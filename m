Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776497795FA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbjHKRRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236767AbjHKRRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:17:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2EA30CB;
        Fri, 11 Aug 2023 10:17:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C76865335;
        Fri, 11 Aug 2023 17:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24CDC433C7;
        Fri, 11 Aug 2023 17:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691774233;
        bh=/X84N0YLDdeGGTp1lt/zOvmBkBfG/I8HFDeJyLNqGvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JMWRgxe3FscJMCJZSLZXARJfuxtf9PgD66G5pnYiOx6DcRFY09X5qBjci6WAdC5ri
         rzG9FJYqPBlq2lRA92DKYbV65P38V3EBf290DUX0WKWm7l0FsmQZjPxJrN0VlvfvoO
         FRmAnTrx1SN+ckodYOANM8x8XqEZVJ5ZKNVVIqv9CuQOEZ1NlTxpaymqlsT26+5wAQ
         6csKDzSJZuRBhHEQfldJjXZRb4A0ZF+EzjWj5eyQI6mwrMO09jvhJSyHp2O0J53gZY
         Z1GTSFBoJ9BKEbhLL0LNyWhdaX8iDuMu4wdzfsf5BCRcGnK49wxKluQxP4BDyB7OJc
         zq87mDXw1rQFw==
Received: (nullmailer pid 3630525 invoked by uid 1000);
        Fri, 11 Aug 2023 17:17:10 -0000
Date:   Fri, 11 Aug 2023 11:17:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        devicetree@vger.kernel.org,
        Vincent Huang <vincent.huang@tw.synaptics.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: input: convert syna,rmi4 to DT schema
Message-ID: <169177423000.3630455.11413514940694318141.robh@kernel.org>
References: <20230728165054.88678-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728165054.88678-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Jul 2023 18:50:54 +0200, Krzysztof Kozlowski wrote:
> Convert the bindings for Synaptics RMI4 bus and devices to DT schema.
> Changes during conversion:
> 1. Add reset-gpios already used in DTS and mentioned by RMI4
>    specification.
> 2. Do not require address/size cells, because without functions
>    (children) they aren't really needed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. Correct [0-9a-z] to [0-9a-f] (Rob).
> 
> Jason, Matthias, Vincent,
> I put your names as maintainers, because moderately recently you were
> changing the driver. Let me know if this is okay or you prefer not to
> maintain the hardware.
> ---
>  .../bindings/input/rmi4/rmi_2d_sensor.txt     |  56 ----
>  .../bindings/input/rmi4/rmi_f01.txt           |  39 ---
>  .../bindings/input/rmi4/rmi_i2c.txt           |  61 ----
>  .../bindings/input/rmi4/rmi_spi.txt           |  56 ----
>  .../devicetree/bindings/input/syna,rmi4.yaml  | 271 ++++++++++++++++++
>  5 files changed, 271 insertions(+), 212 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
>  delete mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
>  delete mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
>  delete mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
>  create mode 100644 Documentation/devicetree/bindings/input/syna,rmi4.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


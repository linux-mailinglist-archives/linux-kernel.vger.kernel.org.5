Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4EB78146C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 22:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380059AbjHRUqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 16:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380045AbjHRUpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 16:45:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A57128;
        Fri, 18 Aug 2023 13:45:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A225961A04;
        Fri, 18 Aug 2023 20:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5316AC433C8;
        Fri, 18 Aug 2023 20:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692391534;
        bh=M6w/nKu6/Yxbouu45YEKnR0/SvvbC0Gr7FbEcvV2fP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u/n39ent+RqY8GQKx0DIxiMH4PF3Y41Y0vLV8piv61s8QG3Cv2b2rJsMajy5ld9WF
         hZT20u7PEGW7+ivTq2xPVH3LWCE0DL74Xb3cZJZWH5+pzky2bryOBESemYUP0Ovl/p
         Chm0VostUmuCnmCOdKVLLtsCV9nAUZsHIxk1e7aUezo3H33uFzZBAJCI9DO+pkJ5L2
         Il8epCKe+AqgbWFZd+S8tr5mdbySrARK5HCxE8iKHSgeow6LIyqaDLMuvGknUw5fOh
         NukADmEbC/y7CCmXoHxwnudbc/a9iEKBXJDV4yCiOR7l2/fmpnoO0HZZ6IX/ceeIp5
         H8YVLEYf5Vjog==
Received: (nullmailer pid 550632 invoked by uid 1000);
        Fri, 18 Aug 2023 20:45:32 -0000
Date:   Fri, 18 Aug 2023 15:45:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     robh+dt@kernel.org, conor+dt@kernel.org,
        Fabio Estevam <festevam@denx.de>,
        krzysztof.kozlowski+dt@linaro.org, giometti@enneenne.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: pps: pps-gpio: Convert to yaml
Message-ID: <169239152974.550532.12741438096585377722.robh@kernel.org>
References: <20230818174159.1680572-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818174159.1680572-1-festevam@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Aug 2023 14:41:59 -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Convert from pps-gpio.txt to pps-gpio.yaml to allow schema validation.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
> ---
> Changes since v1:
> - Pass maxItems to 'gpios' and 'echo-gpios'. (Rob)
> - Pass 'type: boolean' to 'assert-falling-edge'. (Rob)
> - Added Rodolfo's Acked-by tag.
> 
>  .../devicetree/bindings/pps/pps-gpio.txt      | 30 ------------
>  .../devicetree/bindings/pps/pps-gpio.yaml     | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pps/pps-gpio.txt
>  create mode 100644 Documentation/devicetree/bindings/pps/pps-gpio.yaml
> 

Applied, thanks!


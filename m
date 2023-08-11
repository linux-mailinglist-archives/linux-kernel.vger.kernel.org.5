Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD127779651
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236789AbjHKRky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbjHKRkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:40:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA3630CF;
        Fri, 11 Aug 2023 10:40:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8828865056;
        Fri, 11 Aug 2023 17:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEB5C433C8;
        Fri, 11 Aug 2023 17:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691775650;
        bh=/0yQzRJWzPnTkw/Ozyf0///5Fid1qKSWbxjgwcq0t/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W7SM1BS5kp50Q+d5w1JZJ1IvIkpqUwL2wbS6/Mk2scnn5tZsk7/XxHOrGpmyzbdvh
         92LtoNClaVEOyJESmKQOBrBqdO0iftjVZGwv142LU/gwo7BiU8wwDqbnmyPvY58IGf
         arlWGOiT3xXg0H7h3u50Gz1XQxpwP+HK3YL4kolslxjodzdG4JtNW5ENllk3Vhsb/J
         IR9p1FGgqBDO+t2aMk18XosqT8wqnDew7TszKD9LnqmUjdKVTFrMIRDAx3hJwhgFgm
         FQskdExDWN+p4Q2hliNeKdmMns6/VjYGwOn4hUrVTLd6xpgabiw81nLrVZFTXEc/Dy
         L9rBLbv6oI9Ug==
Received: (nullmailer pid 3656168 invoked by uid 1000);
        Fri, 11 Aug 2023 17:40:47 -0000
Date:   Fri, 11 Aug 2023 11:40:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: brcm,bcm11351-pinctrl: Convert to
 YAML
Message-ID: <169177564713.3656110.3836867056727165782.robh@kernel.org>
References: <ZMZ3aEnrrZRDNdO+@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMZ3aEnrrZRDNdO+@standask-GA-A55M-S2HP>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 30 Jul 2023 16:44:56 +0200, Stanislav Jakubek wrote:
> Convert Broadcom BCM281xx pin controller bindings to DT schema.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
>  .../pinctrl/brcm,bcm11351-pinctrl.txt         | 461 ------------------
>  .../pinctrl/brcm,bcm11351-pinctrl.yaml        | 259 ++++++++++
>  2 files changed, 259 insertions(+), 461 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


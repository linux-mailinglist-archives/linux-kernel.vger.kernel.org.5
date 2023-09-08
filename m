Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458A079914E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245371AbjIHUwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240081AbjIHUwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:52:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E595C1FFD;
        Fri,  8 Sep 2023 13:52:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A55C43215;
        Fri,  8 Sep 2023 20:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694206344;
        bh=TcTQRLCCJ2nI5kBt3Ur/VJ/CjA9qDNAGUbTVoXZ0FFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KKMs3kuE0jyLhFFImDSGLnNruBWTdUeyW76xuzGn69ruwfKYI6GKbJOaYXOQYZxy0
         GBLo8zoKCuyc9etWI7P2hqXaoHe1OoTEI/nEhhLmdDq+x7kevRAmSflKjzGx6wKXVK
         1vmR4jvvx8ZXhKhG4REISHbNAa47cFya9GHyN5fIQRoUJUcmU+7Jmzbx4jzEQhETje
         tQStBQmAneqHovqRdKrc1FydK3HWBE2FJOZ4bLkJMBCt7W+ZWKEIOBuuAmrCH/FPYb
         VtvltK95RppdKCbSzGcb7/WprEJRCyAptgDoUFBra9H9TTDJQuiRcYKZ9nAe2QY9Td
         DUc2Fb76bENog==
Received: (nullmailer pid 336501 invoked by uid 1000);
        Fri, 08 Sep 2023 20:52:22 -0000
Date:   Fri, 8 Sep 2023 15:52:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 3/3] arm64: dts: mediatek: mt8365-pumpkin: Add overlays
 for thp7312 cameras
Message-ID: <20230908205222.GA320762-robh@kernel.org>
References: <20230905233118.183140-1-paul.elder@ideasonboard.com>
 <20230905233118.183140-4-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905233118.183140-4-paul.elder@ideasonboard.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 08:31:18AM +0900, Paul Elder wrote:
> Add overlays for the Pumpkin i350 to support THP7312 cameras.
> 
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile         |  4 +
>  .../mt8365-pumpkin-common-thp7312.dtsi        | 23 ++++++
>  .../mt8365-pumpkin-csi0-thp7312-imx258.dtso   | 73 +++++++++++++++++++
>  .../mt8365-pumpkin-csi1-thp7312-imx258.dtso   | 73 +++++++++++++++++++
>  4 files changed, 173 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-pumpkin-common-thp7312.dtsi
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi0-thp7312-imx258.dtso
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi1-thp7312-imx258.dtso
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 20570bc40de8..ceaf24105001 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -56,4 +56,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-pumpkin.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
>  
> +mtk-mt8365-pumpkin-dtbs := mt8365-pumpkin.dtb mt8365-pumpkin-csi0-thp7312-imx258.dtbo
> +mtk-mt8365-pumpkin-dtbs := mt8365-pumpkin.dtb mt8365-pumpkin-csi1-thp7312-imx258.dtbo
>  mtk-mt8365-pumpkin-dtbs := mt8365-pumpkin.dtb mt8365-pumpkin-ethernet-usb.dtbo

This has no effect. You are assigning the same variable 3 times. It 
needs to be every overlay applied to its base is a *-dtbs variable and 
then those are all added to 'dtb-y'. IOW, we don't allow overlays which 
can't be applied at build time.

Assuming the overlays aren't mutually exclusive, you could do:

mtk-mt8365-pumpkin-dtbs := mt8365-pumpkin.dtb mt8365-pumpkin-ethernet-usb.dtbo
mtk-mt8365-pumpkin-dtbs += mt8365-pumpkin-csi0-thp7312-imx258.dtbo
mtk-mt8365-pumpkin-dtbs += mt8365-pumpkin-csi1-thp7312-imx258.dtbo

This works the same way as '-objs' variables to group .o files into a 
module.

> +
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mtk-mt8365-pumpkin.dtb

Looks like mtk-mt8365-pumpkin.dtb failed to get built before. In any 
case, that's a terrible name. What's the difference between 
mt8365-pumpkin.dtb and mtk-mt8365-pumpkin.dtb? There's no clue.

Rob

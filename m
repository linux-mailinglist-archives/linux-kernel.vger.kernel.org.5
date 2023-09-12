Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA7F79C762
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjILHAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjILG7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:59:54 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBAEA10C8;
        Mon, 11 Sep 2023 23:59:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CD86980FC;
        Tue, 12 Sep 2023 06:59:47 +0000 (UTC)
Date:   Tue, 12 Sep 2023 09:59:46 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Rob Herring <robh@kernel.org>, Andrew Davis <afd@ti.com>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: dts: omap: Apply am57xx-idk overlays to base dtbs
Message-ID: <20230912065946.GC5285@atomide.com>
References: <20230911214609.2201040-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911214609.2201040-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rob Herring <robh@kernel.org> [230911 21:46]:
> DT overlays in tree need to be applied to a base DTB to validate they
> apply, to run schema checks on them, and to catch any errors at compile
> time.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Note that I have no idea if this combination of overlays makes sense.

Adding Andrew to review this.

Regards,

Tony

---
>  arch/arm/boot/dts/ti/omap/Makefile | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/ti/omap/Makefile b/arch/arm/boot/dts/ti/omap/Makefile
> index d2b590004fed..d0c76d09fe70 100644
> --- a/arch/arm/boot/dts/ti/omap/Makefile
> +++ b/arch/arm/boot/dts/ti/omap/Makefile
> @@ -129,6 +129,11 @@ dtb-$(CONFIG_SOC_AM43XX) += \
>  am57xx-evm-dtbs := am57xx-beagle-x15.dtb am57xx-evm.dtbo
>  am57xx-evm-reva3-dtbs := am57xx-beagle-x15-revc.dtb am57xx-evm.dtbo
>  
> +am571x-idk-overlays-dtbs := am571x-idk.dtb \
> +	am571x-idk-touchscreen.dtbo am57xx-idk-lcd-osd101t2587.dtbo
> +am572x-idk-overlays-dtbs := am572x-idk.dtb \
> +	am572x-idk-touchscreen.dtbo am57xx-idk-lcd-osd101t2045.dtbo
> +
>  dtb-$(CONFIG_SOC_DRA7XX) += \
>  	am57xx-beagle-x15.dtb \
>  	am57xx-beagle-x15-revb1.dtb \
> @@ -145,6 +150,8 @@ dtb-$(CONFIG_SOC_DRA7XX) += \
>  	am574x-idk.dtb \
>  	am57xx-idk-lcd-osd101t2045.dtbo \
>  	am57xx-idk-lcd-osd101t2587.dtbo \
> +	am571x-idk-overlays.dtb \
> +	am572x-idk-overlays.dtb \
>  	dra7-evm.dtb \
>  	dra72-evm.dtb \
>  	dra72-evm-revc.dtb \
> -- 
> 2.40.1
> 

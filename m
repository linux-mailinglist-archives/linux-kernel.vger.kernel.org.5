Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3217A5D74
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjISJKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjISJKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:10:20 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89465BA;
        Tue, 19 Sep 2023 02:10:13 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38J99vl2085147;
        Tue, 19 Sep 2023 04:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695114598;
        bh=WfMtPVs1WjAmTu1h1StzNblcDZB2CRhuJbtwH+WeC4s=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=GLWOCA/6PKSr1AfbMzwGx84FiFzmEClpeLm5GtxWQHrEVmsdr6lUj2fLwGuYuWai+
         ZihzWfVRcgCdaYl2vcr9qytRUL+ReHm2LL/PcsI0A6BjFCCvSyV39RmkUag8m85sVI
         GLzHBrOqT9ejayxI7Esk37xeBHOSD3Rtc4szbeEM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38J99vv5005334
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Sep 2023 04:09:57 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 04:09:56 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 04:09:56 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38J99tq3025271;
        Tue, 19 Sep 2023 04:09:56 -0500
Date:   Tue, 19 Sep 2023 14:39:55 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 16/17] pmdomain: ti: Move and add Kconfig options to
 the pmdomain subsystem
Message-ID: <20230919090955.hu5mrzq2br4o7zd5@dhruva>
References: <20230915092003.658361-1-ulf.hansson@linaro.org>
 <20230915092003.658361-17-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230915092003.658361-17-ulf.hansson@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 15, 2023 at 11:20:02 +0200, Ulf Hansson wrote:
> The TI_SCI_PM_DOMAINS Kconfig option belongs closer to its corresponding
> implementation, hence let's move it from the soc subsystem to the pmdomain
> subsystem.
> 
> While at it, let's also add a Kconfig option the omap_prm driver, rather
> than using ARCH_OMAP2PLUS directly.

OK

> 
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: Tero Kristo <kristo@kernel.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/pmdomain/Kconfig     |  1 +
>  drivers/pmdomain/ti/Kconfig  | 22 ++++++++++++++++++++++
>  drivers/pmdomain/ti/Makefile |  2 +-
>  drivers/soc/ti/Kconfig       | 12 ------------
>  4 files changed, 24 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/pmdomain/ti/Kconfig
> 
> diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
> index 98e04589bef4..33bfec9c4f7a 100644
> --- a/drivers/pmdomain/Kconfig
> +++ b/drivers/pmdomain/Kconfig
> @@ -15,5 +15,6 @@ source "drivers/pmdomain/st/Kconfig"
>  source "drivers/pmdomain/starfive/Kconfig"
>  source "drivers/pmdomain/sunxi/Kconfig"
>  source "drivers/pmdomain/tegra/Kconfig"
> +source "drivers/pmdomain/ti/Kconfig"
>  
>  endmenu
> diff --git a/drivers/pmdomain/ti/Kconfig b/drivers/pmdomain/ti/Kconfig
> new file mode 100644
> index 000000000000..67c608bf7ed0
> --- /dev/null
> +++ b/drivers/pmdomain/ti/Kconfig
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config OMAP2PLUS_PRM
> +	bool
> +	depends on ARCH_OMAP2PLUS
> +	default ARCH_OMAP2PLUS
> +
> +if SOC_TI
> +
> +config TI_SCI_PM_DOMAINS
> +	tristate "TI SCI PM Domains Driver"
> +	depends on TI_SCI_PROTOCOL
> +	depends on PM_GENERIC_DOMAINS
> +	help
> +	  Generic power domain implementation for TI device implementing
> +	  the TI SCI protocol.
> +
> +	  To compile this as a module, choose M here. The module will be
> +	  called ti_sci_pm_domains. Note this is needed early in boot before
> +	  rootfs may be available.
> +
> +endif
> diff --git a/drivers/pmdomain/ti/Makefile b/drivers/pmdomain/ti/Makefile
> index 69580afbb436..af6cd056c158 100644
> --- a/drivers/pmdomain/ti/Makefile
> +++ b/drivers/pmdomain/ti/Makefile
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_ARCH_OMAP2PLUS)		+= omap_prm.o
> +obj-$(CONFIG_OMAP2PLUS_PRM)		+= omap_prm.o
>  obj-$(CONFIG_TI_SCI_PM_DOMAINS)		+= ti_sci_pm_domains.o
> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
> index 2cae17b65fd9..1a93001c9e36 100644
> --- a/drivers/soc/ti/Kconfig
> +++ b/drivers/soc/ti/Kconfig
> @@ -50,18 +50,6 @@ config WKUP_M3_IPC
>  	  to communicate and use the Wakeup M3 for PM features like suspend
>  	  resume and boots it using wkup_m3_rproc driver.
>  
> -config TI_SCI_PM_DOMAINS
> -	tristate "TI SCI PM Domains Driver"
> -	depends on TI_SCI_PROTOCOL
> -	depends on PM_GENERIC_DOMAINS
> -	help
> -	  Generic power domain implementation for TI device implementing
> -	  the TI SCI protocol.
> -
> -	  To compile this as a module, choose M here. The module will be
> -	  called ti_sci_pm_domains. Note this is needed early in boot before
> -	  rootfs may be available.
> -
>  config TI_K3_RINGACC
>  	tristate "K3 Ring accelerator Sub System"
>  	depends on ARCH_K3 || COMPILE_TEST
> -- 
> 2.34.1
> 

The changes are fine by me,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

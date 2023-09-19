Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746CB7A5C94
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjISIct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjISIcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:32:46 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF3DE6;
        Tue, 19 Sep 2023 01:32:40 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38J8WOIm076785;
        Tue, 19 Sep 2023 03:32:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695112344;
        bh=ko+0biv7p0QE3bbjv/9cyrzE4CVR5cv9T1cCR7xKuE4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=JyayjV+DLoexFsoHU85qsRYEkaDrbcHEul9GPdz75+v4VVJWUYR+iLYKfVcbHa3Y4
         Ie4/YjnypT08Snog6TBhmXNlzIerWOy2kY9myas1V8N2F1t39PG0TQngZgwkuV/YDH
         CheQoMbct5wBvDjtXT9/aG7MubEJa9fIyls2CG7c=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38J8WOoa112617
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Sep 2023 03:32:24 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 03:32:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 03:32:23 -0500
Received: from [10.24.69.199] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38J8WK0Q123113;
        Tue, 19 Sep 2023 03:32:20 -0500
Message-ID: <8ba840a5-baec-733a-f538-a196f5421190@ti.com>
Date:   Tue, 19 Sep 2023 14:02:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: [PATCH] net: ti: icss-iep: add dependency for PTP
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     kernel test robot <lkp@intel.com>, Roger Quadros <rogerq@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20230916050701.15480-1-rdunlap@infradead.org>
From:   MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20230916050701.15480-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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

On 16/09/23 10:37, Randy Dunlap wrote:
> When CONFIG_PTP_1588_CLOCK=m and CONFIG_TI_ICSS_IEP=y,
> there are build errors when referencing PTP functions.
> Fix this by making TI_ICSS_IEP depend on PTP_1588_CLOCK_OPTIONAL.
> Also, since TI_ICSSG_PRUETH selects TI_ICSS_IEP and selects don't
> follow dependencies, make the former also depend on
> PTP_1588_CLOCK_OPTIONAL.
> 
> Fixes these build errors:
> 
> aarch64-linux-ld: drivers/net/ethernet/ti/icssg/icss_iep.o: in function `icss_iep_get_ptp_clock_idx':
> icss_iep.c:(.text+0x234): undefined reference to `ptp_clock_index'
> aarch64-linux-ld: drivers/net/ethernet/ti/icssg/icss_iep.o: in function `icss_iep_exit':
> icss_iep.c:(.text+0x634): undefined reference to `ptp_clock_unregister'
> aarch64-linux-ld: drivers/net/ethernet/ti/icssg/icss_iep.o: in function `icss_iep_init':
> icss_iep.c:(.text+0x1848): undefined reference to `ptp_clock_register'
> 
> Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: lore.kernel.org/r/202309151207.NPDMiINe-lkp@intel.com
> Cc: Roger Quadros <rogerq@ti.com>
> Cc: Md Danish Anwar <danishanwar@ti.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> ---
>  drivers/net/ethernet/ti/Kconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff -- a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
> --- a/drivers/net/ethernet/ti/Kconfig
> +++ b/drivers/net/ethernet/ti/Kconfig
> @@ -189,6 +189,7 @@ config TI_ICSSG_PRUETH
>  	select TI_ICSS_IEP
>  	depends on PRU_REMOTEPROC
>  	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
> +	depends on PTP_1588_CLOCK_OPTIONAL
>  	help
>  	  Support dual Gigabit Ethernet ports over the ICSSG PRU Subsystem.
>  	  This subsystem is available starting with the AM65 platform.
> @@ -200,6 +201,7 @@ config TI_ICSSG_PRUETH
>  config TI_ICSS_IEP
>  	tristate "TI PRU ICSS IEP driver"
>  	depends on TI_PRUSS
> +	depends on PTP_1588_CLOCK_OPTIONAL
>  	default TI_PRUSS
>  	help
>  	  This driver enables support for the PRU-ICSS Industrial Ethernet

This doesn't apply cleanly on netdev/net (using git am) as the
dependency on PTP_1588_CLOCK_OPTIONAL in TI_ICSS_IEP is already added by
[1]. However the dependency on PTP_1588_CLOCK_OPTIONAL in
TI_ICSSG_PRUETH is not added yet and can be added by this patch.

With this,
Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=a8f367f7e131

-- 
Thanks and Regards,
Danish

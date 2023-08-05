Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A811B770DE8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 07:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjHEFVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 01:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHEFVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 01:21:02 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC7D46B3;
        Fri,  4 Aug 2023 22:21:01 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3755Kteg098461;
        Sat, 5 Aug 2023 00:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691212855;
        bh=6FY5LKGtFjZq67qXqi2DuCp712hiFdOjQzt7WA0T+eg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=oHFhvgaK3BYyjcOL7PvqcPBF8GubzoURAACSFpyr2mCVYl8n2JWd5RpobCSQOtkNS
         JGjFw2GSdzui4Frtn11vlxn4D5NYSzO43NYG3+Fq0MpIp3ZsWedCWMnb2qyiTu1PHi
         BBNtczzatt1BfgbmIhBygcbw+FUUmdG0YJy0FPTI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3755Ktxv099804
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 5 Aug 2023 00:20:55 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 5
 Aug 2023 00:20:54 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 5 Aug 2023 00:20:54 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3755KrhC092943;
        Sat, 5 Aug 2023 00:20:54 -0500
Date:   Sat, 5 Aug 2023 10:50:52 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     <linux-omap@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/3] bus: ti-sysc: Build driver for TI K3 SoCs
Message-ID: <20230805052052.zjamrxarn6uc4i5l@dhruva>
References: <20230804103859.57458-1-tony@atomide.com>
 <20230804103859.57458-2-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230804103859.57458-2-tony@atomide.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 04, 2023 at 13:38:58 +0300, Tony Lindgren wrote:
> Allow building ti-sysc also for K3 SoCs. This allows configuring the wkup
> domain devices for SYSCONFIG register wake-up events in a generic way.

If possible, can we add explanation also on why it now needs to be default y
in the Kconfig?

> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/bus/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -210,7 +210,8 @@ config  TI_PWMSS
>  
>  config TI_SYSC
>  	bool "TI sysc interconnect target module driver"
> -	depends on ARCH_OMAP2PLUS
> +	depends on ARCH_OMAP2PLUS || ARCH_K3
> +	default y

Reviewed-by: Dhruva Gole <d-gole@ti.com>

>  	help
>  	  Generic driver for Texas Instruments interconnect target module
>  	  found on many TI SoCs.
> -- 
> 2.41.0

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

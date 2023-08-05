Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E61770DE6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 07:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjHEFSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 01:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHEFSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 01:18:03 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF59C46B3;
        Fri,  4 Aug 2023 22:18:02 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3755Ht3L027356;
        Sat, 5 Aug 2023 00:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691212675;
        bh=nmjhEHZep/oXmNkPQODNKXEeYfXpxRtVizDyTuE0WZc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=LG1JROapnAYkGF1LJc3SEH/Qq1NoxpL7n0KH1+fMU+3mdNffZ6K2lYv1exYz9GX5B
         +urC5opnaMrVWk97z6nmuM9PQNt4b7uIj9M8i7+gqo6vGBUgF8GFreT9dyJCS36RcK
         /TuV85xTBC6bdN+HmvF96v/m6VbE6uABqlgER6hY=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3755Htc9098555
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 5 Aug 2023 00:17:55 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 5
 Aug 2023 00:17:54 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 5 Aug 2023 00:17:54 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3755HrAx022718;
        Sat, 5 Aug 2023 00:17:54 -0500
Date:   Sat, 5 Aug 2023 10:47:53 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     <linux-omap@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] bus: ti-sysc: Fix build warning for 64-bit build
Message-ID: <20230805051753.vpwhg52zttpbbntx@dhruva>
References: <20230804103859.57458-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230804103859.57458-1-tony@atomide.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Aug 04, 2023 at 13:38:57 +0300, Tony Lindgren wrote:
> Fix "warning: cast from pointer to integer of different size" on 64-bit
> builds.

Thanks for enabling this on 64 bit, will help us in K3 SOCs.

> 
> Note that this is a cosmetic fix at this point as the driver is not yet
> used for 64-bit systems.
> 
> Fixes: feaa8baee82a ("bus: ti-sysc: Implement SoC revision handling")
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/bus/ti-sysc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
> @@ -3104,7 +3104,7 @@ static int sysc_init_static_data(struct sysc *ddata)
>  
>  	match = soc_device_match(sysc_soc_match);
>  	if (match && match->data)
> -		sysc_soc->soc = (int)match->data;
> +		sysc_soc->soc = (unsigned long)match->data;

Reviewed-by: Dhruva Gole <d-gole@ti.com>

>  
>  	/*
>  	 * Check and warn about possible old incomplete dtb. We now want to see
> -- 
> 2.41.0

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

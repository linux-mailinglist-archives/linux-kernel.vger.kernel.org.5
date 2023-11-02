Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139497DEE94
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345340AbjKBJDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbjKBJDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:03:45 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442FCFB;
        Thu,  2 Nov 2023 02:03:40 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A293WMA108596;
        Thu, 2 Nov 2023 04:03:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698915812;
        bh=A8uXXyXiHijLvyI333aJJzFE2SeMWl/aav8F2VB+hyg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=J6u/PdH7g9p1SCCcjTPPvvWKmu72bf4B1zm+UJGv4rRzijU4M8Yg9OP3qVlZKlvwf
         acYGpTOCZ/ExBWizW4KjuXxhwZdsFmQ7QQNLSgwSgpVxuS9rVLPW+Z0WgO2QMXkl6B
         PznHPvH9CIYD/6VvMOqxNM5W7mFg4+h6ddLQrYuA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A293Wxu122922
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Nov 2023 04:03:32 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 Nov 2023 04:03:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 Nov 2023 04:03:32 -0500
Received: from [172.24.227.94] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A293TYi093647;
        Thu, 2 Nov 2023 04:03:29 -0500
Message-ID: <91bc69e6-8c6a-4e36-9b09-b000444f6465@ti.com>
Date:   Thu, 2 Nov 2023 14:33:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_omap: Add earlycon support for the AM654
 UART controller
Content-Language: en-US
To:     Ronald Wahl <rwahl@gmx.de>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Nishanth Menon <nm@ti.com>,
        Ronald Wahl <ronald.wahl@raritan.com>
References: <20231031131242.15516-1-rwahl@gmx.de>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20231031131242.15516-1-rwahl@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/10/23 18:42, Ronald Wahl wrote:
> From: Ronald Wahl <ronald.wahl@raritan.com>
> 
> Currently there is no support for earlycon on the AM654 UART
> controller. This commit adds it.

Something like below should also work for just an early console
functionality

earlycon=ns16550a,mmio32,0x02800000

But, I think its better to have setup mapped directly to compatible. so

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>


> 
> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
> ---
>  drivers/tty/serial/8250/8250_early.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
> index 9837a27739fd..e3f482fd3de4 100644
> --- a/drivers/tty/serial/8250/8250_early.c
> +++ b/drivers/tty/serial/8250/8250_early.c
> @@ -189,5 +189,6 @@ static int __init early_omap8250_setup(struct earlycon_device *device,
>  OF_EARLYCON_DECLARE(omap8250, "ti,omap2-uart", early_omap8250_setup);
>  OF_EARLYCON_DECLARE(omap8250, "ti,omap3-uart", early_omap8250_setup);
>  OF_EARLYCON_DECLARE(omap8250, "ti,omap4-uart", early_omap8250_setup);
> +OF_EARLYCON_DECLARE(omap8250, "ti,am654-uart", early_omap8250_setup);
> 
>  #endif
> --
> 2.41.0
> 

-- 
Regards
Vignesh

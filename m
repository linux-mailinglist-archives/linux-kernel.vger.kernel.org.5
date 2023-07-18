Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C92C757F4E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjGROUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjGROUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:20:37 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095B6E7E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:20:34 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36IEJWKc038776;
        Tue, 18 Jul 2023 09:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689689972;
        bh=kMkw8ueDniDP2BCSXZP+ZzUwFI288y3WMcdTOTI0lo0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=FCJAWcxs3guKnhVzwdvQHIg9on2v7DsVczvYepp61ZF1LVNPUijPyCXqMqy9kED1j
         oAgqBxapU9WGcncAbkuQiuailyzsHPyLV74n8MeG4O9U4tDYk1dxNjL4oO3JKrH24m
         G7ja2L85R/s7YIuob3IT/1UwDfWHYBqGsiJWurKA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36IEJWcA026185
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Jul 2023 09:19:32 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Jul 2023 09:19:32 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Jul 2023 09:19:32 -0500
Received: from [10.250.32.198] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36IEJVRK028854;
        Tue, 18 Jul 2023 09:19:32 -0500
Message-ID: <d56cab4a-ad05-4298-42a8-55d285a5ada3@ti.com>
Date:   Tue, 18 Jul 2023 09:19:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ARM: multi_v7_defconfig: Enable OMAP watchdog support
Content-Language: en-US
To:     Julien Panis <jpanis@baylibre.com>,
        Russell King <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <vigneshr@ti.com>
References: <20230718-enable-omap-wd-v1-1-34396f2c76aa@baylibre.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230718-enable-omap-wd-v1-1-34396f2c76aa@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/23 7:51 AM, Julien Panis wrote:
> Add OMAP watchdog support by enabling
> CONFIG_OMAP_WATCHDOG as module.
> 

Commit messages should describe "why", we can figure out the above
from just looking at the patch.

What boards use this? What does this change on those boards?

Wrap lines at 80-100 chars, not 40..

Andrew

> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---
> Enable OMAP watchdog support in multi_v7_defconfig.
> ---
>   arch/arm/configs/multi_v7_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index f0800f806b5f..7d93e21e0cb9 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -554,6 +554,7 @@ CONFIG_SAMA5D4_WATCHDOG=y
>   CONFIG_S3C2410_WATCHDOG=m
>   CONFIG_DW_WATCHDOG=y
>   CONFIG_DAVINCI_WATCHDOG=m
> +CONFIG_OMAP_WATCHDOG=m
>   CONFIG_ORION_WATCHDOG=y
>   CONFIG_RN5T618_WATCHDOG=y
>   CONFIG_SUNXI_WATCHDOG=y
> 
> ---
> base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
> change-id: 20230718-enable-omap-wd-6a563c280752
> 
> Best regards,

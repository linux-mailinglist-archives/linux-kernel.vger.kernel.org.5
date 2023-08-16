Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DF077DC58
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242672AbjHPIeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243028AbjHPId3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:33:29 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84E53AAD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:32:43 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37G7vGTR018819;
        Wed, 16 Aug 2023 10:32:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=f25i3a5F9yJG4clbZN6JrZXcLycbKCHfz4lAHrfRjUY=; b=iB
        8Tm2kUo6Tu0BpWpMTn4NEgG7AgT88zLhMZgFc9BiVUvakiRikfEpYcpyOK8wsdkY
        FS9zyeAFz/WKCJeW+L4akgHzcFyr7vTbmRhP9XDdA7W5UItjPor4eh4CbUpRH1d2
        CHL0r0GkPKbHM0gVezIb3RDNgY5rdk2gZ4UP+cKgnCAUbFMyKH5ZjN9nTIhEULVC
        fw+f07Yw27PNo2RIJVGMRMoEEgf2JHfbOumRsxu1YYnOdWL5uOUYeY4Y2AMb9PQo
        nOjXMAN7fxYL8WEZoGRexSHxVvrnnH1uVDoFVnhz1+81WxYALMWSvxuCdv7ysjw2
        bM7Xha2c1El5q5Ff0+hQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sgth608d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 10:32:27 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5142D10005D;
        Wed, 16 Aug 2023 10:32:26 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ACD7E21B528;
        Wed, 16 Aug 2023 10:32:25 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 16 Aug
 2023 10:32:25 +0200
Message-ID: <fd919d96-7533-4c9b-f883-c697f3b6c76d@foss.st.com>
Date:   Wed, 16 Aug 2023 10:32:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ARM: sti: removal of stih415/stih416 related entries
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, Russell King <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230416185939.18497-1-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230416185939.18497-1-avolmat@me.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_06,2023-08-15_02,2023-05-22_02
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/23 20:59, Alain Volmat wrote:
> ST's STiH415 and STiH416 platforms have already been removed since
> a while.  Remove some remaining bits within the mach-sti.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> Patch sent previously as part of serie: https://lore.kernel.org/all/20230209091659.1409-3-avolmat@me.com/
> 
>  arch/arm/mach-sti/Kconfig    | 20 +-------------------
>  arch/arm/mach-sti/board-dt.c |  2 --
>  2 files changed, 1 insertion(+), 21 deletions(-)
> 
> diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
> index b2d45cf10a3c..609957dead98 100644
> --- a/arch/arm/mach-sti/Kconfig
> +++ b/arch/arm/mach-sti/Kconfig
> @@ -19,31 +19,13 @@ menuconfig ARCH_STI
>  	select PL310_ERRATA_769419 if CACHE_L2X0
>  	select RESET_CONTROLLER
>  	help
> -	  Include support for STMicroelectronics' STiH415/416, STiH407/10 and
> +	  Include support for STMicroelectronics' STiH407/10 and
>  	  STiH418 family SoCs using the Device Tree for discovery.  More
>  	  information can be found in Documentation/arm/sti/ and
>  	  Documentation/devicetree.
>  
>  if ARCH_STI
>  
> -config SOC_STIH415
> -	bool "STiH415 STMicroelectronics Consumer Electronics family"
> -	default y
> -	help
> -	  This enables support for STMicroelectronics Digital Consumer
> -	  Electronics family StiH415 parts, primarily targeted at set-top-box
> -	  and other digital audio/video applications using Flattned Device
> -	  Trees.
> -
> -config SOC_STIH416
> -	bool "STiH416 STMicroelectronics Consumer Electronics family"
> -	default y
> -	help
> -	  This enables support for STMicroelectronics Digital Consumer
> -	  Electronics family StiH416 parts, primarily targeted at set-top-box
> -	  and other digital audio/video applications using Flattened Device
> -	  Trees.
> -
>  config SOC_STIH407
>  	bool "STiH407 STMicroelectronics Consumer Electronics family"
>  	default y
> diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
> index ffecbf29646f..8c313f07bd02 100644
> --- a/arch/arm/mach-sti/board-dt.c
> +++ b/arch/arm/mach-sti/board-dt.c
> @@ -12,8 +12,6 @@
>  #include "smp.h"
>  
>  static const char *const stih41x_dt_match[] __initconst = {
> -	"st,stih415",
> -	"st,stih416",
>  	"st,stih407",
>  	"st,stih410",
>  	"st,stih418",


Hi Russell

This patch is laying on the mailing list since a while, do you intend to take it 
on your side ?

Thanks
Patrice


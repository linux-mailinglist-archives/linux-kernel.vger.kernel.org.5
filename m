Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8664D77DAEC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242218AbjHPHIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242176AbjHPHIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:08:16 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B842D1FD0;
        Wed, 16 Aug 2023 00:08:14 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37G3mbh2002858;
        Wed, 16 Aug 2023 09:07:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=IajmAUfmfJqcrVW+6hYiUuXofmuO8/v3/CzwoHA+gec=; b=Kh
        ICiij5dC4ZeXjqxLEbqvJGb3YzRR+9HRpvYtixgeFtbM2nDG8AaSIek5E0izp7Vp
        HzR09PlmysP99DXWqIEaZbPRTzfgfxiU23DotJknZkqjgXGAAZIjiPHmW1JpFK3K
        VlqUhDp9+tfXXG4Ul0ob5S41eC8HlHZTIOF5tSO23BCD0x82RlezEKzR6uNGsDc4
        9FJiUgAZFIV4JXvLxLFOzXvjyluZ8sa2I/lin/HOFri1D3+o5mN/4/EUAOHHUiES
        jcLLCkJU+xyCEy7kiH9X4M7h+VhYnk+GqRWMtpFKmHD4XqLuBmhscYFuf9uKAMaP
        TvyLKXXizhGi/M5bDnng==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sgpvgru2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 09:07:51 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8AD3510005D;
        Wed, 16 Aug 2023 09:07:49 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8026C2171E2;
        Wed, 16 Aug 2023 09:07:49 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 16 Aug
 2023 09:07:48 +0200
Message-ID: <fa4ea3da-ab10-4d27-7f6c-a13be4b6c84c@foss.st.com>
Date:   Wed, 16 Aug 2023 09:07:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] ARM: dts: st: correct serial alias in
 stih418-b2264.dts
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230702161936.134429-1-avolmat@me.com>
 <20230702161936.134429-2-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230702161936.134429-2-avolmat@me.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_05,2023-08-15_02,2023-05-22_02
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/2/23 18:19, Alain Volmat wrote:
> Aliases should only contain lowercase, digits or - hence
> correct the alias for the serial from ttyAS0 into serial0
> as already done for the other boards.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  arch/arm/boot/dts/st/stih418-b2264.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/st/stih418-b2264.dts b/arch/arm/boot/dts/st/stih418-b2264.dts
> index fc32a03073b6..f496ca28850d 100644
> --- a/arch/arm/boot/dts/st/stih418-b2264.dts
> +++ b/arch/arm/boot/dts/st/stih418-b2264.dts
> @@ -69,7 +69,7 @@ opp04 {
>  	};
>  
>  	aliases {
> -		ttyAS0 = &sbc_serial0;
> +		serial0 = &sbc_serial0;
>  		ethernet0 = &ethernet0;
>  	};
>  

Acked-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

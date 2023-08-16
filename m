Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACC277DB04
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242348AbjHPHQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbjHPHQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:16:35 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3268F2110;
        Wed, 16 Aug 2023 00:16:34 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37G3mjde002884;
        Wed, 16 Aug 2023 09:16:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=7Z8IGGg1Owr0z8L43DjWLQDjlrF6ryvSK3PDWD2om/A=; b=zz
        bS1pqKVrA0o+S+iQWR22r6/hcJ80j6mPFTH0+/cLO2f9mWmSCTcaE4/jWROExaAb
        va3wydtN3laUjo5gRM596I+vEN6eKeHwnYs4fgRFNzHlC9GVEju/OQrlt+lc9fC2
        I/legXDZIRu/6GPdehd1zfTTr3saJ8LemZyVKlY7werqz2zs8SmnGA9kw0q5SkY6
        YO3eOKjX5KECxq7zI2gAp6jSApBAlpOfA+qSVqegCvJKOf8tD6fkqwmlOeoZpX2/
        raeEKXh1iQqwUBrO0TlppaPxon6fWLbER755VC35itLzSUwJZyMgTxZroKOPkxsR
        /y0a3mwoA1f17tQFEIyA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sgpvgrvpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 09:16:21 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E269A10005D;
        Wed, 16 Aug 2023 09:16:20 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D5E74217B6A;
        Wed, 16 Aug 2023 09:16:20 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 16 Aug
 2023 09:16:20 +0200
Message-ID: <e6b6e87f-2464-bf42-a2cc-63743dc75a3b@foss.st.com>
Date:   Wed, 16 Aug 2023 09:16:19 +0200
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


Applied on sti-next

Thanks
Patrice

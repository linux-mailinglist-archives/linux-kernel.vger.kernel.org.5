Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F2F777DE3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbjHJQOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236728AbjHJQOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:14:02 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887172715;
        Thu, 10 Aug 2023 09:13:55 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AClMTo009211;
        Thu, 10 Aug 2023 18:13:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=KNBtwi1v4OaPod4KakQmw1my4EvxABvcUnsIPOqNk9E=; b=us
        Y+WqL1pCuZYZTVMnHjTBI+6DPOYGfD4ml0e0jaPoIbOqU8cPmHVMkKS6tQDD2fyn
        +wJVilc97AugbGB1Jtnyl34iSvDXPb60VYE68fv/3geJ3jTRXQGk6Dk9BDkKvs9b
        Yb1KQqKt1apEHFxf3ezdWBexJKZ1x3snJV9wEsF3uABlC7GJU4vxDqt+XuCaEJHz
        2oek7+5TuKx3imtEKiDhbp11D6Mp8kvhkJPdOdku4SDOd8eGa92NGFSLMdvhq9Qe
        +kT+q5XAcMXkSAzjRNX+3TaaQhaBedl/U1u/L529xPgIi3SQ9gSprIALITLXWSCJ
        hxJh2Xut9Vlhs6KCf5EA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sd07312eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 18:13:29 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A55E0100053;
        Thu, 10 Aug 2023 18:13:27 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 90CF62291A5;
        Thu, 10 Aug 2023 18:13:27 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 10 Aug
 2023 18:13:26 +0200
Message-ID: <e2beee47-3b81-3f59-e746-78c487aad598@foss.st.com>
Date:   Thu, 10 Aug 2023 18:13:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/4] ARM: multi_v7_defconfig: Add SCMI regulator support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <p.paillet@foss.st.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Etienne Carriere <etienne.carriere@foss.st.com>
References: <20230712142432.1885162-1-p.paillet@foss.st.com>
 <20230712142432.1885162-5-p.paillet@foss.st.com>
 <aa05bcd6-140d-d951-2c7f-c09abf7f49f7@linaro.org>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <aa05bcd6-140d-d951-2c7f-c09abf7f49f7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_14,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

On 7/12/23 21:25, Krzysztof Kozlowski wrote:
> On 12/07/2023 16:24, p.paillet@foss.st.com wrote:
>> From: Pascal Paillet <p.paillet@foss.st.com>
>>
>> Enable ARM SCMI regulator support.
>>
> 
> This we see from the diff. Please explain why, e.g. which boards use it.
> 
> Best regards,
> Krzysztof
> 

If you agree I will add some words explaining SCMI regulator on STM32 
board in the commit message (As Patrick mentioned in his answer). I 
would like to have this patch in my next PR for v6.6. If no objections 
I'll do it directly when I merge the patch in stm32-next.

Cheers
Alex

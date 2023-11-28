Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED407FB5F4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343783AbjK1Jfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343751AbjK1Jfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:35:45 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C60793;
        Tue, 28 Nov 2023 01:35:50 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AS9Eds7030939;
        Tue, 28 Nov 2023 10:35:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=GmAQ+P5wdnfnY6QoWde8H7NjTBmiUXrbb0+PZP5EH5k=; b=Uj
        fjmbeiCLPmw07Q0ANonxjPqA8FgITc+qjN3Rn9ZShXWUbTjSb3Qu+A8h8RqEJULB
        CHLePlWG+7cVQ0wsAEyqTwv0yNtr8s8acnGAPHW9VqnFWpb5HmZGO03/GfpS8Vud
        qDwu1mnb3K91F/hTu/oGuj2yg5cdw6JdGyzwu550gNeJkH7splWwFQIFgLq9jjok
        nfcI1iHomAwWDMrM1B4yONWaIyKy+rEXHo8+2btTtx68Wvy+zaxUga9H1wkDh1wF
        hcSZ0aQpXnvfIAL+pPq12SbhnjdOWaYZfADnWwFq4VLaIHVw+yiU2OEHK4C4Qd2U
        6Xg7nk0Nnc+sSqDWTGaw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uk951up0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 10:35:29 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7611810002A;
        Tue, 28 Nov 2023 10:35:27 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 63A3E21BF7D;
        Tue, 28 Nov 2023 10:35:27 +0100 (CET)
Received: from [10.201.21.240] (10.201.21.240) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 28 Nov
 2023 10:35:26 +0100
Message-ID: <25e18413-e23f-444d-82fe-d36cba662638@foss.st.com>
Date:   Tue, 28 Nov 2023 10:35:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] dt-bindings: stm32: add clocks and reset binding
 for stm32mp25 platform
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20231122132156.158103-1-gabriel.fernandez@foss.st.com>
 <20231122132156.158103-4-gabriel.fernandez@foss.st.com>
 <90664758-9273-4ed7-b711-0abe45b4efed@linaro.org>
 <d8df1a06-1bd1-43a6-abc1-d4a7826e9746@foss.st.com>
 <31940ab7-4b39-4859-b482-5c236a263862@linaro.org>
Content-Language: en-US
From:   Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
In-Reply-To: <31940ab7-4b39-4859-b482-5c236a263862@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.240]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_08,2023-11-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/23/23 13:32, Krzysztof Kozlowski wrote:
> On 23/11/2023 10:39, Gabriel FERNANDEZ wrote:
>
>> ok i will use '
>>>> diff --git a/include/dt-bindings/clock/st,stm32mp25-rcc.h b/include/dt-bindings/clock/st,stm32mp25-rcc.h
>>>> new file mode 100644
>>>> index 000000000000..9876ee0dd1e4
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/clock/st,stm32mp25-rcc.h
>>>> @@ -0,0 +1,492 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
>>> Any particular reason why do you need 3-clause BSD? Checkpatch asks for
>>> different one, because that one clause is just annoying.
>> Yes, the same file can also be used in other components, such as
>> TF-A/OPTEE, and can therefore have a dual licence.
> That's not what I asked. I asked: why do you choose different dual
> license then we ask for (as expressed in checkpatch).


Sorry for the delay, i checked with our licensing experts and we 
concluded that there was no particular reason to use BSD-3-clause 
instead of the BSD-2-clause model.


I'm sending back a new version under GPL-2.0-only OR BSD-2-Clause 
license model.

Best Regards

Gabriel


> Best regards,
> Krzysztof
>

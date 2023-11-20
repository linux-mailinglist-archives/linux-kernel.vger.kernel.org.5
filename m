Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7267F0BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 07:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjKTGnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 01:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjKTGnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 01:43:05 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D171893;
        Sun, 19 Nov 2023 22:43:01 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK6gps8003498;
        Mon, 20 Nov 2023 06:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=F7xqR67JNI2+rkb+W/+ku99i3sosh1nTgLbQXaUahzQ=;
 b=CHO9NTiumdkY7fX4wObmxhKUu4pYEyepe8VcYWGOnIOH8fKKvfx/XWIBdBBilYg6YeGa
 6iR/qodLO5M4gEFAoNRLC+4Q72P8FrQ0G3uNB3+dYmUaeKDvWDHnlU8EhIJ09zHHxAj7
 ZJLMFzwc9mIEtyZfA2vFkaQqGxzD7tMBoa7CUk48VvThzmCKYmEH51Pmp/XJFUIj0aYe
 GvlMwQxf9bgQcFEenMqTJu3/AFBwX8TSiYoawzbHJh7MWaNCsnUB5TKeAh0llLCZQfdR
 HSeJsJmey/de58ISTADRUiSw4d7FwdrG4Rsf6LDf+JtRPHqB0v0HrvAar66wCTjksBLA Fw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uem80k86m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 06:42:57 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AK6gue9008974
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 06:42:56 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 19 Nov
 2023 22:42:51 -0800
Message-ID: <4af8e7a4-0506-a08c-f294-d055fb463af8@quicinc.com>
Date:   Mon, 20 Nov 2023 12:12:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 2/4] clk: qcom: Add Global Clock controller (GCC)
 driver for X1E80100
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <andersson@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <agross@kernel.org>, <conor+dt@kernel.org>,
        <quic_tdas@quicinc.com>, <quic_rjendra@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <neil.armstrong@linaro.org>, <abel.vesa@linaro.org>,
        <quic_tsoni@quicinc.com>
References: <20231117092737.28362-1-quic_sibis@quicinc.com>
 <20231117092737.28362-3-quic_sibis@quicinc.com>
 <ec9d03f7-7158-4309-9a04-b08c69b89f39@linaro.org>
 <2e0d2c55-fb2f-4903-a555-f51019942c6e@linaro.org>
 <c8cf229b-4d15-4eca-bc4b-61dc67d63e91@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <c8cf229b-4d15-4eca-bc4b-61dc67d63e91@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1yO-zWFnfgm1pkZ2K0GZ7REihmblx3-_
X-Proofpoint-ORIG-GUID: 1yO-zWFnfgm1pkZ2K0GZ7REihmblx3-_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_04,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=729
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200042
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/23 07:22, Bryan O'Donoghue wrote:
> On 18/11/2023 00:06, Konrad Dybcio wrote:
>> On 17.11.2023 21:50, Bryan O'Donoghue wrote:
>>> On 17/11/2023 09:27, Sibi Sankar wrote:
>>>> * Use shared ops in the x1e80100 gcc driver [Bryan].
>>>
>>> This looks better to me now / more consistent with what we have in 
>>> sc8280xp - where we do try to hit suspend and => retention/parking 
>>> matters.
>> Parking the clock is separate from putting the system to sleep.
> 
> Yes but several of our clocks want to be parked, not switched off.. 
> which obviously does matter in suspend.
> 
>> IIUC we usually use shared ops on clocks that may have different users
>> (e.g. not only controlled by Linux) and/or that are crucial to the
>> functioning of hardware (like AXI clocks, which if gated would make
>> the system crash on any access attempt, from any subsystem, unless
>> turned on beforehand)
> 
> My question here for Sibi, is why sdcc2_apss_clk_src differs here from 
> sc8280xp?
> 
> Is it wrong on sc8280xp or if correct sc8280xp then why is it not 
> replicated here ?
> 
> https://lore.kernel.org/linux-arm-msm/e857c853-51ef-8314-2a21-fa6fd25162ca@quicinc.com/

Bryan,

5e4b7e82d497 ("clk: qcom: gcc-sdm845: Use floor ops for sdcc clks")

The floor_ops was introduced in sdm845 ^^ and later propagated to all
other QC SoCs later on. It makes sense to do the same for sc8280xp as
well.

> 
> Also @Sibi I realise alot of this code is autogenerated - it would be 
> worthwhile finding/fixing the script that does the generation to plug in 
> shared_ops instead of floor_ops if the input material has the necessary 
> flags.

floor_ops part isn't auto-generated (it comes out as shared_ops,
but like you said it might make sense to include it as part of the
generation process itself.

-Sibi

> 
> ---
> bod

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C378C7F4388
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343633AbjKVKTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbjKVKTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:19:15 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D541ED5C;
        Wed, 22 Nov 2023 02:19:09 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM4gAAB005014;
        Wed, 22 Nov 2023 10:18:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=71nQ+y0aV5G11ViRq/c8FveTleKgrOJIHMuQFrseOT0=;
 b=L3k1/h+rMQmkLKKTIK7qPA/JGmkQF62w02nI4TpsZupHcmjK+5NiqwTL4k9gKpPk9jIw
 RPl54ppi4gVMRDrmXqYNOFxQKvZAnvJDgqFLMuEldk/rsoKJDqtiBaEe9S1z4R4tRunH
 ZzlkkNxGWTVpRt6toO2r5rhJhDEcXY1gQ6q9f47/Knd2xc57O+hxOXy3+AxNSff+S/o2
 ajSsFfTki55tlZlCb3u31jZd4czPscA0RIOnhBRBubHyhnRMOHZ+5+iKkF8egltNoX4R
 w7QEploL6J0tM+ihQ6BXNOyU0I9AZWE851yCkEjgpgTZiboXlwKdTkLT7gDFlZycUN22 SQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uh0b4a6yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 10:18:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AMAIqNn007616
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 10:18:52 GMT
Received: from [10.216.2.74] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 22 Nov
 2023 02:18:45 -0800
Message-ID: <2e357fcf-5348-4fb2-b693-2d6bb4d58b21@quicinc.com>
Date:   Wed, 22 Nov 2023 15:48:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] dt-bindings: clock: ipq5332: drop the few nss
 clocks definition
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20231121-ipq5332-nsscc-v2-0-a7ff61beab72@quicinc.com>
 <20231121-ipq5332-nsscc-v2-3-a7ff61beab72@quicinc.com>
 <43376552-7e79-4f34-94ca-63767a95564b@linaro.org>
 <8bb79735-3b5d-4229-b0f4-bc50d61fdba1@quicinc.com>
 <d26eae8d-4968-4ab0-bd9b-696d7b3865ec@linaro.org>
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <d26eae8d-4968-4ab0-bd9b-696d7b3865ec@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WuwKox3A9KgeuJJ07yj-N41Z_moic0lQ
X-Proofpoint-GUID: WuwKox3A9KgeuJJ07yj-N41Z_moic0lQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_06,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=509 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/2023 3:42 PM, Krzysztof Kozlowski wrote:
> On 22/11/2023 11:08, Kathiravan Thirumoorthy wrote:
>>
>>
>> On 11/21/2023 8:36 PM, Krzysztof Kozlowski wrote:
>>> On 21/11/2023 15:30, Kathiravan Thirumoorthy wrote:
>>>> In commit 0dd3f263c810 ("clk: qcom: ipq5332: enable few nssnoc clocks in
>>>
>>> Where is this commit coming from?
>>>
>>>> driver probe"), gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk,
>>>> gcc_nssnoc_nsscc_clk are enabled in driver probe to keep it always-on.
>>>
>>> Implementation can change and for example bring back these clocks. Are
>>> you going to change bindings? No, drop the patch.
>>>
>>> Bindings should be dropped only in a few rare cases like clocks not
>>> available for OS or bugs.
>>
>> Thanks Krzysztof. Will drop this patch in V3.
>>
>> One more question to understand further. In IPQ SoCs there are bunch of
>> coresight / QDSS clocks but coresight framework doesn't handle all
>> clocks. Those clocks are enabled in bootloader stage itself. In such
>> case, should I drop the clocks from both binding and driver or only from
>> driver?
> 
> That's not really the reason to drop them at all. Neither from driver,
> nor from bindings. You should not rely on bootloader handling your clocks


Thanks, lets say if those clocks are not needed at all by OS since QDSS 
is not used and needed only for the boot loaders to access the 
corresponding address space, in such case what can be done? I 
understand, at first those clocks should not have been added to the driver.


> 
> Best regards,
> Krzysztof
> 

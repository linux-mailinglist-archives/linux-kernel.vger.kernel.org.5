Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E247D364A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjJWMT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjJWMT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:19:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FD0102;
        Mon, 23 Oct 2023 05:19:55 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NCIbNV018863;
        Mon, 23 Oct 2023 12:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JJMVBfCW0A2Bv5G8FWVrVS+RMA/lvi1F9W0oTsylveo=;
 b=exQrwL5DYkYL+WH6UAeZdDHA3QShmlan2DKJUnhiM5JPA9rMPPorIr2KaDZprlKETcVu
 yGDPVKzhExPd4+w3FcigYmMajU/qGreErLubPYEorkjzRrGO55EQky2yvmlNYCAccv+R
 UsFMhN7J8IAvJuW2E2Ahzv37jEU1YsxUyILYWB5T/6C60/LtjRkicwfZdyRjcUgfmthF
 PyODiwqQfVx1sTeNtoHNpxLB6p/TQDCbCOPRHtmp5/8PRLpAd3HjprvZ1INRgbQTdSdn
 BFOK6gAXvVvSzrFR5algHi7fLGx/Gg8CSSBaHph7KR1QC8mnDMCGeR2lwlm5iafb40l5 1Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv6r2by8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 12:19:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39NCJnhb030610
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 12:19:49 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 23 Oct
 2023 05:19:44 -0700
Message-ID: <9b142ecd-bfbd-f265-5a37-611029b4b9e0@quicinc.com>
Date:   Mon, 23 Oct 2023 20:19:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 4/5] arm64: defconfig: enable Qcom Memory Dump driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_tingweiz@quicinc.com>
References: <1698052857-6918-1-git-send-email-quic_zhenhuah@quicinc.com>
 <1698052857-6918-5-git-send-email-quic_zhenhuah@quicinc.com>
 <f3d3a532-bb01-4ed7-be0a-ec021095964a@linaro.org>
 <ca27f6a2-b681-8ad2-9df2-71c5a2742484@quicinc.com>
 <73a78775-eb7f-47d0-971e-44a151931d62@linaro.org>
From:   Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <73a78775-eb7f-47d0-971e-44a151931d62@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KB5oAFjKRHMC1gZMApGRRWLdjpueOv4A
X-Proofpoint-GUID: KB5oAFjKRHMC1gZMApGRRWLdjpueOv4A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 mlxscore=1 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=1
 mlxlogscore=226 impostorscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230107
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/23 19:47, Krzysztof Kozlowski wrote:
> On 23/10/2023 13:43, Zhenhua Huang wrote:
>>
>>
>> On 2023/10/23 17:32, Krzysztof Kozlowski wrote:
>>> On 23/10/2023 11:20, Zhenhua Huang wrote:
>>>> Enable Qcom Memory Dump driver to allow storing debugging
>>>
>>> s/Qcom/Qualcomm/
>>
>> Thanks.
>>
>>>
>>>> information after crash by firmware, including cache
>>>> contents, internal memory, registers.
>>>
>>> Which boards and SoCs need it? This is a defconfig for all platforms,
>>> not for Qualcomm only.
>>
>> Currently I'm enabling it for sm8250, further will enable for other
>> targets. Yes, it's a defconfig for all platforms, do you mean I can
>> enable it other defconfig file, or?
>>
> 
> I meant your commit msg should provide justification, e.g. which boards
> supported by this defconfig are using it.

Clear now, Thanks very much!

Thanks,
Zhenhua

> 
> Best regards,
> Krzysztof
> 

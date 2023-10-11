Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8080B7C542F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjJKMlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjJKMlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:41:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D054491;
        Wed, 11 Oct 2023 05:41:14 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BCOpTH024354;
        Wed, 11 Oct 2023 12:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UZpYFbzXOrXENSAWmRlHpKkAEdevo6eS+r/KdkhBvk4=;
 b=lDPWi64w5irorUuxteH6raNoS9ZNXTmDjRWJybaI9r8HDaPuHJbyxLAlMP7Sv0n04WKt
 7X2FnzSnSENqQEbP6qV879MJfI1MNjVlQMj3yP1yD0ecoJfsHWmmFoho/g3Ey58w8ub0
 omb1kQHB3ENs6iTsZn5aSbqK0gzrjw+929QQ7gwizQB1YK9kAoOlq/DaOg1+wvC0fsYH
 a+IkAwmFATZaHOvBEN/8p7JhcukYJD8VLhzYAc/NJ3eCk6dSAWuxmhvqbA9URZ2NyQjf
 NS431fZmcrzTkhRCTzkd9aNtyPFn9ulw/sH79oxv2luembky03RTkNnC60sBeiHWyKbI vA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tnmds90nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 12:40:59 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39BCewWw022591
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 12:40:58 GMT
Received: from [10.253.39.162] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 11 Oct
 2023 05:40:54 -0700
Message-ID: <c3914104-e2eb-44c1-4d5f-304c51b89c1a@quicinc.com>
Date:   Wed, 11 Oct 2023 20:40:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v9 4/4] clk: qcom: add clock controller driver for
 qca8386/qca8084
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <agross@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20230923112105.18102-1-quic_luoj@quicinc.com>
 <20230923112105.18102-5-quic_luoj@quicinc.com>
 <10bcb0cc-19db-4914-bbc4-ef79c238a70d@linaro.org>
 <49c8a8ff-bdb9-a523-9587-d2a46d401e41@quicinc.com>
 <f97d167e-688e-428d-8463-5b315b9a9593@linaro.org>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <f97d167e-688e-428d-8463-5b315b9a9593@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CYuis6oZakva4pExzS48HlWBAcD-Sq5-
X-Proofpoint-GUID: CYuis6oZakva4pExzS48HlWBAcD-Sq5-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_09,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0 mlxlogscore=802
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110111
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2023 7:32 PM, Konrad Dybcio wrote:
> 
> 
> On 10/11/23 13:26, Jie Luo wrote:
>>
>>
>> On 10/11/2023 6:25 PM, Bryan O'Donoghue wrote:
>>> On 23/09/2023 12:21, Luo Jie wrote:
>>>> The clock controller driver of qca8386/qca8084 is registered
>>>> as the MDIO device, the hardware register is accessed by MDIO bus
>>>> that is normally used to access general PHY device, which is
>>>> different from the current existed qcom clock controller drivers
>>>> using ioremap to access hardware clock registers.
>>>
>>> "nsscc-qca8k is accessed via an MDIO bus"
>>>
>>>> MDIO bus is common utilized by both qca8386/qca8084 and other
>>>
>>> commonly
>>>
>>>> PHY devices, so the mutex lock mdio_bus->mdio_lock should be
>>>> used instead of using the mutex lock of remap.
>>>>
>>>> To access the hardware clock registers of qca8386/qca8084, there
>>>> is special MDIO frame sequence(three MDIO read/write operations)
>>>> need to be sent to device.
>>>
>>> "there is a special MDIO frame sequence"
>>>
>>> "which needs to be sent to the device"
>>
>> I will update the comments, thanks Bryan.
>>
>>>
>>> the following indentation splat from checkpatch
>>>
>>> CHECK: Alignment should match open parenthesis
>>> #2071: FILE: drivers/clk/qcom/nsscc-qca8k.c:2004:
>>> +        ret = __mdiobus_write(bus, switch_phy_id, (reg | 
>>> QCA8K_REG_DATA_UPPER_16_BITS),
>>> +                upper_16_bits(val));
>>>
>>> CHECK: Alignment should match open parenthesis
>>> #2131: FILE: drivers/clk/qcom/nsscc-qca8k.c:2064:
>>> +static int qca8k_regmap_update_bits(void *context, unsigned int 
>>> regaddr,
>>> +        unsigned int mask, unsigned int value)
>>>
>>> total: 0 errors, 1 warnings, 2 checks, 2162 lines checked
>>>
>>> NOTE: For some of the reported defects, checkpatch may be able to
>>>        mechanically convert to the typical style using --fix or 
>>> --fix-inplace.
>>>
>>> 0004-clk-qcom-add-clock-controller-driver-for-qca8386-qca.patch has 
>>> style problems, please review.
>>
>> Thanks Bryan for the review. The code line mentioned by CHECK is more 
>> than 100 columns, so i separate the lines.
> Please read what checkpatch tells you.
> 
> It asks you to change
> 
> very_long_func_name(arg1, arg2,
>      arg3);
> 
> to
> 
> very_long_func_name(arg1, arg2,
>              arg3);
> 
> (remember tab len is 8 for the linux kernel)
> 
> Konrad

Got it, thanks Konrad for the reminder.

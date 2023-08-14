Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A0B77B731
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjHNK64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbjHNK6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:58:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13C2109;
        Mon, 14 Aug 2023 03:58:45 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EAng7r023888;
        Mon, 14 Aug 2023 10:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TpxlUtKjEJSvZzzD9sKu9m96D0X87KJp+Yzh5rie9SE=;
 b=BknKqspmwygizK1OxMlK9Rou6YME3kkBzyveZVjQyMi1pz4XymkICSswJU7Dx7sI02XA
 XwdkMeNdLfUOZdwxCTmfiP4GwcvKvxliz/tdQ33cLkq6fIfQ2bCjod6gHVu2ptspv1ST
 pjR0dsQxtInyLlkAKOlG1pPKrK5ErNR8CHeZn/T4NP6Aq9l18T90d3/sBBaVYrLBjcgD
 yEihaDaY5egK4IjzQAp7Fd1nn4uN00FNeRf1LFhWzttQFrkjA4atBTs8HDfIrUYWiYX8
 eIKyXIdrsZVcTPgUtEpYV5HW+H4+8bMny2AvWEceFYVagRTlw+R3UhpAfRAZvI9NYs8s SA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3j93nj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 10:58:35 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37EAwYNS023256
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 10:58:34 GMT
Received: from [10.253.13.227] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 14 Aug
 2023 03:58:30 -0700
Message-ID: <6ebdcbdc-409c-0c08-1e5d-f9aa0b92c3b2@quicinc.com>
Date:   Mon, 14 Aug 2023 18:58:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 3/3] clk: qcom: add clock controller driver for
 qca8386/qca8084
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <agross@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20230810115419.25539-1-quic_luoj@quicinc.com>
 <20230810115419.25539-4-quic_luoj@quicinc.com>
 <9dec09fa-a5a3-416c-9b4d-4b4c4e10320b@linaro.org>
 <9a55016f-0049-f185-f2be-d138fe33384b@quicinc.com>
 <631d5a82-7d24-49cd-9868-74c7b3c08bcd@linaro.org>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <631d5a82-7d24-49cd-9868-74c7b3c08bcd@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: k6VyMzyfW_Ejz_QeZLomfM7TLdkoEecw
X-Proofpoint-GUID: k6VyMzyfW_Ejz_QeZLomfM7TLdkoEecw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_06,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140101
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/12/2023 6:56 PM, Konrad Dybcio wrote:
> On 11.08.2023 13:49, Jie Luo wrote:
>>
>>
>> On 8/10/2023 8:59 PM, Konrad Dybcio wrote:
>>> On 10.08.2023 13:54, Luo Jie wrote:
>>>> Add clock & reset controller driver for qca8386/qca8084.
>>>>
>>>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>>>> ---
>>>
>>>> +struct qcom_cc {
>>>> +    struct qcom_reset_controller reset;
>>>> +    struct clk_regmap **rclks;
>>>> +    size_t num_rclks;
>>>> +};
>>> This all, including the probe func, is required because of the MDIO dance,
>>> I assume?
>>>
>>> Commonizing that would make more sense should more clocks like this appear
>>> in the future.
>>>
>> Hi Konrad,
>> Thanks for the review.
>> the structure qcom_cc is not because of MDIO dance, this is the common structure used by other qcom clock drivers such as gcc-ipq9574 in the probe function.
>>
>> seems that we can't make any more commonization on this, please let me know if there is any idea on this.
> My main point is, why can't you use qcom_cc_really_probe?
> 

Hi Konrad,
qcom_cc_really_probe is taking the platform_device as the input 
parameter, but the nss_cc_qca8k_probe takes the mdio_device as the probe 
parameter.

>>
>>> [...]
>>>
>>>> +static struct clk_branch nss_cc_switch_core_clk = {
>>>> +    .halt_reg = 0x8,
>>>> +    .clkr = {
>>>> +        .enable_reg = 0x8,
>>>> +        .enable_mask = BIT(0),
>>>> +        .hw.init = &(const struct clk_init_data) {
>>>> +            .name = "nss_cc_switch_core_clk",
>>>> +            .parent_hws = (const struct clk_hw *[]) {
>>>> +                &nss_cc_switch_core_clk_src.clkr.hw,
>>>> +            },
>>>> +            .num_parents = 1,
>>>> +            /* Can be disabled in PHY mode for power saving */
>>> Well it clearly cannot be disabled if it has the CLK_IS_CRITICAL flag :D
>>>
>>> What's the "PHY mode" you're talking about?
>> Yes, the clock with flag CLK_IS_CRITICAL needs to be enabled, the hardware register needs to be configured to enable it, it is disabled by default.
>>
>> this clock branch is necessary for the switch mode that has switch features such routing and fdb forwarding, i will remove the CLK_IS_CRITICAL from the clock that is not needed for the PHY mode, we can enable it later when configuring it as switch mode.
>>
>> As for PHY mode, the device works as only PHY device, that includes 4 PHY ports, no switch functions.
> It's still not obvious at all what "phy mode" or "switch mode" are.
> Are they usecases for a device based on this SoC?
> 
> Konrad

They are different chips, qca8084 works in PHY mode, however qca8386 
works in switch mode, that is the different hardware device, but the 
clock controller driver can be used by both.

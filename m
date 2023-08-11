Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C55778E38
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbjHKLuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjHKLuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:50:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D079BDC;
        Fri, 11 Aug 2023 04:50:10 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37B5hH0u029807;
        Fri, 11 Aug 2023 11:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=M6ocA0XsJ5bdriibaSgFS3W+em8rBoAQKGmiD2PZuMI=;
 b=p5c3hEUzetz26gzEi9j0viRg4TeeQFLf4wGmAv3yKLFVnrIcRjv8Jggb6hl8mQFQw9ai
 eHUu4UU+SGRg3EL9IoYBe8x79SqNqUHRb+qn13+n9fWPUyw6XxuLI/NKFRoBKnKLXLBH
 A+OAZVCHOQBxoWs85ZqxTVJyXV64ROhWb4H9RhhNVfkDECb0pV4pythfqWKHGK+78MRb
 GwM4nMMW/ELj5WuFZ6YTPgkBKWxTe/eJKBQDF4u1RxKJhUi8rdqbBSeDZixdF53xtgyo
 peSESZcsSJapyHYN77OpKGeiOPkadgjhqFhVQ/HqvoDG4+d8P18lpA7R6yDJipn0yGRb vw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd9061f2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 11:50:00 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37BBnxKX025728
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 11:49:59 GMT
Received: from [10.253.77.66] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 11 Aug
 2023 04:49:56 -0700
Message-ID: <9a55016f-0049-f185-f2be-d138fe33384b@quicinc.com>
Date:   Fri, 11 Aug 2023 19:49:53 +0800
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
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <9dec09fa-a5a3-416c-9b4d-4b4c4e10320b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bteA0h2er0MyN4fLjz8TxWgHkUuaijO3
X-Proofpoint-ORIG-GUID: bteA0h2er0MyN4fLjz8TxWgHkUuaijO3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_03,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110108
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/2023 8:59 PM, Konrad Dybcio wrote:
> On 10.08.2023 13:54, Luo Jie wrote:
>> Add clock & reset controller driver for qca8386/qca8084.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
> 
>> +struct qcom_cc {
>> +	struct qcom_reset_controller reset;
>> +	struct clk_regmap **rclks;
>> +	size_t num_rclks;
>> +};
> This all, including the probe func, is required because of the MDIO dance,
> I assume?
> 
> Commonizing that would make more sense should more clocks like this appear
> in the future.
> 
Hi Konrad,
Thanks for the review.
the structure qcom_cc is not because of MDIO dance, this is the common 
structure used by other qcom clock drivers such as gcc-ipq9574 in the 
probe function.

seems that we can't make any more commonization on this, please let me 
know if there is any idea on this.

> [...]
> 
>> +static struct clk_branch nss_cc_switch_core_clk = {
>> +	.halt_reg = 0x8,
>> +	.clkr = {
>> +		.enable_reg = 0x8,
>> +		.enable_mask = BIT(0),
>> +		.hw.init = &(const struct clk_init_data) {
>> +			.name = "nss_cc_switch_core_clk",
>> +			.parent_hws = (const struct clk_hw *[]) {
>> +				&nss_cc_switch_core_clk_src.clkr.hw,
>> +			},
>> +			.num_parents = 1,
>> +			/* Can be disabled in PHY mode for power saving */
> Well it clearly cannot be disabled if it has the CLK_IS_CRITICAL flag :D
> 
> What's the "PHY mode" you're talking about?
Yes, the clock with flag CLK_IS_CRITICAL needs to be enabled, the 
hardware register needs to be configured to enable it, it is disabled by 
default.

this clock branch is necessary for the switch mode that has switch 
features such routing and fdb forwarding, i will remove the 
CLK_IS_CRITICAL from the clock that is not needed for the PHY mode, we 
can enable it later when configuring it as switch mode.

As for PHY mode, the device works as only PHY device, that includes 4 
PHY ports, no switch functions.

> 
>> +			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
>> +			.ops = &clk_branch2_mdio_ops,
>> +		},
>> +	},
>> +};
> I see a whole bunch of CRITICAL clocks.. please make sure these clocks
> are actually necessary for Linux to know about (i.e. if we don't need
> to call any operations on them, we might just skip registering them
> with the driver).
> 
> Konrad
> 
yes, Konrad, the clocks with  CLK_IS_CRITICAL need to be enabled 
manually, all clocks are disabled after reset(by default).

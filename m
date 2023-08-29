Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD83E78BE10
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjH2Fw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjH2Fwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:52:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30EDF4;
        Mon, 28 Aug 2023 22:52:30 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T2Qomq032661;
        Tue, 29 Aug 2023 05:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DMAO/tZrI0bbmSE7TU4ffinXGhYBrCGAIWUvF+7P4OQ=;
 b=fEmyBrig12OGG8ASW+LeheDLoUfXZdnbKkZpXYzwkv/jwuk4fuQx8wrIsFynG9yKWlI0
 h9KgaDAxFgRIC3bj0xOKaOla1HvlcXyIk0+YE3QWgYboAqkzazTqm3FC+oWcuVmWItrp
 PvGOhcwF3mtOxc/PGAvstoQ+/+VCGAz9rWgoTpj9CWrjAgBsLxyal70Ig+D/dWGD/4J4
 sINl9Q2P449FUwNYEBeBEWqu9Q+rD7HSrPuA1JG+yfY2SNinTH2SyYfk5VZsIv6kVRbM
 cHHnHzRcUlYnxIqKz8DchPBxHqZaVDpjdlqsyNPxyLokdYa2jUgk9hNznLYgSzBbQtTD gw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss7merb2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 05:52:22 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37T5qKpb028659
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 05:52:21 GMT
Received: from [10.218.10.146] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 28 Aug
 2023 22:52:16 -0700
Message-ID: <8d53a098-bf0d-1b40-45c0-264a42d6e72d@quicinc.com>
Date:   Tue, 29 Aug 2023 11:21:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/4] clk: qcom: rpmh: Add RPMH clocks support for SM4450
Content-Language: en-US
To:     <neil.armstrong@linaro.org>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230824173410.550126-1-quic_ajipan@quicinc.com>
 <20230824173410.550126-3-quic_ajipan@quicinc.com>
 <71d1d748-133a-470b-986c-ece79f743aa4@linaro.org>
From:   Ajit Pandey <quic_ajipan@quicinc.com>
In-Reply-To: <71d1d748-133a-470b-986c-ece79f743aa4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PMSyR2Py-LjshopZXoslD-8dqc5NwZZr
X-Proofpoint-GUID: PMSyR2Py-LjshopZXoslD-8dqc5NwZZr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_03,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290049
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/2023 7:31 PM, Neil Armstrong wrote:
> Hi,
> 
> On 24/08/2023 19:34, Ajit Pandey wrote:
>> Add support for RPMH clocks for SM4450 platform.
>>
>> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
>> ---
>>   drivers/clk/qcom/clk-rpmh.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
>> index 4c5b552b47b6..5d853fd43294 100644
>> --- a/drivers/clk/qcom/clk-rpmh.c
>> +++ b/drivers/clk/qcom/clk-rpmh.c
>> @@ -350,6 +350,7 @@ DEFINE_CLK_RPMH_VRM(ln_bb_clk3, _a2, "lnbclka3", 2);
>>   DEFINE_CLK_RPMH_VRM(ln_bb_clk1, _a4, "lnbclka1", 4);
>>   DEFINE_CLK_RPMH_VRM(ln_bb_clk2, _a4, "lnbclka2", 4);
>> +DEFINE_CLK_RPMH_VRM(ln_bb_clk3, _a4, "lnbclka3", 4);
>>   DEFINE_CLK_RPMH_VRM(ln_bb_clk2, _g4, "lnbclkg2", 4);
>>   DEFINE_CLK_RPMH_VRM(ln_bb_clk3, _g4, "lnbclkg3", 4);
>> @@ -717,6 +718,25 @@ static const struct clk_rpmh_desc clk_rpmh_sdx75 = {
>>       .num_clks = ARRAY_SIZE(sdx75_rpmh_clocks),
>>   };
>> +static struct clk_hw *sm4450_rpmh_clocks[] = {
>> +    [RPMH_CXO_CLK]        = &clk_rpmh_bi_tcxo_div4.hw,
>> +    [RPMH_CXO_CLK_A]    = &clk_rpmh_bi_tcxo_div4_ao.hw,
> 
> Are you sure about div4 here ?
> 
> Kailua uses div2 because the CXO input gets used divided by 2
> by PHYs and divided by 4 for GCC/DISPCC/...
> 
> This is why we introduced a div2 clock in DT used to feed GCC/DISPCC/...
> 
> Neil

Yes div4 is the correct divider only for sm4450 as CXO input get 
directly divided by 4 only. This is someting similiar to sm8450 and 
there is no in between div2 divider like Kailua.

> 
>> +    [RPMH_LN_BB_CLK2]    = &clk_rpmh_ln_bb_clk2_a4.hw,
>> +    [RPMH_LN_BB_CLK2_A]    = &clk_rpmh_ln_bb_clk2_a4_ao.hw,
>> +    [RPMH_LN_BB_CLK3]       = &clk_rpmh_ln_bb_clk3_a4.hw,
>> +    [RPMH_LN_BB_CLK3_A]     = &clk_rpmh_ln_bb_clk3_a4_ao.hw,
>> +    [RPMH_RF_CLK1]        = &clk_rpmh_rf_clk1_a.hw,
>> +    [RPMH_RF_CLK1_A]    = &clk_rpmh_rf_clk1_a_ao.hw,
>> +    [RPMH_RF_CLK5]        = &clk_rpmh_rf_clk5_a.hw,
>> +    [RPMH_RF_CLK5_A]    = &clk_rpmh_rf_clk5_a_ao.hw,
>> +    [RPMH_IPA_CLK]        = &clk_rpmh_ipa.hw,
>> +};
>> +
>> +static const struct clk_rpmh_desc clk_rpmh_sm4450 = {
>> +    .clks = sm4450_rpmh_clocks,
>> +    .num_clks = ARRAY_SIZE(sm4450_rpmh_clocks),
>> +};
>> +
>>   static struct clk_hw *of_clk_rpmh_hw_get(struct of_phandle_args 
>> *clkspec,
>>                        void *data)
>>   {
>> @@ -810,6 +830,7 @@ static const struct of_device_id 
>> clk_rpmh_match_table[] = {
>>       { .compatible = "qcom,sdx55-rpmh-clk",  .data = &clk_rpmh_sdx55},
>>       { .compatible = "qcom,sdx65-rpmh-clk",  .data = &clk_rpmh_sdx65},
>>       { .compatible = "qcom,sdx75-rpmh-clk",  .data = &clk_rpmh_sdx75},
>> +    { .compatible = "qcom,sm4450-rpmh-clk", .data = &clk_rpmh_sm4450},
>>       { .compatible = "qcom,sm6350-rpmh-clk", .data = &clk_rpmh_sm6350},
>>       { .compatible = "qcom,sm8150-rpmh-clk", .data = &clk_rpmh_sm8150},
>>       { .compatible = "qcom,sm8250-rpmh-clk", .data = &clk_rpmh_sm8250},
> 

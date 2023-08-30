Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1129C78DF52
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244562AbjH3TVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240016AbjH3GiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:38:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA3C132;
        Tue, 29 Aug 2023 23:38:16 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U3cuL8005120;
        Wed, 30 Aug 2023 06:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=J/bu3cR5Lai9kz2WZOz2YJs1uiSGdZiEfU+DHeo/xns=;
 b=kjtZUXIkHxzt9nUPkz5YGpElHhZWARY3k0R3sbHsVRbceO0qiNoJuHnjvyGEyTDtSG2o
 A1i+yE/Ceb7CxRIzvFTjLkxYRo+Krn4sB3IwLiTXg0KwK/rS0mLUfNQlu/alnouyzb6g
 SA0DN1cHmH5/IV97Gd7X6YHwTpledNsjR7LqJFykLsHLKfGl4dTUN1LtOtohzEsqvx1J
 pZl4RjhnO2a29AAZHDZQE5f1LuoLEoKNRC4DQeP/h858zhznj4PPn0fuYuGTQ0tmcKji
 8DKazn8J5YDz14AFGW2ZA+RhL4yUlGPQrJKURTYHJmLfTTohbV999BEmnxoXUjjo2n4+ sw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ssjvb1qx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 06:38:02 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37U6c0sG010184
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 06:38:01 GMT
Received: from [10.201.2.48] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 29 Aug
 2023 23:37:56 -0700
Message-ID: <967fad8b-7b20-765e-217c-c1c19de7b40e@quicinc.com>
Date:   Wed, 30 Aug 2023 12:07:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/3] clk: qcom: apss-ipq-pll: add support for IPQ5018
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <devicetree@vger.kernel.org>,
        <jassisinghbrar@gmail.com>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mturquette@baylibre.com>,
        <robh+dt@kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>
References: <20230829095423.760641-1-quic_gokulsri@quicinc.com>
 <20230829095423.760641-3-quic_gokulsri@quicinc.com>
 <9e3fec3f3bf11ec0722f6277593d96ff.sboyd@kernel.org>
From:   Gokul Sriram P <quic_gokulsri@quicinc.com>
In-Reply-To: <9e3fec3f3bf11ec0722f6277593d96ff.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: INu1U2tnqpSYoDemlB4HUhpUP6_tm1fR
X-Proofpoint-GUID: INu1U2tnqpSYoDemlB4HUhpUP6_tm1fR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300060
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/30/2023 4:04 AM, Stephen Boyd wrote:
> Quoting Gokul Sriram Palanisamy (2023-08-29 02:54:22)
>> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
>> index e170331858cc..bbc25d5eb70d 100644
>> --- a/drivers/clk/qcom/apss-ipq-pll.c
>> +++ b/drivers/clk/qcom/apss-ipq-pll.c
>> @@ -24,6 +24,17 @@ static const u8 ipq_pll_offsets[][PLL_OFF_MAX_REGS] = {
>>                  [PLL_OFF_TEST_CTL] = 0x30,
>>                  [PLL_OFF_TEST_CTL_U] = 0x34,
>>          },
>> +       [CLK_ALPHA_PLL_TYPE_STROMER] = {
>> +               [PLL_OFF_L_VAL] = 0x08,
>> +               [PLL_OFF_ALPHA_VAL] = 0x10,
>> +               [PLL_OFF_ALPHA_VAL_U] = 0x14,
>> +               [PLL_OFF_USER_CTL] = 0x18,
>> +               [PLL_OFF_USER_CTL_U] = 0x1c,
>> +               [PLL_OFF_CONFIG_CTL] = 0x20,
>> +               [PLL_OFF_STATUS] = 0x28,
>> +               [PLL_OFF_TEST_CTL] = 0x30,
>> +               [PLL_OFF_TEST_CTL_U] = 0x34,
>> +       },
> Is anything different from STROMER_PLUS?
  No, here both both STROMER and STROMER  PLUS has the same offsets.
   Will update to reuse STORMER PLUS config.
>>          [CLK_ALPHA_PLL_TYPE_STROMER_PLUS] = {
>>                  [PLL_OFF_L_VAL] = 0x08,
>>                  [PLL_OFF_ALPHA_VAL] = 0x10,
>> @@ -73,6 +84,38 @@ static struct clk_alpha_pll ipq_pll_stromer_plus = {
>>          },
>>   };
>>   
>> +static struct clk_alpha_pll ipq_pll_stromer = {
>> +       .offset = 0x0,
>> +       .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_STROMER],
>> +       .flags = SUPPORTS_DYNAMIC_UPDATE,
>> +       .clkr = {
>> +               .enable_reg = 0x0,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
> const?
  sure, will update.
>> +                       .name = "a53pll",
>> +                       .parent_data = &(const struct clk_parent_data) {
>> +                               .fw_name = "xo",
>> +                       },
>> +                       .num_parents = 1,
>> +                       .ops = &clk_alpha_pll_stromer_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static const struct alpha_pll_config ipq5018_pll_config = {
>> +       .l = 0x32,
>> +       .config_ctl_val = 0x4001075b,
>> +       .config_ctl_hi_val = 0x304,
>> +       .main_output_mask = BIT(0),
>> +       .aux_output_mask = BIT(1),
>> +       .early_output_mask = BIT(3),
>> +       .alpha_en_mask = BIT(24),
>> +       .status_val = 0x3,
>> +       .status_mask = GENMASK(10, 8),
>> +       .lock_det = BIT(2),
>> +       .test_ctl_hi_val = 0x00400003,
>> +};
>> +
>>   static const struct alpha_pll_config ipq5332_pll_config = {
>>          .l = 0x3e,
>>          .config_ctl_val = 0x4001075b,
>> @@ -129,6 +172,12 @@ struct apss_pll_data {
>>          const struct alpha_pll_config *pll_config;
>>   };
>>   
>> +static struct apss_pll_data ipq5018_pll_data = {
> const?
  sure, will update.
>> +       .pll_type = CLK_ALPHA_PLL_TYPE_STROMER,
>> +       .pll = &ipq_pll_stromer,
>> +       .pll_config = &ipq5018_pll_config,
>> +};
>> +
>>   static struct apss_pll_data ipq5332_pll_data = {
>>          .pll_type = CLK_ALPHA_PLL_TYPE_STROMER_PLUS,
>>          .pll = &ipq_pll_stromer_plus,
>> @@ -183,7 +232,7 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
>>   
>>          if (data->pll_type == CLK_ALPHA_PLL_TYPE_HUAYRA)
>>                  clk_alpha_pll_configure(data->pll, regmap, data->pll_config);
>> -       else if (data->pll_type == CLK_ALPHA_PLL_TYPE_STROMER_PLUS)
>> +       else
> Just add both STROMER and STROMER_PLUS. Or make STROMER the same as
> STROMER_PLUS locally in this file?

sure, with the first comment addressed, this change will not be needed.

Regards,
Gokul


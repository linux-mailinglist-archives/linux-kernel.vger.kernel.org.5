Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAB6755B19
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjGQGEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjGQGEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:04:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFD71A2;
        Sun, 16 Jul 2023 23:04:38 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H5fVVI029153;
        Mon, 17 Jul 2023 06:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=B9GtKlwnztF0FiPj/X/9qJH2wGXsUE01gQZoOBUtfeY=;
 b=fvRgA1f4Y4JTR5ywi1bqhwKHTA8Mt3mQv67oOFAxz8hSDedSK071B64IUt5oJyfD0joE
 A73JytdUEJF+OECffOHPE1/9RBzLeIFMS2nb3q9aPQjc8OSxKl3VNm+ak+vkgbw+Cydo
 xKrY04zxES+kfIe30FhLeFsI0LWSFOn+sM0VVg6YIe4avx2jeF7fQy254VAvChW3APjZ
 K7opLks/5tGLqDz0QK9mGYIvzlBHfCT2d/6mQ9vKWI8xsbwsRz9JGxIZxryhQdkaoW6P
 aQcll0AJmNpn1g/XHO5uRxBvFPT821BnhOb4L9it9cWlz7nSWp0jzpm/0bDCyQf2EVXS jw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run1gjjta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 06:04:29 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36H64SHt008247
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 06:04:28 GMT
Received: from [10.216.42.53] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 16 Jul
 2023 23:04:22 -0700
Message-ID: <986b0cbe-23b8-9347-8b08-6968c306ec1c@quicinc.com>
Date:   Mon, 17 Jul 2023 11:34:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V3 4/6] clk: qcom: gcc-qdu1000: Update GCC clocks as per
 the latest hw version
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230706105045.633076-1-quic_imrashai@quicinc.com>
 <20230706105045.633076-5-quic_imrashai@quicinc.com>
 <a2d362d0-3a58-0835-5106-fb60f0c3e4d0@linaro.org>
Content-Language: en-US
From:   Imran Shaik <quic_imrashai@quicinc.com>
In-Reply-To: <a2d362d0-3a58-0835-5106-fb60f0c3e4d0@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HfdmzrGXXC3Gmj2MJLFuzzpdd1pZuSZ2
X-Proofpoint-GUID: HfdmzrGXXC3Gmj2MJLFuzzpdd1pZuSZ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_04,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170054
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/2023 6:50 PM, Konrad Dybcio wrote:
> On 6.07.2023 12:50, Imran Shaik wrote:
>> Update the GCC clocks as per the latest hw version of QDU1000 and
>> QRU100 SoCs.
>>
>> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
>> ---
>> Changes since v2:
>>   - Split the patch as per the review comments
>>   - Newly added
>>
>>   drivers/clk/qcom/gcc-qdu1000.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/gcc-qdu1000.c b/drivers/clk/qcom/gcc-qdu1000.c
>> index 8df7b7983968..991fb2bc97e9 100644
>> --- a/drivers/clk/qcom/gcc-qdu1000.c
>> +++ b/drivers/clk/qcom/gcc-qdu1000.c
>> @@ -1131,6 +1131,26 @@ static struct clk_branch gcc_ddrss_ecpri_dma_clk = {
>>   	},
>>   };
>>   
>> +static struct clk_branch gcc_ddrss_ecpri_gsi_clk = {
>> +	.halt_reg = 0x54298,
>> +	.halt_check = BRANCH_HALT_VOTED,
>> +	.hwcg_reg = 0x54298,
>> +	.hwcg_bit = 1,
>> +	.clkr = {
>> +		.enable_reg = 0x54298,
>> +		.enable_mask = BIT(0),
>> +		.hw.init = &(const struct clk_init_data) {
>> +			.name = "gcc_ddrss_ecpri_gsi_clk",
>> +			.parent_hws = (const struct clk_hw*[]) {
>> +				&gcc_aggre_noc_ecpri_gsi_clk_src.clkr.hw,
>> +			},
>> +			.num_parents = 1,
>> +			.flags = CLK_SET_RATE_PARENT,
>> +			.ops = &clk_branch2_aon_ops,
>> +		},
>> +	},
>> +};
>> +
>>   static struct clk_branch gcc_ecpri_ahb_clk = {
>>   	.halt_reg = 0x3a008,
>>   	.halt_check = BRANCH_HALT_VOTED,
>> @@ -2521,6 +2541,8 @@ static struct clk_regmap *gcc_qdu1000_clocks[] = {
>>   	[GCC_AGGRE_NOC_ECPRI_GSI_CLK] = &gcc_aggre_noc_ecpri_gsi_clk.clkr,
>>   	[GCC_PCIE_0_PHY_AUX_CLK_SRC] = &gcc_pcie_0_phy_aux_clk_src.clkr,
>>   	[GCC_PCIE_0_PIPE_CLK_SRC] = &gcc_pcie_0_pipe_clk_src.clkr,
>> +	[GCC_GPLL1_OUT_EVEN] = &gcc_gpll1_out_even.clkr,
> Looks like you split it too much.. this clock is not being defined in this patch.
> 
> Konrad

This clock was already defined in the initial gcc changes and now adding 
it to gcc_qdu1000_clocks[] to register it with the clock framework.

Thanks,
Imran

>> +	[GCC_DDRSS_ECPRI_GSI_CLK] = &gcc_ddrss_ecpri_gsi_clk.clkr,
>>   };
>>   
>>   static const struct qcom_reset_map gcc_qdu1000_resets[] = {

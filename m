Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0508A79009D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344950AbjIAQQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbjIAQQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:16:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977D3E5F;
        Fri,  1 Sep 2023 09:16:22 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 381G0JhN016347;
        Fri, 1 Sep 2023 16:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fQXdVgC8H3ZHI+cVXJ85DJqMLWM9x6fFJNVhYDTwO2U=;
 b=QF/Y+jXY86srvasL/bV23xR2zL/QNhGaYnI1ugZvudru7ikrNWFe5Eq6B4Xag4BGMPtJ
 1CsZTlA7EWA+ojky7eTUDJKDWMNyZraBZXf4MeMi6C+Lyle+QjmUErL2YBCdv5Qk4Ol5
 TdbXEaN6W11/A+LRt5I6Vd6iPlqmW4jspmAnYGkDqA/YwDyx9iDYAYs/mcXZVq8uSJGg
 RWLBBcCHZYzZkoaGKVscjiivoLNJ2T9SZbFbaxJ+xmBUvQg0JzrPxrDZ9U7znmgHnt5Q
 AWSESID9Iru5XhjRt9h7jwerWT8mPc7o3B3YWnURiVGe7kmnrVJS6cj7nVSG7/O+LPH8 kw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sug2h8n5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 16:15:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 381GFGln026870
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Sep 2023 16:15:16 GMT
Received: from [10.216.36.87] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 1 Sep
 2023 09:15:05 -0700
Message-ID: <c1da6c89-5716-1232-11c0-ec598d7b189e@quicinc.com>
Date:   Fri, 1 Sep 2023 21:45:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V2 3/7] clk: qcom: gcc-ipq9574: Add gpll0_out_aux clock
To:     Devi Priya <quic_devipriy@quicinc.com>, <andersson@kernel.org>,
        <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <richardcochran@gmail.com>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
CC:     <quic_saahtoma@quicinc.com>
References: <20230825091234.32713-1-quic_devipriy@quicinc.com>
 <20230825091234.32713-4-quic_devipriy@quicinc.com>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <20230825091234.32713-4-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VP7ph8WG9-9QtdtoE8jgz2InqWjNjAPh
X-Proofpoint-ORIG-GUID: VP7ph8WG9-9QtdtoE8jgz2InqWjNjAPh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_13,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 phishscore=0
 adultscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010152
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/25/2023 2:42 PM, Devi Priya wrote:
> Add support for gpll0_out_aux clock which acts as the parent for
> certain networking subsystem (nss) clocks.
>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>   drivers/clk/qcom/gcc-ipq9574.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
> index 8f430367299e..495a66f7d29a 100644
> --- a/drivers/clk/qcom/gcc-ipq9574.c
> +++ b/drivers/clk/qcom/gcc-ipq9574.c
> @@ -107,6 +107,21 @@ static struct clk_alpha_pll_postdiv gpll0 = {
>   	},
>   };
>   
> +static struct clk_alpha_pll_postdiv gpll0_out_aux = {
> +	.offset = 0x20000,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
> +	.width = 4,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gpll0_out_aux",
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&gpll0_main.clkr.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,


You might need to drop the member 'flags '. Please refer 
https://lore.kernel.org/linux-arm-msm/1693474133-10467-1-git-send-email-quic_varada@quicinc.com/

I will send the patch to drop the flags in the existing driver sometime 
next week.

Thanks,


> +		.ops = &clk_alpha_pll_postdiv_ro_ops,
> +	},
> +};
> +
>   static struct clk_alpha_pll gpll4_main = {
>   	.offset = 0x22000,
>   	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
> @@ -4144,6 +4159,7 @@ static struct clk_regmap *gcc_ipq9574_clks[] = {
>   	[GCC_SNOC_PCIE1_1LANE_S_CLK] = &gcc_snoc_pcie1_1lane_s_clk.clkr,
>   	[GCC_SNOC_PCIE2_2LANE_S_CLK] = &gcc_snoc_pcie2_2lane_s_clk.clkr,
>   	[GCC_SNOC_PCIE3_2LANE_S_CLK] = &gcc_snoc_pcie3_2lane_s_clk.clkr,
> +	[GPLL0_OUT_AUX] = &gpll0_out_aux.clkr,
>   };
>   
>   static const struct qcom_reset_map gcc_ipq9574_resets[] = {

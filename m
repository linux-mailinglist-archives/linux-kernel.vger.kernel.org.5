Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EA479D0B9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbjILMHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbjILMHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:07:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6344C10D0;
        Tue, 12 Sep 2023 05:07:31 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CBg6Gr013041;
        Tue, 12 Sep 2023 12:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TpRkSGy9bAiQly3TrmAYNmwyDja3VoEJVgLgv+ifnqI=;
 b=ldYbvsC7/79u1CwY6fYYC7jdDf8ic8ib3z3EdzRW8IsDzGIZM8drj8lseQUlEs0JQsUx
 NZQ/ir8ptpGrtfgvkVY9f1EL16JtUM2u+fa3nkba9w7gE0O6rbCOv1hRA0rJIXmaJg0J
 Hmkf6OfuVpJv0FW4DhYfMWisRO1qTVcPUDOMdnzeMZ3+PiEzLYQ5bcLlasoe2xH188Mw
 0RLwZy79TTG/EFpQtZQ3qsfi/RAqOq3zKIp8dg5jTP1clfbeIbnZ6ompidIM4fCnXMOH
 fuKWWb2w33hgRkakda/T/mZymggGa+8rdF6zox3fBYXruNwY2XgeWFzc1CHq3jJzFTIF tg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t268fj8x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 12:07:12 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38CC79vW032117
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 12:07:09 GMT
Received: from [10.253.74.236] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 12 Sep
 2023 05:07:05 -0700
Message-ID: <f67b354c-8a4b-49f5-6275-66b7d614301a@quicinc.com>
Date:   Tue, 12 Sep 2023 20:07:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v6 4/4] clk: qcom: add clock controller driver for
 qca8386/qca8084
To:     Stephen Boyd <sboyd@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <catalin.marinas@arm.com>,
        <conor+dt@kernel.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <p.zabel@pengutronix.de>, <robh+dt@kernel.org>, <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20230901091823.30242-1-quic_luoj@quicinc.com>
 <20230901091823.30242-5-quic_luoj@quicinc.com>
 <27ae3297ad161fd67706db70b402db04.sboyd@kernel.org>
 <16d09acf-7bdd-04ee-6faf-936c0366df03@quicinc.com>
 <17681a9f756cc70a190c674c51b90140.sboyd@kernel.org>
 <5a4805f7-f802-b1ba-9804-59c0fe6c7f26@quicinc.com>
 <92058c25fb11b75ee0a2298a684825e9.sboyd@kernel.org>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <92058c25fb11b75ee0a2298a684825e9.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -epRGd5dQsKoQ_1a-CeHTBo2HvE_JnI7
X-Proofpoint-ORIG-GUID: -epRGd5dQsKoQ_1a-CeHTBo2HvE_JnI7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_09,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 clxscore=1011 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309120100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/2023 4:11 AM, Stephen Boyd wrote:
> Quoting Jie Luo (2023-09-08 04:10:35)
>>
>>
>> Yes, the uniphy implements the clock provider that supports changing
>> rate, which will be upstream later, and nss_cc_mac5_rx_clk_src is the
>> special case, which is only used in the switch device qca8386.
> 
> Ok great.
> 
>>
>> For the phy device qca8084(uniphy has only 312.5M fix clock which is
>> registered by device tree), this clock nss_cc_mac5_rx_clk_src is not used.
>>
>> The issue for the switch device(qca8386) here is the clock rate of
>> parent uniphy can't be changed because of the clock rate requirement of
>> branch clock, since the uniphy clock rate is decided by the current
>> working interface mode(PHY_INTERFACE_MODE_2500BASEX with 312.5M or
>> PHY_INTERFACE_MODE_SGMII with 125M).
> 
> Got it.
> 
>>
>> For example, when the uniphy works on PHY_INTERFACE_MODE_2500BASEX, then
>> the parent uniphy clock rate is 312.5M, which is decided by hardware and
>> can't be changed. when a branch clock requires a 25M clock, the parent
>> uniphy clock maybe updated to 125M by clock framework if the flag
>> CLK_SET_RATE_PARENT is set here, but the actual hardware clock rate of
>> uniphy is still 315.5M since the uniphy still works in the interface
>> mode PHY_INTERFACE_MODE_2500BASEX.
>>
> 
> If the parent rate can't change because CLK_SET_RATE_PARENT is missing
> and the hardware doesn't allow it, then perhaps instead of having a
> frequency table we should have rcg clk ops for determine_rate that
> simply looks at the parent rates and finds the rate closest to what is
> desired. And for the set_rate clk_op we can have it be simple and just
> program a fixed divider. The benefit is less frequency tables that don't
> do anything and less hard-coding of the frequency. I thought we already
> had those rcg clk_ops but I couldn't find them with a quick glance.

Thanks Stephen for the suggestion.
looks you are saying the clk ops clk_dp_ops for the fix parent rate? 
which seems not meet the clock requirement of this clock.

For the device qca8k, it is also possible to switch the interface modes 
between PHY_INTERFACE_MODE_2500BASEX(312.5M) and 
PHY_INTERFACE_MODE_SGMII(125M) during the running time, and there are 
multiple parent clock source(P_UNIPHY0_RX or P_UNIPHY0_TX) for the RCG 
clocks to select according to the current work mode. so the parent_map 
and freq_tbl are necessary to this clock.

such as the following clock table, same parent clock rate has the 
different parent source.

+static const struct parent_map nss_cc_uniphy0_rx_tx_map[] = {
+	{ P_XO, 0 },
+	{ P_UNIPHY0_RX, 1 },
+	{ P_UNIPHY0_TX, 2 },
+};
+
+static const struct freq_tbl ftbl_nss_cc_mac5_rx_clk_src[] = {
+	F(50000000, P_XO, 1, 0, 0),
+	F(125000000, P_UNIPHY0_RX, 1, 0, 0),
+	F(125000000, P_UNIPHY0_TX, 1, 0, 0),
+	F(312500000, P_UNIPHY0_RX, 1, 0, 0),
+	F(312500000, P_UNIPHY0_TX, 1, 0, 0),
+	{ }
+};

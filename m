Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D08793526
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 08:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238122AbjIFGHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 02:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241386AbjIFGHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 02:07:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF3610DC;
        Tue,  5 Sep 2023 23:07:23 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3865knGv028100;
        Wed, 6 Sep 2023 06:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XwnqHZrjEXk32wMzzvgxT0wFIpyLkqsdotf/qrmxZ3s=;
 b=CWy6Lh+WsANgEtBKUsepb0F+Sr6TAO2DX1jOYvPpTSlHccWH54Hi1e5ezPKotXQ5eIow
 os95PXOMDyISR0MqK98gnE2zcDsYesdjw+SLrnbtORI9StpI9sOhb93+yP6na/dgOFhV
 ZvQtLZZXmErVYcy/fPmn9bjzMQZPUpAt6n7Cnkh4YzhWdZQwEZvr/V+C0sLbWRueGWzx
 VlLZQ7F1/mOhD12bVGuy5Vp1/sooH9OifhgE9pD7rBDYo01s7T485Jlyi/6Q+5Vsy90m
 WyAZHmMWqGTC+uxp7gRKtzE6qFd7WSZgHZ6spGtrn0kyej1mg+l5xqZchX6adMpjE5Lf XQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sww32tvy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 06:07:20 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38667J2c021035
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Sep 2023 06:07:19 GMT
Received: from [10.216.33.5] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 5 Sep
 2023 23:07:14 -0700
Message-ID: <22165524-706a-324a-5d3c-83b4aaa0162a@quicinc.com>
Date:   Wed, 6 Sep 2023 11:37:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/4] clk: qcom: branch: Add mem ops support for branch2
 clocks
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20230808051407.647395-1-quic_imrashai@quicinc.com>
 <20230808051407.647395-3-quic_imrashai@quicinc.com>
 <98d0632c-7129-4e3a-aba7-e805e3281f91@linaro.org>
Content-Language: en-US
From:   Imran Shaik <quic_imrashai@quicinc.com>
In-Reply-To: <98d0632c-7129-4e3a-aba7-e805e3281f91@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rU3R9v8C3mx1KS1xG2GYZpwSvD6creZQ
X-Proofpoint-GUID: rU3R9v8C3mx1KS1xG2GYZpwSvD6creZQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=877 mlxscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060052
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/2023 1:27 AM, Konrad Dybcio wrote:
> On 8.08.2023 07:14, Imran Shaik wrote:
>> From: Taniya Das <quic_tdas@quicinc.com>
>>
>> Clock CBCRs with memories need an update for memory before enable/disable
>> of the clock. Add support for the mem ops to handle this sequence.
>>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
>> ---
> Could you expand the commit message a bit? What does this clock
> memory do?
> 

Sure, will expand the commit message with more details and push the next 
series.

> [..]
> 
>> +static int clk_branch2_mem_enable(struct clk_hw *hw)
>> +{
>> +	struct clk_branch *br = to_clk_branch(hw);
>> +	u32 val;
>> +	int count = 200;
>> +
>> +	regmap_update_bits(br->clkr.regmap, br->mem_enable_reg,
>> +			br->mem_enable_ack_bit, br->mem_enable_ack_bit);
>> +
>> +	regmap_read(br->clkr.regmap, br->mem_ack_reg, &val);
>> +
>> +	while (count-- > 0) {
>> +		if (val & br->mem_enable_ack_bit)
>> +			return clk_branch2_enable(hw);
>> +		udelay(1);
>> +		regmap_read(br->clkr.regmap, br->mem_ack_reg, &val);
>> +	}
> readl_poll_timeout?
> 

Sure, will check and use this.

Thanks,
Imran

> Konrad

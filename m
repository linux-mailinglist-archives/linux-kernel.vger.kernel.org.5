Return-Path: <linux-kernel+bounces-21998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B55398297AB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DF328CDEA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131FF3FE56;
	Wed, 10 Jan 2024 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y1nyBdKO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208183C49D;
	Wed, 10 Jan 2024 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A8d37s021096;
	Wed, 10 Jan 2024 10:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BOuDR4vqdlLrDwTrZywpOXtBP0nMFyGMe6C1dwrW9lM=; b=Y1
	nyBdKOB708B5KRgO4tJwiZ46XiN0fs/Rm/lqKQIkFuQGYC2jqlq5OaZAmb7is325
	NJuNBUHx3pa1lgmmBfDwIVMt+Eql7OeEk+euXXDW8IiLxkOoqBdg4LoLRi0AUWUN
	m7s/7aXoLM6CsfzmcSEcL4CQIhWZM7JoDBpQ7e1orczGCs3L2U5iqzIj8F0kVmK7
	lltJ8dPb71pZBK6JXlBS5A2RSo6BBnEcqpapUU2NhjmtYqSytszL+ZmXtHfqoxVs
	IlVLtrNzvEwDHwX2K9y/avNL4iIFQCYzMSwzcFu4xtZac/lHu+4cYrp9iPyokgpj
	oTyZdE9h8cbq8tyYz2tQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhjh2rusg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 10:31:18 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40AAVHv4020107
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 10:31:17 GMT
Received: from [10.218.19.46] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 10 Jan
 2024 02:31:10 -0800
Message-ID: <a242202d-c576-05e8-8726-91dfdbe10e7b@quicinc.com>
Date: Wed, 10 Jan 2024 16:01:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/3] clk: qcom: gcc-sm8150: Register QUPv3 RCGs for DFS on
 SM8150
Content-Language: en-US
To: Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Deepak Katragadda
	<dkatraga@codeaurora.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Taniya Das
	<quic_tdas@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>
References: <20240104-sm8150-dfs-support-v1-0-a5eebfdc1b12@quicinc.com>
 <20240104-sm8150-dfs-support-v1-1-a5eebfdc1b12@quicinc.com>
 <988ae72846dc680382f98b63b61a8c32.sboyd@kernel.org>
From: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
In-Reply-To: <988ae72846dc680382f98b63b61a8c32.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mYmE384YEGN7sGTWGTAr9sk-pnczqoW2
X-Proofpoint-GUID: mYmE384YEGN7sGTWGTAr9sk-pnczqoW2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100085


On 1/5/2024 3:06 AM, Stephen Boyd wrote:
> Quoting Satya Priya Kakitapalli (2024-01-04 06:23:04)
>> diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
>> index 05d115c52dfe..6d76fd344ddf 100644
>> --- a/drivers/clk/qcom/gcc-sm8150.c
>> +++ b/drivers/clk/qcom/gcc-sm8150.c
>> @@ -453,19 +453,29 @@ static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
>>          { }
>>   };
>>   
>> +static struct clk_init_data gcc_qupv3_wrap0_s0_clk_src_init = {
> Can these be const?


We update the ops inside the qcom_cc_register_rcg_dfs. Hence cannot make 
this as const.


>> +       .name = "gcc_qupv3_wrap0_s0_clk_src",
>> +       .parent_data = gcc_parents_0,
>> +       .num_parents = ARRAY_SIZE(gcc_parents_0),
>> +       .flags = CLK_SET_RATE_PARENT,
>> +       .ops = &clk_rcg2_ops,
>> +};
>> +
>>   static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src = {
>>          .cmd_rcgr = 0x17148,
>>          .mnd_width = 16,
>>          .hid_width = 5,
>>          .parent_map = gcc_parent_map_0,
>>          .freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
>> -       .clkr.hw.init = &(struct clk_init_data){
>> -               .name = "gcc_qupv3_wrap0_s0_clk_src",
> [...]
>> @@ -3786,6 +3850,13 @@ static int gcc_sm8150_probe(struct platform_device *pdev)
>>          regmap_update_bits(regmap, 0x4d110, 0x3, 0x3);
>>          regmap_update_bits(regmap, 0x71028, 0x3, 0x3);
>>   
>> +       ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
>> +                                      ARRAY_SIZE(gcc_dfs_clocks));
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "Failed to register with DFS!\n");
> Use
>
> 		return dev_err_probe(...);


Okay.



Return-Path: <linux-kernel+bounces-61602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 372EA85141F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78CE1F22316
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3328D3A1CA;
	Mon, 12 Feb 2024 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Bku+8HiQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F713A1AE;
	Mon, 12 Feb 2024 13:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743344; cv=none; b=Fw2S16MHqL5ik567OqBU3sCq4VcaXfSEDDeHLAzhawDfjx4+ZDH/5628ySQbwHfzkbFF9MWw/p50kOkIbkasQS1f+svaQ0OCvMQInSBiEOTKJSg/F0+xZs/o0ZG5vJoAsgDt9aGnzLPp1p7V1X/sqCBX1Hzre2CUIAbWSw1MWew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743344; c=relaxed/simple;
	bh=4+8+H3nl+15cD2YaDA6YDXi5PnZkRMQeQp9cwmKJibQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=syDMwdzBvFYbroW6qOAqtF6AwMfhZuRE+K7w6Nb0Bi64pAaYxLJf3GzOod6gPQq1kRjMPpeY6Q8iBdVHqeCzq5ttfMDuGZj+iaQXfGU2iHv47hUNFoMr9ZFt6jES0hXo7Xg1ljIwQ+3+JvPn2MgAPoCfp4YBnf2jFtPe7TLot+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Bku+8HiQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CAHalX029712;
	Mon, 12 Feb 2024 13:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6t4tevTqpkCcEqWpuMyBoTR981x6zRAKExlciBinyZc=; b=Bk
	u+8HiQvPAY+nhkSaauDwMcyfq/Cr0+dgW/4IJmtiCr96ycegJiyf+ZNnSLXL2YqJ
	jbvRdTz1z8OWZr2kkHRWvoSnMD1tbh2XB8pICwwYVcwYksKa4mlc21WV6FlUUIBb
	whf6vWmuuOCQ2U/ZpcTyz2WAAdmbeCMS8NA+ltMwUdXb+WC3jsWqMsfEqPiH4Zlc
	EJzsNSTdE3GD4+c4RgOPWI8NABblhHXcXuNGXmHVqvYJ7+3k5jtd599NgIEDyIDN
	cpcQgoEX6eww/4JN6yLlypC3EgUYLOR4ssW2xHszAtZ+b2D/5cWyaZhaWhmq/Gsb
	ppYFsZfE5Fy4Qzpzdepw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7hew8ess-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 13:08:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41CD8u62012983
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 13:08:56 GMT
Received: from [10.216.29.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 05:08:50 -0800
Message-ID: <e5c484cc-7624-40fd-a527-8cfcbf7784fe@quicinc.com>
Date: Mon, 12 Feb 2024 18:38:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] clk: qcom: camcc-sm8650: Add camera clock controller
 driver for SM8650
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Michael
 Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Taniya Das
	<quic_tdas@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Ajit Pandey" <quic_ajipan@quicinc.com>
References: <20240206113145.31096-1-quic_jkona@quicinc.com>
 <20240206113145.31096-5-quic_jkona@quicinc.com>
 <edc9fa59-5f39-4f47-8647-242a9b0a8cb4@linaro.org>
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <edc9fa59-5f39-4f47-8647-242a9b0a8cb4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5py5guP990ylBvUnRKeEv81XkaFUTYwd
X-Proofpoint-ORIG-GUID: 5py5guP990ylBvUnRKeEv81XkaFUTYwd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_09,2024-02-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999 priorityscore=1501
 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120099



On 2/7/2024 6:41 PM, Bryan O'Donoghue wrote:
> On 06/02/2024 11:31, Jagadeesh Kona wrote:
>> Add support for the camera clock controller for camera clients to be
>> able to request for camcc clocks on SM8650 platform.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> 
>> +static struct clk_rcg2 cam_cc_mclk1_clk_src = {
>> +    .cmd_rcgr = 0x1501c,
>> +    .mnd_width = 8,
>> +    .hid_width = 5,
>> +    .parent_map = cam_cc_parent_map_1,
>> +    .freq_tbl = ftbl_cam_cc_mclk0_clk_src,
>> +    .clkr.hw.init = &(const struct clk_init_data) {
>> +        .name = "cam_cc_mclk1_clk_src",
>> +        .parent_data = cam_cc_parent_data_1,
>> +        .num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_rcg2_shared_ops,
> 
> Nice.
> 
> I compared this to WIP for x1e80100 which looks nearly register 
> compatible. Use of the shared_ops indicates to me you've thought about 
> which clocks should not be switched all the way off.
> 

Thanks Bryan for your review, We want all RCG's to be parked at safe 
config(XO) when they are disabled, hence using shared ops for all the 
RCG's.


>> +static struct platform_driver cam_cc_sm8650_driver = {
>> +    .probe = cam_cc_sm8650_probe,
>> +    .driver = {
>> +        .name = "cam_cc-sm8650",
> 
> That said .. please fix the name here "cam_cc-sm8650". The title of your 
> series is "camcc-sm8650" which IMO is a much more appropriate name.
> 
> The admixture of hyphen "-" and underscore "_" is some kind of 
> tokenisation sin.
> 

Sure, will fix this in next series.

Thanks,
Jagadeesh

> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>


Return-Path: <linux-kernel+bounces-64763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA72E854293
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49FC01F24EF0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86C510A28;
	Wed, 14 Feb 2024 05:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KacCDt4v"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5267911185;
	Wed, 14 Feb 2024 05:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707890345; cv=none; b=gVcSIfFu0MWlzk9nmMkRwV6Tg0fuT1NYKwJAXr+ZNxBVFZ5/gZV6GvxV2f1rcfkIj95WUMQroodh4Fryk3wgvfpigkRTWC7h2Fh+9kVqkkKo4AYfmyxpvdNkhuJ9fJanYa6ePX7k4P79vV3UeG+Lb4uAgIgg8nJ6YXOR/mN/oXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707890345; c=relaxed/simple;
	bh=yt5cR8sRNfxAE2BrcvV/xTGqOwh/nhpAq4LH4WO4HXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Tw2t07Xdowt3vi0YVV94H/xaipGQ7MaRt2L0ugtp/IlU+Lh9juR3Klq3f8ppNRUjpFiUvdPhPuyb8OR7bbhsLFsrPe3kx590Y5F3Pprq52fynDYYDMEKRKW6/9rxw1KFe6+RWgCBhPl0bHVXw45JAs+DO8E/lmoSTrd8VZp409s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KacCDt4v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41E5GV8m032216;
	Wed, 14 Feb 2024 05:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=UPUbFMGxqekMpGyBpqMvhSAyTmMWs4IW1Gxf/FboSgA=; b=Ka
	cCDt4vb9wrO5W1TMbxSDFfEHPw1esmd95Q8d4SVfIKuz2PCloskuHM1SwPsfSuPJ
	wjeTBR+ZUSewIcrvqgFxJ+TNNOZmfp4YucPDIAId/PzvIE9zgQDv8w8Sg7LS19uj
	xeFCrSSaSgOemGEjrI7nLgxG2DoRKLXN0KxWNAai/zwutlgtkzer+tUaWes+a0IK
	1cM2e00qeFibqiuWG4K94P+Mgmbwy76QVDY2Q/Tex6fHV8fEkfszmmLSAVkrKeUM
	huhCk0m/2enzmb9kwcQ3hPIcSbgwyP6eqjRyNYio3lzSwoSnlWNTofNSroi1jXBk
	otAY76kHiZ6FxQsDc1QQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w88gq1w1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 05:58:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41E5wv9W022502
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 05:58:57 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 13 Feb
 2024 21:58:51 -0800
Message-ID: <28db06e1-e5a3-4b49-bb7a-fb3fbfe5e5d0@quicinc.com>
Date: Wed, 14 Feb 2024 11:28:48 +0530
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
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Michael
 Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Taniya Das
	<quic_tdas@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Ajit Pandey" <quic_ajipan@quicinc.com>
References: <20240206113145.31096-1-quic_jkona@quicinc.com>
 <20240206113145.31096-5-quic_jkona@quicinc.com>
 <edc9fa59-5f39-4f47-8647-242a9b0a8cb4@linaro.org>
 <e5c484cc-7624-40fd-a527-8cfcbf7784fe@quicinc.com>
 <CAA8EJpqjU-RDwPH6xGLa7xzcyxmU+86mX0X+DL09SJ0uVB5_CQ@mail.gmail.com>
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <CAA8EJpqjU-RDwPH6xGLa7xzcyxmU+86mX0X+DL09SJ0uVB5_CQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sPJKVCWJu9w7pdcXYn3piAzit1h7TF6M
X-Proofpoint-ORIG-GUID: sPJKVCWJu9w7pdcXYn3piAzit1h7TF6M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402140045



On 2/12/2024 6:46 PM, Dmitry Baryshkov wrote:
> On Mon, 12 Feb 2024 at 15:09, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>>
>>
>>
>> On 2/7/2024 6:41 PM, Bryan O'Donoghue wrote:
>>> On 06/02/2024 11:31, Jagadeesh Kona wrote:
>>>> Add support for the camera clock controller for camera clients to be
>>>> able to request for camcc clocks on SM8650 platform.
>>>>
>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>
>>>> +static struct clk_rcg2 cam_cc_mclk1_clk_src = {
>>>> +    .cmd_rcgr = 0x1501c,
>>>> +    .mnd_width = 8,
>>>> +    .hid_width = 5,
>>>> +    .parent_map = cam_cc_parent_map_1,
>>>> +    .freq_tbl = ftbl_cam_cc_mclk0_clk_src,
>>>> +    .clkr.hw.init = &(const struct clk_init_data) {
>>>> +        .name = "cam_cc_mclk1_clk_src",
>>>> +        .parent_data = cam_cc_parent_data_1,
>>>> +        .num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
>>>> +        .flags = CLK_SET_RATE_PARENT,
>>>> +        .ops = &clk_rcg2_shared_ops,
>>>
>>> Nice.
>>>
>>> I compared this to WIP for x1e80100 which looks nearly register
>>> compatible. Use of the shared_ops indicates to me you've thought about
>>> which clocks should not be switched all the way off.
>>>
>>
>> Thanks Bryan for your review, We want all RCG's to be parked at safe
>> config(XO) when they are disabled, hence using shared ops for all the
>> RCG's.
> 
> What is the reason for parking it instead of fully disabling the clock?
> 

We don't do anything explicit in RCG disable, normally when all branch 
clocks are disabled, RCG gets disabled in HW. But as per the HW design 
recommendation, RCG needs to be parked at a safe clock source(XO) during 
disable path, hence we use shared_ops to achieve the same. After parking 
at XO, RCG gets disabled as all the branches are disabled.

Thanks,
Jagadeesh

>>
>>
>>>> +static struct platform_driver cam_cc_sm8650_driver = {
>>>> +    .probe = cam_cc_sm8650_probe,
>>>> +    .driver = {
>>>> +        .name = "cam_cc-sm8650",
>>>
>>> That said .. please fix the name here "cam_cc-sm8650". The title of your
>>> series is "camcc-sm8650" which IMO is a much more appropriate name.
>>>
>>> The admixture of hyphen "-" and underscore "_" is some kind of
>>> tokenisation sin.
>>>
>>
>> Sure, will fix this in next series.
>>
>> Thanks,
>> Jagadeesh
>>
>>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>
> 
> 


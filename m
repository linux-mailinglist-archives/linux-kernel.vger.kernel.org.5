Return-Path: <linux-kernel+bounces-128510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DA5895BD5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9A51F23378
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CFA8495;
	Tue,  2 Apr 2024 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KlD6xera"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16A4219E0;
	Tue,  2 Apr 2024 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712082939; cv=none; b=u70UgAyJOQtDQiv07zXixFUhb8M6JFJHC75myRUNett33HGQqIrk+jskWDe3YyKCsFs26iTLJc/UZRQdgmrZxqdnqJM7kEiG3d6QUbw37i5m325qJJWIxSws9vMs/nGyXzFDeP2DgB4KX3F/w47G/qEjST5PGqdsbsPSfoKEWJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712082939; c=relaxed/simple;
	bh=6iTeA9V6p1tBO/Pmz+o6WiGHGo9CjWuecrmEVBvePM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Dx4eNjc5l6lUs7at6sQRMTlLHOnZx/SPcA+fftoFbze6Ji6nXHbBYPABMrTkLEC9IYidl5rHKPtx/GtcOMWHj80pr/M+QwniqX55ctPOd25CdTCMuDM1gvwJ85tJ99bjp3kPyUHf7l1LIZOrAYDL8xr7Pg0WshIIPtfGhdGJmd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KlD6xera; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432HDuPW014036;
	Tue, 2 Apr 2024 18:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7v9FT9Zi0K8PmmSREucDBeJVDzHRbgSradEMlX0VBHQ=; b=Kl
	D6xeraVuAPidVSYQkdUPslPbXwwlHlC4fZTm7rIp5nsUby2tX8GCjwR6vTiXw8/c
	bxhIEZwS+Lb/uiGqOblqGMnQPIGYOXXgHuu396sanzaiYjGI4/Jfo/keSyqSwDVh
	uGsQxRZjd7jNb5SG0KEaj9u5a01LJr8lheEXPyxV/8VoIMMcHzJrR0xX3JWOS4sz
	4hgULRObkqVwxmwm7pZiYApBAwmVGBABBTCZaaPH7K+faQg/Y7X9qktW048QhlYA
	0eSs71F7eGX18Ud3sDceFozjxXbgxW09qATEMZDbdAdyxFNv7UI50OsPDQQ/igFa
	fcoEv9aJc4GB52pWbMBg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8h5es6qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 18:35:30 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432IZTJN020750
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 18:35:29 GMT
Received: from [10.216.46.192] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 2 Apr 2024
 11:35:19 -0700
Message-ID: <e2f108d8-0b25-d799-fbe4-ab6256966982@quicinc.com>
Date: Wed, 3 Apr 2024 00:05:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/7] clk: qcom: clk-alpha-pll: Fix CAL_L_VAL override for
 LUCID EVO PLL
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        "Satya Priya Kakitapalli"
	<quic_skakitap@quicinc.com>
References: <20240330182817.3272224-1-quic_ajipan@quicinc.com>
 <20240330182817.3272224-2-quic_ajipan@quicinc.com>
 <d8c0ca00-7e14-454e-8a65-5dcf14ed7796@linaro.org>
From: Ajit Pandey <quic_ajipan@quicinc.com>
In-Reply-To: <d8c0ca00-7e14-454e-8a65-5dcf14ed7796@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yH-2pW9lwhdszkxmIWpXzX8fqjEeM4Rk
X-Proofpoint-ORIG-GUID: yH-2pW9lwhdszkxmIWpXzX8fqjEeM4Rk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_12,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=814 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 clxscore=1011 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404020138



On 3/31/2024 12:49 AM, Krzysztof Kozlowski wrote:
> On 30/03/2024 19:28, Ajit Pandey wrote:
>> In LUCID EVO PLL CAL_L_VAL and L_VAL bitfields are part of single
>> PLL_L_VAL register. Update for L_VAL bitfield values in PLL_L_VAL
>> register using regmap_write() API in __alpha_pll_trion_set_rate
>> callback will override LUCID EVO PLL initial configuration related
>> to PLL_CAL_L_VAL bit fields in PLL_L_VAL register.
>>
>> Observed random PLL lock failures during PLL enable due to such
>> override in PLL calibration value. Use regmap_update_bits() with
>> L_VAL bitfield mask instead of regmap_write() API to update only
>> PLL_L_VAL bitfields in __alpha_pll_trion_set_rate callback.
>>
>> Fixes: 260e36606a03 ("clk: qcom: clk-alpha-pll: add Lucid EVO PLL configuration interfaces")
>>
> 
> No blank lines between tags.
> 
> Add Cc-stable tag.
> 
Sure, will update in next series

> Please do not combine fixes with new features.
>  > Best regards,
> Krzysztof
> 

Actually this fix is required for correct scaling for few frequencies in 
this patch series, hence combined them together and pushed this fix as 
first patch in series so that they get mainlined together and feature 
functionality will not get impacted.
-- 
Thanks, and Regards
Ajit


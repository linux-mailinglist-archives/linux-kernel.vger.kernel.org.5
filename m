Return-Path: <linux-kernel+bounces-6561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E77E2819A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870EC1F238B5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FC61BDC0;
	Wed, 20 Dec 2023 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nretrJ1Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0293B1CA8C;
	Wed, 20 Dec 2023 08:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK7gxYh022585;
	Wed, 20 Dec 2023 08:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=I/r5lDb91mnmb3vYOrx+qaFxVLH75viEaNpK/MTGryc=; b=nr
	etrJ1QYhIX5R1iijOWnlXGPxKZt02V6LIooNZuyPvf0ABijR//iFVvfBC8B0W28+
	75p7zBxdBYebsO46yuaUCsIXi+QvFcPaYTItDhS98gjciguIVZ9kMJwI0ijA4CZ5
	S6dFOcyitS3l4Hy4KPjzXMobK0wByOLJvP4m2aXjjf0wT57bj1yFM9fDokA+fLas
	qCenFIWi02a4FjDnCuiyqOXuI/h0L3xfCjIB2I7U4cyFzSqWFGcdRQK4Qd3elXLV
	8pfVm0iMhC8A8mnRXY/Hk3q9Tpw6nvf2vFM2p7BX/f5TS5MLSJ8dP08t7b7yiZy9
	EIXHfbgxRX5zEfLZdxPg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3v3382se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:23:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BK8NWiM009244
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:23:32 GMT
Received: from [10.216.36.155] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 00:23:28 -0800
Message-ID: <a850d4de-ead3-805b-c5d1-701903083ab6@quicinc.com>
Date: Wed, 20 Dec 2023 13:53:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 29/34] media: iris: implement power management
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stanimir.k.varbanov@gmail.com>,
        <quic_vgarodia@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mchehab@kernel.org>,
        <bryan.odonoghue@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <quic_abhinavk@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <1702899149-21321-30-git-send-email-quic_dikshita@quicinc.com>
 <20690d50-5f76-4371-97e6-dcee717ba935@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20690d50-5f76-4371-97e6-dcee717ba935@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JsTIpkYLsC429TD24AKUDx-cPwefFv2p
X-Proofpoint-GUID: JsTIpkYLsC429TD24AKUDx-cPwefFv2p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=796 clxscore=1015 priorityscore=1501
 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312200057



On 12/19/2023 5:54 PM, Konrad Dybcio wrote:
> On 18.12.2023 12:32, Dikshita Agarwal wrote:
>> From: Vikash Garodia <quic_vgarodia@quicinc.com>
>>
>> Hardware specific power sequence include programming specific
>> sequence of registers. Implements this sequence for iris3.
>>
>> Introduce video device suspend and resume using runtime PM.
>>
>> Also, implement iris3 specific calculation for clock and
>> bus bandwidth which depends on hardware configuration,
>> codec format, resolution and frame rate.
>>
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> ---
> [...]
> 
>> @@ -97,6 +103,7 @@ static int iris_probe(struct platform_device *pdev)
> return dev_err_probe, drop __func__
Sure
> 
> [...]
> 
>> +	ret = readl_relaxed_poll_timeout(base_addr + reg, val, ((val & mask) == exp_val),
>> +					 sleep_us, timeout_us);
>> +	/*
>> +	 * Memory barrier to make sure value is read correctly from the
>> +	 * register.
>> +	 */
>> +	rmb();
> just drop _relaxed and return directly
> 
Will check and do the needful.
>> +
>> +	return ret;
>> +}
> [...]
> 
>> +	ret = read_register_with_poll_timeout(core, AON_WRAPPER_MVP_NOC_RESET_ACK,
>> +					      0x3, 0x3, 200, 2000);
> that looks like a lot of bits/bitfields that deserve #defining in this
> and some other functions
> 
Will check this.
> Konrad


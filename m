Return-Path: <linux-kernel+bounces-127307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DD2894975
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00711F24660
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDC11401C;
	Tue,  2 Apr 2024 02:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i2J4cyQl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E308310A0C;
	Tue,  2 Apr 2024 02:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024968; cv=none; b=Nv9MrRzFXzGxG8B61uMn/1oZ3swysUV1EXbOsDklxxj2nEvaCrnMDnmIPGu0sT0uerJ16ldUVa0QLn+eGn6tIBmQf2xyjrzbQPb4XKqmrV7yBJtcmfBcwI8kODMEuFxyVyVlhlKfUEwNeosSvn4Z0RfEB/r5WKkB8Fp/Ac9ERnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024968; c=relaxed/simple;
	bh=YOK3Vrm/GjP8UTcwVyHRIUVeZFsT2y0pds17HFYM7B0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d8r8flzyngc6fsUb9JMPfmKpaGLvBo395GwiI9BPoycQn/qQ8GfyQm6O/DZuorokOhLvDrYLRYrxAwj4igKZWJuE+WdAxtO1QjA7OxFkrBMzHtaPvDtPNPD5QZ7mXGj9iDXvjxvSDvPz+rxgeKJAkQE317+RJOLZ+aHIfemt4QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i2J4cyQl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4322Ek4p030833;
	Tue, 2 Apr 2024 02:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=J0U5+iwHb3WLKeAZmMsk0vPiVfr2dgan3DXVTFIviw0=; b=i2
	J4cyQllHtOCNDys8BNxI03gVhIGuuOjPIBYWeBueV3/joQkXn+SFnmdEWVPYg88y
	5wcYgg3cvziMeyPLdO6WIB6RBHU7+KOPEkTGl3d54EG46jpiIMm3HGsNwxW6lpJR
	55jCUOE8c6yMnT9VYwhuHN1D6BwBELf7N/9Ks48LX7DiQLpoQugBBdc2rZ6XPH/j
	FJw2Q9Zv8nB22nd4z3uz9XMKFo6MSJnmFuphaJ1WaR4hMBDAFYHUSKgTrzBM+K84
	YJ+6kpAuSFVctcwqonKDjh2V8t0NUaPblcJv2pbFVd2YwtBQ5y/7TI7HIlACYJMy
	s3EMUkxu4Yzq7/MxZ7xg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x87um04b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 02:29:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4322TEAO024929
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 02:29:14 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 1 Apr
 2024 19:29:08 -0700
Message-ID: <2d35eb0c-2a89-4e06-bb29-b4a9fc531446@quicinc.com>
Date: Tue, 2 Apr 2024 10:29:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 RESEND 0/4] arm64: qcom: add AIM300 AIoT board support
To: Trilok Soni <quic_tsoni@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <keescook@chromium.org>, <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20240401093843.2591147-1-quic_tengfan@quicinc.com>
 <31f0b5d2-5b92-cc74-68bd-94fd42527a22@quicinc.com>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <31f0b5d2-5b92-cc74-68bd-94fd42527a22@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: enCqBDIQHpnahHhM2nzKGhjfa96sj9ij
X-Proofpoint-ORIG-GUID: enCqBDIQHpnahHhM2nzKGhjfa96sj9ij
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_18,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=840 adultscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404020016



On 4/1/2024 11:54 PM, Trilok Soni wrote:
> On 4/1/2024 2:38 AM, Tengfei Fan wrote:
>> Here is a diagram of AIM300 AIoT Carrie Board and SoM
>>   +--------------------------------------------------+
>>   |             AIM300 AIOT Carrie Board             |
> 
> spellcheck
> 
> s/Carrie/Carrier ?

Thanks Trilok for pointing out the problem here, I will correct this 
typo in next version patch series.

> 

-- 
Thx and BRs,
Tengfei Fan


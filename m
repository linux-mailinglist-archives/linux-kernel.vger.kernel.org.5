Return-Path: <linux-kernel+bounces-122064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D53A88F16E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5903329F4CA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A325B153BCB;
	Wed, 27 Mar 2024 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q1A9XLWL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EBF14D2B5;
	Wed, 27 Mar 2024 21:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711576616; cv=none; b=j2e9y9CC0NJ3xgPsO4Dj3zJFlU5nNmSGMM9X1DJTAKFJF2Pcqk3Izdf5XbhejsP07vgZbf8R1OuOk13gUFUKpJ2YejiMQdE0rRxN+Fs9FOLMyqHQckZJu73hdesXfX/dYvE0NUSLRAn5znogWdkR/HC5ivJs0HjwhFZYmuU2Png=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711576616; c=relaxed/simple;
	bh=ISq7nL0MCjV0q2xYanA81OaMJO+3t4kSdLr8g3E1Nyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mS9GeIsPqT/H3xU3N5QzG8Nhm8iGdHFYdjInFPP7JSOJ7uzCynBSf5d9kzU2j7cJxKax/CCe2V30TVl8WVB7UUYjDFyGzU/oaCvrIC7TJlVYjl1gfjbc9kMhaXROLC2sPyKcUzv+FrAV4m4tGwXfXw8lVBKE6AJ6fyHBZPua8Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q1A9XLWL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42RLmDJZ019592;
	Wed, 27 Mar 2024 21:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vv8xA4/mVYkR+YakQcsUhlKG9wQSF4c/gv/+lZU9rLw=; b=Q1
	A9XLWLkht511vU9Fic9Yp9rvGCpwHEWde8nV/HR6/F7fpVZwIgoDDGJqJNyz77BD
	NkOVrveQeJxfxBUwERSOxaW+pNe4tuRV/SQQbD41tddYGoV5hJ2KbYZuLn6wldrE
	xM6aHpXMLV5hnfHlGnjddy08hWIEl4cXSTF5e/jEPPnyXUJJnnKDETrPammsAetO
	DVBkATTKMCqCxkcKE/OId2qV8+5KJmhQuDkQQQ8Ajoa2geSGCgq5iegPSrgEsRiH
	mS4mg5ZOc+InGPtdysbOzNZQ7/HOtrMz0kuqTNeiaKb9qzMnok5gg3v1XT18iia+
	pgszRl2OVERzlLMFJHAQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u208389-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 21:56:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42RLunV9030345
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 21:56:49 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 27 Mar
 2024 14:56:49 -0700
Message-ID: <258a3863-36ce-4f07-a1cb-a28673ad1f17@quicinc.com>
Date: Wed, 27 Mar 2024 14:56:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] wifi: wil6210: cfg80211: Use __counted_by() in
 struct wmi_start_scan_cmd and avoid some -Wfamnae warnings
Content-Language: en-US
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kalle Valo
	<kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
References: <ZgSP/CMSVfr68R2u@neat>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <ZgSP/CMSVfr68R2u@neat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qWe04CBVAaAy2kQTpNuk_ALUq3tMYgW3
X-Proofpoint-GUID: qWe04CBVAaAy2kQTpNuk_ALUq3tMYgW3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_18,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=717 impostorscore=0 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403270156

On 3/27/2024 2:30 PM, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time
> via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
> (for strcpy/memcpy-family functions).
> 
> Also, -Wflex-array-member-not-at-end is coming in GCC-14, and we are
> getting ready to enable it globally.
> 
> So, use the `DEFINE_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warning:
> drivers/net/wireless/ath/wil6210/cfg80211.c:896:43: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Link: https://github.com/KSPP/linux/issues/202
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>



Return-Path: <linux-kernel+bounces-122068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B0D88F175
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55E89B22881
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A8C153BCE;
	Wed, 27 Mar 2024 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GkaiEv3D"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A04C153822;
	Wed, 27 Mar 2024 21:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711576656; cv=none; b=axLo8ZDkgruAlfX8M5pcbG1uvly+vamWSqfG9lGMBlZlE9IUOzJKKG2Jn9QJiop5oMQfnM9Z+3LtCj4OHcN6/uPklvC849Nqm+Lf9LU4khpwvxgQVBKDEGfnW5W3D8CSVPC4EXeL5393SxmHpQwIPoWrDiLalcz3+B5o6rItlf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711576656; c=relaxed/simple;
	bh=No9c2+vWYCBWwMnt1dM6LzgpdTAP4Nv0ncW8x+hZVig=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=izdrgeY6eMVTZkbhIO+XCHDgTFfh+M0sKDYXOt26gouAD6pdT0huLQk+TEyddfVXx0DrRWucdeAQGTck+ekdytigmB5z+56Wf6VCV8Cfr7cArLIAHltBZRiA0g+nmCmiCBDq5E71bgCSUn7zLayPRxZemeA5SO9WQsgKi0JiZLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GkaiEv3D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42RLlfd3001052;
	Wed, 27 Mar 2024 21:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Cmxj55j51YjAMBIJuwAO3+RXfWLP8G52XXR5VHzeqRc=; b=Gk
	aiEv3DU3VSnOodCokzWrKLziZzQr67O7C2d28Y5NBCf0CD9+4+wyXJRFCe/fMw16
	RpYGD4i5d6iigQl+Eb7MTqvOrSKckzHMhTvZX4wbsCyDfpJIRvALdHZHmofXcTgd
	L4E/Gx1DapIc6UkpJuK17Nthg03+7i/KsUjj1YjT2jRmm/qk1G1W5mSra86G20Kc
	VgWCo4u8rOunaf/fVPX2cjFzTsWbBhFBFGVBka3oDbbvTw/Ob6QaNQFTiNTpdTaW
	1CmNUd+CECX2Zr+TDJHBAF+xwG0cRulvrEO9JcZr3o/GoIQMh0ux0oLPR/Uj4AJN
	GVhQ1VZ5xKPxEpdLUcoA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u1wg3dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 21:57:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42RLvUws015428
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 21:57:31 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 27 Mar
 2024 14:57:30 -0700
Message-ID: <a90d43dc-144c-4fe8-9cea-0d765d5de131@quicinc.com>
Date: Wed, 27 Mar 2024 14:57:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] wifi: wil6210: wmi: Use __counted_by() in struct
 wmi_set_link_monitor_cmd and avoid -Wfamnae warning
Content-Language: en-US
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kalle Valo
	<kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
References: <ZgSTCmdP+omePvWg@neat>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <ZgSTCmdP+omePvWg@neat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uomM1ntEBt3dv-cNukiQYASJrkEzr-gE
X-Proofpoint-ORIG-GUID: uomM1ntEBt3dv-cNukiQYASJrkEzr-gE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_18,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0
 mlxlogscore=763 mlxscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403270155

On 3/27/2024 2:43 PM, Gustavo A. R. Silva wrote:
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
> drivers/net/wireless/ath/wil6210/wmi.c:4018:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Link: https://github.com/KSPP/linux/issues/202
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>




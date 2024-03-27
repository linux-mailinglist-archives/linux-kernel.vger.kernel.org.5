Return-Path: <linux-kernel+bounces-122005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175F588F093
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DC83B20FFD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE6815356A;
	Wed, 27 Mar 2024 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HzExBfGA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86E215351C;
	Wed, 27 Mar 2024 21:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711573283; cv=none; b=lli4/f7bJ2bP6EoDdlrkHoHEy3S5ZGhYjyJ6QTHuHPsXl1dAyamqQbZRJ7vTWO4OCjd1bA5b+V256YVNBou6RrEum+o1OmXIxiLeUobitmHzR2O33hY0v8Nr7kRnecj/uWL9fiYnxPn8LRcr6d3L1WHkYtB/ny4BN04vlUoJypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711573283; c=relaxed/simple;
	bh=OPurRJ5xp6aX8HKk/buUQYjAT54YFne/0QOnhHJzkRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sqmaXQlJZx/ISBPVNj7cnwUje0848WkSFV9m3dFs0gIevTLTGnhktKEDQeAZ7JchWqmzycTzzdhOKfCTeu8qlaBzCqRcld3RM4YJ83+fU8xDVs5H77mx+FpTuMQ+iUGUDl06WqVy52TuREOz7AO8oAjTeloaBO8yHF/64V/OeoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HzExBfGA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42RL0BDo018853;
	Wed, 27 Mar 2024 21:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xmtVpysrBXcgF+Pog62RluWsO9TEDjl7iMQWHnudVBY=; b=Hz
	ExBfGAzeo8rFS6NU2MB68p2l2/IdaEJuJbbt/r53shABVELEOid8vVo9CIPrvMjp
	YOvcrk6w6OP+q3BP+du/kryKLUU2fVMNOAq0p8SLsu4P/HYIb1F+gDzwoPIz+qKh
	yxyY3Cu6sVrUMV3Sn4s3e2Hg3hjx+dk+FIipLxLbF7H94OiMjyDkLchTj0F5xrC8
	K53Gfk+0Oj4b01lMFTRh7IiW3xlu6DwRZc9AxS/nBq+8B6kwW68C1ixtawKD4BeZ
	ixyYxzHZpPZxDXW+zMlCAWrMc1t+1/wEkmh77hX3rdRb1mzkT7FBYhfFSsJ5Rhdp
	HF+0BdYI+3p0lJQ9EXfw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u04r033-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 21:01:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42RL1BWK029439
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 21:01:11 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 27 Mar
 2024 14:01:11 -0700
Message-ID: <dc556824-d499-430c-850e-fb0ca55dd5fe@quicinc.com>
Date: Wed, 27 Mar 2024 14:01:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: wil6210: wmi: Use __counted_by() in struct
 wmi_set_link_monitor_cmd and avoid -Wfamnae warning
Content-Language: en-US
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kalle Valo
	<kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
References: <ZgRsn72WkHzfCUsa@neat>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <ZgRsn72WkHzfCUsa@neat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -42v3xr_7ZE0RIUA4Hc1HvCqp3LbjyXW
X-Proofpoint-GUID: -42v3xr_7ZE0RIUA4Hc1HvCqp3LbjyXW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_18,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=807 clxscore=1015 mlxscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403270149

On 3/27/2024 11:59 AM, Gustavo A. R. Silva wrote:
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

That DEFINE_FLEX() macro takes a bit of time to understand! But I finally
digested it so...

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>



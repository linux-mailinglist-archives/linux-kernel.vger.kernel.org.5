Return-Path: <linux-kernel+bounces-109069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EB1881443
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52842816B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC58A524B7;
	Wed, 20 Mar 2024 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Kt8qapt7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2034DA1A;
	Wed, 20 Mar 2024 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710947592; cv=none; b=M5sgx/b7cyzL0N1FIVd15prj0hUTc0eog4JJD4DfM//CcyEp2OABRqq5X81lzxdumf1LD2JMa8v3yFwdPbGw8DzK9wqRu6ZsUbpV0irSRMRvByUZkyhoLv6HvXfkOLs7qCYhbMisbcEa4aRG58hArOSD0zEMyU5cJb4FKbKs0/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710947592; c=relaxed/simple;
	bh=pcGxRvY/FbBvBlq97QB2rq5HTC92beOMYNwfDm8kMEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OD7RrS4V8MKoDpw5nXgdIDBg/9xrQ+fyPpeBuTtAT1UPYEI3t5L2KiDuEl++tYxG0mfKzG7JHNvYeG4Pv/mYz8V0a5D6B1m+qyHlbFnfl57QSJJynnRZpumFZa06XZjSu5Q5vHbh73f04zom5r30DcwIe1VmpylCE6DDPtm5KRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Kt8qapt7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KEk4k5003864;
	Wed, 20 Mar 2024 15:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=D1YOUigZ032H/1z4ozAs2t77AHgioIzVm+TtWp1zuOo=; b=Kt
	8qapt7ufd0OQx13srzzsbnT9KvPuHggjZiFmhQWTtpzZ7fuYLIb4wkGrmqX6RGDG
	Rc1duXWK14KJjXhdOX62pJBvfoEA9E/TgHfCkKcSHudS5m3/aTtMiFo60X01uBuv
	thB47g7Ct+V6vzwji5jyArPCnt9asMr+hhNvI+WewvdeQmp2j05vAwbuCjLgOoNw
	jQeYJf6GtV3Kl/LUkhMsle+uZ52t82m9xTk4vV62uUVDOFu54XR6/dz1oC/X4C+H
	bozfSe/O2mmTCdURveUvk5LMMHoXYmNVn7vHslc3ah4rA33EGkZW88oVYoXJiGUd
	bUgCcZxUWKP6qtYKCGkg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x01br85fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 15:12:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KFCl7l027483
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 15:12:47 GMT
Received: from [10.110.120.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Mar
 2024 08:12:47 -0700
Message-ID: <9fcdb857-da62-4832-ae11-043fe993e4ad@quicinc.com>
Date: Wed, 20 Mar 2024 08:12:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath10k: allocate dummy net_device dynamically
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, Kalle Valo <kvalo@kernel.org>,
        Jeff
 Johnson <jjohnson@kernel.org>
CC: <kuba@kernel.org>, <keescook@chromium.org>,
        "open list:NETWORKING DRIVERS
 (WIRELESS)" <linux-wireless@vger.kernel.org>,
        "open list:QUALCOMM ATHEROS
 ATH10K WIRELESS DRIVER" <ath10k@lists.infradead.org>,
        open list
	<linux-kernel@vger.kernel.org>
References: <20240319104754.2535294-1-leitao@debian.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240319104754.2535294-1-leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: q7s0hFZrLjK3gu1dnGtitAhln06Gey-B
X-Proofpoint-ORIG-GUID: q7s0hFZrLjK3gu1dnGtitAhln06Gey-B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=943 lowpriorityscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200121

On 3/19/2024 3:47 AM, Breno Leitao wrote:
> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_device from struct ath10k by converting it
> into a pointer. Then use the leverage alloc_netdev() to allocate the
> net_device object at ath10k_core_create(). The free of the device occurs
> at ath10k_core_destroy().
> 
> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

NAK this based upon the ath11k patch results.

As suggested there we should just use kmalloc/kfree to match the existing logic.

/jeff


Return-Path: <linux-kernel+bounces-99507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE5F878965
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C3D2820E0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1785677A;
	Mon, 11 Mar 2024 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JHns6zg0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819D853E2C;
	Mon, 11 Mar 2024 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710188726; cv=none; b=fu9rzqD4n7PkyS9PuYhaY3l5qpR5gb1ZuqrE2ct06QtwwiHNmaLV0dhOZarFmoIa7rBXQnXMpHRoRcawykCsPcewelWFAXD9FHT8tYKqSuNR9Px7Mb/MgBviklmdM9F8yPzrFnSufz6k189IgrQz220d6xrd2suGce6y8jOphHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710188726; c=relaxed/simple;
	bh=RbttMjg1t8BnCBFxgoASfbncHtXvw7RIxtm4H3RaysY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hq0NMDl548XNRYkF7u/8jS5/22q1NnMEbAI4rKQx8SbgkqGaoOtSbT9MD3DpYCybp02YuFzhciK8ZhC+4lLUkAh6ZqGkAjbverOzhBdXdLtMN6Y7Bk7zSjXw455SMPXjmJGIFrNSdBaFWToZl3lmhuVCp0APlXzvQ6YSNZIx34Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JHns6zg0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42BIh59i003636;
	Mon, 11 Mar 2024 20:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xgX5sbGPX/6nBM30K+ygSCYUNLuoYQieQqABdvNGoeY=; b=JH
	ns6zg03lnhJi+s4CuJ6YxeOM8xZFiIbb+P1QZWoTZUIzoBisINWhGVOxLLi3JhAB
	lBdbAAkvQrOpHwz0honOxs/X9khusB6Ug9t1YuISzDZ9+mlvOgtn6WxPymBAr0d9
	akcsg75CP/5fz/Bqz0RbIS+XxTcwxXlkfkLVhPirea7FKGaChFf8Y1u8ICb9egDG
	QATfhGa666jXX7Al1D4EQGtXNvvUpNm1ijZxY4tQe+n4oC2mqBcxXDxaSh6EqkDy
	wNNKgqklVkettwUIRA843nhCAxPlHn1UEW4Qqg1QDfd6Qz/mIYva07yxFiQcAZyo
	L5jOcxyf/D3RC8asNOZg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wt1dwhbvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 20:25:19 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42BKPIZJ032598
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 20:25:18 GMT
Received: from [10.110.9.215] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 11 Mar
 2024 13:25:17 -0700
Message-ID: <05d1f2e6-42b4-4ca5-92ec-838da492d845@quicinc.com>
Date: Mon, 11 Mar 2024 13:25:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of: Move all FDT reserved-memory handling into
 of_reserved_mem.c
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240311181303.1516514-2-robh@kernel.org>
Content-Language: en-US
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <20240311181303.1516514-2-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0vGEOSypj4MgMG8WyGOW-I88YXz1KgiC
X-Proofpoint-ORIG-GUID: 0vGEOSypj4MgMG8WyGOW-I88YXz1KgiC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 mlxlogscore=689 spamscore=0
 suspectscore=0 clxscore=1011 mlxscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403110156


On 3/11/2024 11:13 AM, Rob Herring wrote:
> The split of /reserved-memory handling between fdt.c and
> of_reserved_mem.c makes for reading and restructuring the code
> difficult. As of_reserved_mem.c is only built for
> CONFIG_OF_EARLY_FLATTREE already, move all the code to one spot.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>

> ---
> Oreoluwa, Please rebase your series on top of this.
ack
>
>  drivers/of/fdt.c             | 123 +---------------------------------
>  drivers/of/of_private.h      |   5 +-
>  drivers/of/of_reserved_mem.c | 125 ++++++++++++++++++++++++++++++++++-
>  3 files changed, 127 insertions(+), 126 deletions(-)


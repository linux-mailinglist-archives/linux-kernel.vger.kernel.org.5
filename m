Return-Path: <linux-kernel+bounces-79293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECCE862072
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F3A2869DE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD5F14CAD0;
	Fri, 23 Feb 2024 23:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oHxMGfpt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407F41419B3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 23:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708729311; cv=none; b=px4iwqZtn100ybiesA4XCyFY5hYMN1fKgnFkNZc+PlaF4luM9aFQEyih0NN5kAnG3TRLNg+k3OtuwX5EDDcJVnYIbdOTQ9luD9RFDbTLkEiZMKwrcJBrmyq1xhKlcxL7b1U9xppj3zr7fe5vjsckh0+ZsvQBk8Bd/85D5bB5vcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708729311; c=relaxed/simple;
	bh=1dzYoI6vsrDa7JlZXic4EvXzSRWdhN9Vw6gw8Uo8reM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=njfeD7koZN1B5q6UuiAWR++772iv/TxMfsCYVoxfck0J0oZGiuAJZ2DCpdTIdNfHnwrNE6pgSye9x+S7l6/YhY/60yk/htGGV6vv0mDpqhmTXLH9tfib4mfFiG9JgmG2jcUfiyWE+ixHCzzMfTkBb43u6Z4u4B/aylU1b0c4yIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oHxMGfpt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NN1RtX009389;
	Fri, 23 Feb 2024 23:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1NUNV1Y+ZYRptTs/BTDov/JdcwW4BdHz5V7oyY4rvoo=; b=oH
	xMGfptbGCDtRqjvx2bhY90qTZeTuxeb9LC0exUzR1VRCclNqBGsKEypdAvT2nfWu
	109W11aFBmr/v6Kv29sEXLtVHio6RI2uFKJWGOBru+OtE7oVD826nRjwpmxeix9y
	2I8btNIiBUze6P23TeYYykUkjWM65t2a760PRfbImuXXDITbWt23eymAIWHPakqb
	Zyovz0+UEtYO2iKmmnT/8INvdVEgd5xB/mrl+BeN0C1aRDUdARUNm7bQuV97rS/4
	Kc7NaJ7HDUCvPqgmvo3Ktkt+X1kLtGXVGLx3X2iEGlqcRuSSKk+noRykJ/AmXGez
	AOLNygTnWPyNNs2zhBKQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wekvet9uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 23:01:44 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NN1hjb030369
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 23:01:43 GMT
Received: from [10.110.73.113] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 15:01:43 -0800
Message-ID: <7f24405e-8133-7f9d-65f2-bf13b102a616@quicinc.com>
Date: Fri, 23 Feb 2024 15:01:42 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] accel/habanalabs: fix glbl error cause handling
Content-Language: en-US
To: Oded Gabbay <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC: Tomer Tayar <ttayar@habana.ai>
References: <20240220160129.909714-1-ogabbay@kernel.org>
 <20240220160129.909714-5-ogabbay@kernel.org>
From: Carl Vanderlip <quic_carlv@quicinc.com>
In-Reply-To: <20240220160129.909714-5-ogabbay@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dMGpfzdpMaZk4oHdln5RjBC-pDxlZEtO
X-Proofpoint-ORIG-GUID: dMGpfzdpMaZk4oHdln5RjBC-pDxlZEtO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 mlxlogscore=860
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230165

On 2/20/2024 8:01 AM, Oded Gabbay wrote:
> From: Tomer Tayar <ttayar@habana.ai>
> 
> The glbl error cause handling has a wrong assumption that all error
> bits are consecutive.
> Fix the handling to check all relevant error bits per ASIC.
> 
> Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>

Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>


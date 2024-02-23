Return-Path: <linux-kernel+bounces-79301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4444F862085
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46AC1F230D5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A0314CAD8;
	Fri, 23 Feb 2024 23:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XsypZTE1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E956610A33
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 23:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708730148; cv=none; b=LZF1TGHTq5dMi9woVoyp61pwSdHk1CTRUlJTuNwpmdYB0fYQrq1EYdufhQJzGEZQ3GLmm5iMiB4ryyolSPkDQLllbZ5JjsGERxRGnhkuuTENq6L6Nst0VtXlpc6v/yv4wic9cQCsqOSsJJNlncx9/zYDAn4yi7v+bdoqQNLtbfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708730148; c=relaxed/simple;
	bh=v4VaZ24+ya/xTYjAv0y5MGmLqkYZdfBCy0mPEZDGUY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U679iOgHdui147804o5zNjTASvV5zmRDUc67nCB4ve4uuQTLJon1U2iYxHn9qzL85lGWfAyHWN84ZnOLOO/aXjCnGIzbpDG8FM34FbdGMBi0GGk0EK/im8og7OkD9Z666oaBNKFPja69qZSgFiyj+BN+pdEsfQzjG+duSscKUfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XsypZTE1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NN1YoD017456;
	Fri, 23 Feb 2024 23:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GyRl2E8gSNNOEpcfXOyStqtYToQ9A1FCKJQFTeGxW+A=; b=Xs
	ypZTE1qgr2QA949pNix8w85WP82pGt0t/jngontOjJURpW/UG59r8AKZdjJWcq/r
	a7VcnKslpEOYJrl/ZlYZw2sVjztoD7acDqzFns7h8tyMJMZXqaSOiyTWjVw9Bv/L
	quDqBZ6z+3nN8h/7Ld677J8jRX9rLwVOuFADgnVZiePSLSkTdwAvhD3ENCljvWcR
	QiyPHaYr/gu602sBRbFJkavncZjUHVXVk2hmquAAvgOYqekMMwvfmXsGTJYTn6Q5
	ibyWlmYJDzayjzhgsvl8Rb89wbkt/Y2enjI3svsQ/L2N1wfmDyMXdrA5cuBrJj/i
	HwsbuImeRUSGWksrs8Sg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weytjrmme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 23:15:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NNFdsS011868
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 23:15:39 GMT
Received: from [10.110.73.113] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 15:15:38 -0800
Message-ID: <b4ad0ecf-fc9f-337d-f18b-382d04c07de5@quicinc.com>
Date: Fri, 23 Feb 2024 15:15:37 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] accel/habanalabs: fix error print
Content-Language: en-US
To: Oded Gabbay <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC: Dani Liberman <dliberman@habana.ai>
References: <20240220160129.909714-1-ogabbay@kernel.org>
 <20240220160129.909714-8-ogabbay@kernel.org>
From: Carl Vanderlip <quic_carlv@quicinc.com>
In-Reply-To: <20240220160129.909714-8-ogabbay@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sts7Vh6QSQ_h7OQ9B3YHEMZqFTPjlZ4W
X-Proofpoint-ORIG-GUID: sts7Vh6QSQ_h7OQ9B3YHEMZqFTPjlZ4W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=711 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230167

On 2/20/2024 8:01 AM, Oded Gabbay wrote:
> From: Dani Liberman <dliberman@habana.ai>
> 
> The unmasking is for event and it can be other event than RAZWI.
> 
> Signed-off-by: Dani Liberman <dliberman@habana.ai>
> Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>

Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>


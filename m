Return-Path: <linux-kernel+bounces-145991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4004F8A5DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632091C20DED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB24158D8B;
	Mon, 15 Apr 2024 23:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e0OjPhoy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6642F1B80F;
	Mon, 15 Apr 2024 23:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713222164; cv=none; b=Mxeb4pRHpPmuoWePJbqNckrJ28s1tLh5mOeqyczmS8CfkGyU8cC0KBZfzhyA+Y5X7oV1FzeOfqkLyEJGcNTN3HOWAuLWnJuO1yg0dQgDqlgsffxXaCH8SgBYAW07QmrXQhJy5p++N51xPK+ntfG5OS/4EFFsll0iR6TERXZ4dCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713222164; c=relaxed/simple;
	bh=gxV1Ph97a/W74A6F8z4TFcPgXcQsydxRjPH6L9WEsnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VZyR9DV7SlPoDVflII4NBm69mKGcGY3NcLqn0rMQpHG8PqOEYVVqBVE6ekp0PltOr7mxj7GF9TrnAEov3qrD74MyQBukSNNudwZhTlMrY1R9m6WaPMpG7ImLBhhoX8Aora3gJX/KeM3mK7TqTsilXm8P51shlaEI9t9hoR3xVTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e0OjPhoy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FMVsUa029113;
	Mon, 15 Apr 2024 23:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=LD3APBpY44Us7u2kLbQJnxGyxFIwkWHb8n4qwYdex5k=; b=e0
	OjPhoy3FpYydg6g+DG/PUnjLgce9/CsRDxayh9qMi+fGQcDeBMlakZykGzG7lg8a
	mve33hAee+J8jCLbPt7Zh06irE5stYn9RiP8JSKnJq509FdJzhrYO5M2G87ZOMag
	ddru1sjLE1mDcnY1OcCJBV/xdFS3iETCYAFn22PnN/5cS09qvHeNJ5btM8C/CEkD
	4z/PevbxArsBb68liZ5Mh0cSAM/WAdQqqm9sp1ySRg7l9lwI26UutnSsydrw8FSc
	Q4+9dovKtlzWnnqOGS5KR32V50RDMmfgxjuUktVbFbMWoQ8ENeDRiD8pmVaCrY18
	U1JsmvBAAQsWf3jsG77Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xh25ghqet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 23:02:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43FN2VHF020789
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 23:02:31 GMT
Received: from [10.110.3.16] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Apr
 2024 16:02:30 -0700
Message-ID: <a4e7ae9c-aaae-4f62-af2f-e7c58e65d465@quicinc.com>
Date: Mon, 15 Apr 2024 16:02:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: Fix error handling in
 ath11k_wmi_p2p_noa_event()
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kalle Valo
	<kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Kang Yang
	<quic_kangyang@quicinc.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Kalle
 Valo" <quic_kvalo@quicinc.com>,
        <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>
References: <07f1fc75b2d5b4173ae1b7bb1da5be7f6fc608c8.1713212781.git.christophe.jaillet@wanadoo.fr>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <07f1fc75b2d5b4173ae1b7bb1da5be7f6fc608c8.1713212781.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _vjyx1FuakXJ5kezIV8e6P3iLy7hZPF3
X-Proofpoint-ORIG-GUID: _vjyx1FuakXJ5kezIV8e6P3iLy7hZPF3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_18,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404150153

On 4/15/2024 1:26 PM, Christophe JAILLET wrote:
> if (noa_descriptors > WMI_P2P_MAX_NOA_DESCRIPTORS), there is a mix of
> return and goto. In such a case, 'td' should be freed to avoid a memory
> leak.
> 
> While at it, change ath11k_wmi_p2p_noa_event() to return void.
> '0' was returned in all cases, even in case of error and the only caller
> does not handle the return value.
> This is also more consistent with most of functions called from
> ath11k_wmi_tlv_op_rx().
> 
> Fixes: 2408379f15a1 ("wifi: ath11k: implement handling of P2P NoA event")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



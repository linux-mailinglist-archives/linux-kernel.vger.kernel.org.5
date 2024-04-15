Return-Path: <linux-kernel+bounces-145536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 777618A5785
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD521F21344
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D615C80635;
	Mon, 15 Apr 2024 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lOBwJbrm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2A242072;
	Mon, 15 Apr 2024 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197938; cv=none; b=q7VVSkmsO8MFhSeYx/kKk9rXBOYB+Q165STHHEAbNsJfkS+JK/lRkiSbytxk32/va/Kh5QhwUcKReIpxCA28xeFcnPizDmwNkCNQoAKohm603KTJR7Nb9t7vXKwQdbk4JamaSLtJiBN7EOllos9K+VtT79z2iYwHphUjwqoXEco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197938; c=relaxed/simple;
	bh=HRZ16pcKTsXfvuhSnVWDJ8KSOEd3+F59Kb2TPzi/bZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V5Tb4k4/d66aBrjfhxIpZ1NQ9dlyZmEWiMbn+iTXVqvQGcc94BBh1HvMG4Zke6Z6uLTItSdkKqGsSwB2oZtT37irJAQfO9Rh90jpWxwRJga4qlgliiKkSNHtyFkBpHPJ+gJsuTX+KnzNT5Nv5vDl71As+lrazlCd4n+ULuoUTx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lOBwJbrm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FFNNSG010273;
	Mon, 15 Apr 2024 16:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=sZS5PybUDH+WqH6Sa8LywzS+Thk1uLag0/bFVQZopgY=; b=lO
	BwJbrmnPXVU9u/Egkt8hJVnr1nt+D4hdseeSRvCl48NLaQAEv/Eu8sRxvQZ5Vklu
	XtwLWEwtWUSTdgtyW+2uyH8dgColntQJW5AqQa+ssFjSiJr7tGhFsRwIqKQzQ4re
	CKCVMYUGAMxV9DHRtOcGZu0c43fpNJ9XHPC2g6N8UwVS2U9Xkdma/ubp5sqomZBQ
	qc2ZaYw6sdRD5WuDnGVd1IZ8chfuvssrki3nm4uIeDtITWO85ne7xDA8OzfXhSln
	04OaEfI/Eo1TFiaAb/q7MZpg26Eex4xmUg7SL1U3K+Vab3efTSr7T0ZLDFJJIyCB
	aTuyJevxiLr45SMPUW4A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xh25ggx4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 16:18:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43FGInwj023178
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 16:18:49 GMT
Received: from [10.110.3.16] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Apr
 2024 09:18:48 -0700
Message-ID: <b4c8a18c-286c-442f-a7e9-d4a0bb604083@quicinc.com>
Date: Mon, 15 Apr 2024 09:18:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: Fix error handling in
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
References: <6ee80f65f736db1646f6f201f60816cf35b6f3fe.1713180046.git.christophe.jaillet@wanadoo.fr>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <6ee80f65f736db1646f6f201f60816cf35b6f3fe.1713180046.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: su9nS6VNfgFs0jlq66M3IlcC0Ecc_HWC
X-Proofpoint-ORIG-GUID: su9nS6VNfgFs0jlq66M3IlcC0Ecc_HWC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_13,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404150107

On 4/15/2024 4:23 AM, Christophe JAILLET wrote:
> if (noa_descriptors > WMI_P2P_MAX_NOA_DESCRIPTORS), there is a mix of
> return and goto. in such a case, 'ret' should be assigned an error code and
> the 'td' should be freed to avoid a memory leak.
> 
> While at it, return 'ret' instead of 0 in case of error.
> This is actually harmless, because the only caller does not handle the
> return value.

in that case it would be preferable to change this to be a void function and
not return anything. that would be consistent with most, if not all, of the
other event handlers



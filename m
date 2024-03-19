Return-Path: <linux-kernel+bounces-108035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BA6880514
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529791C230F9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE89B39FD7;
	Tue, 19 Mar 2024 18:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I9BNLvmx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811DB38DC3;
	Tue, 19 Mar 2024 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710874023; cv=none; b=ZkZA3seEIvwyA3e2npIcGMlIjbgW4nYwNKe5wu7kpBZ6zm9Brp35G4Hnj/0q3dHg8COF2jhjXSfY7NnIijzC3+C1sbYuJxc4/Uk87FQblnOccWMCrQbiwfvlAfmkCuFuQ/VEbBVRTSF5C995vrSZ8Z2F1vew72ioMhvUcreivXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710874023; c=relaxed/simple;
	bh=DaMdMRqPQX4MktdbTTIbll7N57Ee5lAFzSn2B0C2n7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a2txyRFPpsamKGgb/Z/vqau7jlDEQgE5i5lgn3rU79mNRfdRTOM81Gtn2m+5+x8hDzP17cotlBI1w5fHkj/kBQbhaHf5gn4fb1JOKM8xWyZ0IvRqvGwoOiehx3A/Clo95lUh2gVm+Iav3pFulwMzBs/XAIsL9Um1zaZyNVrHjfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I9BNLvmx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42JHGjQs030198;
	Tue, 19 Mar 2024 18:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TP4ackwa+Ob3sp81duFElM8Xs9uwBheL7CE1OFm03yk=; b=I9
	BNLvmx9OEJwyrV8g2vUfcY2jGgG+WmZpTvO2/hPNYRTCxWno55uHueHej7ToWLW6
	qwvW3R1rM5hbf0OSFfbh4jgOXnLRGxD4bKUbNPJIEXEa9xLn7iRNBVpWL5fZZ+6v
	YBpcQLSFjXkdcJQPhicNf5qPhyvh3FMRVoYHtut0S8eZpWBHazNE5vuSQKsnjdBR
	M1JH2rPfEjPmxjSHfCFAtO15HQMFYg9GikRQqzH1YlksRB1BHWxK7FxcbAWl09wR
	FTu6U8xF9wGcPx8KCScg8mAsKkYdO+eM3QlMXrgJnjdGwXkz5pKKALNkn5FxdX/r
	1hAE93Bqsb3bBtVB4LPA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy94ts7gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 18:46:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JIkhYu030051
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 18:46:43 GMT
Received: from [10.110.120.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 11:46:43 -0700
Message-ID: <c9ed5980-c01b-4d20-a5c2-e2ee97373dca@quicinc.com>
Date: Tue, 19 Mar 2024 11:46:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath10k: allocate dummy net_device dynamically
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>
CC: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        <kuba@kernel.org>, <keescook@chromium.org>,
        "open list:NETWORKING DRIVERS
 (WIRELESS)" <linux-wireless@vger.kernel.org>,
        "open list:QUALCOMM ATHEROS
 ATH10K WIRELESS DRIVER" <ath10k@lists.infradead.org>,
        open list
	<linux-kernel@vger.kernel.org>
References: <20240319104754.2535294-1-leitao@debian.org>
 <8771e856-3d9f-41c6-88c8-3c75e77b2aab@quicinc.com>
 <ZfnILSPBiqk8JdJ4@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <ZfnILSPBiqk8JdJ4@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sH8aayGgxF7shxzpMxP7VMhozu2dYCSS
X-Proofpoint-ORIG-GUID: sH8aayGgxF7shxzpMxP7VMhozu2dYCSS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 clxscore=1011 mlxlogscore=955 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190142

On 3/19/2024 10:15 AM, Breno Leitao wrote:
> On Tue, Mar 19, 2024 at 09:05:24AM -0700, Jeff Johnson wrote:
>> On 3/19/2024 3:47 AM, Breno Leitao wrote:
>>> @@ -3687,6 +3690,8 @@ struct ath10k *ath10k_core_create(size_t priv_size, struct device *dev,
>>>  
>>>  err_free_coredump:
>>>  	ath10k_coredump_destroy(ar);
>>> +err_free_netdev:
>>> +	free_netdev(ar->napi_dev);
>>>  err_free_tx_complete:
>>>  	destroy_workqueue(ar->workqueue_tx_complete);
>>>  err_free_aux_wq:
>>> @@ -3708,6 +3713,7 @@ void ath10k_core_destroy(struct ath10k *ar)
>>>  
>>>  	destroy_workqueue(ar->workqueue_tx_complete);
>>>  
>>> +	free_netdev(ar->napi_dev);
>>>  	ath10k_debug_destroy(ar);
>>>  	ath10k_coredump_destroy(ar);
>>>  	ath10k_htt_tx_destroy(&ar->htt);
>>
>> looks like there is a pre-existing issue that the order of operations in
>> _destroy() doesn't match the order of operations in the _create() error path.
> 
> Right. I found it weird as well. Basically "ath10k_coredump" and
> "ath10k_debug" operations are swapped between ath10k_core_create() and
> ath10k_core_destroy().
> 
> If you wish, I can submit a patch ordering it properly.

Don't bother. I'll queue that up to fix separately myself

/jeff


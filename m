Return-Path: <linux-kernel+bounces-156013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C059B8AFCA1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB0F2827F3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABB63FB94;
	Tue, 23 Apr 2024 23:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Wzaxc9Rs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E84B1DFF5;
	Tue, 23 Apr 2024 23:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713915229; cv=none; b=kvZ+ZtWsmhHPxRfz7UVCZAINwPHXZGxaYGuRfaalZphdF6o9uIe2NL+5rLi7EzkndYnOeiqqyhWLi9Z0tUIzjLOtvflw1f/344g6O3GBkBKq+nhtgyjPq8eSQ3x4KxzP5pR9BftDORQSIOh4dtrB8CyWcX0b57Tt3HwEY3LxqSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713915229; c=relaxed/simple;
	bh=UhT05+SHXUDIfRetZSC879uPTe6jaust2zQku4q1KQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N+uahqwUygGqs+qDdiiClWYKJK+7GFgtKPFhHGq0DRGZsFeK6gKkpfXAsccRc1dyRDOGgpqiQWsKX8KJmv+6gBNm5gH349+9T4l8WysokQSDzmKlsQeFiBLQ+oSTZ8cdReY2pH3rYYDaCG58D53gbcd8hZG66uP7PDZ+q82Oh0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Wzaxc9Rs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NNSFui023474;
	Tue, 23 Apr 2024 23:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=UhT05+SHXUDIfRetZSC879uPTe6jaust2zQku4q1KQk=; b=Wz
	axc9Rs/aY4eq7Yw9Wxoi1c7YH8PzSQYqQqP2mjDYmyDmP4zEV8dfgh5XKkkOeHs+
	IYkzu1xETm7/gHQBWp9bw64xPesLAakgpUtjuACCI3lNhW2wJEKim6gvRdua586O
	XhUktIcY9RCjoZ9Fbq0LuEJ/LgNlU+Qkxfa7j6jkAVn+Vq69LX4qYbum1d+8SC3S
	4vco8Ja6qUiblQo2uzsUN8THHe6kTGZY9Bxvgyr+5dZnm1Z6fywCOOc8gNaaiowi
	jI4jXjZ3wGK2t9Iv4nGFpV80blauhoyrKIpoU3MCX47dw192BA4D79prBRqx4zlo
	DM0AhzK77D2O1IJHgdzA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xp9aa2q1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 23:33:44 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43NNXgXV021080
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 23:33:42 GMT
Received: from [10.71.110.192] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 16:33:40 -0700
Message-ID: <24c894ae-5c4a-4462-b036-5929db2fc5ac@quicinc.com>
Date: Tue, 23 Apr 2024 16:33:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of: reserved_mem: Remove the use of phandle from the
 reserved_mem APIs
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <robh@kernel.org>,
        <saravanak@google.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20240422235243.2878536-1-quic_obabatun@quicinc.com>
 <d024a0b0-46aa-4182-a8e8-8ff15f12c363@quicinc.com>
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <d024a0b0-46aa-4182-a8e8-8ff15f12c363@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qlaKYsRXzo7aOhtVXPD5ZDxRLe6tu7Qg
X-Proofpoint-ORIG-GUID: qlaKYsRXzo7aOhtVXPD5ZDxRLe6tu7Qg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_18,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=613
 bulkscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404230065


On 4/23/2024 7:32 AM, Jeff Johnson wrote:
> On 4/22/2024 4:52 PM, Oreoluwa Babatunde wrote:
>> The __find_rmem() function is the only place that references the phandle
>> field of the reserved_mem struct. __find_rmem() is used to match a
>> device_node object to its corresponding entry in the reserved_mem array
>> using its phandle value. But, there is already a function called
>> of_reserved_mem_lookup() which carries out the same action using the
>> name of the node.
>>
>> Using the of_reserved_mem_lookup() function is more reliable because
>> every node is gauranteed to have a name, but not all nodes will have a
> s/gauranteed /guaranteed /
>
> (jumped out at me while scanning the kernel patches)

ack.

Thank you Jeff!



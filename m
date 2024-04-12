Return-Path: <linux-kernel+bounces-143333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E678A3754
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDD21C21E8A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4297B14BF9B;
	Fri, 12 Apr 2024 20:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NrS0A2bL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0688817C7F;
	Fri, 12 Apr 2024 20:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712955213; cv=none; b=X51A8gf2ml0SaRINugpOUCwU3U0KXPyvn3IrxnlkJfNCoqZPxVVBqMldUIhtCGtpC5D4GefkOvDp1jEPXmRzifoYuWee5fET7HPNHBGRWFcI4fMxj+s8Iyu3kS0PzxJCimrbBnQc7RgZ4SRS1GDjFP7tt1mT9o3q041xWL1mutw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712955213; c=relaxed/simple;
	bh=gtXa1g8Diw8jhvbhoBh7settfSPef9KvqOllWKOXyXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mejmgUbyecRyDlpLHjxefo1QA8qpALpIXTz59XmVlqIQcg96a4LHsIzSe71iSNnZPsQQN6KOPFRLl8YI9FLtxemezcAlxfMdXXZmoI4Q0eP0MCKvUGEIjqKKEschpzeyE7VFArw6cX5hFqwa6rx5Sproxd1efyceDA8C0ZWr7MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NrS0A2bL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CKTvuh002893;
	Fri, 12 Apr 2024 20:53:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=HgJDa/2EwgakQCDAhk1JenjRlC2wN9yg1hRDEABckvY=; b=Nr
	S0A2bL0sek98H41TF0941WBLNT3tvWmfofmy3d9Jcx/srTi7/WcjymTS0S14e8RC
	Zq244J8TXEC+ANlFlpg/KXTjwXNf1plhYGEL4Vzmq3w2g9q8yC76MAgYv9zO4hyt
	53aCp9iap5FZpTmwILT4PDh4+/YpF6xr35O236D2tcdyQSxVCGKOyQ1YscJMaTO4
	kGMq2DaXCZLBkAbIiBkdBJ6tloi84bTepA6mDFFNLNhklUWZZAaQU/q3oVevijO0
	brFSJSSpCkOWFfEUc/ycMrv8Ujasu9x1fXz71swD3grV3QljrVC1Bgd+I/EAdKeg
	jnuoQIutiLX1OET8C8kQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xf9x6rjuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 20:53:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43CKr5D0021876
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 20:53:05 GMT
Received: from [10.110.37.144] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Apr
 2024 13:53:04 -0700
Message-ID: <c7106c8e-0c99-4160-966e-b1a8ba5770ee@quicinc.com>
Date: Fri, 12 Apr 2024 13:53:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath11k: support DT ieee80211-freq-limit
 property to limit channels
Content-Language: en-US
To: Christian Lamparter <christian.lamparter@isd.uni-stuttgart.de>,
        Robert
 Marko <robimarko@gmail.com>, <kvalo@kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240412162510.29483-1-robimarko@gmail.com>
 <20240412162510.29483-2-robimarko@gmail.com>
 <4a1e0cb6-c319-4eb1-9bd1-5ff13eabfe1b@isd.uni-stuttgart.de>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <4a1e0cb6-c319-4eb1-9bd1-5ff13eabfe1b@isd.uni-stuttgart.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oKEhJCcr9ogoabfdMqA007OIM4biwoUC
X-Proofpoint-GUID: oKEhJCcr9ogoabfdMqA007OIM4biwoUC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_17,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=784 spamscore=0
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 clxscore=1011 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404120149

On 4/12/2024 12:52 PM, Christian Lamparter wrote:
> On 4/12/24 6:24 PM, Robert Marko wrote:
>> The common DT property can be used to limit the available channels
>> but ath11k has to manually call wiphy_read_of_freq_limits().
>>
>> Signed-off-by: Robert Marko <robimarko@gmail.com>
> 
> I've seen this before.
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/ed266944c721de8dbf0fe35f387a3a71b2c84037.1686486468.git.chunkeey@gmail.com/
> 
> (dt-binding too. it has/had an ack)
> https://patchwork.kernel.org/project/linux-wireless/patch/fc606d2550d047a53b4289235dd3c0fe23d5daac.1686486468.git.chunkeey@gmail.com/
> 
> sooo.... this is awkward.

Patchwork indicates Changes Requested
Any idea what changes Kalle is looking for?



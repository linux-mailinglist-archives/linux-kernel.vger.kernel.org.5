Return-Path: <linux-kernel+bounces-11731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2DC81EAEC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 01:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B4F1C21EA5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 00:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FC81FBF;
	Wed, 27 Dec 2023 00:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N341jRBp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD915622;
	Wed, 27 Dec 2023 00:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BQNuTAw017245;
	Wed, 27 Dec 2023 00:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=C0F31algdVe500mgfgdoCt4pGhDTR1ZynXl8Vor97Co=; b=N3
	41jRBpZw1Gukq/QZ0mh2PL5OOwrHNWSZjDU9nqRMiGSdQvqW8Rcc8V9u+SFSNqbu
	jTZVpSCpilzkfkI48HDyTfopX0dWYYPdgnX6AmvSNpklzY/rnjowOk61e25+bdCZ
	iXGLf7cMiW9zHOWmH0O2q1TWHydWnW12OokIrMLjP0uJvt9dqCGDZ8rwhUrwIT4H
	FaWDB8PzYBbWUUJswFmNi9fVYSkScGuE+cxpoTla2PYxST4gz6zJrI8lF4eANfYG
	wE+TRPEZOzDMF2C9CFc3h/ohAuKCcK2YHSgihnEDxVsZZs2ZvIfykwPRmyctq8dr
	VYaVehy8SvKCUvzIrfQg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v7c9jk1rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 00:20:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BR0K5WI032355
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 00:20:05 GMT
Received: from [10.110.65.236] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Dec
 2023 16:20:04 -0800
Message-ID: <3e017f77-87dd-78e1-321d-90c3e57a68d9@quicinc.com>
Date: Tue, 26 Dec 2023 16:20:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V1] net: qrtr: ns: Ignore ENODEV failures in ns
To: Simon Horman <horms@kernel.org>, Sarannya S <quic_sarannya@quicinc.com>
CC: <quic_bjorande@quicinc.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:NETWORKING
 [GENERAL]" <netdev@vger.kernel.org>
References: <1703153211-3717-1-git-send-email-quic_sarannya@quicinc.com>
 <20231223135333.GA201037@kernel.org>
Content-Language: en-US
From: Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <20231223135333.GA201037@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hzpCbIT1obMCBG01wK-6u7g99AjD_AAU
X-Proofpoint-ORIG-GUID: hzpCbIT1obMCBG01wK-6u7g99AjD_AAU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=960 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312270000



On 12/23/2023 5:56 AM, Simon Horman wrote:
> [Dropped bjorn.andersson@kernel.org, as the correct address seems
>   to be andersson@kernel.org, which is already in the CC list.
>   kernel.org rejected sending this email without that update.]
> 
> On Thu, Dec 21, 2023 at 03:36:50PM +0530, Sarannya S wrote:
>> From: Chris Lew <quic_clew@quicinc.com>
>>
>> Ignore the ENODEV failures returned by kernel_sendmsg(). These errors
>> indicate that either the local port has been closed or the remote has
>> gone down. Neither of these scenarios are fatal and will eventually be
>> handled through packets that are later queued on the control port.
>>
>> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
>> Signed-off-by: Sarannya Sasikumar <quic_sarannya@quicinc.com>
>> ---
>>   net/qrtr/ns.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
>> index abb0c70..8234339 100644
>> --- a/net/qrtr/ns.c
>> +++ b/net/qrtr/ns.c
>> @@ -157,7 +157,7 @@ static int service_announce_del(struct sockaddr_qrtr *dest,
>>   	msg.msg_namelen = sizeof(*dest);
>>   
>>   	ret = kernel_sendmsg(qrtr_ns.sock, &msg, &iv, 1, sizeof(pkt));
>> -	if (ret < 0)
>> +	if (ret < 0 && ret != -ENODEV)
>>   		pr_err("failed to announce del service\n");
>>   
>>   	return ret;
> 
> Hi,
> 
> The caller of service_announce_del() ignores it's return value.
> So the only action on error is the pr_err() call above, and so
> with this patch -ENODEV is indeed ignored.
> 
> However, I wonder if it would make things clearer to the reader (me?)
> if the return type of service_announce_del was updated void. Because
> as things stand -ENODEV may be returned, which implies something might
> handle that, even though it doe not.
> 
> The above notwithstanding, this change looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> ...

Hi Simon, thanks for the review and suggestion. We weren't sure whether 
we should change the function prototype on these patches on the chance 
that there will be something that listens and handles this in the 
future. I think it's a good idea to change it to void and we can change 
it back if there is such a usecase in the future.


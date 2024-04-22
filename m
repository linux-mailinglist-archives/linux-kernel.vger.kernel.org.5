Return-Path: <linux-kernel+bounces-153620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 227F38AD076
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD09D1F216B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA7E152E14;
	Mon, 22 Apr 2024 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hcYK4UlM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C112152180;
	Mon, 22 Apr 2024 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799164; cv=none; b=V+qi6SavrOAbRXbieC6us+wjfRo18kZh+coAZvi/wA0bSvjZSCY0Kup+iI8oEkloIasknnx9X2TNpIx4xDTABxn7LkTAIM9cn7/ChuFUfv6fDsn6FEuN7jn2SbBWwyYpoLI2WKOXXVwcfMeDZ2yF0TQ1vxtoZE4eUkuLRmJJwBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799164; c=relaxed/simple;
	bh=SQELW759SXCwoXkW5c0xXgnr4pqy2tLW1ZKbcY2HvPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gJFNqrbiSz4Ze75GmyNT2BtYo6h+xdHggVoI9gGPp2hcPAZylpPRHNG8iJNhVDURYcwnaaNRmvo0NIJ/e7Pj0eVUltNlwlS4NjPf4MFUFCUFgnJRJZqkFaLbCsQ6ZzQOptHy7MPV+RzObZKZ6yz7LRM5voszsSxHh0BUyYTgqpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hcYK4UlM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M3K233024557;
	Mon, 22 Apr 2024 15:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=f6pTsCYBLKhjTJN3CtA0dNLg4N9NIPRSJsVZ07k/o8M=; b=hc
	YK4UlM96yrzJSVJkrs08CxCejxJDcKrFUXLyLTLQ4R4ZzVOGzPYBEDwBvsAFsIHr
	W+DVVeiQmiQzguZp84v/xH/2hmW32x9NDAw+fnGfg2MU+ECfFQvGABZujtEVW5Vg
	MEnMLm4PkL2XZcQBy/pVCOQysIhTKno065YAz+UBWt0kdSOSzeBc5/fmBJFFQYVM
	xMrs2+nLsP8spdDmXWFEt4wY+bdZC+7NgcYGYPaLYGLn2xUK0lUp6plZ+IxGksvJ
	IELPzZguYKSPO+O6BcJmzpz0spuUrly/7fji5WrcBfMS9HM0ZJRIDzLap8c5zWXu
	wMvKkOtAcB8OW4yY3qCA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xmxq4tvaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 15:19:16 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MFJFcs005829
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 15:19:15 GMT
Received: from [10.253.37.80] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 08:19:13 -0700
Message-ID: <5ce83568-e185-4247-aa72-bc86d727446f@quicinc.com>
Date: Mon, 22 Apr 2024 23:19:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Bluetooth: qca: fix NULL-deref on non-serdev setup
To: Johan Hovold <johan@kernel.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann
	<marcel@holtmann.org>,
        Zhengping Jiang <jiangzp@google.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240319154611.2492-1-johan+linaro@kernel.org>
 <ZiZdag8fw8H1haCb@hovoldconsulting.com>
 <438844e9-47e8-486e-9611-ae524d6974b3@quicinc.com>
 <ZiZkK4BAoqxNg7yG@hovoldconsulting.com>
 <472b9f60-d68e-47ee-9ca9-f71a9ba86a1a@quicinc.com>
 <ZiZpg4lyp-LcpV8l@hovoldconsulting.com>
 <3e170e40-c143-4e3b-8696-b661cac56f00@quicinc.com>
 <ZiZ8GzBXd9Re8EjZ@hovoldconsulting.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <ZiZ8GzBXd9Re8EjZ@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UtfriMwa4s7Fpc5hplr7oznPxK7jGsiH
X-Proofpoint-ORIG-GUID: UtfriMwa4s7Fpc5hplr7oznPxK7jGsiH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220065

On 4/22/2024 11:02 PM, Johan Hovold wrote:
> On Mon, Apr 22, 2024 at 09:53:48PM +0800, quic_zijuhu wrote:
>> On 4/22/2024 9:43 PM, Johan Hovold wrote:
>>> On Mon, Apr 22, 2024 at 09:30:28PM +0800, quic_zijuhu wrote:
>>>> On 4/22/2024 9:20 PM, Johan Hovold wrote:
> 
>>>> NAK for your [PATCH 1/2] since the null checking is redundant with your
>>>> [PATCH 2/2].
>>>
>>> I explained in the cover letter why it is split up like this. If you
>>> don't bother reading, then we will not bother listening to you.
>>>
>>>> NAK for your [PATCH 2/2], since it is same with my earlier fix
>>>> https://lore.kernel.org/all/1704960978-5437-1-git-send-email-quic_zijuhu@quicinc.com/
>>>> my new patchset for btattach tool still has this change.
>>>
>>> The fix does not depend on your btattach series, which has also been
>>> rejected.
>>>
>> these my v1 and v2 for this issue which are earlier then yours.
>> they are not rejected but not responded.
>>
>> https://lore.kernel.org/all/bf74d533-c0ff-42c6-966f-b4b28c5e0f60@molgen.mpg.de/
>> https://lore.kernel.org/all/1704970181-30092-1-git-send-email-quic_zijuhu@quicinc.com/
> 
> Here is your *v3* as part of the rejected btattach series:
> 
> 	https://lore.kernel.org/all/1713409913-13042-2-git-send-email-quic_zijuhu@quicinc.com/
> 
no, v3 is a separate patch here and not was rejected.
https://lore.kernel.org/all/1710912504-25416-1-git-send-email-quic_zijuhu@quicinc.com/
and it was sent after your patch.

then i included the fix into a patch serials for tool btattach shown by
below link
https://lore.kernel.org/all/1713358336-29619-2-git-send-email-quic_zijuhu@quicinc.com/
you reviewed my the serials and also did not rejected the fix.
and it also doesn't get any negative comments.

> Apparently you had earlier also sent it separately, I see now in lore.
> It's all a big mess.
> 
>>> You clearly have some learning to do on how to interact with the kernel
>>> community and to write proper commit messages and patches. If you start
>>> listening to feedback and try not to piss everyone off perhaps you can
>>> even get your patches merged one day. [1][2]
> 
> Johan



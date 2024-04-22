Return-Path: <linux-kernel+bounces-153532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 108038ACF45
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68731B21769
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19461514F8;
	Mon, 22 Apr 2024 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QGhBsmfH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7781A1514E3;
	Mon, 22 Apr 2024 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713795791; cv=none; b=VoNZRJoZ4r8zUXBbwk2uGhCG4BTJ2EamSQYY0Q1ZxZ3RjmiSPQiG3b2IQhomsS1NxheSEMlxM2EaG8PM+eXj1Qz/9rcTL4FjIRvasnsTw+XHDX1FXEQgHgteQbsq+Ux/ctcPjcKENAAFcnCkeTarBWYzwh6nZbMuPnNdfypPYBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713795791; c=relaxed/simple;
	bh=bNuTKcNQBJfPtRg4gz+UFE0NPRn8XlMDK4A1ptT56yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HGIScItREmOp1HSLmiLXDMd8zEzZNzScV7mT1S7eSLNZf6aHjJu0xFNqSqa/Wra0RZX1RgjcaM/sPAFQR1PwMC49GNAc38SolkatgG69u1S6WLqvRi8dGrJeBh/QqXUWF4BedTuta6TL2sOrQzsYpQbj+qZ2abc2rKn9X6WSOJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QGhBsmfH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MEIniv008160;
	Mon, 22 Apr 2024 14:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5i/QBINeeD1xvrRe8QvaoMm2iQtpwWw17sNpwbPCAnA=; b=QG
	hBsmfHIK3yCGbYUm7pIyZoJ94TzV/ivenfYCeTVDWGtyMczcUUlcqob+bdFtrM6m
	wLPi+y9ikU3CF++G7vpY2HKRv6eNbsT1dUXXlu09WkWXIsojakXI0Jezsi4Y7kMy
	hqAcQ8flxSufbcUV3cXhSCdC3AeAYlsFxSo2KulqEpeJgOBSeV6/ALdk0T8CoI+t
	In41pttikRlIP/0kahX3HlEQ7ivqQac/ehjY6LAcsXwWSMHvC1fRVIS2ah2vNO9D
	MuXzTlpy42ngKSxZ686vmkVbmiSQIFeYQ0ZOwgvd2k3jnIHbYGE19VCeUnOnV79b
	XXz0PO2YxTi6UWujEL+Q==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnn82gr2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 14:23:02 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MEN2QT025147
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 14:23:02 GMT
Received: from [10.253.37.80] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 07:23:00 -0700
Message-ID: <1972beef-8ad6-4d7f-aa97-12143baa1fc1@quicinc.com>
Date: Mon, 22 Apr 2024 22:22:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Bluetooth: qca: fix NULL-deref on non-serdev setup
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Johan Hovold <johan@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
        Zhengping Jiang <jiangzp@google.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240319154611.2492-1-johan+linaro@kernel.org>
 <ZiZdag8fw8H1haCb@hovoldconsulting.com>
 <438844e9-47e8-486e-9611-ae524d6974b3@quicinc.com>
 <ZiZkK4BAoqxNg7yG@hovoldconsulting.com>
 <472b9f60-d68e-47ee-9ca9-f71a9ba86a1a@quicinc.com>
 <ZiZpg4lyp-LcpV8l@hovoldconsulting.com>
 <3e170e40-c143-4e3b-8696-b661cac56f00@quicinc.com>
 <CABBYNZKpR8ZqUHmLg0RLq1Yqtk4qDEYj9UuDLYrZsthSPao-dg@mail.gmail.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <CABBYNZKpR8ZqUHmLg0RLq1Yqtk4qDEYj9UuDLYrZsthSPao-dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BmlNpZ_TfcWdDyGFTk5Lkm-O9dhr-XmI
X-Proofpoint-ORIG-GUID: BmlNpZ_TfcWdDyGFTk5Lkm-O9dhr-XmI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220062

On 4/22/2024 10:15 PM, Luiz Augusto von Dentz wrote:
> Hi Quic_zijuhu,
> 
> On Mon, Apr 22, 2024 at 9:53 AM quic_zijuhu <quic_zijuhu@quicinc.com> wrote:
>>
>> On 4/22/2024 9:43 PM, Johan Hovold wrote:
>>> On Mon, Apr 22, 2024 at 09:30:28PM +0800, quic_zijuhu wrote:
>>>> On 4/22/2024 9:20 PM, Johan Hovold wrote:
>>>>> On Mon, Apr 22, 2024 at 09:04:58PM +0800, quic_zijuhu wrote:
>>>>>> On 4/22/2024 8:51 PM, Johan Hovold wrote:
>>>>>>> On Tue, Mar 19, 2024 at 04:46:09PM +0100, Johan Hovold wrote:
>>>>>
>>>>>>>> Johan Hovold (2):
>>>>>>>>   Bluetooth: qca: fix NULL-deref on non-serdev suspend
>>>>>>>>   Bluetooth: qca: fix NULL-deref on non-serdev setup
>>>>>>>
>>>>>>> Could you pick these up for 6.9 or 6.10?
>>>>>>>
>>>>>>> The patches are marked for stable backport and only privileged users can
>>>>>>> set the N_HCI line discipline these days (even if I'm not sure about
>>>>>>> pre-5.14 kernels...) so it may be fine to wait for 6.10 if you prefer.
>>>>>
>>>>>> could you share the patch links for me to review. i can
>>>>>> 't find them now
>>>>>
>>>>> Sure, but you should bookmark lore.kernel.org in your browser as you can
>>>>> search the archives there yourself:
>>>>>
>>>>>     https://lore.kernel.org/lkml/20240319154611.2492-1-johan+linaro@kernel.org/
>>>
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
>>
>>> You clearly have some learning to do on how to interact with the kernel
>>> community and to write proper commit messages and patches. If you start
>>> listening to feedback and try not to piss everyone off perhaps you can
>>> even get your patches merged one day. [1][2]
>>>
>>> Johan
>>>
>>> [1] https://lore.kernel.org/linux-bluetooth/fbe5722b-1e45-4ccb-a050-20a473a823c8@quicinc.com/T/#m8e495666a71eb0e7ae54c82554dfff1fc96983e7
>>> [2] https://lore.kernel.org/linux-bluetooth/1713563327-19694-1-git-send-email-quic_zijuhu@quicinc.com/T/#med0610646a8fd8b3c8586abca9895b124b2d2534
>>
> 
> They probably need to be resend as well, you have so many sets pending
> that makes it hard to know which should go first, next time please
> wait until each set is merged before sending the next since I can't
> know if they are really independent of each other or not.
> 
okay. let me also provide a list of patches required for BT maintainers
in another thread.



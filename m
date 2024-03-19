Return-Path: <linux-kernel+bounces-108097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3809E8805E7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD7F1F23502
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C78959B76;
	Tue, 19 Mar 2024 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V7i4Sz+K"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DC45F860;
	Tue, 19 Mar 2024 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710879190; cv=none; b=ldtPOyH0RralXh0Z8+vbs2JY2kVWx+NMOJepFNqM2wFULBvQ7+buOLkfqdc6ETfOKh16AsYFeiHyDmjxDBgjZPC3l7RT6IXxFjmoO+1aTDVBitnKVkKlxYRrz9iXNJmiTZKmolnPvwmtvwGhXB++I05cJ3fVgIC9CyrDq+SWKZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710879190; c=relaxed/simple;
	bh=XSo6Qp5+TTIpAtv1z79spgUBfLtasygSqClrv/83aWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WOig6C3vMD0XD7gGs0jtR1ZMItN84oMSUQ99/FR2eBJcwjdk3aldPF8w/GYNgX1BJ1wpnBhKC+jmo+nzvxCNIvIWJ3LjnHWFUHnh5FrMX7yZeujVtbrQdB9Y2YwJr455NhQ7G93boE4nYHhccRPGFHhxAyAS9bV6hrwsm/Bt6us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V7i4Sz+K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42JJh5Vx008725;
	Tue, 19 Mar 2024 20:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=fmu5THVSphdCzmExKKVkeaiKTgxaANSNFePOX3S7iuw=; b=V7
	i4Sz+KcchDCEHBZspLgAEOXU+KnHuiJZT0xDDlGpF9brzF27UbCuFY+4c0KauPS1
	yYpJtkm5x0+k0/mqNQ2SxJ5yjcMakV8wiM+NLOfngWv9B1SZ7aNfaddrWjJVXSyn
	gylXSXfmPKewOFBRBMI+9wLFdxOKTqHZXn5v06Bz8wVLmb3ijAi/qpqd/J7eNcWT
	cEYE/0oBdBzrVV5FnM6LV70W/NX1zhtOffQ27ENuus3XpVOkQJSaZSBA9y4l8/4p
	UOcKZ7ZRb5CSoxPuhXr68dAA38sRYjysjWvGK8kieX8+J+UWVhknfNAqQrRRVmSm
	+nVY7m1ud48wjQBugRJA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wye5n8jsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 20:12:40 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JKCexf025944
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 20:12:40 GMT
Received: from [10.110.98.255] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 13:12:36 -0700
Message-ID: <e008b2aa-8a36-44af-ad57-f5cd9658bb4f@quicinc.com>
Date: Tue, 19 Mar 2024 13:12:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net: Re-use and set mono_delivery_time bit
 for userspace tstamp packets
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, <kernel@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Halaney
	<ahalaney@redhat.com>,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf
	<bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Alexei
 Starovoitov" <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20240301201348.2815102-1-quic_abchauha@quicinc.com>
 <2a4cb416-5d95-459d-8c1c-3fb225240363@linux.dev>
 <65f16946cd33e_344ff1294fc@willemb.c.googlers.com.notmuch>
 <28282905-065a-4233-a0a2-53aa9b85f381@linux.dev>
 <65f2004e65802_3d1e792943e@willemb.c.googlers.com.notmuch>
 <0dff8f05-e18d-47c8-9f19-351c44ea8624@linux.dev>
 <e5da91bc-5827-4347-ab38-36c92ae2dfa2@quicinc.com>
 <65f21d65820fc_3d934129463@willemb.c.googlers.com.notmuch>
 <bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev>
 <65f2c81fc7988_3ee61729465@willemb.c.googlers.com.notmuch>
 <5692ddb3-9558-4440-a7bf-47fcc47401ed@linux.dev>
 <65f35e00a83c0_2132294f5@willemb.c.googlers.com.notmuch>
 <e270b646-dae0-41cf-9ef8-e991738b9c57@quicinc.com>
 <8d245f5a-0c75-4634-9513-3d420eb2c88f@linux.dev>
 <d10254cc-a908-4d81-98d2-2eed715e521f@quicinc.com>
 <66ad9e5b-0126-476e-bf0f-6a33f446c976@quicinc.com>
 <5b1d5758-3510-47c5-97e9-2edc5112d046@linux.dev>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <5b1d5758-3510-47c5-97e9-2edc5112d046@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VMrYGObpInr61SalXL7s6H01AGPAuPip
X-Proofpoint-ORIG-GUID: VMrYGObpInr61SalXL7s6H01AGPAuPip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=876 mlxscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190155



On 3/19/2024 12:46 PM, Martin KaFai Lau wrote:
> On 3/18/24 12:02 PM, Abhishek Chauhan (ABC) wrote:
>>>>>>> I think the "struct inet_frag_queue" also needs a new "user_delivery_time"
>>>>>>> field. "mono_delivery_time" is already in there.
>>>> [ ... ]
>>>>
>> Martin, Do we really need to add user_delivery_time as part of inet_frag_queue struct? I was wondering why is this required since we are using tstamp_type:2 to
>> distinguish between timestamp anyway .
> 
> 
> The context for this was before combining mono_delivery_time:1 and user_delivery_time:1 into tstamp_type:2. No need to add user_delivery_time to inet_frag_queue because it is combined into tstamp_type:2. If mono_delivery_time:1 is replaced with tstamp_type:2 in sk_buff, the same should be done in inet_frag_queue.
> 
Thats what i was planning to do. This is more or like the patch 3 - when brings in the changes of two bits. 
Thanks Martin for clarification. 
> 


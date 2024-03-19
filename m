Return-Path: <linux-kernel+bounces-108044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4697688052C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7951F2471E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE8C39FCF;
	Tue, 19 Mar 2024 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a93kvzT8"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAAF39AD5;
	Tue, 19 Mar 2024 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710874581; cv=none; b=rQa53qnjLQFez06A76qjjofggp+ZhPHAlG8WdCsW/ON63swYvWf9u2zUA53Y5CG2JfV91FXlduLwz9tH2jaeNQhiH1/1DoX2I8sirS/cb++5KqDj3QzPgmXZDw2Nb9NRkKDR802MspDBeh1t9z+3UqZm9AuLTl6QBxnf8Hfuidc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710874581; c=relaxed/simple;
	bh=DdYQb2a+xcV5YeF7/xy5cNg5XH3bFTlzk6qS9cbOnPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMIoHsz/DmbqUJTEHBoZVUv0NJzZ/0maAnwLKUXOQn2hK8R0W/9tnQfZ6WZYH1L03FUlpi0ezquD7dg/d3boQkI2dBrwjhWdg4kbpnUPt9Zl6qKkb52YJZyS9KW5qOaeHPfP8XzkuZ4PtQVVAdcQq2mhunAQbkbey76/zlE3VbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a93kvzT8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JIp7SW009331;
	Tue, 19 Mar 2024 18:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sErdNKpGwdXCXGL6HoHiUJZ1yPwMRBR6HoPdLoOlibI=;
 b=a93kvzT8SWMsT1tfXJiXqNMoT63RCIiTWe3f7f5Wmqe2bJSN/XE8iJfYmkqh1iozjXT9
 yETbLFjlPLB+FjBSJN3OxEaG+huppqHONy7R7N1+O2CUM5l/4PXJfI3aGG1Ix2CPQ5cs
 ZW2FJpad8E34U3liKr4bM5YXr2phdW7gxDyrGKTwWgrkfStJh5vnp+2s1Gx1qiiOojv1
 Lk46OqIJw5nCKwcJ1UEgVFgu53A/21ovuIZ55w6VQ4CLdRpmAM6b1XOCGsUu1MxEPaoM
 hOmMxqTeViQTQGtPlBUeb2gjpziwyB3DTis9rwQuXl/GVVdvb4ViW6LKFlAPAnPe1Zmb vw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyfuwg2ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 18:56:00 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42JIcIeL015829;
	Tue, 19 Mar 2024 18:56:00 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwp501qgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 18:56:00 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42JItvpD19726910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 18:55:59 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D9AA5804B;
	Tue, 19 Mar 2024 18:55:57 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1F3258067;
	Tue, 19 Mar 2024 18:55:55 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Mar 2024 18:55:55 +0000 (GMT)
Message-ID: <026ad747-eb04-44e6-9c1e-cb1a56a6e0e3@linux.ibm.com>
Date: Tue, 19 Mar 2024 14:55:55 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/13] Add support for NIST P521 to ecdsa
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        bbhushan2@marvell.com
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <ZfiMhi9D2Rhh89BI@wunner.de>
 <d02eda40-2d3a-43a2-a3a9-cb79055acda7@linux.ibm.com>
 <CZXXPKTAUUM9.35VZUFITJWF6A@kernel.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CZXXPKTAUUM9.35VZUFITJWF6A@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 79g6SWib6schXeCJA2BReBDbIz_Nh0sw
X-Proofpoint-GUID: 79g6SWib6schXeCJA2BReBDbIz_Nh0sw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=533 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403190143



On 3/19/24 14:22, Jarkko Sakkinen wrote:
> On Tue Mar 19, 2024 at 12:42 AM EET, Stefan Berger wrote:
>>
>>
>> On 3/18/24 14:48, Lukas Wunner wrote:
>>> On Tue, Mar 12, 2024 at 02:36:05PM -0400, Stefan Berger wrote:
>>>> This series adds support for the NIST P521 curve to the ecdsa module
>>>> to enable signature verification with it.
>>>
>>> v6 of this series is still
>>>
>>> Tested-by: Lukas Wunner <lukas@wunner.de>
>>
>> Thanks.
> 
> This has been discussed before in LKML but generally tested-by for
> series does not have semantical meaning.
> 
> Please apply only for patches that were tested.

Ok, I will remove the Tested-by tag.

However, patch 4/13, that only changes a comment, can also be tested in 
so far as to check whether the code is correct as-is for the tests that 
'I' ran and no further modifications are needed for NIST P521. In this 
case it would mean that a single subtraction of 'n' from res.x seems 
sufficient and existing code is good as described by the modified comment.

> 
> BR, Jarkko
> 


Return-Path: <linux-kernel+bounces-140182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CC18A0C78
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C603C1F2262D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C878114532B;
	Thu, 11 Apr 2024 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gyt1CYYw"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB62F144D2A;
	Thu, 11 Apr 2024 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712828004; cv=none; b=QC3tkd26JoJNBRpx7hnQh+sUkYE8MLhZuSW7ca/tYEzINS8fDxMXqlwekNEd+7344yw/qEdXCElFlpEAZB1my0PdwCxEPLNA8NP/9YsnA4jePydDSHWqlRk1ZRzuKJcFZ4YMRq9+TC8xQ5ibiQXTuOSdoPHI2ZfjkK+FOg6sOsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712828004; c=relaxed/simple;
	bh=NPUjbygY7dOut/w/ZBzQBO8x18aPGw21EDbfje4x9Wc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FwA3pKH9beoMJ0Dmgod80pXJ0J7cSCxsyvp1AIFMWvI82lhHiaOadyRI2NFyNydMW5SmAI1Sf62BqfG3qwRm+nBvKTc2XKiAs8fqxtfXMtmlcApvjcXvciSHPceuqtvLFFLgEmS/nX3u/u9pKySL7CuPPBl5FP2i0RmGRn9kGNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gyt1CYYw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43B91IU7011364;
	Thu, 11 Apr 2024 09:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=GNfbBQyMK7y6+Ln1Yl3MWg1C2ZKWaofyJvThpeHIeB4=;
 b=gyt1CYYwYp7U/XDm2LaIZ+8nuGFUcIG2KOgilFgsKCEYvlmQRZBAu2aL9o78kl6KkP7H
 iyF+NytN3lT8V97mEKxeMqTHobv0Jv+aUDgz/iPWQOIBCuJWqFiB3YB3RKZWk99EZlXO
 SPz3ZHn575u4sN8QEdlUpFOzPP0ahxcpSpFnyEC77QrQxwmH/femkZF41+5wV/v7ONRm
 jUKJGSairtA1nwmPnSm74kHPYrJum7Qrgre9hXTUz4kFRrG32HDmyK8tQP/t7msddAGq
 MR6Ib38LwqkW4p4OtpB2DOS0GKjjjfij/EfOMupbUE+fdY/Hc9an0je0dYzDDIHseLYm Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xeap80d1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 09:33:12 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43B9XBWY030359;
	Thu, 11 Apr 2024 09:33:11 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xeap80d1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 09:33:11 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43B7xEFt017031;
	Thu, 11 Apr 2024 09:33:10 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xbke2sxdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 09:33:10 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43B9X7t119923690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 09:33:09 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C630B58066;
	Thu, 11 Apr 2024 09:33:05 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BCE958072;
	Thu, 11 Apr 2024 09:33:02 +0000 (GMT)
Received: from [9.179.30.10] (unknown [9.179.30.10])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Apr 2024 09:33:02 +0000 (GMT)
Message-ID: <ddd181fc-307f-4c2f-bc9b-6941a17f16d9@linux.ibm.com>
Date: Thu, 11 Apr 2024 11:32:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v5 00/11] net/smc: SMC intra-OS shortcut with
 loopback-ism
Content-Language: en-GB
To: Wen Gu <guwen@linux.alibaba.com>, Gerd Bayer <gbayer@linux.ibm.com>,
        jaka@linux.ibm.com
Cc: wintera@linux.ibm.com, twinkler@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
References: <20240324135522.108564-1-guwen@linux.alibaba.com>
 <ae3ea4bc-4a9c-416e-a593-2885fea96ae5@linux.alibaba.com>
 <27deaa5dbb30c467fcdaa0667ef39da86bcee03f.camel@linux.ibm.com>
 <fc274220-cb6e-43be-aa76-69e37449e535@linux.alibaba.com>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <fc274220-cb6e-43be-aa76-69e37449e535@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BSFtNKy1vmi4bC4EQpAeMyxktRppxZCx
X-Proofpoint-ORIG-GUID: JB91-AKHYEvEA27xqbpBi3V2FdwQY33H
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_03,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404110068



On 11.04.24 09:45, Wen Gu wrote:
> 
> 
> On 2024/4/3 19:10, Gerd Bayer wrote:
>> On Wed, 2024-04-03 at 14:35 +0800, Wen Gu wrote:
>>>
>>>
>>> On 2024/3/24 21:55, Wen Gu wrote:
>>>> This patch set acts as the second part of the new version of [1]
>>>> (The first
>>>> part can be referred from [2]), the updated things of this version
>>>> are listed
>>>> at the end.
>>>
>>>> Change log:
>>>>
>>>> RFC v5->RFC v4:
>>>> - Patch #2: minor changes in description of config SMC_LO and
>>>> comments.
>>>> - Patch #10: minor changes in comments and
>>>> if(smc_ism_support_dmb_nocopy())
>>>>     check in smcd_cdc_msg_send().
>>>> - Patch #3: change smc_lo_generate_id() to smc_lo_generate_ids()
>>>> and SMC_LO_CHID
>>>>     to SMC_LO_RESERVED_CHID.
>>>> - Patch #5: memcpy while holding the ldev->dmb_ht_lock.
>>>> - Some expression changes in commit logs.
>>>>
>>>
>>> Hi, Jan. Do you have any comments on this version and should I post a
>>> new patch series without 'RFC'? Thank you.
>>
>> Hi Wen,
>>
>> Jan has been out sick for a little while now, and Wenjia is expected
>> back from a longer vacation tomorrow. So if you could hold off until
>> begin of next week, Wenjia might have some more feedback.
>>
>> In the meantime, I'm looking at your patchset...
>>
>> Thank you, Gerd
>>
> 
> Hi Gerd, is there any further information? I am wondering if I
> should wait for more feedback from SMC maintainers. Thanks!
> 
> 
> Hi Wenjia, when it's convenient for you, could you please confirm
> if [1] and [2] need to be included in the next version? Thanks!
> 
> [1] 
> https://lore.kernel.org/netdev/7291dd1b2d16fd9bbd90988ac5bcc3a46d17e3f4.camel@linux.ibm.com/
> [2] 
> https://lore.kernel.org/netdev/60b4aec0b4bf4474d651b653c86c280dafc4518a.camel@linux.ibm.com/
> 

Hi Wen,

I'm just back, thank you for the patience!

Firstly I want to thank Gerd and Niklas for review and bringing up these 
points!

Here are some of my options on that:

To [1]:
I agree to document the ops as otional if it must not be supported. 
Since I don't really have any ideas, the classification souds reasonable 
to me. Going to the details, what about to take following options as 
mandatory:

* query_remote_gid()
* register_dmb()/unregister_dmb()
* move_data() : I do see the necessary here.
* get_local_gid()
* get_chid()
* get_dev()

To [2]:
I also agree to keep the ism-loopback at the very beginning of the List. 
That acting is also what I imaged previously. Thank you, gerd, again for 
testing it and find it out!

Thanks,
Wenjia


Return-Path: <linux-kernel+bounces-14369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0A5821C27
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ECB92815D0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD731F9EF;
	Tue,  2 Jan 2024 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j6Lzo/m4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D099FBE2;
	Tue,  2 Jan 2024 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 402CgZaO007352;
	Tue, 2 Jan 2024 13:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=6GPl8Fgppj8jE8Ii9nAOicUgGEWraLIpSFxzZ3BotJM=;
 b=j6Lzo/m4jK3+x8E3OwbjGYajZMjXXn4HBQNbY0xKcpvUO43PCglOV2Rbu22bSNkRfc06
 YLcsr/tT2mU7kiv1JTvboJbpLH48cSd73YMi4/Rjt58al6HIJs1mjzbxK2bFTV7emF/w
 oshtJrSDH6j0J/2gxrBr8ehZUQXgZ/Ab21EImY0yPUJS9mCriESq7xftflbBmCN277as
 ir55KJY+w9WYEI2T7dPg9obb9QToayFtaS5/CA2AbRlNYTF2SJbqh927AFL1BlugNbjD
 1VbZL1RIUp5OhQpPWaFoYZZpniDIK5m/8fsghpzkgJnEMa747JdXWDfZXN+7Sx2vSVbM HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vcjqt0atd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 13:03:03 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 402CufhZ009407;
	Tue, 2 Jan 2024 13:03:03 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vcjqt0asy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 13:03:03 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 402ABIDD017850;
	Tue, 2 Jan 2024 13:03:02 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vawwymye8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 13:03:02 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 402D32Zi54985214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jan 2024 13:03:02 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AEB558061;
	Tue,  2 Jan 2024 13:03:02 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53B6A58056;
	Tue,  2 Jan 2024 13:03:01 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jan 2024 13:03:01 +0000 (GMT)
Message-ID: <b1ad9ed4-0924-4642-b49f-4cfc2daf2277@linux.ibm.com>
Date: Tue, 2 Jan 2024 08:03:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rootfs: Fix support for rootfstype= when root= is
 given
Content-Language: en-US
To: Rob Landley <rob@landley.net>, Askar Safin <safinaskar@gmail.com>
Cc: gregkh@linuxfoundation.org, initramfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        zohar@linux.ibm.com
References: <CAPnZJGDcNwPLbzC99qNQ+bRMwxPU-Z0xe=TD6DWQU=0MNyeftA@mail.gmail.com>
 <d4b227de-d609-aef2-888b-203dbcf06707@landley.net>
 <CAPnZJGBeV-E_AN8GnTfkaJvRtBmCeMYYCt+O0XMsc3kDULRuKg@mail.gmail.com>
 <fb776d99-1956-4e1b-9afc-84f27ca40f46@linux.ibm.com>
 <0879141d-462c-7e94-7c87-7a5b5422b8ed@landley.net>
 <e32077de-b159-4a7b-89a3-e1925239142f@linux.ibm.com>
 <fcb45898-0699-878f-0656-f570607fbed4@landley.net>
 <8b85253d-dd75-42e4-9a05-dafb3618269c@linux.ibm.com>
 <01010fbc-50d9-37f3-309c-f01643865ed9@landley.net>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <01010fbc-50d9-37f3-309c-f01643865ed9@landley.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ge-9UIqfqlcWxXM9PaU0BCbOVAiMLF8w
X-Proofpoint-GUID: XIyif6-oxoGOpbZfQcegi0ACz6aDZfdK
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_02,2024-01-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401020099



On 1/1/24 13:50, Rob Landley wrote:
> On 12/31/23 10:03, Stefan Berger wrote:
>>> Let me see if I understand your problem: it sounds like debian's initramfs-tools
>>> overloads the root= and rootfstype= arguments parsed by the kernel to have a
>>> second meaning (the kernel uses them for one thing, you want to use them for
>>> something else, and there's currently a semantic gap between the two.)
>>
>> My intention is to be able to pass rootfstype= to the kernel and have it
>> interpreted correctly in the presence of root=, which currently does not
>> work. User space tools that interpret the value of rootfstype= as if
>> this option belonged to user space is not helpful, though it should be
>> easy to teach the user space scripts to strip a leading 'tmpfs,' or
>> 'ramfs,' from the rootfstype value and let them interpret the rest.
> 
> Does your initramfs plumbing need to pass a rootfstype equivalent on to the
> userspace mount at all? In what cases does it not autodetect the type correctly?

The only change I needed was to have tmpfs used for the initramfs to 
enable xattrs. No other changes were needed in my case (OpenBMC/Yocto).

> 
> (Even NFS and SMB mounts are generally detectable because of the leading \\ or
> blah: although I suppose there are other network filesystem types that wouldn't
> be. Or if you wanted to micromanage the fat variant you were using...)
> 
> "rootfstype=" is the argument that tells the _kernel_ how to mount / and by the
> time init runs the kernel's already mounted what it's going to mount. The kernel
> only exposes one visible / mount to userspace, you don't return back into it and
> get another init launched running in a different root filesystem.
> 
>>> You want to add a new capability requiring a new build dependency in the
>>> initramfs-tools package because it's doing new stuff, but there cannot be any
>>> OTHER changes made to initramfs-tools, so the kernel should change its existing
>>> semantics instead.
>>
>> I haven't even thought of what would need to be added to Debian's
>> initramfs-tools package since my primary goal was to enable tmpfs for
>> the initramfs on OpenBMC where we then read the xattr values from a file
>> and write them into the filesystem because cpio format doesn't carry
>> them.
> 
> Me, I'd have a simple initramfs extract/decrypt a tarball with the filesystem
> that needs xattr values into a new tmpfs mount and switch_root to that. But I
> tend to statically link an initramfs into the kernel image when I want to be
> sure what it's running, and have never quite been clear on the benefit of
> _additionally_ verifying data that originates from within the kernel image. (If
> they can change that, they can change ring 0 code.)
> 
> Still, adding xattr support to cpio comes up a lot. It seems like a couple days

Let's see where we can take this next now that we will have xattr 
support via tmpfs for the initramfs.

    Stefan


> work tops, maybe the interested parties should do a video conference thingy,
> hammer out the details, and come up with a patch to add support? The userspace
> side sounds easy enough, I added xattr support to toybox tar in 2021 in a
> weekend, and have sent "would you like to keep up with toybox" patches at the
> busybox guys semi-regularly.
> 
> I even poked coreutils about feature parity once (the Android guys asked me to),
> which they said they would like to add, but which but still isn't in years later:
> 
> https://lists.gnu.org/archive/html/coreutils/2023-08/msg00009.html
> https://lists.gnu.org/archive/html/coreutils/2023-08/msg00100.html
> 
> But eh, I'm used to that with 30 year old projects licensed under copyleft...
> 
>> Also, I didn't expect that any user space tools would try to
>> handle a kernel command line option as if it was theirs.
> 
> Debian predates the 1.0 kernel release, so has some historical design baggage.
> That's why it's I tend to check them for snags in this area.
> 
>>> You can't NOT provide root=, and you can't provide initramfstype=tmpfs...
>>
>> I only know about rootfstype= (
>> https://github.com/torvalds/linux/blob/master/init/do_mounts.c#L128 ).
>> If currently handling of rootfstype= in presence of root= is not
>> considered a bug and we should introduce initramfstype= instead, we
>> could do that. But doesn't this become a bit confusing if rootfstype=
>> can be passed when root= is absent but then initramfstype= must be used
>> when root= is present?
> 
> I personally think having two would be confusing, and changing the existing API
> without adding new capabilities is pointless.
> 
>> This is 'our' patch describing the issue:
>> https://github.com/torvalds/linux/blob/master/init/do_mounts.c#L128
>>
>>> either, and those are the two existing ways to tell rootfs to be tmpfs instead
>>> of ramfs. You'd like to add a third way to specify the same thing.
>>
>> Do you have a link to initramfstype= handling in kernel code?
> 
> No, it's never done that. There was a suggestion to do that earlier in this thread:
> 
> https://lkml.iu.edu/hypermail/linux/kernel/2312.2/07060.html
> 
> And I thought it was a bad idea. The submitter agreed it was a bad idea. (Over
> the holidays I've haven't been paying close attention and threads tend to bleed
> together, sorry. :)
> 
> The answer to my "do I have this right" question was, apparently, "no". I mixed
> together what two different people wanted...
> 
> Rob


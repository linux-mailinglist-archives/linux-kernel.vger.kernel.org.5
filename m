Return-Path: <linux-kernel+bounces-48817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4651C8461FA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B72EEB2740A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA92A26AFC;
	Thu,  1 Feb 2024 20:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oN9iycUb"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58B211734;
	Thu,  1 Feb 2024 20:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706819761; cv=none; b=Tziw7CbjNdhzVkmo5p8YMMSQ6h+0Hrr2adpNimHa03yLFw8ABe3czO7zq799HbZHt5RmEERzX4bcJ5hGSsc8VrcrNhrFS4MZrRqXp2/UeAKe1w/Kdm8HZQ1S3J3f96dIqXygXLOnC/9Hzs4rZ+TPfIpofKL5h4hE5pz3NqvndDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706819761; c=relaxed/simple;
	bh=hs57Z2mkpRZQ6il4JKQzEbkvWqBwM6QammxS9t2WJGc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZgKvM+fyuA8bd64ykeWldZEBZbcsAn5jExco6pbq5km+ShF/cBL/YNY5XIKIwQAPZfICX/5wRgX/SeZaBxhd6Gpgrk8ILnNi0+IjIDdbQaolB/0X/Bqq3kSfbhsnEBc1n2kDDhrQxYjTKOZglsOC+5jDkupmpgT1sm6cjTqYMXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oN9iycUb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 411Ihw9m010491;
	Thu, 1 Feb 2024 20:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ZrpJNL6iZEPA6sQR29LIEXHnuVthFhNaoZsbeCfxhfs=;
 b=oN9iycUbFTtYHnOxmm2jCylvqah/KT6MPBH1/y4t174Xf3zqy0E0BlQ9EltQFSENvQ3J
 yhScRFsBDQGnmwK6wWp6mZHXi0sdpSpfULab+uWkONye4a9fkZ2gXotC/HII46LwnBYG
 2XBMt9g2VsfTXF8fqU7N2Y7LKTyQcgT03oy+k3vHv+/eiNyyTOZ9spSDPjnzLGxkNbOF
 hXyi/evkcod01X510kin+pdkE7qhXmsE6DDvpC50yRYacqkIZuYwf9LFkQH+SXta4TgB
 rHIPIGX3nr/nm1LY1KabaOlSqm/r+pg9cFp93QcGVo/9GFL9GHi5QNNM4FyzgJXZKBOm iA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0gu0tpf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 20:35:39 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 411KMi09030948;
	Thu, 1 Feb 2024 20:35:38 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0gu0tpen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 20:35:38 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 411KGGY9017772;
	Thu, 1 Feb 2024 20:35:37 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwcj06yuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 20:35:37 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 411KZb6360621160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Feb 2024 20:35:37 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7118858059;
	Thu,  1 Feb 2024 20:35:37 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7125058043;
	Thu,  1 Feb 2024 20:35:36 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Feb 2024 20:35:36 +0000 (GMT)
Message-ID: <11abffea-15c5-4d13-9d0f-edbc54b09bf3@linux.ibm.com>
Date: Thu, 1 Feb 2024 15:35:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] evm: Use the real inode's metadata to calculate
 metadata hash
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, roberto.sassu@huawei.com, miklos@szeredi.hu
References: <20240130214620.3155380-1-stefanb@linux.ibm.com>
 <20240130214620.3155380-5-stefanb@linux.ibm.com>
 <38230b4c-54ae-45ed-a6fb-34e63501e5b1@linux.ibm.com>
 <CAOQ4uxiYARZBSgzb4_W-RKvB1XLSF3GUBqeLw2kH+eVeZ_8ARQ@mail.gmail.com>
 <c018b014-9ba8-4395-86dc-b61346ab20a8@linux.ibm.com>
 <CAOQ4uxi6Te8izWpXROthknRaXrVA9jho5nbc+mkuQDrcTLY44Q@mail.gmail.com>
 <CAOQ4uxigdNeE+2nfr4VxS9piQf5hez=ryT0a-jzW+tW0BT-zuw@mail.gmail.com>
 <492ea12a-d79d-47da-9bbe-a7f33051bd3f@linux.ibm.com>
 <CAOQ4uxgiO1RbsmqOu4F4Foy-MBPecnEXO7BvgDGz-Lzb1Eysog@mail.gmail.com>
 <4c584bfb-d282-4584-bb20-18c26b1033c0@linux.ibm.com>
 <CAOQ4uxjftr7GGx6tuW_yB_MTaVB57m6p_d=UHhN3Z23YVXY0QQ@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAOQ4uxjftr7GGx6tuW_yB_MTaVB57m6p_d=UHhN3Z23YVXY0QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m3G5nDwEVM1jNBhuJVWhwtN7eoS9U_6p
X-Proofpoint-ORIG-GUID: nu2JHyXDCUYWUejiUxydbyDNmxXHCEt2
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
 definitions=2024-02-01_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402010159



On 2/1/24 09:11, Amir Goldstein wrote:
> On Thu, Feb 1, 2024 at 3:37 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>
>>
>> On 2/1/24 07:10, Amir Goldstein wrote:
>>> On Wed, Jan 31, 2024 at 7:46 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 1/31/24 12:23, Amir Goldstein wrote:
>>>>> On Wed, Jan 31, 2024 at 5:54 PM Amir Goldstein <amir73il@gmail.com> wrote:
>>>>>>
>>>>>> On Wed, Jan 31, 2024 at 4:40 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 1/31/24 08:16, Amir Goldstein wrote:
>>>>>>>> On Wed, Jan 31, 2024 at 4:11 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 1/30/24 16:46, Stefan Berger wrote:
>>>>>>>>>> Changes to the file attribute (mode bits, uid, gid) on the lower layer
>>>>>>>>>> are not take into account when d_backing_inode() is used when a file is
>>>>>>>>>> accessed on the overlay layer and this file has not yet been copied up.
>>>>>>>>>> This is because d_backing_inode() does not return the real inode of the
>>>>>>>>>> lower layer but instead returns the backing inode which holds old file
>>>>>>>>>> attributes. When the old file attributes are used for calculating the
>>>>>>>>>> metadata hash then the expected hash is calculated and the file then
>>>>>>>>>> mistakenly passes signature verification. Therefore, use d_real_inode()
>>>>>>>>>> which returns the inode of the lower layer for as long as the file has
>>>>>>>>>> not been copied up and returns the upper layer's inode otherwise.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>>>>>>>> ---
>>>>>>>>>>       security/integrity/evm/evm_crypto.c | 2 +-
>>>>>>>>>>       1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
>>>>>>>>>> index b1ffd4cc0b44..2e48fe54e899 100644
>>>>>>>>>> --- a/security/integrity/evm/evm_crypto.c
>>>>>>>>>> +++ b/security/integrity/evm/evm_crypto.c
>>>>>>>>>> @@ -223,7 +223,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
>>>>>>>>>>                                    size_t req_xattr_value_len,
>>>>>>>>>>                                    uint8_t type, struct evm_digest *data)
>>>>>>>>>>       {
>>>>>>>>>> -     struct inode *inode = d_backing_inode(dentry);
>>>>>>>>>> +     struct inode *inode = d_real_inode(dentry);
>>>>>>>>>>           struct xattr_list *xattr;
>>>>>>>>>>           struct shash_desc *desc;
>>>>>>>>>>           size_t xattr_size = 0;
>>>>>>>>>
>>>>>>>>> We need this patch when NOT activating CONFIG_OVERLAY_FS_METACOPY but
>>>>>>>>> when setting CONFIG_OVERLAY_FS_METACOPY=y it has to be reverted...  I am
>>>>>>>>> not sure what the solution is.
>>>>>>>>
>>>>>>>> I think d_real_inode() does not work correctly for all its current users for
>>>>>>>> a metacopy file.
>>>>>>>>
>>>>>>>> I think the solution is to change d_real_inode() to return the data inode
>>>>>>>> and add another helper to get the metadata inode if needed.
>>>>>>>> I will post some patches for it.
>>>>>>>
>>>>>>> I thought that we may have to go through vfs_getattr() but even better
>>>>>>> if we don't because we don't have the file *file anywhere 'near'.
>>>>>>>
>>>>>>>>
>>>>>>>> However, I must say that I do not know if evm_calc_hmac_or_hash()
>>>>>>>> needs the lower data inode, the upper metadata inode or both.
>>>>>>>
>>>>>>> What it needs are data structures with mode bits, uid, and gid that stat
>>>>>>> in userspace would show.
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> With or without metacopy enabled, an overlay inode st_uid st_gid st_mode
>>>>>> are always taken from the upper most inode which is what d_real_inode()
>>>>>> currently returns, so I do not understand what the problem is.
>>>>>>
>>>>>
>>>>> No, I was wrong. It is the other way around.
>>>>> d_real_inode() always returns the real data inode and you need the
>>>>> upper most real inode.
>>>>>
>>>>> You can try this:
>>>>>
>>>>>     -     struct inode *inode = d_backing_inode(dentry);
>>>>> +     struct inode *inode = d_inode(d_real(dentry, false));
>>>>>
>>>>> With the changes in:
>>>>>
>>>>> https://github.com/amir73il/linux/commits/overlayfs-devel/
>>>>>
>>>>> Not thoroughly tested...
>>>>
>>>> The change + 3 topmost patches cherry-picked is unfortunately are
>>>> crashing for me.
>>>>
>>>
>>> I will look into it.
>>> But anyway, the patch I suggested above is not enough exactly because
>>> of the reason I told you earlier.
>>>
>>> Mimi's fix ("ima: detect changes to the backing overlay file") detects
>>> a change in d_real_inode(file_dentry(file)) in order to invalidate the
>>> IMA cache.
>>>
>>> Your change also invalidates EVM cache on a change in
>>> d_real_inode(file_dentry(file)) and that makes sense.
>>>
>>> But on "meta copy up" for example on chmod(), an upper inode with no data
>>> is created (a metacopy) and all the attributes and xattr are copied
>>> from lower inode.
>>> The data remains in the lower inode.
>>>
>>> At this point , the IMA cache and the EVM cache refer to two different inodes
>>
>> You mean they refer to different inodes because IMA cares about file
>> content ("data remains in the lower inode:) and EVM cares about the
>> metadata ("an upper inode with no data is created")? If so, I agree
> 
> Correct.
> 
>> since the following line after copy-up with meatacopy enabled shows the
>> proper GID is in the backing inode not the one return from
>> d_real_inode(). If we knew that a meta copy has been done we could call
>> d_backing_inode() in this case for access to mode bits, uid, and gid.
>>
> 
> You should be able to use
> d_real_meta_inode(dentry) != d_real_inode(dentry) to figure that out.
> 
>> +       printk(KERN_INFO "real: GID: %d  backing: GID: %d\n",
>> +              from_kgid(&init_user_ns, d_real_inode(dentry)->i_gid),
>> +              from_kgid(&init_user_ns, d_backing_inode(dentry)->i_gid));
>> +
>>
>>   > so you cannot share the same logic with IMA cache invalidation.
>>
>> I thought we we would have to share the same logic since IMA and EVM
>> would have to refer to the same inode also since IMA and EVM are
>> strongly connected. So the file_inode(file), which is typically used for
>> finding the iint, should be the same 'high level' inode for both EVM and
>> IMA I thought. A different inode could then be used for file data and
>> metadata.
>>
>>>
>>> My patches are meant to provide you with a helper e.g. d_real_meta_inode()
>>
>> The patch providing this isn't there yet in overlayfs-devel, right?
> 
> It's there just not spelled out with these helper names:
> 
> d_real_meta_inode(d) := d_inode(d_real(dentry, false))
> d_real_data_inode(d) := d_inode(d_real(dentry, true))
> d_real_inode(d) := d_real_data_inode(d)
> 
> I think this use case is pretty specific to EVM, so I don't think
> I will actually define these d_real_*_inode() helpers.
> 
>>
>>> that you could use to get the upper inode in the case of a metacopy, but
>>> IMA would still need to use the d_real_data_inode().
>>
>> That would be fine since we are only changing EVM code in this case.
> 
> Yes, using those overlayfs APIs requires understanding of what they mean
> and knowing how to test the affected use cases.
> This is not something very common for other subsystem developers.
> 
>>>
>>> Is that explanation clear? Is it clear why I said that the problem is more
>>> complicated?
>>
>> I think I understand it.
>>
> 
> I think I am also starting to understand the expectation from IMA/EVM
> over overlayfs ;)
> 
> Anyway, let me see if I can fix the problem in my WIP branch.

The good news is that with your two patches applied :

3b0ed3977dd2 (HEAD) fs: make file_dentry() a simple accessor
b5ccc40f3d50 fs: remove the inode argument to ->d_real() method

and your suggested change to this patch :

-       struct inode *inode = d_real_inode(dentry);
+       struct inode *inode = d_inode(d_real(dentry, false));;


The test cases are now passing with and without metacopy enabled. Yay!

Your 3rd patch causes crashes..

    Stefan


> 
> Thanks,
> Amir.


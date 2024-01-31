Return-Path: <linux-kernel+bounces-46928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 253B3844672
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BE23B278D1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6648712DDB9;
	Wed, 31 Jan 2024 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dXbuB0td"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEB884A2D;
	Wed, 31 Jan 2024 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723227; cv=none; b=nv2N0LAW8kIRxA0hxmQXKlwDD+xEy2VHDveXkmpUWXa/6SKY4U32n1o0J9+yTIXNXol9jxYFhABEb3VnZXLDD5I+hZxkxm4/QDiTcka0RKYDUYhmj2YQt7p+n7BG2ONPqT0wexjAeSMXNOupxdTIWK/e0+1ht873EyPgL/9peIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723227; c=relaxed/simple;
	bh=Ipedpefq4J3h0S5ip6WRcAR6sx6WUus8M+dhnFhaTMI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S5xo8q2j5YIFdHGN1sOUZYCqskElbJqYnwuAjh0nLyxutVPcMuLX0DWx5lXq8DRfe8aAWFDFV2TbRRtV9BC1CR/cFU5P6ZeZEZxtfxNrv7xpxsiktB4NepTAh+lO71X3ykt6iISjOXwSvZbdq016djzqwNBvMugfSiNCVylx71Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dXbuB0td; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VHhFi0019116;
	Wed, 31 Jan 2024 17:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=NFjD52f4SHbNPOmvNdYtxgXBLMsyMtRwSKo6DB50NP0=;
 b=dXbuB0tdliph9fccSmIeY93/QeV/rQNMPoEi17tJL1sMDseHSlzjI3yJ4jRM54FNLnsE
 C9n+/RRk/dqLoDtAovHOnAaiC8xo5bkR1HPAYt7Fwz4ETBZCDleA1izJJCEaaAZujOi2
 eD1m+8fZb4XdHR2IHmGA6Av6eZqRf4ivr/TLvA1rVV8kqkR76irTIURRVvQ+oHR5dAj8
 fkPMjoCcg0Dueuvoa/udSemzpqRTpiogDDKGVhrNZxSIimoQh6VmYiRMzb7e58wH7qzU
 OKmVl9dthIWKWSru1qaRXZL5HqqkZUAP0kB556nT7lzkm7H+zT9KqrUIMFDb+A1R0Wqu DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyq9jyp3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 17:46:54 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40VH20kj004144;
	Wed, 31 Jan 2024 17:46:53 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyq9jyp3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 17:46:53 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40VGo9Zw002223;
	Wed, 31 Jan 2024 17:46:52 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwc5tf67s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 17:46:52 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40VHkqTP18285300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 17:46:52 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE1AA5804E;
	Wed, 31 Jan 2024 17:46:51 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9666B5803F;
	Wed, 31 Jan 2024 17:46:50 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 31 Jan 2024 17:46:50 +0000 (GMT)
Message-ID: <492ea12a-d79d-47da-9bbe-a7f33051bd3f@linux.ibm.com>
Date: Wed, 31 Jan 2024 12:46:50 -0500
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
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAOQ4uxigdNeE+2nfr4VxS9piQf5hez=ryT0a-jzW+tW0BT-zuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7b2cI1DQjEJF3D80dF401hk10E4NsNaE
X-Proofpoint-ORIG-GUID: 5CB92-9YJr2vJe3J9Y6JeLhe9Im44Afu
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
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401310137



On 1/31/24 12:23, Amir Goldstein wrote:
> On Wed, Jan 31, 2024 at 5:54 PM Amir Goldstein <amir73il@gmail.com> wrote:
>>
>> On Wed, Jan 31, 2024 at 4:40 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>>
>>>
>>>
>>> On 1/31/24 08:16, Amir Goldstein wrote:
>>>> On Wed, Jan 31, 2024 at 4:11 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 1/30/24 16:46, Stefan Berger wrote:
>>>>>> Changes to the file attribute (mode bits, uid, gid) on the lower layer
>>>>>> are not take into account when d_backing_inode() is used when a file is
>>>>>> accessed on the overlay layer and this file has not yet been copied up.
>>>>>> This is because d_backing_inode() does not return the real inode of the
>>>>>> lower layer but instead returns the backing inode which holds old file
>>>>>> attributes. When the old file attributes are used for calculating the
>>>>>> metadata hash then the expected hash is calculated and the file then
>>>>>> mistakenly passes signature verification. Therefore, use d_real_inode()
>>>>>> which returns the inode of the lower layer for as long as the file has
>>>>>> not been copied up and returns the upper layer's inode otherwise.
>>>>>>
>>>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>>>> ---
>>>>>>     security/integrity/evm/evm_crypto.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
>>>>>> index b1ffd4cc0b44..2e48fe54e899 100644
>>>>>> --- a/security/integrity/evm/evm_crypto.c
>>>>>> +++ b/security/integrity/evm/evm_crypto.c
>>>>>> @@ -223,7 +223,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
>>>>>>                                  size_t req_xattr_value_len,
>>>>>>                                  uint8_t type, struct evm_digest *data)
>>>>>>     {
>>>>>> -     struct inode *inode = d_backing_inode(dentry);
>>>>>> +     struct inode *inode = d_real_inode(dentry);
>>>>>>         struct xattr_list *xattr;
>>>>>>         struct shash_desc *desc;
>>>>>>         size_t xattr_size = 0;
>>>>>
>>>>> We need this patch when NOT activating CONFIG_OVERLAY_FS_METACOPY but
>>>>> when setting CONFIG_OVERLAY_FS_METACOPY=y it has to be reverted...  I am
>>>>> not sure what the solution is.
>>>>
>>>> I think d_real_inode() does not work correctly for all its current users for
>>>> a metacopy file.
>>>>
>>>> I think the solution is to change d_real_inode() to return the data inode
>>>> and add another helper to get the metadata inode if needed.
>>>> I will post some patches for it.
>>>
>>> I thought that we may have to go through vfs_getattr() but even better
>>> if we don't because we don't have the file *file anywhere 'near'.
>>>
>>>>
>>>> However, I must say that I do not know if evm_calc_hmac_or_hash()
>>>> needs the lower data inode, the upper metadata inode or both.
>>>
>>> What it needs are data structures with mode bits, uid, and gid that stat
>>> in userspace would show.
>>>
>>>
>>
>> With or without metacopy enabled, an overlay inode st_uid st_gid st_mode
>> are always taken from the upper most inode which is what d_real_inode()
>> currently returns, so I do not understand what the problem is.
>>
> 
> No, I was wrong. It is the other way around.
> d_real_inode() always returns the real data inode and you need the
> upper most real inode.
> 
> You can try this:
> 
>   -     struct inode *inode = d_backing_inode(dentry);
> +     struct inode *inode = d_inode(d_real(dentry, false));
> 
> With the changes in:
> 
> https://github.com/amir73il/linux/commits/overlayfs-devel/
> 
> Not thoroughly tested...

The change + 3 topmost patches cherry-picked is unfortunately are 
crashing for me.

FYI - in case you are interested: My tests running this with UML are here:

repo: https://github.com/stefanberger/ima-namespaces-tests.git
branch: overlayfs

There's a UML config in config/config.uml
Compiler kernel with this series applied: make ARCH=um -j128  && yes | 
cp linux /usr/local/bin/linux

sudo IMA_TEST_UML=/usr/local/bin/linux IMA_TEST_VERBOSE=0 
evm+overlayfs-1/test.sh
sudo IMA_TEST_UML=/usr/local/bin/linux IMA_TEST_VERBOSE=0 
evm+overlayfs-2/test.sh
sudo IMA_TEST_UML=/usr/local/bin/linux IMA_TEST_VERBOSE=0 
evm+overlayfs-3/test.sh

The 2nd and 3rd test case will fail at some point when metacopy is 
enabled, otherwise they will all pass.

> 
> Thanks,
> Amir.
> 


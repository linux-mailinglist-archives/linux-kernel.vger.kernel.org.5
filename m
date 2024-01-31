Return-Path: <linux-kernel+bounces-46624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A8C844223
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A8628712A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A48F84A35;
	Wed, 31 Jan 2024 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HDsD/c4E"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A4CFBF3;
	Wed, 31 Jan 2024 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712412; cv=none; b=IXBJ5vD0ChcsRcvgChoss9X7CaWPQd6W0nN3fQdeYcNe7BvdhyA+sVb8iBGyAlOWzVosctqLUQe1CvY60A5OlsDc9PIE1xxpuzXsQaU4qlWy43fF8HMPh9SwvuqUPomeO83bI05fQGsLHMcasC5wG5k2ArDjTGlEHuewVOGQiys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712412; c=relaxed/simple;
	bh=dRezcYdYLhpFsKr2NdLaq3DYfeOJBWWpX2zQQ1DPQKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5uNtQCDs8z8DXr3wxfaNeWbVTfAZ0IUZYAdSwYvpJuA/jHwNI4k9ovra0oJKR61TCDDrupAhMRa3X0DDlj17sYrY8gSiSteWhNOYSXGHmNJr8cJKhQjfV/pbRa8m+i5d2VUyocTjBFm4Fi5XFXqZrgZT0SHHdx0jm/MBp6kAOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HDsD/c4E; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VDeBQu019348;
	Wed, 31 Jan 2024 14:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wgccrFtt613FD3f0tbHr8qKSJoWVdVbUoodUYvH1tvw=;
 b=HDsD/c4EnXDTz0lvkSJZmWKwNRaZhHmrDOCW3j8Xm7ZxwtcWcJmfX04VtjrdV6+PM1zS
 +LWk2X5785a9z9vSaMXPrXUAp/qOYssysQHF+OecHwZfRJMlXOJ4O6u7V03X/BWAV20I
 2fohYXbJVyGpLuPQqUiqct4xqhjFOT/girgL8KDoPk3a197Cwbuxwf1c9K9URuXDeude
 gbNDAOl0viHLCf7G6uL+oWk//dCqDKScTL1cYz1eX3sAJB24e5U1e/KS4bXTBJgPmj8a
 0bqHfk+3cY9Kc7nPMxKHtBJwep3bNmVxaokOMNSMcjqGq87HdiMY44IfGgCX34aMhnq/ Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyq9jt2g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 14:46:32 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40VEU2ZE007411;
	Wed, 31 Jan 2024 14:46:31 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyq9jt2fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 14:46:31 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40VEZ9o0017723;
	Wed, 31 Jan 2024 14:46:31 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwchyx5e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 14:46:31 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40VEkU6M57016680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 14:46:30 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86B1458055;
	Wed, 31 Jan 2024 14:46:30 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BA215804E;
	Wed, 31 Jan 2024 14:46:25 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 31 Jan 2024 14:46:25 +0000 (GMT)
Message-ID: <c4dc6344-445c-44b8-b5ea-2eb8e2d051d1@linux.ibm.com>
Date: Wed, 31 Jan 2024 09:46:24 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ima: Reset EVM status upon detecting changes to
 overlay backing file
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, roberto.sassu@huawei.com, miklos@szeredi.hu,
        Christian Brauner <brauner@kernel.org>
References: <20240130214620.3155380-1-stefanb@linux.ibm.com>
 <20240130214620.3155380-4-stefanb@linux.ibm.com>
 <CAOQ4uxjC=-GOFi3J4ctcNgdMfaerkae30OH9=TkKTWCf=TP95g@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAOQ4uxjC=-GOFi3J4ctcNgdMfaerkae30OH9=TkKTWCf=TP95g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NWIO3KIocDpIpKqDbuta9d1ypXNVnaIF
X-Proofpoint-ORIG-GUID: ixlWU0_8sPCweEQ69zy3CM3YItVpUlUR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=835 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401310113



On 1/31/24 08:56, Amir Goldstein wrote:
> On Tue, Jan 30, 2024 at 11:46 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>> To avoid caching effects to take effect reset the EVM status upon
>> detecting changes to the overlay backing files. This prevents a not-yet-
>> copied-up file on the overlay from executing if for example the
>> security.evm xattr on the file on the 'lower' layer has been removed.
>>
> 
> And what is expected to happen when file is executed after copy up?

The copy-up may be triggered by changing file content or file metadata.
For EVM file metadata (file attributes and xattrs) are important and if 
they change EVM would re-evaluate the file, meaning that it would 
determine the file mode bits, uid, gid and xattrs and calculate a hash 
over them and compare this hash against the signature in security.evm.

> Doesn't this change also protect the same threat after copy up?

 From what I remember from my testing is that file attribute or extended 
attribute changes on an already copied-up file were already handled 
correctly, meaning they caused the re-evaluation of the file as 
described above.

> 
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   include/linux/evm.h               | 8 ++++++++
>>   security/integrity/evm/evm_main.c | 7 +++++++
>>   security/integrity/ima/ima_main.c | 2 ++
>>   3 files changed, 17 insertions(+)
>>
>> diff --git a/include/linux/evm.h b/include/linux/evm.h
>> index d8c0343436b8..e7d6742eee9d 100644
>> --- a/include/linux/evm.h
>> +++ b/include/linux/evm.h
>> @@ -66,6 +66,8 @@ extern int evm_protected_xattr_if_enabled(const char *req_xattr_name);
>>   extern int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
>>                                       int buffer_size, char type,
>>                                       bool canonical_fmt);
>> +extern void evm_reset_cache_status(struct dentry *dentry,
>> +                                  struct integrity_iint_cache *iint);
>>   #ifdef CONFIG_FS_POSIX_ACL
>>   extern int posix_xattr_acl(const char *xattrname);
>>   #else
>> @@ -189,5 +191,11 @@ static inline int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
>>          return -EOPNOTSUPP;
>>   }
>>
>> +static inline void evm_reset_cache_status(struct dentry *dentry,
>> +                                         struct integrity_iint_cache *iint)
>> +{
>> +       return;
>> +}
>> +
>>   #endif /* CONFIG_EVM */
>>   #endif /* LINUX_EVM_H */
>> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
>> index 22a5e26860ea..e96d127b48a2 100644
>> --- a/security/integrity/evm/evm_main.c
>> +++ b/security/integrity/evm/evm_main.c
>> @@ -721,6 +721,13 @@ static void evm_reset_status(struct inode *inode)
>>                  iint->evm_status = INTEGRITY_UNKNOWN;
>>   }
>>
>> +void evm_reset_cache_status(struct dentry *dentry,
>> +                           struct integrity_iint_cache *iint)
>> +{
>> +       if (d_real_inode(dentry) != d_backing_inode(dentry))
>> +               iint->evm_status = INTEGRITY_UNKNOWN;
>> +}
>> +
>>   /**
>>    * evm_revalidate_status - report whether EVM status re-validation is necessary
>>    * @xattr_name: pointer to the affected extended attribute name
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index cc1217ac2c6f..84bdc6e58329 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -26,6 +26,7 @@
>>   #include <linux/ima.h>
>>   #include <linux/fs.h>
>>   #include <linux/iversion.h>
>> +#include <linux/evm.h>
>>
>>   #include "ima.h"
>>
>> @@ -295,6 +296,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
>>                      !inode_eq_iversion(backing_inode, iint->version)) {
>>                          iint->flags &= ~IMA_DONE_MASK;
>>                          iint->measured_pcrs = 0;
>> +                       evm_reset_cache_status(file_dentry(file), iint);
>>                  }
>>          }
> 
> Make sense.
> Unrelated to your change, I now noticed something odd about Mimi's change:
> 
>          backing_inode = d_real_inode(file_dentry(file));
> 
> I find the choice of variable name to be quite confusing, because ima/evm code
> uses  d_backing_inode() all over the place and d_real_inode() !=
> d_backing_inode().
> 
> First of all, there is never any reason to use d_backing_inode() and its name is
> quite confusing in the first place, but it will be a big cleanup to
> remove them all.
> 
> Suggest to rename the variable to real_inode, same as in
> ima_collect_measurement()
> to be consistent and reduce confusion factor, which is already high enough ;)
> 
> Thanks,
> Amir.


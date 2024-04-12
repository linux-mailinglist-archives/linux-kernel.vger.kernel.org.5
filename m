Return-Path: <linux-kernel+bounces-143240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0532D8A3631
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C001F23964
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D4E14F9DF;
	Fri, 12 Apr 2024 19:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XjGhncbS"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9C21487CB;
	Fri, 12 Apr 2024 19:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712948955; cv=none; b=OzXuQsfbwbGtxI/6ptUhmHwaJZwKhuArQs9X1IDvDZ0nYYjZN8kE6z7jJA6cbChp0SaHynIjgsoFDNgI1fS5Epdor9KbFs2zJUrt+QHPuJxUCpwVcOWTP8Go/gU+tWJpeoE7nSiSlQW7+NGzxSB1W9POhXG/piwUVCdvWyaGF08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712948955; c=relaxed/simple;
	bh=jz3gOrjR0kAdrw+sakHPNu/cSUP8HYvdH4a/SSQMslE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wjb/iBBfZ+A3Zcfj/ufWXccPig4Qt47pCk0Np8AYGH+R9JRlb7AY1kBvlqwgZGqE78XCBOigXxXBt0ISkP40gvrj9Jw0qUmtpH5vnxm4mCC2gJnmWp2lgChGeekIP3dJ1kNy058rXnsiWUKPH+zYbmK0zX1kcqi3GdYfCahWSF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XjGhncbS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43CHQwSa005964;
	Fri, 12 Apr 2024 19:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=U5rFYlmdCzVROqFdptvkIiAyxLYeS5MFcfBO+auJlV4=;
 b=XjGhncbSNJm8EPJmyvIIyctAKe2F308TKiRub6TqPejdZSv7GWszv1DGxUymAyNKgvFJ
 XyhI8vcIdnJb8niyds5UTdxiHoR5lF2yhiOc+xNkfIMVeK1yvvMVpwvwhK3uIj5ppDJY
 dMe3WZxNiju+n9Ff2adk+V2l2sj1JcCLnpVN2k6FRBMwPGc5icIpu9Bk3+l3vGHtnVoG
 FGxCk4scLs+gbGVRrUOiW7F76QJg+XXLt/VfwOmpGmu0kaeS3U3pyAvf5Pcfb+mNuhW7
 fZhMA4Zkx4snj8Q1IoM+jlKzJEZIpoUYiRI91ix/6Ri37F3bcFumRCx00pQ25nkv6vRV BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xf6qv8jah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 19:09:00 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43CJ903I021823;
	Fri, 12 Apr 2024 19:09:00 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xf6qv8jag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 19:09:00 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43CHuCEx029951;
	Fri, 12 Apr 2024 19:08:58 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbj7mujeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 19:08:58 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43CJ8tJf28705444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 19:08:58 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACCE45804B;
	Fri, 12 Apr 2024 19:08:55 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF2845805B;
	Fri, 12 Apr 2024 19:08:54 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Apr 2024 19:08:54 +0000 (GMT)
Message-ID: <89b4fb29-5906-4b21-8b5b-6b340701ffe4@linux.ibm.com>
Date: Fri, 12 Apr 2024 15:08:54 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] ima: Fix detection of read/write violations on stacked
 filesystems
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, miklos@szeredi.hu,
        Christian Brauner <brauner@kernel.org>
References: <20240412140122.2607743-1-stefanb@linux.ibm.com>
 <20240412140122.2607743-3-stefanb@linux.ibm.com>
 <CAOQ4uxjDQO91cjA0sgyPStkwc_7+NxAOhyve94qUvXSM3ytk1g@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAOQ4uxjDQO91cjA0sgyPStkwc_7+NxAOhyve94qUvXSM3ytk1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aWGKuA4MpOnkWvqTY26m5s8jTg0zuj7J
X-Proofpoint-GUID: tvy2SPw98Eyp6wEA6jmYKRDVDtmt6wf9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_15,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 mlxlogscore=979 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404120139



On 4/12/24 14:08, Amir Goldstein wrote:
> On Fri, Apr 12, 2024 at 5:01 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>> On a stacked filesystem, when one process opens the file holding a file's
>> data (e.g., on upper or lower layer on overlayfs) then issue a violation
>> when another process opens the file for reading on the top layer (overlay
>> layer on overlayfs). This then provides similar behavior to the existing
>> case where a violation is generated when one process opens a file for
>> writing and another one opens the same file for reading. On stacked
>> filesystem also search all the lower layers for relevant files opened for
>> writing and issue the violation if one is found.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   security/integrity/ima/ima_main.c | 27 ++++++++++++++++++++++-----
>>   1 file changed, 22 insertions(+), 5 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index f04f43af651c..590dd9d5d99a 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -121,8 +121,11 @@ static void ima_rdwr_violation_check(struct file *file,
>>                                       const char **pathname,
>>                                       char *filename)
>>   {
>> +       struct inode *real_inode = d_real_inode(file_dentry(file));
>>          struct inode *inode = file_inode(file);
>> +       struct dentry *fd_dentry, *d;
>>          fmode_t mode = file->f_mode;
>> +       struct inode *fd_inode;
>>          bool send_tomtou = false, send_writers = false;
>>
>>          if (mode & FMODE_WRITE) {
>> @@ -134,11 +137,25 @@ static void ima_rdwr_violation_check(struct file *file,
>>                                                  &iint->atomic_flags))
>>                                  send_tomtou = true;
>>                  }
>> -       } else {
>> -               if (must_measure)
>> -                       set_bit(IMA_MUST_MEASURE, &iint->atomic_flags);
>> -               if (inode_is_open_for_write(inode) && must_measure)
>> -                       send_writers = true;
>> +       } else if (must_measure) {
>> +               set_bit(IMA_MUST_MEASURE, &iint->atomic_flags);
>> +
>> +               if (inode == real_inode) {
>> +                       if (inode_is_open_for_write(inode))
>> +                               send_writers = true;
>> +               } else {
>> +                       d = d_real(file_dentry(file), D_REAL_FILEDATA);
>> +                       do {
>> +                               fd_dentry = d;
>> +                               fd_inode = d_inode(fd_dentry);
>> +                               if (inode_is_open_for_write(fd_inode)) {
>> +                                       send_writers = true;
>> +                                       break;
>> +                               }
>> +                               /* next layer of stacked fs */
>> +                               d = d_real(fd_dentry, D_REAL_FILEDATA);
>> +                       } while (d != fd_dentry);
>> +               }
> 
> The idea of digging though ovl layers feels wrong to me.

I have a couple of test cases that expect violations to be logged. One 
test case has 2 overlay filesystems stacked on top of each other (lower 
= A, upper = B) and it passes those test cases when for example

- opening the file on lower on 'A' for writing
- opening the file on overlay layer on 'B' for reading

OR

- opening the file on overlay layer on 'A' (= lower layer of 'B') for 
writing
- opening the file on overlay layer on 'B' for reading



After causing a copy-up only the following test case causes a violation 
to be logged:

- opening the file on upper on 'B' for writing
- opening the file on overlay layer on 'B' for reading

No violation will the be logged for example for:

- opening the file on overlay layer on 'A' (= lower of 'B') for writing
- opening the file on overlay layer on 'B' for reading



> As Miklos is the designer of overlayfs and its vfs architecture,

I was hoping that this would be sufficiently generic to work with 
potential future stacked filesystems as well that would need to also 
provide support for D_REAL_FILEDATA.

> I am deferring the call about adding this interface to Miklos.
> 
> Thanks,
> Amir.
> 


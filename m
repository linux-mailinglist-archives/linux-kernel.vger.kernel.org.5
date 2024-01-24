Return-Path: <linux-kernel+bounces-36976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACA383A9BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FAB2B23912
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650B263127;
	Wed, 24 Jan 2024 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qknX1smj"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A762A1B;
	Wed, 24 Jan 2024 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099349; cv=none; b=J5LXjfFxkdFs7c2X3KRMSjSPBHuGUft/uVfCXB68pI4e2ePV1PYBsCxQ30lygXXI8dDyYi/1/GzL/kpZjf1qX42tQOTgjaaTNbsyYEtUulmBYolsyjZMUGc+RSQv4HE+IVjK0QbZYdZxfcOEbCrp4dg24mkOuSselBYS4Oqhul0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099349; c=relaxed/simple;
	bh=KTTT0hAREIReOX7Dh02jOmcOXgistX7i9o+5/GVJE7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=SbjstQjfTxaHnPtrqx0xI/jrxzIkiGKL1NDz+FG6ClWycIOfiOrDj3/EiqY1mO3LDAJpkpWNLekgHPTsZ13ORIkr/F0S0gYWyeNsgL+Rve5IqbLGaTIxX8P8RcTPDwNY7n2BoAI9V+FUuSexF0ddlU3mTCF5uLPsd7BDyKpRJJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qknX1smj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OCRBIQ000670;
	Wed, 24 Jan 2024 12:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=HfmJ1zK+NYQUvuNDkZxtMVy1ZxXi+1QuLnhuH4k6Wc0=;
 b=qknX1smjnCFSnSDdz9K7QQhxOvffIBFWq5bszAqGZgREnfJC2WHpDwKoewmnE7zAOrEd
 cv96AT28ONy20azi8cyhRJZwChyWfyApRdsi/tRuDjSPvvXdcXivjdh902lLCEcpjUcX
 JnBXfXaFpzeJrxK1RYM6ZHn82IdkOtXMVglDkZu0qCd9g6z9Li/EkVemFovO4kVAx4T0
 klFz4BfImXjGzbJDKtr8shHmjg7C36MYJ1eHQjq5Vbm8KjauYTzw9LfHBkwilwXBkgR8
 xgaYKw+3jpdurCVANzd1ZHGfK1QuYAHNBdQR9UVqYnqMvfZ/7FNNz1QNx+q255txkfTm 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vu2bx8bmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 12:28:36 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40OCRFSK001378;
	Wed, 24 Jan 2024 12:28:33 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vu2bx8bdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 12:28:33 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40OBj9eu025285;
	Wed, 24 Jan 2024 12:28:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrtqkdcas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 12:28:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40OCST0T44630396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 12:28:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 354182005A;
	Wed, 24 Jan 2024 12:28:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3AE52004E;
	Wed, 24 Jan 2024 12:28:28 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 24 Jan 2024 12:28:28 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox
 <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>, Yu Zhao
 <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman
 Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>, "Huang, Ying" <ying.huang@intel.com>,
        Zi Yan <ziy@nvidia.com>, Luis
 Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama
 <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang
 <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>, Alistair
 Popple <apopple@nvidia.com>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v9 02/10] mm: Non-pmd-mappable, large folios for
 folio_add_new_anon_rmap()
In-Reply-To: <edfade67-269e-4a49-8db6-40617131e283@arm.com> (Ryan Roberts's
	message of "Wed, 24 Jan 2024 12:17:23 +0000")
References: <20231207161211.2374093-1-ryan.roberts@arm.com>
	<20231207161211.2374093-3-ryan.roberts@arm.com>
	<ZaMR2EWN-HvlCfUl@krava>
	<41dc7dff-1ea8-4894-a487-88d46ec2b2d8@redhat.com>
	<ZaRKMwKJIBmh8-lD@krava>
	<1188e67e-5c04-4bb5-b242-78d92c3fc85c@arm.com>
	<yt9d1qa7x9qv.fsf@linux.ibm.com> <ZbDyLzoIm0GdQzZA@krava>
	<6caaced7-a9d7-4fe4-823a-11b96be83e46@arm.com>
	<ZbD9YdCmZ3_uTj_k@krava>
	<edfade67-269e-4a49-8db6-40617131e283@arm.com>
Date: Wed, 24 Jan 2024 13:28:28 +0100
Message-ID: <yt9dcytqx6dv.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 71MAZEQhl-TgTZUFZ5x0IfXxNuyTFLM2
X-Proofpoint-GUID: XxYJdeAV-7Gfh8Dc8S5zxblSgDXROtE4
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=893 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240090

Hi Ryan,

Ryan Roberts <ryan.roberts@arm.com> writes:

>>>>>>>>> I'm hitting this bug (console output below) with adding uprobe
>>>>>>>>> on simple program like:
>>>>>>>>>
>>>>>>>>>    $ cat up.c
>>>>>>>>>    int main(void)
>>>>>>>>>    {
>>>>>>>>>       return 0;
>>>>>>>>>    }
>>>>>>>>>
>>>>>>>>>    # bpftrace -e 'uprobe:/home/jolsa/up:_start {}'
>>>>>>>>>
>>>>>>>>>    $ ./up
>>>>>>>>>
>>>>>>>>> it's on top of current linus tree master:
>>>>>>>>>    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat
>>>>>>>>>
>>>>>>>>> before this patch it seems to work, I can send my .config if needed
>>>>>>
>>>>>> Thanks for the bug report!
>>>>>
>>>>> I just hit the same bug in our CI, but can't find the fix in -next. Is
>>>>> this in the queue somewhere?
>>>>
>>>> we hit it as well, but I can see the fix in linux-next/master
>>>>
>>>>   4c137bc28064 uprobes: use pagesize-aligned virtual address when replacing pages
>>>
>>> Yes that's the one. Just to confirm: you are still hitting the VM_BUG_ON despite
>>> having this change in your kernel? Could you please send over the full bug log?
>> 
>> ah sorry.. I meant the change fixes the problem for us, it just did not
>> yet propagate through the merge cycle into bpf trees.. but I can see it
>> in linux-next tree, so it's probably just matter of time
>
> OK great! How about you, Sven? Do you have this change in your kernel? Hopefully
> it should fix your problem.

Same here - the fix makes uprobes work again, i just didn't see it in
torvalds-master and neither in todays linux-next. But Jiri is right,
it's in linux-next/master. I just missed to find it there. So everything
should be ok.


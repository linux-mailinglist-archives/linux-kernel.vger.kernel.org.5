Return-Path: <linux-kernel+bounces-138880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9A989FB99
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B631F2212A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3FC16EBED;
	Wed, 10 Apr 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qViPEqHI"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9FB15B137;
	Wed, 10 Apr 2024 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763076; cv=none; b=dZy5fWsORkYP1p9y2V0qsLysqlHv0HDbMi7oaV5D5fh2/Iq4jAgE0Tu/w4dRMalUVtXicd0VvkIkM5YjQKJgrFw7yQjVXYoRGFCKwkNZwFlSXLBQN17qJDzya+McYjEMPWkxHGyqU8+eWmlEDU5VGwa4BNEwSfPvlaCIfoP4ecg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763076; c=relaxed/simple;
	bh=pH+z7kT+B4G554baL6gQ+2qPvr9hlaRu9zM0ygTBqww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkHfowmXKOPXoI0lOHPSqwzbmJrMpLbLFjJ1gKQ/G46L+ju7kGdazzF3k6FtQOpoZP8hbjDCNwFaJMGCwhbYwbLc2nHUJaDDLE9rHSEM7+NbHfZkiaq1geVYosumYNUSUs8ciqK96FR+8njsB1iwcik0duza+QmtDOh2rRb6nnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qViPEqHI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43ADvQvd002584;
	Wed, 10 Apr 2024 15:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=Cbi/eAWd7VhxaqxfaHTml+ueD1AIDaz+ba8OE4CCdvA=;
 b=qViPEqHIuBk9CBux21zCp8UMLj//yBpq37q5ojeITXSi8J/V8GrSYW3oKyFtC8PKQ+S+
 jr0OhNNdhKo+mOCUbqWdK/lNmqCc2cNxhf6ejca2zxlBcdRMMlsNZhh8pbBlSQTJ+cGT
 GJSo67C6hCJT5OzwqYENJ/tcY43p+woUjruAfstycZ5vCHtTWkZO+L/3B8pPB3Qre+1A
 kbCdGBSDon3MT4zO6YL1Ejx0HvY7IVWO2AVHuf7g7Z5i39EUrFtZIIwvsMa8nha9f8kJ
 1aAEDABtFv13w7dxCcY14UBIuYa+KqH3EXEgAv0JDBI2zgg1TKSAxI54/uxGqSwdt0K6 uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xds6k8s0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 15:31:03 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43AFV3XD021875;
	Wed, 10 Apr 2024 15:31:03 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xds6k8s0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 15:31:03 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43AEXDuU029966;
	Wed, 10 Apr 2024 15:26:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbj7mdf1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 15:26:47 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43AFQf4j30867974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 15:26:44 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3E2E20043;
	Wed, 10 Apr 2024 15:26:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32FE12004F;
	Wed, 10 Apr 2024 15:26:41 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.171.29.198])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 10 Apr 2024 15:26:41 +0000 (GMT)
Date: Wed, 10 Apr 2024 17:26:39 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hughd@google.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        iii@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/shmem: Inline shmem_is_huge() for disabled
 transparent hugepages
Message-ID: <Zhavr9NxvayDhU9X@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20240409155407.2322714-1-sumanthk@linux.ibm.com>
 <594dbec7-b560-44e5-a684-93dcb8ba85df@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <594dbec7-b560-44e5-a684-93dcb8ba85df@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L612PNMowBeXj8vY2YP3t3EszkoVv0Uk
X-Proofpoint-ORIG-GUID: GxlMHGTjvPmiE1LhuQok0TrbcWFwqCxD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1015 mlxlogscore=368 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404100112

On Wed, Apr 10, 2024 at 02:34:35PM +0200, David Hildenbrand wrote:
> On 09.04.24 17:54, Sumanth Korikkar wrote:
> > In order to  minimize code size (CONFIG_CC_OPTIMIZE_FOR_SIZE=y),
> > compiler might choose to make a regular function call (out-of-line) for
> > shmem_is_huge() instead of inlining it. When transparent hugepages are
> > disabled (CONFIG_TRANSPARENT_HUGEPAGE=n), it can cause compilation
> > error.
> > 
> > mm/shmem.c: In function ‘shmem_getattr’:
> > ./include/linux/huge_mm.h:383:27: note: in expansion of macro ‘BUILD_BUG’
> >    383 | #define HPAGE_PMD_SIZE ({ BUILD_BUG(); 0; })
> >        |                           ^~~~~~~~~
> > mm/shmem.c:1148:33: note: in expansion of macro ‘HPAGE_PMD_SIZE’
> >   1148 |                 stat->blksize = HPAGE_PMD_SIZE;
> > 
> > To prevent the possible error, always inline shmem_is_huge() when
> > transparent hugepages are disabled.
> > 
> 
> Do you know which commit introduced that?
Hi David,

Currently with CONFIG_CC_OPTIMIZE_FOR_SIZE=y and expirementing with
-fPIC kernel compiler option, I could see this error on s390.

However, default kernel compiler options doesnt end up with the above
pattern right now.

I think, shmem_is_huge() for disabled transparent hugepages comes from:
Commit 5e6e5a12a44c ("huge tmpfs: shmem_is_huge(vma, inode, index)")

However, HPAGE_PMD_SIZE macros for !CONFIG_TRANSPARENT_HUGEPAGE
originates from:
Commit d8c37c480678 ("thp: add HPAGE_PMD_* definitions for
!CONFIG_TRANSPARENT_HUGEPAGE")

Thanks,
Sumanth


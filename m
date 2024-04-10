Return-Path: <linux-kernel+bounces-138951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EEF89FC7F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8624B27C24
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CB617920F;
	Wed, 10 Apr 2024 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bz+xp+Vq"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674A71791FB;
	Wed, 10 Apr 2024 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712765292; cv=none; b=IqXr/chaEaa0tPq1BYRFWFIlaJT1UwUysI8Dmhcr5ryMTifIqt8eVckz9anQXvWT5l3z4JbwoXg6jOU9b5FAwxqXQX/RrRZzQ8c9BovItQ1uU7tnEsiMSMsVtc0qTmqWQqcplbc9wpN9tWLvPjNFiFo7tSOV/RFMozAOgNHDZL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712765292; c=relaxed/simple;
	bh=TYSbglhUGKkp+nQF65/gBniM6ORpHD/r7dxLRKAY3CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfgOJiSpPoDPvzh9VdbJbNiXMdfIBZXbXLGT0h5JKCE+zXA+/IUykvF//WmyEgkIkPx6hH7Grq+5pISxaUQbLPF5M6NyLkEqnTKAmXgkaYWQL7NY+an+PXdbZUOME2CvJmJx/HDyy9u7RB5NtAN8XDa1XUguFt0k36PW00R849o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bz+xp+Vq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43AG3vwA016370;
	Wed, 10 Apr 2024 16:08:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=n+nI9qSzX6fe4b6bLe/CP34ytrHVPciQDdwr8ktXFOM=;
 b=bz+xp+VqP3XyScImRa/54OkA6ZyBSnmwJML+NPsZc9HvwLrSe4pll8LRwua2lGCHnqRX
 wzVatIm2SwqrmKhtCEQ25WsXRsOMxNobbAKWtdR4eEnevIMwLEpYNp06ggrcw+wE0+T9
 q4wFD0JNXoCh+9oVcM/ZeZanGvocN6yOJ7o2giFY2sOnrh1mh7eWY4D+pg1b9T9fcYKO
 mcIoGs/hlqIjjvGAiiWJMW5Xh70ny4dPMtl3+5nYxvNZxA8NoCpZ/0nYJiU/TpBRIO9S
 27jwqq+FES0JeZj+DFirQXgg2G4Sbje/Wvo6IpQN+6sYOP4tG9v/QofmnpoF6Rv9uc2G 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xdwxsr0hy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 16:08:00 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43AG80sP022647;
	Wed, 10 Apr 2024 16:08:00 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xdwxsr0hu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 16:08:00 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43AFb0J0016996;
	Wed, 10 Apr 2024 16:07:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xbke2nbgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 16:07:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43AG7sWf33161638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 16:07:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFB302004D;
	Wed, 10 Apr 2024 16:07:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 451BD20043;
	Wed, 10 Apr 2024 16:07:53 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.171.29.198])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 10 Apr 2024 16:07:53 +0000 (GMT)
Date: Wed, 10 Apr 2024 18:07:51 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hughd@google.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        iii@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/shmem: Inline shmem_is_huge() for disabled
 transparent hugepages
Message-ID: <Zha5V0QxODZR4qOW@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20240409155407.2322714-1-sumanthk@linux.ibm.com>
 <594dbec7-b560-44e5-a684-93dcb8ba85df@redhat.com>
 <Zhavr9NxvayDhU9X@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <29b613a8-f0d5-4f5f-adbc-d64ed8908044@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29b613a8-f0d5-4f5f-adbc-d64ed8908044@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: diLl3fzGZHAouOz23n5C0cevWaObunjs
X-Proofpoint-GUID: _1YMLRsYJXVgNhSs5Kv8fJoHDrrYdjkM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015 mlxlogscore=699
 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404100117

On Wed, Apr 10, 2024 at 05:51:28PM +0200, David Hildenbrand wrote:
> On 10.04.24 17:26, Sumanth Korikkar wrote:
> > On Wed, Apr 10, 2024 at 02:34:35PM +0200, David Hildenbrand wrote:
> > > On 09.04.24 17:54, Sumanth Korikkar wrote:
> > > > In order to  minimize code size (CONFIG_CC_OPTIMIZE_FOR_SIZE=y),
> > > > compiler might choose to make a regular function call (out-of-line) for
> > > > shmem_is_huge() instead of inlining it. When transparent hugepages are
> > > > disabled (CONFIG_TRANSPARENT_HUGEPAGE=n), it can cause compilation
> > > > error.
> > > > 
> > > > mm/shmem.c: In function ‘shmem_getattr’:
> > > > ./include/linux/huge_mm.h:383:27: note: in expansion of macro ‘BUILD_BUG’
> > > >     383 | #define HPAGE_PMD_SIZE ({ BUILD_BUG(); 0; })
> > > >         |                           ^~~~~~~~~
> > > > mm/shmem.c:1148:33: note: in expansion of macro ‘HPAGE_PMD_SIZE’
> > > >    1148 |                 stat->blksize = HPAGE_PMD_SIZE;
> > > > 
> > > > To prevent the possible error, always inline shmem_is_huge() when
> > > > transparent hugepages are disabled.
> > > > 
> > > 
> > > Do you know which commit introduced that?
> > Hi David,
> > 
> > Currently with CONFIG_CC_OPTIMIZE_FOR_SIZE=y and expirementing with
> > -fPIC kernel compiler option, I could see this error on s390.
> 
> Got it. I assume on Linus' tree, not mm/unstable?

It's not yet upstream.
> 
> > 
> > However, default kernel compiler options doesnt end up with the above
> > pattern right now.
> 
> Okay, just asking if this is related to recent HPAGE_PMD_SIZE changes:
> 
> commit c1a1e497a3d5711dbf8fa6d7432d6b83ec18c26f
> Author: Peter Xu <peterx@redhat.com>
> Date:   Wed Mar 27 11:23:22 2024 -0400
> 
>     mm: make HPAGE_PXD_* macros even if !THP
> 
> Which is still in mm-unstable and not upstream.

Not related to this commit. I tried on master branch.

Thanks,
Sumanth


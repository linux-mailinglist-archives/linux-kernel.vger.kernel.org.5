Return-Path: <linux-kernel+bounces-146873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 883078A6C33
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0FAAB20FE4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8C812C486;
	Tue, 16 Apr 2024 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uazbtz7t"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DB112BF25;
	Tue, 16 Apr 2024 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713273903; cv=none; b=Ey1T+MC44mHJJ4TjVB5mJbQz8jTYsFBdmJiV16Oo4o6I2KMgNMYAongOpbzdhGW5FCKSWFg5SJAVHnx1wsn62ynDDwVyKwGgUWGY+8sqNbgUOZvUHdJ9MpN+n6OjkXMFGS9fbtkErANMTh4EVDBkuXnqA6OZWNBwJGN+QjHiAP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713273903; c=relaxed/simple;
	bh=Dl20SKKKdK/glPzRJdejo+DpwoBM7fVMEjjyFFZXHMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0u0GZmvLStHMiFKcLH/6bJ8sB3eXYNbwhZ5j9b+LFBCTlKdZ/Vby+DFB8n1P6Yy5Wq57SAsIg4BQQkL+nITkyk/a4Se+msLDutsSJXXTV9VkKS4eoCGJuDvHQqFLXB7pDml6Knk22dm0dJHBLhbKkdPDmByExze1JGv3aITVaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uazbtz7t; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GDD8YM015505;
	Tue, 16 Apr 2024 13:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=lM809BDZYuTXn/Pqi/pRu243BYM375+7G+rhxIcNB9Q=;
 b=Uazbtz7toUE6L437ceiB9GampGVsD/jAFrAKDH6sULCVIyZhOjjzr6gaZZknymCHjpvV
 isrqy4FQM6fB5jrNyDWk4NXacU+YCBxgERFNu19KCIigpocsMGxNNuHC0k4UrpElGjPU
 9mAMjP8oze+sGuhLVeHK+9NgODK4bcMZ6aTC3SjOe0A7/mAebus0EJgfKboxiujWuKon
 VcddfQU4nuoIxEdNg+Y8NE3J2FlpQEgL8bMHz71gowjRi+4P8NneOpoCRRJRdiw0/GOO
 M1ExzZFAqcwXfUf88x5JxG/883Cue9y1TONuIx/pU79DHbUNewYwoGx3D8InQprtHkym /w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xht0s011c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 13:25:00 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43GDOxvl002686;
	Tue, 16 Apr 2024 13:24:59 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xht0s010j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 13:24:59 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43GBsqdm018152;
	Tue, 16 Apr 2024 13:24:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg4ct6g17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 13:24:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43GDOY9V45482310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 13:24:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07B892004E;
	Tue, 16 Apr 2024 13:24:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDB2120040;
	Tue, 16 Apr 2024 13:24:33 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 16 Apr 2024 13:24:33 +0000 (GMT)
Date: Tue, 16 Apr 2024 15:24:31 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        frankja@linux.ibm.com, nrb@linux.ibm.com, nsg@linux.ibm.com,
        borntraeger@de.ibm.com, gerald.schaefer@linux.ibm.com,
        david@redhat.com
Subject: Re: [PATCH v1 0/2] s390/mm: fix improper use of
 __storage_key_init_range
Message-ID: <20240416132431.8615-A-hca@linux.ibm.com>
References: <20240416114220.28489-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416114220.28489-1-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Zm7f7t5x2oIaMNl7cMub2GV_QvJQcolB
X-Proofpoint-GUID: 2AzUImr0v-tkR-NBwo1hVD6EjBQi3hhy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_10,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=958 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160081

On Tue, Apr 16, 2024 at 01:42:18PM +0200, Claudio Imbrenda wrote:
> The function __storage_key_init_range() expects the end address to be
> the first byte outside the range to be initialized. I.e. end - start
> should be the size of the area to be initialized.
> 
> This small series fixes two cases in which the last address in the
> range was passed as end address. This was still functionally correct,
> since __storage_key_init_range() will still loop over single pages and
> correctly clear the given range, but it will be slower than clearing
> the storage keys for the whole 1M block with a single instruction.
> 
> Claudio Imbrenda (2):
>   s390/mm: fix storage key clearing for guest huge pages
>   s390/mm: fix clearing storage keys for huge pages
> 
>  arch/s390/mm/gmap.c        | 2 +-
>  arch/s390/mm/hugetlbpage.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>


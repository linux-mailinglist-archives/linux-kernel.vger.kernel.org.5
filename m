Return-Path: <linux-kernel+bounces-71670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACC085A8C8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D907C2858FC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7563CF4F;
	Mon, 19 Feb 2024 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ytm8/zWH"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D04374DD;
	Mon, 19 Feb 2024 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359741; cv=none; b=QFSN0zX6AGqjNPYu0yIyaW9aY0XM6/1eIQ4/fsb8ZNsGdIKVlR3Mopg/WhiL3vtNzvsY/RhiKUfnZwnJQ+hxlv7j0ywuvxftEzV/ppovVohyt5l4xHB5eItEiKO8LCHOHmDgJMl9cJgECuPPC1ygCx5ihbEc/rHOAq5IUzcjZ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359741; c=relaxed/simple;
	bh=hDYsI9osVj/sIAvuqFcdJVNB9hb4QwVGsGzwVEm1oNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyMyoVRND7CQ4tNqZGDOEI1LHTo4v21T1q6I55UuaWITdXM9GRy+PsHoe/FMv5Cv1G6QmX35fC0uY2mDsu+OyjYc8XAG/TBGRMffRL45SVCFWuMqCRLZwS/ucNxgPr/OIZIWlWDhNFfM4x5dIeYVIslf+qpXjgiOHVETB9a/hyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ytm8/zWH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JFcPEk023093;
	Mon, 19 Feb 2024 16:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=wNNK4H9rLt/e+SO2ZcWoe4RsM1HqZV3aots/hybb5oY=;
 b=Ytm8/zWHOsaX/KpJtVK57ljiA1N6zS6ivo9mEF2WWKMUPUJn5KJ8jjEYdvunM2Fbk+4r
 z91YPgZtbtrfISDQGWeHn7VIlijyEwZE/MaauSc7ipKuJ0B8Cye2hqK+G5bGQUtTMMaF
 PRHpNGXpIo2pg/nFpnQ6sNYwaraoT7yoHUJcjCGm7DdrhgKms6uNlpAdTZoEACH8I5n8
 m+3+cQ8kw6+zkVupjDtlsL5HR6x9iZhiMkmBQurWg6qtR4B9vzmFC4fARkOd6aPRINkC
 6q5Z1GA7YYVvN3r80ICd/jRz7ZlC+T5ky/5w8i/CdliGzCyzj9lODlrXzUg+D3fTrE+I 2Q== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wc9t6h270-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 16:22:04 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41JGKGIY003606;
	Mon, 19 Feb 2024 16:22:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74takhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 16:22:03 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41JGLvYS45547992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 16:22:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5C4B20040;
	Mon, 19 Feb 2024 16:21:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 375D320043;
	Mon, 19 Feb 2024 16:21:57 +0000 (GMT)
Received: from osiris (unknown [9.171.27.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 19 Feb 2024 16:21:57 +0000 (GMT)
Date: Mon, 19 Feb 2024 17:21:55 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 02/10] s390/vdso/data: Drop unnecessary header include
Message-ID: <20240219162155.16287-F-hca@linux.ibm.com>
References: <20240219153939.75719-1-anna-maria@linutronix.de>
 <20240219153939.75719-3-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219153939.75719-3-anna-maria@linutronix.de>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: acyEUdKEUvlZsTsXBChOazRe66SMK7AE
X-Proofpoint-ORIG-GUID: acyEUdKEUvlZsTsXBChOazRe66SMK7AE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_12,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=483 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 malwarescore=0 clxscore=1011 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190122

On Mon, Feb 19, 2024 at 04:39:31PM +0100, Anna-Maria Behnsen wrote:
> vdso/datapage.h includes the arch specific vdso/data.h file. So there is no
> need to do it also the other way round and including the generic
> vdso/datapage.h file inside the arch specific data.h file.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/s390/include/asm/vdso/data.h | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>


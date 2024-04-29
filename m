Return-Path: <linux-kernel+bounces-162414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC8A8B5ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E098D1F20933
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217A078B63;
	Mon, 29 Apr 2024 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VX0+5we7"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F36763FC;
	Mon, 29 Apr 2024 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399495; cv=none; b=aSYCeW2SM0+ZkGegcv7f8+QwC2GIZhTdwjyms+SXVdkEupIQpSkr2R2DUf3phsps7XdbI966BWo3Wuiic03KAsDe71LmP/38AvFAvyEtg5e+0kmU6Wk7MeNWNjO4OSx1hCQVQpxGvCHWAfmZZlwM6a/1ZZKyIW4kHEvZPSyPQyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399495; c=relaxed/simple;
	bh=zjARx+/GtRRv+02D1RxjEuNjW2h1b2KhrsRFMuJzsmc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7NhfaTp3Rm6LokTnWfUIa3poFfZxqfTv96/VojghwYW0pqvruJUuzwCQty7bAs+5RR2bkOzrm8AX40Ln6Y5icPGreVekgM8h2RtoQgnI1hn179G9eUxY2n6dxPaULBfp+6HyB5z/pxLZvkpdkg1oRjuJht1N1GaJDHK0qMrAMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VX0+5we7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TDgh7J032410;
	Mon, 29 Apr 2024 14:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZUGOkK+F6Z/S7qp5pIGSND8iBVS08pT++7QX/o/4sxU=;
 b=VX0+5we75Via2kE2mtJMg33dATo6/kWUcaJcBfBE2i9jZhelRQlAE8hT8ddLBaghBVG9
 zaUZFbtX1VLlWcO5nBgRHtcbU7DiKBydKRVrIdJimwD3kWJUwwO7l4qYd0rdr/Lor48o
 IiIfJNfjRirVOJRcpSUsMO6rApajNuMGVIgcOxkyz8I4hctEAKlXvhXH0yvMi+15mXjm
 0xSI40ioXO8CJipQNhLVZRMQtOBnbXISkPvYzC7d02cXMS9aF9Xbv9dcwfNijW4+gVhJ
 Y50YXoWpxc4JmU9SHpxRRQdXbe8fe0PBmRiqDsdXmBfp11R2yLWAf1rvxnGuuaF+XHQ+ TQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xtcnt8239-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 14:04:02 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43TB5Phq001433;
	Mon, 29 Apr 2024 14:04:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xsbptqvab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 14:04:01 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43TE3tIm17957170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 14:03:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4A0A2004B;
	Mon, 29 Apr 2024 14:03:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DA7820040;
	Mon, 29 Apr 2024 14:03:55 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Apr 2024 14:03:55 +0000 (GMT)
Date: Mon, 29 Apr 2024 16:03:54 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, borntraeger@de.ibm.com
Subject: Re: [PATCH v3 2/2] s390/pgtable: add missing hardware bits for
 puds, pmds
Message-ID: <20240429160354.47f05bfc@p-imbrenda.boeblingen.de.ibm.com>
In-Reply-To: <20240429131149.29046-M-hca@linux.ibm.com>
References: <20240426120447.34318-1-imbrenda@linux.ibm.com>
	<20240426120447.34318-3-imbrenda@linux.ibm.com>
	<20240429131149.29046-M-hca@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xxqSgTpP99SUCF5qRzTJtRbHwppMqYCy
X-Proofpoint-GUID: xxqSgTpP99SUCF5qRzTJtRbHwppMqYCy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_12,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404290089

On Mon, 29 Apr 2024 15:11:49 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> On Fri, Apr 26, 2024 at 02:04:47PM +0200, Claudio Imbrenda wrote:
> > Add the table type and ACCF validity bits to _SEGMENT_ENTRY_BITS and
> > _SEGMENT_ENTRY_HARDWARE_BITS{,_LARGE}.
> > 
> > For completeness, introduce _REGION3_ENTRY_HARDWARE_BITS_LARGE and
> > _REGION3_ENTRY_HARDWARE_BITS, containing the hardware bits used for
> > large puds and normal puds.
> > 
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > ---
> >  arch/s390/include/asm/pgtable.h | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)  
> 
> ...
> > +#define _REGION3_ENTRY_HARDWARE_BITS_LARGE	0xffffffff8001073cUL
> > +#define _REGION3_ENTRY_HARDWARE_BITS		0xfffffffffffff6ffUL  
> ...
> > +#define _SEGMENT_ENTRY_BITS			0xfffffffffffffe3fUL
> > +#define _SEGMENT_ENTRY_HARDWARE_BITS		0xfffffffffffffe3cUL
> > +#define _SEGMENT_ENTRY_HARDWARE_BITS_LARGE	0xfffffffffff1073cUL  
> 
> Please resend and make sure the order (BITS, BITS_LARGE, ...) is the
> same; then Alexander can pick this up.

oops, will fix

> 
> For the definitions:
> Reviewed-by: Heiko Carstens <hca@linux.ibm.com>



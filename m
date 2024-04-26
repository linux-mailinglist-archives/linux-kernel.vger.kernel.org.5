Return-Path: <linux-kernel+bounces-159776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7108A8B33D2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936BF1C21CFD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E6213DDC7;
	Fri, 26 Apr 2024 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bKJY2++g"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294CC282EA;
	Fri, 26 Apr 2024 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123335; cv=none; b=CBA6WXL6ETiKbi50v6mjMYhJIfg6UXGFoMEjtKd8W0+QjYIcw94Oh4xUY7GGHIaXjSJ9NA04rr52WTe0l3q4FCNIYvpM/bedXINU4udBHmC8X7I7Mikyw+Vj/K4/JRKfdOGZfFLb9YoB3avtbFBwMxmxFHIAWXyOs4j6SoSihCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123335; c=relaxed/simple;
	bh=Sf+L1xWoaHlAf0nD2PEH3YdAW+88HHm216ZUXqqqUCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UQ5I/da4wNR553V9b88qiStdkvjiUQIDD0ljqgzU0JEBYnXO9RgE2bQn9lztbQGgXRzTBhl+Cmmq57b6T7wzbmjdo+qQE36WTOcCLvgdENZRnZ4ByuFJJ1D8AcFEhZLBDDkRBhQyE3tzHMy51krg+L77bs396j3+izzM0tlq+eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bKJY2++g; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q9KL8T024970;
	Fri, 26 Apr 2024 09:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=pvH+FXQvoSZFUAiMdegKZnVOLGNFLl20OwUtG5i6Hbg=;
 b=bKJY2++gV/a5KFYtAcX3hGcFDmNRxfJruD60GLyXwBN8+OvvsGW+S6dl5sS3P+ep4Ov3
 Mcv3mWApHAj+LEncbSJG0HU9CK3D+LjKekY7Zsd/3Gh1pCgKuiVxAg2e+8YXPXn0U5RU
 y4keW2rkzrKgCW0RXnqRi/SU8eAUILbNG8v1PkBQt7KHwKf1HnlRhhJ+TnQwEwC3Jjix
 7occQocNL2L9AfrxqLC3CzjzvJWw5joS+UNxFKEHq1VVQacqp8YYEpvJ2gdmTXcSF0T3
 V/oJPHtIMuK8w/G3O7Sx0I8yjgvqs8Z9PNX8OC/NjOvTJHITWGivrV2OJbn5oLRjbbAr vA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xr9e4g0cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 09:22:12 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q89r9C020908;
	Fri, 26 Apr 2024 09:22:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmre0f284-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 09:22:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43Q9M63q45875496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 09:22:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C1CB2004E;
	Fri, 26 Apr 2024 09:22:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD5752004B;
	Fri, 26 Apr 2024 09:22:05 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Apr 2024 09:22:05 +0000 (GMT)
Date: Fri, 26 Apr 2024 11:22:04 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, borntraeger@de.ibm.com
Subject: Re: [PATCH v1 2/2] s390/pgtable: introduce
 _REGION3_ENTRY_HARDWARE_BITS_LARGE
Message-ID: <20240426112204.10c00d33@p-imbrenda.boeblingen.de.ibm.com>
In-Reply-To: <20240426085714.8950-F-hca@linux.ibm.com>
References: <20240425130555.73132-1-imbrenda@linux.ibm.com>
	<20240425130555.73132-3-imbrenda@linux.ibm.com>
	<20240426085714.8950-F-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: DVhY9Iy4vvXYIHHy1DTfw0r9sV5xVPlw
X-Proofpoint-GUID: DVhY9Iy4vvXYIHHy1DTfw0r9sV5xVPlw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_09,2024-04-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260060

On Fri, 26 Apr 2024 10:57:14 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> On Thu, Apr 25, 2024 at 03:05:55PM +0200, Claudio Imbrenda wrote:
> > For completeness, introduce _REGION3_ENTRY_HARDWARE_BITS_LARGE,
> > containing the hardware bits used for large puds.
> > 
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > ---
> >  arch/s390/include/asm/pgtable.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> > index 3da2995fd196..5c0f840eee2a 100644
> > --- a/arch/s390/include/asm/pgtable.h
> > +++ b/arch/s390/include/asm/pgtable.h
> > @@ -262,6 +262,7 @@ static inline int is_module_addr(void *addr)
> >  #define _REGION3_ENTRY		(_REGION_ENTRY_TYPE_R3 | _REGION_ENTRY_LENGTH)
> >  #define _REGION3_ENTRY_EMPTY	(_REGION_ENTRY_TYPE_R3 | _REGION_ENTRY_INVALID)
> >  
> > +#define _REGION3_ENTRY_HARDWARE_BITS_LARGE	0xffffffff8000073cUL  
> 
> _REGION_ENTRY_HARDWARE_BITS is missing too. :)

right, I will fix it

> 
> And this definition also raises the question if the definition of
> _SEGMENT_ENTRY_HARDWARE_BITS_LARGE should be changed so it also includes
> the table type bits, which it probably should.

tbh I agree

> 
> These masks are really a bit randomly defined and assume that the
> ACCF-Validity control bit is never set, and therefore the ACC bitfield can
> be assumed to be software bits (and they are used as such for format 1
> segment table entries).
> 
> But the ACCF bit is also a hardware bit in any case... oh well.

probably the ACCF bit should also be marked as hardware bit (I had
actually thought about it, but we don't do it for segments and I wanted
it to be consistent)

I'll send a v2 with:

segment table type bits
ACCF bit (both for segments and region3
_REGION3_ENTRY_HARDWARE_BITS


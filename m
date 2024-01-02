Return-Path: <linux-kernel+bounces-14517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A855821E30
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06000B22090
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143E41427C;
	Tue,  2 Jan 2024 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FXbIqg4H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D857A12E5B;
	Tue,  2 Jan 2024 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 402EhEM2021402;
	Tue, 2 Jan 2024 14:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=bL+ZIKl6ttywS56QSUlX/YXzFOtll+hBW6t6aAV1Vp0=;
 b=FXbIqg4H6uJbPylH7RCPxkCCPirilzNe8hKTNicaeuAWBCv7bk14cvJG7UG6Wj6pzOqG
 0MV1LxQTX10AhZ056a++KwE4/uQwt6gkeShrymB5sEeYt9T8WTLwoHx+KMNiIstjgX96
 gqhM+2MdedhFfefj4k/fiOjfZxJfbl3tsitdBcT1/t8sLGnYHXwigZL8z3cTaOuDKe3R
 /gDW0xNyfeiOsOSKg1bSzE3eKXp7RObaTpHpGRfca3i7SandTgvPNsLFI4Ucl77ksyX0
 5V8+XdJvDyK2zhylYrT8qWzuSD2Fo3wF72lpZhRWPxMuC3zpFYy+rSJtTe9/g136ORzM wg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vcmg7re0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 14:56:59 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 402EjXkx029393;
	Tue, 2 Jan 2024 14:56:56 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vcmg7rdpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 14:56:56 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 402ED398007417;
	Tue, 2 Jan 2024 14:56:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vaxhnweh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 14:56:29 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 402EuQBv58393020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jan 2024 14:56:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65FF320063;
	Tue,  2 Jan 2024 14:56:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 546F42004D;
	Tue,  2 Jan 2024 14:56:25 +0000 (GMT)
Received: from osiris (unknown [9.171.22.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  2 Jan 2024 14:56:25 +0000 (GMT)
Date: Tue, 2 Jan 2024 15:56:23 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v3 25/34] s390/diag: Unpoison diag224() output buffer
Message-ID: <20240102145623.6306-C-hca@linux.ibm.com>
References: <20231213233605.661251-1-iii@linux.ibm.com>
 <20231213233605.661251-26-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213233605.661251-26-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RUOkeM2Jhk_VjhploDiahEDWYEBVFPeb
X-Proofpoint-GUID: _T0ziB-ASJYSISr80eNxgXOERvkM-ZsL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_04,2024-01-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401020115

On Thu, Dec 14, 2023 at 12:24:45AM +0100, Ilya Leoshkevich wrote:
> Diagnose 224 stores 4k bytes, which cannot be deduced from the inline
> assembly constraints. This leads to KMSAN false positives.
> 
> Unpoison the output buffer manually with kmsan_unpoison_memory().
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/s390/kernel/diag.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/s390/kernel/diag.c b/arch/s390/kernel/diag.c
> index 92fdc35f028c..fb83a21014d0 100644
> --- a/arch/s390/kernel/diag.c
> +++ b/arch/s390/kernel/diag.c
> @@ -9,6 +9,7 @@
>  #include <linux/export.h>
>  #include <linux/init.h>
>  #include <linux/cpu.h>
> +#include <linux/kmsan-checks.h>
>  #include <linux/seq_file.h>
>  #include <linux/debugfs.h>
>  #include <linux/vmalloc.h>
> @@ -255,6 +256,7 @@ int diag224(void *ptr)
>  		"1:\n"
>  		EX_TABLE(0b,1b)
>  		: "+d" (rc) :"d" (0), "d" (addr) : "memory");
> +	kmsan_unpoison_memory(ptr, PAGE_SIZE);

Wouldn't it be better to adjust the inline assembly instead?
Something like this:

diff --git a/arch/s390/kernel/diag.c b/arch/s390/kernel/diag.c
index 92fdc35f028c..b1b0acda50c6 100644
--- a/arch/s390/kernel/diag.c
+++ b/arch/s390/kernel/diag.c
@@ -247,14 +247,18 @@ int diag224(void *ptr)
 {
 	unsigned long addr = __pa(ptr);
 	int rc = -EOPNOTSUPP;
+	struct _d {
+		char _d[4096];
+	};
 
 	diag_stat_inc(DIAG_STAT_X224);
-	asm volatile(
-		"	diag	%1,%2,0x224\n"
-		"0:	lhi	%0,0x0\n"
+	asm volatile("\n"
+		"	diag	%[type],%[addr],0x224\n"
+		"0:	lhi	%[rc],0\n"
 		"1:\n"
 		EX_TABLE(0b,1b)
-		: "+d" (rc) :"d" (0), "d" (addr) : "memory");
+		: [rc] "+d" (rc), "=m" (*(struct _d *)ptr)
+		: [type] "d" (0), [addr] "d" (addr));
 	return rc;
 }
 EXPORT_SYMBOL(diag224);


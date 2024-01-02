Return-Path: <linux-kernel+bounces-14528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9814821E52
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B791F22BD4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C95A13AF4;
	Tue,  2 Jan 2024 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K8s/TXnn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD2E14F73;
	Tue,  2 Jan 2024 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 402EI2Yt031896;
	Tue, 2 Jan 2024 15:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Oonp123cOdkP40iNRTSGS2eTt70BPLYr/b5oy9HIOrE=;
 b=K8s/TXnnvnjYH/i63M4IJ8zJHQCU3LU4xpar5nz7GGtGeZerOuyW34Cj8fL58lx5Iit8
 WnB6PXZkhxtXAeZi0CY7TRzm0EDR6AUQ3xJW29Bvo4gJHUe7CWUe8gMRy3CB73Cgm3WR
 ZQ5Oo6ATzTFGZOeX/cXmPHTHsFNBKPuF0+nfL9EhIeUh8aguAoalQ/EorSBwwNdFa4UI
 sMHsrO6BPYG7ripsJhjLkD66corKHhJjusWg/wT3VosjoIRVboLScyPTpOrPdvrF9zXN
 Ys/N65xahMlVsqJiA5J2+C3VjzzpdhlzdRphqbtC/Tow93pb1wtpqDfHc+BP5aE1H9yD OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vcm4k9a60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 15:06:46 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 402ETn6Y004810;
	Tue, 2 Jan 2024 15:06:46 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vcm4k9a5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 15:06:46 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 402DoQfs017830;
	Tue, 2 Jan 2024 15:06:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vawwynmw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 15:06:45 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 402F6g4R22020754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jan 2024 15:06:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D94B20040;
	Tue,  2 Jan 2024 15:06:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA9552004D;
	Tue,  2 Jan 2024 15:06:40 +0000 (GMT)
Received: from osiris (unknown [9.171.22.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  2 Jan 2024 15:06:40 +0000 (GMT)
Date: Tue, 2 Jan 2024 16:06:39 +0100
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
Subject: Re: [PATCH v3 30/34] s390/traps: Unpoison the
 kernel_stack_overflow()'s pt_regs
Message-ID: <20240102150639.6306-H-hca@linux.ibm.com>
References: <20231213233605.661251-1-iii@linux.ibm.com>
 <20231213233605.661251-31-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213233605.661251-31-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: leYrbA6vtAty3KAE9ah14tjkk5Bn0Uhc
X-Proofpoint-ORIG-GUID: utJWxtGOYHGAv9Kk1hnF_c8f7r1ax0vb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_04,2024-01-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxlogscore=933 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401020115

On Thu, Dec 14, 2023 at 12:24:50AM +0100, Ilya Leoshkevich wrote:
> This is normally done by the generic entry code, but the
> kernel_stack_overflow() flow bypasses it.
> 
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/s390/kernel/traps.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Heiko Carstens <hca@linux.ibm.com>


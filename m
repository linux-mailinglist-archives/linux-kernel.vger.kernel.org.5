Return-Path: <linux-kernel+bounces-421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E84F08140E2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC785B22316
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605C9610D;
	Fri, 15 Dec 2023 04:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oyqTzhb3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62757566C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 04:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BF32MJt016877;
	Fri, 15 Dec 2023 04:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=JUgmFi08qpXy1eUIY5eChcvEZ8dewch6vbpeTULj1SI=;
 b=oyqTzhb3EUjwz2ERT194OXDQeKQRWpgbTB8+oyF8d5RpiQRvfQrsNjSS2i3Huxq7ag86
 Oqd3A2dQlEfAFHF3u9ZW0djumWkDBsnp0iLgNgtxGPmrEhDfkA0t4Uy/6P+C/Q8+DB+j
 XHtITrocADyI5TKtW4DZlQ2K/bjxj0289nBOEQOVpPt32M5gumKgDtYNEBLF+MtffpXo
 L5z+BUp442kKBy4IPECP77sOVLjY0dxObpCseipeReum6VJzLo6qrWE4+3i9KXieVieh
 Cj2K0D9z+Fkh09OQOvLbxia4RHavx90kWa32u42aq8Bs6LWuVV2W2hpb27RAA1c6WAdy TA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0ehqhasa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 04:10:34 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BF3QhHn016716;
	Fri, 15 Dec 2023 04:10:34 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0ehqharm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 04:10:34 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEJMKQ0014824;
	Fri, 15 Dec 2023 04:10:32 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw42kjmus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 04:10:32 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BF4AU4V41222886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 04:10:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E44A2004B;
	Fri, 15 Dec 2023 04:10:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2498120040;
	Fri, 15 Dec 2023 04:10:28 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri, 15 Dec 2023 04:10:27 +0000 (GMT)
Date: Fri, 15 Dec 2023 09:40:27 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: Enable group_asym_packing in
 find_idlest_group
Message-ID: <20231215041027.GX2194132@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20231018155036.2314342-1-srikar@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20231018155036.2314342-1-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I8hsLBsaCagOdzP5I1g6gEk5tZ8i9fxp
X-Proofpoint-ORIG-GUID: TgVQuydjcxTeDdiBTTA98QBtjjxEzzL_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_17,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=641 phishscore=0
 suspectscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312150027

* Srikar Dronamraju <srikar@linux.vnet.ibm.com> [2023-10-18 21:20:35]:

Hi Ingo, Peter,

> Current scheduler code doesn't handle SD_ASYM_PACKING in the
> find_idlest_cpu path. On few architectures, like Powerpc, cache is at a
> core. Moving threads across cores may end up in cache misses.
> 
> While asym_packing can be enabled above SMT level, enabling Asym packing
> across cores could result in poorer performance due to cache misses.
> However if the initial task placement via find_idlest_cpu does take
> Asym_packing into consideration, then scheduler can avoid asym_packing
> migrations. This will result in lesser migrations and better packing and
> better overall performance.
> 
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

I haven't heard any comments or seen any reviews on this patch.
I have verified that it does still apply cleanly on v6.7-rc5 based
tip/master

Do let me know your thoughts on the same.

Also let me know if you want me to repost the same.

-- 
Thanks and Regards
Srikar Dronamraju


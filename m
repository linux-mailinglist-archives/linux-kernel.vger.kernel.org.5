Return-Path: <linux-kernel+bounces-71677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FD085A8E5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5886A2860F2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8D93E46B;
	Mon, 19 Feb 2024 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lwWhogav"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76792D022;
	Mon, 19 Feb 2024 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708360015; cv=none; b=pHvFs9yAIdUNJPn8QErIARFO7gT8JIIth+yTEsFyY8FwnMj4AYql34Wg2xJXo/gjKI+nKTyV/5f2OIxtq5FJdovKcmLcOwJ/NAYdJ/VUDXlicTdCnqP+9PVmBdXNAgYQ0wIKE78gJ6itWFH6VFm2UKV6bpMkGNpVOq8yaHRAzZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708360015; c=relaxed/simple;
	bh=2rOXUpicCDFr612xiRjU1GjIGrF2+97ZNgHigeMCr3s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RVCo+J2UyRFsUygHLfablfQRLqkmcREZb7BAfIPwUuwspLhSSu93fMad4DeINx8McKIyBQDkcQgsZzVL9jTrJgOSNmPrySzctF3Uy4Jh8XyJaA4/RbtdYh81Jo9s53n6r8R6ROVbnuWu+Kk2oVXQYlvRMVWqRrlWJRoWOuDprNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lwWhogav; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JEnP1j009384;
	Mon, 19 Feb 2024 16:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=9jFGo8PIGcuQJK5K8tB9z7irbRbR+Xv4HP4lmh3eCuI=;
 b=lwWhogaviQpS6qXIvJ0M8WcL2Fir0KNdeXR23UV6JYmdvJ+TML7cZ+oOrOHUt+PJRX+J
 D2DipgtUYgxKVUNj1JyrTiA6MSfK/2ycYLFf+Kyz05vs4MfT/nHbUyg6IpKGYqqjys1I
 7gTEssbltHiHtd7UdTiWf6vlnUGyB5QvFnHs5SAWTgQg2wZDZvaf/5hXauurUVY4J5DR
 4rtRFoJ8RVPkaoX1UrYPY10DFNqqrmRHt5lvMZjl1coQxDACjbjG0rv6Zwpj4/gZ3ooM
 Zd2U8fi9mCG1pdgHo5+FMN8+8/BmHXqOIY7QGlTfOjXLWhPntVfFAMCaQLO3bNUnYxOp ig== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wc86jmpyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 16:26:04 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41JG7P7J028305;
	Mon, 19 Feb 2024 16:26:04 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wc86jmpxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 16:26:04 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41JEZMvm017307;
	Mon, 19 Feb 2024 16:26:03 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb8mm24ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 16:26:03 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41JGQ0Kh4457182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 16:26:03 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4AB45805D;
	Mon, 19 Feb 2024 16:26:00 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1CD658065;
	Mon, 19 Feb 2024 16:25:58 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.67.34.213])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Feb 2024 16:25:58 +0000 (GMT)
Message-ID: <f5bef33da6c50e5fd067577f16f460025fe9a601.camel@linux.ibm.com>
Subject: Re: [PATCH 03/10] scsi: NCR5380: Replace snprintf() with the safer
 scnprintf() variant
From: James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To: Lee Jones <lee@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>, drew@colorado.edu,
        Tnx to
 <Thomas_Roesch@m2.maus.de>, linux-scsi@vger.kernel.org
Date: Mon, 19 Feb 2024 11:25:57 -0500
In-Reply-To: <20240219152312.GD10170@google.com>
References: <20240208084512.3803250-1-lee@kernel.org>
	 <20240208084512.3803250-4-lee@kernel.org>
	 <CAMuHMdX72mpGgb3Wp0WRX3V78nn+bWUqiYz25CjeMNPpWaPmxg@mail.gmail.com>
	 <20240208102939.GF689448@google.com>
	 <98bdd564c6bf1894717d060f3187c779e969fc5f.camel@linux.ibm.com>
	 <20240219152312.GD10170@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Kw_5OnP1HVdcv3cs033o_SEKrua0TOSt
X-Proofpoint-GUID: 7EiP4svoflyd92tVtrZX3HtZSqfgAS0A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_12,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=408
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190122

On Mon, 2024-02-19 at 15:23 +0000, Lee Jones wrote:
> On Sat, 10 Feb 2024, James Bottomley wrote:
> 
> > On Thu, 2024-02-08 at 10:29 +0000, Lee Jones wrote:
> > > On Thu, 08 Feb 2024, Geert Uytterhoeven wrote:
> > > 
> > > > Hi Lee,
> > > > 
> > > > Thanks for your patch!
> > > > 
> > > > On Thu, Feb 8, 2024 at 9:48 AM Lee Jones <lee@kernel.org>
> > > > wrote:
> > > > > There is a general misunderstanding amongst engineers that
> > > > > {v}snprintf() returns the length of the data *actually*
> > > > > encoded into the destination array.  However, as per the C99
> > > > > standard {v}snprintf() really returns the length of the data
> > > > > that *would have been* written if there were enough space for
> > > > > it.  This misunderstanding has led to buffer-overruns in the
> > > > > past.  It's generally considered safer to use the
> > > > > {v}scnprintf() variants in their place (or even sprintf() in
> > > > > simple cases).  So let's do that.
> > > > 
> > > > Confused... The return value is not used at all?
> > > 
> > > Future proofing.  The idea of the effort is to rid the use
> > > entirely.
> > > 
> > >  - Usage is inside a sysfs handler passing PAGE_SIZE as the size
> > >    - s/snprintf/sysfs_emit/
> > >  - Usage is inside a sysfs handler passing a bespoke value as the
> > > size
> > >    - s/snprintf/scnprintf/
> > >  - Return value used, but does *not* care about overflow
> > >    - s/snprintf/scnprintf/
> > >  - Return value used, caller *does* care about overflow
> > >    - s/snprintf/seq_buf/
> > >  - Return value not used
> > >    - s/snprintf/scnprintf/
> > > 
> > > This is the final case.
> > 
> > To re-ask Geert's question: the last case can't ever lead to a bug
> > orproblem, what value does churning the kernel to change it
> > provide? As Finn said, if we want to deprecate it as a future
> > pattern, put it in checkpatch.
> 
> Adding this to checkpatch is a good idea.
> 
> What if we also take Kees's suggestion and hit all of these found in
> SCSI in one patch to keep the churn down to a minimum?

That doesn't fix the churn problem because you're still changing the
source.  For ancient drivers, we keep the changes to a minimum to avoid
introducing inadvertent bugs which aren't discovered until months
later.  If there's no actual bug in the driver, there's no reason to
change the code.

Regards,

James



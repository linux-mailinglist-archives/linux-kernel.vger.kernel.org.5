Return-Path: <linux-kernel+bounces-165769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C568B9104
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ED95B2260B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185C0165FC0;
	Wed,  1 May 2024 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MhpZH0Bu"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDD2155354;
	Wed,  1 May 2024 21:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714598032; cv=none; b=djk2G+ROxYJnMH8taim2rffqievnWZBMMTeYTjc1GPiHj9WmA/22PGLvR9u3wFi8oWqYlyWAd3vHGBQKLp5lIM2aETsArW/osiArBCjp2JN65uePsoxP7khUjjhe6upOkHTyCyP5/u4IyNsl/8vlyyQavsfEFSsboO+HkqZ9haQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714598032; c=relaxed/simple;
	bh=Fjv5fHYgpvYAi7LV9NlFlvlxokkvAoEPcv+1ofHxJ1I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qA3u7rWBv+bbO4Q2Qr+gy0MuRaBE+ZhWPPAnYFsRogecfAjBlgMJAk6ymmrJW5JVu7RQ+ynRNzGG1xYTvt+FIvl8Gt3WQkt3nsP0bMT1yOsn4i+uujMJtiHcX4njC4YmJHdD1uctmqWx+9qSy41M3y1q2IIRod/YMZsUqhRXJ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MhpZH0Bu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 441Kwocq000881;
	Wed, 1 May 2024 21:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=+WNt8HcbBneSMStXoQNcHoy6yy7Pf5ZoXUsn8QlgbVA=;
 b=MhpZH0BuMfMJseopuxFp/77+8WEWAa7Aeg+UZFvyRdLo8RnO7z/ekElFkYsxLSwPdNqu
 MMx8vgcd0K0Xz0bEFooWyPk0UhYAZYssdYbLyIAKvGONXE2KKbbnYvdMwfOrU29x0SbL
 mDJmDo4+pb4IJK8pJvSikRZqWLvIHzInSW3ZcbjMRUamr0MdhlNMeGDiVicBSh0Bs4ty
 2X0TxE6NzPDbXbM/VB+1jvbOQAfH3qLj6zMxnHEHObcDMA65O57IcZ65vNMXOzeDGt/g
 BrrmCU9DSxnvaL7REaOx5o4xgCUB4EWCz9snNFDJfu9/Vd8PxNHEEd1RSjV+esML7RyN Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xuw80r0w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 May 2024 21:13:30 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 441LDTlX021169;
	Wed, 1 May 2024 21:13:29 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xuw80r0w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 May 2024 21:13:29 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 441JjaXU002989;
	Wed, 1 May 2024 21:13:29 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xscppmjbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 May 2024 21:13:29 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 441LDQ4T47448784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 May 2024 21:13:28 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6829658057;
	Wed,  1 May 2024 21:13:26 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5D6D58059;
	Wed,  1 May 2024 21:13:25 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.157.98])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 May 2024 21:13:25 +0000 (GMT)
Message-ID: <e1d868f3612f2e3480e84d6489a78337a68cb748.camel@linux.ibm.com>
Subject: Re: [RFC 2/2] ima: Fix detection of read/write violations on
 stacked filesystems
From: Mimi Zohar <zohar@linux.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Stefan Berger <stefanb@linux.ibm.com>,
        Amir Goldstein
 <amir73il@gmail.com>, linux-integrity@vger.kernel.org,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        roberto.sassu@huawei.com, Christian Brauner <brauner@kernel.org>
Date: Wed, 01 May 2024 17:13:25 -0400
In-Reply-To: <CAJfpegtH8z3uRcSPCQ_3kj-XoV9rUnJc5nE+CQSrCuBMajEmeQ@mail.gmail.com>
References: <20240412140122.2607743-1-stefanb@linux.ibm.com>
	 <20240412140122.2607743-3-stefanb@linux.ibm.com>
	 <CAOQ4uxjDQO91cjA0sgyPStkwc_7+NxAOhyve94qUvXSM3ytk1g@mail.gmail.com>
	 <89b4fb29-5906-4b21-8b5b-6b340701ffe4@linux.ibm.com>
	 <CAJfpeguctirEYECoigcAsJwpGPCX2NyfMZ8H8GHGW-0UyKfjgg@mail.gmail.com>
	 <b74a9a3edc52d96a7a34d6ba327fdb2a5a79a80d.camel@linux.ibm.com>
	 <CAJfpegvPwpS5_S4qrrVbeC1RovP8jeNuDCYLbdcZ_XDFgfgftQ@mail.gmail.com>
	 <52645fb25b424e10e68f0bde3b80906bbf8b9a37.camel@linux.ibm.com>
	 <CAJfpegsHJ1JsM3SxNk5gnUM+aucqOqNm3RTrsYgePkcQYR4EEw@mail.gmail.com>
	 <e052c1b5d2aa29b3a1f3a8086af4fb8a94c4d318.camel@linux.ibm.com>
	 <CAJfpeguzh6VzhdnwOPf_hM4x0FbsK8hhZp=VK4kWpCYn0xeBCg@mail.gmail.com>
	 <254ee35d6534089e99f7396582572606f24ff3a2.camel@linux.ibm.com>
	 <CAJfpegtH8z3uRcSPCQ_3kj-XoV9rUnJc5nE+CQSrCuBMajEmeQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-25.el8_9) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vaRNOZvMwMH-RosCNAwXxXi3LMYThG4I
X-Proofpoint-ORIG-GUID: SQXZj7dqipWfHnMks8cJlRrnf_d2rjbO
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1011 spamscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2405010149

On Tue, 2024-04-23 at 13:06 +0200, Miklos Szeredi wrote:
> On Tue, 16 Apr 2024 at 21:06, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Tue, 2024-04-16 at 16:46 +0200, Miklos Szeredi wrote:
> > > On Tue, 16 Apr 2024 at 14:18, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > Originally there was a single measureent unless the filesystem was mounted with
> > > > SB_I_VERSION.  With commit a2a2c3c8580a ("ima: Use i_version only when
> > > > filesystem supports it") this changed to always re-measure the file if the
> > > > filesystem wasn't mounted with SB_I_VERSION.
> > > 
> > > Does the i_version get stored and compared only while the inode is in memory?
> > > 
> > > In that case I think it should be possible to support a version number
> > > for the overlay inode.
> > 
> > i_version was insufficient to detect a file change for overlay.  Commit
> > b836c4d29f27 ("ima: detect changes to the backing overlay") also compares the
> > i_ino and s_dev as well.  Refer to
> > https://lore.kernel.org/lkml/20231025143906.133218-1-zohar@linux.ibm.com/.
> 
> Which is rather ad-hoc.
> 
> I'm talking about returning something in overlay i_version, which
> really indicates the version of the overlay file calculated from the
> i_version of the underlying files.  The only issue is making this
> i_version persistent, AFAICS.  If that's not needed than the overlayfs
> specific logic in IMA could be moved into overlayfs, where it belongs.

IMA saves the i_version in order to detect whether or not the file has changed.
between one access and another. The i_version value, itself, does not need to be
persistent but needs to be consistent.

> 
> > Here in this patch set we need to detect IMA read/write violations, based on the
> > i_readcount/i_writecount.  If an overlay file is opened for read, but the
> > backing file is already opened for write, the file measurement is
> > meaningless.  An "open-writers" violation needs to be generated; and the IMA
> > measurement list needs to be invalidated.
> 
> If there's no other way, then let's implement an API to query the
> writecount that can take overlayfs into account.  This is for the VFS
> and/or overlayfs to calculate, not for IMA.

Thanks, that will definitely simplify IMA.

Mimi



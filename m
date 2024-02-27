Return-Path: <linux-kernel+bounces-83401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AB8869852
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E161B22129
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE418145B03;
	Tue, 27 Feb 2024 14:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oBGfoSNe"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E6B1419A0;
	Tue, 27 Feb 2024 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044168; cv=none; b=Y16Ef5V8anLVrmFnNB4Sn2fl0MjtuBxpGjWzEv/e2VeTzk1rWCXzq/IiWB522QeilZWh8HuB0qVO72Pitd+ym22beDv1rOXQcFaV4H/wa15MHZn8F7c9dPesMHiF200C1TzN4Z1b5zTccjFp8IpjpqGJ54B6zFeMLx33TWaxf6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044168; c=relaxed/simple;
	bh=L8Y8rnwu95x33EnTIXSjk4pEIYFULOLfxNY8Ak2Vvh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJ/8PH4Jvj8jeBoDjPhfkrsEzzjEEH2BFF9w4ujNZDLKlnjtRkoW5ZuzehIoT6Q3qUI3mb1UCn1Vx1IFFVH0AsMA24xKOIYlIuOgxBOxKupfdpnI3Y2V20GL512NEojVbIXZAL0mbmWhTDRC97fW6Po78CfWszSjfje/Eq0qG34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oBGfoSNe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41RDrKcO029324;
	Tue, 27 Feb 2024 14:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=etvuMIsXye1NyMwaxEALvpT3llw8g+DZmDk8l12N12Y=;
 b=oBGfoSNeSBC20vxMRJaiJlOIuYrzNyRZ7TnHU8dXZ8PPshNUZ3Zk1I353wii3xb8UZ8l
 4bSY4iNy/MoJqIXIVlNMk8x6ZJhUqP42uDVRLq/5BHkjEGUIZ9E+gZ5AkxAVfnm4QarC
 7pkWUcQ5lIbxAuWhOthlNvZjgkc/nguLuznaEPmziXJlK1lIHUM9Pcq+xAiqrzvLrQnK
 VaxaZ5cCNJN+zVcNoecoKJXzX0w0rW5dftxby4eGssh2fIlo5d7e7plArc9mkYPVQ/ev
 Hx0dktiwT+fBL/j4cDpY4tqMESa0R42bzuUBpdo/0+PSfFqK45EPY9cBLbbjb/T5g0JH Og== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3whh11948p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 14:29:25 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41RC3qqP008787;
	Tue, 27 Feb 2024 14:29:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wftstgerw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 14:29:24 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41RETJZ67799396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 14:29:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 106412004D;
	Tue, 27 Feb 2024 14:29:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE9E820040;
	Tue, 27 Feb 2024 14:29:18 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 27 Feb 2024 14:29:18 +0000 (GMT)
Date: Tue, 27 Feb 2024 15:29:17 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        pasic@linux.ibm.com, akrowiak@linux.ibm.com, borntraeger@de.ibm.com,
        agordeev@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH] s390/vfio-ap: handle hardware checkstop state on queue
 reset operation
Message-ID: <20240227142917.6127-B-hca@linux.ibm.com>
References: <20240215153144.14747-1-jjherne@linux.ibm.com>
 <3b5a812d-3832-6f34-a528-c67e59d76e65@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b5a812d-3832-6f34-a528-c67e59d76e65@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PmuyNpjsypTJA_M5gy-_YD3xJcSAAnhW
X-Proofpoint-GUID: PmuyNpjsypTJA_M5gy-_YD3xJcSAAnhW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402270111

On Tue, Feb 27, 2024 at 08:25:21AM -0500, Jason J. Herne wrote:
> Polite Ping :)
> 
> Patch already has R-b.
> Thanks for taking a look.
> 
> On 2/15/24 10:31 AM, Jason J. Herne wrote:
> > Update vfio_ap_mdev_reset_queue() to handle an unexpected checkstop (hardware error) the
> > same as the deconfigured case. This prevents unexpected and unhelpful warnings in the
> > event of a hardware error.
> > 
> > We also stop lying about a queue's reset response code. This was originally done so we
> > could force vfio_ap_mdev_filter_matrix to pass a deconfigured device through to the guest
> > for the hotplug scenario. vfio_ap_mdev_filter_matrix is instead modified to allow
> > passthrough for all queues with reset state normal, deconfigured, or checkstopped. In the
> > checkstopped case we choose to pass the device through and let the error state be
> > reflected at the guest level.
> > 
> > Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> > Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> > ---
> >   drivers/s390/crypto/vfio_ap_ops.c | 35 ++++++++++++++++---------------
> >   1 file changed, 18 insertions(+), 17 deletions(-)

Applied, thanks!


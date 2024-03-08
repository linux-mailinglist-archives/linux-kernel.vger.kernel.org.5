Return-Path: <linux-kernel+bounces-97284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 601B087683F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3C1CB20A13
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62602D029;
	Fri,  8 Mar 2024 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H3mmWpjE"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAFC366;
	Fri,  8 Mar 2024 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914782; cv=none; b=HyHewhphFBEt/hr7fmsDVOJGD6XHvhYm8cREpki5zSI5vOZuiv92YXtvOGWUAHbBQ8lh7fRMjVVfG/jP/6xDWjjdsoA2ToPRwU7eSlZQBAfht3xMAqq5aSN9uEfNzuyuA/e9Vfp2bJ3j4x4aogOy4lVCuq0lqe6VwVsFr1Cb8pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914782; c=relaxed/simple;
	bh=VwKU32SQzCD7f0r4iWSLv7o1A/bneCJg9/Su2issv1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VHCV99WAdJWcnNAiODmZC9AuYpQnClBMYdPPuJMmJALF+9wgPsRIFc/v/NosGxEoqzy5yo0VPHd0/6Ns5D8sJtwPbLOc8LnmGN7k3DjfWZD8s1iisPkZYYW7P/+SPJdghTfa59sVHcxBoCWrRQyEoJQnkMcA/NRCnPTcS+krcC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H3mmWpjE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428G25sS023981;
	Fri, 8 Mar 2024 16:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=8LHt9Nf2yj7BSVusITolUKNG+T02aIoq8SsB6ZGGRTQ=;
 b=H3mmWpjE2w4NLtAacezuptpfd9xJVIYou/ePhmvRSbrJvrjHz7mOgsnNWQCf8EvNETQ7
 PvxdbbEBbdQz0ILrjz0w5kn+hgdLK0Uy8+kVbo4ACvP15FIF1eCMQTyvOzUltynSDBRc
 5oCVOlxPd8pLev5MM1WPgT+6rbnfCJFxwewVi1dAAWW1dKKMlkujc2dw1HOrGvuauWer
 eCcwKNXhJnzo2ZAJU3qjjnZLGj1CtKAK6f9VBmHfJDnxApFEg6WOVA7nr+n7QeknJpS7
 PEw0mewu3NbT+MLu5GaK7rAaaMUfeAxyS2yGm7WynV7pMlzZJ673fWymS19P0rm6EREJ 9Q== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr5ub0bes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 16:19:36 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 428DUA44024160;
	Fri, 8 Mar 2024 16:19:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wpjwsrq2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 16:19:34 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 428GJTqF11927888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Mar 2024 16:19:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EAB52004B;
	Fri,  8 Mar 2024 16:19:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8972820040;
	Fri,  8 Mar 2024 16:19:28 +0000 (GMT)
Received: from osiris (unknown [9.171.32.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  8 Mar 2024 16:19:28 +0000 (GMT)
Date: Fri, 8 Mar 2024 17:19:27 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/6] s390: constify struct class usage
Message-ID: <20240308161927.26074-H-hca@linux.ibm.com>
References: <20240305-class_cleanup-s390-v1-0-c4ff1ec49ffd@marliere.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-class_cleanup-s390-v1-0-c4ff1ec49ffd@marliere.net>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MJh3Iq6EtVLnKM7yAa1penUKigB4fh9Z
X-Proofpoint-GUID: MJh3Iq6EtVLnKM7yAa1penUKigB4fh9Z
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=805 spamscore=0 mlxscore=0 phishscore=0 adultscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403080131

On Tue, Mar 05, 2024 at 08:25:18AM -0300, Ricardo B. Marliere wrote:
> This is a simple and straight forward cleanup series that aims to make the
> class structures in s390 constant. This has been possible since 2023 [1].
> 
> [1]: https://lore.kernel.org/all/2023040248-customary-release-4aec@gregkh/
> 
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
> Ricardo B. Marliere (6):
>       s390: zcrypt: make zcrypt_class constant
>       s390: vmur: make vmur_class constant
>       s390: vmlogrdr: make vmlogrdr_class constant
>       s390: tape: make tape_class constant
>       s390: raw3270: improve raw3270_init() readability
>       s390: raw3270: make class3270 constant
> 
>  drivers/s390/char/fs3270.c       |  8 ++++----
>  drivers/s390/char/raw3270.c      | 32 ++++++++++++++++++++------------
>  drivers/s390/char/raw3270.h      |  2 +-
>  drivers/s390/char/tape_class.c   | 17 ++++++++---------
>  drivers/s390/char/vmlogrdr.c     | 19 +++++++++----------
>  drivers/s390/char/vmur.c         | 18 +++++++++---------
>  drivers/s390/crypto/zcrypt_api.c | 33 +++++++++++++++++----------------
>  7 files changed, 68 insertions(+), 61 deletions(-)

Series applied, thanks!


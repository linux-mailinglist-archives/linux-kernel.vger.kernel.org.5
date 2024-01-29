Return-Path: <linux-kernel+bounces-42504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C39B840245
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B100A1F22366
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6D555E58;
	Mon, 29 Jan 2024 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SKSAjcFU"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AE859B49;
	Mon, 29 Jan 2024 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521978; cv=none; b=a/hrC3Zt5PvfTyjiTMHDRWGen2zM/aErpuSEg2mSuSgvPg2Hpwe36HJUiUTG5u5du0NKGJCee4sXsgCXHv1qB536+ry/jpv4h3y57drZ4/DvBFtLzvHPiSPkht1cjoEviZO+xScOXbuXaK4paI40xSRsepKpCkfCrUfs9pGNHic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521978; c=relaxed/simple;
	bh=oyc6YC+UnMBs4AnjnMQ3lMqIsNFfLoqBWzpH4/9Sh3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYZhTPX+/FeaQRgs1wd+bVc2lGXOw36Krz9/DZO32tbIqZDJldLqeks/3asLFSY8s3AOEAL83npLOJvsn63Nb94woWeQ8yltEGQ/4pY/QippBqIFowIy6Nb52GXn1jTqFzIcLS077FcNxcQKtotl2fBPW30GAWkvgo83GWF8TZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SKSAjcFU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40T8j5cB009027;
	Mon, 29 Jan 2024 09:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=T8yzjOj6VbfU/AtzvHhpBsK5Qg/KXZet/7IHkYOELGI=;
 b=SKSAjcFUGjyx4ZsO10RCmlgHGlxNt/1wkYtl1gFX+6qGeof/k7siWUWUw3kwippwkt0m
 DeVCqVmZdULrurFKdQvl+tp914+sIaTMfTmkMXb4VP4y/cn3HAyX5wtcIwMCBEb/XL3A
 3M1lmMrZxRiwEh8k/j3WxjGKVVyxO/miRC/4NmMdKuWzxeUyZaSLnLo+b/KfaCemSXte
 vdzeqrj0CO4k5n0t6A0MGxe2wtTTKMUKN+kvHGeqPYtjJevpmfTQhHOzZI2t1rITp2RH
 qPrAufnetdPrViAuj28W6gg/ouwhA/EQJgats8W1/W2EVP+fj6lI6Xs9thOaUe9+vLLb xA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vx6e2cqr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 09:52:48 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40T8XeBx011067;
	Mon, 29 Jan 2024 09:52:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwd5nfd2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 09:52:47 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40T9qf6x24511136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 09:52:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6973020043;
	Mon, 29 Jan 2024 09:52:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D923920040;
	Mon, 29 Jan 2024 09:52:40 +0000 (GMT)
Received: from osiris (unknown [9.171.85.65])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 29 Jan 2024 09:52:40 +0000 (GMT)
Date: Mon, 29 Jan 2024 10:52:39 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/5] sched/vtime: do not include <asm/vtime.h> header
Message-ID: <20240129095239.6722-C-hca@linux.ibm.com>
References: <cover.1706470223.git.agordeev@linux.ibm.com>
 <2402f44309e1c9705501bdc9b798e8fe6d73f905.1706470223.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2402f44309e1c9705501bdc9b798e8fe6d73f905.1706470223.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: t5dGNDAG7oDR415HEJK8W843mUfuva5W
X-Proofpoint-ORIG-GUID: t5dGNDAG7oDR415HEJK8W843mUfuva5W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_05,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=2 clxscore=1015 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=2 spamscore=2
 mlxlogscore=175 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401290070

On Sun, Jan 28, 2024 at 08:58:54PM +0100, Alexander Gordeev wrote:
> There is no architecture-specific code or data left
> that generic <linux/vtime.h> needs to know about.
> Thus, avoid the inclusion of <asm/vtime.h> header.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  include/asm-generic/vtime.h | 1 -
>  include/linux/vtime.h       | 4 ----
>  2 files changed, 5 deletions(-)
>  delete mode 100644 include/asm-generic/vtime.h

I guess you need to get rid of this as well:

arch/powerpc/include/asm/Kbuild:generic-y += vtime.h


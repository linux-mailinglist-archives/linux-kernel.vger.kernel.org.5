Return-Path: <linux-kernel+bounces-54493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AAE84AFF3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7101F21EA9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5FE12B177;
	Tue,  6 Feb 2024 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rh6lwEtt"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00262E827;
	Tue,  6 Feb 2024 08:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208276; cv=none; b=PZLvMPw43hbH9XSgNn8yayDvpLaO+91lpduTwxJTYKHjSZNFs/e1RW1F9R57+HKg+EsJipW9cDtKmFocsuIVnLUSPKDzcIPeleAy96q5eUx1W12Fvz6RCDEKcTMxJbQN6f0+q7C5G/7Wem76mGLaK5K+mcdlaINz0yXBtQy3At4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208276; c=relaxed/simple;
	bh=lt+1mLGMhm5l0/t98hXG5WEqjqSEDt/EpMtIkFWy9NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XQ+j5XrxhtrChOqTQdLL4folFTgg6st0wSLJvLPM7j/IWbdKdDb8QivRx+EVHZ2pBQ9twE18MBl6psp/h0X1yPBsa0GiOWnRu4SilN34n7FEQir0UaPu4cE7rqs/fuuzfqbq60tbvyyRA/kLXajJeGAr3313+7si7XPhn3Zvvlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rh6lwEtt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4168RIdS004498;
	Tue, 6 Feb 2024 08:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=//lNQevsjJgdzeHg50s9onUHKe1xQCX2+UPDb9DoeP0=;
 b=rh6lwEtt59EPNSZgyJTZZ3AfxXY2SK4OTZ//QreeCxTGTMbz28PUlQdihGPAoM7BaPd2
 L2HOTfsroDCi4vzfvScqJOv4srnEyVFDmErsf0tyw1fBBpv72+w6M1C2bM2JALRdIS2B
 cwYUYapLk0O8AV0Qt4pdy3gwLfrOJQy3LtRXqq6XC6HqUTWiLwwogFW/x0+SjSF97ioZ
 ceXffgWIyrPyfmi8SO8WZyIcfAc04n7sCajGs4UGbXxBVNwmlHeXwdfyerI2vbV5eQ5C
 o7R4gVb6Lg8ztBQsRuDLcldrGaiHmj4PZZnIcU3E8ds3sh7BRNBLkDtPo0ELK5p6hESR Rw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w3h9206j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 08:31:09 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4168CE8p016137;
	Tue, 6 Feb 2024 08:31:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w22h1wb1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 08:31:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4168V4Yq52232682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Feb 2024 08:31:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6830C20043;
	Tue,  6 Feb 2024 08:31:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B12D320040;
	Tue,  6 Feb 2024 08:31:03 +0000 (GMT)
Received: from osiris (unknown [9.171.32.22])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  6 Feb 2024 08:31:03 +0000 (GMT)
Date: Tue, 6 Feb 2024 09:31:02 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] s390: struct bus_type cleanup
Message-ID: <20240206083102.11958-A-hca@linux.ibm.com>
References: <20240203-bus_cleanup-s390-v1-0-ac891afc7282@marliere.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203-bus_cleanup-s390-v1-0-ac891afc7282@marliere.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y8XyZBvmITDIouv76GEN38J5rB9EztLM
X-Proofpoint-ORIG-GUID: y8XyZBvmITDIouv76GEN38J5rB9EztLM
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1011 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=566 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060059

On Sat, Feb 03, 2024 at 11:57:57AM -0300, Ricardo B. Marliere wrote:
> This series is part of an effort to cleanup the users of the driver
> core, as can be seen in many recent patches authored by Greg across the
> tree (e.g. [1]). Specifically, this series is part of the task of
> splitting one of his TODOs [2].
> 
> ---
> [1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=bus_cleanup&id=26105f537f0c60eacfeb430abd2e05d7ddcdd8aa
> 
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> 
> ---
> Ricardo B. Marliere (6):
>       s390: ccwgroup: make ccwgroup_bus_type const
>       s390: cio: make css_bus_type const
>       s390: cio: make ccw_bus_type const
>       s390: cio: make scm_bus_type const
>       s390: AP: make ap_bus_type const
>       s390: vfio-ap: make matrix_bus const
> 
>  drivers/s390/cio/ccwgroup.c       | 4 ++--
>  drivers/s390/cio/css.c            | 4 ++--
>  drivers/s390/cio/device.c         | 4 ++--
>  drivers/s390/cio/scm.c            | 2 +-
>  drivers/s390/crypto/ap_bus.c      | 4 ++--
>  drivers/s390/crypto/vfio_ap_drv.c | 2 +-
>  6 files changed, 10 insertions(+), 10 deletions(-)

Applied, thanks!


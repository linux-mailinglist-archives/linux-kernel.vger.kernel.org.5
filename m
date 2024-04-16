Return-Path: <linux-kernel+bounces-146528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 104108A6699
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 920F7B23719
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F2B84A5F;
	Tue, 16 Apr 2024 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KfT1Tzoo"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FA384A32;
	Tue, 16 Apr 2024 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713258016; cv=none; b=hkVVyTfWBmRHYCBEHwZ2Xg6AzvVSIekBj1Z7K4hq+fCVfwVFGSBmuTLfnHRscPKKd7ewnooYgf1jUKB5aQyakReMMVJvArDwkmMrwg9KfF5D01Aq6QMEiYPR6J0q2+eCFSjg+3ijycW64615WvlJ9jsyMlDksMp53fpCwKG6iEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713258016; c=relaxed/simple;
	bh=RgaBbswYd2rWACpPuI/2WL3QuUoVBkhz2aonoKtotR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRxs4wQ296MDS9pEOnfwFs9ox5HxEUEVtsY6T0EOERVVZmfWYjBkbq0AUgugEoyFRstiCKfiLEpNAqq2pnZMcdU5BLy5yncxFNEuaUQya6SHDyvwjRWeSaJQPMKXD6vX71i/etkaOfcpqcmZ/6YmDTtW+wayAQ4ASIMVV4pM9UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KfT1Tzoo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43G8YcRa005302;
	Tue, 16 Apr 2024 09:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=MrRL22TlcMpsSJ+r4JgU2PhHkQILKTZXjPvwSvpNHdA=;
 b=KfT1TzooHdNQoyv3EonBHQwozRg0cXokjdHscm+Fer6W0QyqcyNSHj8z4fptbTGp/WzH
 eGep1hY1EwhgpBL/v+IaM1AmLT+pRVkEKxSNRxXMkosWILVeMyk9BcJiZ79uL/K1VlUY
 D2P3Py4HVG4+Wy+ntl3hsRbLLBWd/Ry49k62rM5A4D2EERZcPRQoQYXLY2j0Gxg7j3LD
 PxC2TDDErkSJoOWh/angPaEGDchWmKR89lNOIQpZSz81Li/+Mcu8hui6NBoeal5IPtkj
 OSqC/ws93AV+THQZsJBIUPpG/ktGOzV8PXjUPidIoEC5YZGbV58jZVe2Y9qFu7DvR5pA uQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhjrngef0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 09:00:13 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43G66JYu023575;
	Tue, 16 Apr 2024 09:00:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5cnw4gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 09:00:12 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43G906wG27656756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 09:00:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A9062004D;
	Tue, 16 Apr 2024 09:00:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BDA620043;
	Tue, 16 Apr 2024 09:00:05 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.55.218])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 16 Apr 2024 09:00:05 +0000 (GMT)
Date: Tue, 16 Apr 2024 11:00:03 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        pasic@linux.ibm.com, akrowiak@linux.ibm.com, borntraeger@de.ibm.com,
        gor@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH v5 0/5] s390/vfio-ap: ap_config sysfs attribute for
 mdevctl automation
Message-ID: <Zh4+E9DkeQnPP52J@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240415152555.13152-1-jjherne@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415152555.13152-1-jjherne@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fniL-xancy0_D8sjW4ZFKrcWbZrr7DUs
X-Proofpoint-ORIG-GUID: fniL-xancy0_D8sjW4ZFKrcWbZrr7DUs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_06,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=664 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404160054

On Mon, Apr 15, 2024 at 11:25:50AM -0400, Jason J. Herne wrote:
Hi Jason,
>  Documentation/arch/s390/vfio-ap.rst   |  30 ++++
>  drivers/s390/crypto/ap_bus.c          |  13 +-
>  drivers/s390/crypto/ap_bus.h          |  22 +++
>  drivers/s390/crypto/vfio_ap_ops.c     | 224 ++++++++++++++++++++++++--
>  drivers/s390/crypto/vfio_ap_private.h |   6 +-
>  5 files changed, 266 insertions(+), 29 deletions(-)

Applied, thanks!


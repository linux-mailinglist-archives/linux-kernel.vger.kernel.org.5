Return-Path: <linux-kernel+bounces-38564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7815783C1A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7CA28D13C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F093FE2B;
	Thu, 25 Jan 2024 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kk1TANLx"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F78B36B10
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184546; cv=none; b=Rq2gHKp95VaxXVL08weJdWeBYwTPxmGszv652RavYhUnTRLo1y+i3nFdYECbqyOTrBnZls1MUmUt+IzG4EFi3gcEQAUZ2GlJoSDEQoETd5LwSzYLHvi9WVjdIoWKgCITqCf3t8sJilM9Yr77ojy4+Fc2AOudK7c/9CD1O91t9Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184546; c=relaxed/simple;
	bh=hW38eYKoD5Ps9w/tN9+u5C3X6PtP5pJcfVA7FxvEGEM=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=SNBJUlmsFKRe9BATvQdm5IebE2oVHlexe99WGgUaNM75EGdfxE9BykKQ8RtH6IygzFqA0IHqBK9WeI0rkTUQ52nu+farrtsctJFSuBVIZBhDlQYwby6LFXoI5bwVBQcr8fAvFMmXhEuWmL2RG7smxXJh3I4VYEicAxAqGnseFEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kk1TANLx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40PARGr1023178;
	Thu, 25 Jan 2024 12:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=b8dPyaQz/h6jJXdKMDdubzJRSxNKRomIcG79SDz6Jxs=;
 b=Kk1TANLxMlycgaRODkTjR9x1ZwAt0x//Gt36ek9IJWxfVNnx8rEbaY4bjYQmNiPDj/wQ
 SEh7xLyUiwnlQXN+QexvumuoGXIpkzi1Msj7FOoLvJO3gFSnUCh4AHRyzdAE/1Yqa11Y
 y5TWK8TNHX18ZEI0sv132QWtvwTIaPm2ZgySTL7mpNhADXWVh7/Q5IRU4UPYEsgRuijB
 FUsr4yhNdw/MCfvA/lbyGrMeY8/EidYJRhJSkSMhNki0ko4wdpob99adMg83Hn9G+YgJ
 dyTXE4YeMDJfPv1tISt3YPny3LdEKXlVHr6/JOk6Pe2hht1bL/JMl0ZVa1lPL5mwG4m7 Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vunwc2fd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 12:08:33 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40PC0QwY017059;
	Thu, 25 Jan 2024 12:08:33 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vunwc2fc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 12:08:33 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40PAOPrf025268;
	Thu, 25 Jan 2024 12:08:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrtqkkvt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 12:08:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40PC8T2w7602828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 12:08:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29E5A20043;
	Thu, 25 Jan 2024 12:08:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9096F20040;
	Thu, 25 Jan 2024 12:08:26 +0000 (GMT)
Received: from ltcd48-lp2.aus.stglab.ibm.com (unknown [9.3.101.175])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jan 2024 12:08:26 +0000 (GMT)
Subject: [PATCH 0/2] powerpc: iommu: Fix the vfio-pci bind and unbind issues
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: iommu@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
        naveen.n.rao@linux.ibm.com, jgg@ziepe.ca, jroedel@suse.de,
        tpearson@raptorengineering.com, aik@amd.com, bgray@linux.ibm.com,
        gregkh@linuxfoundation.org, sbhat@linux.ibm.com,
        gbatra@linux.vnet.ibm.com, vaibhav@linux.ibm.com
Date: Thu, 25 Jan 2024 06:08:25 -0600
Message-ID: 
 <170618450592.3805.8216395093813382208.stgit@ltcd48-lp2.aus.stglab.ibm.com>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LC7nRvPzH-Kt8toPgx8QCQGBERAvb_dp
X-Proofpoint-GUID: Hcp7wE1MLHbbbko411CUT4UzxRGgmrXe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_06,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=790 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401250084

On PowerNV and pSeries machines, the bind and unbind of vfio-pci is
broken with the below commits.

2ad56efa80db ("powerpc/iommu: Setup a default domain and remove set_platform_dma_ops")
0f6a90436a57 ("iommu: Do not use IOMMU_DOMAIN_DMA if CONFIG_IOMMU_DMA is not enabled")

Details of the same are in the following patch descriptions.

---

Shivaprasad G Bhat (2):
      powerpc: iommu: Bring back table group release_ownership() call
      iommu: Fix the domain type checks when default_domain is set


 arch/powerpc/kernel/iommu.c | 16 +++++++++++++---
 drivers/iommu/iommu.c       | 14 ++++++++++----
 2 files changed, 23 insertions(+), 7 deletions(-)

--
Signature



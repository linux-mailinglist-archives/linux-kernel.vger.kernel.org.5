Return-Path: <linux-kernel+bounces-127267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E82A8948F5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE712283EE2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6774F9EC;
	Tue,  2 Apr 2024 01:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XRPqv5UE"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B4FDDA9;
	Tue,  2 Apr 2024 01:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712022564; cv=none; b=WpGTpowFYt2iPZeEb2h7TLfUebn4YvJboMJS8mQbCuhaegKiUUI28uofLOfDwO6PJ13IFY2oR/1ONW+yKQjd6oXXOymLM12mRMGS48LtkExe9KiwfLHmFJYpcBpvdDM24pj1bBn7cAlS0Pa+5sDsFHlSBJmNc5Bn+m7kCeVM+qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712022564; c=relaxed/simple;
	bh=3BMAWjYxAFuWTZocux9maWZeauEJIUcxiIQtopfcuzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jkqe7kOI1lgYQq4bguMMYqXYd3nkoPmJKrUEuXPXH6nrXu7awhx+jpMq30ZmA/wpD4ljpZ/8ObGM9QxEzxzsc70sjOmhgk9DXoh/7Oky1e2dVkJTO5u7FqafWels0ypqae4TY1pXvviouGoqfPu1c5yHyM6ppt1UD5aaVVbCgBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XRPqv5UE; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 431Hdjcg027676;
	Tue, 2 Apr 2024 01:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=bmHfwrwvbHQZHXx0aPTRE9HNrALZx/0FJcq7sObSMo0=;
 b=XRPqv5UEp92a6+4X6F2behZA0gA6aN3zYUO2Vffio6H5X5SgO4wLBeQYWF+PLC6Rqx+b
 QZcj3GeRm15QXUbPVzBltPyYHXmdwVebxjCPEeluOT2Ur5q8nRwT0O6r6m2F48Xj9Um+
 Q8/IIHJSP9H3FBXmCzNnhGGVpCf3vvbO85AuxbKDt4ZhJ3MTtg0gLfHGTliHxxBL4pkV
 xbnz00qTKZ7vSdXI+tIp/lTYd+0lPwaRTnOs1zX9HTcBCui2XnAB41zp5s1sqv9dHDIY
 zB66NzmukIhI2LEdz6JkNpF8+BeU4HvIvledusdj1hp1b6c3qIuC4AVOPfwi/mafQT3n 3Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x6abubj86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 01:49:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 431NHIpX018767;
	Tue, 2 Apr 2024 01:48:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x696cd6ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 01:48:47 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4321mkNC030130;
	Tue, 2 Apr 2024 01:48:46 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3x696cd6bp-3;
	Tue, 02 Apr 2024 01:48:46 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: john.g.garry@oracle.com, yanaijie@huawei.com, jejb@linux.ibm.com,
        dlemoal@kernel.org, chenxiang66@hisilicon.com,
        Yihang Li <liyihang9@huawei.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@huawei.com, yangxingui@huawei.com
Subject: Re: [PATCH v4] scsi: libsas: Allocation SMP request is aligned to ARCH_DMA_MINALIGN
Date: Mon,  1 Apr 2024 21:48:37 -0400
Message-ID: <171202249161.2135322.4854478001132847216.b4-ty@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328090626.621147-1-liyihang9@huawei.com>
References: <20240328090626.621147-1-liyihang9@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_18,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2404020012
X-Proofpoint-ORIG-GUID: YTX-9KlkJ7oIqRHTaiiFqxb3wtqC2l6K
X-Proofpoint-GUID: YTX-9KlkJ7oIqRHTaiiFqxb3wtqC2l6K

On Thu, 28 Mar 2024 17:06:26 +0800, Yihang Li wrote:

> This series [1] reducing the kmalloc() minimum alignment on arm64 to 8
> (from 128). In libsas, this will cause SMP requests to be 8-byte-aligned
> through kmalloc() allocation. However, for the hisi_sas hardware, all
> commands address must be 16-byte-aligned. Otherwise, the commands fail to
> be executed.
> 
> ARCH_DMA_MINALIGN represents the minimum (static) alignment for safe DMA
> operations, so use ARCH_DMA_MINALIGN as the alignment for SMP request.
> 
> [...]

Applied to 6.9/scsi-fixes, thanks!

[1/1] scsi: libsas: Allocation SMP request is aligned to ARCH_DMA_MINALIGN
      https://git.kernel.org/mkp/scsi/c/e675a4fd6d1f

-- 
Martin K. Petersen	Oracle Linux Engineering


Return-Path: <linux-kernel+bounces-82625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4323E868764
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B2A1C27CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48176208AD;
	Tue, 27 Feb 2024 02:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iOZyNEfM"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E191B200A0;
	Tue, 27 Feb 2024 02:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709002055; cv=none; b=pYfrtCnbdcg2L5BXMnHQIKgPTvmI+Vz9KTsw51pYr4CAVLFAVCbgzGSWoGl5nSFFHs26XTBOonN8ANgABghuX95GJ1BvQd9F82PKWSNs6IiePJjvj18TM0TCKx/aMaVocsOEBy3Lda3H3PtGACp2qso3fiQJR6Nng1cLaWbZ1Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709002055; c=relaxed/simple;
	bh=M1eMfPgInHxhL59jpRH9kAh1NkkGlq74g37M2D+wdKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZkmMj0e3hTHoetbvWFvPpcC6oP6aanYT7O1L0jBNbkcdn3giVwxWBMZlXb7RHLH8d5a6KALU3VP9lltjqCWUPSbEjjH+5AwyNp7r3TXaTQL2T70ahJZIWhXV4sgRTaqGz3zSUNh1H4uuY6kOjA8+UQ3HcP0mQwlyQyQHqtezkS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iOZyNEfM; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41R1FYZK025669;
	Tue, 27 Feb 2024 02:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=wKC+omDhh5DOKXN9cJ0C8fmf93fsonG/WWT1GB8nEIM=;
 b=iOZyNEfMlN9KkSPRiy66KJkArs1ZuX4h5F7MddQ8qxrBqBOh9Wrevc9N5POtJo8Xm2y3
 6jtdtwea6/fyDaHx3bia1PPfjcP6wKG9sdAw7nmiK5jR+SnVR7DiKynFDv87dN+42nTM
 gWfbgezx3xxJ9TMyML6rJlypXsYXdFc6w7tT65j9mJa1KPWkK2QyOEcajpXkeR9lIt2F
 kxiEgaIDQ7nyxquB5WA64Ftdqt3GND8REmnA6ZBWMrLJORlnHd65iRawR72bMjecpUm4
 XOUCF+soLc3zYPILiM8X01nCy3XfeWmQJrHMBxAHqigUqTsUypIr/4UzJwg8XiI/Ahzz +Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf82u6002-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 02:47:25 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41R0MMFD025490;
	Tue, 27 Feb 2024 02:47:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wd0n2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 02:47:24 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41R2lNAe026317;
	Tue, 27 Feb 2024 02:47:23 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wf6wd0n28-1;
	Tue, 27 Feb 2024 02:47:23 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Ranjan Kumar <ranjan.kumar@broadcom.com>,
        Tomas Henzl <thenzl@redhat.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] scsi: mpi3mr: reduce stack usage in mpi3mr_refresh_sas_ports()
Date: Mon, 26 Feb 2024 21:47:14 -0500
Message-ID: <170900202640.3669151.3772018788684563610.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240123130754.2011469-1-arnd@kernel.org>
References: <20240123130754.2011469-1-arnd@kernel.org>
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
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402270021
X-Proofpoint-GUID: vRSAya9COKBLyudmFgJeiroVLsZZAUo8
X-Proofpoint-ORIG-GUID: vRSAya9COKBLyudmFgJeiroVLsZZAUo8

On Tue, 23 Jan 2024 14:07:36 +0100, Arnd Bergmann wrote:

> Doubling the number of PHYs also doubled the stack usage of this function,
> exceeding the 32-bit limit of 1024 bytes:
> 
> drivers/scsi/mpi3mr/mpi3mr_transport.c: In function 'mpi3mr_refresh_sas_ports':
> drivers/scsi/mpi3mr/mpi3mr_transport.c:1818:1: error: the frame size of 1636 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> 
> Since the sas_io_unit_pg0 structure is already allocated dynamically, use
> the same method here. The size of the allocation can be smaller based on the
> actual number of phys now, so use this as an upper bound.
> 
> [...]

Applied to 6.8/scsi-fixes, thanks!

[1/1] scsi: mpi3mr: reduce stack usage in mpi3mr_refresh_sas_ports()
      https://git.kernel.org/mkp/scsi/c/5cc2da0b60e5

-- 
Martin K. Petersen	Oracle Linux Engineering


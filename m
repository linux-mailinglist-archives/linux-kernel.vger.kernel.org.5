Return-Path: <linux-kernel+bounces-4585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AEA817FA6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1381EB23D06
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEE75689;
	Tue, 19 Dec 2023 02:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D4GJdneZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23531FDE;
	Tue, 19 Dec 2023 02:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ0JnfZ025828;
	Tue, 19 Dec 2023 02:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=j5VRO7qxP7OMJ2AhEF1ZWy9zjqXUQZwBbwvHH35DvGw=;
 b=D4GJdneZynGJvZh2sfoi1f/+avrZZXKZ1Uu59r1dVxkYzJtrRUH4irNODyPEIBFX8iPz
 wmAZQikIs7g6B4YfOBRxAKK59KmMzLJF1DVnOOIoVkTTfj8lscc0d2kOPQ1RS2W97IPw
 LcGRMzHTnEMZ4/fAwdmnG8PJLm0U18QCI7mmLIOVxQhlQvol6CzRaQ2dPCMVMLMVN+nM
 +/EtaTQlY20gYPP7bKWY/Fs5PbmCTUNTK0HY2eIL1yw4OXcg0AIpbwOHHlRlfu4ajcCW
 YsvdT/HYH922A4x7z0ksPXQ/DtKd2o/2IFhf6sTCD6aKsNSrDeZREarXBT13g/AEXO6r jg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12p44unb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 02:19:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ0ZAX8020991;
	Tue, 19 Dec 2023 02:19:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b69t89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 02:19:14 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJ2J7ZD012682;
	Tue, 19 Dec 2023 02:19:13 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3v12b69t3t-6;
	Tue, 19 Dec 2023 02:19:13 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: sebaddel@cisco.com, Karan Tilak Kumar <kartilak@cisco.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, arulponn@cisco.com,
        djhawar@cisco.com, gcboffa@cisco.com, mkai2@cisco.com,
        satishkh@cisco.com, jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/13] Introduce support for multiqueue (MQ) in fnic
Date: Mon, 18 Dec 2023 21:18:50 -0500
Message-ID: <170294822163.2675590.10020304744988699046.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231211173617.932990-1-kartilak@cisco.com>
References: <20231211173617.932990-1-kartilak@cisco.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_15,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=993 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312190017
X-Proofpoint-GUID: NlpOyqmmPQu8aTNf2yQdjpSF7xSF48D8
X-Proofpoint-ORIG-GUID: NlpOyqmmPQu8aTNf2yQdjpSF7xSF48D8

On Mon, 11 Dec 2023 09:36:04 -0800, Karan Tilak Kumar wrote:

> This cover letter describes the feature: add support for multiqueue (MQ)
> to fnic driver.
> 
> Background: The Virtual Interface Card (VIC) firmware exposes several
> queues that can be configured for sending IOs and receiving IO
> responses. Unified Computing System Manager (UCSM) and Intersight
> Manager (IMM) allows users to configure the number of queues to be
> used for IOs.
> 
> [...]

Applied to 6.8/scsi-queue, thanks!

[01/13] scsi: fnic: Modify definitions to sync with VIC firmware
        https://git.kernel.org/mkp/scsi/c/2cda90e6f649
[02/13] scsi: fnic: Add and use fnic number
        https://git.kernel.org/mkp/scsi/c/ca008aeeb02c
[03/13] scsi: fnic: Add and improve log messages
        https://git.kernel.org/mkp/scsi/c/3df9dd0d51c2
[04/13] scsi: fnic: Rename wq_copy to hw_copy_wq
        https://git.kernel.org/mkp/scsi/c/86b86a7d2fda
[05/13] scsi: fnic: Get copy workqueue count and interrupt mode from config
        https://git.kernel.org/mkp/scsi/c/8c2a6f815a18
[06/13] scsi: fnic: Refactor and redefine fnic.h for multiqueue
        https://git.kernel.org/mkp/scsi/c/554a14826020
[07/13] scsi: fnic: Modify ISRs to support multiqueue(MQ)
        https://git.kernel.org/mkp/scsi/c/8a8449ca5e33
[08/13] scsi: fnic: Define stats to track multiqueue (MQ) IOs
        https://git.kernel.org/mkp/scsi/c/b559b827716c
[09/13] scsi: fnic: Remove usage of host_lock
        https://git.kernel.org/mkp/scsi/c/848d010ab934
[10/13] scsi: fnic: Add support for multiqueue (MQ) in fnic_main.c
        https://git.kernel.org/mkp/scsi/c/52f6e196e52e
[11/13] scsi: fnic: Add support for multiqueue (MQ) in fnic driver
        https://git.kernel.org/mkp/scsi/c/c81df08cd294
[12/13] scsi: fnic: Improve logs and add support for multiqueue (MQ)
        https://git.kernel.org/mkp/scsi/c/55cf715244a7
[13/13] scsi: fnic: Increment driver version
        https://git.kernel.org/mkp/scsi/c/53021c192cc5

-- 
Martin K. Petersen	Oracle Linux Engineering


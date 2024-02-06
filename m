Return-Path: <linux-kernel+bounces-54185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D10384AC0A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A37B287ECB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7F75A0FB;
	Tue,  6 Feb 2024 02:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qg/7gR6m"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53395A0E9;
	Tue,  6 Feb 2024 02:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707185402; cv=none; b=R2n4NHTEBcVWpt54KbePpMAdh3ORIinhBPSE8xjyFlW549EzhdeHL2DAG2qOdjtb+uc71+dcfZoagqoJy81bjKumJ7yHfBo9+MNEaP2hLXqqCnLEe4hdD26ztY+nncRxSCOb1zvAh5UscY43kaxLo0FPK+Xnydg1oHi12BVqT0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707185402; c=relaxed/simple;
	bh=wXZ7on9ZacefHMakxM5K44hEI/YqdV4PBf7mSuIbtiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQa2j1rDBDr1dDaUw4ddN1cz19b/3ZwMuX91bYz7MtN1B8PEYmGx1byw8UXnf+WmQJ/srJhMpqCl16FdUTMpbqeV2thW4BiWL8vevlQkDq/18LsjKj66fIy9CUy2wcVUjImMG7l0fKg/WHHr0tTGiX8Tj0AUFvKs8N/yMA1yjLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qg/7gR6m; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4161EL9J020716;
	Tue, 6 Feb 2024 02:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=kWLW+rKj7J9xnZhyEp49tXVd6PZDaAaTix1Fh55T45g=;
 b=Qg/7gR6maNzGrxfGscPsWA4scU8t0xcT8r6WNXI6FIzLw8KW/VG7qi6hQui/knurBxSA
 MTFXi5id90zZ40Hvwmcxu6YBOsCYpyBE21czlVG03OEG4+DCAGdCNpvwaUoGtbZbIjsF
 hw0Qbiy667824iOlKCDR84UoOJPyFf1qC3lRF+ZK18gJbYHq0Y7XgkHcAOjVcTp9+wFp
 vj2NIesuE6VIxsD+2kE6cgNUTLnEu2t1zsnA1hYJmJZaDkA1pbqEuWKMYXEdSjbk+IEx
 ltHeSmrZsUwkkJp1lyYuVsUUzT7Lmrn+g5VLqijAIrQZNSVek+3t4SEm/WTPRtPlNfGU Eg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1bwengt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 02:07:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 416165dk039333;
	Tue, 6 Feb 2024 02:07:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx6cdrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 02:07:52 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41627qHH034652;
	Tue, 6 Feb 2024 02:07:52 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3w1bx6cdrb-1;
	Tue, 06 Feb 2024 02:07:52 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: jejb@linux.ibm.com, Lee Jones <lee@kernel.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Adam Radford <aradford@gmail.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        Andre Hedrick <andre@suse.com>, de Melo <acme@conectiva.com.br>,
        Joel Jacobson <linux@3ware.com>,
        "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>,
        Richard Hirst <rhirst@linuxcare.com>
Subject: Re: [PATCH 0/5] scsi: Replace {v}snprintf() variants with safer alternatives
Date: Mon,  5 Feb 2024 21:07:37 -0500
Message-ID: <170715263669.945763.9109810582389494681.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240111131732.1815560-1-lee@kernel.org>
References: <20240111131732.1815560-1-lee@kernel.org>
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
 definitions=2024-02-05_18,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=954 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402060013
X-Proofpoint-ORIG-GUID: sOV9ZS4Lqr5IzF_bHf0BCwEeNbbeo5so
X-Proofpoint-GUID: sOV9ZS4Lqr5IzF_bHf0BCwEeNbbeo5so

On Thu, 11 Jan 2024 13:17:21 +0000, Lee Jones wrote:

> For a far better description of the problem than I could author, see
> Jon's write-up on LWN [1] and/or Alex's on the Kernel Self Protection
> Project [1].
> 
> [0] https://lwn.net/Articles/69419/
> [1] https://github.com/KSPP/linux/issues/105
> 
> [...]

Applied to 6.9/scsi-queue, thanks!

[1/5] scsi: 3w-9xxx: Remove snprintf() from sysfs call-backs and replace with sysfs_emit()
      https://git.kernel.org/mkp/scsi/c/a977c8158a42
[2/5] scsi: 3w-sas: Remove snprintf() from sysfs call-backs and replace with sysfs_emit()
      https://git.kernel.org/mkp/scsi/c/7eaa48e9e497
[3/5] scsi: 3w-xxxx: Remove snprintf() from sysfs call-backs and replace with sysfs_emit()
      https://git.kernel.org/mkp/scsi/c/30cc6aa09eee
[4/5] scsi: 53c700: Remove snprintf() from sysfs call-backs and replace with sysfs_emit()
      https://git.kernel.org/mkp/scsi/c/f615c74de383
[5/5] scsi: aacraid: aachba: Replace snprintf() with the safer scnprintf() variant
      https://git.kernel.org/mkp/scsi/c/bc978cc18d46

-- 
Martin K. Petersen	Oracle Linux Engineering


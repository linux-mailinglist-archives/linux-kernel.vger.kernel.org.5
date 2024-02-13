Return-Path: <linux-kernel+bounces-62875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E7585272B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A201F261A0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5D44430;
	Tue, 13 Feb 2024 01:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m9Fx9zwu"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF74138C;
	Tue, 13 Feb 2024 01:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707789448; cv=none; b=tRMmG9ixWZPL2/wH51iQwtjPILoCe4G+I+wn8FNRkP4yV4v7OcEirRgOcrmOZSZC2NtAED1Kd7Ihv2j0UZljIIQ4rL6CrFAHh3KMBnbNonbMZOndk0ysAPiA3FqYWkAe7pOivI0pfxhgtnT0ANcH2hrHEHaUBAQg9qpg/Ngds2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707789448; c=relaxed/simple;
	bh=xmj4o0CdVgE5lED5Le9y7LxCJNif/wR0CRonl+9y/yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpdPqXIS2zEX3Fg5SNa7Xjq7472X+UJcZ63u5daW44tiULbubH/TYtLtlv5456ldqbNFZoLcgCRZCeQ6YHX6IPYqfu+XnnEUUb1E6e49GFwW0C0MuBE+rlpMNATcV8oq46cb1qcD69eaTom6Kp1PgUzSr5byaSpeENQxbQ8MK1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m9Fx9zwu; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D1hm9F006438;
	Tue, 13 Feb 2024 01:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=Lh/hBdrarHRzchKDuPiZYbMlC0+vPxFkfo5CWMLulbo=;
 b=m9Fx9zwu7K1e0HDDtbJ1cyhdm8YRb1L1KHnaWyvbphj/JDcLmSBzrLBPDalqI76SgpXJ
 JxhbHap0eXFAS/QkPj4XWyxaOQ6uUjUD43PjHg718jeNFwW/uz+8UNdlyICI1p35Ehjo
 YkOIcHWazbk4aNIrpECNjHelWclpN3b8UHzaoAUGyGD3cwTqtQCp/vNnQTvSM+cGX8+c
 vzsPUr1rzN7pwBFRJHmAahrtH/hO4gOrrgIJpdi9epKxvIyOj9T/+wsZCQ4Pa9x6lNbF
 pHyxJku4zmvohHgH3/bWkmhd0kxA11DjPDtXsryxExPl0NfR4NawWG5TEF+MHbAVE0yW ow== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7xt500wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 01:57:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D01ha4000873;
	Tue, 13 Feb 2024 01:57:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6ms09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 01:57:20 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41D1vJGC016701;
	Tue, 13 Feb 2024 01:57:19 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3w5yk6ms05-1;
	Tue, 13 Feb 2024 01:57:19 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Duncan <leeman.duncan@gmail.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Chengfeng Ye <dg573847474@gmail.com>, hare@suse.de,
        Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Karan Tilak Kumar <kartilak@cisco.com>, Lee Duncan <lduncan@suse.com>
Subject: Re: [PATCH v4 0/2] Ensure FCoE target interrupts work correctly
Date: Mon, 12 Feb 2024 20:57:09 -0500
Message-ID: <170778915962.2192303.5279236168147495494.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1707500786.git.lduncan@suse.com>
References: <cover.1707500786.git.lduncan@suse.com>
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
 definitions=2024-02-12_20,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=519 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130011
X-Proofpoint-GUID: uRwiecKIAtwbp20g8xz2UBt5E5nowwiB
X-Proofpoint-ORIG-GUID: uRwiecKIAtwbp20g8xz2UBt5E5nowwiB

On Fri, 09 Feb 2024 10:07:33 -0800, Lee Duncan wrote:

> Commit 1a1975551943 "scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock"
> changed locking for fnic/FCoE, but it did so by disabling interrupts
> where they weren't disabled before, and this caused FCoE targets
> to go offline. Reverting that patch fixed the issue.
> 
> But to handle the problem originally addressed by the commit,
> instead of modifying the locking, move the work to be done
> into a work queue.
> 
> [...]

Applied to 6.8/scsi-fixes, thanks!

[1/2] Revert "scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock"
      https://git.kernel.org/mkp/scsi/c/977fe773dcc7
[2/2] fnic: move fnic_fnic_flush_tx() to a work queue
      https://git.kernel.org/mkp/scsi/c/379a58caa199

-- 
Martin K. Petersen	Oracle Linux Engineering


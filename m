Return-Path: <linux-kernel+bounces-29403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD952830DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3FD1C21B17
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445E924B28;
	Wed, 17 Jan 2024 20:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lpIoSlX5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050292511A;
	Wed, 17 Jan 2024 20:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705522248; cv=none; b=uVUE0yd8J9QzDSfH/hO0AWweDKucGXeUoA2vAwDyoi7rLQSK6T9fEdHcmRj2F6XEEiIfU7vGKWNoa8p6cYfYRIgzetbEma7clfAytSFQOxf9q3NahaeUSqPi6LEySFjHQCzuztTRFQwgRNl7vp+9/SNtfeLJAF6BNkrxwy9oZWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705522248; c=relaxed/simple;
	bh=RmfGzAd/XgykEqUzjFuwCSJPDuRGpVUMwaab5mAYSJo=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID; b=EJpGKRwaHeg+TiB/uGgMaH/2FdoHP/CUZPiP2QqXmtAGeOr0UayeyJYuaDgOukRrbwBaAX9tuGAcBf+ApWbcs3QffyOmwxn6OoPXkPTORmE9zTHCyfCH0HgtXGmXdbgrwI63cVncnhOvl34fDMfcFQVxch+hD3jHYTcXKHdxkck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lpIoSlX5; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HJcnKA021406;
	Wed, 17 Jan 2024 20:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=AvM1dSX52GX9U/Q66X0eKsNnXAEtqQDh3nrOhSoMltM=;
 b=lpIoSlX5nhF5ucWekCNM4PAJf17t0M/fFTrAgfUPfYKtKHNg35B+hmiY2aBsyKl1KLxS
 NK7LrwVdyJh+PJREa0LZgztcYIJw57ezHG7z5APcfvkXzym06dRlZ4HvZU2qYGW6ZNmf
 y9nniV3SQNF1LKqkr4p0VPFYXEmPlOFOvoVPPifiJzujd9gIfENtFYXOegUKxFC1rsu4
 0Anmpm5JePTMez2cJHFDAsq+WFQoVnidU5atszpYwf6i0EHC9SX9t1IbivfqIRU7BsSa
 9U0+q7f5eoyjKnQ1h+Y5xrNo143q52sywquBxoMQWbgw9iZ9vauqmcD8L80YdRfB3iMg eQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkjjegwre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 20:10:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40HJUHuJ020137;
	Wed, 17 Jan 2024 20:10:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgyb1c26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 20:10:21 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40HKAHCF030718;
	Wed, 17 Jan 2024 20:10:20 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vkgyb1bw6-3;
	Wed, 17 Jan 2024 20:10:20 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        mpi3mr-linuxdrv.pdl@broadcom.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: mpi3mr: fix mpi3mr_fw.c kernel-doc warnings
Date: Wed, 17 Jan 2024 15:10:07 -0500
Message-ID: <170552035086.3348001.5949735061638738947.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231221053113.32191-1-rdunlap@infradead.org>
References: <20231221053113.32191-1-rdunlap@infradead.org>
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
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=597 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401170147
X-Proofpoint-ORIG-GUID: YdCJ382JztDB6b2J6ZoO1N0XQvPEYhJD
X-Proofpoint-GUID: YdCJ382JztDB6b2J6ZoO1N0XQvPEYhJD

On Wed, 20 Dec 2023 21:31:13 -0800, Randy Dunlap wrote:

> Use correct format for function return values.
> Delete blank lines that are reported as "bad line:".
> 
> mpi3mr_fw.c:482: warning: No description found for return value of 'mpi3mr_get_reply_desc'
> mpi3mr_fw.c:1066: warning: bad line:
> mpi3mr_fw.c:1109: warning: bad line:
> mpi3mr_fw.c:1249: warning: No description found for return value of 'mpi3mr_revalidate_factsdata'
> 
> [...]

Applied to 6.8/scsi-queue, thanks!

[1/1] scsi: mpi3mr: fix mpi3mr_fw.c kernel-doc warnings
      https://git.kernel.org/mkp/scsi/c/904fdd2062f3

-- 
Martin K. Petersen	Oracle Linux Engineering


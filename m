Return-Path: <linux-kernel+bounces-141801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516258A239B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0129A1F22297
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D209D171A7;
	Fri, 12 Apr 2024 02:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qt/t8GOI"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2623DDB8;
	Fri, 12 Apr 2024 02:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712887539; cv=none; b=ms6JNQqtMNuRKL5NbmiqNFYhuDlXdOJIr5XhjKZVcJiIjB/srv5DwjEzzcG2UfWzEAD1+td7pxrm/0w8BiRTaTZ31+2EGLhq7/l3nptk+DIIujVdwbL2X8qkL/9810NQAHGupGljHOVhrYUEgaVxdDIwTlJxiZgwJr53aGLjHOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712887539; c=relaxed/simple;
	bh=eiMcr3tKWfdOajOKj3aV5hQ4Keqv6oFeJ/fMJLoMfVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RHxZYl0P/rGGP3eXzo+xBgONHYHiKFebvqS6Y4XATH4Di5ByAoVVao3l2wFfWFYmfxB6trMbFjxShArF6XfJX6sB+hn34x6tq6cnYOudu7HyixTewHL6B5yvcXA2yhDQsx6wpuPn253GKGinUb62y6/fUC+GFGP7eDIS+/ics5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qt/t8GOI; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43BHs7NB024172;
	Fri, 12 Apr 2024 02:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=v4JjHBO9ZfUIQ6HpttTrCWBq1z75rDYn8quCjQnfPxk=;
 b=Qt/t8GOIauA6W7jSs26Q2hqE2yYlpQqRk28rLi0MaU89RDgfiLZ0YlT4ILqPimHfRuZS
 0RazQC37WwgFvRTJnOMdQHc8XdCTeBMyXPOOMHXkYugvDBZ7BisNFDFhIXweVXkm89z4
 f1iwrLCaPVJtey/EhyeWvE9MRBuYBTflIjG1gsoF2Cu0PZsC+e8UCxuqD8QqkBmYDTmQ
 Cq3h8XhvW+GT6wZ8TKfmFWYkCHxnwRtQ08AYzG4WXjdb6pdJdVhmacRdIZDImXCqxgZd
 aN4Cmvu8x3GPNQZ2uGHfFcLpApVTcuF1TyGzu3lmx3XTEHr5PMhBVIrS5mAZBN4qW6xP JA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xax0utw51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 02:05:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43C0F5TM040162;
	Fri, 12 Apr 2024 02:05:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavugmd2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 02:05:32 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43C25UFk013100;
	Fri, 12 Apr 2024 02:05:31 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xavugmd1x-3;
	Fri, 12 Apr 2024 02:05:31 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org
Subject: Re: (subset) [PATCH v2 01/25] scsi: aacraid: Convert sprintf() family to sysfs_emit() family
Date: Thu, 11 Apr 2024 22:05:10 -0400
Message-ID: <171288602651.3729249.16274043151321098202.b4-ty@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319063132.1588443-1-lizhijian@fujitsu.com>
References: <20240319063132.1588443-1-lizhijian@fujitsu.com>
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
 definitions=2024-04-11_14,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404120014
X-Proofpoint-GUID: NYME5ZvdmnDzZbDL4sS5r_OmmjgmpcsZ
X-Proofpoint-ORIG-GUID: NYME5ZvdmnDzZbDL4sS5r_OmmjgmpcsZ

On Tue, 19 Mar 2024 14:31:08 +0800, Li Zhijian wrote:

> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> or sysfs_emit_at() when formatting the value to be returned to user space.
> 
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
> 
> sprintf() and scnprintf() will be converted as well if they have.
> 
> [...]

Applied to 6.10/scsi-queue, thanks!

[12/25] scsi: snic: Convert sprintf() family to sysfs_emit() family
        https://git.kernel.org/mkp/scsi/c/eab302e89f3d

-- 
Martin K. Petersen	Oracle Linux Engineering


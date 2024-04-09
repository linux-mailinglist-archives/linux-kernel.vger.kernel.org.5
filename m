Return-Path: <linux-kernel+bounces-136168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B734489D0BC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8DED1C224B1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162F2548F9;
	Tue,  9 Apr 2024 03:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kDdjjbmq"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24FD762F8;
	Tue,  9 Apr 2024 03:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632163; cv=none; b=s7mehQ6s9rVWagWhZbBMP1InPPksDTElx3mISR4F2uLFJxJQC0NCnNqvnhA3pqQVi1flrxMmHQn+lVXup1PK3KJszOz36ZTHcqrgzrwv0OMuTzJw1r543HtVNCFxovKwIKJ+0xsYgFaYvG7a/NNnEDoh5sFSAm8bkpdiM963hwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632163; c=relaxed/simple;
	bh=CQ4kHtXmSlTCEKFKjUcJPYXU4rAZRhCLTgFIC9/77uM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmAFKYH+EwlZ4YfXM7uAx1jWXfcoWnhANCMu4iJRcZEnHIXrmygXWKv+rNKlTkETCmk0r6ku1c8fxazmpM6tkgl31ivIO7SgyxBFVK6bcBLPBNJfqf1MYRTDknV3Fgspv/wt7fsbhphyTAZzMvxJuZaJDM6crUT5HZYvrm4q7cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kDdjjbmq; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438Ln5Ac013214;
	Tue, 9 Apr 2024 03:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=I1kwtWVsd09P1c4oQc3NhxV8xHoHjoJIs2C84Zz1jt4=;
 b=kDdjjbmqSuNw35uvKo/Pv05ELmXBA0O9d9eX7mn4RIUfZBG4i1Q5e2mIcADtCgB44LXi
 9Jz6cnSc+oLFPDDo1PtPqhg/XryPE5aH8hmURqLWK1qwRIRdIWL1KvGu7PnM8YvDjnEx
 Lx8OGOAN5N7Vb1lKTJl+wJGNS15n5DJfTQs8H6CpXzRplD5EoFAvtb5zpd7QKPvVtiiV
 /q06Bl7lv97v1Zx9bJGM2qq998Cn6svzj1wVLnr9pBkhhFIurP9HaH46Yr63j16HT66v
 yOT7hC0Q+mrRhIzGwAxVfpvp9r3XqmHmKHf4htnd6yuHl7FOPQQLe3HTrJjkpP1Udoj/ /Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xavtf44xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 03:09:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4391NqCB020038;
	Tue, 9 Apr 2024 03:09:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuca6ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 03:09:03 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 439392FB012913;
	Tue, 9 Apr 2024 03:09:03 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xavuca6e1-2;
	Tue, 09 Apr 2024 03:09:03 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>, Arnd Bergmann <arnd@kernel.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] [v2] cxlflash: fix function pointer cast warnings
Date: Mon,  8 Apr 2024 23:08:51 -0400
Message-ID: <171260277849.3109929.1668041090243479256.b4-ty@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404161524.3473857-1-arnd@kernel.org>
References: <20240404161524.3473857-1-arnd@kernel.org>
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
 definitions=2024-04-08_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404090018
X-Proofpoint-GUID: -_XBwNVxPZXBmBkFdUdqEDIHQTbQZZGZ
X-Proofpoint-ORIG-GUID: -_XBwNVxPZXBmBkFdUdqEDIHQTbQZZGZ

On Thu, 04 Apr 2024 18:14:58 +0200, Arnd Bergmann wrote:

> Calling a function through an incompatible pointer type causes breaks
> kcfi, so clang warns about the assignments:
> 
> drivers/scsi/cxlflash/main.c:3498:3: error: cast from 'int (*)(struct cxlflash_cfg *, struct ht_cxlflash_lun_provision *)' to 'hioctl' (aka 'int (*)(struct cxlflash_cfg *, void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>  3498 |                 (hioctl)cxlflash_lun_provision },
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/cxlflash/main.c:3500:3: error: cast from 'int (*)(struct cxlflash_cfg *, struct ht_cxlflash_afu_debug *)' to 'hioctl' (aka 'int (*)(struct cxlflash_cfg *, void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>  3500 |                 (hioctl)cxlflash_afu_debug },
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to 6.10/scsi-queue, thanks!

[1/1] cxlflash: fix function pointer cast warnings
      https://git.kernel.org/mkp/scsi/c/28fc2bd2c729

-- 
Martin K. Petersen	Oracle Linux Engineering


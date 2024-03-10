Return-Path: <linux-kernel+bounces-98357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C255B87791C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776EF1F21642
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD243C488;
	Sun, 10 Mar 2024 23:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LuiLPCKd"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCD13BBDF;
	Sun, 10 Mar 2024 23:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710111881; cv=none; b=fkwwtbPraPB9pDvqTG4tUpMEXxJvEHXCmrFP39H/TzGcRNk1+yief/UXA7eR2wAfs4ZwEU8kHDIoW97pQ1oBVCGVQ10yRCNNZhx/reG5ivFrNCCypRJWcchFFThcQTSzKpELI4+FSm4eApVt0/CR7IHZ1mKix7W02Jh0zqjorSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710111881; c=relaxed/simple;
	bh=xsSCg1gIRfOme0qklPp8Mf3tndy3KcT8aeAC76zRIw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nUbI+2GdkjPI8soSmE8uS8gKlHRoQ2nagbMKqU8x7jsUu39B/+i/wXF2v9zkYTSgvKpbbQgQjPETtBlWp3DLPVAYiOJsVIBIEuf+O8nog7ujhz1EGEFY39HtGIkjblIWYWwuQ2NBP2GIAWEepUP0iqOnCuDiHYPpUvSCpRmxpX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LuiLPCKd; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42AJHw3T023445;
	Sun, 10 Mar 2024 23:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=f+FpPc4r1PZZdnJlL9j5cCgKyKK/ti6jzEW4uDteAb8=;
 b=LuiLPCKdYmBUX4HPpw3r+LJCreOcQHeGO0wW9hSeLGcq5yy4CcIe70CsLE315Y2AQpBG
 PNS5QWI5swQWW5FxJ9yJFUZxQ72iT76x2sqFHDMaw7LJA3nQ/1Mc4Ty8TZTukDYEjj2s
 OApGoYZ5w3uY4KDiDS5Di5L8qOCxJewF69xbJfqmcBgEJSEssVimDsh6uVVy7IiSkDm5
 uZ60B6gQL2bM1v+TwVrAc3A3zDhTPpCMYMKYIgPY+1ZxC5GONp60U4lSDwfrMCVRzgq9
 Kq60NgDOdY4QXUsQJeb2WJ8K1G/QMp9dtD9jGgMyBwSaaRsKytNMtUdWQ76Hn/S31vbV 1w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrej3stu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 23:04:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42AIUIgY004790;
	Sun, 10 Mar 2024 23:04:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre750ne5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 23:04:30 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42AN4TSC006839;
	Sun, 10 Mar 2024 23:04:30 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wre750ndq-2;
	Sun, 10 Mar 2024 23:04:30 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Justin Stitt <justinstitt@google.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] scsi: libfc: replace deprecated strncpy with memcpy
Date: Sun, 10 Mar 2024 19:04:18 -0400
Message-ID: <171010474754.3838281.7412694993720179449.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240221-strncpy-drivers-scsi-libfc-fc_encode-h-v2-1-019a0889c5ca@google.com>
References: <20240221-strncpy-drivers-scsi-libfc-fc_encode-h-v2-1-019a0889c5ca@google.com>
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
 definitions=2024-03-10_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=809
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403100187
X-Proofpoint-GUID: -lc6KRz5DNNYPN7JoNIakS6QpDoyRZ6q
X-Proofpoint-ORIG-GUID: -lc6KRz5DNNYPN7JoNIakS6QpDoyRZ6q

On Wed, 21 Feb 2024 23:50:26 +0000, Justin Stitt wrote:

> strncpy() is deprecated [1] and as such we should use different apis to
> copy string data.
> 
> We can see that ct is NUL-initialized with fc_ct_hdr_fill:
> |       ct = fc_ct_hdr_fill(fp, op, sizeof(struct fc_ns_rspn) + len,
> ...
> 
> [...]

Applied to 6.9/scsi-queue, thanks!

[1/1] scsi: libfc: replace deprecated strncpy with memcpy
      https://git.kernel.org/mkp/scsi/c/3e24118ec185

-- 
Martin K. Petersen	Oracle Linux Engineering


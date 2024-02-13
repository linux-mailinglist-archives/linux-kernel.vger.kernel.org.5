Return-Path: <linux-kernel+bounces-62876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D5D85272F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0941F265A8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE91849C;
	Tue, 13 Feb 2024 01:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hvH5nxM1"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FBC79DF;
	Tue, 13 Feb 2024 01:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707789481; cv=none; b=bcYWvAoAUcEioLX5Va1Cs8MVLUURvMcs7hlfaD2HBdtu7k5ucRwuTBLTTXBvF4EgTk/E7Bg/8YY5h1JGRV5T/uxF2Df2vF7Y1S01fcK2RLv2vGfKzwLtoFTYfbX2MzukKfUov1G4jXuk4macpOREzRHH66hFIqeA5DZGJeOGHu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707789481; c=relaxed/simple;
	bh=4Pmw8M4aI0IKdTTvha7fcRQFvJNGdIe19vJcBseBKdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPMAZQ9MAFXgzkI0wQA4QNkIuIG/PmhHZD/DhShrU3Big/1gjw5kWi7oN3Zfd3jpBJSKLC1pC5NcLQ+9zaklKT7UJfloweljQQQn3XumSFTwno4edAHom3EEZ1v4P5eXqXAdrtU8TovjwMNf3rkjqONrfKjDtN42Gl2/6Sf5uD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hvH5nxM1; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D1hvs4017458;
	Tue, 13 Feb 2024 01:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=HNm0IOa9Q/cPbgW7SJ+Tu5MjfZLGw2RzEpHqIWyVsGI=;
 b=hvH5nxM1nfIFCXqL4bRJFYxk2mo4hZXT3kxy/9AXP2vOdlZvs9O4KO83awuDCbyarQSA
 /Zz+oxIQ7vqXN8/LRQN2gbNbxbFOEcuGRPXy8tDpzGHbNcMOkZHhX19jCcB3xr9OiCKE
 JQBDVjrMj6kb3vtgQwoaLwY2uBaUn/sKeTlGudaOhs4V1yHZvYYHhdD09K5blOL/eO8I
 Jd+PpRE3aU+tMGyrFtxg4Vu38wToblZ0Iw6yiDVLOhlUKQprjPbLke9eAOS0O4JW7MiC
 qAqffNVmsco3Nazpwmcer1hGWCt12hHYL3da8occIfbB8xunuJ1hy2+spLi1AuejSpH2 aw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7xqv014d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 01:57:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D0DfsL024614;
	Tue, 13 Feb 2024 01:57:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykcw3ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 01:57:49 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41D1vm1j022232;
	Tue, 13 Feb 2024 01:57:49 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3w5ykcw3a9-2;
	Tue, 13 Feb 2024 01:57:49 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        open-iscsi@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/3] drivers: scsi: struct bus_type cleanup
Date: Mon, 12 Feb 2024 20:57:42 -0500
Message-ID: <170778686840.2103627.12956797195697757629.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240203-bus_cleanup-scsi-v1-0-6f552fb24f71@marliere.net>
References: <20240203-bus_cleanup-scsi-v1-0-6f552fb24f71@marliere.net>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=763 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130011
X-Proofpoint-ORIG-GUID: J34ByVUJ0oSxCl4qnH3YNwWs81QQ4h9x
X-Proofpoint-GUID: J34ByVUJ0oSxCl4qnH3YNwWs81QQ4h9x

On Sat, 03 Feb 2024 15:38:59 -0300, Ricardo B. Marliere wrote:

> This series is part of an effort to cleanup the users of the driver
> core, as can be seen in many recent patches authored by Greg across the
> tree (e.g. [1]). Specifically, this series is part of the task of
> splitting one of his TODOs [2].
> 

Applied to 6.9/scsi-queue, thanks!

[1/3] scsi: fcoe: make fcoe_bus_type const
      https://git.kernel.org/mkp/scsi/c/4dbde797b946
[2/3] scsi: iscsi: make iscsi_flashnode_bus const
      https://git.kernel.org/mkp/scsi/c/824ec98b1b55
[3/3] scsi: scsi_debug: make pseudo_lld_bus const
      https://git.kernel.org/mkp/scsi/c/ac0dd0f33adb

-- 
Martin K. Petersen	Oracle Linux Engineering


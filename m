Return-Path: <linux-kernel+bounces-43828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB473841949
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC7B1C25034
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A27F53805;
	Tue, 30 Jan 2024 02:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EPY0zTNl"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE9536AF0;
	Tue, 30 Jan 2024 02:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581674; cv=none; b=BrT89KI2HaCWuXbEp6+Ogv4UvwxkZ1Ycc7l6gYILwuFv+AhaEwi0wMrfWE2soXUc/9YDZrZRygGI6d5PF4cocD16LearPR5Jg/CMzfRNHVzCMLDiDmFpj3TE7mfwRwwaihTkGxE9dk4xBOjnUhANqsX35RyUVRaEl7SCSzQ3mjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581674; c=relaxed/simple;
	bh=biDR4WVh8XwgitufaXUjQcfAIksXStyHX6/Ssx8yLmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTtf/LRf3ZDtRWSTU9AfEg5yzROZK7P11KoAwYver6w4G50Um5fec7kOL63kN79fy8S/azzGk9v0R0dsVrNAFIMYsLfNPi4OGsM7MpXfpmH6xbqyMzVLapYTgIuwdhX3XjP28/4XstvogX4cRQbSIDfzrMWSIjqYGErLOiYpmfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EPY0zTNl; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJi2N1017505;
	Tue, 30 Jan 2024 02:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=yqWSbwF5NH44g18kVWwJLR6zAlw8G2QsBTkijrmQatg=;
 b=EPY0zTNlaC6RdOAGidWVfc/lvITKjkb0sa1LGnTqi27IQGOzP/p10mcYInB2g9apZmdd
 z5AsgaXZHReJeVe0neuVnPsqe9QTWivYRmftlXrKTwKIm1j2dETxEVBGMJA635uY/dIL
 jbOOxl59akhzW9b5UoNlMec81/HPwvgTwbHXZxwIYcBHEZGghKu52YMeC8rqO4QDkVCT
 LLOB8J4FP597TLt+cOEF/1z5VEyiK7GJst/mOJbt5xmw0XiMKvDVnhfhQWUzYnlHAr2Y
 5hvEKQ/lJyywceMYEcoWYlS0yJwYRV+dINczlk5CKqcyX2HEWI2frC13XqDu3+YjPPy+ 1g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvseude7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 02:27:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40U0evBW014627;
	Tue, 30 Jan 2024 02:27:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr96g53t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 02:27:43 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40U2RP02040916;
	Tue, 30 Jan 2024 02:27:42 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vvr96g4y7-12;
	Tue, 30 Jan 2024 02:27:42 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Petr Mladek <pmladek@suse.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Down <chris@chrisdown.name>, oe-kbuild-all@lists.linux.dev,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] scsi: core: Safe warning about bad dev info string
Date: Mon, 29 Jan 2024 21:27:08 -0500
Message-ID: <170657812665.784857.18111081210924770600.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240111162419.12406-1-pmladek@suse.com>
References: <20240111162419.12406-1-pmladek@suse.com>
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
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=856 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300015
X-Proofpoint-ORIG-GUID: SSQX7xMkesmg1gfh8kZFddCgohtmOVi4
X-Proofpoint-GUID: SSQX7xMkesmg1gfh8kZFddCgohtmOVi4

On Thu, 11 Jan 2024 17:24:19 +0100, Petr Mladek wrote:

> Both "model" and "strflags" are passed to "%s" even when one or both
> are NULL.
> 
> It is safe because vsprintf() would detect the NULL pointer and print
> "(null)". But it is a kernel-specific feature and compiler warns
> about it:
> 
> [...]

Applied to 6.9/scsi-queue, thanks!

[1/1] scsi: core: Safe warning about bad dev info string
      https://git.kernel.org/mkp/scsi/c/796cae1a79b1

-- 
Martin K. Petersen	Oracle Linux Engineering


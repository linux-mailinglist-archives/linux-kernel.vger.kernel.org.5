Return-Path: <linux-kernel+bounces-127266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F302C8948F2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1452D1C22FA1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130D2D52A;
	Tue,  2 Apr 2024 01:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K8/b6Wpz"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D98945A;
	Tue,  2 Apr 2024 01:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712022561; cv=none; b=Bfh0cU4+fmZtvOtuxXZLJCbeQlfr/9Nf7XG2JSso2GuVvDj2w5LBXSTSRBypXS84cB/c3FL280kz2ThenS7nURJ0x7blJi52Hcy30WwtxQaDnRba0j21uijRYD0hb/eWTydp0tUU4BLzpOQErBnI0Ea2wXGK+KSHDpAn3JJuvS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712022561; c=relaxed/simple;
	bh=ymwed1k6ACtf8fgdJkYzQ7Ru5D8myQY+P/QQYMl/qZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=blF7WWqcgMWQcf6BWmIxE5MZ9DTqDprFeE4nE+2+gHYGcH3P7Xf1Mcoxq0XHyQi7PP6Cmjc84bbZmvUQp3lfc5Qh+CmwbZ4Balz7Xm3UKm48t3jaYwddUrJh7sUACBsim9lGLpLgScfwTNPznor8Dly+9jsrzAcRJeTqcQYjjIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K8/b6Wpz; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 431Hod0P027630;
	Tue, 2 Apr 2024 01:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=uMOzZ+I5p5VMxZzmb/C9JkxZpA8LRmSnYdKsdawaLFE=;
 b=K8/b6WpzOmOFj64e04Exy43ARLBxUVBctfpRgb11UvLR2xdlMPKuDX3m7m7aH39WaaiL
 RHkWiyrZsTMA+L6z2dyYg/6wHVmylrCQF0fuUZVaIwOmbhNymCkaXreBNKICCHbSIKg6
 zJQlSkkmuo5oT3fvUKcM018rgXvHA4UEpWSh5cLNf6gMq6PueItHf4qotJChKoRykLbd
 SIuWZuRN8Uww+a8Ib/J0u1NIkNWWo8dN/jlBEwweARtCy8Tq437wKVPqH2d/fW8Lw7wg
 NAfxort1oNckUS9APoumHsBadktWXVwaa/fFK/vF5nyrxANhMzM41zVbPkSYC7ETuhq0 vw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x6abubj85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 01:49:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 431NQ7ZA017967;
	Tue, 2 Apr 2024 01:48:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x696cd6c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 01:48:47 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4321mkNB030130;
	Tue, 2 Apr 2024 01:48:46 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3x696cd6bp-2;
	Tue, 02 Apr 2024 01:48:46 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: jejb@linux.ibm.com, mcgrof@kernel.org, linan666@huaweicloud.com
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] scsi: sd: unregister device if device_add_disk() failed in sd_probe()
Date: Mon,  1 Apr 2024 21:48:36 -0400
Message-ID: <171202249157.2135322.13476364200143136492.b4-ty@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20231208082335.1754205-1-linan666@huaweicloud.com>
References: <20231208082335.1754205-1-linan666@huaweicloud.com>
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
 definitions=2024-04-01_18,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=904 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2404020012
X-Proofpoint-ORIG-GUID: Io5SB_bFnyfgLu5TorF_EUg7TJ5N68oz
X-Proofpoint-GUID: Io5SB_bFnyfgLu5TorF_EUg7TJ5N68oz

On Fri, 08 Dec 2023 16:23:35 +0800, linan666@huaweicloud.com wrote:

> "if device_add() succeeds, you should call device_del() when you want to
> get rid of it."
> 
> In sd_probe(), device_add_disk() fails when device_add() has already
> succeeded, so change put_device() to device_unregister() to ensure device
> resources are released.
> 
> [...]

Applied to 6.9/scsi-fixes, thanks!

[1/1] scsi: sd: unregister device if device_add_disk() failed in sd_probe()
      https://git.kernel.org/mkp/scsi/c/0296bea01cfa

-- 
Martin K. Petersen	Oracle Linux Engineering


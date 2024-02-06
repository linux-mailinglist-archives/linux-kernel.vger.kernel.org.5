Return-Path: <linux-kernel+bounces-54183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9278B84AC05
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36C14B2106D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9C458100;
	Tue,  6 Feb 2024 02:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ljjohSHb"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82D857323;
	Tue,  6 Feb 2024 02:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707185360; cv=none; b=hbNWvRrHTiSH1Tq73YROHw6PTE1txeR3YCHtOh9u7bFAL/SEXRHZhMAK1SmU2QqXLPTo62kNDB88ul4DeRnbUksaJ/S1lmQ7xAKVQX/OlCUnbFJImi+aU5VuYrf2vpluYrMwzgbEVdxR8l03CJZeQGs7KVQLShTDCdq830ELj9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707185360; c=relaxed/simple;
	bh=wdnYagnlXJL8GHTWDPK85zAJiKUOzaiblB/nDgI8EEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lb8Cbrzeg8qPbcmDADL0Uim81V/bfKCenUI13M7CmfYIkU4RT/3eQ6MTXuvo0GLGpZG+SbkIAWG9BLRaT6IMbXhmLL336G73tbL/hzzOVGueMGzBuAoCky0N36odJB372CeNKX4AhO6mYiaG6tMWdrHG9V+/Wt6vW/2XXh8PbGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ljjohSHb; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4161EldR002551;
	Tue, 6 Feb 2024 02:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=G7HdZBkNz5lLne62b3vVRjDKdnTLtIWxgUypQkVo4AA=;
 b=ljjohSHb7RahFnjBOG3x3E09HIb0dVEAJ5eP8bgI8ZbBWSbbF+Uzs43DI6tol6B8J3rw
 4G8IWAIJ4YMlrteZlnJLyOq6eIiHF3pE1kAr6moWhdRwsinO9IJaq2r9pBJR5XmxIOAy
 +wOSob4GU/QFymEoKbLMFp5AyIX1VsHZdWSXBqy78eoH5pFOYjQNmK7QYejzKEBxh6FE
 I+UkB/31hDerT3kT8SoTFPYW2BwZKD51F1T07kyPthXPneaBq00FpGdu31BCnVAddxpA
 gHWniid75jMySMshfWofBluu4mGxkXMDEiJIgReaP1Khp4p1fFfsbRzKTGO6i2f4pVGS NQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1cdcwkn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 02:09:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4161o9cD039427;
	Tue, 6 Feb 2024 02:09:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx6ceh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 02:09:11 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 416297CM038970;
	Tue, 6 Feb 2024 02:09:10 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3w1bx6cef6-3;
	Tue, 06 Feb 2024 02:09:10 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        beanhuo@micron.com, bvanassche@acm.org, kwangwon.min@samsung.com,
        kwmad.kim@samsung.com, sh425.lee@samsung.com, sc.suh@samsung.com,
        quic_nguyenb@quicinc.com, cpgs@samsung.com, grant.jung@samsung.com,
        junwoo80.lee@samsung.com, SEO HOYOUNG <hy50.seo@samsung.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v1] scsi: ufs: core: Remove the ufshcd_release in ufshcd_err_handling_prepare
Date: Mon,  5 Feb 2024 21:08:57 -0500
Message-ID: <170718504185.1101069.1333761980481958791.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240122083324.11797-1-hy50.seo@samsung.com>
References: <CGME20240122083204epcas2p26a1bca522e201972ca072e0b24d23a52@epcas2p2.samsung.com> <20240122083324.11797-1-hy50.seo@samsung.com>
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
 spamscore=0 adultscore=0 mlxlogscore=723 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402060014
X-Proofpoint-GUID: T7j6YWOXvAeiB03GXynNiuLI1jWPZs40
X-Proofpoint-ORIG-GUID: T7j6YWOXvAeiB03GXynNiuLI1jWPZs40

On Mon, 22 Jan 2024 17:33:24 +0900, SEO HOYOUNG wrote:

> If err_handler is performed in the suspend/resume situation, ufs_release
> can be called twice and active_reqs valid can be negative.
> This is because ufshcd_errhandling_prepare() and
> ufshcd_err_handling_unprepare() repeatedly release calls.
> Eventually, active_reqs have a value different from the intention.
> To prevent this, release duplication processing was removed.
> 
> [...]

Applied to 6.8/scsi-fixes, thanks!

[1/1] scsi: ufs: core: Remove the ufshcd_release in ufshcd_err_handling_prepare
      https://git.kernel.org/mkp/scsi/c/17e94b258541

-- 
Martin K. Petersen	Oracle Linux Engineering


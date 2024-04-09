Return-Path: <linux-kernel+bounces-136166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A1489D0B9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBAE0284F0E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776BD54773;
	Tue,  9 Apr 2024 03:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rxzy7HHx"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3531D54BDA;
	Tue,  9 Apr 2024 03:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632158; cv=none; b=Begom8fcSz3eFGT7w5EyEY4yNBDG9eUkKMyjeU/Fb803mh8Yt2dPrSrjJ3Ww3UIKFiSxNYKNzDDQHgJKc7qOpp23pGi1v3aCUW6fvCA/0aFHr3gWk8uxNRsUnrqYiMhOFrWr7bHBnBGGxYgMoGHjuxGvaBXpybJ0Ql3C5R0jx3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632158; c=relaxed/simple;
	bh=s84R/QNSBP4M44H6LFkEyJVzicIiPwCXHRnXHiRWOUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KzduNJKE2ZWyK+Vc7VhFlwI7TSHBOimD7bFy43ozxXgZsksvfsDjkqEcgHc++MEuSuaLzbR7qFiHsi5L1yUDvzeQoBdmGyxpgd0Zyeo/6Q4E1HwHHxjQbQ86g1zwNdPcXAW/I/zbHqH96hC6oEHN39JLkcubdJBVCktVCaX85xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rxzy7HHx; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438LmwmD018610;
	Tue, 9 Apr 2024 03:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=vE+9o9BkLURaI9VMoiOQYusDiI3hCMVMoz5FiCiu6CI=;
 b=Rxzy7HHxRdqP+7asazirdy4MxpcZcAEAsk3+YlQfbUN8ue/ymMWBizhyS66LGo9uJH6g
 Qxv833omkbf2sXpmysZfJJ5jViNLvXDtU1NtxnOYRGvC4AwYDqe4ItfuSqxY6ddhKfTt
 ETx0Sgq1dY/D5y9tuHaUP/+2F3XCX012i+2Vjl3q67zGnU7ybEEl+5mNYYIO+iXzkjQS
 pp8Jd1wZ6NMJn3r9fdft5J8wu3wR/yeDT2UnVVT1O6+EUj1qx7ubuZK/hL3scBLWC+SJ
 seqk/k+0wmcalH5o0mGqzxlUbsQ9Djrs3IR9aEluTSpLi8x5aDGwVm1DwY7yY6+EKKao kQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaw6445xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 03:09:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 438NjXev017921;
	Tue, 9 Apr 2024 03:09:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuca6fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 03:09:05 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 439392FJ012913;
	Tue, 9 Apr 2024 03:09:04 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xavuca6e1-6;
	Tue, 09 Apr 2024 03:09:04 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH 0/4] scsi: Prevent several section mismatch warnings
Date: Mon,  8 Apr 2024 23:08:55 -0400
Message-ID: <171260277844.3109929.5187390857869116431.b4-ty@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711746359.git.u.kleine-koenig@pengutronix.de>
References: <cover.1711746359.git.u.kleine-koenig@pengutronix.de>
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
X-Proofpoint-GUID: dEEkDF4sRO2VvVDh3BInaZMA7K7vVCGs
X-Proofpoint-ORIG-GUID: dEEkDF4sRO2VvVDh3BInaZMA7K7vVCGs

On Fri, 29 Mar 2024 22:11:40 +0100, Uwe Kleine-König wrote:

> this series fixes the same issue in four drivers. The warning is a false
> positive and to suppress it the driver structs are marked with
> __refdata and a comment is added to describe the (non-trivial)
> situation.
> 
> Best regards
> Uwe
> 
> [...]

Applied to 6.10/scsi-queue, thanks!

[1/4] scsi: a3000: Mark driver struct with __refdata to prevent section mismatch
      https://git.kernel.org/mkp/scsi/c/e81bb6f59b35
[2/4] scsi: a4000t: Mark driver struct with __refdata to prevent section mismatch
      https://git.kernel.org/mkp/scsi/c/e70d4cce8923
[3/4] scsi: atari_scsi: Mark driver struct with __refdata to prevent section mismatch
      https://git.kernel.org/mkp/scsi/c/bb8520996fe1
[4/4] scsi: mac_scsi: Mark driver struct with __refdata to prevent section mismatch
      https://git.kernel.org/mkp/scsi/c/4a0166d55edd

-- 
Martin K. Petersen	Oracle Linux Engineering


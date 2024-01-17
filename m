Return-Path: <linux-kernel+bounces-29401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D27830DC3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807A31F221B1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE6924B30;
	Wed, 17 Jan 2024 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U6AmF3tN"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA25724B20;
	Wed, 17 Jan 2024 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705522225; cv=none; b=SCnwy7ZnAJN+BEDwRz4JlZ8+o7NDajyeTuhktGH/Xf5T1J4RfbENcOQNeYUuVFjrR/wdtuwlklxlf06LMB1XCtYL91oHOeZhjn5zuodaW4+SnGbM3pxuJVcCFSzhauFeaArVIAR93V6sZm7q3vS3vNU8/D743MIczkR0y8yc1oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705522225; c=relaxed/simple;
	bh=SF5JQcvnVmt4Tnjms+Ejj9mC3MVPiWRTIEHklx99jCM=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID; b=ML4EUwHUKNmatzjvtYMGWzxkXJukADByBXZigqiMeVix0uQz9yhmhl+Vkqgt4Eq+tYPf9ysRGa7SPaezl1rHW6lzZZDAP4DpU+ox+tzC7Fsm5pmgY/2OWYAEj5w92P3Mh7+b4PPqQR2Kmb57S/X7DLovliYvE4V3A2aIsHmYoxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U6AmF3tN; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HJciOd003038;
	Wed, 17 Jan 2024 20:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=1zjVlsCpmMyOvWsQhON2/QjBIUYtMmVfKY/1cWTuImM=;
 b=U6AmF3tNLEAe/mOB8EC4WNa+ZqZezuSHCr1bLGBTnBcNUdzXrWxBMXJ2lgPKfOersF85
 VPUBIZHKYovwD2eRcB1ddVeTe6+o35V8eSgOE15H8ckHDW1zuEnu5hSTRNyMk0vvhBbH
 EHcRWeSBwsitybNhR72N98tUuPcb2PA/78kjb1SzWA1G2q4j1/ue3WOVamE3JkC4ATZn
 Y9Imx3vB+hU9bPdrwLtgL5orJAWAL6aFj8jp8GSc0jZQiBs45fXNh2Z1bgLvHKbjdhpf
 c9/4t8fDfu2P/Swha5B3P6iybZUM1e25x/Rwx7EgdIGDt3aNY0aYFnxN+qpLeeksP3to EA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkm2hrqt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 20:10:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40HIsM84020000;
	Wed, 17 Jan 2024 20:10:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgyb1byg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 20:10:18 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40HKAHCB030718;
	Wed, 17 Jan 2024 20:10:17 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vkgyb1bw6-1;
	Wed, 17 Jan 2024 20:10:17 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Karan Tilak Kumar <kartilak@cisco.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Arulprabhu Ponnusamy <arulponn@cisco.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: fnic: unlock on error path in fnic_queuecommand()
Date: Wed, 17 Jan 2024 15:10:05 -0500
Message-ID: <170552035092.3348001.1586940422453299571.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <5360fa20-74bc-4c22-a78e-ea8b18c5410d@moroto.mountain>
References: <5360fa20-74bc-4c22-a78e-ea8b18c5410d@moroto.mountain>
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
 spamscore=0 mlxlogscore=647 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401170147
X-Proofpoint-GUID: jO8xc34yIqNE87m8hJLI73MQUrJeXS2O
X-Proofpoint-ORIG-GUID: jO8xc34yIqNE87m8hJLI73MQUrJeXS2O

On Wed, 10 Jan 2024 21:41:55 +0300, Dan Carpenter wrote:

> Call spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags) before
> returning.
> 
> 

Applied to 6.8/scsi-queue, thanks!

[1/1] scsi: fnic: unlock on error path in fnic_queuecommand()
      https://git.kernel.org/mkp/scsi/c/38945c2b006b

-- 
Martin K. Petersen	Oracle Linux Engineering


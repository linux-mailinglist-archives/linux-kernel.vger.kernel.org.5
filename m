Return-Path: <linux-kernel+bounces-157921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F948B189A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FD81F24C79
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8DA10A14;
	Thu, 25 Apr 2024 01:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dPf4qBDS"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6C3F9F5;
	Thu, 25 Apr 2024 01:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714010244; cv=none; b=l8TEcXVjsu/dEXYWS7ySecS1Sk9jQ8oXHs6s38DCG1BBZXUaSrRZVSimIEo8HtyZeB+S9p3Vcr9JfGqfdBIGuyPzd3HNZKuN8/ka9baN957UWy/KNWLWfedfaA4HDlMKbqrVG5yZb3uaBhIG2U/R9HD8VfLB7XagupeHIpr8r1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714010244; c=relaxed/simple;
	bh=lqaTTxB2g6SKJSdMCfNg86WYDJ+Vs/l+VpTs7KzpyR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ov57iVN6VHFLwiKI8Romuiga0RmAmMNBrbRhm+T4Zg4DoS7zyLi+itDSm8yxHtkRC3EVJA/gsPKIuinF16KZZPNRjRu0RGi4kuGdkBGc4yoHM65y726kgOwN8Le/76gr4tU7/wfhwA6NlR8OnX7ypE8j+BZ9kV3MteUkuPtNaLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dPf4qBDS; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43P0jUJQ032490;
	Thu, 25 Apr 2024 01:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=iD0eF3jpWi06WFWT9jICwohhM4CtHMBbrSU7TQYtR80=;
 b=dPf4qBDSj5YqS2qRQr2i57JC+eZa9uy0kJzl6761X/ycy3kJh9Hzyc7+xUGy04YUvIER
 RAGu/sPMVDJwdxUnW1hWoct+rS0B1qKb7z8YYM6QQidTktjmankZEsSnRqFOzl7iHbwr
 xjJRmiwvAT1RqO9KKPWS8GZOgL3LM64tAKvoAOpy9ZCNwn5T0WNMeyC4AHW9rvGdy4VX
 ztGSPAh57KPYP684cHkujDW40J9w/Bgs6zFsavXBUdTd1IZFEX25AEydMOXqVjfa3ndy
 /kFgkzQa7EDyi/9e8/5uvlD6vzCIkfrOGGgcRu98UGyHRbn/vtjWs1lylmfBYK40PxB+ ZQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5kbt350-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 01:57:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43P1udih025265;
	Thu, 25 Apr 2024 01:57:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45fyh1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 01:57:12 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43P1vCuL009586;
	Thu, 25 Apr 2024 01:57:12 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xm45fyh1b-1;
	Thu, 25 Apr 2024 01:57:12 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Andrew Donnellan <ajd@linux.ibm.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, manoj@linux.ibm.com,
        ukrishn@linux.ibm.com, fbarrat@linux.ibm.com
Subject: Re: [PATCH 1/2] MAINTAINERS: Make cxlflash obsolete
Date: Wed, 24 Apr 2024 21:57:00 -0400
Message-ID: <171362345488.571343.5494585475689526516.b4-ty@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409031027.41587-1-ajd@linux.ibm.com>
References: <20240409031027.41587-1-ajd@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_01,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=866
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404250012
X-Proofpoint-GUID: 0-SKBKWbUced76nFdb_0kKODfeCpFBYy
X-Proofpoint-ORIG-GUID: 0-SKBKWbUced76nFdb_0kKODfeCpFBYy

On Tue, 09 Apr 2024 13:10:26 +1000, Andrew Donnellan wrote:

> The cxlflash driver is no longer actively maintained and we intend to
> remove it in a future kernel release. Change its status to obsolete.
> 
> While we're here, Matthew Ochs no longer works at IBM and is no longer in
> a position to access cxlflash hardware, so remove him from the maintainers
> list.
> 
> [...]

Applied to 6.10/scsi-queue, thanks!

[1/2] MAINTAINERS: Make cxlflash obsolete
      https://git.kernel.org/mkp/scsi/c/6d97e807c906

-- 
Martin K. Petersen	Oracle Linux Engineering


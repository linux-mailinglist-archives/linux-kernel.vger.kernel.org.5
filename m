Return-Path: <linux-kernel+bounces-67658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA979856EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AAB3B21779
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66F013B29F;
	Thu, 15 Feb 2024 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n/C5505B"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A63139564;
	Thu, 15 Feb 2024 20:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708029504; cv=none; b=ZEV4h+ZeRerPMYdJeK/T108Cxi1m9r6Fg9gdVrppornanpi+lY6cUQxdfRqtwmk8niUb0jluk5Afpj+WHdtK5VWNBJXOLE6aXAZ3/jYX74eiFAewBaXUTl1oQwnDfZbafRoxaGDJKeJWsHSmPw+2sQctxAcxJZAaw2Dq8TMWRxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708029504; c=relaxed/simple;
	bh=TJqHLaoB5WuF16FHxlNYu4yTxIuEaFNeoQXuLQa86dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+9i/CbyoQcsXaFE0xUwWx2GqSoNDWbzSdJVms57w6DgyJfNWyjN710FWR6yioeD94G7eI49KsSRY0hXqPAyf4p0RsxAeO0HO+U1/cJ8Ryj4R4zVjo5vVJKKaepGv7aVdvCe9oZ59nT1Z/4cIHdqJ64QpBoyNLzqjZGd06eVFO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n/C5505B; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FFT72o022398;
	Thu, 15 Feb 2024 20:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=AdJSSSYDfjEiQVXnvX4E2jByaztp26kZhSe7cEfyIjs=;
 b=n/C5505B6UtJ+hO/fMgfXd4cTQ6X8gkk2j/i+AIv27cmH6OSeb0zpnJjbqlSrl/22c5a
 noJ+2zRKbGrzSeqXo23gg7JOLhQEi7XKop+b/3GF17RrxQLXnabh5IV1LpIO8bkSG2Hk
 PkKu0oGTdC3uyfWcn5EtcTaHgEL44bZ/CU21VKXDyjh+zYRGq1N7yYFDOgWiJndRDpp5
 Bfdr0UNOsN4IRXEh3oztvZz8LmfLN++put+0GSnHVWrnW2Jt2AYR4ZG5E8z3SbTdZ4je
 C5fU9mIHvw+bMc5YyLRY2u35KqGXnqGXMyrGfqTasEdtx/BuvzBwrBacYWX30d9grJZ7 Qw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92j0k944-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 20:38:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FJn70b014943;
	Thu, 15 Feb 2024 20:38:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykatqp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 20:38:08 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FKc8Ub005623;
	Thu, 15 Feb 2024 20:38:08 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3w5ykatqnd-1;
	Thu, 15 Feb 2024 20:38:08 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] scsi: Make scsi_bus_type const
Date: Thu, 15 Feb 2024 15:38:00 -0500
Message-ID: <170802931700.3317223.18234042849656423364.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240212-bus_cleanup-scsi2-v2-1-65004493ff09@marliere.net>
References: <20240212-bus_cleanup-scsi2-v2-1-65004493ff09@marliere.net>
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
 definitions=2024-02-15_19,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150166
X-Proofpoint-GUID: qd9xrsRxZv-LTxwq-MYYwGlYEMhtMQuO
X-Proofpoint-ORIG-GUID: qd9xrsRxZv-LTxwq-MYYwGlYEMhtMQuO

On Mon, 12 Feb 2024 15:38:37 -0300, Ricardo B. Marliere wrote:

> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the scsi_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> 
> [...]

Applied to 6.9/scsi-queue, thanks!

[1/1] scsi: Make scsi_bus_type const
      https://git.kernel.org/mkp/scsi/c/a0bcad233fd6

-- 
Martin K. Petersen	Oracle Linux Engineering


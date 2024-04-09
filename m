Return-Path: <linux-kernel+bounces-136167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9489A89D0BA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EDC1F24FC7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB43657D4;
	Tue,  9 Apr 2024 03:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FmHBrK6y"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6A654BEF;
	Tue,  9 Apr 2024 03:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632159; cv=none; b=EIeZuq/Cy+YGEIMHU46iKK/chgssyNM9RgH+/r4mFPRKtyMVX3dUQI5SoJIB0sAlN4hYyH6zlyfRxx3IFW1SbWvD5vG1QbHach8ekzond2PXkMpSjVVfLQOdpScF/EoOAkGEB/vh01MiTt8NL6eaxk+8ETxLO2ooTWqNUkpwj/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632159; c=relaxed/simple;
	bh=a+EK1OWJ5teG/yZigtKT7bTAjSQ54ymxlVrJr9yAEQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBTJGIg10KAtNleHdqIlbDlJ3sKBzXEGWNmrakRu/cSNkhry4suT8YYkbfKbK4yjMs7fOH17iVLWlgR/zmJ/x1WF/RxD//44hbpdDsxcFPDYHyGeyaWTpHo6n9Nqf6TcIA7WxnInMRtmv+RTqRVoypbdAVGUH2c34DubHYkOLvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FmHBrK6y; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438LnM1B031197;
	Tue, 9 Apr 2024 03:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=ZdTwwpyLo3CjaHboWwbvGSNuxZ1HaoXY2uyoJfFsfkw=;
 b=FmHBrK6yoVQFEUYKn7nPSvc1XPEykOiZl5+XidMMYFZJFocD1ofWIUGSoCdeXBZE5D19
 kEGaP/xoIw48pXuTeBbblsK+mrgct0b4gaSJ4L2Slv96iGh8y0vnqTGmZCPsaD5ioO+J
 s3UgWJMo3d9ahfhcEmXXAwIuxoVrdNZbFE1aMjXxfgf7JLO3RtByequKnde8NVX/2i9s
 2GjunrouNe4Bem7QBIQQfoY9KNt6kbB2l1bFPP1VMBB2Rg/Xhm7PX4VmXc4NjF3alyGN
 YBduP2AvDMNSbA5kSZxvtf2KKfxdctWN4/fTYcnc6qfCYonSl/85e7SHsfRk2Gp8o55/ zw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaw0245hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 03:09:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4392Vutt017968;
	Tue, 9 Apr 2024 03:09:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuca6eq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 03:09:04 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 439392FD012913;
	Tue, 9 Apr 2024 03:09:03 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xavuca6e1-3;
	Tue, 09 Apr 2024 03:09:03 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>,
        =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] scsi: store owner from modules with scsi_register_driver()
Date: Mon,  8 Apr 2024 23:08:52 -0400
Message-ID: <171260277837.3109929.13971519530749630658.b4-ty@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328-b4-module-owner-scsi-v1-0-c86cb4f6e91c@linaro.org>
References: <20240328-b4-module-owner-scsi-v1-0-c86cb4f6e91c@linaro.org>
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
X-Proofpoint-ORIG-GUID: fB8utxnCdUq6f39VAdmQWm3fH_fjD_0r
X-Proofpoint-GUID: fB8utxnCdUq6f39VAdmQWm3fH_fjD_0r

On Thu, 28 Mar 2024 21:45:44 +0100, Krzysztof Kozlowski wrote:

> Merging
> =======
> All further patches depend on the first patch, therefore please ack
> and this should go via one tree.
> 
> Best regards,
> Krzysztof
> 
> [...]

Applied to 6.10/scsi-queue, thanks!

[1/6] scsi: store owner from modules with scsi_register_driver()
      https://git.kernel.org/mkp/scsi/c/65a09ba26936
[2/6] scsi: sd: drop driver owner initialization
      https://git.kernel.org/mkp/scsi/c/aef9e4872684
[3/6] scsi: ses: drop driver owner initialization
      https://git.kernel.org/mkp/scsi/c/8d326b243c11
[4/6] scsi: sr: drop driver owner initialization
      https://git.kernel.org/mkp/scsi/c/dc916f7f0f5e
[5/6] scsi: st: drop driver owner initialization
      https://git.kernel.org/mkp/scsi/c/2ee2d99fe449
[6/6] ufs: core: drop driver owner initialization
      https://git.kernel.org/mkp/scsi/c/9282899e1e7e

-- 
Martin K. Petersen	Oracle Linux Engineering


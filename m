Return-Path: <linux-kernel+bounces-43829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE9584194C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C64282ECC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867B75466D;
	Tue, 30 Jan 2024 02:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lHowqzQG"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7033654656;
	Tue, 30 Jan 2024 02:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581680; cv=none; b=NIVst29FQR7bxK0hpJaPDRaFlmFkHbW7TVUy16RoNyOOA1tN0JAt4kZcugzhdCScTDvfoHAmiCH9bShYKdGral9HSDewVdhCdVPQ1HMWLM/6c4iQH1/cBbqJB7cgI3/gbnxGUy691aqsdwwusvCbn7bnufoVmgYmWv9iF2fSjxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581680; c=relaxed/simple;
	bh=DINAL8D7iPrhf77F0Cmtsw/EUK0sFUDLU+r7vWE1zis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ssl9F7T5lTVB84MSAeVedlOgPlmzN8hhsopbb/MtGxzEwSTWCXlYUH5YLEzP5I4DaBTFI1ilWzcTQRhHyAnDr7d9CxgytG/GzSIXyjY5pRaYHtcLI7We0Lvqn+A1sbxKWgTpE+oy07cYV8cnyeyKemLoYSm7f9UxhaVmKLbdKJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lHowqzQG; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJjFFQ031339;
	Tue, 30 Jan 2024 02:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=WBMFsOTdFwH4IbQ/ifau3T507/gj4PdaNNxG6rrK4VA=;
 b=lHowqzQGYuILeJJghn/9zrHYQeLslsBeuFZUc8x2eNb34XGMhmrPcMDbCgX9tmUpSI7f
 yWLaSlL+oVZy0OK8uONjhjDWTSk42TXn79TR34YpNoOw6qjSR5b0b93X5bmuKzkB4RsG
 WNDtLn9IQU4PO7LwNNnpWoUlsYazVQa4z9APlrbpq77cEmMHJ9+60u8QTFXkRvCMIWfX
 I2OstDmdHnydLIwyUTkb8v/I49VM/SpyFi3t5atRCpc0fhjVg4JUAmSERG+Pwr7KTfIL
 zOl6mB7QtuyYi0xpPGWpRx8FmlJEt9i3TAlPdWd/l9X/iSV+5IO9x4kJ2gt3drhhlMhg nw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrrcdjrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 02:27:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40U0P3QJ014462;
	Tue, 30 Jan 2024 02:27:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr96g512-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 02:27:32 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40U2RPxm040916;
	Tue, 30 Jan 2024 02:27:31 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vvr96g4y7-5;
	Tue, 30 Jan 2024 02:27:31 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, peter.wang@mediatek.com, chu.stanley@gmail.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        stanley.chu@mediatek.com, quic_cang@quicinc.com, mani@kernel.org,
        quic_asutoshd@quicinc.com, powen.kao@mediatek.com,
        quic_nguyenb@quicinc.com, yang.lee@linux.alibaba.com,
        athierry@redhat.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Chanwoo Lee <cw9316.lee@samsung.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, grant.jung@samsung.com,
        jt77.jang@samsung.com, dh0421.hwang@samsung.com, sh043.lee@samsung.com
Subject: Re: [PATCH v3] ufs: mcq: Add definition for REG_UFS_MEM_CFG register
Date: Mon, 29 Jan 2024 21:27:01 -0500
Message-ID: <170657812670.784857.12424520117392551144.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240102014222.23351-1-cw9316.lee@samsung.com>
References: <CGME20240102014248epcas1p4d49dcf2cd3f020bed88eebaeba648789@epcas1p4.samsung.com> <20240102014222.23351-1-cw9316.lee@samsung.com>
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
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=833 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300015
X-Proofpoint-ORIG-GUID: KjxR28JYNzC9rJxeETTWUejeOOd3-6XD
X-Proofpoint-GUID: KjxR28JYNzC9rJxeETTWUejeOOd3-6XD

On Tue, 02 Jan 2024 10:42:22 +0900, Chanwoo Lee wrote:

> Instead of hardcoding the register field, add the proper definition. While
> at it, let's also use ufshcd_rmwl() to simplify updating this register.
> 
> 

Applied to 6.9/scsi-queue, thanks!

[1/1] ufs: mcq: Add definition for REG_UFS_MEM_CFG register
      https://git.kernel.org/mkp/scsi/c/ab3e6c4e0ea1

-- 
Martin K. Petersen	Oracle Linux Engineering


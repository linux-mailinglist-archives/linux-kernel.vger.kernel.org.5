Return-Path: <linux-kernel+bounces-43825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934AB841941
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7AE289D29
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FC53839E;
	Tue, 30 Jan 2024 02:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lwldu3lT"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89785364C0;
	Tue, 30 Jan 2024 02:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581663; cv=none; b=mqiDHJLH/SCCXa3rke9hLa8b1oy6XBSJAOqEPk+/xxMaIcojIzJrppUBfUzVEpllfH2MbrmWiJO0qKHeib9jLCpCuZNmvxs2jNN2Bmb/LpZslbnwEhXBFl3uOlr6nAsXfhA+fOmPVTz9zuYfLhqzloHXzawnmGSmRKRARDJx+BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581663; c=relaxed/simple;
	bh=VkWeA5Zv+PkjgN4C/2LECttFMTxuaOer65L1W//6lGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8ePbFlOgc9Wq4C2A+Hu8EVxap0n8sN3Huo2fB9wCwOLC3gxuSrId+TTcqfjmGPyn9+GpC16HK53ZYhkaA08B1iUM2oZ0QXnI27xeQr04FbEmGED1fshhgssZividCJVsyJKWl0Dt3zgrpQBmB+LP8LaoxID9eqyx8StG4yxyNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lwldu3lT; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJiSsZ007793;
	Tue, 30 Jan 2024 02:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=kYbbWZG+9wMGo15VfEkL8fSVRk71xnQytKV1MBvoNAk=;
 b=lwldu3lT2slhjjO6fokdH2jY1I1Duk//sy9xDe+nkbs77ljNaohdQZ2lMy3ldAK3Ai0I
 wn842lp7X70kwEn9yebu7zXKTpryr9bXG6efHFNTXJQuQe3Ix8EO8xIqzwrNUO3yV8z6
 Vg3G26sLX41zyvD/OXzRUuiZyAig7Vy7GcTc628EzBgMhmaOj0eH5xIH31JnbWTYVIAX
 9JnXWZlC54SIezaeX9uHMeEbK/W0YH+w5PZKyZcgaq/7loUgzcBD+NXAhaLgBHJGhw0/
 K6k3tkGEleMVis6fw5YcNBXrC2WStwARGnTuR4z4aE+3c5vPOFMeB8AHl+Tb46BMMuyo 7g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvtcuwft7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 02:27:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40U12IAV014564;
	Tue, 30 Jan 2024 02:27:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr96g51m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 02:27:34 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40U2RPxq040916;
	Tue, 30 Jan 2024 02:27:34 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vvr96g4y7-7;
	Tue, 30 Jan 2024 02:27:34 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: satishkh@cisco.com, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, sebaddel@cisco.com,
        kartilak@cisco.com, jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] scsi: fnic: clean up some inconsistent indenting
Date: Mon, 29 Jan 2024 21:27:03 -0500
Message-ID: <170657812682.784857.11233505329485632869.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240118020128.24432-1-jiapeng.chong@linux.alibaba.com>
References: <20240118020128.24432-1-jiapeng.chong@linux.alibaba.com>
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
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=602 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300015
X-Proofpoint-ORIG-GUID: ZjykiNFFLBI_AQmrbRdnegqanQy-V45V
X-Proofpoint-GUID: ZjykiNFFLBI_AQmrbRdnegqanQy-V45V

On Thu, 18 Jan 2024 10:01:28 +0800, Jiapeng Chong wrote:

> No functional modification involved.
> 
> drivers/scsi/fnic/fnic_scsi.c:1964 fnic_abort_cmd() warn: inconsistent indenting.
> 
> 

Applied to 6.9/scsi-queue, thanks!

[1/1] scsi: fnic: clean up some inconsistent indenting
      https://git.kernel.org/mkp/scsi/c/f1aa6437733a

-- 
Martin K. Petersen	Oracle Linux Engineering


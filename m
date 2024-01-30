Return-Path: <linux-kernel+bounces-43823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E083684193C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84456B26ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8254037715;
	Tue, 30 Jan 2024 02:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ArsF7OaA"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291ED364C6;
	Tue, 30 Jan 2024 02:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581654; cv=none; b=aQB643JHEU4ztgSV9ZPaEO5/bMf2rAJCFL9iaKtUkrc8Cz3PE+qcKFQBTWZjmDO0f6jcc8utEL7EfBWLxGfWaeS0iyCHIyhvZsvXP4H02viKNZ7GHPldL7DvhlCMRmlFZ4A7Rszlr7xLX/ts6T2JzX4OuZ//T9ePJE4yRt1LMcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581654; c=relaxed/simple;
	bh=JcosPY/MUcmuEKAv8uCYUQulu9wUKKVPAVVT2p9eLHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0RKFLEtjxn8iwy1lIQCrN04tpoZvHjDdXyI1uXiqJMRECR4hIra5P7RI4oNajglB4WvghmOILXZi4dQm+5UuFW2BYOwd0S9Fdn+xv20wwL7jX0nffl2QdX0HRhGUIhEr46PNqdt0Bmx2SNl03g6bBuf6TlIq1NatkxQ1vftsIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ArsF7OaA; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJiSDN007797;
	Tue, 30 Jan 2024 02:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=Eoh+JshKWgOgkcuwwhLvB39S4d8nsOejXj2leZ5f3BQ=;
 b=ArsF7OaA3Ylo8U6xG7TyPyKYieEE3LsE5y+Pxv/KrMHLTOeuw/oL6myKncHwmfFpk84f
 dMJ85uplfkic62wzYFh0lAjfmuicludf5qGqY4zULAcukHBvXG+VmX7v4+z01GqLVf/T
 hqXTVw1V/+0mivqLlKgHwWAyX7ymzfLKy1dvzGTLEb4uFS+7U1ATlIOPjiLkYfGGuSD/
 cwJFFYAJGRNgnUwf1ZLPNgplKQGczMIufXhak77kH4c9F20n8SlSEcxu9blODZD35JAS
 S5mscV/BJb83cKpJqfvAYEj3jpfYxAsLautd8+ICIyYFzXcmtQsQHGNOCOBK/pbedb/w Qg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvtcuwft2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 02:27:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40U2A4vB014552;
	Tue, 30 Jan 2024 02:27:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr96g50c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 02:27:29 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40U2RPxk040916;
	Tue, 30 Jan 2024 02:27:29 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vvr96g4y7-4;
	Tue, 30 Jan 2024 02:27:28 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] scsi: message: fusion: remove redundant pointer hd
Date: Mon, 29 Jan 2024 21:27:00 -0500
Message-ID: <170657812676.784857.7561703610497490336.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240118122039.2541425-1-colin.i.king@gmail.com>
References: <20240118122039.2541425-1-colin.i.king@gmail.com>
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
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=897 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300015
X-Proofpoint-ORIG-GUID: l8tkXpHexA3b_hau8E-YqD4e6sixnjqQ
X-Proofpoint-GUID: l8tkXpHexA3b_hau8E-YqD4e6sixnjqQ

On Thu, 18 Jan 2024 12:20:39 +0000, Colin Ian King wrote:

> The pointer hd is being assigned a value that is not being
> read later. The variable is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> warning: Although the value stored to 'hd' is used in the enclosing
> expression, the value is never actually read from 'hd'
> [deadcode.DeadStores]
> 
> [...]

Applied to 6.9/scsi-queue, thanks!

[1/1] scsi: message: fusion: remove redundant pointer hd
      https://git.kernel.org/mkp/scsi/c/be7fc734b658

-- 
Martin K. Petersen	Oracle Linux Engineering


Return-Path: <linux-kernel+bounces-62877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C38F852732
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256A71C257A6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697058F5F;
	Tue, 13 Feb 2024 01:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CMPWu+/o"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB8279E1;
	Tue, 13 Feb 2024 01:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707789481; cv=none; b=n6Dpfn+OnXKeFcJaV7NQJH9QjRiKKQ7DZlzS9gWLGp/YB7lwxHdH+e4Pt1UHq/sDW4rI8PHQteCX8Uz3jIp3qmbbkfwfXQxaOgEsYwlu4lOVtKFT0eeZu0P3EoSBDgjvH9mTz+LvtOSm2aXSd3Ty9hlY/f+Wmj6iMvRHmOrjh8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707789481; c=relaxed/simple;
	bh=AK2dQ9oyoMdcMMHXetOHC+B390rOsuyzXMSQCJ65Py8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0v7Tvxv8MnSbgL69mL7NH6Tb/foVjin9Mm56mpClYuZUYZb+ugjrWnAckSAZ1Ak6yEbbnM9IL2cAa3C4WqpwmOK5DjHcZ409fRCLZzoNLfBlfXJqEMvKuzgafuMMeC2heXB53WqEHlpss1W1Z9w9MzR6MEyY1geIpFRn8UkMSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CMPWu+/o; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D1iEb2003075;
	Tue, 13 Feb 2024 01:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=JMVoOtM1py7aSa6kLQ7/92X6PzbGGiOnL+aPH9hefLo=;
 b=CMPWu+/oWdlTnhKHzE8wxZQs06FiT6QMOH4JjevQJt4W/uB9wn72I+aKyLnIvkh9SVJx
 egsrf9LrFFY2kEoyoVeEuK6KBiL1iV7TrG4YDsY6i9SlZ4wJ2+FaVNNwRYYahQS9s6kc
 xeqAmLBLFjGa2IA0RM0aCKO5bD1oC8APP+r/yKwHl9l8199ALwwFJqZXDraYX0kQ0Iwx
 dVNU56JxcYs1Ui9c3GOWtQIwHfRLoclmG5xC4Sp2na49TZxUbo9oGzt00iEEEVOASF5u
 Pa0Se9CIYFXaFTpvfB62+UrJmptxtNS3fYdhYQ7HXwdp9bK41A5WtvIjAtMkxv0jnVZ7 Bw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7xeq01qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 01:57:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D0AENV024679;
	Tue, 13 Feb 2024 01:57:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykcw3an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 01:57:50 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41D1vm1l022232;
	Tue, 13 Feb 2024 01:57:49 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3w5ykcw3a9-3;
	Tue, 13 Feb 2024 01:57:49 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] scsi: tcm_loop: make tcm_loop_lld_bus const
Date: Mon, 12 Feb 2024 20:57:43 -0500
Message-ID: <170778686841.2103627.348317624154335790.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240204-bus_cleanup-target-v1-1-96106936c4ab@marliere.net>
References: <20240204-bus_cleanup-target-v1-1-96106936c4ab@marliere.net>
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
 definitions=2024-02-12_20,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=758 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130011
X-Proofpoint-GUID: tllfBj0IfAbsXcEZ2-TKmqh6PwkGRswe
X-Proofpoint-ORIG-GUID: tllfBj0IfAbsXcEZ2-TKmqh6PwkGRswe

On Sun, 04 Feb 2024 17:48:26 -0300, Ricardo B. Marliere wrote:

> Now that the driver core can properly handle constant struct bus_type,
> move the tcm_loop_lld_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> 

Applied to 6.9/scsi-queue, thanks!

[1/1] scsi: tcm_loop: make tcm_loop_lld_bus const
      https://git.kernel.org/mkp/scsi/c/4ad946536537

-- 
Martin K. Petersen	Oracle Linux Engineering


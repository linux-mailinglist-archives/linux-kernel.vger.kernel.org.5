Return-Path: <linux-kernel+bounces-136164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64E089D0B3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4770D1F24EEA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56433548F3;
	Tue,  9 Apr 2024 03:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TkbnAsk9"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0342A54756;
	Tue,  9 Apr 2024 03:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632154; cv=none; b=WWYau0TurgOl2bADVtC1lojKWMOCV3P1edQZq/6igK6Fy2fZW+PNDUHLtcApP2PcWT0xfgWIY5R9MF5wZsVGkeROymHd7udhjkQvoZuTeUyTJ7WnQYPG0vLbkQOLwsACSKFcXjmbx5Je1BdmcxtQKeIOshK0VzO4kqzcvbKGL+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632154; c=relaxed/simple;
	bh=7nY365Z+RmglEv3tFyEGtSqZkL9laEZIeTmbfwJYsos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVuXbmxSPdPx2hI+4s1NWowwYKOqq2su/GC4rxU1N7ah/9PypxHkh/nZnJpYQzv3E1W5V3r5dUFLcS4qbxN4pbiM7Wt7QvpWkw9/bof8QGvjpubo52sdGYKkybq+EwOP4O2ZYTRF2BSPzUqMccrXVNQ2+0A17SvWmx5OJ45poOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TkbnAsk9; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438LmxtT018644;
	Tue, 9 Apr 2024 03:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=LkdkWPOrLJULKUCy5VwV7AQz6ge43RgfEmaxGhPM1o8=;
 b=TkbnAsk9uh+MkN/b4h2WYs22zJtv9jAmPJdvalLtb/YdAEfb4pxyOIm7HKnwaR1PFUL1
 Gaz7dNK6jCrwRfWKAQkQ5oEWygiA5dfVhz5JtYnh77F8wiTbskE223uKKMGSjmayHwS/
 A3ZoQjcEy3ouYoSgzbKXnGSs7cl3SqG4T7iW1jyVse5ubb6OJ65pMzhCH0x9Jg42FA2m
 HhH+ulFJVvq2FYWCRboMNr6qh4nl/DnUFHn/PwXysx931GBU/YyRx0rRuBnQIfBrz44P
 IMXDNo1+G1OuUEDWgDI3DUQ7Bd2iezg9+pjUPlERsOWnLeyg4quzCbBsrn8+CyFpPViR vQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaw6445xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 03:09:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4392crZ7020069;
	Tue, 9 Apr 2024 03:09:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuca6ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 03:09:04 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 439392FF012913;
	Tue, 9 Apr 2024 03:09:03 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xavuca6e1-4;
	Tue, 09 Apr 2024 03:09:03 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/2] scsi: csiostor: drop driver owner assignment
Date: Mon,  8 Apr 2024 23:08:53 -0400
Message-ID: <171260277835.3109929.15425179940252551620.b4-ty@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327174921.519830-1-krzysztof.kozlowski@linaro.org>
References: <20240327174921.519830-1-krzysztof.kozlowski@linaro.org>
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
X-Proofpoint-GUID: HVLI7bL7_Q9TsrEDtu258H3-kNpgzqN7
X-Proofpoint-ORIG-GUID: HVLI7bL7_Q9TsrEDtu258H3-kNpgzqN7

On Wed, 27 Mar 2024 18:49:20 +0100, Krzysztof Kozlowski wrote:

> PCI core in pci_register_driver() already sets the .owner, so driver
> does not need to.
> 
> 

Applied to 6.10/scsi-queue, thanks!

[1/2] scsi: csiostor: drop driver owner assignment
      https://git.kernel.org/mkp/scsi/c/ca0e1b9afbc9
[2/2] scsi: qla2xxx: drop driver owner assignment
      https://git.kernel.org/mkp/scsi/c/4e64bbba5352

-- 
Martin K. Petersen	Oracle Linux Engineering


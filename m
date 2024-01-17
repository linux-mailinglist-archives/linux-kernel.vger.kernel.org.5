Return-Path: <linux-kernel+bounces-29402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A3C830DC7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D0A1F22A13
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7A724B39;
	Wed, 17 Jan 2024 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nYUCsjYh"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F5B24B57;
	Wed, 17 Jan 2024 20:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705522229; cv=none; b=bvPEGHynReJGKjm7bSZG7IZpkFFap6MQn3/3bmn4zhNps0X/s/K7BvEPIbO6BAlOJlfhnGTqueLIFh5AgT5Yx84qQfFlzoikytursmVTreqUjjBuZFebAIhGAJdWpv4OsqgmmZz15FKQOeA98onvqyxu3d8cImzEKC2DyJdxRxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705522229; c=relaxed/simple;
	bh=4vwSLLR2Xw4dWO0MOKREjo5VSSihDzuRLLAGmh/SXv0=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID; b=Wkoge6I1QxxMx/cxf0hf07sYe2J89rLzJnnD5TSUoJ3NJ0RIrfbBdzz7SWyaiJTHBrMdvBxeFnC70Iar3iEWCx1RNDx76PDxvTKoHSR/h2zS318O2mu8/U3y9PagUdrc+airedVn8984r/TwkWnKHD+kVkp8Y3rS84NsJ5bjYVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nYUCsjYh; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HJcrw0023582;
	Wed, 17 Jan 2024 20:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=89HxgIwBEYJaHnsk5AEcjOC5NVX2QZpUegFxl8d9R34=;
 b=nYUCsjYhAJriZebos+UlDsTkfgS/cCX77IRqGYXWKIZZIEmIEbFGuIeA41GQHwY0bhZQ
 eauiDjqZReWKWEwdkzuAHSofQHsF9jKN2dRUWhDpfOLlj44ryYbCSpi4G1Ek/ujrTMn6
 ePT3sQngXMXgwnzpe3dy+VeH8flaeoY6vTjk6V+vH8TMGmk/zdAcCge2G6ifrVthEorB
 oqunjQq4rbl0+2W42dP32VoT9K34iGOj7IujVCwY4PWQ8Dg2D7TS1az0NChxfi1HHAoA
 8/82C4b7oixgxwIuPSnhSWZce33QDa8lnxl7X28PUs2VvNf+93UlaCo4LtriPWPhHRaV XA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkqce0gk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 20:10:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40HJn7fP019950;
	Wed, 17 Jan 2024 20:10:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgyb1c10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 20:10:19 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40HKAHCD030718;
	Wed, 17 Jan 2024 20:10:19 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vkgyb1bw6-2;
	Wed, 17 Jan 2024 20:10:19 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Justin Stitt <justinstitt@google.com>,
        Kees Cook <keescook@chromium.org>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
Subject: Re: [PATCH] scsi: fcoe: Fix unsigned comparison with zero in store_ctlr_mode()
Date: Wed, 17 Jan 2024 15:10:06 -0500
Message-ID: <170552035090.3348001.8757972022614438996.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240102085245.600570-1-harshit.m.mogalapalli@oracle.com>
References: <20240102085245.600570-1-harshit.m.mogalapalli@oracle.com>
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
 spamscore=0 mlxlogscore=708 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401170147
X-Proofpoint-GUID: ERi6vrtsMoa9XNku4zjdaua5uLmf24C2
X-Proofpoint-ORIG-GUID: ERi6vrtsMoa9XNku4zjdaua5uLmf24C2

On Tue, 02 Jan 2024 00:52:45 -0800, Harshit Mogalapalli wrote:

> ctlr->mode is of unsigned type, it is never less than zero.
> 
> Fix this by using an extra varibale called 'res', to store return value
> from sysfs_match_string() and assign that to ctlr->mode on the success
> path.
> 
> 
> [...]

Applied to 6.8/scsi-queue, thanks!

[1/1] scsi: fcoe: Fix unsigned comparison with zero in store_ctlr_mode()
      https://git.kernel.org/mkp/scsi/c/567a1e852e87

-- 
Martin K. Petersen	Oracle Linux Engineering


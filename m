Return-Path: <linux-kernel+bounces-157924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4888B18A2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E922B2682D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE8F1CD06;
	Thu, 25 Apr 2024 01:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lWCMwpou"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8590C134AB;
	Thu, 25 Apr 2024 01:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714010249; cv=none; b=f7JNgzurOEWgzHS2CuopIup/EU9c0OSf0P1tkfsyp21rVU3yMtn7/NqwJpYGzvjAGjfa+kO2JfFlFSSoHOkdv+MJZZb0ddO5mjbPAq1FGxRkQxYHPBszvvEdUhLE0U+/biGIkHlRMq2kG5Dqe6/0/y5Fvze73U5tgiDoHWDsS44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714010249; c=relaxed/simple;
	bh=75KPJ4YOgv2AHevcYRwuw2uuTyEI8DyAgyj1qHuS2PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bd2ySKA4sYuAu4XXgxwl3njKdi1PyjUS1b19Qwch4p+D/KbgNzsxN0QdUEQv6ADPnBr1lsyPh7BDPqPQbhY0x5Vo0kIJqUF6lm+6sC/s6ixXeeVxofjp3anFTG3QK0z0zmphpqC00jYml8jO3lDdBH1qtB30HNW19rpiCXrBK60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lWCMwpou; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43P0i6q4015238;
	Thu, 25 Apr 2024 01:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=kjT+SpPJzKl8w7kSFiIcNkWzRwIJPDHUfy/FQiYyYaQ=;
 b=lWCMwpouBaIo7qm9kBHRsIC4inRFNQ4OaetEyno5mf6OLNMFuZSCJVXsDnKJVRYanU93
 41FjF46goEV0Qyjb0UcomDfGfhTYfaGIhKXWF8spEnIfdWWITu9gD7HzWwC0Ahngx254
 rWsABi0TD6MHyyXUEXhKAlGLI7JjvV8LINIxSnF9jg7aEY/1QHxABu9dxyTYhPYBa6os
 pJ2XY6sS9xf+O+uq97PLy0bs1ldCC4YK+YwTx1+PeyfuYGmfDdGdF7LfaDPz16nZygr/
 Mw8ZdO+MSz9SO0IPSliSVPeg9hBK83Fso4fdHBKqetsSxFlfze6dUVMizG9nahRPfUZt IQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm44f1d6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 01:57:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43P0McEA025366;
	Thu, 25 Apr 2024 01:57:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45fyh2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 01:57:14 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43P1vCuR009586;
	Thu, 25 Apr 2024 01:57:14 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xm45fyh1b-4;
	Thu, 25 Apr 2024 01:57:14 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Peter Wang <peter.wang@mediatek.com>, Stanley Jhu <chu.stanley@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        linux-scsi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Will McVicker <willmcvicker@google.com>
Subject: Re: [PATCH] scsi: ufs: mediatek: fix module autoloading
Date: Wed, 24 Apr 2024 21:57:03 -0400
Message-ID: <171362345486.571343.15378016948257284142.b4-ty@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409203954.80484-1-krzysztof.kozlowski@linaro.org>
References: <20240409203954.80484-1-krzysztof.kozlowski@linaro.org>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404250012
X-Proofpoint-ORIG-GUID: 5kL1fAXRt9q0alSsinLmOfxzmG3P03OT
X-Proofpoint-GUID: 5kL1fAXRt9q0alSsinLmOfxzmG3P03OT

On Tue, 09 Apr 2024 22:39:54 +0200, Krzysztof Kozlowski wrote:

> Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
> based on the alias from of_device_id table.
> 
> 

Applied to 6.10/scsi-queue, thanks!

[1/1] scsi: ufs: mediatek: fix module autoloading
      https://git.kernel.org/mkp/scsi/c/a6584df2fd51

-- 
Martin K. Petersen	Oracle Linux Engineering


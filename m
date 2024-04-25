Return-Path: <linux-kernel+bounces-157923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D141D8B18A0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F57D1C2112D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3861803D;
	Thu, 25 Apr 2024 01:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L/c3ctz3"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4A71173F;
	Thu, 25 Apr 2024 01:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714010248; cv=none; b=KbTRfp7nfLkP+RY2SXH3lzEVHOf8DMCSUYEhL5k9V9RokCaNEwIBTxc5dROcgYZxGk3vzMa8E857YWlRyn54BrBslxD3nH5zem1BJQYuiHKFpWp+Xy9APJAl+TPNZnjzrupUK37UURMkVfUcoinRUsCrMaYw69OoTNNezGGJzYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714010248; c=relaxed/simple;
	bh=/GB48CjrcrQCL8M5LlkM1nJzW/MpeTEDdniq8BdBgbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWp4k/OjdRrYTMGQzfUfBYoKe3teTaQYj6UtcjgIdUbQcFWekqXXaniLDE/N+1RdcCM2Bv2sLbH3onf2FtFHWHhbV+jt7jUYI9G28FrGfnCse0OmA03HBVZG+fgmuMPP00G/lT+SQ0vLXDBMp/cUsOLAu6VWtJtZqXvcUsFSOQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L/c3ctz3; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43P0jUw6032460;
	Thu, 25 Apr 2024 01:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=93pgeyhaAFraO8DY5WjEs/xj9MduHGbB28caTZ1Yq8o=;
 b=L/c3ctz3wCdbmGE4o6wElcr3+7MC4vfzMXe1r+ATa0AeY0rHUK8YuHLj/7JYBkiBUXxy
 phwk5ZyeW3yY37Ea/m+ulslJNe7hmUJYt3rEiGuidXj+zo4k+/6MWwfmjYIh6a2JK4Rq
 unDdRza1Jzl/B1sU9d90ILv3f4zuWnanrDR9dOgWpRJhGCSAAJsx5xOLMOzxGuQRcO+F
 n+AT1m1w5/uzUKA9888/HqSdGt7gIpufaiL45+p5tqdzRSsglZPgurdFdvdrsSBtHthp
 wqvt++AQ6maJwIn5W2A1tCLuzqivTbE/wK8oS7+R0xIRHHDuajOOPmtN/wy3j6/nCy2I qw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5kbt352-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 01:57:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43P1oZDc025314;
	Thu, 25 Apr 2024 01:57:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45fyh2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 01:57:15 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43P1vCuT009586;
	Thu, 25 Apr 2024 01:57:14 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xm45fyh1b-5;
	Thu, 25 Apr 2024 01:57:14 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Will McVicker <willmcvicker@google.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Peter Griffin <peter.griffin@linaro.org>, andre.draszik@linaro.org,
        tudor.ambarus@linaro.org, kernel-team@android.com,
        linux-scsi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] scsi: ufs: exynos: Support module autoloading
Date: Wed, 24 Apr 2024 21:57:04 -0400
Message-ID: <171362345483.571343.13648416767019194881.b4-ty@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409202203.1308163-1-willmcvicker@google.com>
References: <20240409202203.1308163-1-willmcvicker@google.com>
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
X-Proofpoint-GUID: 0EOElnENofiHRAXb33XiRdYqPBv5m3xI
X-Proofpoint-ORIG-GUID: 0EOElnENofiHRAXb33XiRdYqPBv5m3xI

On Tue, 09 Apr 2024 13:22:02 -0700, Will McVicker wrote:

> Export the module alias information using the MODULE_DEVICE_TABLE()
> macro in order to support auto-loading this module for devices that
> support it.
> 
> $ modinfo -F alias out/linux/drivers/ufs/host/ufs-exynos.ko
> of:N*T*Ctesla,fsd-ufsC*
> of:N*T*Ctesla,fsd-ufs
> of:N*T*Csamsung,exynosautov9-ufs-vhC*
> of:N*T*Csamsung,exynosautov9-ufs-vh
> of:N*T*Csamsung,exynosautov9-ufsC*
> of:N*T*Csamsung,exynosautov9-ufs
> of:N*T*Csamsung,exynos7-ufsC*
> of:N*T*Csamsung,exynos7-ufs
> 
> [...]

Applied to 6.10/scsi-queue, thanks!

[1/1] scsi: ufs: exynos: Support module autoloading
      https://git.kernel.org/mkp/scsi/c/2810702f2cbc

-- 
Martin K. Petersen	Oracle Linux Engineering


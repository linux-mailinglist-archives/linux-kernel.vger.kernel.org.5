Return-Path: <linux-kernel+bounces-98359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B99877920
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533B42817CA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967603D964;
	Sun, 10 Mar 2024 23:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MiDCYJTV"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FDA3CF79;
	Sun, 10 Mar 2024 23:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710111885; cv=none; b=AjW9Vpn0lmTfPk9UaafPV/yOGznX9AADOrAtmay6MQcOlKVPmeUU2SW86F3uwJmzTLz/OtIsJXfuiN87RbXBGZKZO4bpZ1l9ryKOwZvodBW8mLh3UifaHWzdXLih46rBnilQf46GWUDch7R4kUc0/4N4smPLNXj/7BICbh/lZ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710111885; c=relaxed/simple;
	bh=IqKlVXdvRCGyV3P+9ATcptDQsKk0x0UuV2i/DuWwdnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRMjDLjG/sye6AL89Gx71Rp5GMTAis3b+S4fLV/TLmPG1bAqYI3Nm5ZWMMESg1YA0jqw3I7Z/fMCwyolqys3OuxwTdc/GKMVMq/mgO/XtO704RLruAw5Lb5dlmhgQ/BNSRZ7ZT9d2PBU5SwVN9BAr78MbY6176R5lLSGW8nhtDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MiDCYJTV; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42ALnUR2024778;
	Sun, 10 Mar 2024 23:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=6fPMDNozrHsLnGVjWcs5LMYU5HVRwihp+ZkxbBA2AMA=;
 b=MiDCYJTVRLe9Z5YNRyPgu0it8On5PQE23w0p4R83wMB2ERxfbAL29P1HsDxJCfFl4M7t
 GIvP14W4KBezFjrG67flGw27wXKWUGPVkbTD4Gw/wrWYKqCDtXd9Kw4L+0Cw2peynCNV
 D+7Ys3mgqK3x4GGbE5Zg4ULGELhaKnRRajcx2grudyhvrhX7NAQNrneLm6QpTGhgypLV
 l3sa1Y3+CUEgsSPa4MLa7sB36JSXf7LDj17dyC4cXIlRLTMJuoeBMuwi7TAK1Vt23VKg
 1C2r6avrDiWO0O2ujcUat9I2eRkrgfy2BggB6XGGBiwuAFXCqWbkrU3MN5X1A0RiD0uS 1w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrftd9svu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 23:04:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42AMsVK5005032;
	Sun, 10 Mar 2024 23:04:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre750nej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 23:04:31 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42AN4TSI006839;
	Sun, 10 Mar 2024 23:04:31 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wre750ndq-5;
	Sun, 10 Mar 2024 23:04:31 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, simone.p.weiss@posteo.com
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: bfa: Remove further unnecessary struct declaration
Date: Sun, 10 Mar 2024 19:04:21 -0400
Message-ID: <171010474745.3838281.8532324205422385487.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240217191409.6260-1-simone.p.weiss@posteo.com>
References: <20240217191409.6260-1-simone.p.weiss@posteo.com>
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
 definitions=2024-03-10_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403100187
X-Proofpoint-ORIG-GUID: G1AGs45jbMjuU4jbh_LkqgLMHQBcX1kF
X-Proofpoint-GUID: G1AGs45jbMjuU4jbh_LkqgLMHQBcX1kF

On Sat, 17 Feb 2024 19:14:09 +0000, simone.p.weiss@posteo.com wrote:

> With Commit c3b0d087763f9833
> ("scsi: bfa: Remove unnecessary struct declarations") duplicated struct
> declarions for struct bfa_fcs_s and struct bfa_fcs_fabric_s where already
> removed.
> 
> There are further duplications:
> 
> [...]

Applied to 6.9/scsi-queue, thanks!

[1/1] scsi: bfa: Remove further unnecessary struct declaration
      https://git.kernel.org/mkp/scsi/c/c121b588a5e4

-- 
Martin K. Petersen	Oracle Linux Engineering


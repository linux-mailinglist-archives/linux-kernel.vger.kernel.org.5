Return-Path: <linux-kernel+bounces-43830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB4484194E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D64CBB27C95
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A09A55E5C;
	Tue, 30 Jan 2024 02:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CCIe7+3k"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCBF36121;
	Tue, 30 Jan 2024 02:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581682; cv=none; b=oPA6JUCKp9e5sw9KLHjF74cCQsyhPOF9za3YyCU8YErlA67v44kpx0oe9IuPg+4RtEi+OnIo1iGCQ7TEZbfzQSICiqzjNQGgGn9js34bq5by30KkDbRMFko9bi2vyYX+YQtLxlG1+LTpvlXvuWs00LMja0sHOMZVWD4uTBHHD/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581682; c=relaxed/simple;
	bh=mZDRmgKic9sLa85bM8YbcsyfBKuxV7YiVfj3BwMuEqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ock80YHXuC5z3kryFWiwkNfPOFBdB25CFqN5pal+B7PQSLJSD/t+57WEq+3GldOS6lnwkVoFDN6WGUqjr2KdxmesRyyyh8tJ1qUNUNsOGSSUmNT9DnGa8WazAVHbHoM0QbUhdEpYRQ+8aXm7qlj2yc/fdIfWx1YZJGe/WC2Vv/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CCIe7+3k; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJi1lT016789;
	Tue, 30 Jan 2024 02:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=PSjQwz/LMG7SM4NIPUeOK917k8N7lEdxTH1OYuR665g=;
 b=CCIe7+3kbfSsRluYQWioOta2zNTIjzOK2dJuj0sGEVg41oO0sD+xjmreMT15x4VVThyL
 y0jYYO+lZOZc6uU9JASedKsa4qGMI/angRcvhV82aBa6ULXUXcj0h890H5iU+rpJs5Im
 mpHMhAa6Wj+bMhzJmUVYQPE5Wi40zfKwd3UyuHAWgVn7SAgH8PGPZiiwt3bJckkIwhYg
 WaIGduooxgSuvmugFpWScRm5ZoLKxM8ASjMcJI/oW0Dkz5US12Tze58/TKQLh+Lu6CvA
 qea4ncsig9bYuk1w+XXTHlh395O0hRa6B9bZZZoZqtietu0fruTw4qHhsMAs4XShOvFC uw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsvdnf4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 02:27:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40U1Jbse014551;
	Tue, 30 Jan 2024 02:27:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr96g54e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 02:27:45 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40U2RP04040916;
	Tue, 30 Jan 2024 02:27:44 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vvr96g4y7-13;
	Tue, 30 Jan 2024 02:27:44 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Peter Wang <peter.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Maramaina Naresh <quic_mnaresh@quicinc.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stanley Jhu <chu.stanley@gmail.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com
Subject: Re: [PATCH V6 0/2] Add CPU latency QoS support for ufs driver
Date: Mon, 29 Jan 2024 21:27:09 -0500
Message-ID: <170657812656.784857.12349810743131732483.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231219123706.6463-1-quic_mnaresh@quicinc.com>
References: <20231219123706.6463-1-quic_mnaresh@quicinc.com>
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
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=764 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300015
X-Proofpoint-ORIG-GUID: Qw1lRoHD-ORVhe2pPJxh4GIgqthnKFHF
X-Proofpoint-GUID: Qw1lRoHD-ORVhe2pPJxh4GIgqthnKFHF

On Tue, 19 Dec 2023 18:07:04 +0530, Maramaina Naresh wrote:

> Add CPU latency QoS support for ufs driver. This improves random io
> performance by 15% for ufs.
> 
> tiotest benchmark tool io performance results on sm8550 platform:
> 
> 1. Without PM QoS support
> 	Type (Speed in)    | Average of 18 iterations
> 	Random Read(IPOS)  | 37101.3
> 	Random Write(IPOS) | 41065.13
> 
> [...]

Applied to 6.9/scsi-queue, thanks!

[1/2] ufs: core: Add CPU latency QoS support for ufs driver
      https://git.kernel.org/mkp/scsi/c/2777e73fc154
[2/2] ufs: ufs-mediatek: Migrate to UFSHCD generic CPU latency PM QoS support
      https://git.kernel.org/mkp/scsi/c/0652205b4ce2

-- 
Martin K. Petersen	Oracle Linux Engineering


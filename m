Return-Path: <linux-kernel+bounces-43833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D20841956
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933CA1F29F24
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79021376E2;
	Tue, 30 Jan 2024 02:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DGCsTb6z"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB536AF0;
	Tue, 30 Jan 2024 02:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581879; cv=none; b=bBMVrJ4mc8KYLt4tmYWQ60hyMIpYpzALd0INo4+CKGJg5nfuVeR5hqB6T8lxOvO2wA6rdqIhbaH0SBPD7cgPa3zMkNHM4d/qsUG/tZ2q0V/F2toVFWjQrDV8X4Vqhu2PEmJdpi1H+J1ZWDXQ4QXLVU8R5clY3EmQruGzAMn1J3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581879; c=relaxed/simple;
	bh=y62Q/dAtQ8BmeEZlg6H2iuUnRhAZs3aPjzgkezjwQTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IW+3j4jPwdbND6JoeEf6rrTCy40PwbjspZ5vNuEfXFi/t+xc2yQeqbJ2N8gK4dieJC7T8S5HILn3li2ql3cyjYRajYKGHRxklGh+at4fqC1/K7uaecvxQC6+dZl7760Xfme+AHl3/YMSmUOrDJl+4DMEEprmp2q1LCvLgoW2xIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DGCsTb6z; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJiSWO007794;
	Tue, 30 Jan 2024 02:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=caKsiPBI0FkNALgqagk+uNbDMWGEH6FlNyumgTnYZ/s=;
 b=DGCsTb6zHeSji3sw5fr9v2vdcFt/D2/n7xaRHZM7vJcxaFsRJ5xiQNM4oZeEY4F18MH5
 +9RSqcJn/kIXGF4GBLELtZ+Q90t2nw5uvKSiZt4UMA9BmYsZ2khD85luNuP3A/LqYiNu
 pVifiK3+eQQzjyJoDCLGQ3bom+0Rynk/ubnJ086hnwFlnIMRVH9/xop3axVws/IaQoZD
 ljrCd1VjYVHclz0ri6UiXM11ind2qC9o5X3DkqZcgZnc4/vFzSA9HxgQHkG4Y9VCy0UH
 VQBiSQSIrkyY064n6he5AoVXbrjYYMZ+nKnk/MZPYwfnRQuvNmHNNjWnDnPbT47XinCf rw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvtcuwfsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 02:27:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40U20Po0014442;
	Tue, 30 Jan 2024 02:27:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr96g4yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 02:27:26 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40U2RPxe040916;
	Tue, 30 Jan 2024 02:27:25 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vvr96g4y7-1;
	Tue, 30 Jan 2024 02:27:25 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, echanude@redhat.com,
        Andrew Halaney <ahalaney@redhat.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: qcom: Clarify comments about the initial phy_gear
Date: Mon, 29 Jan 2024 21:26:57 -0500
Message-ID: <170657812687.784857.581913209178930350.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240123-ufs-reinit-comments-v1-1-ff2b3532d7fe@redhat.com>
References: <20240123-ufs-reinit-comments-v1-1-ff2b3532d7fe@redhat.com>
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
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=950 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300015
X-Proofpoint-ORIG-GUID: -TOcNY6fwNbNgZeEWmekZaRq5gHelOcB
X-Proofpoint-GUID: -TOcNY6fwNbNgZeEWmekZaRq5gHelOcB

On Tue, 23 Jan 2024 13:13:36 -0600, Andrew Halaney wrote:

> The comments that currently are within the hw_ver < 4 conditional
> are misleading. They really apply to various branches of the
> conditionals there and incorrectly state that the phy_gear value
> can increase.
> 
> Right now the logic is to:
> 
> [...]

Applied to 6.9/scsi-queue, thanks!

[1/1] scsi: ufs: qcom: Clarify comments about the initial phy_gear
      https://git.kernel.org/mkp/scsi/c/883a8b451cf4

-- 
Martin K. Petersen	Oracle Linux Engineering


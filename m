Return-Path: <linux-kernel+bounces-136165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9498489D0B6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C2B1F24449
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E767D55E49;
	Tue,  9 Apr 2024 03:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PMvPfe9l"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65BE54BC4;
	Tue,  9 Apr 2024 03:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632158; cv=none; b=WS5N0aSVadhQRrku+3TcFXYibOYOGlRSSgjoXXH0G+uJskNUJI4VplOHCZmqeZN5FiwCptZ30a8LkCG1kMMw6LAzMNl9tnknizSL30CIHub7XtERXcDvEJ9SdcBw4Z7rF+B2IJ65eF/jmkL+eZeP6YjzBnXo3/Jvdo8u8qP4bZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632158; c=relaxed/simple;
	bh=PiLT+rzw1mBxXPaJGGeBq9KLguuW/jlf50tr12yHf34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3OkHnW08k7b/aG51eKqWZeI4LfYyC6ITMfy7v6V5drH7fFg5G4JsFaulGvyy+xYQGoTX+lMZ7lIa+169BA2e/H2kQoqeJkS7aAHtdZqzc0n5qCj/QhVmguJeaZrghKMF3kivM/iI+meTIrFgV898/ANYwzHcg6pRsjoef4pGXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PMvPfe9l; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438LnMZN031204;
	Tue, 9 Apr 2024 03:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=fx5yUgaafXhCJ86ZJScmLwp9cgs70Q+9ULaNWtMFDLk=;
 b=PMvPfe9lLo75tOGyVtkzmQ405gRdJpADPJX5y0deI60XUKETBImItNdOuKI+7Pzuzps+
 wM44j3ODUOZ05FJv3/CokS5yTBaeL6X4eXEqDQ3FYsgJols+singiUvUVKJLrYmrtyep
 OJm6tgv0/CtDUD9fcQSEmUWAdPrFn7TP6p9GgivFt87H/KoUwxaHfE+xHSudycTf3cOB
 Eu55vJxBrdNlADoYtJsAdWBmIYCpYeXPRleCYHhrp4fgvD8i0sSYd75ASLqr6uzP7rPm
 LgTal8NnIzi+FgeGVz+pDKpWbVrTi8CpAvu2vZk+o6xu9Tsxau4nq4oQ7zUHU7G0Xm6o gQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaw0245hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 03:09:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4392QeCt017924;
	Tue, 9 Apr 2024 03:09:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuca6f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 03:09:04 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 439392FH012913;
	Tue, 9 Apr 2024 03:09:04 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xavuca6e1-5;
	Tue, 09 Apr 2024 03:09:04 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH v2 0/2] scsi: ufs: qcom: Add missing interconnect bandwidth values for Gear 5
Date: Mon,  8 Apr 2024 23:08:54 -0400
Message-ID: <171260277845.3109929.6952839490050788029.b4-ty@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403-ufs-icc-fix-v2-0-958412a5eb45@linaro.org>
References: <20240403-ufs-icc-fix-v2-0-958412a5eb45@linaro.org>
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
X-Proofpoint-ORIG-GUID: fXzbk1Mo_r9YJJAOEpoDFskhF3DfutKG
X-Proofpoint-GUID: fXzbk1Mo_r9YJJAOEpoDFskhF3DfutKG

On Wed, 03 Apr 2024 18:50:02 +0530, Manivannan Sadhasivam wrote:

> This series adds the interconnect bandwidth values for Gear 5 to the Qcom
> driver and also adds the check for the unsupported gear/lane values.
> 
> - Mani
> 
> 

Applied to 6.10/scsi-queue, thanks!

[2/2] scsi: ufs: qcom: Add sanity checks for gear/lane values during ICC scaling
      https://git.kernel.org/mkp/scsi/c/33507b3964f1

-- 
Martin K. Petersen	Oracle Linux Engineering


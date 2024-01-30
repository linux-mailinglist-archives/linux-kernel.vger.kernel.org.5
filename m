Return-Path: <linux-kernel+bounces-43826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8825F841942
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED65D1F28C04
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE134383A8;
	Tue, 30 Jan 2024 02:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PCRTbGCj"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7D5364C6;
	Tue, 30 Jan 2024 02:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581663; cv=none; b=N6PjnOKh/XpRvj2F9FoW/MjprY0hkbNp8UByXk9gx3y+4CF/PL0EOxxBdLR/bSy4yOFiRPriyrY5Nmfgwo829XBvsC+D6CVEAOiVHPrcbsU/IvHu4hWvvW5ymz9XP0W6pd2lOvZkeMHMqzydGAcH/cwpLwZVqt6Rfv06J9MGXaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581663; c=relaxed/simple;
	bh=z13I5ybnzMVN5WhzhM32kJmhR0ljPHz0r70EoqO8aQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZX99hiV/JvkpnB0FEsC5TgbYV6lPPaiIp99QtklQ2zehUufk1pWpXRQrsRHUD1iL6P5XFp4sJQnjY00nWtdzXyk4vlnIA9PtEW36gJ/VkkTCwUZRve7MLmo3Fl9GGKD+OI7rX/uTP/+deoYuckzGWyPdvpePL+ORSB4ugC4lZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PCRTbGCj; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJiRkb004393;
	Tue, 30 Jan 2024 02:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=tSdBOJQuqBqTGbHFIEL4Bsj/aJKjebNuxL4HEajLauw=;
 b=PCRTbGCj5OJYh42/kscjK58HJEjYbXG0VQxI9D8AS7DymHKjYRcp0GYuVSxMnqWeMY7L
 Y5DqXikrzShY5pZlw0s92OYuz6G6nNrNat82f4s1cRoPbu+lv4MCHI0jWxVRNFJiMZ54
 gF0iaHWH4xL7vtHwJ/epwx7zbYNi4W2X3xejRt72I0AGG8mp/ryeXyPgicZkW/GhmRBI
 JSb6jXjPpTNXLAog9/cGHAweOeNLUkELXir1INlp+FFBZl3ax4OrL7ZDdyf+A8gh99Sr
 WIshSSasY6MPCh0UnK942zFn5xk+8jGGbZJi3AJL0oO/JeiJhjoydVUQCaSD8HrP6l0K jg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsqawf7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 02:27:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40U0vF3f014520;
	Tue, 30 Jan 2024 02:27:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr96g51c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 02:27:33 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40U2RPxo040916;
	Tue, 30 Jan 2024 02:27:33 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vvr96g4y7-6;
	Tue, 30 Jan 2024 02:27:32 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Eric Chanudet <echanude@redhat.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: ufs: qcom: avoid re-init quirk when gears match
Date: Mon, 29 Jan 2024 21:27:02 -0500
Message-ID: <170657812687.784857.2745114891755367401.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240123192854.1724905-4-echanude@redhat.com>
References: <20240123192854.1724905-4-echanude@redhat.com>
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
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=867 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300015
X-Proofpoint-GUID: esX45kz7BNXdKF6lFjG0bDvpGJpd7c7A
X-Proofpoint-ORIG-GUID: esX45kz7BNXdKF6lFjG0bDvpGJpd7c7A

On Tue, 23 Jan 2024 14:28:57 -0500, Eric Chanudet wrote:

> On sa8775p-ride, probing the hba will go through the
> UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH path although the power info
> are same during the second init.
> 
> The REINIT quirk only applies starting with controller v4. For these,
> ufs_qcom_get_hs_gear() reads the highest supported gear when setting the
> host_params. After the negotiation, if the host and device are on the
> same gear, it is the highest gear supported between the two. Skip REINIT
> to save some time.
> 
> [...]

Applied to 6.9/scsi-queue, thanks!

[1/1] scsi: ufs: qcom: avoid re-init quirk when gears match
      https://git.kernel.org/mkp/scsi/c/10a39667a117

-- 
Martin K. Petersen	Oracle Linux Engineering


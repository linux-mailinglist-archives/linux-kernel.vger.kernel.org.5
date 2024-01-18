Return-Path: <linux-kernel+bounces-30339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27431831D4D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ADF01C22F5C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AA82C6BA;
	Thu, 18 Jan 2024 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T0SjTVNJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D902428E0B;
	Thu, 18 Jan 2024 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594382; cv=none; b=L5SUKo4OngYuOrHzJkO0NrTBdaJmldY38qsVfftDTUG8PWYLSNDWKw5aS471NBL4C2OnypFYhWij+PVPAOUI0nXQUa22u5MV+beSOZsWVMI1vm2gBOz1F837wcSnfIoQ/cHD1EWaD4MZ7vCTOZBL2FdG/wwlUPkr0UalI+seKFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594382; c=relaxed/simple;
	bh=sqDjzYI0zzSFRu4qu2bImIy72pfvSNJog227EXCQen4=;
	h=Received:DKIM-Signature:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-QCInternal:X-Proofpoint-Virus-Version:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=MwTfTL1CLwR4nSIMFI8S048WIlEzM9hnSMiL5biHaKDpJ1YrJDoqPdflGpYUe4VZdpvZGVEbp8tiGUrT4Pbu8V0XzRx/xOuCbYCqzTxuyR5oBztufHjv78I6Flj2ojyq8SSrf9nJuS0UIHUDxo5hTFWoO5C0QGlWETfw1CDT6sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T0SjTVNJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40IEPj1H003045;
	Thu, 18 Jan 2024 16:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=UY1NWNgvjQ2I1WarSI9xQY5Dw4XgduBVsLCIgrtYBfc
	=; b=T0SjTVNJkivhgNGhNs0TYJ8ohVdzBFWSSLobG7EcAQ4qJWPLQMryoDvUs9f
	QmaU63MypewUc7SaGels6NhRl2ap5zMAgJsBkusKGwyXK3PGw3WXwcsqOFk4udnL
	FspawG1fcVPg0ymGGX/d2MJdwbT7c6jx+0pOfUZibrNZrbmyp2AO2HE+4bPgbK/b
	qoM1lOXb+U91yCGR/T9lNVEJVw1dLDKZRSbaVhjgKezSrkMtQbinKj2gMvtjf8j6
	s8iYnNNn2nKO4/39VFctnO3J65AYCyI2LssvVLIi6P/tajQqPkWUMz0OwRWBErAN
	rjRHUqna7SMS5SgZDXu+kCyQ/1A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vq5qrg8qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 16:12:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40IGCuM7017656
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 16:12:56 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 18 Jan
 2024 08:12:55 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 18 Jan 2024 08:12:56 -0800
Subject: [PATCH 4/5] wifi: ath10k: Fix htt_data_tx_completion kernel-doc
 warning
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240118-ath10k-kerneldoc-v1-4-99c7e8d95aad@quicinc.com>
References: <20240118-ath10k-kerneldoc-v1-0-99c7e8d95aad@quicinc.com>
In-Reply-To: <20240118-ath10k-kerneldoc-v1-0-99c7e8d95aad@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VSJcKERQF4lnwuYTrpjmjqC3LJiXLwCj
X-Proofpoint-ORIG-GUID: VSJcKERQF4lnwuYTrpjmjqC3LJiXLwCj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 phishscore=0 mlxlogscore=965 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401180118

Currently kernel-doc reports:
drivers/net/wireless/ath/ath10k/htt.h:911: warning: Cannot understand  * @brief target -> host TX completion indication message definition
 on line 911 - I thought it was a doc line

This is because even though struct htt_data_tx_completion uses the
kernel-doc marker "/**", it doesn't actual use kernel-doc syntax for
the documentation. Rather than try to update this legacy driver
documentation to use kernel-doc style, just replace the comment
marker.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/htt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
index eb0ce2f49315..603f6de62b0a 100644
--- a/drivers/net/wireless/ath/ath10k/htt.h
+++ b/drivers/net/wireless/ath/ath10k/htt.h
@@ -906,7 +906,7 @@ struct htt_data_tx_completion_ext {
 	__le16 msdus_rssi[];
 } __packed;
 
-/**
+/*
  * @brief target -> host TX completion indication message definition
  *
  * @details

-- 
2.42.0



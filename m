Return-Path: <linux-kernel+bounces-30336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D80D7831D47
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC82CB212F4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1C12C18D;
	Thu, 18 Jan 2024 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C8hFoY+4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0C728DCC;
	Thu, 18 Jan 2024 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594381; cv=none; b=C66UzCMVMNNq005Qy49QG3pRZJdoegfYUh4TuXV4UXcuoii+AvwAMfufq3R4WxWtY2izSy4QcwimPalYKxjhqmxzYbSDfrnywZ3jzxZfXca3Aq+Og+dOSVhT00nWgmqf9NswLjZoAJeRuirzTbTxzLZotww886qGwZs214Stags=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594381; c=relaxed/simple;
	bh=f+eTMaKSC+t3FO/LTKXXvfC1BOCOZCJ7SjfzxwGpx5g=;
	h=Received:DKIM-Signature:Received:Received:Received:From:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:CC:X-Mailer:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=n8FqA34T92RuK0fNHWgdaogIdFz7+GQsChQZ30upHYJ446jA0jpfu8DRKovlJHj+Gc5CfeRXvpJ4AF6Ig1ua3mzD/VTKfT0P+4pnqW/++YMhvh6zltPG87/hB6mGGZIuKEzCaJ9BKb4BtDmVXS6HobwsgOxtB22rtffU5XsK8jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C8hFoY+4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40IC3pB8030883;
	Thu, 18 Jan 2024 16:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=cwOBLhodr8CT44
	XbrWbGzF7SdmbNPrU3iBPGctfl20U=; b=C8hFoY+4MqjnKrMiWjEhIGBjMN/QI3
	OIi0RlZ7gwjdVhy3/c6aPrWnWbkHcg61t8T6jK4cEk38vDfRSv/PTvWsUnyNBxC/
	PnSxvhPoF9pkvhbHJqfMaKWfYoH7nOK0q6Gb7i9uTHOfaaTMre2dEjdnUdAk3WDH
	MDqU+d4oA4pqUPWb2KZtb7uvWDUAtJIvD+fQL/fJA6epai/Ji6ZgcALlWPUnn0/C
	mUGVV98v9b7momstRQlshiot0on4gSalr90rBGbTXK9x2L7FQ3Btka6eSsdzYTxi
	kHKVg1DI5xToqTstD6KDB7w4GzP09Pysk/1Lz46NpJ4FsRomy/buaDKA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vq3ns8hyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 16:12:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40IGCtkE013165
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 16:12:55 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 18 Jan
 2024 08:12:54 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 0/5] wifi: ath10k: fix ath10k kerneldoc issues
Date: Thu, 18 Jan 2024 08:12:52 -0800
Message-ID: <20240118-ath10k-kerneldoc-v1-0-99c7e8d95aad@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAROqWUC/2WNQQ6CMBBFr0JmbU2nNK248h6GBZZBJmiLLRIN4
 e5WElcu30v++wskikwJjsUCkWZOHHwG3BXg+sZfSXCbGZRUWiIa0Uw9ykEMFD3d2uCEwbY0pC/
 opIY8GyN1/NqS5zpzz2kK8b09zPi1v5j9j80opMDqYG1nlSl1dXo82bF3exfuUK/r+gERV8l+s
 gAAAA==
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 93Gyjc2qukGWbjyt2k9mvrhAkOV4tFLZ
X-Proofpoint-ORIG-GUID: 93Gyjc2qukGWbjyt2k9mvrhAkOV4tFLZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=562 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401180118

With this series applied there are no kernel-doc issues in ath10k
(ath11k and ath12k have already been previously fixed).

---
Jeff Johnson (5):
      wifi: ath10k: add missing wmi_10_4_feature_mask documentation
      wifi: ath10k: correctly document enum wmi_tlv_tx_pause_id
      wifi: ath10k: fix htt_q_state_conf & htt_q_state kernel-doc
      wifi: ath10k: Fix htt_data_tx_completion kernel-doc warning
      wifi: ath10k: Fix enum ath10k_fw_crash_dump_type kernel-doc

 drivers/net/wireless/ath/ath10k/coredump.h |  8 ++++++--
 drivers/net/wireless/ath/ath10k/htt.h      | 12 ++++++++----
 drivers/net/wireless/ath/ath10k/wmi-tlv.h  |  4 ++--
 drivers/net/wireless/ath/ath10k/wmi.h      |  7 +++++--
 4 files changed, 21 insertions(+), 10 deletions(-)
---
base-commit: c1938548bbeed6fcce8fa6e4de9f694994efcc42
change-id: 20240116-ath10k-kerneldoc-61d36e4b1c04



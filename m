Return-Path: <linux-kernel+bounces-37166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A86883AC95
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 107EFB31483
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB78C131E40;
	Wed, 24 Jan 2024 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nBqjHoxp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E23131759;
	Wed, 24 Jan 2024 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106665; cv=none; b=XitZI8rqlQ10sStbkPfYr2Fyzh+LRti4q+hmsxGFGQb4ZMscu+aKUtoJQP2n/BGunvT5BzPPPD6fHXgB9QnguSeW/lm2Zq2LXhvfF2adG9npEO699hK3wx5Gh9SJsWKcwIkT1fOs2dXaaobyq2HuCtCRj1Rr1VNDcxh1uKYPQgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106665; c=relaxed/simple;
	bh=hg0MXJRhPeSBicHzTjU/WJs4RhrbZBMcJt82j7UVrlI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TzY0sEDb9Lb8AzjusY+DrgOEOfNbhOsxZIpEWfGtJGDzS1APVK9zyC0wmbfkRRplU+W+WOfJWbGCXi0gqrm2aP4ATBFGv87c7b/QNT99RtkB0euG/g46/pvmiZFC8Nz5QjC4+P3pRK0OzfCsfdEW5KbkDgIkYMjljmIaPHbBYfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nBqjHoxp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40OCYgfh013998;
	Wed, 24 Jan 2024 14:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=IpU6UPD3KNop00t3GRLzLFXqFcvzqVzyP4FgU48nRLY=; b=nB
	qjHoxpqJBo4hI29imrM1jjywRyb8drp3hCnVUHvol56+cy0IViFg8+O81XrJP3n9
	qHldHnalfQ4SZ2dQZYaDe+BzI9h0LoP7VSdFlWbxjx7vvrpgT8KsxCTjDY/Alh1y
	htb8hfZozrXMq5eQNzLr+f6hIQDlO522c1GyMwvnAXgep4pd4jLxPlZcS15l7Y//
	Urj2batYFpF4DonoJSFSR6x+4a2YLCPn7z6T91USBSDW7s8/4+UhGtPHPxCD4b9A
	a3AtwcaxuAVqjU8BgFSHCrSZhTOS+Dja48Pq0OYHklP+bGRGjLiPSp0mDddTft9P
	8uL6W8SrtsUoY5X4Evkw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtykw8msq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 14:30:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40OEUwnB013622
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 14:30:58 GMT
Received: from hu-janathot-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 24 Jan 2024 06:30:56 -0800
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/1] Bluetooth: hci_qca: add check to set HCI_QUIRK_USE_BDADDR_PROPERTY
Date: Wed, 24 Jan 2024 20:00:41 +0530
Message-ID: <20240124143042.27790-1-quic_janathot@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: E0usJxkWjOI7s_nilFUFEfp_dG4lcx7l
X-Proofpoint-ORIG-GUID: E0usJxkWjOI7s_nilFUFEfp_dG4lcx7l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=484 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401240105

Changes in v2:
  - Addressing comments from Paul Menzel

Janaki Ramaiah Thota (1):
  Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT

 drivers/bluetooth/hci_qca.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project



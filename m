Return-Path: <linux-kernel+bounces-31777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8180D8333D7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 12:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03FF8B223F1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74395DDDD;
	Sat, 20 Jan 2024 11:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HAhICGxJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFAADDAD;
	Sat, 20 Jan 2024 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705749676; cv=none; b=A3xGjlCPOgy1ZW8eflzqR0ntp+uWNsL3qAnvkryARffsKwsBx7iX6BIdys3BBefezQixW3iEX6ABdqTnpglNYZFojpmzK3BfdnkU2fbWeR49JYU8oQbLcEKhmT7J8ypszndfANazd9ME7z9mz3tFreWSfw7YOJY3ZkkX/vdTYps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705749676; c=relaxed/simple;
	bh=2dcc0Yyrj14lg85ApEViidIZ5aShvEHIjZ0J7cIXKJY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d/L7mvLtidSP0+uOGCpbeQXvE+zFL5zhg28+JT0Ays6htS1cJVIOVy/Dt0gqAbPSOVdg+zfbTsSlHcJlmhLFgSQsurJRYA+LBbhsh9hu4CbkmyiLihPv3RgVI0S2/7tEFovE4lpzF2UIll5FbTHC5pUF5tSe0D4YqhloxcolU+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HAhICGxJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40KBKXuQ018175;
	Sat, 20 Jan 2024 11:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=zvMn6sx6QAeXlTZWaI1EwsfMy/pABV7n7RhDItQ16Tw=; b=HA
	hICGxJK6XXAJ/aZ10xh5YakeIh+6ERouBW2s3gdJPcrfAAYnhqIoO546rc3RkBHh
	fpnL82H94QSxFWXwN0eUXnQgOgKxldiROOZxFp3i8boTXxxRDfv/Qi9JdLX+635m
	ecdIEIMyA4L/kK3zTjRkZn4JmNmtJHCfiNCmbCNUL8mxTidpaWzsap0LtGG9E4Py
	XI/jlkVSW5HDlbzfDw0RuWhNJz4CnU2DTWCe7A49ZPc6qbIFCXC4RO53NsdqjaEs
	pVPN4tLAkxc9eMOlHVUxq7JDtqCtaSmjMPuuy6KYjoqleq1kz6XuvjfsezEs4NcX
	iLpBn1W4bfb5C9zawB5Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr6xn0dmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jan 2024 11:21:11 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40KBLA5I029786
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jan 2024 11:21:10 GMT
Received: from hu-amrianan-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 20 Jan 2024 03:21:04 -0800
From: Amrit Anand <quic_amrianan@quicinc.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Amrit Anand
	<quic_amrianan@quicinc.com>
Subject: [PATCH 0/2] Add board-id support for multiple DT selection 
Date: Sat, 20 Jan 2024 16:50:47 +0530
Message-ID: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UkIywPEtXl5UCY0aLF4TeZU-cP1wl5VU
X-Proofpoint-ORIG-GUID: UkIywPEtXl5UCY0aLF4TeZU-cP1wl5VU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-20_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 mlxscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=656
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401200092

Device manufacturers frequently ship multiple boards or SKUs under a
single software package. These software packages will ship multiple
devicetree blobs and require some mechanism to pick the correct DTB for
the board the software package was deployed. Introduce a common
definition for adding board identifiers to device trees. board-id
provides a mechanism for bootloaders to select the appropriate DTB which
is vendor/OEM-agnostic.

Isn't that what the compatible property is for?
-----------------------------------------------
The compatible property can be used for board matching, but requires
bootloaders and/or firmware to maintain a database of possible strings
to match against or have complex compatible string matching. Compatible
string matching becomes complicated when there are multiple versions of
board: the device tree selector should recognize a DTB that cares to
distinguish between v1/v2 and a DTB that doesn't make the distinction.
An eeprom either needs to store the compatible strings that could match
against the board or the bootloader needs to have vendor-specific
decoding logic for the compatible string. Neither increasing eeprom
storage nor adding vendor-specific decoding logic is desirable.

The solution proposed here is simpler to implement and doesn't require
updating firmware or bootloader for every new board.

How is this better than Qualcomm's qcom,msm-id/qcom,board-id?
-------------------------------------------------------------
The selection process for devicetrees was Qualcomm-specific and not
useful for other devices and bootloaders that were not developed by
Qualcomm because a complex algorithm was used to implement. Board-ids
provide a matching solution that can be implemented by bootloaders
without introducing vendor-specific code. Qualcomm uses three
devicetree properties: msm-id (interchangeably: soc-id), board-id, and
pmic-id.  This does not scale well for use casese which use identifiers,
for example, to distinguish between a display panel. For a display
panel, an approach could be to add a new property: display-id, but now
bootloaders need to be updated to also read this property. We want to
avoid requiring to update bootloaders with new hardware identifiers: a
bootloader need only recognize the identifiers it can handle.

Amrit Anand (1):
  dt-bindings: hwinfo: Add Qualcomm's board-id types

Elliot Berman (1):
  dt-bindings: hwinfo: Introduce board-id

 .../devicetree/bindings/hwinfo/board-id.yaml       | 53 +++++++++++++
 .../devicetree/bindings/hwinfo/qcom,board-id.yaml  | 86 ++++++++++++++++++++++
 include/dt-bindings/arm/qcom,ids.h                 | 68 +++++++++++++++--
 3 files changed, 199 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwinfo/board-id.yaml
 create mode 100644 Documentation/devicetree/bindings/hwinfo/qcom,board-id.yaml

-- 
2.7.4



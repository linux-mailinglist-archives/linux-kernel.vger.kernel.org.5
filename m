Return-Path: <linux-kernel+bounces-124224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65991891417
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966601C21825
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6228C40863;
	Fri, 29 Mar 2024 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qdb8I3mt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1866739FD8;
	Fri, 29 Mar 2024 07:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711696837; cv=none; b=XOqw0K2OviNyHkNYBtrHWr+MCGYWSIUcyzKQ9NJYfENUz1YS08W2xfA2sAfxP99OhWSd/mqL8vkrmPK3GHFa0wzcgSgAcijF+DeW49gISQxGMlLrTssx6sB4eBvPGT7Q8DWlxqSrMYYrrFk13tSYrjFeEDB+1ddWrQkykR1LsuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711696837; c=relaxed/simple;
	bh=vzmPmJeJUxq5/BxD3bs1AX/uEs3Ldk2UfdR7q7RIaqM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gJ0L6OXSRrHsABe8tvIdE2J4KunnnQ+lWn6FVOCc2HWeVoLmPNb0PuRnfz9kC5AO8Of+X7RiqNRemt9ljy7TkhZ8l5km9FgRNIFjwImOSQJRVs2A92ozkIjgAIVcrGSNzFwi4EsLJ52GiwhF2T+ydCTJWHVj/hsvFxP+Pm20Ua8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qdb8I3mt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T1xp1V019589;
	Fri, 29 Mar 2024 07:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=3rUcGkP
	kSK5xD+ct0f6cwMGcLbiakbm2DQyntW9fjKI=; b=Qdb8I3mtxP427P+750jSECI
	SnbnwLwBSBtT8wWxwQK0h0uYVa04TuXEN4cfWqXEwIp+Vj52nH+sc1YVr6TK0Vmq
	h077NuOTEsb/WLYwKPbMCu1yXcQzCyZTUrhWgUm8LjJxCEz72Wr8feFtRGruTszP
	WP9PvDiGC3LgR/JTNnKrIc1splGW0O+lFOPbrYmI7lo2yVgd57KjPM/OgSPJkL6V
	ah36JrrI3LUoyKqjTyDlFH/IelkBPU/yX9a04mk0SLsbrR4Lc6g94rQBnQ3dhZw8
	8tPbnL1ZpRNwN/TRUb7yLLV5Sf5jM6H07qLEvYsoKlaZUH4Xt6SPN3AZgwMxe8Q=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5fs895pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 07:20:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42T7K3jK018851
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 07:20:03 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 29 Mar 2024 00:19:58 -0700
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Helgaas <bhelgaas@google.com>, Kyle
 Tso <kyletso@google.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
        <u.kleine-koenig@pengutronix.de>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [RFC PATCH 0/2] Add gpio-usb-c-connector compatible
Date: Fri, 29 Mar 2024 12:49:46 +0530
Message-ID: <20240329071948.3101882-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BtrgVd0-GHri3_cLMixRc9KjVDQY6PPq
X-Proofpoint-ORIG-GUID: BtrgVd0-GHri3_cLMixRc9KjVDQY6PPq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_06,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=408 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290061

QDU1000 IDP [1] has a Type-c connector and supports USB 3.0.
However it relies on usb-conn-gpio driver to read the vbus and id
gpio's and provide role switch. However the driver currently has
only gpio-b-connector compatible present in ID table. Adding that
in DT would mean that the device supports Type-B connector and not
Type-c connector. Thanks to Dmitry Baryshkov for pointing it out [2].

This series intends to add that compatible in driver and bindings
so that it can be used in QDU1000 IDP DT.

[1]: https://lore.kernel.org/all/20240319091020.15137-3-quic_kbajaj@quicinc.com/
[2]: https://lore.kernel.org/all/CAA8EJprXPvji8TgZu1idH7y4GtHtD4VmQABFBcRt-9BQaCberg@mail.gmail.com/

Krishna Kurapati (2):
  dt-bindings: connector: Add gpio-usb-c-connector compatible
  usb: common: usb-conn-gpio: Update ID table to add usb-c connector

 Documentation/devicetree/bindings/connector/usb-connector.yaml | 3 +++
 drivers/usb/common/usb-conn-gpio.c                             | 1 +
 2 files changed, 4 insertions(+)

-- 
2.34.1



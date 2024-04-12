Return-Path: <linux-kernel+bounces-141855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CED68A2447
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A7E283023
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694F117583;
	Fri, 12 Apr 2024 03:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="LopAmj1U"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC9716426;
	Fri, 12 Apr 2024 03:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712892103; cv=none; b=tr8xwXQwpmlUvsTyPBmDZcWF36REoKSv63JKqe7g3V/BAtbCnnNn31G777OXFcBlqfuMvfr6eYQLWbZulVGyfpKEI0Za9HvWBRcOr9pdz1Wxi9XkoG1Ejiv1deGxBAhwG+CIp4jK9IByi9aSu1dKfjLWYbIj2ctVr9uRWIJ9qTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712892103; c=relaxed/simple;
	bh=k9QBzxKZzxtZuk28uNHFvqqSgtLDW1PHZOzO/qPeL20=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QSlYsgdX5N5bPOqUINGkkSGqUVfzaSIVbX3Ajxx/38jIjufzKkvN3zFliwpa6zTunuXovwhDCsSQOS+ZgMYD/e6KLlDmDbuWSXrvGmEIFsVV0WCx1n+RQmbBIWUZcMQ3Chmba14mZTZRvsjjNeINezfkMMFyiaQSkTy27c5KAbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=LopAmj1U; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C2ekPr017703;
	Thu, 11 Apr 2024 23:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=DKIM; bh=YcFyLivoUu4Y
	2ck+EIRcC6nVLwmCQ2o31tgZ4TY8kus=; b=LopAmj1UOKJrALf5KgEcfPB85GCW
	tbY5Sj1BRN19IeiKpaxZZcH/hYbcANgfJAZgDiRiM26OvX9TGOOfahQ/cZxfHq1q
	8RDOdvfBcEQUrkvW71EqoKLmXq+K8NWxLUPIDpSKickI/8Bi58qdjq3k8BeNZ8Q6
	Q7Bpi5xJxRGrVPfOA9vivSz31sZvmJ6FL5bwJbHIqsLSRvdEPzYs9p1W9QorBZGt
	1IYSSXIRUeV5YAvepoJzj14V67s8W8IvUiSgs2De4g+hxhEBcYOchczVSY+RIusr
	iT2fmWu+6iqc3mFkxrqQYIjztsHNnYbKWYMNTNmxnZ7YKdoQkTh6jMqiLQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3xek1fa877-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 23:21:24 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 43C3LNr0021560
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Apr 2024 23:21:23 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 11 Apr 2024 23:21:22 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 11 Apr 2024 23:21:22 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 11 Apr 2024 23:21:22 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.220.36])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 43C3L8pe021230;
	Thu, 11 Apr 2024 23:21:10 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "David Lechner" <dlechner@baylibre.com>,
        Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH 0/4] Add driver for LTC2664 and LTC2672
Date: Fri, 12 Apr 2024 11:20:58 +0800
Message-ID: <20240412032102.136071-1-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: WEB6zb_F89hJGGM2ixbTgTcALdoN4nCN
X-Proofpoint-ORIG-GUID: WEB6zb_F89hJGGM2ixbTgTcALdoN4nCN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_14,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120023

The LTC2664 is a 4 Channel, Voltage Output SoftSpan DAC while LTC2672 is a 5
channel, Current Output Softspan DAC. The ABI defined for the driver:

LTC2664 - toggle mode channels:
        * out_voltageY_toggle_en
        * out_voltageY_raw0
        * out_voltageY_raw1
        * out_voltageY_symbol

LTC2672 - toggle mode channels:
        * out_currentY_toggle_en
        * out_currentY_raw0
        * out_currentY_raw1
        * out_currentY_symbol

Default channels won't have any of the above ABIs.

Kim Seer Paller (4):
  dt-bindings: iio: dac: Add adi,ltc2664.yaml
  iio: ABI: add ABI file for the LTC2664 DAC
  iio: ABI: add ABI file for the LTC2672 DAC
  iio: dac: ltc2664: Add driver for LTC2664 and LTC2672

 .../ABI/testing/sysfs-bus-iio-dac-ltc2664     |  30 +
 .../ABI/testing/sysfs-bus-iio-dac-ltc2672     |  30 +
 .../bindings/iio/dac/adi,ltc2664.yaml         | 230 +++++
 MAINTAINERS                                   |  11 +
 drivers/iio/dac/Kconfig                       |  11 +
 drivers/iio/dac/Makefile                      |   1 +
 drivers/iio/dac/ltc2664.c                     | 785 ++++++++++++++++++
 7 files changed, 1098 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2664
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2672
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
 create mode 100644 drivers/iio/dac/ltc2664.c


base-commit: 27eea4778db8268cd6dc80a5b853c599bd3099f1
-- 
2.34.1



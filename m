Return-Path: <linux-kernel+bounces-112056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342CD8874AF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 958B9B217BE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B7F81ADB;
	Fri, 22 Mar 2024 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qVPq7gqv"
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E398005F;
	Fri, 22 Mar 2024 22:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711145107; cv=none; b=phqgcG6Pnj1eDMi9EMfJ9ELZxLJHX1LbDUpVowCf2l4xPqksZrMOvFv9ONocvt7EmI40jQzxG3w4NnLEkKBsbIWfiLlxlvYBrUSXP1JLDA/UflHqjS32m8Q4V2UQ4rbcNRpGDGcI2apax5Tc9lwRWfPp7pP/aLhAv+ur0FmPoA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711145107; c=relaxed/simple;
	bh=mQH4u03tsZyluoPkuFH+vj5xwkSsplS8WTDBXM4a1jY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sD/fDB1+CUCm4qWHobZyMYMENQOgRm/rOX8oYTU7M2r87MGJB8smH9xhzIbrR0uZthyaF/J+0X1NPaS6g0MQyWh50T1MRKlUPtdFiIcNukD/gm3yiWYsrk/lf7+y0kuK0pRSEb0DPv+KGAUMvzg58pTuhzpAkwjxM17N717Y0Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qVPq7gqv; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42MKFhNd008721;
	Fri, 22 Mar 2024 18:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=DKIM; bh=FfnNqIOM8NsT
	oahXJWH3mBcZhmxAmlsdOMFS/s3tSyA=; b=qVPq7gqv8HdChZjd/J7u81TpKBRP
	PMwgyiOwNmE1KPLLhMsN9dkcTjLwIKmm9JoQAffgfctz0QdXe+pq2E4RlNJy72aT
	zyx0T+PECE9kze+vQDew8E7H5d8SPOcvRtuyyYuR5y4QAkvox0v/fQPeTFx+uwFm
	8UPSn/5fuvaym5ciAsS7Al8Mp9T0UXgxwiw3HP0I3B11ZxwZzCuhK8tYqugfKH4Q
	tYgYOEuhmv/vFNJzBeqNuBodIPua4dFot5IriMO9QDHZwDf7YIy7/FDQABmGSCCM
	fqk+0xXV6P6VvlluHmznfjvlC6J5kgBz6i41QlUkUE7ULO0c3IfuD3gIKg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3x1gv8g8je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 18:04:37 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 42MM4aat023755
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 22 Mar 2024 18:04:36 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 22 Mar
 2024 18:04:35 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 22 Mar 2024 18:04:35 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 42MM4M9L028868;
	Fri, 22 Mar 2024 18:04:24 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Add support for AD4000 series
Date: Fri, 22 Mar 2024 19:04:20 -0300
Message-ID: <cover.1711131830.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: L4gCMAWbV0esw13bw2h4cgwr1h2XSv56
X-Proofpoint-ORIG-GUID: L4gCMAWbV0esw13bw2h4cgwr1h2XSv56
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_14,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=859 phishscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403220160

This series adds support for high-speed, high-precision AD4000 series of SAR ADCs.

Most uncommon things about this set are:
1) These devices have the same SPI (Strange Peripheral Interface) as AD7944
devices, which has been documented in ad7944.rst [1].
The device tree description for SPI connections and mode can be the same as of
ad7944 adi,spi-mode [2].
Because ad4000 driver does not currently support daisy-chain mode, I simplified
things a little bit. If having a more complete doc is preferred, I'm fine
changing to that.

[1]: https://lore.kernel.org/linux-iio/20240313-mainline-ad7944-doc-v1-2-7860416726e4@baylibre.com/
[2]: https://lore.kernel.org/linux-iio/20240304-ad7944-mainline-v5-1-f0a38cea8901@baylibre.com/

2) Differently from AD7944, AD4000 devices have a configuration register to
toggle some features. For instance, turbo mode is set through configuration
register rather than an external pin. This simplifies hardware connections,
but then requires software interface. So, additional ABI being proposed 
in sysfs-bus-iio-adc-ad4000. The one I'm most in doubt about is 
span_compression_en which affects the in_voltageY_scale attribute.
That might be instead supported by providing _scale_available and allowing write
to _scale. Anyway, let me know how bad those look like :)

Thanks,
Marcelo

Marcelo Schmitt (2):
  dt-bindings: iio: adc: Add AD4000
  iio: adc: Add support for AD4000

 .../ABI/testing/sysfs-bus-iio-adc-ad4000      |  36 +
 .../bindings/iio/adc/adi,ad4000.yaml          | 151 ++++
 MAINTAINERS                                   |   9 +
 drivers/iio/adc/Kconfig                       |  12 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad4000.c                      | 666 ++++++++++++++++++
 6 files changed, 875 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4000
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
 create mode 100644 drivers/iio/adc/ad4000.c

-- 
2.43.0



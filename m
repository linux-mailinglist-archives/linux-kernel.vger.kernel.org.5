Return-Path: <linux-kernel+bounces-135521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EDB89C71F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3842284F7A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFBF13D28E;
	Mon,  8 Apr 2024 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="d0g6MJwQ"
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC0413D264;
	Mon,  8 Apr 2024 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712586705; cv=none; b=Fjjjc/dNp2kvkZ3rxxo5ejvzE+msCGdpvCUIr05aHOegw6WpPpePo+wUhRLE0dJXJSuuBrjnxrmTVHPRt73YFULTBnoqnq96mr3Jy0wnQ12fQhieMae17I5GJMU3Jz2xnZ2oJLt+mtaXDzoiZUwpocTymPUThnZ+NYr+4ayDheY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712586705; c=relaxed/simple;
	bh=EvtVPmC2a8GrbYiUa8nf5b5/yGVqGSuBquGmjhHCG2A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A0w5DL942+0vUrgNbFbTRJZTuNiQAuHmJi9STgte+NKujwOQHQ974zzJPOEt8/e4F+Yy03M66EY8Nkz3u08fVvryY8OTDc2E9+Np7NZ6hmEEEZwreCnhmzgZF+mNjQZTSQ5Oq4HYFXSFvPqcGnR8RRV48SCshKbKOxJyisfhyq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=d0g6MJwQ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438BnEZ7027951;
	Mon, 8 Apr 2024 10:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=DKIM; bh=J3KVBpz+p8Bb
	sjloP3ipPohes/eBdHpznTwlRE3dPvo=; b=d0g6MJwQB5mLa6mCosEhjwhqEgYG
	Ea/+SjLmEZ1hDc7cLYrHdtwkMj3rh8Z9sL3VxgCSmodItHDq/L7S4LJxoVEJqzBj
	sCVA71bLOB6QqnGGQvqeae2vdBIWOoKOKk1y2JlAQJfUeMJKtk3kbh+gwvusajvQ
	2aTwzf9JVbY2KYH1I81enLnohEdBcL323tRd9iK3ZnQLeTiZ7Yssy/EKL3Hq/Adq
	mSsIWyqZT++B7/5MNTiEgniJ5ESFyesV77kIRNoOTA2PIwB+adnulAWNdM/qIXvB
	A6aWXIgY7sOnWK1vqvaLIRpIqAORfCn0ieS53m25u1mqpmIG/bt3yzERwg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3xcbbn1qf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 10:31:14 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 438EVDkF039117
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Apr 2024 10:31:13 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 8 Apr 2024
 10:31:12 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 8 Apr 2024 10:31:12 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 438EUsew017936;
	Mon, 8 Apr 2024 10:30:57 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] Add support for AD4000 series
Date: Mon, 8 Apr 2024 11:30:50 -0300
Message-ID: <cover.1712585500.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-GUID: QoTcOSGl1jWg0r1YwsM7F9Amu-qwkuT3
X-Proofpoint-ORIG-GUID: QoTcOSGl1jWg0r1YwsM7F9Amu-qwkuT3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_12,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 adultscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080111

This is more like an RFC patch set since configuration read/write is currently
buggy.

Change log v1 -> v2:
- Took device tree provided by David.
- Dropped ABI additions in favor of device tree properties.
- Set differential IIO channel subtype for differential ADCs.
- Set scan_type shift bits to mask out correct real bits from buffer.
- Added __aligned(8) to buffer timestamp.
- Used union to reduce buffer memory usage for 16-bit devices.
- Used SPI transfer functions rather than SPI message.
- Used c99 style structure initialization.
- Used iio_device_claim_direct_scoped().
- Removed unneeded pointer casts.
- Added other power supplies (VDD and VIO).

Link to v1: https://lore.kernel.org/linux-iio/cover.1711131830.git.marcelo.schmitt@analog.com/

Additional topics:

- Why there is no different handling for the different SPI wiring modes?
It looks like there is no need for different handling of "4-wire" and "3-wire"
modes.
If in "4-wire" (dt default mode), SDI is connected to SPI controller CS and
CNV is active high. We can activate the CNV GPIO then let the SPI controller
bring CS (connected to SDI) down when starting the transfer.
If in "3-wire" (dt single mode), if we have a CNV (active low) GPIO we activate
it and then proceed with with the transfer. If controller CS is connected to
CNV it works the same way.
I'm thinking it's better if we can support these devices in similar way
other SPI ADCs are supported. Does that make sense?
To me, the "3-wire" mode with controller CS to ADC CNV is what most resembles
conventional SPI. The only important distinction is that the
controller must be able to keep ADC SDI line high during conversions.
Although, while the spi-engine implementation provided to me can keep SDI up
during conversions, I'm not sure its a thing all SPI controllers can do.
I tried a raspberry pi 4 some time ago and it was leaving the SDI line low if
no tx buffer was provided. Even with a tx full of 1s the controller would 
bring SDI down between each 8 bits of transfer.
Anyway, single-shot and buffered reads work with the spi-engine controller
with ADC in "3-wire"/single mode with controller CS line connected to ADC CNV
pin which is how I've been testing it.

- Why did not make vref regulator optional?
Other SAR ADCs I've seen needed a voltage reference otherwise they simply
could not provide any reasonable readings. Isn't it preferable to fail rather
than having a device that can't provide reliable data?

- Why did not split into AD and ADAQ patches?
The main difference between AD and ADAQ is the amplifier in front of the ADC.
If only supporting AD, we could probably avoid the scale table since it would
only have two possible values per ADC. But then the handling of span compression
scale would need refactoring to be in the scale table when adding ADAQ.
I'm not excited to implement something knowing it will need rework in the
following patch. Will do if required.

- Span compression and offset.
For non-differential ADCs, enabling the span compression requires an input offset.
Link: https://www.analog.com/media/en/technical-documentation/data-sheets/AD4000-4004-4008.pdf
page 18
and
Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4002-4006-4010.pdf
page 19
I updated the _offset attribute for those ADCs according to span compression
being enabled or not. Is it okay to have an attribute update cause an update to
another one?
Maybe also make the span compression a dt property and have it fixed after probe?

- Configuration register
Despite it doing single-shot and buffered captures, read and writes to the
configuration register are currently buggy. It is as if the register was
"floating". I tried setting up buffers like ad7768-1, adxl355_core, bma220_spi,
bma400_core, and mcp3911.


Thanks,
Marcelo

Marcelo Schmitt (2):
  dt-bindings: iio: adc: Add AD4000
  iio: adc: Add support for AD4000

 .../bindings/iio/adc/adi,ad4000.yaml          | 201 ++++++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  12 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad4000.c                      | 649 ++++++++++++++++++
 5 files changed, 871 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
 create mode 100644 drivers/iio/adc/ad4000.c

-- 
2.43.0



Return-Path: <linux-kernel+bounces-5903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768E081914E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A1FEB24889
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58E139AC7;
	Tue, 19 Dec 2023 20:26:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050E839AC5;
	Tue, 19 Dec 2023 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJI4OGc024805;
	Tue, 19 Dec 2023 15:25:28 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3v3g4s8efk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 15:25:28 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3BJKPQsO034660
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 19 Dec 2023 15:25:26 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 19 Dec 2023 15:25:25 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 19 Dec 2023 15:25:25 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 19 Dec 2023 15:25:25 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3BJKP5B9029964;
	Tue, 19 Dec 2023 15:25:07 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <dan.carpenter@linaro.org>,
        <dlechner@baylibre.com>, <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 00/11] Add support for AD7091R-2/-4/-8
Date: Tue, 19 Dec 2023 17:25:04 -0300
Message-ID: <cover.1703013352.git.marcelo.schmitt1@gmail.com>
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
X-Proofpoint-ORIG-GUID: O66u9oDmtLDVDQzxRqI-DTKy0UwNU27a
X-Proofpoint-GUID: O66u9oDmtLDVDQzxRqI-DTKy0UwNU27a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312190151

From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

----------------- Updates -----------------

Applied all suggestions. 
Only submitting patches not applied on v4:
Patches after ("Align arguments to function call parenthesis").

Change log v4 -> v5:
- Patch 1: Event callbacks
  * Moved to begin of the series to easy backport;
  * Reverted to original event attributes;
  * Reworked event configuration to do per direction per channel enable/disable;
  * Improved commit message;
  * Added fixes tag;
  * Added Suggested-by tag.
- Patch 2: Enable internal vref
  * Added fixes tag and improved commit message;
  * Now earlier in the series to easy backport;
  * Used regmap_set_bits() to make code more neat.
- Patch 3: Move generic AD7091R code
  * event specs moved earlier in patch 1.
- Patch 4: Move chip init data
  * Renamed field to make initialization clearer: irq_info -> info_irq.
  * Fixed ad7091r_init_info initialization by passing pointers to info structs;
- Patch 10: Add ad7091r8 support
  * Moved bitfield.h include to patch event callbacks patch;
  * Dropped GPIO consumer include on ad7091r-base.h and added gpio_desc;
  * Removed extra space before devm_gpiod_get_optional().

So, since we are already fixing a few things here, maybe it's a good time to
comment about the event ABI.
I see the event config files under events directory appearing as
in_voltage0_thresh_falling_value
in_voltage0_thresh_rising_value
in_voltage1_thresh_falling_value
and so on.
They don't have the `_raw` part of the name as documented in the IIO ABI [1].
Not sure if that is how it's intended to be, the driver is still missing
something, or maybe ABI is somehow outdated.
Anyway, if that is also something to be fixed then let me know I'll have a look
at it.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/Documentation/ABI/testing/sysfs-bus-iio#n887

Thanks,
Marcelo

----------------- Context -----------------

This series adds support for AD7091R-2/-4/-8 ADCs which can do single shot
or sequenced readings. Threshold events are also supported.
Overall, AD7091R-2/-4/-8 are very similar to AD7091R-5 except they use SPI interface.

Changes have been tested with raspberrypi and eval board on raspberrypi kernel
6.7-rc3 from raspberrypi fork.
Link: https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/ad7091r8


Marcelo Schmitt (11):
  iio: adc: ad7091r: Allow users to configure device events
  iio: adc: ad7091r: Enable internal vref if external vref is not
    supplied
  iio: adc: ad7091r: Move generic AD7091R code to base driver and header
    file
  iio: adc: ad7091r: Move chip init data to container struct
  iio: adc: ad7091r: Remove unneeded probe parameters
  iio: adc: ad7091r: Set device mode through chip_info callback
  iio: adc: ad7091r: Add chip_info callback to get conversion result
    channel
  iio: adc: Split AD7091R-5 config symbol
  dt-bindings: iio: Add AD7091R-8
  iio: adc: Add support for AD7091R-8
  MAINTAINERS: Add MAINTAINERS entry for AD7091R

 .../bindings/iio/adc/adi,ad7091r5.yaml        |  82 +++++-
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  16 ++
 drivers/iio/adc/Makefile                      |   4 +-
 drivers/iio/adc/ad7091r-base.c                | 269 +++++++++++------
 drivers/iio/adc/ad7091r-base.h                |  83 +++++-
 drivers/iio/adc/ad7091r5.c                    | 120 ++++----
 drivers/iio/adc/ad7091r8.c                    | 272 ++++++++++++++++++
 8 files changed, 714 insertions(+), 140 deletions(-)
 create mode 100644 drivers/iio/adc/ad7091r8.c

-- 
2.42.0



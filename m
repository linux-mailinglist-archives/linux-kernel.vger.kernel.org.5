Return-Path: <linux-kernel+bounces-2298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A38E815AB2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 18:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55067285DC4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9868330FA0;
	Sat, 16 Dec 2023 17:45:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B173F2C192;
	Sat, 16 Dec 2023 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BGEYQka002174;
	Sat, 16 Dec 2023 12:45:07 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3v1526spe1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 12:45:06 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3BGHj5lw033801
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 16 Dec 2023 12:45:05 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Sat, 16 Dec
 2023 12:45:04 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sat, 16 Dec 2023 12:45:04 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3BGHikIr015700;
	Sat, 16 Dec 2023 12:44:48 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <dan.carpenter@linaro.org>,
        <dlechner@baylibre.com>, <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 00/15] Add support for AD7091R-2/-4/-8
Date: Sat, 16 Dec 2023 14:44:43 -0300
Message-ID: <cover.1702746240.git.marcelo.schmitt1@gmail.com>
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
X-Proofpoint-GUID: ZteL9u2eUe3dogRbUEce-DRqXKLVF4DJ
X-Proofpoint-ORIG-GUID: ZteL9u2eUe3dogRbUEce-DRqXKLVF4DJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0 adultscore=0
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160136

From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

----------------- Updates -----------------

Applied changes suggested to the previous set.

Change log v3 -> v4:
- Patch 1: checkpatch patch
  * Changed __aligned regex string.
- Patch 2: alert handling fix
  * Applied David's suggestion [1] to pass iio_dev on to IRQ thread handler.
- Patches 6, 7, 9
  * Removed ad7091r prefix from callback function names.
- New Patch 7: Remove uneeded probe parameters
  * Removed id->name and regmap from probe paramenters.
- Patch 8 (now Patch 9): Enable internal vref
  * Not expecting NULL return from regulator_get_optional() anymore;
  * Reverted to previous probe defer handling.
- Patch 10 (now Patch 11): dt doc
  * Extending existing ad7091r5 dt doc instead of creating a new one;
  * Added VDD and VDRIVE supplies to dt doc;
  * Removed channel property from dt doc;
  * Interrupt description, interrupt constraint check, example indentation improvements.
- Patch 12 (now Patch 13): add ad7091r8 patch
  * Neats to macros, gpio setups, and probe parameters.
- Patch 13 (now Patch 14):
  * Made use of wild cards in MAINTAINERS file.
- New Patch (Patch 15): event configuration callbacks

[1]: https://lore.kernel.org/linux-iio/CAMknhBHCYicEL_xhumBQMUm=HBVb=7dLrYsK8Zj2o7RodvMarw@mail.gmail.com/

Thank you all for the help with this set,
Marcelo

----------------- Context -----------------

This series adds support for AD7091R-2/-4/-8 ADCs which can do single shot
or sequenced readings. Threshold events are also supported.
Overall, AD7091R-2/-4/-8 are very similar to AD7091R-5 except they use SPI interface.

Changes have been tested with raspberrypi and eval board on raspberrypi kernel
6.7-rc3 from raspberrypi fork.
Link: https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/ad7091r8

Marcelo Schmitt (15):
  scripts: checkpatch: Add __aligned to the list of attribute notes
  iio: adc: ad7091r: Pass iio_dev to event handler
  iio: adc: ad7091r: Set alert bit in config register
  iio: adc: ad7091r: Align arguments to function call parenthesis
  iio: adc: ad7091r: Move generic AD7091R code to base driver and header
    file
  iio: adc: ad7091r: Move chip init data to container struct
  iio: adc: ad7091r: Remove unneeded probe parameters
  iio: adc: ad7091r: Set device mode through chip_info callback
  iio: adc: ad7091r: Enable internal vref if external vref is not
    supplied
  iio: adc: ad7091r: Add chip_info callback to get conversion result
    channel
  iio: adc: Split AD7091R-5 config symbol
  dt-bindings: iio: Add AD7091R-8
  iio: adc: Add support for AD7091R-8
  MAINTAINERS: Add MAINTAINERS entry for AD7091R
  iio: adc: ad7091r: Allow users to configure device events

 .../bindings/iio/adc/adi,ad7091r5.yaml        |  82 +++++-
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  16 ++
 drivers/iio/adc/Makefile                      |   4 +-
 drivers/iio/adc/ad7091r-base.c                | 255 +++++++++++------
 drivers/iio/adc/ad7091r-base.h                |  81 +++++-
 drivers/iio/adc/ad7091r5.c                    | 120 ++++----
 drivers/iio/adc/ad7091r8.c                    | 257 ++++++++++++++++++
 scripts/checkpatch.pl                         |   1 +
 9 files changed, 682 insertions(+), 142 deletions(-)
 create mode 100644 drivers/iio/adc/ad7091r8.c

-- 
2.42.0



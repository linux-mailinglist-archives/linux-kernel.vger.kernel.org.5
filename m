Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174BE809047
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjLGSgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjLGSgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:36:16 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0C81711;
        Thu,  7 Dec 2023 10:36:17 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B7FRV7S008686;
        Thu, 7 Dec 2023 13:35:50 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3utd13snpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 13:35:50 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3B7IZmQY024170
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Dec 2023 13:35:48 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 7 Dec 2023
 13:35:47 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 7 Dec 2023 13:35:47 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3B7IZSpv015039;
        Thu, 7 Dec 2023 13:35:31 -0500
From:   Marcelo Schmitt <marcelo.schmitt@analog.com>
To:     <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dan.carpenter@linaro.org>, <marcelo.schmitt1@gmail.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 00/13] Add support for AD7091R-2/-4/-8
Date:   Thu, 7 Dec 2023 15:35:27 -0300
Message-ID: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 1SsenXRjwrZh6ziueMLV-vekFJJVkksa
X-Proofpoint-GUID: 1SsenXRjwrZh6ziueMLV-vekFJJVkksa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312070154
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

----------------- Updates -----------------

Applied all changes suggested to the previous series.

I tried to better explain the changes but, since there is a fair amount of
rework in ad7091-base and ad7091r5, it may be hard to get the reasoning for the
early patches before looking at the patch for ad7091r8.

Change log v2 -> v3:
- Split alert fix patch into 2 fix patches and one alignment cleanup patch
- Corrected Fixes tag format
- Moved MAINTAINERS update to the end of the series
- Reworded some commit messages to provide context and make their goal clearer
- Removed erroneous gmail sign off
- Created container struct to store chip_info, regmap_config, and callbacks
  specific to each ADC design
- Created callbacks for chip specific tasks such as setting device operation mode
- Dropped the chip type enum struct
- Applied suggestions related to device tree documentation
- Added __aligned to list the of checkpatch attribute notes
- Other code style tidy ups.

I see regmap's interface for reading device registers under /sys/kernel/debug/regmap/.
I can read all registers but can't write to any of them unless I force define
REGMAP_ALLOW_WRITE_DEBUGFS.

When testing events for this driver I often write to device registers
to set different rising/falling thresholds. I do something like this:
# echo 0x17 0x100 > /sys/kernel/debug/iio/iio:device0/direct_reg_access

I tried read/writing to files under iio:device events directory but always
get segmentation fault. I must be forgetting to implement something.
What am I missing?

Thanks
Marcelo

----------------- Context -----------------

This series adds support for AD7091R-2/-4/-8 ADCs which can do single shot
or sequenced readings. Threshold events are also supported.
Overall, AD7091R-2/-4/-8 are very similar to AD7091R-5 except they use SPI interface.

Changes have been tested with raspberrypi and eval board on raspberrypi kernel
6.7-rc3 from raspberrypi fork.
Link: https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/ad7091r8

Marcelo Schmitt (13):
  scripts: checkpatch: Add __aligned to the list of attribute notes
  iio: adc: ad7091r: Populate device driver data field
  iio: adc: ad7091r: Set alert bit in config register
  iio: adc: ad7091r: Align arguments to function call parenthesis
  iio: adc: ad7091r: Move generic AD7091R code to base driver and header
    file
  iio: adc: ad7091r: Move chip init data to container struct
  iio: adc: ad7091r: Set device mode through chip_info callback
  iio: adc: ad7091r: Enable internal vref if external vref is not
    supplied
  iio: adc: ad7091r: Add chip_info callback to get conversion result
    channel
  dt-bindings: iio: Add AD7091R-8
  iio: adc: Split AD7091R-5 config symbol
  iio: adc: Add support for AD7091R-8
  MAINTAINERS: Add MAINTAINERS entry for AD7091R

 .../bindings/iio/adc/adi,ad7091r8.yaml        |  99 +++++++
 MAINTAINERS                                   |  12 +
 drivers/iio/adc/Kconfig                       |  16 ++
 drivers/iio/adc/Makefile                      |   4 +-
 drivers/iio/adc/ad7091r-base.c                | 141 ++++------
 drivers/iio/adc/ad7091r-base.h                |  78 +++++-
 drivers/iio/adc/ad7091r5.c                    | 119 ++++----
 drivers/iio/adc/ad7091r8.c                    | 261 ++++++++++++++++++
 scripts/checkpatch.pl                         |   1 +
 9 files changed, 597 insertions(+), 134 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml
 create mode 100644 drivers/iio/adc/ad7091r8.c

-- 
2.42.0


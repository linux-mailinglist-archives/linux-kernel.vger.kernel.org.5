Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488AC7F385C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbjKUVe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjKUVe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:34:26 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0FCF4;
        Tue, 21 Nov 2023 13:34:22 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ALGQcPe024636;
        Tue, 21 Nov 2023 16:34:09 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ueu275ev1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 16:34:09 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3ALLY7D8056886
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Nov 2023 16:34:07 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 21 Nov 2023 16:34:07 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 21 Nov 2023 16:34:06 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 21 Nov 2023 16:34:06 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3ALLXrCV019788;
        Tue, 21 Nov 2023 16:33:55 -0500
From:   <marcelo.schmitt@analog.com>
To:     <beniamin.bia@analog.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <jic23@kernel.org>, <marcelo.schmitt1@gmail.com>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/7] Add support for AD7091R-2/-4/-8
Date:   Tue, 21 Nov 2023 18:33:49 -0300
Message-ID: <cover.1700595310.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: AI8lvFFjUVhbewESITz-PYV-jsJFqTD2
X-Proofpoint-GUID: AI8lvFFjUVhbewESITz-PYV-jsJFqTD2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_11,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1011
 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=975 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311060001 definitions=main-2311210168
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

This series adds support for AD7091R-2/-4/-8 ADCs which can do single shot
or sequenced readings. Threshold events are also supported.
Overall, AD7091R-2/-4/-8 are very similar to AD7091R-5 except they use SPI interface.

This has been tested with raspberrypi and eval board on kernel 6.1 from ADI fork.
Link: https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/ad7091r8

Marcelo Schmitt (7):
  iio: adc: ad7091r-base: Set alert config and drvdata
  MAINTAINERS: Add MAINTAINERS entry for AD7091R
  iio: adc: ad7091r: Move defines to header file
  iio: adc: ad7091r: Alloc IIO device before generic probe
  dt-bindings: iio: Add binding documentation for AD7091R-8
  iio: adc: Add support for AD7091R-8
  iio: adc: ad7091r-base: Add debugfs reg access

 .../bindings/iio/adc/adi,ad7091r8.yaml        | 101 +++++++
 MAINTAINERS                                   |  12 +
 drivers/iio/adc/Kconfig                       |  16 ++
 drivers/iio/adc/Makefile                      |   4 +-
 drivers/iio/adc/ad7091r-base.c                |  98 ++++---
 drivers/iio/adc/ad7091r-base.h                |  82 +++++-
 drivers/iio/adc/ad7091r5.c                    |  55 ++--
 drivers/iio/adc/ad7091r8.c                    | 272 ++++++++++++++++++
 8 files changed, 551 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml
 create mode 100644 drivers/iio/adc/ad7091r8.c

-- 
2.42.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A747539B2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbjGNLkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjGNLk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:40:26 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E97430CD;
        Fri, 14 Jul 2023 04:40:23 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 0CA2E120011;
        Fri, 14 Jul 2023 14:40:20 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 0CA2E120011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1689334820;
        bh=lAP+LiJAgofCoDTySJN73ZIOwR19lY9bnqhJJAzeg8M=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=Prz0aPweWBDeOhxS/T4hcWkRocmfCcIJywOuXTg9aouegMSuKjTMN7MyG8uslJL80
         HbDS16Wi/VwwSiEVwR/9XRQ/pYkjw/ohsogRZPft3zMrI/wx2jTWVY9YBvDVVXHapA
         UU1JMLBSkeAct4RM1wLmOJyl8oq6I9ySbzzZ9oi1zyKnAQnHK3xkivyaXirXbcH/K4
         kRjeU7+qgxHkOL22DCJbceOvZDgs+/TfGQh0FIwggh8WLJGLrgZ/DZwxe5OZz0wJVI
         8NoUHOA+joVBmUDztNULdqTKRJ+A/eOodcRpd6F3xbD4QnqjguJoIWm2MKWmccMnqQ
         E3QOmBL9hrh3A==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 14 Jul 2023 14:40:19 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 14 Jul 2023 14:39:47 +0300
From:   George Stark <gnstark@sberdevices.ru>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>,
        <andriy.shevchenko@linux.intel.com>, <nuno.sa@analog.com>,
        <gnstark@sberdevices.ru>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>,
        George Stark <GNStark@sberdevices.ru>
Subject: [PATCH v7 2/6] iio: adc: meson: move enums declaration before variables declaration
Date:   Fri, 14 Jul 2023 14:37:49 +0300
Message-ID: <20230714114010.293440-3-gnstark@sberdevices.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714114010.293440-1-gnstark@sberdevices.ru>
References: <20230714114010.293440-1-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178622 [Jul 14 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: GNStark@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 523 523 523027ce26ed1d9067f7a52a4756a876e54db27c, {Tracking_from_domain_doesnt_match_to}, sberdevices.ru:5.0.1,7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/14 02:46:00 #21611850
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to use enum items for variables initialization.
For this, move enums upper in the code.

Signed-off-by: George Stark <GNStark@sberdevices.ru>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/meson_saradc.c | 44 +++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 569ffc178935..98b6697a21f6 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -202,6 +202,28 @@
 	.datasheet_name = "TEMP_SENSOR",				\
 }
 
+enum meson_sar_adc_avg_mode {
+	NO_AVERAGING = 0x0,
+	MEAN_AVERAGING = 0x1,
+	MEDIAN_AVERAGING = 0x2,
+};
+
+enum meson_sar_adc_num_samples {
+	ONE_SAMPLE = 0x0,
+	TWO_SAMPLES = 0x1,
+	FOUR_SAMPLES = 0x2,
+	EIGHT_SAMPLES = 0x3,
+};
+
+enum meson_sar_adc_chan7_mux_sel {
+	CHAN7_MUX_VSS = 0x0,
+	CHAN7_MUX_VDD_DIV4 = 0x1,
+	CHAN7_MUX_VDD_DIV2 = 0x2,
+	CHAN7_MUX_VDD_MUL3_DIV4 = 0x3,
+	CHAN7_MUX_VDD = 0x4,
+	CHAN7_MUX_CH7_INPUT = 0x7,
+};
+
 static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
 	MESON_SAR_ADC_CHAN(0),
 	MESON_SAR_ADC_CHAN(1),
@@ -225,28 +247,6 @@ static const struct iio_chan_spec meson_sar_adc_and_temp_iio_channels[] = {
 	MESON_SAR_ADC_TEMP_CHAN(8),
 };
 
-enum meson_sar_adc_avg_mode {
-	NO_AVERAGING = 0x0,
-	MEAN_AVERAGING = 0x1,
-	MEDIAN_AVERAGING = 0x2,
-};
-
-enum meson_sar_adc_num_samples {
-	ONE_SAMPLE = 0x0,
-	TWO_SAMPLES = 0x1,
-	FOUR_SAMPLES = 0x2,
-	EIGHT_SAMPLES = 0x3,
-};
-
-enum meson_sar_adc_chan7_mux_sel {
-	CHAN7_MUX_VSS = 0x0,
-	CHAN7_MUX_VDD_DIV4 = 0x1,
-	CHAN7_MUX_VDD_DIV2 = 0x2,
-	CHAN7_MUX_VDD_MUL3_DIV4 = 0x3,
-	CHAN7_MUX_VDD = 0x4,
-	CHAN7_MUX_CH7_INPUT = 0x7,
-};
-
 struct meson_sar_adc_param {
 	bool					has_bl30_integration;
 	unsigned long				clock_rate;
-- 
2.38.4


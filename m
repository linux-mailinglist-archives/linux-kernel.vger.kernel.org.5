Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DB7751432
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjGLXMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjGLXML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:12:11 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C54B18E;
        Wed, 12 Jul 2023 16:12:09 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 0C0CE100023;
        Thu, 13 Jul 2023 02:12:08 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 0C0CE100023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1689203528;
        bh=98khYn1fztt12eqMcHqL5Q5p7BU+eCOCeF+HxCxX/Ck=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=HWUZo+0l5D7O5Y4TTzYcYdQhy2ZAG2Zb6v4VKQ5ZAfmDke+XSOcGmsi8GN9eFMNdD
         zeA8G5hrxG5rEzVb0kGkC8FH9Ki5P6PanyASef7032Sr2+WOpuOJNnmW27TWPBhhTR
         6NgTVn33MI8no7jiE8o5gTeH0LpGIJqpXj/sIVQ36BrlitkIVhR6VKZ3jkmJ6dNhAQ
         cU/2EWktWFy3RXZ9so2qZBkwLWtG6DsNECo7VfBCXx1p2ZQA0UrLg5WlpuiWExB8Mc
         teouz4xcwMZTamvd9Ix2Hg8ysMQtU95bKiiDC/5yINbds55/bPkbMHDyjOxZtaNpts
         2TopbaZoKc0eg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu, 13 Jul 2023 02:12:07 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 02:11:48 +0300
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
Subject: [PATCH v6 4/6] iio: adc: meson: add enum for iio channel numbers
Date:   Thu, 13 Jul 2023 02:10:45 +0300
Message-ID: <20230712231157.261245-5-gnstark@sberdevices.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712231157.261245-1-gnstark@sberdevices.ru>
References: <20230712231157.261245-1-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178587 [Jul 12 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: GNStark@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 521 521 0c3391dd6036774f2e1052158c81e48587b96e95, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/12 10:49:00 #21602221
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Channels could be referenced in the driver code and using enum allows
to make it more robust.

Signed-off-by: George Stark <GNStark@sberdevices.ru>
---
 drivers/iio/adc/meson_saradc.c | 46 +++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 44ac6ce5e3aa..b14c66656bcc 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -224,27 +224,39 @@ enum meson_sar_adc_chan7_mux_sel {
 	CHAN7_MUX_CH7_INPUT = 0x7,
 };
 
+enum meson_sar_adc_channel_index {
+	NUM_CHAN_0,
+	NUM_CHAN_1,
+	NUM_CHAN_2,
+	NUM_CHAN_3,
+	NUM_CHAN_4,
+	NUM_CHAN_5,
+	NUM_CHAN_6,
+	NUM_CHAN_7,
+	NUM_CHAN_TEMP,
+};
+
 static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
-	MESON_SAR_ADC_CHAN(0),
-	MESON_SAR_ADC_CHAN(1),
-	MESON_SAR_ADC_CHAN(2),
-	MESON_SAR_ADC_CHAN(3),
-	MESON_SAR_ADC_CHAN(4),
-	MESON_SAR_ADC_CHAN(5),
-	MESON_SAR_ADC_CHAN(6),
-	MESON_SAR_ADC_CHAN(7),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_0),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_1),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_2),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_3),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_4),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_5),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_6),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_7),
 };
 
 static const struct iio_chan_spec meson_sar_adc_and_temp_iio_channels[] = {
-	MESON_SAR_ADC_CHAN(0),
-	MESON_SAR_ADC_CHAN(1),
-	MESON_SAR_ADC_CHAN(2),
-	MESON_SAR_ADC_CHAN(3),
-	MESON_SAR_ADC_CHAN(4),
-	MESON_SAR_ADC_CHAN(5),
-	MESON_SAR_ADC_CHAN(6),
-	MESON_SAR_ADC_CHAN(7),
-	MESON_SAR_ADC_TEMP_CHAN(8),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_0),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_1),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_2),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_3),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_4),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_5),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_6),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_7),
+	MESON_SAR_ADC_TEMP_CHAN(NUM_CHAN_TEMP),
 };
 
 struct meson_sar_adc_param {
-- 
2.38.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B34791F6C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 00:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240163AbjIDWCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 18:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIDWCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 18:02:13 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1D89C;
        Mon,  4 Sep 2023 15:02:10 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c1d03e124so253611266b.2;
        Mon, 04 Sep 2023 15:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693864929; x=1694469729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xMaoJXfSUTGUV6QmpzTNhrGbBGCZavotUULkh8MgnQA=;
        b=CTUmyD3tsgPK4wtfXEldTvXQ6kXhZebB4IGvNBWylJsYmuIWdYwddtU28zMhYd9SYI
         LC3OOmmU2/SQ8tqO+Jx2wzliMdIiIwJ4a9lHyTjge+D2Ri2Fcv/9Whj563+nT/a7xds6
         zTVe4bpI0cruO4wpXbWeF0FzmXANm0XiZwIkqOMX0kFM3mzr6QjPRk2nhHC3Tj2hvtee
         +p5oE41T/UdLWoJIJS3jQn99hSFTP+Tnt68ufufzGT5kJvb+VbFrcZMN/dNHaS5daKyi
         qgS4RxgwWVV1J0RB5+VDdmd6TXPK8eO5W3LjDOJOCUnJuYR97QDzD+stomwLVkfuoFKK
         ByHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693864929; x=1694469729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMaoJXfSUTGUV6QmpzTNhrGbBGCZavotUULkh8MgnQA=;
        b=lJAv79o0yARWIusORWj/+Zi8C+BVdkc5/69zduo9mwKAkI369+CroG4Aoa2V07Hhb9
         Z93iDv8qldV/lwIbgGhHtYEqyBpT4OqDr3SSh0XuiVeao5qEcp5T4leA7HSrfUBUdw4p
         cSM+c8wBZWY3HFk6pXj36vdilXZgAnJ8EzLBTjRge9ftx8J0VhmUQKKm6IGuayepEAra
         UagiF3vH1wHpMYH46dPWPHzKXXnh8Ljzl9PgUrh6rT+krjuBo5wT5qPaC3p/gmQR8mFx
         zBIxHzyeSLQipcnQrcjO11Ry2vNQgWtQMKkphADjkJxCAnpVLoVu66cXNXMoi6CuO4EI
         O+WA==
X-Gm-Message-State: AOJu0YwV3IHr5ydch/TJkJVU3/sDtTWJ7cRdPLB5BJs6FqSDsLtHV+nh
        KARCO18oHEfdvongLktq4tI=
X-Google-Smtp-Source: AGHT+IGawf0GPRwtAfFkpDQtSL1yhynnboG0lTJh4YRpwT/zygNcLkKKHHMi4UoM8zi+B7IkwpNUGw==
X-Received: by 2002:a17:907:b18:b0:9a5:e441:4cf2 with SMTP id h24-20020a1709070b1800b009a5e4414cf2mr7473042ejl.58.1693864928721;
        Mon, 04 Sep 2023 15:02:08 -0700 (PDT)
Received: from thinkpad-philipp.localdomain (pd9eb53b2.dip0.t-ipconnect.de. [217.235.83.178])
        by smtp.googlemail.com with ESMTPSA id lj17-20020a170906f9d100b009829dc0f2a0sm6692456ejb.111.2023.09.04.15.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 15:02:08 -0700 (PDT)
From:   Philipp Rossak <embed3d@gmail.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>,
        Haibo Chen <haibo.chen@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Philipp Rossak <embed3d@gmail.com>
Subject: [PATCH] iio: adc: imx8qxp: Fix address for command buffer registers
Date:   Tue,  5 Sep 2023 00:02:04 +0200
Message-Id: <20230904220204.23841-1-embed3d@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADC Command Buffer Register high and low are currently pointing to
the wrong address and makes it impossible to perform correct
ADC measurements over all channels.

According to the datasheet of the imx8qxp the ADC_CMDL register starts
at address 0x100 and the ADC_CMDH register starts at address 0x104.

This bug seems to be in the kernel since the introduction of this
driver.

This can be observed by checking all raw voltages of the adc and they
are all nearly identical:

cat /sys/bus/iio/devices/iio\:device0/in_voltage*_raw
3498
3494
3491
3491
3489
3490
3490
3490

Fixes: 1e23dcaa1a9fa ("iio: imx8qxp-adc: Add driver support for NXP IMX8QXP ADC")

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/imx8qxp-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-adc.c
index f5a0fc9e64c5..fff6e5a2d956 100644
--- a/drivers/iio/adc/imx8qxp-adc.c
+++ b/drivers/iio/adc/imx8qxp-adc.c
@@ -38,8 +38,8 @@
 #define IMX8QXP_ADR_ADC_FCTRL		0x30
 #define IMX8QXP_ADR_ADC_SWTRIG		0x34
 #define IMX8QXP_ADR_ADC_TCTRL(tid)	(0xc0 + (tid) * 4)
-#define IMX8QXP_ADR_ADC_CMDH(cid)	(0x100 + (cid) * 8)
-#define IMX8QXP_ADR_ADC_CMDL(cid)	(0x104 + (cid) * 8)
+#define IMX8QXP_ADR_ADC_CMDL(cid)	(0x100 + (cid) * 8)
+#define IMX8QXP_ADR_ADC_CMDH(cid)	(0x104 + (cid) * 8)
 #define IMX8QXP_ADR_ADC_RESFIFO		0x300
 #define IMX8QXP_ADR_ADC_TST		0xffc
 
-- 
2.39.2


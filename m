Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF0277CA57
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbjHOJXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbjHOJWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:22:23 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC9A19AF;
        Tue, 15 Aug 2023 02:21:53 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso8580903e87.2;
        Tue, 15 Aug 2023 02:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692091311; x=1692696111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mty89Zsn743QA235zlInIryimxQpDYJ277HbsbXhdWg=;
        b=m3yx0WGmf+HfuxGalGmrrQxAwumeWYg2dYkjAl9VgThDO6j8+PLy8YyX0K/uCFc7HD
         JV/2Sb+zL4P3tMoO67fSdnfcH2FCQVT04NW+98IX+6l0SCwx4UoM4leYFvis4IlvrsuC
         jY8hZD1kTTKesHHrV+OISKuxF34LnShdgfy6FDUH11J4dI+9KwumLlb9ya7zcbq8qar/
         QM36P6vzlSP+Yb2z4o60A3dBSG0+lHNE3sHnS9cjDvXrKKwN/du+NDGf/wc9yeAzDSpp
         MqP0EpF1F0LGhrG/oHjddJmm7sOMW3fSHiXsLolPCSoJNtUik3pRaTGGrRemc/LpzlJJ
         t0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692091311; x=1692696111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mty89Zsn743QA235zlInIryimxQpDYJ277HbsbXhdWg=;
        b=CDExglijKaIeM/ytlZbRn5ACTTH/cI7CI2W2l2X/pgKqwEXNo8dCXUioIXAhv5wvYu
         l05tXB8eNxZ/raRI0lUUrNQGbk8bum6c7qNq/6vsWhuQ4ZB2Gd9mRDr7FSLPzAtJwo7p
         +Z5j5+Pl2AGoKFnUk889mCaEJLqnnmz2NSYXQvd2jTKV/mnH0ZdlQEA5JfjAsx0D6m8s
         avFwIlqVW+K03stgiIeqjWvmOLmHaNtlM7or0tkblIBFN0lyqLcqN/0Je3a6RVIayX3Z
         atySHa6nrsg0FnpVgMZ2QFps9q3F4wEHTrDKIO95sYs83AD85K95FfFoiN2FmYe5+4hW
         Hc4w==
X-Gm-Message-State: AOJu0YyH6mF7l7HGMG53y6izJcom2IBFPbZ0RB3H4t5GuIeQ3zrhC2F3
        MA4NKdR1KGLMQPQkYaNemhs4tyNYnBwVBgSU
X-Google-Smtp-Source: AGHT+IHqwcMfn+ov/HY3PvEe3qzwNYh+mZoAO2ekpyvjQAAlCFVl4ozDxPwwO9IbXdqt1b/CTvWU6w==
X-Received: by 2002:a05:6512:4004:b0:4fd:fef7:95a1 with SMTP id br4-20020a056512400400b004fdfef795a1mr9543796lfb.53.1692091311136;
        Tue, 15 Aug 2023 02:21:51 -0700 (PDT)
Received: from DESKTOP-BUQC5RC.localdomain ([178.155.5.98])
        by smtp.gmail.com with ESMTPSA id a5-20020a19f805000000b004fb9536bc99sm2353569lff.169.2023.08.15.02.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 02:21:50 -0700 (PDT)
From:   Alexander Danilenko <al.b.danilenko@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>
Cc:     Alexander Danilenko <al.b.danilenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mason Zhang <Mason.Zhang@mediatek.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] spi: tegra114: Remove unnecessary NULL-pointer checks
Date:   Tue, 15 Aug 2023 12:20:58 +0300
Message-Id: <20230815092058.4083-1-al.b.danilenko@gmail.com>
X-Mailer: git-send-email 2.34.1
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

cs_setup, cs_hold and cs_inactive points to fields of spi_device struct,
so there is no sense in checking them for NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 04e6bb0d6bb1 ("spi: modify set_cs_timing parameter")
Signed-off-by: Alexander Danilenko <al.b.danilenko@gmail.com>
---
 drivers/spi/spi-tegra114.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 488df681eaef..2226d77a5d20 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -723,27 +723,23 @@ static int tegra_spi_set_hw_cs_timing(struct spi_device *spi)
 	struct spi_delay *setup = &spi->cs_setup;
 	struct spi_delay *hold = &spi->cs_hold;
 	struct spi_delay *inactive = &spi->cs_inactive;
-	u8 setup_dly, hold_dly, inactive_dly;
+	u8 setup_dly, hold_dly;
 	u32 setup_hold;
 	u32 spi_cs_timing;
 	u32 inactive_cycles;
 	u8 cs_state;
 
-	if ((setup && setup->unit != SPI_DELAY_UNIT_SCK) ||
-	    (hold && hold->unit != SPI_DELAY_UNIT_SCK) ||
-	    (inactive && inactive->unit != SPI_DELAY_UNIT_SCK)) {
+	if (setup->unit != SPI_DELAY_UNIT_SCK ||
+	    hold->unit != SPI_DELAY_UNIT_SCK ||
+	    inactive->unit != SPI_DELAY_UNIT_SCK) {
 		dev_err(&spi->dev,
 			"Invalid delay unit %d, should be SPI_DELAY_UNIT_SCK\n",
 			SPI_DELAY_UNIT_SCK);
 		return -EINVAL;
 	}
 
-	setup_dly = setup ? setup->value : 0;
-	hold_dly = hold ? hold->value : 0;
-	inactive_dly = inactive ? inactive->value : 0;
-
-	setup_dly = min_t(u8, setup_dly, MAX_SETUP_HOLD_CYCLES);
-	hold_dly = min_t(u8, hold_dly, MAX_SETUP_HOLD_CYCLES);
+	setup_dly = min_t(u8, setup->value, MAX_SETUP_HOLD_CYCLES);
+	hold_dly = min_t(u8, hold->value, MAX_SETUP_HOLD_CYCLES);
 	if (setup_dly && hold_dly) {
 		setup_hold = SPI_SETUP_HOLD(setup_dly - 1, hold_dly - 1);
 		spi_cs_timing = SPI_CS_SETUP_HOLD(tspi->spi_cs_timing1,
@@ -755,7 +751,7 @@ static int tegra_spi_set_hw_cs_timing(struct spi_device *spi)
 		}
 	}
 
-	inactive_cycles = min_t(u8, inactive_dly, MAX_INACTIVE_CYCLES);
+	inactive_cycles = min_t(u8, inactive->value, MAX_INACTIVE_CYCLES);
 	if (inactive_cycles)
 		inactive_cycles--;
 	cs_state = inactive_cycles ? 0 : 1;
-- 
2.34.1


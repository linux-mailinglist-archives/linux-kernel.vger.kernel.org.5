Return-Path: <linux-kernel+bounces-12054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B305681EF7B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47B01C21167
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18A545BF8;
	Wed, 27 Dec 2023 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tp8eydQe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B590C45BE5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d5aa35b60so11414275e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 06:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703687769; x=1704292569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k6zNqclS7J7Qh9osUCxcjQJENaFPWi0hRNSckfQHr2A=;
        b=tp8eydQewNHvl4cLlXYMMB3vUKeGbvDLkdrzJj5kJYqcPZdy3HKwtLEUiEcPoblfVF
         nOFEDc2+xNJYIl6aujnRHjbOPAc40eNQEzFqPMVuKdY5wZUp//TJ3bqzkJlbQB7kYZqr
         Gi0ja8tG916amDIMwCtA98Wh+rTDSufeeA0vuFW+qK9vBuGTzeLVvIDbK/F3e4HqaeF4
         R9EvU8Q6J2KkbVtBGJwwCnHAPb14XYh6XxlvR7xbBeP1Yu/NjMTEyltVlDvunlKieAPi
         0eqkfV+sqdbnCCKjehpKiMkWcsZ6iwhAuEUuzzdsS+aARahjWU+qiZg42Lt5ShX8dZA2
         15JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703687769; x=1704292569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k6zNqclS7J7Qh9osUCxcjQJENaFPWi0hRNSckfQHr2A=;
        b=DzTEih4figIQlcN1BsyWje953PZcGsk8x4xur/fhtPN3g6oEOmGC74VLjg3gLlZqek
         NcGtkGgzUpXYDUi5RqGnevzupiu+sinKx4hX38AqXtcPoNJtWapeLRu828xD6t2xlQDg
         4ATW7TV1Ty22ZAgeDcyvQV9DbqkKWN2sZ2VABah258+1IB0/SxvLmVK/ZfY9sTAYik+f
         sjSblUPhBbBhwJZql+rYxgmImFDY0NBsA3ch8tR3D/AYWEAXMo695CUmNlY9lplDnNvp
         Ri9hkcn4hlnjgVIO2DGo7Rt6h9ixGsIlvBgOvYqq7zfxRSJfneLT121vumS8+Z1Ro7+r
         6oLw==
X-Gm-Message-State: AOJu0YwhLMBx4iBc8/nAy0SRb70pSK9bXkX11EPOCqrR65ht4Hz5aW7k
	vWOg/Ja3XPvcpv0r7dWIiZok0QDomNuozQ==
X-Google-Smtp-Source: AGHT+IFwG8UV4lJV8XAn3gHqm5NfmlKcd46dS6QpUygLIozQ74rCGCj7SlyeDim5yGrro+kAh6lC3Q==
X-Received: by 2002:a05:600c:4d96:b0:40d:5c83:c74c with SMTP id v22-20020a05600c4d9600b0040d5c83c74cmr462301wmp.38.1703687768955;
        Wed, 27 Dec 2023 06:36:08 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id i16-20020a05600c355000b0040d5a5c523csm5686544wmq.1.2023.12.27.06.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 06:36:06 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: tglx@linutronix.de
Cc: kernel test robot <lkp@intel.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
Subject: [PATCH] clocksource/drivers/imx: Fix -Wunused-but-set-variable warning
Date: Wed, 27 Dec 2023 15:35:46 +0100
Message-Id: <20231227143546.2823683-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All warnings (new ones prefixed by >>):

   drivers/clocksource/timer-imx-gpt.c: In function 'mxc_timer_interrupt':
>> drivers/clocksource/timer-imx-gpt.c:279:18: warning: variable 'tstat' set but not used [-Wunused-but-set-variable]
     279 |         uint32_t tstat;
         |                  ^~~~~

vim +/tstat +279 drivers/clocksource/timer-imx-gpt.c

The change remove the tstats assignment but not the reading of the
register, assuming the register may be a ROR (Reset On Read) which
happens in the driver's interrupt registers.

Fixes: df181e382816 ("clocksource/drivers/imx-gpt: Add support for ARM64")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312231803.XzPddRa5-lkp@intel.com/
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-imx-gpt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index 6a878d227a13..489e69169ed4 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -258,9 +258,8 @@ static irqreturn_t mxc_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *ced = dev_id;
 	struct imx_timer *imxtm = to_imx_timer(ced);
-	uint32_t tstat;
 
-	tstat = readl_relaxed(imxtm->base + imxtm->gpt->reg_tstat);
+	readl_relaxed(imxtm->base + imxtm->gpt->reg_tstat);
 
 	imxtm->gpt->gpt_irq_acknowledge(imxtm);
 
-- 
2.34.1



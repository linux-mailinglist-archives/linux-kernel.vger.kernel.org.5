Return-Path: <linux-kernel+bounces-47263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC02F844B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3751C223C8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8843B187;
	Wed, 31 Jan 2024 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qi0hhmFC"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D715F364CA
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706740652; cv=none; b=Vp1n5w1oH8gGfKdJGy3av/NsvtHlNfwRrSimPwxHje5HlfF9nxp5LeBaEOhLuA80+WUtRuiqlTO6nZ193zQ5Tn8FivtUkYacDlMnEPrNE+kGyNwGhksKmQCysYwQ79i5frAKJ8Fl8/aMig0qwDPArUF9tTBeF1on+ooL0BffqNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706740652; c=relaxed/simple;
	bh=ionRqyl3Q5D/E0zHp+ahunwML94VNC0kY+YxXQFZSkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z00cM7EBOw165qTZYxiPjj8BBv3VMzVfI88OxvTtHUxuZ4465KmHAkJndRp6xDJycXwkWEFm4wDTNgWirtqk07sW384WnD/DjyfRCdTFB2fLKY3JwxLxfa87tFTznKiVfi9avidyZsCjWnzVb90h3Qyg5IoNzlDpqmH08czai0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qi0hhmFC; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5110fae7af5so344313e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706740647; x=1707345447; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qflVRgaLPtLFWdxTtNrz5ppvd0xQoWg+EunwCWy5ijM=;
        b=Qi0hhmFCsNkMp/q47OpcNF4m/IKeKpLiaTFE3uxMVD8NDNEi2MjxFIzCeREc5FT6t9
         7Zcva/+qvRZW7tOLIj272qhPEMA68ZtK8iASx4B2KkcGcRHxjuZREsYZ7fEzB60OkSy4
         4XMVJ1Y9iLq6RwNvun1IRulYFx8AVPydYc62oxAcuEFUEwhPPy8Tqx8oHtYt74to9b4e
         6m1Tgy5TDoqxu4CzlZcG+9IEnIopmig2y3c7FClz2xJHtRyCrQqwxVlp3Wq0sQxSdP3s
         Mb3Iq5qLHpnE5chkoU4wzPNzIqqQzU4rpn3tOC3sq2dDl5TwWPBVgvJwunp1L7NSyUh4
         lgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706740647; x=1707345447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qflVRgaLPtLFWdxTtNrz5ppvd0xQoWg+EunwCWy5ijM=;
        b=AbDB+0YM2IxTBR64Lt/hp9gnWBd5KWCFpCaUfyuGEHxlZGBLXQmsjVextYwvfcsgSa
         OEb3uX3htvaCRBLHCkwnHBpnRJay/Rs8vkRZkEa/oRO7E4vOpxtjVY3JLdFIJ/zE0DX9
         3XHUFeo2t8F6jlfhAl4bYHevVO2ghnSVn1sFFwnD/hjI4Kc9tXTjdtIaFzMrUkz8S3J5
         9FEBkX49KVbYSJmPjobuX2zQgZvBteS6MWty2O0EIHAtHfrnDTkqmjeJx1h3A4ItljGu
         /pYsIEPnR3wq8cDI4GrxzLYRa2q5r0SiHbBpeo3BnYcQhWKntjzJppI/Vd6Svvs9t94e
         xtmw==
X-Gm-Message-State: AOJu0YyTcR+9NeJENInYA7Nci9KuTCkMYN6LutLQqye+9+gPpmZym5ZV
	cHiyVJkeyX/YvDVF8cfDIrtJk3ckk+xM/js+j87JF7Uy3TmeaLSmrOGtNRdTBJU=
X-Google-Smtp-Source: AGHT+IHP0c4yw2cb1tH3KkasvEXgTEolgi4dREEGX3xay5jvaVY2tiuki6tuV3gEcKIvvbPP+uZjEw==
X-Received: by 2002:ac2:5b05:0:b0:511:24da:ca21 with SMTP id v5-20020ac25b05000000b0051124daca21mr658246lfn.9.1706740646978;
        Wed, 31 Jan 2024 14:37:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV7zI291CvMzGbV4tDVdfrqcKTOar2yqyKSFlxpyCD7d45AtujJIIbroRHBkJHsWBnjyHD6BlU8dpKV4N/pA7kM0EzB3ZApSk1Rt22Xv3wQ7nxrcWzbGQAc8/ZyYgeXLD3UiXESHU1q/j9vCWMMHwGW906VzXWk42CMbFZb//wPshMvslQWHCE8lADQEVs311nLGpjkwdmw73TpScJY/5QBf2eOCiFDOuI9TgYAAC3lKhG1c1YtZnmouR5WhO3AhZZ6Kidh/GPd+i8AkA24WYbHNhAYvJTB5v6PFIsFzvfxlA74Kzo1HgaCReCd9ViVglwSxzSEPdBkwqwmBFSUxTxKJirKdN6SQ/jnV+G2qmeCdg7Em8I5SERp5DUDZ7fROS5f5D4Is60LxNoC37mKVOL7ix6wuP8oVg6wLGr5yTOzgmwJZS2N63JvHay5VcY1Hk3AaKkMoBT1Baurdw==
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v25-20020a05651203b900b0051023149df3sm1976021lfp.248.2024.01.31.14.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:37:26 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 23:37:21 +0100
Subject: [PATCH 2/6] wifi: ti: wlcore: sdio: Drop unused include
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-descriptors-wireless-v1-2-e1c7c5d68746@linaro.org>
References: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
In-Reply-To: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Kalle Valo <kvalo@kernel.org>, Arend van Spriel <aspriel@gmail.com>, 
 Franky Lin <franky.lin@broadcom.com>, 
 Hante Meuleman <hante.meuleman@broadcom.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Srinivasan Raju <srini.raju@purelifi.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 brcm80211-dev-list.pdl@broadcom.com, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

The file is including the legacy GPIO header <linux/gpio.h> but
is not using any symbols from it, drop the header.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/wireless/ti/wlcore/sdio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
index f0686635db46..45dcc7b400c3 100644
--- a/drivers/net/wireless/ti/wlcore/sdio.c
+++ b/drivers/net/wireless/ti/wlcore/sdio.c
@@ -16,7 +16,6 @@
 #include <linux/mmc/sdio_ids.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
-#include <linux/gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/printk.h>
 #include <linux/of.h>

-- 
2.34.1



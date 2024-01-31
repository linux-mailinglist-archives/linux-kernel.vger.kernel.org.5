Return-Path: <linux-kernel+bounces-47261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AA7844B1B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB500B276FD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5F23A8D0;
	Wed, 31 Jan 2024 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AjBzFK95"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EE33A1CB
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706740648; cv=none; b=nWgY0j8U/CppLvpxRfRv4f3Dgja2EivoGxT/IrsoxllYijkqF/0WKtzcdtFrdrFAKD8BEFjE+dwCfL2PQ98PukKPTwYozg1azUbejp6VuFrlvRQdTWM8g229d2DS7P3tOiIZLEdSx9A35Yspsc/TyuCFAgofBtyidZ6onXqrGx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706740648; c=relaxed/simple;
	bh=GHCslkMbeb8cqNbZMhNeG8BDz/DVNH+7BbzW3dVkGy0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GZKOiqSZNy8m3xw2TWJL77NqO7P5VLV1U5xj+BnzZgw9malp4NqHzjsJtUOZYxaB23iRenIjviRzE8srTEd00KHVpunh7g2T3+pGWqAnEH042C2FAHDvbNhYKtzqsWrCHaDY5yzrrAy6tUuzFJAwWyZap3H4boEf2KMyMtZgPEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AjBzFK95; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5111ef545bfso427061e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706740645; x=1707345445; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gjqkz5/4fOYK8UlYJhkvBOZbQ3T8J2UbD1rT1LvGIH8=;
        b=AjBzFK95eec1gfYn08jWdljI+JYfhAJpoIkTiIMPnB3UwhvjSNUHTHEZoSbBK4VbU4
         hUz47OrysaFBDxFwE+Ep9aLd53gALGmNDMqeHXyoVxnRMDoRdL3lOiav10k1wJBehvXU
         8jcUvQdESVRBn5nECP074IazmyNJNFUNxxoUp3g1XGPQOnmQyIE3SPrqMbbQuA0dPll3
         g+aGbtPjaHivChS7PXPImqy6NhF00JB2ZVBhIniGwDIk4WeHvmc3LytGzzi1igwDNrga
         dtTlM54RRr4+zo6YH1LFpWZT13TW93bB1Uo+vbLT6JNPny0PreTBuKRKXvBZ0Xv8ioaA
         oEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706740645; x=1707345445;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gjqkz5/4fOYK8UlYJhkvBOZbQ3T8J2UbD1rT1LvGIH8=;
        b=hYUKH2mX4YQMMoW+cvFi6NTMslz3AfoP9p74JB8Io+v62R6LV09I6kNhCPd5VzaIh6
         cHamJV6buNtmgiHI/XVIpJHv6ixRA8N2ixtylcj2b+/im2+l3mKZ04THf6fAcMos5cSX
         F/MftEXQyDV4KMv77RXbkjpBKDKh35fQ6thWDaEpfsENGkOmgHF1iKy4Qnu68U+aiSns
         yaB4P5Z98uukMLXHvMOu2Zwm/kHyD89Rk2ghq2a389uOszj1js+iVHtkKVVrhBVETVb/
         seVgBmqD2m7Q4CGlWbLG89/bSk4Y+8j7Dn4j2XcvtQIxm+PjPV4uxs/u3Mdz1x73DtD/
         2UYw==
X-Gm-Message-State: AOJu0YySV7zSZ7WBpFXRZlHLA6HT7bqC8+xGgBI7VzrLvaNjTy0Luu7K
	jpU9GhBycFzF5aq5qJ34px+sYdHbTSHeTIahObpr3iAjilJCvvJXYgPYfBBRGMQ=
X-Google-Smtp-Source: AGHT+IEMIuI5hvAZEuoBTltAZ0X1MJbZczlIpQv+KBqzvjJT96h4zzxFmvPW1XHVD1WAjd36PDy46w==
X-Received: by 2002:a05:6512:3b81:b0:50e:7b9c:3ed5 with SMTP id g1-20020a0565123b8100b0050e7b9c3ed5mr724096lfv.50.1706740644933;
        Wed, 31 Jan 2024 14:37:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVzuwlnfDtJNqGCVUREN76vukNns1U1VXlZ0fzehBTrVJu+DHgyhn0h23Etnk6UySO0+66Kv9XbvRT9WC8hrH2TfQWzOfwogz6GZwb/g3264TBFzxCCW8QN6xU/QP7caG2fe8dRqCVpX6kYqj3DpDiFf3krg+fugNquXA/LEcFTSzzrhWl0YQZuOfHfdZTag6Ewh86qRqaV1hDFiYZ5rrhL4x1VMO68vCjCnrvpBg3RMSHsrVQPp/MKqGlRpqAJKQvk5tFgBMG8wOrkdl2Jt6ObkO5lgZSCRHH76QD7GoNbil1cA/71/hFP3gD0nluZWKBmGJbTcqFiutP1grQQOPvrcYdEEL4YSPZcVoquzI8b6AczcWYJOnrg9Q0zxgt2hdqQGP7u1+v0TCIs4flHvjdGFkcrQOc1AoHrGtEPj/FL60hhVpGx3j4jFAOa0qSor6joQO3mMrXzYGN7jA==
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v25-20020a05651203b900b0051023149df3sm1976021lfp.248.2024.01.31.14.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:37:24 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/6] Convert some wireless drivers to use GPIO descriptors
Date: Wed, 31 Jan 2024 23:37:19 +0100
Message-Id: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ/LumUC/x3M3QpAQBBA4VfRXNti2cKryMX+DKa0NCPU5t1tL
 r+LcxIIMqHAUCRgvEhojxl1WYBfbVxQUcgGXem2qrVWAcUzHefOom5i3FBEuS7Y3gRvXWMgpwf
 jTM+/Haf3/QD/zjAJZgAAAA==
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

This converts some Wireless network drivers to use GPIO descriptors,
and some just have unused header inclusions.

The Intersil PL54 driver is intentionally untouched because Arnd
is cleaning it up fully.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (6):
      wifi: ath9k: Obtain system GPIOS from descriptors
      wifi: ti: wlcore: sdio: Drop unused include
      brcm80211: brcmsmac: Drop legacy header
      wifi: mwifiex: Drop unused headers
      wifi: plfxlc: Drop unused include
      wifi: cw1200: Convert to GPIO descriptors

 drivers/net/wireless/ath/ath9k/hw.c                | 29 ++++-----
 drivers/net/wireless/ath/ath9k/hw.h                |  3 +-
 .../net/wireless/broadcom/brcm80211/brcmsmac/led.c |  1 -
 drivers/net/wireless/marvell/mwifiex/main.h        |  2 -
 drivers/net/wireless/purelifi/plfxlc/mac.c         |  1 -
 drivers/net/wireless/st/cw1200/cw1200_sdio.c       | 42 +++++++------
 drivers/net/wireless/st/cw1200/cw1200_spi.c        | 71 ++++++++++++----------
 drivers/net/wireless/ti/wlcore/sdio.c              |  1 -
 include/linux/platform_data/net-cw1200.h           |  4 --
 9 files changed, 82 insertions(+), 72 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240122-descriptors-wireless-b8da95dcab35

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>



Return-Path: <linux-kernel+bounces-160075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC628B38B9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93B7288C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867DF147C90;
	Fri, 26 Apr 2024 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uF9Ti56C"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F3B824B3
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714138924; cv=none; b=WNhRNQNMIVkw/JoNWrMxVvaN1qBVtTcckw5HoAANPMFu5EtBiV4Cnq5OfLoiZFRNPG3bsckr9R3qHT10xAfP+f2jOL4EMhiy0kjxPB0vg5K/ejRUUy3Ie9OfTfrhV+rVHk8Ymjghht0BMeZaZ7kt1EkemoT89ZgnKvfZpFjV9SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714138924; c=relaxed/simple;
	bh=PUHy0Ja0SSf7b3oUZ8tvjV0ut6Sih45TvCcp2ik+qp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cp9JH3WfdnoFQO9jbOzQFodZ3ubUmu3KsA3F0rAT/DgUJMmRwZmqe3kUbxx487z0t+mTyxNqbEFvjLUqc4LyeHPPs8I+Ns9qHtD9i0cCa0I2N4OVppAz7Bodzk0BV9G1sBBXHl9XO9DgSp8QQo+hq8yhtyMx5+0NXGBfX5pOLi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uF9Ti56C; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5196c755e82so2747335e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714138920; x=1714743720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZoPAqs/FsSRU0VmqAIyUDeL5k+oeAlm1vs0Pwv/KPc=;
        b=uF9Ti56C1iKaISE/kW6VuYIXE4ePQZ4v0xOVK/BtJuBvf/vVS1yni0csy/Ruhf13v2
         Fep461x2gfSm0Vamys/+BPgoaHL8YqtqBvVelV72I0HB5jD8fz0XyiU+Qd4MQRSvhL92
         rbDpoyWZez8deLZX8jVVopQxsmHLSUy8SashrP7ISvRkbkvDMlPbzv+SjZK+qxTWFrpk
         DGddpoBJBtZCq/z8pYhA692wehp/qC337fYDpMa5budSa8E0U2UIiAWbhT0i+Kn+BC06
         D70SrY3aJg4o8Cj94B+qEcmCaPlyIgbuRDftaKSCu57OhPbQFZ1V9O6pLqmqiOHtGzDR
         TL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714138920; x=1714743720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZoPAqs/FsSRU0VmqAIyUDeL5k+oeAlm1vs0Pwv/KPc=;
        b=sYQG2oUFHrZFwWtDYT5hNUlOaw7WNa3JHO5BaVtCKXErQCSyJsz5ePuReSvK87T5fV
         fsM41P3qfLyfQWKaW8eTbGRRRhqM67qxDxm6zDY4BMWxmixqamp/d/tTzoPnsEO9hS1I
         aq2u8xABQ5eW5devoL+PRvf+aPJ/1JKNLjwbfqH1TzAyoBj+bI7j029lBwvMfRVwXO1E
         NSU4j4H4uCNbsfrlWnslXQ+NYRVensj4D/Zq+T5GjM0ReUFOPqBAKLlkW0gdoeRj6r5+
         qZQ+hkUBnAU6vxB7UWwmceGqu81YdBSEBIXiJHdswdl+5W8EXmyBIlI8v+mHRlGFboFf
         96JA==
X-Forwarded-Encrypted: i=1; AJvYcCU1Gfkp7BVBvbUqiXowKu8bzEWi0GVPK6Ww+6L6b1M/6ggZYyyL1lOYmwH3RfYI7zMFAePYO5DR2ZcuH184pjjZXR2UVHnLRmw9UJdh
X-Gm-Message-State: AOJu0Yy1JB1pHOr/XwpXddE1sdKBuPDzeG6zwULR+mPQR0GEGottxFyA
	u+bHdDxhUIum378AOBZ0AC0vsgdREjMSTmPgKn3CTAPiN49JDCGCUBWQgx8XbWZ+UyXEWGeISaa
	h
X-Google-Smtp-Source: AGHT+IGPLKZcerp3MvuJR5uN1npoHSmtLy+7WTMWioCuEvXXFNm30DQl5IWvmOoTb1lmO9LmLUtnzw==
X-Received: by 2002:a05:6512:3609:b0:51b:7c36:da61 with SMTP id f9-20020a056512360900b0051b7c36da61mr1513968lfs.56.1714138919541;
        Fri, 26 Apr 2024 06:41:59 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1926:f73e:8b99:1c0a])
        by smtp.googlemail.com with ESMTPSA id jg1-20020a05600ca00100b0041b25a70a85sm7558852wmb.30.2024.04.26.06.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:41:58 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH] ASoC: meson: cards: select SND_DYNAMIC_MINORS
Date: Fri, 26 Apr 2024 15:41:47 +0200
Message-ID: <20240426134150.3053741-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Amlogic sound cards do create a lot of pcm interfaces, possibly more than
8. Some pcm interfaces are internal (like DPCM backends and c2c) and not
exposed to userspace.

Those interfaces still increase the number passed to snd_find_free_minor(),
which eventually exceeds 8 causing -EBUSY error on card registration if
CONFIG_SND_DYNAMIC_MINORS=n and the interface is exposed to userspace.

select CONFIG_SND_DYNAMIC_MINORS for Amlogic cards to avoid the problem.

Fixes: 7864a79f37b5 ("ASoC: meson: add axg sound card support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

NOTE: This problem was found while toying with a minimal configuration
which disabled CONFIG_SND_DYNAMIC_MINORS and DT overlays. Overlays
prepend nodes instead of doing append. This changes the order in which
the links are parsed by the card driver, which in turn changes the pcm
numbers. The userpace pcm number then got over 8 triggering the problem.

 sound/soc/meson/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index b93ea33739f2..6458d5dc4902 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -99,6 +99,7 @@ config SND_MESON_AXG_PDM
 
 config SND_MESON_CARD_UTILS
 	tristate
+	select SND_DYNAMIC_MINORS
 
 config SND_MESON_CODEC_GLUE
 	tristate
-- 
2.43.0



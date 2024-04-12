Return-Path: <linux-kernel+bounces-142518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C07E78A2CB1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4C8289964
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC8B20310;
	Fri, 12 Apr 2024 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gl1lzpBX"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1741F32C60
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918546; cv=none; b=ncQrBNOrGoMgp3dfvpzlU7YP/h0HtWgnU4N/c6L3DjMEYFG829aOAZDJOtA1T6DAiBZfQbm6HG1u8eCo/4K3e9SdSnJzxo+o9a/Api1TXd/+pYDSgbFHqL+A/xezB+V/616ipc/TBZ6jsveZwnx2jhHFprGSH+5J5iK+lPH57fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918546; c=relaxed/simple;
	bh=UIokhiS5Rj3MPlQ+/XRMF9ng6qEkITKXuZOWx3vpGv4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zr7WzZNlKGOrOqD1cZuauDWkq0GiLsvmc53iTxCBcj8dY7lAqJ1B7AnOJIOJdGLrrqYw6k5wuDeeGp/yqZN5UvYAI4uNEpWImXbQdR/v8jg5yLTTWmobLGd6/gXzyZyBFZrl4nRyumOOgywFlWjHIKa/JV4iI7qtpn1uboaHkfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gl1lzpBX; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d1ecaf25so936684e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712918543; x=1713523343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0yzFF7XLEaVBUn6zqt63Jmp6pMmz0w4BTjsr5ZlkzWs=;
        b=Gl1lzpBXgTsaFqFsrX3lBEI8SggK4N06IMkg7smvtCkA5kGOdnjGKYtNVGEEIaD4u3
         0LrMk2t+tOH8G0PvZQY+UdUI0VnCCyWfIBODAdjz0aN+Je0XYvorJP6qzBCEVGZrylGj
         tAh1gIvpCOxzg+AXb3maMxxVlugEQDFnPNcQ/RSFbGsQSnEZmFOIw4s/geSl3rywlY2A
         s2YpCKZLLNafI89Zn+onk7oEX/Tdhssg7TYwjnYdfeUgToWqNceZQkLtpqkYmxdFy4m7
         yJFZdRa0CZngOx3CDzWBNqQTS3N1ehaMe3YU06KgwmcZ6Lms0JRT0W3bQbkuymi+lW2K
         ppxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712918543; x=1713523343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0yzFF7XLEaVBUn6zqt63Jmp6pMmz0w4BTjsr5ZlkzWs=;
        b=dYAwkX/QbdljcgJUlPZIogxi8HEdfyVME01Wi32KnESG7cygM6wm8iapDEGL5yE+p7
         XwtFrHI9DC2YAp9u5roEmO77Wji+c6CViAwrhd7MZPYVLDfb+i0lnBY3Jafl0LTowK3f
         xVJS1q23gqAp8hynTfbdkDgWm6GXrVvzNhpFwjljglnbj+BDzcjPwkpZcoLw3kdXFj4o
         CNhxTA9dTHO4VwpBK1UJYnrpPVYPasDne2EUEfakIWd7i6lHNgowF1aMhf0TcrhFTaHQ
         Rgv9oJeij5BACV36hDxBOaPsufUYqk0VTboGLmehMre11Azh3io8lyf5CFD1CrdAvouD
         YV7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXahlrwPoOqiAfGmYNthPr+uKg6ycyzVnKzSyCMxxv7A02rBy/I+0lAhTlX30P8tEy//O7ewR/tyOzx/be/+NBGCCcqB87eZcgeDdSO
X-Gm-Message-State: AOJu0YxqzVMjWA7m9EOUUS2dJB/hDQRfUUs/0KEnzcrYbIlAl+TwQkLj
	EfH6Y2m8YvrB9R6pnQJir2/SsvXbW/932GHTsz4v9nt+tmYG72r069CYmdzeE2s=
X-Google-Smtp-Source: AGHT+IFEu4dnjTinOwWdQUMez8s60WK/1nUwKuFkVdaWfd4AmIZ0Ku0mYf4Xc1K806sEPp0uonGS3g==
X-Received: by 2002:a05:6512:609:b0:518:9964:a7a6 with SMTP id b9-20020a056512060900b005189964a7a6mr1218lfe.42.1712918543246;
        Fri, 12 Apr 2024 03:42:23 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id v10-20020a05651203aa00b005135f60f486sm493689lfp.112.2024.04.12.03.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 03:42:22 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] pmdomain: core: Update the rejected/usage counters at system suspend too
Date: Fri, 12 Apr 2024 12:42:07 +0200
Message-Id: <20240412104208.74361-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During system suspend we may try to enter a low power-state for the genpd
in question. Let's take this into account for the statistics too, by
updating the rejected/usage counters for the corresponding state.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 4215ffd9b11c..903ea0c193e1 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1178,8 +1178,12 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 
 	/* Choose the deepest state when suspending */
 	genpd->state_idx = genpd->state_count - 1;
-	if (_genpd_power_off(genpd, false))
+	if (_genpd_power_off(genpd, false)) {
+		genpd->states[genpd->state_idx].rejected++;
 		return;
+	} else {
+		genpd->states[genpd->state_idx].usage++;
+	}
 
 	genpd->status = GENPD_STATE_OFF;
 
-- 
2.34.1



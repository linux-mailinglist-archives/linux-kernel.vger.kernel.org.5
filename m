Return-Path: <linux-kernel+bounces-2265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EBB815A53
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57BF31C20CAB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46A239ADE;
	Sat, 16 Dec 2023 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORln11Q0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AB13066C;
	Sat, 16 Dec 2023 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a1ca24776c3so523898566b.0;
        Sat, 16 Dec 2023 08:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744038; x=1703348838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYVqczyH7NXnPG1SGiVfMuDstNC9AVi+qa/g94ih5J4=;
        b=ORln11Q06AfwRwzKAvM8o7KJiraB3oCCa5aGGo5jVqP1cB4xe3f6thvQVeITtDUjq8
         ZpzYllZEIGyr7dvdHbeDud22Zch7jNU/roOaxvB6b01rscPOgp/jbDZLLgzC5IPo8yzT
         +DeYXfr4X+SyZyDBp4stQObeZGq/AgEMoWUOzRqR842CbBQnJBpqKl55AIIu6znojW2F
         l1MjzX6rWvoyrJ6gTd2V59/xMqm0wQBq4Vk0ryfIWwHsR5oqK32qeqeDVF6/e1eWR+SD
         LPF8kV/hAtVKikxKqTa0zN0cXVNrD3b3ZyOkqG6p2aI9YRemeP91euqudwiyjKP+othv
         tNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744038; x=1703348838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYVqczyH7NXnPG1SGiVfMuDstNC9AVi+qa/g94ih5J4=;
        b=F4JBGOd6YQlZmK5tMoe72XZHUr0MVycZDqd7FhPaHwBOaCCQ9nE3U3saad1ZEqr54d
         /jxW3+ZQJE6tv9MuVlbdcKkS1wcFeTNK5ds+wVLnl5nKmPIbO0sAPG7Ggp1tVR7v3Hc5
         v0rLgxKOuDkB/oAnyLYL+XCUhouAMNiJhvUtfBz4P6M10Sp1DAeo54g7ZqR9kvg3LgfN
         +UD14Xg2MBY/v9rEmWXoJMkof0nRBwSKvTf0wWGZWo8k9auOnbCEBv7EURBNHtQy9JEf
         lZvBMCxRHW3xH0cg2sPOvyH7TrwCpOubI2Zwbr9+Ukp/teMe+bEog0Yflk1OoD4nqjtV
         j3hw==
X-Gm-Message-State: AOJu0YzqEQqOiijq5wgagfLQpYS09CrLPVYDgIbrw9fHrJQ3XzK+hCHZ
	3ioGhI8yP19O3V5DOiWUyhr59MSLfA==
X-Google-Smtp-Source: AGHT+IFQguCjqhAt5YMtNc7JRxmN3MqTnMpRgT1krDRhGkQTlTpXIYTPCKozsi5nGRJMmdtgCFPTcg==
X-Received: by 2002:a17:907:12d6:b0:a23:3828:573c with SMTP id vp22-20020a17090712d600b00a233828573cmr157926ejb.3.1702744038296;
        Sat, 16 Dec 2023 08:27:18 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:e807:d345:6f47:1db9])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a1cd0794696sm11990362ejc.53.2023.12.16.08.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:27:18 -0800 (PST)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andyshrk@163.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 17/27] drm/rockchip: inno_hdmi: Remove useless include
Date: Sat, 16 Dec 2023 17:26:28 +0100
Message-ID: <20231216162639.125215-18-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231216162639.125215-1-knaerzche@gmail.com>
References: <20231216162639.125215-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The inclusion syscon.h isn't used anywhere. Remove it.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - new patch

 drivers/gpu/drm/rockchip/inno_hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index d9eb8cdc0148..62c7e2275246 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -10,7 +10,6 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/hdmi.h>
-#include <linux/mfd/syscon.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-- 
2.43.0



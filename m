Return-Path: <linux-kernel+bounces-84933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A72986ADE0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013931F26159
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6728713B7A0;
	Wed, 28 Feb 2024 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9U09kjr"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449FE12CD87;
	Wed, 28 Feb 2024 11:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120268; cv=none; b=n+w3HoWSfR/m1U+HuK6KLs26/nwe+8a5l49wvh/E5DgZj9J37h68tjCcQxsJhwzrxBQGSBf+V/tpvbNGI7LQ6NupWJS236ON8FTSTIstA7RfIuNRQwH1d6h5xap/tPYQwEmJ1anKGtnmslS3LI6P6WZEQfSRxEk9XXYc545gxm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120268; c=relaxed/simple;
	bh=WscMPhRz3gtDrK0zadY+NG7FINr3PhPGV9Yb7XNaQno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YXKqDTKDUDM6fabHxKLo6b8ccHLFYNOb3YLIxHXdqoiTdtgyNnmgLnqIe02U2TNkU7SjKfCHMOg1BN+GkRquskLoGqGD1L1MXc8lucSoUNPl73dfNO7lWmGsGV3+qVi2jXdWo+xDqfBb9Zj1sb/LHLpNpnwlHBfXapAfqy/hLJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9U09kjr; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c403dbf3adso285128639f.1;
        Wed, 28 Feb 2024 03:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709120266; x=1709725066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hFtrXUgWnMJ9NQ2PU+2dtB8bMmOfzlQTR6EQYNPIXm0=;
        b=E9U09kjrxCnTAMKfM/3tQZcZAODujfQk0CiKqFQxS89kYTlhBX7j+nbbRxjKv6KKKx
         01q2GrBCE2xE7bn+NOmR6pKqX6kJQNwKTNNLz0MbSNta6CxdRgWB5Z0NJkkMlC7M/BKc
         TLf5pRCwu9Lp9z14o7BEigk82g88cMSHiSPwboZ3EtJ+MoqQWMA6oMYbwP5RaXau1vAL
         hR3/OmpHHWXXncIlD/uxQkjCH9J+snDhbxpSPz2NFtRq09WqYjLNhmoUmeZZ88h3OKAt
         qH582CCx5WGMg5IaXL3poNF/Rr6Ovp6XQ4oFb8TeMdm9Epkszs1s7VlZJUNtAnr7nP/w
         Htxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709120266; x=1709725066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFtrXUgWnMJ9NQ2PU+2dtB8bMmOfzlQTR6EQYNPIXm0=;
        b=NTtmiHqt28MPalLYpvduDbCdCtR6aqXwG9YaOx6eOFtpWj2Efte0/jSgSPGv680X1h
         3xCOYn0p1naYvtjpFWCD0LC9Xe50+X/uL9VpIE4oFrOe4loBKhqUDJl7jUinVOSmbRge
         7gtckZdrCF+Qi+OlNvGk7D8QkcqVonfE+qI33NSCeC1SjDaSZmN3PyKYykuNWbr3nIUd
         09wXHlMc310Nk4wj+dF5laVwINR4UaxLRTmZulXuMwj1MqpG4LtCllm1SqBkjbYuM468
         aBdPJPoHrDzuAAjY04gX+CTNXHXfoPXJquU7jkpdcgV4AHZ3n7dZnU30UG7JAoOTBP1w
         ejfg==
X-Forwarded-Encrypted: i=1; AJvYcCUOVYczXvbTfxcz8Fp7gdJOEX+au7gMbSJJ0Q4ECrH+20uKklR4425RdMH/AiNSX9vSbGyAwsZJlAa3jrepbP81bCKLyAIv2Eikqm8mXqKtU5gWpraNrcTBEHEskV3Lw6a8ErWAwlkb0Q==
X-Gm-Message-State: AOJu0Yxpb7Pef+BunyjDUWM3lB/PMx6JFycd3GjIrOOOPLCjoaqhU0zO
	FcnXokDKYPpO3c1Vr1TMQQg5OsuWfggsd2BU/LZM9a98PI0l+OeI
X-Google-Smtp-Source: AGHT+IEwYOiAlwhhDwfp6MFMf8Kh9Xrgrs548zAUc51dykwi25IhwwwaKGbQtiBKAvrlGS0wowxSjQ==
X-Received: by 2002:a5e:8f01:0:b0:7c7:fc3e:6f1b with SMTP id c1-20020a5e8f01000000b007c7fc3e6f1bmr967586iok.7.1709120266374;
        Wed, 28 Feb 2024 03:37:46 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:abe6:89f4:1061:8343])
        by smtp.gmail.com with ESMTPSA id k6-20020a02c646000000b004747d876aefsm1833147jan.6.2024.02.28.03.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 03:37:45 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/bridge: adv7511:  Allow IRQ to share GPIO pins
Date: Wed, 28 Feb 2024 05:37:35 -0600
Message-ID: <20240228113737.43434-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IRQ registration currently assumes that the GPIO is
dedicated to it, but that may not necessarily be the case.
If the board has another device sharing the IRQ, it won't be
registered and the hot-plug detect fails.  This is easily
fixed by add the IRQF_SHARED flag.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index b5518ff97165..21f08b2ae265 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1318,7 +1318,8 @@ static int adv7511_probe(struct i2c_client *i2c)
 
 		ret = devm_request_threaded_irq(dev, i2c->irq, NULL,
 						adv7511_irq_handler,
-						IRQF_ONESHOT, dev_name(dev),
+						IRQF_ONESHOT | IRQF_SHARED,
+						dev_name(dev),
 						adv7511);
 		if (ret)
 			goto err_unregister_audio;
-- 
2.43.0



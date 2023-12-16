Return-Path: <linux-kernel+bounces-2264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210F4815A52
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15B728585A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7600639AC5;
	Sat, 16 Dec 2023 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0UQKqHi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635DC36AFF;
	Sat, 16 Dec 2023 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-54c7744a93fso2051844a12.2;
        Sat, 16 Dec 2023 08:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702744038; x=1703348838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVVbI3UTdjEdNjMJt0TLf0s4Teux8aF6Z8rzwOg5CSc=;
        b=K0UQKqHiw9tDZDZT/KfV2Ussx8ubQuVhxW5BWsEgjx/C7ww9K6XZlFPbAcdUYoyc/B
         B3vnOwYoIhVSD+G88UNtMxuGwxoBk2Bb9LB+u12l0xsoB6fuLxzR5E8FEx45GTNHBEmP
         v6Ej0SruINPF5rMf29jkhMa+jQiHjlOkfhmpGV5QMbYmUOjYaDvgNq8tlly2cK6sTu/D
         tswcZ4pOjMJpfILGJWeO0L/5Cs7Q0o9uD8GU6JfIhxtW7uz4N0yxjsLnepsyZEvWNM3G
         eJNU2DzB1W5KXNbB4DH+5XLPeLs04Z5X983Yq62HP2GsPYjQuVPDpnoRMteufl6ImlBf
         gYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744038; x=1703348838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVVbI3UTdjEdNjMJt0TLf0s4Teux8aF6Z8rzwOg5CSc=;
        b=C9jMjErM25zwNX9J7jVXeT4V/CTfzXyI4XZziEJZCT73DOiOwr10n3blLnfU2NrTyv
         hFIT8Fwx9YpXGoTsORkhy9geNJsf/XSPCHspW1esnwUMarf+DysZLIbkFBe/gcKex3LR
         InxUCmlx5Ft8RF6IpY58kUnlB7narvklH48S81Ww72Zztb3SXs2yq24IsVcuFQh60FxE
         qxCTIsKYNw9fG38Vgjfbg7O3MNTIu39cX1uUQpTfw43PpvJel/V7IepFQoGrSmbffxZN
         jvixV7o2BKTc7QWdFFYmaIOCQyOQXRrvIZfWqEhihxuM6fbuftOtjhSzhG9BhTHvFzI/
         W0Tg==
X-Gm-Message-State: AOJu0Yzi5ON/kzJu3GWCLL62WX4/w80Q8km830TUxQ9iJ4l2Jwu1J4mr
	lr0XVQSgo9SzJzl6NweyEogEg4DG4A==
X-Google-Smtp-Source: AGHT+IHHs7PgwtHCDlp/FqUXAIhufy7iNz+SxosjtQiOzqhHkLXHcAd6A1Uk8Np38VLThP5p396hkg==
X-Received: by 2002:a17:906:287:b0:a23:2ccc:8eb1 with SMTP id 7-20020a170906028700b00a232ccc8eb1mr368904ejf.134.1702744037655;
        Sat, 16 Dec 2023 08:27:17 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:e807:d345:6f47:1db9])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a1cd0794696sm11990362ejc.53.2023.12.16.08.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:27:17 -0800 (PST)
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
Subject: [PATCH v2 16/27] drm/rockchip: inno_hdmi: Drop irq struct member
Date: Sat, 16 Dec 2023 17:26:27 +0100
Message-ID: <20231216162639.125215-17-knaerzche@gmail.com>
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

The struct member irq isn't used anywhere. Drop it.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - new patch

 drivers/gpu/drm/rockchip/inno_hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index e37023d8fa39..d9eb8cdc0148 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -45,7 +45,6 @@ struct inno_hdmi_i2c {
 struct inno_hdmi {
 	struct device *dev;
 
-	int irq;
 	struct clk *pclk;
 	void __iomem *regs;
 
-- 
2.43.0



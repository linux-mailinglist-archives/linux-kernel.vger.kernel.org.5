Return-Path: <linux-kernel+bounces-9966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE5E81CDF8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD84285C05
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E2B39AE5;
	Fri, 22 Dec 2023 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVq0kSZ3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1841035EEB;
	Fri, 22 Dec 2023 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-336746a545fso1256661f8f.0;
        Fri, 22 Dec 2023 09:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703266954; x=1703871754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVOgOlLPAvEr0sLISb9E6/KYZz//LU2ejxtiVGPulEQ=;
        b=DVq0kSZ3Gi2uNQEj24tCvX8m5HTjKxRFhMlYeehzN2dKuam8p1auBI0t/REFkWvLjS
         /6VuLMr/vVs/8uPIEUs+xmsW99QJ+wLi2K697ZMF6OUlGRRHVbXdc1Yi7hrdDK9sPziz
         2bS0FJ/8z+3+IltDrNPscv0J7orEuxe060N/rfyHWfvDGVWSMaLHmm4CHrLs1CVuKmkN
         W6/gE8RE9j1AjVWsIEYXUrJ4tmXl41dXdb+mzR9BYW1Gx7xln8qNLWt7zkUK8oBwC0AV
         XNA8wt/dDEq+bVo3QB1jJ8ZdHx/eyU7qfxH0qamOoxivHpt6spa9lkjMQCuiY+8tw4s9
         GJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266954; x=1703871754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVOgOlLPAvEr0sLISb9E6/KYZz//LU2ejxtiVGPulEQ=;
        b=t/PRUDPpUqq4KaHEOH9giibOPvYo18HyD8h5Jx8pmBFLK30C7/BcXNfHGcExnblhn5
         KtvFnVveeXF6uN5k6l5q0UIPI/KN89iUu0J9WowCAzb29XZc4QeR+L9fq44uJ5qw2KgH
         AgOsNHWGwm4DXqWnNvBoyiHN8aWrw+3K6MFeZzPs+ei9L1s/28XDwMtpbxBQdzPJ6nVD
         xzajJH30IdWIkg2+iOQ9LwsFlztmagpuI3wqJYr2MA7X7uWdDQFsusiWuPOKyF472ML2
         SZn4vuXu3vti3L280USW4MMYiFmnDC4xstnAoNxQwBvuN9vJv3YfTEZoza7n+4LbNl9l
         3q3g==
X-Gm-Message-State: AOJu0Yy1uLkHqWEI1HefKNqtMgQtTPrWSED99uFn+M2tctHJ7rpQ149O
	6pxoHTj5ZH1GcQw3exX0+w==
X-Google-Smtp-Source: AGHT+IG0VO/bIXEiwSNnQQTPGjLRg14lP+2fe564PcKz/X7g3SD2+YUJXu7x0ci0ig2sXjCTtOJ87A==
X-Received: by 2002:adf:f74a:0:b0:336:8030:214d with SMTP id z10-20020adff74a000000b003368030214dmr748542wrp.19.1703266954331;
        Fri, 22 Dec 2023 09:42:34 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:f3ae:2788:7e03:f44])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00336670abdcasm4777116wrn.40.2023.12.22.09.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:42:34 -0800 (PST)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v4 17/29] drm/rockchip: inno_hdmi: Drop irq struct member
Date: Fri, 22 Dec 2023 18:42:08 +0100
Message-ID: <20231222174220.55249-18-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222174220.55249-1-knaerzche@gmail.com>
References: <20231222174220.55249-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct member irq isn't used anywhere. Drop it.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
---
changes in v2:
 - new patch

changes in v3:
 - collect RB

changes in v4:
 - none

 drivers/gpu/drm/rockchip/inno_hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 51c1a69dfcc0..138cd4287dea 100644
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



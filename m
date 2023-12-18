Return-Path: <linux-kernel+bounces-3983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C47817653
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147851C23E41
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482D03D57F;
	Mon, 18 Dec 2023 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJ8LSnv2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FDE4FF66
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2356bb40e3so105486666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702914522; x=1703519322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nKUBapAjhj0X0B96M3zAwIkjMB25EHCfu9hZ082V30o=;
        b=CJ8LSnv2lgXXIZIViabbhDPgDW8icMxYC8xhGIHgDObiDXSJG7Kd3qZ2VQLHOpDt9S
         5h4lJ52STLYCex0JiTTYR9GEaAzou+s+TezQnEKnc8OPEN3xycyFE84mIwBpelIajC1U
         je35VQc3PZVc4wMJVdchBx+NPOM6hrJaVhJ0DB8fe1rMIu0xQQic6B7ZNTjCsxAwjWvK
         3C+2K4sMujMEAbaZYufDhfudn+TLDecBQu2aMMbidbGRGsGUi6VcJRXme5lmgEhx6bas
         maTLaAvC1y8Bx6djJjR+xvbUKU3PFOel4gol+ofC9tuBctK73RkA1+Cndtspm3BPLNCs
         sDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914522; x=1703519322;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKUBapAjhj0X0B96M3zAwIkjMB25EHCfu9hZ082V30o=;
        b=ZZ60+pltaKBRklrOmFZy0C9qGizQXTvips5lt/QNMkecWR8dtLa5FtvQ8iLU4KYQSf
         7Fh9tteBHlaGTzaJVom032LdnvtLfF1Qn47Oh3rvOBbrB5YjZqHz/T6ZEGrxnynz5i6W
         HzrH2Wi29zQZoLlrv5FnWlTivPvVDAObidIDU4lt4+PM+g86olzCAnlpNIlRWK99///6
         7SQTNZXInc5foFyD84WBpUjih5PdNYheq1j1o5CObytMBr/oTNRgpd8+xrszCpy4wsiX
         RLujKEOM7T1Z1iMCEFzlYrHPK2fg2yuyZOotZKghFtYEd1OSp1yg2fVsiSPGkQ1Qi+BE
         1Kvw==
X-Gm-Message-State: AOJu0Yxz/esLDzkBSQqxOtr9Y9JDia1t0SSFBcIFBl+hPCqmWMBHmzfp
	/+2OzNglRMbgR9oCNkU6w9A=
X-Google-Smtp-Source: AGHT+IG6VzyjvQH34+G4mZe3J8X6d+shURJPU4OY3fo8K/ff+S+V8abQzu8/HpzcKzta+X+jlpzp8Q==
X-Received: by 2002:a17:906:7399:b0:a23:6c6e:6b4b with SMTP id f25-20020a170906739900b00a236c6e6b4bmr282667ejl.45.1702914522076;
        Mon, 18 Dec 2023 07:48:42 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id vq6-20020a170907a4c600b00a19b7362dcfsm14334325ejc.139.2023.12.18.07.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 07:48:41 -0800 (PST)
Message-ID: <745f84db-dc9b-81b2-6171-4d8d86a96966@gmail.com>
Date: Mon, 18 Dec 2023 16:48:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 1/2] drm/rockchip: rk3066_hdmi: remove unused drm device
 pointer
To: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <f86ec29f-194a-800d-0aaf-9e16e551b37d@gmail.com>
Content-Language: en-US
In-Reply-To: <f86ec29f-194a-800d-0aaf-9e16e551b37d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The drm_dev field in the rk3066_hdmi struct stores a pointer to the DRM
device but is never used anywhere in the driver. Let's remove it.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/gpu/drm/rockchip/rk3066_hdmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index 62e6d8187de7..0dac6d133767 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -40,7 +40,6 @@ struct rk3066_hdmi_i2c {

 struct rk3066_hdmi {
 	struct device *dev;
-	struct drm_device *drm_dev;
 	struct regmap *grf_regmap;
 	int irq;
 	struct clk *hclk;
@@ -752,7 +751,6 @@ static int rk3066_hdmi_bind(struct device *dev, struct device *master,
 		return -ENOMEM;

 	hdmi->dev = dev;
-	hdmi->drm_dev = drm;
 	hdmi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hdmi->regs))
 		return PTR_ERR(hdmi->regs);
--
2.39.2



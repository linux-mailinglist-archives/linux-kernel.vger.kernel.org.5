Return-Path: <linux-kernel+bounces-17828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1C382534E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BAA22859CD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33542D052;
	Fri,  5 Jan 2024 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hrbIMxLS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847DA2D040
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-336990fb8fbso1090009f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 04:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704457347; x=1705062147; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sGBscisyTSw/b2M1zSYK36n9y5Z4TnelnT//si07xms=;
        b=hrbIMxLSw8g63VsCT535qVeJOjRwMbf8ZGIMZ/q+LSLF4F7FdqpICyI/k+tMNnoDXH
         RwV9fAtVqE6I7S456kxIB9TDUqt1w2AmCqPUxP47CF+qLQ2OmwgMmHwvjqZxytIdpPsn
         5TcKtSFXsnI/C7eS5sYmtHnIUyiyW88gGh8FZUpWzAxrjiMd4+hqoFc77CNFrTVPIbG2
         Fq9dBFx8oqYbsu8UYSc+WG+/f9T3V/XQH1oFFfNKkUjVa4rTujbGKUvW6aEdnVUBjxzT
         J9AGO1xXYvk/hQk8hJb8eZwYxvEUkLDZ3QPFQRsF6LCh5dJHHe1SM/ktLlFDDSUbSPFU
         OYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704457347; x=1705062147;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGBscisyTSw/b2M1zSYK36n9y5Z4TnelnT//si07xms=;
        b=xLUf6SFBMojAIIqhTcKchS8tD/ivKm+oOZ9X4Fb7jh3k/R4Rl/RWju7tL7I9iBNddx
         dzP+pSSj/PQM7dPXAEIGITLHtDKc59R9wilfwLGYLcwwto7wY3rCO/PMLdvKsiLWJOTc
         8B1sLUCh9Y+RvOAqTy47Q2gcWo3GtB85A6YDu22G1a37p2YQJSdEi7Mrr78TlquucoZ6
         IM3nanLiTUfYKR7xJcMRYpXhE5XRC8mtZWjApH4i4kf7vDSXIPP9KVMYEgUk8a2REYfz
         1JGjxwNbt46GgrFHHL0CnErEQlNyPT8pNDMS3MkWkA940hh3caIAOVJ+3XGcrOHJDU4Z
         hXrw==
X-Gm-Message-State: AOJu0Yw6CpKtNGgUp6iP972fn6PvC+cBp/oAgN9VeTp1xKPL88Wnoe7z
	1hD3wBqBd5V04MT7th3yvCPGGjkPlwUNpA==
X-Google-Smtp-Source: AGHT+IGT9fzaBi710ATXJxb0FerLWIsQ3l4gQxWJgA6mtydUZQ2+rmZLq4bt4feS2DdowkKD2D79Tg==
X-Received: by 2002:adf:ec05:0:b0:337:46ce:6239 with SMTP id x5-20020adfec05000000b0033746ce6239mr1113868wrn.60.1704457346718;
        Fri, 05 Jan 2024 04:22:26 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id d3-20020adffd83000000b003367e35abd4sm1296723wrr.71.2024.01.05.04.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 04:22:26 -0800 (PST)
Date: Fri, 5 Jan 2024 15:22:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Matt Roper <matthew.d.roper@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/xe/device: clean up on error in probe()
Message-ID: <c8984fe2-dc1a-4ba8-97c9-5c83f53a0d09@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This error path should clean up before returning.

Smatch detected this bug:
  drivers/gpu/drm/xe/xe_device.c:487 xe_device_probe() warn: missing unwind goto?

Fixes: 4cb12b71923b ("drm/xe/xe2: Determine bios enablement for flat ccs on igfx")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Speeking of static analysis, someone should probably run Sparse on this
driver.  There are some missing annotations.

drivers/gpu/drm/xe/xe_mmio.h:65:72: warning: incorrect type in argument 1 (different address spaces)
drivers/gpu/drm/xe/xe_mmio.h:65:72:    expected void const volatile [noderef] __iomem *addr
drivers/gpu/drm/xe/xe_mmio.h:65:72:    got void *

 drivers/gpu/drm/xe/xe_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index d9ae77fe7382..b8d8da546670 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -484,7 +484,7 @@ int xe_device_probe(struct xe_device *xe)
 
 	err = xe_device_set_has_flat_ccs(xe);
 	if (err)
-		return err;
+		goto err_irq_shutdown;
 
 	err = xe_mmio_probe_vram(xe);
 	if (err)
-- 
2.42.0



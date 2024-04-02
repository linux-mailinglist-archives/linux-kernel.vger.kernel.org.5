Return-Path: <linux-kernel+bounces-127672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B608D894F3F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08F6BB22238
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D041759172;
	Tue,  2 Apr 2024 09:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bApx8/cM"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5862759151
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051788; cv=none; b=IrIqKhu+M8TMPPfQIr2VEMMXbw33K8AjhZosGpLPYcArqdmWhaJWJjzphgx126Wz4lEHPA76nzoXfQCyRQP5M4pDufyJFp3AaEdPlcYkKgDHx0JZKwOjACBu35JSZ5yEVO2UtoprLlbFE+COJBuen9un/D1idXOlwYF6tuLiLyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051788; c=relaxed/simple;
	bh=Nh+2aAI3uXCuRfrMoJJ0v+wDHsdg/m8Udqg61zTF9R4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=amfuKu6yWSLU+980t6LEYtptn8ULCByauitznb/hxrAm0KX/v7A3aT6psxCANV//xCGcfMwxPTVlrFT5ulAEMB5H6emFefVYklLwNaOBxGwYrYpa1w8yaqXclCAwMfYo87F+2jVoDk/g9AOizUn9R7IL7FmpyeF1G/k7E82Ay+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bApx8/cM; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56c583f5381so6522120a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 02:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712051785; x=1712656585; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eiv2Gv97BeG+qqS2CUDwFb7TsuwaJxi4oFr7eU4Jkw4=;
        b=bApx8/cMFsi4/EtIWG2FTx+ZkcGLXG1qgEqNmrq9i8NXfN83Q09NDICvLJHH30MjZ3
         FcHIpOmdnYSNWZObJTEQO+IGz7b9X3GJX0B3CbO6hyFTsMGDk7oNJGgCwYEgbgIgLDvf
         klk9/oYwhYmyOmVMk5Z0u5hXHeY/1jXaU0YesDCVp6q7B0mwUnTEC61vb5inqc1s67yS
         bIx7ECdn4cdvYftPc+F/bVpYkOxehGluck4/svyPpVVpK9X5oiMsVg/RgBj9Hh/tZqsu
         Zdr19A24kgf13UYP9oHkQSuBIIvTTEyh6zuJ+wVLOOB2bZx4BJH2L/2VY95WHYU3+ZQr
         WVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712051785; x=1712656585;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eiv2Gv97BeG+qqS2CUDwFb7TsuwaJxi4oFr7eU4Jkw4=;
        b=ZBl+vCDpRFS3rgEZGj6o4dEDEH/op3P1wWKtuT8RC1JQCa5n+Nh9Cst1Ezms9eYNIA
         UCkPcq51aKxz5XmzOpL8eD9wueoqfnqq6YqtR3AI+iQnDTsWBojQCOEVPgYCCw6bu+PY
         19jjNFXiiHmxoQ3iSp2cRFtlcj79RTLqwu9dpY6jWU7RE1w8WDJLysyLiRKRR5cULCqQ
         SD3ogOYhcOqxlwipTog5/ccBTelU8pAxiOY9dyzJIJDr1ojXF/sAQZ51kcpZQuy7nwiU
         aWcQPT2DexQCBC8da4LHcemG6Fxh8bOxVyOtN5OoQmdb9RxRcr5O4zC6oITGf7LUC54D
         AxLw==
X-Forwarded-Encrypted: i=1; AJvYcCWMJ2ZkCFK324/5UpfplVJqefADSWEokbe02cYcLn3XNR6Dxpaz8Sun71hUghRlxliLppsA+MjF49JdrxbPS1FjrUgZ5KxNFeFSx6ug
X-Gm-Message-State: AOJu0YyCpP39M/yT9ukIhrvziu/QaoT/cGfaSV8U7r0lpkeKy4mcjFz1
	cvAhduBteKZIf+Z6Qaifhr00bdSd5cfIIcqe7UmCyILpVRml4CyU/RYeisk5au4=
X-Google-Smtp-Source: AGHT+IGco8HwCbD45dxh0cXo5f4RbSDoT35IhySsKpVpDkYvfjDKul3aeagzg+egPF4UF9e8RGBTWw==
X-Received: by 2002:a05:6402:35d6:b0:56d:c3f9:b8eb with SMTP id z22-20020a05640235d600b0056dc3f9b8ebmr8364382edc.12.1712051784449;
        Tue, 02 Apr 2024 02:56:24 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id f5-20020a05640214c500b0056bf7f92346sm6683950edx.50.2024.04.02.02.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 02:56:23 -0700 (PDT)
Date: Tue, 2 Apr 2024 12:56:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Heiko Stuebner <heiko@sntech.de>,
	Grant Likely <grant.likely@linaro.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/panthor: Fix error code in panthor_gpu_init()
Message-ID: <d753e684-43ee-45c2-a1fd-86222da204e1@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code accidentally returns zero/success on error because of a typo.
It should be "irq" instead of "ret".  The other thing is that if
platform_get_irq_byname() were to return zero then the error code would
be cmplicated.  Fortunately, it does not so we can just change <= to
< 0.

Fixes: 5cd894e258c4 ("drm/panthor: Add the GPU logical block")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/panthor/panthor_gpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index 0f7c962440d3..5251d8764e7d 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -211,8 +211,8 @@ int panthor_gpu_init(struct panthor_device *ptdev)
 		return ret;
 
 	irq = platform_get_irq_byname(to_platform_device(ptdev->base.dev), "gpu");
-	if (irq <= 0)
-		return ret;
+	if (irq < 0)
+		return irq;
 
 	ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq, GPU_INTERRUPTS_MASK);
 	if (ret)
-- 
2.43.0



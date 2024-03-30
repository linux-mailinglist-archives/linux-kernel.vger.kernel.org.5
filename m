Return-Path: <linux-kernel+bounces-125846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACB6892D02
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6FFAB21FB6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9623446AE;
	Sat, 30 Mar 2024 20:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J0vCs3bZ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580A423758
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711830803; cv=none; b=VTg2CEgcqnX3fmLlhNxc/OB9O0zSO5nq4LNzVzXtmElg5nxHvE/NaJ8GzNMq8tT72sT9kNQx4DGHo6ViZeya2FeJSUUbUcbg3Sxb+pWTKKfD0/sXh42fBTKZlB88mnTw1/dTSLg2fsVoNJVyEupiVBzEs+nrQFTIJYDzxc81lhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711830803; c=relaxed/simple;
	bh=ikAn+U2VxbkfcXOAocqiqsMAFIUnrQGNULyY7tvmZjM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JTAd78KbTYm8n/Lf7mmhd20KTy8X08ttzsyFaoClsP58+oL3zRmj2UcyyVHuFov9uHt9HGPg/q+m5KF5vaPO3UZuTYK1bmUag21FSx8dT9wmSfEKd8/fPc7QnUC/wBOgxyY3z5vxlmU2jM5PbMLchGscA1Up8GRL5BZO6IhK8K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J0vCs3bZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3433e518c78so579284f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711830800; x=1712435600; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GFAjJDDVv2Mq/JzFmcsO7YxhKCuR+cnUm88ySh3fdCY=;
        b=J0vCs3bZj868wkv2dxCA16usdLTxHmx+JepOHhgNLGhrtirvnyRwGOK7QU8kuAGxkI
         XAwimqKE0ToQZRhZD2eGjLCsReLZgXnm5vuNxSlCPMlf3dalnHePEaHvZ54DxRzsb0a+
         9elkNdrVfMD0433x0LhQBzFqNu6bJZ3dIT0RnvVXjeQUwXR/Dle4HKh24gEmEZcU+I6E
         i587xtWsu6wcJR6o9dEISLZ0x3fnP8wT6e04edOK5Re/KbOOH3X3Df52EX5M5vmOSP/8
         PTbzSeZj7uKmttBPdBXpUUQwHCDYJm9dVvCMyXuRzNXG+Cs+9w04YkBJmL0+ozCgjDz7
         +7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711830800; x=1712435600;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFAjJDDVv2Mq/JzFmcsO7YxhKCuR+cnUm88ySh3fdCY=;
        b=TmC+8MnnZIhZvYVUlk5aV8Xyicmgx1r824t02dqJiMK2pmAo/xGQ48J60QNjNe8hpu
         +T3E1nBDIfEsCHSdmHqtyKUHCBlNFUU1dczxEL14x4ERPN3G9Upv9jZy7kvdR4oQzF2T
         7ZRf/O9k/6u41PMrXMfZPinZTPyIqi4jCfPbLkzIln9ABOG/Y1zlmTM6dRKYbYgDIdw8
         F/G9lxWCl+qm8AMlcB63jwHlmP9mx8HbanOWgY+qhjTuhU16/SLojrcX0BYWF8Akk4Ej
         Rhzsr1UT821naF61eDNXnUR8SdlfLc9tzfODJH0OZ2Mp1qy3RmuRIc6FWMqj5MrbFmoe
         ZO/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVamrzsTvCSaVocaoOVVlEDlIMO2N6Vip0MtsibeMN4JEvT2rGf6cO8beZH1N637WnGU+mm6I2AM0Q3vrq+n2BTaJNQWN6IZA+q1ERt
X-Gm-Message-State: AOJu0YyW51YeimqyZq9t4V0EBJHFYpILms/srtbnq75OP/8XuXSfSRZM
	/C65SifQQfNehv+WyCUcfnIhkJ/4jPPZwP8m8hXBQr+Tmr030QnotYk0kyx3ySo=
X-Google-Smtp-Source: AGHT+IGOX9rzHnZKqEi/0u/JwllhPjDL5WI+9xrT75BifyUqTbwy5wixNEYn4orV6XKjH7yINyhNTQ==
X-Received: by 2002:a05:6000:402a:b0:341:c9bc:6340 with SMTP id cp42-20020a056000402a00b00341c9bc6340mr5662696wrb.12.1711830799729;
        Sat, 30 Mar 2024 13:33:19 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id f14-20020adfc98e000000b0033b48190e5esm7209315wrh.67.2024.03.30.13.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:33:19 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/11] drm/exynos: drop driver owner initialization
Date: Sat, 30 Mar 2024 21:33:04 +0100
Message-Id: <20240330-b4-module-owner-drm-exynos-v1-0-3fa30e2c7e5a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAB3CGYC/x3MQQqEMAwAwK9IzgZq24P4FdmDblINaCsp6yri3
 y0e5zIXZFbhDF11gfIuWVIsaOoKvvMQJ0ahYrDGeuOcwdHjmui3MKZ/ZEXSFfk4Y8pINjSjJd8
 OwUEJNuUgx5v3n/t+AL01KntsAAAA
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1590;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ikAn+U2VxbkfcXOAocqiqsMAFIUnrQGNULyY7tvmZjM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCHcD5nGngLbev9+ND1Nt7ZqZYQsRksp1eacLP
 WkIvzjxXZuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgh3AwAKCRDBN2bmhouD
 1xbxEACSQfAZBiA6d/aLNg7qF26Uj0wPR1fgjNyfRIfnunql1d/6F6f4IStx4vjq0toKC17p3bR
 PdE6D2sQxPj6wsScga2SpIYE53Q0dXFIBtvqB0F5GqY2+MLAExBETmkgeKTrnv+dikQaqO5Kw3P
 pkPLep6s4eUpf4QSCaKQggBRFNs0MgUCW7mvQu35OOsw7t+rBrmvxUkBWQgwzH+elQw0sA5VgcK
 ljBU/gecnRyddZ/EbhGIuU5qJbFN+UZejzLHwrewFRmWetZQNsG+NDDlSOQuZ4qle8fRP+sIBZC
 Pw7FKA2PIQdtOuNCXipkThniRxQqJSBUflAzKaUZdNHtxHIOmvcokX3S1k4Sx87HIG+ERLN4QwO
 /62OnW4TW2LIewfHg+3H0fsYNghHw/uW7ifEEVqOfgeibGGsgQoOcp6eKUNDG9MIeO5lTt9IQRx
 EeN1Mpis0Fh6cM4l8xTC1D1NcqQS0IoNsudpnX4hbPGgH3R212SOHT8wk1BwatrZdJ6R2Q8x5g0
 EyI24A4UewQQMbyWJL+o7SJnVTaQzlaJzZclJoJV76UpgyHVF8IzgpqWxTWNiHfu3Y2Lh3vdPAW
 u9FjNjO3ZxUf63LnC0ATHBPdyDAHBTgB/xspsVfe8bwnMUNJBTIMSY8Sq2rjLPjEd8nNb6hXDtX
 Cb+Pm6aXb5PFKFA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Simplify the code by dropping unnecessary .owner initialization in the
driver.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (11):
      drm/exynos: fimc: drop driver owner initialization
      drm/exynos: fimd: drop driver owner initialization
      drm/exynos: dsi: drop driver owner initialization
      drm/exynos: g2d: drop driver owner initialization
      drm/exynos: gsc: drop driver owner initialization
      drm/exynos: mic: drop driver owner initialization
      drm/exynos: rotator: drop driver owner initialization
      drm/exynos: scaler: drop driver owner initialization
      drm/exynos: vidi: drop driver owner initialization
      drm/exynos: hdmi: drop driver owner initialization
      drm/exynos: mixer: drop driver owner initialization

 drivers/gpu/drm/exynos/exynos_drm_dsi.c     | 1 -
 drivers/gpu/drm/exynos/exynos_drm_fimc.c    | 1 -
 drivers/gpu/drm/exynos/exynos_drm_fimd.c    | 1 -
 drivers/gpu/drm/exynos/exynos_drm_g2d.c     | 1 -
 drivers/gpu/drm/exynos/exynos_drm_gsc.c     | 1 -
 drivers/gpu/drm/exynos/exynos_drm_mic.c     | 1 -
 drivers/gpu/drm/exynos/exynos_drm_rotator.c | 1 -
 drivers/gpu/drm/exynos/exynos_drm_scaler.c  | 1 -
 drivers/gpu/drm/exynos/exynos_drm_vidi.c    | 1 -
 drivers/gpu/drm/exynos/exynos_hdmi.c        | 1 -
 drivers/gpu/drm/exynos/exynos_mixer.c       | 1 -
 11 files changed, 11 deletions(-)
---
base-commit: 7fdcff3312e16ba8d1419f8a18f465c5cc235ecf
change-id: 20240330-b4-module-owner-drm-exynos-d2f1b2d48af3

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



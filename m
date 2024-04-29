Return-Path: <linux-kernel+bounces-162995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 024B28B631F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937DC1F22A24
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586F4141999;
	Mon, 29 Apr 2024 20:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WIbbGqzh"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87FE13BC3C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421085; cv=none; b=W+f7Nfb7SZLplyNYpPr+wk5kbFtL+6gMTNFr5KDX3tHJYoq/CGChNicIo79UJgpSJFo2t9/uVkJx1Qdk27BYGIvrsJA0KqRFfctKBxnkmhNjTCraqGP/cY2++emHmM39ZSNIhTHXSPUI5UDdEZcH3RnLBOd6vehfvWc/yNyF5ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421085; c=relaxed/simple;
	bh=vr6HYHNikxrE9uxnRijq931ZgRzQtEgdb3JuE8cpJSM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G1a9b082bgNUo1ChywTDgyzu2N4z4rWPF7ZoUXNM16YmHIcEdKvfJ2gb3KN3bZvoJNLlBLM+fHE1MIsP/g9GDn6mSxbq2Lao7v2i7qOEJmNgZogaEqI1qxNeXfJIhx0Br9N4GuPDymRtTUCxFqTm078jEekDQ038DgL1VYaoR84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WIbbGqzh; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5200202c1bso658844166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714421081; x=1715025881; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MBevWuCkVXQNiIio5Rvv3o9eiqdWWz0SFEKzoKMNFwY=;
        b=WIbbGqzhZPx3CmBFB6sJIbFgBRnGbJVsFpykyllHcJt59S3sfy1iOZSlICjIZUuiES
         hEj3xl0h4fc+NZDBM6bStR8YPimRlZy7BbHueRgPo4NHiu598L8wDXCGsfd77s9j0hNJ
         DXQi4DMYm+GwC3bh3YirnV3lthP8TZ19RDsTozvipE+vrz3BcZE1+A9UcCHx9RX4C481
         S1HJI9KJFZYTnk/kIZnnMVXY+9MoG7N4uq1EIJnTls4GRl8tb4X51GBSJxmMO80NBMoI
         NJL97SFhhFGiSaH4Mr8VKlSSXhe0iEHWfJ+3GXoxzYqwvh+0peE6EvdLsUP4jh3JZDVX
         NXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714421081; x=1715025881;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBevWuCkVXQNiIio5Rvv3o9eiqdWWz0SFEKzoKMNFwY=;
        b=m31iQWomwFnGZISXAXLz2fjAbl3Nztz2iwsJf6Cfkhu1b2LNw3ZKNqSr7itYycMc5H
         Ge29cpXrDWRboOUqIIyzLGSM14EYHTOOZEtzd4m8hhiyZYMgAlCsSBX11Xa0B1aNjiqh
         ogk9wq0KZJXZ1oJFzd8D0UG0hGkUVx20/qzgpnM7nngX9OoK0Y47BsWIZTV5lYPR2FWs
         ZLx1A1ONJ0fXiv+Xr9FI5bSkGIBUZ5HJ8Dg1H2KaG3EZsZMzNeT/fYVqRJmIRZUdqC2Z
         NcklcNw9OzgbTZRHhhBLS9EWq9LDKbzTwNPQH0HEB0JuHyLAaCXQc5twoTVEqK4rTk8u
         i8nA==
X-Forwarded-Encrypted: i=1; AJvYcCXGK2iVe8VrwF8pG7L1m26DVx5iOEXVcviZRBoE8/6Tv4P+lh+T3SfqAL3q6hLQRzrQPclD2jOFgzg0lLFRwvlvKPrYVRoY38a3ROXB
X-Gm-Message-State: AOJu0YyPFPCVc1CjA133hmANhV6PFsGOXJntrtMBcvJAbZdYT1Zj29W1
	XgTpsvfzid4viQvNzuen8kOs0632jNS6FqQH7ncMR+QQpr1X+kQRl/a7Xmkl7bg=
X-Google-Smtp-Source: AGHT+IEwxOsduorLqYmOECGbGSlyf8SHBXhtUyR4n6IHP4C5E96b2T1pKw70dIQG95K7lnDVKs8gMQ==
X-Received: by 2002:a17:907:76c2:b0:a55:b2da:3e92 with SMTP id kf2-20020a17090776c200b00a55b2da3e92mr9322913ejc.68.1714421081239;
        Mon, 29 Apr 2024 13:04:41 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id ld4-20020a170906f94400b00a5906d14c31sm1140887ejb.64.2024.04.29.13.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:04:40 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 0/4] hook up pin controller clocks on Google Tensor gs101
Date: Mon, 29 Apr 2024 21:04:37 +0100
Message-Id: <20240429-samsung-pinctrl-busclock-dts-v1-0-5e935179f3ca@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFX9L2YC/x3MQQqDQAwAwK9IzgbcNLbYr4gHXVMbtKtstAji3
 108zmUOMIkqBu/sgCh/NZ1Dgssz8N82DILaJwMVxAVThdb+bAsDLhr8GifsNvPT7EfsV0N+dkQ
 PfrmSHaRiifLR/e7r5jwvCIh4LW4AAAA=
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

This series hooks up the individual clocks for each pin controller in the
gs101 DTS.

On Google Tensor gs101 there are separate bus clocks / gates each for each
pinctrl instance. To be able to access each pinctrl instance's registers,
this bus clock needs to be running, otherwise register access will hang.

The driver update to support this extra clock has been proposed in
https://lore.kernel.org/r/20240426-samsung-pinctrl-busclock-v3-0-adb8664b8a7e@linaro.org

This series depends on:
* hsi2 series:
  https://lore.kernel.org/r/20240429-hsi0-gs101-v3-0-f233be0a2455@linaro.org
* pin controller clock support:
  https://lore.kernel.org/r/20240426-samsung-pinctrl-busclock-v3-0-adb8664b8a7e@linaro.org

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (4):
      arm64: dts: exynos: gs101: specify bus clock for pinctrl (far) alive
      arm64: dts: exynos: gs101: specify bus clock for pinctrl_peric[01]
      arm64: dts: exynos: gs101: specify bus clock for pinctrl_hsi2
      arm64: dts: exynos: gs101: specify placeholder clocks for remaining pinctrl

 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
---
base-commit: 87e0588641086e91f3d0a7d97b939301990b1e86
change-id: 20240429-samsung-pinctrl-busclock-dts-46b223471541

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>



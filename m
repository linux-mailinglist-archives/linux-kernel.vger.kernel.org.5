Return-Path: <linux-kernel+bounces-43765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 478858418A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23151F20F27
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1EF36139;
	Tue, 30 Jan 2024 01:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEgCiaU5"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67A436119;
	Tue, 30 Jan 2024 01:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706579376; cv=none; b=Lv3O3c9+eoTwtpa9MoXRS13sZIV/uoflJWdTB7eXVa+gQuo6Zoek5wMFryct9Xpg5oxA0Tp81KPSEkSyLaR16w2n4GFIDSB0xlfZKaBf5aaYGUBEM2QMiPvk9GkIEKTONXJI/IxGxBad/IveUk+9aN64w/CPde2VNAE39ox7HR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706579376; c=relaxed/simple;
	bh=Das3/PJSuhF39HibmKn1WTovHbDU7/BnIv203V4wU0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HRVrpp3tOZUdWvWdF1okrD0t6tdlLh0BlvFPEdwfyFUpUKmaN/YOiFRjER7CRdnNwmGO0ZY7JlTE0Jw3IYJDaatKZqZq1f3zQuxECmOUL1/65PUv9ePMwlH3swZVA2cT/4mr1C4yHXJ7iITJd36FId38aRI9dThmxEx9uWQRA5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEgCiaU5; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e118b528aeso842914a34.1;
        Mon, 29 Jan 2024 17:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706579374; x=1707184174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YeHqdcQaLpP97ddnNdRPtp8biGTA9rsSvXwVDndOucU=;
        b=jEgCiaU520kFPT2awPFEmmlxeFtNIfLxLOxvGVDv3wSrSf6vHbJwSNynqh+n8zb9J5
         z/H5oL6pctNz4gjZV6wik6o6rvbp2qBiZiIjE1WcEB2Pyz8lo4vsQWNyUj9JQLKDKIlr
         vJ1jTt5tACdLR/ZIVKKDC2MhTzDbNvD5UZljobPeHVdyvx+nWgFrIRQWDP196Ywq/NwV
         xbyOlNq5MUXnjIHu+KytsNH3KD/+xDh0mEBW+XKc9jWhNwgwxg61V+el9kC8DpMzdftX
         YyoGDTOFqwsNUsxT+rS4/VGuGkAfbSZ2l40XVGKrZ+YdEOgY9hY9nbDXUP1Ayvr7bt6q
         zcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706579374; x=1707184174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YeHqdcQaLpP97ddnNdRPtp8biGTA9rsSvXwVDndOucU=;
        b=fX6w9iV0GzsTf6QTZE813iO+xYMun6ihlyUOWDZpnhezDdmNIj/vvmC/hgWnwDqpqQ
         fVweXKUAyxEKTAr2fXlPf0U5YTUnYAHNrIx5xob9oZvBlRanuy8YaQID7iDqIhU2CnGI
         C0IxJG4QR5FQ91vrNuXW0dA6+T3Vf8hldKt6aaTe0tOiqaxgmSSK2BpJ5n+yHTkJy0BS
         M55jndukoIwL9tBturjj3EyWlVb6jRyA0x57NRc361eOchYqj3TGSN9qXExG7iQflKxv
         MVdfS2i13+fpe0XOklttNGoaP9oWYkzYw295+GzOcbXzhmTsMxx8E7JzyGZ7zvasv2My
         03yQ==
X-Gm-Message-State: AOJu0Yzyu57sZFN7xKDtgbigZvTBv/othqb+FnbaON3PRxck7gWkx9NC
	bGZb7HZ4GCU0P3DY9WQikm01IUm9Csnmzxb/Mza/Kr9osqAI/tcZ
X-Google-Smtp-Source: AGHT+IEWm+yFUTc8v5aJm4yHpf3+3Hg9XQA2nq0GSCISj8wiLiLasRTc7aM2MNnDAGpP6/LwVRyHGA==
X-Received: by 2002:a9d:6a4d:0:b0:6dd:e9e2:de67 with SMTP id h13-20020a9d6a4d000000b006dde9e2de67mr6253354otn.20.1706579373627;
        Mon, 29 Jan 2024 17:49:33 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id f10-20020a4ad80a000000b0059610f4de98sm1292156oov.41.2024.01.29.17.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:49:33 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	p.zabel@pengutronix.de,
	robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	inochiama@outlook.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v3 0/4] riscv: sophgo: add reset support for SG2042
Date: Tue, 30 Jan 2024 09:49:08 +0800
Message-Id: <cover.1706577450.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

This series adds reset controller support for Sophgo SG2042 using
reset-simple driver.

Thanks,
Chen

---

Changes in v3:
  This patch series is based on v6.8-rc2, which has included the missed patch I
  mentioned in v2.
  - As suggested by Philipp, drop the Kconfig for SG2042, just add a default
    y if ARCH_SOPHGO to RESET_SIMPLE.

Changes in v2:
  This patch series is based on v6.8-rc1. You can simply review or test the
  patches at the link [3].
  - fixed some minor formatting issues.
  Note that if you need to pass dtb check, you need to apply a patch. This
  patch is missing in v6.8-rc1. For details, please see [2].

Changes in v1:
  The patch series is based on v6.7. You can simply review or test the
  patches at the link [1].

Link: https://lore.kernel.org/linux-riscv/cover.1704790558.git.unicorn_wang@outlook.com/ [1]
Link: https://lore.kernel.org/linux-riscv/MA0P287MB28228572C526C5099A8BDA2DFE7B2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM/T/#u [2]
Link: https://lore.kernel.org/linux-riscv/cover.1706161530.git.unicorn_wang@outlook.com/ [3]

---

Chen Wang (4):
  dt-bindings: reset: sophgo: support SG2042
  reset: simple: add support for Sophgo SG2042
  riscv: dts: add reset generator for Sophgo SG2042 SoC
  riscv: dts: add resets property for uart node

 .../bindings/reset/sophgo,sg2042-reset.yaml   | 35 ++++++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  9 ++
 drivers/reset/Kconfig                         |  3 +-
 drivers/reset/reset-simple.c                  |  2 +
 .../dt-bindings/reset/sophgo,sg2042-reset.h   | 87 +++++++++++++++++++
 5 files changed, 135 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml
 create mode 100644 include/dt-bindings/reset/sophgo,sg2042-reset.h


base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
-- 
2.25.1



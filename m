Return-Path: <linux-kernel+bounces-37995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E04683B96F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20661B23D51
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B8A10A12;
	Thu, 25 Jan 2024 06:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J62KC7sf"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6A910782;
	Thu, 25 Jan 2024 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706163030; cv=none; b=JBWdPurwohlpGpVZXwcQhmWL8JtONoGsd41e+pWMywjjVMlgfEl4Xb6wPwd4aYu8weDnjAZpgVzw6bxBjhInpiX0YiS+LpGC3mUrE4rTxYm1SN07x4/glFr+71l1CdLuPMnIeDOmSKqVMgvQ+tNqNuYh3B6nROABlGGkj/hEXME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706163030; c=relaxed/simple;
	bh=/UEVRkJILpAvaty/jsKhIC4XDoOSzKbsdAl07tMk4DA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aazjlkxVYdI+JhZUp74FY+lHu7DRGWx3zb4p52Xv/0WZgOgJqvcRtSNLgNwOBCkTQ/XzTvtrzteiK0iAStiolZm72t0+3VD+Ynu9eV7zHe40wXDWUcTfFiEnQyVKZWDEUt4eQ98BIyoLABdAQDDSzgEf9iooPo/x7J6t6Wjp/GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J62KC7sf; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2108c7829caso2529581fac.3;
        Wed, 24 Jan 2024 22:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706163028; x=1706767828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f5UOEcCOGayf5fE0hmDRoB6IFfHak7GXt74RM7JU47Y=;
        b=J62KC7sfDMO4a8lnlgQKNOu6GV8YXgEtplCOM8eVvPrXzwCKWItxJVt+nc9FpFB9wn
         IVvl4+hRfBOx6wHKkfWpZWzyn/FF2CA9trK59Wos1XN4vL8Tzo9VHReR8Og3ExcrSZ9k
         NsVxOyvjvOGw9zpXiJKuI4sj4sYMUgKvZqhEQcNXFGp5xTa7JMluqZ2zI8v0y07ChK+s
         s7Sksjkh5gmFfNG3xMmnvwmiqrI6vdCsEb57ToJaDvmoDskFpi29Fdx1mmzcU7ii2Pkb
         CgtaRIR6f1RjOtjz4CT4fOnIVoTx0rBPWb20OyKIA3BSl34Yif2SxFHOtG3q45TSGASu
         5zQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706163028; x=1706767828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5UOEcCOGayf5fE0hmDRoB6IFfHak7GXt74RM7JU47Y=;
        b=CBFyegGtglkykz55+FcpJuGvJx9LNlKo8ddsabY4q7wodBzOMZuH+H2j8tD9zKgnNF
         XrC+vqSafZ5QxVh/dA7SN7DYzduL1kEAXe3ouJVG4492h1wE6gihW80QYIlYmPnq66ZD
         hKWO+5DpcuEhXTB0C2wCPLa5j2obGTbM9lxLykQECZ0ai0vNp4hKatP2Hf7pqbTGZT8J
         zMUdepa9qKnYPMiqZejYzlVV25ejtwcReormwf8mbjuE0J5CkSeo4Tsr7kJ7ARIZcDO+
         IUCb/vUvWmgYKLe9vFzZY1luq1NejudT4SvDrhxf5pEAhtNWFNhyZihMkv53RoXC6Eva
         iX6Q==
X-Gm-Message-State: AOJu0YxdKjUjWkby8+9+PpofbgZIk+Gapp77zLSOOiHziwNn1SlV1LNq
	YL4PIzqeCfyCAkWve3Tu16Mr5MqD2/VpSi+JbZVMNhBCQFPZ5MRxLEGtkiZm
X-Google-Smtp-Source: AGHT+IHxmTVll4Cf8JjrzxGvWNFM4f/G55JM2dOmVP6aW9splGnxNL/nv5pU/Vz/5Rg/XQeNyBlcuw==
X-Received: by 2002:a05:6870:6189:b0:214:d7de:dc92 with SMTP id a9-20020a056870618900b00214d7dedc92mr154668oah.47.1706163027698;
        Wed, 24 Jan 2024 22:10:27 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id z16-20020a544590000000b003bd9c53096csm2856540oib.31.2024.01.24.22.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:10:27 -0800 (PST)
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
Subject: [PATCH v2 0/4] riscv: sophgo: add reset support for SG2042
Date: Thu, 25 Jan 2024 14:09:47 +0800
Message-Id: <cover.1706161530.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

From: Chen Wang <unicorn_wang@outlook.com>

This series adds reset controller support for Sophgo SG2042 using
reset-simple driver.

Thanks,
Chen

---

Changes in v2:
  This patch series is based on v6.8-rc1.
  - fixed some minor formatting issues.
  Note that if you need to pass dtb check, you need to apply a patch. This
  patch is missing in v6.8-rc1. For details, please see [2].

Changes in v1:
  The patch series is based on v6.7. You can simply review or test the
  patches at the link [1].

Link: https://lore.kernel.org/linux-riscv/cover.1704790558.git.unicorn_wang@outlook.com/ [1]
Link: https://lore.kernel.org/linux-riscv/MA0P287MB28228572C526C5099A8BDA2DFE7B2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM/T/#u [2]

---

Chen Wang (4):
  dt-bindings: reset: sophgo: support SG2042
  reset: sophgo: add SG2042 reset generator driver
  riscv: dts: add reset generator for Sophgo SG2042 SoC
  riscv: dts: add resets property for uart node

 .../bindings/reset/sophgo,sg2042-reset.yaml   | 35 ++++++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  9 ++
 drivers/reset/Kconfig                         |  1 +
 drivers/reset/reset-simple.c                  |  2 +
 drivers/reset/sophgo/Kconfig                  | 10 +++
 .../dt-bindings/reset/sophgo,sg2042-reset.h   | 87 +++++++++++++++++++
 6 files changed, 144 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml
 create mode 100644 drivers/reset/sophgo/Kconfig
 create mode 100644 include/dt-bindings/reset/sophgo,sg2042-reset.h


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.25.1



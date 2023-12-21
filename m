Return-Path: <linux-kernel+bounces-8193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7BB81B367
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2F728691B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC994F890;
	Thu, 21 Dec 2023 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EudNFrUg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A634F20E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40c2db2ee28so7527225e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 02:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703153999; x=1703758799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ncgABTCdGBw0CAzWbFnnfumaUfHdt8Nbmu7o0Ioedpw=;
        b=EudNFrUgFuhO51GHl5kbFhUxOY6xTnWxpBf4IU3RBZbODu60kx6EILafDBa9tHF6H9
         fdmPk5/DtO8gm6a9u4dB86oRrDfrUhLaE9zG1U5R0Y5IDNiXCuWj9C6324IZowPewl5d
         9uQVlcr1xE5IR53Lg2AvcLXiWl/Fgr54apz7zF2mX+aXDY42nMe0q6rUv6o/Db45RMfh
         h7j8xgh2tVTI2olgXxj0XckLsH3oNYF5D36WcFo6Rnm77m3LHmTrjQOPQff8OjvtVNu8
         Ylm0qimlP8b+pciPi5TMzEIqAs+6JDztinVwr5oJx1aKSB1WCy1aNMve1Gd9P71kRo8D
         kM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703153999; x=1703758799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ncgABTCdGBw0CAzWbFnnfumaUfHdt8Nbmu7o0Ioedpw=;
        b=K2Eq9N9PE+pPKrmq/8aRD8fPI8x2pLP1hvt/CZX+SguArA3FZ9LlZetTe3IhZVPGnV
         1iPNB8UhJTYKgFJCgjFDwuTD5wIua5ajL9pa/CrD+dyaOvY61LtlOuS8IwhKnvbCCe7y
         aikO6R0ULdyEK6gfzAMlnvv0dYBzpSZpjaVEv/nH9/MlEDXlOljnNsvHyOx/m9OMMVFg
         u5bgoU3yldzDVs3ot0MuGKfmVNULdBOIC50huDXd6BV/twIo6aCWuvBT73xGi0kW2ztM
         q6AhUbyGBAZefc/7RizlYsSnPFGO0YmSzNi6ama7GQzkDCbfi+5/VYpFWnMKQfQCJDWv
         2UYQ==
X-Gm-Message-State: AOJu0YwAsTK04BSvOMm6zz0WyszwiiXbmBo0ZeNp9Kn5L6Eqvv8SHEyE
	VaPSJKwVhmdAHFwbcpaZr6bGmg==
X-Google-Smtp-Source: AGHT+IFg88O/OHFdh5msbuWj8UlRrpIJ55OkeR2K7Sdmc5pIObNzWxGViQXX4T11YRZDFKQZ5NwONw==
X-Received: by 2002:a05:600c:34d3:b0:40d:18c4:d744 with SMTP id d19-20020a05600c34d300b0040d18c4d744mr634990wmq.97.1703153999252;
        Thu, 21 Dec 2023 02:19:59 -0800 (PST)
Received: from krzk-bin.. ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id p9-20020a170907910900b00a26ac5e3683sm125186ejq.100.2023.12.21.02.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 02:19:58 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Olof Johansson <olof@lixom.net>,
	Arnd Bergmann <arnd@arndb.de>,
	arm@kernel.org,
	soc@kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: drivers for v6.8, part two
Date: Thu, 21 Dec 2023 11:19:56 +0100
Message-Id: <20231221101956.16351-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit 4a23d0f9814c38308dc82b6dbc466666a400b27d:

  memory: tegra: Protect SID override call under CONFIG_IOMMU_API (2023-12-06 11:22:24 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.8-2

for you to fetch changes up to 365fcc03b6321f36eb7cbda8baa737238c387907:

  memory: ti-emif-pm: Convert to platform remove callback returning void (2023-12-19 09:05:19 +0100)

----------------------------------------------------------------
Memory controller drivers for v6.8, part two

Convert all drivers platform remove callback to the "remove_new" which
returns void.  Usual rationale from Uwe:

  The .remove() callback for a platform driver returns an int which
  makes many driver authors wrongly assume it's possible to do error
  handling by returning an error code. However the value returned is
  ignored (apart from emitting a warning) and this typically results in
  resource leaks.

----------------------------------------------------------------
Uwe Kleine-König (15):
      memory: brcmstb_dpfe: Convert to platform remove callback returning void
      memory: brcmstb_memc: Convert to platform remove callback returning void
      memory: emif: Convert to platform remove callback returning void
      memory: fsl-corenet-cf: Convert to platform remove callback returning void
      memory: fsl_ifc: Convert to platform remove callback returning void
      memory: jz4780-nemc: Convert to platform remove callback returning void
      memory: mtk-smi: Convert to platform remove callback returning void
      memory: omap-gpmc: Convert to platform remove callback returning void
      memory: renesas-rpc-if: Convert to platform remove callback returning void
      memory: exynos5422-dmc: Convert to platform remove callback returning void
      memory: stm32-fmc2-ebi: Convert to platform remove callback returning void
      memory: tegra186-emc: Convert to platform remove callback returning void
      memory: tegra210-emc: Convert to platform remove callback returning void
      memory: ti-aemif: Convert to platform remove callback returning void
      memory: ti-emif-pm: Convert to platform remove callback returning void

 drivers/memory/brcmstb_dpfe.c            |  6 ++----
 drivers/memory/brcmstb_memc.c            |  6 ++----
 drivers/memory/emif.c                    |  6 ++----
 drivers/memory/fsl-corenet-cf.c          |  6 ++----
 drivers/memory/fsl_ifc.c                 |  6 ++----
 drivers/memory/jz4780-nemc.c             |  5 ++---
 drivers/memory/mtk-smi.c                 | 10 ++++------
 drivers/memory/omap-gpmc.c               |  6 ++----
 drivers/memory/renesas-rpc-if.c          |  6 ++----
 drivers/memory/samsung/exynos5422-dmc.c  |  6 ++----
 drivers/memory/stm32-fmc2-ebi.c          |  6 ++----
 drivers/memory/tegra/tegra186-emc.c      |  6 ++----
 drivers/memory/tegra/tegra210-emc-core.c |  6 ++----
 drivers/memory/ti-aemif.c                |  5 ++---
 drivers/memory/ti-emif-pm.c              |  6 ++----
 15 files changed, 32 insertions(+), 60 deletions(-)


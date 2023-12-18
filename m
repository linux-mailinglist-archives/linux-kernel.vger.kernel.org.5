Return-Path: <linux-kernel+bounces-3267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC55816A1B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E0A1F250F1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCB4125B6;
	Mon, 18 Dec 2023 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FagT9KWy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C163311CAF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-54c5d041c23so3127328a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 01:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702892753; x=1703497553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o3Cx4LBCQ55lZB8WnWvhI3iafApiI+cNI28/HCIjwBg=;
        b=FagT9KWyUarRxDnkg9ZEv7rsgnycmThGiZKTFUUPEWFWLUzAVUjHURgkzpcMF69BM4
         wyAzI2gseYOxDpcItSHaDdXRVkH98l3HaYyZhIgfGZXcffXBhO65If6RCoc3yPzGBDYm
         RFQfLOgdJZCCCvKhV76SavmBAK6mbBQRSXxO7cE0zA4LDs/kKpMqzr563fqQgB3fY2CB
         F0S/OcyPPHC1JsSY1nVFAXLaEvtMMh/tg+0f6PuJTcQdmFm6v9lUrE7mbSmkXGNMo4Lk
         MoT7xJUEKJr179ynp0U0Q4siBq2MQcDhPLN7w7ywJbg8K9nXWFtZnm8Rq0jei1DaqEQy
         bL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702892753; x=1703497553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o3Cx4LBCQ55lZB8WnWvhI3iafApiI+cNI28/HCIjwBg=;
        b=Iz1AGa1XXcwG/i5d+5V8Xbl3EvFTv7RwMh9FdPcFILZwknImaDHknHKCuUfI46VH67
         4S5G3zUOAGxCCdcb0v+DT6lE8UMtwqpKA3GqkzxI/gxw9YKJep/VfEUGnRvwl2pd9gFV
         Pn3PexkcG8H53yZ123msYmMuGUWIRQJyDVtvu/2+8XXduWvUis/TE6+YSX3jSyr8F8RT
         LfwvFeydEYpd9LFTyqV5MivvqctrnyvzYJuoUYlaiJKoR8dVXFPB2W7vUDqEXHGJpK41
         OYWTxbFEz8LnltopPcrPr7VOCJp9tVSxG25frnxEnDprRc6Tgpe5AIqL3YbDiJ4xadqo
         doWA==
X-Gm-Message-State: AOJu0YxFgZCe8fiHzr7y9RR2SgUoLzf3SjcAoXsNm4kd0GYXwJm3pQfm
	8ylCzlO0sEJHsN6PVfNw4x5mUw==
X-Google-Smtp-Source: AGHT+IG8sNFmemRPce/khkhH1WuZjuhq/cFdrfDD4VKMz8M4LUXyo3lOAKDJYV9Mv6695jFBBgeqtw==
X-Received: by 2002:a17:906:16c7:b0:a23:4262:9411 with SMTP id t7-20020a17090616c700b00a2342629411mr524951ejd.38.1702892753035;
        Mon, 18 Dec 2023 01:45:53 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id i11-20020a170906250b00b00a233a4c4a30sm1974926ejb.90.2023.12.18.01.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 01:45:52 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Sylwester Nawrocki <snawrocki@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [GIT PULL] pinctrl: samsung: drivers for v6.8
Date: Mon, 18 Dec 2023 10:45:48 +0100
Message-Id: <20231218094548.37105-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Google and Samsung SoC pinctrl changes for v6.8.

Best regards,
Krzysztof


The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tags/samsung-pinctrl-6.8

for you to fetch changes up to 6cf96df77338c6a7e753229fe6d330ab60e28cda:

  pinctrl: samsung: add exynosautov920 pinctrl (2023-12-13 08:49:33 +0100)

----------------------------------------------------------------
Samsung pinctrl drivers changes for v6.8

1. New hardware: Add pin controllers for Samsung ExynosAutov920 and
   Google Tensor GS101.

2. Few DT bindings cleanups: add specific compatibles for each device
   using generic compatible as fallback.  This affects only DTS, no
   driver changes are needed.

3. Allow setting affinity on non wake-up external GPIO interrupts.

----------------------------------------------------------------
Jaewon Kim (3):
      dt-bindings: pinctrl: samsung: add exynosautov920
      pinctrl: samsung: support ExynosAuto GPIO structure
      pinctrl: samsung: add exynosautov920 pinctrl

Krzysztof Kozlowski (3):
      dt-bindings: pinctrl: samsung: add specific compatibles for existing SoC
      dt-bindings: pinctrl: samsung: use Exynos7 fallbacks for newer wake-up controllers
      dt-bindings: pinctrl: samsung: correct ExynosAutov920 wake-up compatibles

Peter Griffin (3):
      dt-bindings: pinctrl: samsung: add google,gs101-pinctrl compatible
      dt-bindings: pinctrl: samsung: add gs101-wakeup-eint compatible
      pinctrl: samsung: Add gs101 SoC pinctrl configuration

Petr Vorel (1):
      MAINTAINERS: Remove snawrocki's git tree

Youngmin Nam (1):
      pinctrl: samsung: add irq_set_affinity() for non wake up external gpio interrupt

 .../pinctrl/samsung,pinctrl-wakeup-interrupt.yaml  |  45 ++--
 .../bindings/pinctrl/samsung,pinctrl.yaml          |   5 +-
 MAINTAINERS                                        |   1 -
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c     | 280 +++++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-exynos.c           | 109 +++++++-
 drivers/pinctrl/samsung/pinctrl-exynos.h           |  25 ++
 drivers/pinctrl/samsung/pinctrl-samsung.c          |   7 +
 drivers/pinctrl/samsung/pinctrl-samsung.h          |  14 ++
 8 files changed, 460 insertions(+), 26 deletions(-)


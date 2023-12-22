Return-Path: <linux-kernel+bounces-9800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F8681CB9B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 684A2B239A3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4B0241E9;
	Fri, 22 Dec 2023 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gw3kEdpN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7F623759
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a235e394758so216940466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 07:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703257308; x=1703862108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W4lx9wwE1i9du74XL1yxBGJ3vsI1REncsFrgYBE3k74=;
        b=Gw3kEdpNp1G1yL+lawUmRB/eqxiZcOBjsVV/gEEJfF0Ns+7Hcw9Nd2DufEmNycf5wm
         zhqKTWaCj/YBdRKfNDzu6by41E4l8a8m8zAc0kGamB55T/k69ZFgJRv+e90gQovR8WJH
         re1fj7vJ0WxwAbZiABwtaObN0tlUZSHVM+8egMXFubAb4hLwKLCBVCFNBhFkCwfkqhCx
         4HDtg8u38UWItA73Wfro+cw/Ep07Jx7kVcYiOXt9mMRwQC5sYWITEEvjVxLFegVZBV+v
         A0qHq6r7wRsD1BnREesO68a0/hI8xArPRgeMxJAb4eDxUt+ZXdYlzDzKsjNBGo/tV9z4
         VjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703257308; x=1703862108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W4lx9wwE1i9du74XL1yxBGJ3vsI1REncsFrgYBE3k74=;
        b=TXCD0kfrQlvB5DApFLKBF9NGcNNoXfX7Qf6Kn/NCGhbq9ERwQpdImMBquVGeNsDmNM
         FC7dQXuUKZGlQYmLA5ilJccsSnaDSLwMVSwWDlY40bPlaVyMgvhsCk5s8My/1PI+CVvb
         LNuO6UNJwHw1cD2BKyYsAKKnMdDI18OTjZg18hduwhLWcRwQP09tMvJywRACUtNWBSPg
         +CJgfqJ8GxpYjoKp1WK09Zg84WOBtckbjg0Y2f3A8s527GY8LT1Tq+/gyN6ZDBeZMbiM
         1SVhPxM4B1tjLCVyWHsWQPTB1yAN/a/4pveCq73E30scr9oIfr5k7uFKpuSnS9DY01va
         hSBg==
X-Gm-Message-State: AOJu0YwXKfkUxkTum3jqUuU5WVyJaFolLDePYJAtUSRg9cP/aZ7EJLop
	0dttZnHRTBeUYIw+37UvEJiXhCvftLtvAA==
X-Google-Smtp-Source: AGHT+IHRKrti1VwxIc09jY0oOuJy9YPs+JgtifApCY/xsD7vtw0cq160pet+7Cxzey11G3sc5FPgzg==
X-Received: by 2002:a17:906:278e:b0:a23:577f:5fbc with SMTP id j14-20020a170906278e00b00a23577f5fbcmr849058ejc.79.1703257303016;
        Fri, 22 Dec 2023 07:01:43 -0800 (PST)
Received: from krzk-bin.. ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id h1-20020a17090791c100b00a26af35c171sm1275671ejz.0.2023.12.22.07.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 07:01:42 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 0/4] reset: gpio: ASoC: shared GPIO resets
Date: Fri, 22 Dec 2023 16:01:29 +0100
Message-Id: <20231222150133.732662-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

We have at least few cases where hardware engineers decided to use one
powerdown/shutdown/reset GPIO line for multiple devices:

1. WSA884x (this and previous patch):
https://lore.kernel.org/all/b7aeda24-d638-45b7-8e30-80d287f498f8@sirena.org.uk/
2. https://lore.kernel.org/all/20231027033104.1348921-1-chris.packham@alliedtelesis.co.nz/
3. https://lore.kernel.org/lkml/20191030120440.3699-1-peter.ujfalusi@ti.com/
4. https://lore.kernel.org/all/20211018234923.1769028-1-sean.anderson@seco.com/
5. https://social.treehouse.systems/@marcan/111268780311634160

I try to solve my case, hopefuly Chris' (2), partially Sean's (4) and maybe
Hectors (5), using Rob's suggestion:

https://lore.kernel.org/all/YXi5CUCEi7YmNxXM@robh.at.kernel.org/

Best regards,
Krzysztof

Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sean Anderson <sean.anderson@seco.com>

Krzysztof Kozlowski (4):
  reset: instantiate reset GPIO controller for shared reset-gpios
  reset: add GPIO-based reset controller
  ASoC: dt-bindings: qcom,wsa8840: Add reset-gpios for shared line
  ASoC: codecs: wsa884x: Allow sharing reset GPIO

 .../bindings/sound/qcom,wsa8840.yaml          |   9 +-
 MAINTAINERS                                   |   5 +
 drivers/reset/Kconfig                         |   9 ++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/core.c                          |  70 ++++++++++--
 drivers/reset/reset-gpio.c                    | 105 ++++++++++++++++++
 include/linux/reset-controller.h              |   2 +
 sound/soc/codecs/wsa884x.c                    |  52 +++++++--
 8 files changed, 231 insertions(+), 22 deletions(-)
 create mode 100644 drivers/reset/reset-gpio.c

-- 
2.34.1



Return-Path: <linux-kernel+bounces-160024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 893568B37FE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E19F1F22ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96757146A95;
	Fri, 26 Apr 2024 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mYtsuPaQ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCCE146A7C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137052; cv=none; b=tOZT/HBbNA6kucHnTQ/Y6isiF5RVJ5DWRp/0FBlh3D0Bm1DcAY+WhN+76GALK1QebEtXAtYYnHUBBTXyk7Jc2IWSpYXYwBwu9TPsUebG0eavTWBSQKz7LMSH9s7L/8fyqzlMOa2Ih0dqjm5MBMdy11g9zBONQFGddOX37e9Z7ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137052; c=relaxed/simple;
	bh=VE7wD8KokW+7zCXO0HYd2htMwnpzd+jqE5ppA5VzXgs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r9NDI6f128dP59CPAUNsdIbJWqvX8SzQaNYKKMGOzxBv6AUZnte6TrWbGJcvhEith/lU8VQL3DIQZbraeUfSqAUU9X5gRxjz4NcrTZ+m5Yuwb2r7acG0Csz+qzYBL0BA1NooGOGeuQvC8T7kj5+8IOUYk+T6n+s2B8Roue6j/Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mYtsuPaQ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-516d4d80d00so2844312e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714137049; x=1714741849; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=up/TvhMZAZY6yPkfNvqYk9mm7CB0BvgIE99o7dPUwOo=;
        b=mYtsuPaQ0gH2j5OLE9kTsQa5Xi7g8G06kk+9t8fADcEYyG8rjWqsD4SLF6GX8I58a1
         dL+Ad6SCcG8zEwVqAcI3QHpF6ZE+UStNK1Ur1eZT5pxnJaNhf4WK+XoHmoQm5TR5vo5f
         6BPQPRPRCL5XQ/RturGRVMC7C9+caBID225aLif00Ss/hFgAmElJzikih2cRQFvVp6V3
         U3Bw8e+eONY6XhGKgXuSOilr8K+WulprjFJxc81KYDOyU5RAdkDYzAE1KeRjTc19LhoG
         3tsB6NZ1D2QGSSjjygnW6yOCxOVZnO7Y0sSB1fYSwso9VJypiNNjzPVfE0s2dJ8R3Hjl
         nREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714137049; x=1714741849;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=up/TvhMZAZY6yPkfNvqYk9mm7CB0BvgIE99o7dPUwOo=;
        b=EO+kw7jadQmZc5rf3Eb0cOJcOrhg0LPB+2RbAXdDerw53yxSYzKU1RyYsvx8EXB2WF
         XV4HYE7LcJf4VEA3JaCxdCbqT2+mo6w/3Bac5drO8U14w81u97DE5i7aVhxSg7hPNHcN
         DZrFDTYiiiFykS8w2rQGmhgXXw72TaOtowGWA+TGP8A7oS91Kso+Cd8GKCLKS9WRxaQd
         fAUCB5ICwlytNeTNgeZtVmJRddCZBCa4C7lqq1oYXWZciEzOJQVzAfDFUrfflXUNS8y0
         xvqGIAgtWeMxSPEZ9QYLDan0o0LGUYYDQS7JlRRIuSW49a+a/1peKuYnQUeSeFZWMztJ
         DDzA==
X-Forwarded-Encrypted: i=1; AJvYcCWW2GE5i0BhRlR32nTyytL4wa6DZIeqiSu6lH14eyMNeDgLJS63C5p7dIjOpq4kYk0AOrni+SmEqeGnOpbrJmY1YF1TQf7R4cDzCD30
X-Gm-Message-State: AOJu0Ywwq09q7u+KXKRHL0Jnh1YK0FG2uaOWUk7pDeMlDH+hk1YU7cvu
	QFAN9+U3T6R2fp7qObGgXW6he7JGMR9GM4wHriIxeSKdyFs2VhZiv8cTzgVyr1k=
X-Google-Smtp-Source: AGHT+IHL9UxI1NEY1QMkE6e22sU+Za46bYeedUI48dL8mkZVuEGHt9uH/8OUBtMER64Ua4ymrFeFUw==
X-Received: by 2002:ac2:4248:0:b0:51a:90dd:698b with SMTP id m8-20020ac24248000000b0051a90dd698bmr1749320lfl.65.1714137049284;
        Fri, 26 Apr 2024 06:10:49 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id u18-20020a170906c41200b00a58bec2ae2bsm1396948ejz.39.2024.04.26.06.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:10:48 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v2 0/2] clock support for Samsung Exynos pin controller
 (Google Tensor gs101)
Date: Fri, 26 Apr 2024 14:10:45 +0100
Message-Id: <20240426-samsung-pinctrl-busclock-v2-0-8dfecaabf020@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANWnK2YC/42NQQ6CMBBFr0K6dkxbAasr72FYlFJhIrZkBoiG9
 O5WTuDyveS/vwn2hJ7FtdgE+RUZY8igD4Vwgw29B+wyCy11KUtdAdsXL6GHCYObaYR2YTdG9wR
 VKadP3bk2tRR5PpF/4HtP35vMA/Ic6bM/repn/4iuCiSYi7FaStv62txGDJbiMVIvmpTSF6gIH
 9fBAAAA
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

This series enables clock support on the Samsung Exynos pin controller
driver.

This is required on Socs like Google Tensor gs101, which implement
fine-grained clock control / gating, and as such a running bus clock is
required for register access to work.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v2:
- propagate clk_enable() errors in samsung_pinmux_setup(), i.e.
  struct pinmux_ops::set_mux()
- move clk_enable()/disable() outside bank->slock lock, to avoid
  possible deadlocks due to locking inversion (Krzysztof)
- fix some comments (Krzysztof)
- use 'ret' instead of 'i' in samsung_pinctrl_resume() (Krzysztof)
- Link to v1: https://lore.kernel.org/r/20240425-samsung-pinctrl-busclock-v1-0-898a200abe68@linaro.org

---
André Draszik (2):
      dt-bindings: pinctrl: samsung: google,gs101-pinctrl needs a clock
      pinctrl: samsung: support a bus clock

 .../bindings/pinctrl/samsung,pinctrl.yaml          |  17 ++++
 drivers/pinctrl/samsung/pinctrl-exynos.c           | 112 +++++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-samsung.c          |  95 ++++++++++++++++-
 drivers/pinctrl/samsung/pinctrl-samsung.h          |   2 +
 4 files changed, 223 insertions(+), 3 deletions(-)
---
base-commit: a59668a9397e7245b26e9be85d23f242ff757ae8
change-id: 20240425-samsung-pinctrl-busclock-151c23d76860

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>



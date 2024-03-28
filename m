Return-Path: <linux-kernel+bounces-122675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959C488FB40
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513F829062F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A60E7C08B;
	Thu, 28 Mar 2024 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z92uH96+"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4C4134CB;
	Thu, 28 Mar 2024 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617807; cv=none; b=N/L65/+/lOTP7AYG2GHzdqLtQAq9QcuLZGma3WbV7dgJCvxLbeVSXgu+7gQDlFJOIKF/hOW+01XliUiB+mKwAhj0sRK6MJAttoyWqusajx7JWb6u9ubNnnu0wOL1MvfLm+ZlEFegFfCITM/kXelqq2jrntTK0Bv5HcVubJYhS8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617807; c=relaxed/simple;
	bh=M8HHIKevIxc77HrQP75VS/7x/3zEwQAFlO5tgpeUBkM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=H/rUWp2AyRECnWP4D8vxkt55P+kAPj6ym5ItMrt6T8/exwjqH1+wnNoy475MJ4xmBFdjlaVPDbebdF6dGrDvQa/9XjKyE/Ke259EBAYbRz3ioqjQ3YkaQKXGlpKZ1SqWfmAjo0Tx4WvfnyQpH19QY3uuLRTQhJSquqxghovJeeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z92uH96+; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56c0a249bacso874572a12.1;
        Thu, 28 Mar 2024 02:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711617804; x=1712222604; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=76sr1FMyUWOhL+InHmaTktpONdMRRLx62idYpcBzy94=;
        b=Z92uH96+cRwbIomvybeQq9l6W3OBKxlX90Pq3UFWof8MqY0xGduHbdbAZDjFhqC25G
         lvVj95n0miv7Kow8ENpZUjoUXo36RViVITn075mXS+Ap5nIdxJlXKWyKPW1ryrLpgTCe
         haRh1arlX9lpVyi5KBgZgLndp6fugzYQKqmOt9fzAv8O4bPsQaVrnInUPNvAheoCSX6U
         yBGb3w0qFFpCVKrbYdvw/RwQLtj/0hdJ7dsl/4n1nxjJ9s9NDLO6pwpovi/ygAv7GKhz
         h9MjrEhKQAwEfJRHtfz3avlPUbOECl9yD7bFsrVJ+gOfxUHoNEEsO8vTWjuL8etHivCG
         I+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711617804; x=1712222604;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76sr1FMyUWOhL+InHmaTktpONdMRRLx62idYpcBzy94=;
        b=OJowfPo3OgoA191nI/GduJ0Mc1jak31XEWox4hmSHCRAlIAqK0EglXPYV+mYUCQw95
         lLUj/0UtarlPI+qrYbMp3m/pNZ/JmNR6pyQvfz1ZXe1ESewvI+wyK6AL+87X0lYF5jjY
         xd54/UnlfLOav5CHIgZ3d6z3zwbYm32ZcFfYqb58ZBjoESUspZuBxoGIVi/QiSV08h0L
         JVTrdRZEojQrXyaO7szv4wyAuJ4TFTLa2glhwwwvVUOHeGxsETP9//j9IsHDYPHmp6m0
         FgXk6mgHgGWQGSDLnS3RpavBuygZZnY15X58FStNCPRRjuGkkY5oFaGjcyICpEBJ/OJy
         O0xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwZENPduc4IC1gILZwdZ77wDipaGNMdgl4+8pdQIa0H8IK+pn9Z5COueCy+ZRoEEIBxGFI3wJAavC6h0eZNuNckI5GiTYmctNuC9x4nkvXZ5DbYinMUCSdZYAl/To8vFEn5EYOaH5S
X-Gm-Message-State: AOJu0Yz6PeKDEX8GL80TIwsbHfNIMbWJUgzEyam4x936NGEn9e4QY9RS
	KGnQ7+c6JwBcJm+E4MxKrxcyAtbpcdRPKAmHUX2jRtM2cy6O7IAv
X-Google-Smtp-Source: AGHT+IE3J5JOX1g8Ck4ra/FFcNf6SzeadCdYhTqGYRrbUyGiFt9NhynmUm7P+nLaZECE3OhvHzUDtA==
X-Received: by 2002:a50:cdc2:0:b0:566:ab45:e6c5 with SMTP id h2-20020a50cdc2000000b00566ab45e6c5mr1733391edj.28.1711617803822;
        Thu, 28 Mar 2024 02:23:23 -0700 (PDT)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id cf2-20020a0564020b8200b0056b0af78d80sm609298edb.34.2024.03.28.02.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 02:23:23 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH v4 0/5] clk: qcom: apss-ipq-pll: various cleanups
Date: Thu, 28 Mar 2024 10:23:09 +0100
Message-Id: <20240328-apss-ipq-pll-cleanup-v4-0-eddbf617f0c8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP02BWYC/3XN3wqCMBTH8VeRXbdw/8p11XtEF2s708HUtZUU4
 rs3hUAiL78/OJ8zogTRQUKnYkQRBpdc3+XguwLpRnU1YGdyI1pSXjIisAopYRfuOHiPtQfVPQN
 WBKRUVppKcJRPQwTrXgt7ueZuXHr08b18Gci8fsHqPzgQXGJB7VEKTqUR5ly3yvm97ls0gwNdI
 ZRsIDQjtCSW6QxZw38RtkYOGwjLCBGaK4Ab4UqvkWmaPu+x4aZCAQAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.13.0

This series contains a few patches to perform some cleanup in the
apss-ipq-pll driver.

The set is based on v6.9-rc1 and it depends on the following patches:
  - "clk: qcom: apss-ipq-pll: use stromer ops for IPQ5018 to fix boot failure"
     Link: https://lore.kernel.org/r/20240315-apss-ipq-pll-ipq5018-hang-v2-1-6fe30ada2009@gmail.com
  - "clk: qcom: clk-alpha-pll: Stromer register cleanup"
     Link: https://lore.kernel.org/r/20240311-alpha-pll-stromer-cleanup-v1-0-f7c0c5607cca@gmail.com

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v4:
  - fix a typo in the subject of patch 5
  - collect Reviewed-by tags
  - Link to v3: https://lore.kernel.org/r/20240326-apss-ipq-pll-cleanup-v3-0-15c4aeeb14ac@gmail.com

Changes in v3:
  - rebase on top of v6.9-rc1
  - change patch 3 to use private values for pll_type instead of removing the 
    field of struct apss_pll_data
  - collect Reviewed-by tags
  - Link to v2: https://lore.kernel.org/r/20240321-apss-ipq-pll-cleanup-v2-0-201f3cf79fd4@gmail.com

Changes in v2:
  - add a new patch at the end to remove the 'cbf_pll_regs' register map
    from clk-cbf-8996.c
  - change patch 2 to move huayra register map to clk-alpha-pll.c
  - collect Reviewed-by tags
  - Link to v1: https://lore.kernel.org/r/20240318-apss-ipq-pll-cleanup-v1-0-52f795429d5d@gmail.com

---
Gabor Juhos (5):
      clk: qcom: apss-ipq-pll: reuse Stromer reg offsets from 'clk_alpha_pll_regs'
      clk: qcom: apss-ipq-pll: move Huayra register map to 'clk_alpha_pll_regs'
      clk: qcom: apss-ipq-pll: constify match data structures
      clk: qcom: apss-ipq-pll: constify clk_init_data structures
      clk: qcom: clk-cbf-8996: use HUAYRA_APSS register map for cbf_pll

 drivers/clk/qcom/apss-ipq-pll.c  | 56 ++++++++++------------------------------
 drivers/clk/qcom/clk-alpha-pll.c | 10 +++++++
 drivers/clk/qcom/clk-alpha-pll.h |  1 +
 drivers/clk/qcom/clk-cbf-8996.c  | 13 +---------
 4 files changed, 25 insertions(+), 55 deletions(-)
---
base-commit: 9755120255d6e7b6480509e753e9aecd6171e04a
change-id: 20240315-apss-ipq-pll-cleanup-a1e99af9d854

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>



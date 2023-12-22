Return-Path: <linux-kernel+bounces-9925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9867181CD50
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3778F1F2326B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D420286B6;
	Fri, 22 Dec 2023 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/T7uZar"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C442510C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d4d9d9b77so746385e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 08:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703264081; x=1703868881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tp4rJuQG3OHFx6oF8DI0RVZGd4i2skFPkCRfzzGlz8s=;
        b=P/T7uZarPNDby4pD8nQXosKSWzSvXFewVpk0oIkFa1xN0Ns/Jg5nVErHGRXodvojjq
         xfKpgQXkI0NSTJs7COJEswic9y0xuUe2UsoFHKNkzA3zEfzyS/v+U1JU1aHynUXehFLg
         vISU28cav1MQppfqpAuX5owEwVmT0VUBdSbVC/AOM5dbD0mhxlNk+G1doV9qTGepuyAt
         VaIH6cImr2ZkFoKT9gECUTF47rAsxQTWCnLEQgKLh35qdxhqOZuGzkfWWfCHdimp84iF
         QA7TydNF360C5yKFhBvpMfsYJDlsbtWiYWJxe42mIabrtOFCY5AXU/2vEYI29SAwrX4M
         89sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703264081; x=1703868881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tp4rJuQG3OHFx6oF8DI0RVZGd4i2skFPkCRfzzGlz8s=;
        b=ofNFFClejoQcboaKQ7sHzFbQxSnyngd9mtcCyjXWaXSTQplObE0kUl/XMqJauC2olA
         T9H2QJ3IBjmzEyzwI3zFy6032jKOlrdqqNwOXqDIn+K15w7lmxUCElyALHsj7D8aFqZc
         s8aG85IRKhyzXKjlKRliOXMAWlGEr9ORhclbNrysyqH0efxWKFrGbIMM1QLUmm6RoTFc
         B5/5ZcWJS0t/BKNbbnNNzfmRFYiUGu8ZLqH9+gSg6Srl2Vuk4ZTny1zKnrqZpnkFdsS7
         xFBl4WbDjWI9/7G0zzQMAJaHSIA+hHubjyYxiyJ4sDDwpzFubxb0Vv/wKxhHBPSQOCHJ
         7YxA==
X-Gm-Message-State: AOJu0YwWWrigC3B2S3kggwFifZfc4fivhMrXXRe1xwygJI2uRDKZuvS1
	41Lo9OwC17iF+1GamzV/AJ+PG7kpo+8C5w==
X-Google-Smtp-Source: AGHT+IHImM4HfK5e0bczSc3i+bOXtwSGNqlpqls7j9IZ1sajgCFkS/wlJMk9ERJ1tkqE8H+tfsc8fw==
X-Received: by 2002:a05:600c:19c8:b0:40d:4da9:db82 with SMTP id u8-20020a05600c19c800b0040d4da9db82mr105248wmq.45.1703264081104;
        Fri, 22 Dec 2023 08:54:41 -0800 (PST)
Received: from gpeter-l.lan (host-78-151-55-40.as13285.net. [78.151.55.40])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600c354f00b0040d378510adsm10138520wmq.1.2023.12.22.08.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 08:54:40 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	peter.griffin@linaro.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	semen.protsenko@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com
Subject: [PATCH 0/3]  Enable Multi Core Timer (MCT) for gs101
Date: Fri, 22 Dec 2023 16:53:52 +0000
Message-ID: <20231222165355.1462740-1-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

This series enables Multi Core Timer (MCT) for gs101. As part of enabling
MCT we also need to register cmu_misc bank of clocks early so exynos_mct can
obtain it's clock.

MCT timer is required longer term as the Arm arch timer can't wake the CPU from
suspend. This series is based off todays linux-next.

Note the dtsi change without the corresponding clock driver changes will result
in a system that doesn't boot. So ideally this would both be merged together
through Krzysztofs Samsung exynos tree. If that is OK with everyone?

regards,

Peter

Peter Griffin (3):
  dt-bindings: timer: exynos4210-mct: Add google,gs101-mct compatible
  clk: samsung: gs101: register cmu_misc clocks early
  arm64: dts: exynos: gs101: define Multi Core Timer (MCT) node

 .../timer/samsung,exynos4210-mct.yaml         |  2 ++
 arch/arm64/boot/dts/exynos/google/gs101.dtsi  | 20 +++++++++++++++++++
 drivers/clk/samsung/clk-gs101.c               | 12 ++++++++---
 3 files changed, 31 insertions(+), 3 deletions(-)

-- 
2.43.0.472.g3155946c3a-goog



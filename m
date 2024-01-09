Return-Path: <linux-kernel+bounces-20804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192F482856B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD67C2856EC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B19374DA;
	Tue,  9 Jan 2024 11:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R81PcQwa"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CF437168
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e52ebd643so521285e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 03:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704800951; x=1705405751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QZRbCk8qoWzhrWr+jjYycVBUYFG/5QcQa9WqigCq1eg=;
        b=R81PcQwa0KNKPY0Vc1BO6PuyQslYA5y4lJT9xfie5s2z0/RYCRe9WqLmwoe7mAoIl6
         F01EEs87vhh3MXUsrvgPUdudQbXT0SO5qIkmTfabUrdlJiK0ChkE8cgdwY0FnGuwsBoI
         zGLjmTUj/PmQP2c6ismG6mCAwbSpI1oa4qPgKuLeZ6mCa6T56V66Aqo4mQ5Ps3+lLvE8
         NIBdGUFm6Y+QHTxrN2nIrSKUEl8tHVV8QiG5TsHLgUcBzi8uX4EgoxdTOgPjifUlCLA5
         zAQ40zt82Hz21u4D+PAnerKVbiHTAlHaGLDAGxBOO5PnwbsLku7GX24J4w1E4lslAuPp
         DOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704800951; x=1705405751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZRbCk8qoWzhrWr+jjYycVBUYFG/5QcQa9WqigCq1eg=;
        b=MUs2lCfowliPZUL9XRo6c33qdZe/ISHLv8zXqog+eGaOWxRGjih7JI8Ia0A8fUqlZW
         5OOddGHecKjzdUPbgvGHpH/8Eze9CiHaeNd/TorRpTuU2c00wjqTLhCyRGFniGUm1+GP
         EI/4+t+Z+p5RKUzoiE5350uhTvnhl484wIXTdclQMT0iaTJxtD+FNxk862ka57FLHoL5
         BfsIa2i9iV5an/jXsFBvB10BCToGYgSTosfh7IAxzlDqjwZDVfSM6+ZDOBotUk4kPEL1
         uSDg2ZAWR+5Pm8JXaBJcQH5hCdx5LPw1XlV0+Et+QH87d2h7n8eAOJeR41Wx9VfD3BLw
         MIBA==
X-Gm-Message-State: AOJu0Yz2IjmEn6cbnB2Cb8kLmguLahKVVxdITWYrpN/yCeOSWvMJiCiE
	Uuf24KV2ZVowyvTi4MNA1my9d1J2J+g3fw==
X-Google-Smtp-Source: AGHT+IG5OZPESaiv3ZJWZ9aXTp1QjbvbftLSyzmc38Bl8NUiHJ5JLWEB88jZiBz1GZutTuBFPpSVgA==
X-Received: by 2002:a05:600c:4d26:b0:40d:73e3:41db with SMTP id u38-20020a05600c4d2600b0040d73e341dbmr2534565wmp.56.1704800950770;
        Tue, 09 Jan 2024 03:49:10 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id bg30-20020a05600c3c9e00b0040d62f89381sm3335699wmb.35.2024.01.09.03.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 03:49:10 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	peter.griffin@linaro.org
Cc: mturquette@baylibre.com,
	sboyd@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	semen.protsenko@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 0/3] GS101: rename cmu_misc clock-names
Date: Tue,  9 Jan 2024 11:49:05 +0000
Message-ID: <20240109114908.3623645-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the cmu_misc clock-names to just "bus" and "sss" because
naming is local to the module, so cmu_misc is implied. As the bindings
and the device tree have not made a release yet (v6.8), comply with the
renamed clocks in the device tree and the clock driver.

The patch set is expected to be queued through Krzysztof's tree as he
was the one that queued all the previous gs101 patches.

Changes in v2:
- comply with the new cmu_misc clock names in the clock driver

v1:
- https://lore.kernel.org/all/c6cc6e74-6c3d-439b-8dc1-bc50a88a3d8f@linaro.org/

Tudor Ambarus (3):
  dt-bindings: clock: gs101: rename cmu_misc clock-names
  arm64: dts: exynos: gs101: comply with the new cmu_misc clock names
  clk: samsung: clk-gs101: comply with the new dt cmu_misc clock names

 .../devicetree/bindings/clock/google,gs101-clock.yaml         | 4 ++--
 arch/arm64/boot/dts/exynos/google/gs101.dtsi                  | 2 +-
 drivers/clk/samsung/clk-gs101.c                               | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.43.0.472.g3155946c3a-goog



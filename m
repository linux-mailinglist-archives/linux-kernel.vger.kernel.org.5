Return-Path: <linux-kernel+bounces-20639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A69D38282CE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59721C23E0E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030962E634;
	Tue,  9 Jan 2024 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX+JFFNS"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A6D29422;
	Tue,  9 Jan 2024 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-59879d7a655so268240eaf.3;
        Tue, 09 Jan 2024 01:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704791789; x=1705396589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S5ZhSIArRTK4RfoHAa1IKQyQ/jqRQdYfU3TlnySgOUI=;
        b=HX+JFFNSfFn4imaRxpNfulZ/0fycGV/WdKk51ObnKRrbotGQlZPYHXa6yhoyY4gWP3
         DIqcgVYoABASDYAwBKrBJNg+EjxlKvdbE+RrQtdaWLkmaEzFmbuRW1OsiYt9o3y/oWuW
         MMvn+G28PFIlBlwMjyRTpBvA3msZjQt+s7DOZ/2pDU99By+HKg+HEj02glxRKrplxMs8
         XcWOx2Fl5voghFrxlfkHXTOtTwH5SR6EFA5cDJ2ggX7YZonntG5PRmRW1fdKJfqRzaAp
         MycccLiK9saGn89Yw5SOf3WRjeaszR0oIGEWHev6nhHjNDf5N+QbVp4l9KIQ9L0CFgM+
         33Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704791789; x=1705396589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S5ZhSIArRTK4RfoHAa1IKQyQ/jqRQdYfU3TlnySgOUI=;
        b=ZhbBv29vukqyu86rBPHA3I64UVGJubMgcHY/C3PKFopefgOk9+kl9MiG/Wc4jubor/
         3LBv/Ot+bjZm4ErPhOKY+59udlDIDtVqL7DTK0sJ+30KgDTQ8z/s/uTDw5IO45jtMXoo
         gJMCQHWja2ST2JbgxUoi4t3yrH35tLpJ7wp5njRJgp5NLA/8SUhhFYHpP1cW1XC6OGqF
         bEyH4zRFp39L1/wHUpDHRaNTCxS9ERkY/Oe5PgRPC9VadZwBUvUH4lmd7d8do2OHxY9J
         FWRf/izP/SD5NAdcQPhbpQKkmF9m3cOBpPs/4QHtOvnOcBQ0Es2wFqmXZ9B/+CkGqWja
         w1ZQ==
X-Gm-Message-State: AOJu0YwOa7JTJr+00li4M9XSd/WSwNY2kmvuBeGFCK50dTrv8m8rWKoP
	XHXT3GW+TRfu2TAEw2bYZiE=
X-Google-Smtp-Source: AGHT+IFC+ax8l/GFUw9c+ZsF4JvmZfycyaUROeGLkmZUhFQLoxdei8HI92/lfl1mvk6eQcA1CzRmOA==
X-Received: by 2002:a05:6820:168e:b0:594:cea0:eeda with SMTP id bc14-20020a056820168e00b00594cea0eedamr3851277oob.2.1704791789026;
        Tue, 09 Jan 2024 01:16:29 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 189-20020a4a03c6000000b005963088920asm313287ooi.32.2024.01.09.01.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 01:16:28 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
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
Subject: [PATCH 0/4] riscv: sophgo: add reset support for SG2042
Date: Tue,  9 Jan 2024 17:16:07 +0800
Message-Id: <cover.1704790558.git.unicorn_wang@outlook.com>
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
 .../dt-bindings/reset/sophgo,sg2042-reset.h   | 88 +++++++++++++++++++
 6 files changed, 145 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml
 create mode 100644 drivers/reset/sophgo/Kconfig
 create mode 100644 include/dt-bindings/reset/sophgo,sg2042-reset.h


base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
-- 
2.25.1



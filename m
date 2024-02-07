Return-Path: <linux-kernel+bounces-55989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1CF84C48C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36DCCB22BF8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4F915E97;
	Wed,  7 Feb 2024 05:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZDGLJ1h"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8221CD19;
	Wed,  7 Feb 2024 05:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707285542; cv=none; b=GNVDzxF5PHGlFgNnGiKaVLPtpCWbv1kpYYJ0ZmMCP5BU9ODKgO+LjkoYSo9RsThe7y7GUEJfLqHQzN2atfaOQT/2TiEbAUfIwBFT/2jjRSa5r7AGOGUG1gg9IKPYFmmK2M8De1rFEIYrFwzqfrvzGToJq8ig4MFbJcfpkoY9haw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707285542; c=relaxed/simple;
	bh=t+07vSCtQrMTARa0gnjUaC1zB1Rmh/ABvCeTKkGD6t8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NGKYaptVZd/cL7LKmyweSC/bHAUYCaFSRTfoxr5jYqQLr+FX9x1bUVNpdlUL5lvw8/FRRahVvPWdhSyBanaHn0auh9xIKOhydCkMPE2EID3s6UhZdcKIFk04HHRraVSzH9mnjJCI/1J6cn9VqwwlnKmTgKvLXnSyP5yX98knU4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZDGLJ1h; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e04eca492fso202160b3a.1;
        Tue, 06 Feb 2024 21:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707285540; x=1707890340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GoTOTDguJ93aeizwcDFxhm41O6QP2z7HpzyOJGDVWFs=;
        b=AZDGLJ1haYL1JQ7UDNsXx8LX+W780NnvXL9/mgB2/IVkUgRGBGb8j6VSMVXZTdu3WE
         JjP1GcA/P/he1wbNS3OcvO7gR6BH1J0jgsfuDwl4CF6FhkI+ddBZa+P8M1AiavTNFT3/
         x/ymWHh+UdgxWha05B7mXbr46IXTRyHkI3Sb/utrPbHYuwm97xwam5hCuPgzitYjd3/c
         1AmIkqenakkb5Kdfgs3nf/gOEuVqBlBdMQMYObRMgbIJVbWHeIo4854a2N0OiUYOLx71
         qcra1653DD7O08MDxfuYJvU5gYfh48ExkfOeUyLNjQ+f0SsX99tSHL5ldq/JnOqw2Fph
         k6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707285540; x=1707890340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GoTOTDguJ93aeizwcDFxhm41O6QP2z7HpzyOJGDVWFs=;
        b=wiW9Ig7FKHFgks3wDuZfupD/B/0zH5BgcWuJUM+MVqZMKIMaDRcTzWoWKvBRMvT/tP
         mavhxfcZRDTuVGBfmoSBtqz6lJuO0fHfHveBZp7YAD7dC1WWh6qotUtqjcWvrJXygZDL
         OykFHrXghJYwnDPF8yGmBWHYAx/Igfuv9KyAeWg0xJbQ3tkv666/nTridHzJ6o9MyBKl
         7LdjlA8Te3xoRXhJX1FiWJtzkDQXa0NpNCOfd5L6gbgvj4Z0NPMmDFXg3kWrNu+VynW+
         1ScNNVaRQqDk5m2XD7p4a4VYEVxqfDJqEdiT5gktK4InFYEmK+4K/XwncAdJJIz7qeWS
         bGtw==
X-Gm-Message-State: AOJu0YwprIPb9cVeRczIsu8NZAtJrnaDM0DZ0HxjiSrMnb08Mv1gL5I8
	zpQ5UCIZYlFEJIxMpH5ehuP3fH8CjcG1betiMpBO+gRgmBpvt/8W
X-Google-Smtp-Source: AGHT+IHouwaipBmRkx+W7KWEdUOgEFQA6s0NO3f9JB/RNKrVn2g/lBwp4jn1iD/vuXVjhqmTUQmVgA==
X-Received: by 2002:a05:6a20:d90e:b0:19e:9c72:90ab with SMTP id jd14-20020a056a20d90e00b0019e9c7290abmr3782447pzb.18.1707285539844;
        Tue, 06 Feb 2024 21:58:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXVPI7i3B1PMoZ1+rjTSmjarSOryk9owdORs02dNENYEWKFELT2v2icTKV3yLCHJ4v8NWtNY3IPncbQ40E6T4qmrzmazMDx/6h9QNdXlz//ZysmB/OFLojMCdAm2w+2Y/e0nHjzERO34NTK57LtWPPHpiJ1zUaxbnVts7x15Kv6RO5ljzsouWePpIwRm6EgjsnYrd8AniRDyU4kCbgQVQ9pJ9w1s9iJ01yYaUf0dO7/9n01eZBePLCcDzeOp6p3ZoG4eMol0HT0qEVXMJtFT3NqSR0+BxDEsXMHUZ8+YCcUG3KfjZNLzE83nL36kusfeL+zmmNXGklgE48gS+MtP8MiupY+KdBfEJ6KQHtT3uCMIWTSp3mLInXVBbAPi/+ovVahKwr2HykMrvk5ihR8YT/dE3ZP+ONWhbX0TsMfcIT9/XylYTPlcq3DbdBlrz/Mz4IZriiiOKQ73bBpc+oe
Received: from localhost ([46.3.240.105])
        by smtp.gmail.com with ESMTPSA id kk8-20020a170903070800b001d9a40f50c4sm533777plb.301.2024.02.06.21.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 21:58:59 -0800 (PST)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: u.kleine-koenig@pengutronix.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	dlan@gentoo.org,
	inochiama@outlook.com,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v1 0/2] riscv: pwm: sophgo: add pwm support for CV1800
Date: Wed,  7 Feb 2024 13:58:54 +0800
Message-Id: <20240207055856.672184-1-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Sophgo CV1800 chip provides a set of four independent
PWM channel outputs.
This series adds PWM controller support for Sophgo cv1800.

Jingbao Qiu (2):
  dt-bindings: pwm: sophgo: add pwm for Sophgo CV1800 series SoC.
  pwm: sophgo: add pwm support for Sophgo CV1800 SoC

 .../bindings/pwm/sophgo,cv1800-pwm.yaml       |  45 ++++
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-cv1800.c                      | 218 ++++++++++++++++++
 4 files changed, 274 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml
 create mode 100644 drivers/pwm/pwm-cv1800.c


base-commit: 7afc0e7f681e6efd6b826f003fc14c17b5093643
-- 
2.25.1



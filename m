Return-Path: <linux-kernel+bounces-161485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E608B4CA5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD551F21542
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E146FE20;
	Sun, 28 Apr 2024 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZuMl3kab"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D406F072
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714321207; cv=none; b=VsUm4ckMRRbK0oCqYKOveWgmJGqoVGzTrPPYJxyQTpNSlR8bCPiao8iDepheS0FBUVLqFHc5QiIw1XKtPP/PQvqBp+mS5uZGkuZ6sVCEcdNw77zEcUyQV2YrdyjWEL+LY9b+n/3BpACIJCNShCE3vxgxPafKkhkPbR7B3IcbVNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714321207; c=relaxed/simple;
	bh=c4iAuXANxkyaFARjZ7T0cXAt+fVdYbYegOBH3TKfk0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SzgvX9pHaD+mUYveuHRgX9ZK/XMHhO5CFKtwSaVujF3dZptOZ6zWr4AtjWc6geE3S3wPe6DcpfJ0091wMSqmrAq7zguT2lIM/keLrnRrR3PoE88quQlAO6G++eqUkkaVPjbKMJlCkZz777G5HkMT/k4Xnlz8QuPjGMHgiw2uCes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZuMl3kab; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a58f1f36427so92240066b.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 09:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714321204; x=1714926004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FASynAs5IxrMDovqRBLq0gB6byYA6/mpBMhiTARocxs=;
        b=ZuMl3kabH7+0uTZXsRqXWlrxtMWeEgxAq2OgfGXy9rGk/13qzHLfjuRh+QAi3He6NS
         qndJL0E2E87ZhtMk9t6mW7Oi+/wUEtkLKTUIAz/CUY8QJyHELJVsTwbNZyL9IJE2DKDj
         H0KJfoSJQ031liIUo3yTczslKYXEZgx+EDJb8ZfP2TcxHYlUBE7WRZPLP+mOhWZzEPRV
         /NXImfYvQR8C7+2ZgmrXYomA4b8iFFyaWEv10mWAiQpHMtM7eF4xAo0UTyvNbOPPmp88
         rADXP6i6VOhK3Se/bvE/NmLOabVOKg+mKX031qsJG06s5qBbtvN1y0DNbEjrKX2o1Qv+
         jJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714321204; x=1714926004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FASynAs5IxrMDovqRBLq0gB6byYA6/mpBMhiTARocxs=;
        b=QsEJEv6pB3y9ZyK2f3leRuSp8CK744Q1saEPPgDrI/X2PbzVLvCjYy99NwzwjxqT7l
         rDzbK7UhdkwzpQsdEuzBfZwUckg0Yy7JYOdKiXg5kxVe7UNibbd/Ujf3xVJPxiS+Pi4t
         qD8ZrLUmHjsVDPlmAVXy5rYaSEEDKwXogFfSScGszVIIOpmGyhru+I+Kc43PqaVmIVOQ
         fsTf/46oA9fK/0m6gdVG8EQdGzlgfymwbPK13XcmK4FM8iX2QCarzr6Ln9tLeqbdDH+8
         SkppyAnjMyy3xja2P/tzhM1T7C/l2MfoNpyCTFIpECvevTqpvuBGTNgnbtWoD3p4KFpK
         8kFg==
X-Forwarded-Encrypted: i=1; AJvYcCWQP6xXCHRFMawO77lQA8pNlqiwVObVbMeqV/rZb0CylgMmVsDL7gM8iY4e2szPCldbFrkpFY2yoNOZTttsNsRiN1TwN2ityyL8N5mg
X-Gm-Message-State: AOJu0YyMs23gjJcQXTbv1Depsqhtdjo8lJUQ0bc7zP+Tv8m0U1zY2dd3
	IlhbF9Iw32ZYV5oFhmrhPr4r42fwKyL1zNGLsWIQgn2ZO8e1MQYayY87918Atj1UDRZ6PGo+EPD
	Gq14=
X-Google-Smtp-Source: AGHT+IHUbZG5j4eAjiIEASfxJU33DsXgl8sNmmmfQQbZA+L0ob/0eeZAUp3u39qVBjAlNmwaZu7ueQ==
X-Received: by 2002:a17:906:6d3:b0:a51:a288:5af9 with SMTP id v19-20020a17090606d300b00a51a2885af9mr4805711ejb.51.1714321203930;
        Sun, 28 Apr 2024 09:20:03 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id u3-20020a170906b10300b00a52552a8605sm12886738ejy.159.2024.04.28.09.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 09:20:03 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Olof Johansson <olof@lixom.net>,
	Arnd Bergmann <arnd@arndb.de>,
	arm@kernel.org,
	soc@kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: drivers for v6.10
Date: Sun, 28 Apr 2024 18:20:01 +0200
Message-ID: <20240428162001.28011-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.10

for you to fetch changes up to bf11908757eeab716536d16a32693b5dcd6990de:

  memory: mtk-smi: fix module autoloading (2024-04-11 08:22:26 +0200)

----------------------------------------------------------------
Memory controller drivers for v6.10

Few cleanups:
1. Correct module auto-loading - missing aliases in the module.
2. Document bindings for the Samsung S5Pv210 SoC DMC memory controller.

----------------------------------------------------------------
Krzysztof Kozlowski (3):
      dt-bindings: memory-controllers: add Samsung S5Pv210 SoC DMC
      memory: brcmstb_memc: fix module autoloading
      memory: mtk-smi: fix module autoloading

 .../memory-controllers/samsung,s5pv210-dmc.yaml    | 33 ++++++++++++++++++++++
 drivers/memory/brcmstb_memc.c                      |  1 +
 drivers/memory/mtk-smi.c                           |  2 ++
 3 files changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/samsung,s5pv210-dmc.yaml


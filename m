Return-Path: <linux-kernel+bounces-146569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A55B28A676A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A05B1F220F7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE4286250;
	Tue, 16 Apr 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHNgwoEa"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC953FE2A;
	Tue, 16 Apr 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261029; cv=none; b=Ue69jMq65sjrW6nXrvP5tmfE4FlySak2ZXlbShIL2wNvlYqy7Hm9j+g66QfMWJzOfOy6mLI/m6HybD2VWmTyLLZta4bhCYR87//btZyXnnp+tsWNQfhaTPZGjNU2JxsPdNYan/Mn4008biEwkr+6kFLgM/NpIV2KWUX0qaV5C20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261029; c=relaxed/simple;
	bh=AmL4OzNOa5RSLZU8EnoXbFMAeiXWA1+x1kMtQF2XERw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WF+QEyiqa5u1rbp/FxyLtodmH7tMy6xlK67i3w9iSuJ5i9HqyibKycB81oQ+Du7hyFM1PXpUgFaeWRA8Olpsy5izhH/ATH/e5ztp+7z75az9dSrwg82eoYQ3KoQzcc6j7bTaGBb+8hOyp1kVh6ykqlTP5VZYFh4v2kvCedLASlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHNgwoEa; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5aa17c69cf7so3033026eaf.2;
        Tue, 16 Apr 2024 02:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713261027; x=1713865827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AzPu/UiUvA3k3gEc6xFuTsUjWTRQgYweYisjZPbivEY=;
        b=OHNgwoEavC/a/ubPpkYKWMXIy+mA16+GoURqTW3NbxzrAwg82VUFHdINat9jOemO3P
         7d9zMKHVNpJNOj/EM0hVkiLSoehb/UCxbhaX9x936QNkK3oU6C4vFU8IBbMsn7IJLVWO
         kjRmlIZ7c5Gpxg3DMqg/vmTe/EjE376BvpWJTFnYnmGyTGiFmrPB6xoCCQ669n8AyA+Y
         mXKHWV+9O+J4pt5YJ/6VrdlrTc4HxyiVOyUTB5TUz5s0MnWEUjM+OnKVXyhLhMw4IiHa
         g9pn3G3+RA6xnGt/DAD+0jPXt1IcXjTQAseMbvoJsY30IPWGKEAUB/hW5Df009m1wL8r
         CitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713261027; x=1713865827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AzPu/UiUvA3k3gEc6xFuTsUjWTRQgYweYisjZPbivEY=;
        b=P2LrSpVBFnLjjMUvOCywNT98S4WO8Z3DFw5u9uaiFvpm8weMudlMOV6T1VKvFgN0ie
         U9qoisFgA/5qfQki+BUl/OUmmrGGPOpefC9vMlDQFr0i4kzD2pXbbxHZW0PBigV0bUnk
         rQsxab1Wdomza2xlTNUjJKc5/QPhVdftuCMEW9egkomgD9fgy6wijgbttRc3JT8Ptlhh
         opX6HJR3KmckxzHaCS7GNCdrYl0Z6ppswM8X33w367R/E+dBvG2lpPappfcnMRcT/IRq
         iZiT3kvm1sbGxDka4s9pofMFvQKrwOJJ+AGV4YIRTPpMQr7i4vncqBacrIMcY8LLj48x
         3rwg==
X-Forwarded-Encrypted: i=1; AJvYcCX04335TyQ8duxuOS0wjAB+Zs60xLMc8tbgQToBgSH0QaKHyvxmijpmtEICZ2dTsN9ObtjzED054k1btOUKa8wWGBR6f/QX+bEwYmwcp6A5FJKEBbjVYsFsofaJHWnAQSUhYIwOJvheN5tFXppV/E9B9cRVZW8VOHgv+DI6eAX2WrI6Xg==
X-Gm-Message-State: AOJu0YzoEUS2pbUPWGADK0dGhNpc6ezn9NfU5esdcwrTz4Wv8Y4pfWm+
	WGDYs7uXEp9Z/nkxgj5+CsF74S1KBnBDDFRmRdRgC2nyPKYjh3oC
X-Google-Smtp-Source: AGHT+IFnGRfaqTMKMw+sqVlviPGyiJjLh5HEIewQkEWrBktvio2oxeHymaib3oW5wQ8ddqOkyMzKGA==
X-Received: by 2002:a4a:1a85:0:b0:5ac:9e85:59d8 with SMTP id 127-20020a4a1a85000000b005ac9e8559d8mr5605165oof.1.1713261027313;
        Tue, 16 Apr 2024 02:50:27 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id by27-20020a056820201b00b005aa4e48efc3sm2460056oob.37.2024.04.16.02.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 02:50:26 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: adrian.hunter@intel.com,
	aou@eecs.berkeley.edu,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	jszhang@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	ulf.hansson@linaro.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	tingzhu.wang@sophgo.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH 0/3] mmc: sdhci-of-dwcmshc: support Sophgo SG2042
Date: Tue, 16 Apr 2024 17:50:17 +0800
Message-Id: <cover.1713258948.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add support for the mmc controller for Sophgo SG2042.
Adding corresponding new compatible strings, and implement
custom sdhci_ops.

This patchset is based on v6.9-rc1 and depends on following pathsets:

- [PATCH 0/1] mmc: sdhci-of-dwcmshc: enhance framework [1]
- [PATCH v14 0/5] riscv: sophgo: add clock support for sg2042 [2]
- [PATCH v1] mmc: sdhci-of-dwcmshc: th1520: Increase tuning loop count to 128 [3]


Link: https://lore.kernel.org/linux-kernel/cover.1713257181.git.unicorn_wang@outlook.com/ [1]
Link: https://lore.kernel.org/linux-riscv/cover.1713164546.git.unicorn_wang@outlook.com/ [2]
Link: https://lore.kernel.org/all/20240402093539.184287-1-bigunclemax@gmail.com/ [3]


---

Chen Wang (3):
  dt-bindings: mmc: sdhci-of-dwcmhsc: Add Sophgo SG2042 support
  mmc: sdhci-of-dwcmshc: Add support for Sophgo SG2042
  riscv: dts: add mmc controllers for Sophgo SG2042 SoC

 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |  67 +++++--
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |  15 ++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  32 ++++
 drivers/mmc/host/sdhci-of-dwcmshc.c           | 173 +++++++++++++++++-
 4 files changed, 264 insertions(+), 23 deletions(-)

-- 
2.25.1



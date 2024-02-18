Return-Path: <linux-kernel+bounces-70488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE65D85988A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3FF1C20F22
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4128E6F079;
	Sun, 18 Feb 2024 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rl4jbnV+"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ECF6BFB0
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708280824; cv=none; b=OjcUDPzHh7NhrKTgjpLyoqUziatmZV3a0shi8jTDOwmoEvj9G8mEpXxvxwAR+I3l55LIQeS5JKRfg44bZOwWOhxUUEq0OnxWBSoNWjba0LW6yMM8hnrN/r1nu5VZKUYLm+i4onsfJSkwRXOmEu5UZ73icHW3Bw8HTXVxNYNrpLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708280824; c=relaxed/simple;
	bh=h+8YSK5EbUCVVcPv/5kUVUOYAs8nPjnuNS8a9vxhy0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=txFf2SqlksdmiQBujjw+2/7jBsxjwtGOpjlgvaul0jbWP0XO0g+SuSnjausnO5k38RBH6fEfrVn+1oGsUVe18NYfIjOcwe7XhkKyVu1MFjrrGgjn7fyMucDOxbGpi68usebXgV4HJo9gGGzHTKZ4ZmvupqLAFAqB0RDDuF2SZoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rl4jbnV+; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d22b8801b9so18308461fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 10:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708280821; x=1708885621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bcQ97OFQNs3R16kTM2aR1AcH40aXNgteh4fPRKCJudg=;
        b=Rl4jbnV+IoCmew+LWaP8DSPjiPDs7TAotds1RfTAXVMigljlIXvZGzwiKCXaJsxVgL
         2a3iTn5IA37y6NCTol7lsOd3vmeEn9mvqBRDbhSreGC46FlzMZeW1EaSudJvXs5xDGVM
         QhJ0JUi5qfwCDsephcP9m2ljDSPNCCPQgE5K5XpUdrLGD+n8CiXvNKjTdDeYf42T9ghZ
         ZXRWICyxahn0wtnpI94gz4KaQPz7CoKUdTCyypk6OJxobq0O5+bdoifeCajJV90zOzO8
         x2qyY5s/6trUhht7KI19x9P7faMtJdywkj5affj/1TlZO0tIW2CnWdggXFEHLnYAJbUt
         UUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708280821; x=1708885621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bcQ97OFQNs3R16kTM2aR1AcH40aXNgteh4fPRKCJudg=;
        b=b9CimND4fjegaWbNIzOMCt4wdlMxV8AD85eLGX89QE2pp5Axj918joh/ESAlvtv7AL
         KsMtaofudMEPsaioaeq0drQGsNTo+mXKRmkbHCEOgbmc0PQFPfgyQQchUyZttYHETqAp
         GEgj1v0Q0O0OGBbWrqs00AC4b3oO2CepCYq4/EhJtcCdgkpbtnYGB6dAPeSyh631RiNy
         BsnVKNAiMvf3Yctf5W7B1kzUzZlADAZN8LdY1/vlFX8Qvopcrerl2OZSlw2HIk9ip1ky
         X3CS7FaFVINNSNOnis+5dGPlfmo8k59ktCuXrVh6oZgVwFuVhCu1++zYTkS1FMXo/eQJ
         98Jw==
X-Forwarded-Encrypted: i=1; AJvYcCU96wkAqDb7YYRWF0SHlS8fWYlH7s6j421XqsWBIMEajTKw8D3msbG3E24FxOWbzEsPW2OrrFapgWxF8GTGQpT4eQV6UfC7bWUK+r0c
X-Gm-Message-State: AOJu0YzBB8GOFDnS34n4AWtCQPrhmUmUpmceOu/h4QQ6L+B+e9tOJ5AI
	V5qpHbEbXtrXhZMP22862tquE8ve1RSUHWkvbNB28LbIGP3dTGMV7bEgA8udU9s=
X-Google-Smtp-Source: AGHT+IE80M1z/F09P03IHlpRGx7t7Lw6zDY6kyyJTY7Jo4EVo8YoAgu0THGO93HaW3bGoE36IXzy7Q==
X-Received: by 2002:a2e:300d:0:b0:2d2:39fa:822c with SMTP id w13-20020a2e300d000000b002d239fa822cmr500915ljw.35.1708280820849;
        Sun, 18 Feb 2024 10:27:00 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c231700b00410b0ce91b1sm8698796wmo.25.2024.02.18.10.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 10:27:00 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Olof Johansson <olof@lixom.net>,
	Arnd Bergmann <arnd@arndb.de>,
	arm@kernel.org,
	soc@kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] ARM: dts: various improvements for v6.9
Date: Sun, 18 Feb 2024 19:26:56 +0100
Message-Id: <20240218182656.32103-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/dt-cleanup-6.9

for you to fetch changes up to 8c82b4eef2972200f6171aaa260d7bba2ad29889:

  ARM: dts: sti: minor whitespace cleanup around '=' (2024-01-26 15:30:45 +0100)

----------------------------------------------------------------
Minor improvements in ARM DTS for v6.9

1. Marvell MMP2: Very old issue, for which I sent patch back in 2014.
   Patch was never picked up and now another try to fix the same
   happened, so here it goes: use proper compatible MAX8925.
2. Marvell Dove: add proper unit-addresses.
3. TI DA850: add MMC interrupts.
4. STI: minor white-space fixes.

----------------------------------------------------------------
Alvin Šipraga (1):
      ARM: dts: marvell: dove-cubox: fix si5351 node names

David Lechner (1):
      ARM: dts: da850: add MMD SDIO interrupts

Duje Mihanović (1):
      arm: dts: marvell: Fix maxium->maxim typo in brownstone dts

Krzysztof Kozlowski (1):
      ARM: dts: sti: minor whitespace cleanup around '='

 arch/arm/boot/dts/marvell/dove-cubox.dts      | 4 ++--
 arch/arm/boot/dts/marvell/mmp2-brownstone.dts | 2 +-
 arch/arm/boot/dts/st/stih407-pinctrl.dtsi     | 8 ++++----
 arch/arm/boot/dts/ti/davinci/da850.dtsi       | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)


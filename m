Return-Path: <linux-kernel+bounces-163498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF15D8B6C26
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F5EB21D35
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DC83FE46;
	Tue, 30 Apr 2024 07:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2PvapAo"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CA214AB7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714463423; cv=none; b=B2/x5mf7tkA4heYo95sGHGgMz/qpHKww1qbu0ftOaIL3RpSt2mw2oYmBWg44E8+y1f2TCWkbGgrQu8P+2/kirZx5c5Y7ZUBE0YZfV39k3dfck3a2XmNNDzYP4hIsb0luO8MLCiSysIySRT2EjodhIfC/10B0nUwdJFivSJxykSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714463423; c=relaxed/simple;
	bh=EF5ldR5uHG4JPFXib+OoLVUeB+8jGp5a6KVbR8bCpok=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mUli+3w96K7ocDK0QhHdl1dmdb0pY1hlh3zZ2c1dygNGEUhmijbFTxs9fcSkKfwBEzC92kIFPrsFkZOZ2pwHHOHEQAA4DQHgrHEQph9VBrgfj0FkCZcEdSAa4jecTzmBDZTaLiYqc+5JRkxcQ2t5GE1ynk/b4eXqmGDexb6jakA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j2PvapAo; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dbed0710c74so5015809276.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714463420; x=1715068220; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oj+sxpJnJ9QMTH6odiZZHrnV6iIJzPyVwEyx8Qt7Yr4=;
        b=j2PvapAopCa8bZa+r3lyvJeDQrvCVv8ggMVPuyc/WtwfrHi1rcvYRK+fnN4OVuH7ba
         kvjjCUQxKNWlOsOhUKADkbJae/Of7ndH803udPQW1w5v1sGZ4hHZh1a37B0oVreDp5CC
         Imu5S37AHhqAFCL5lriPxLhZl4UkvsFXmegZHsOtIonb3s5m1WtjPpyhE2N1mGsJVa3H
         4RQDz51KQWB8/Mw/0sQv61MGv0CSyLS3+nMeUb5RVILNohw++1T4niq5HMofOxFIHqUz
         KNVNJYaPqtpfNzKjOS1LN17+ZdKfGDuTp4yZ5qAlS3JPSqhYWlGjpkZB9v+o2BpWr9aS
         IFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714463420; x=1715068220;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oj+sxpJnJ9QMTH6odiZZHrnV6iIJzPyVwEyx8Qt7Yr4=;
        b=wAyAY5aM7QQR5x2zbR6/nMu/1DWi5nNA4rIJrWTtfmC2cWbj1Uy565Frq7lCiWath+
         E3AxvnuDDck8UzzbX26ze7dhhjdgSYWPJ/vpAEGilgYUCASX/LlsQL9jv7ku5zBH7hy7
         2N7AAoJKw96XHTSyMWUXsxhm9mnrWf7AmxZ+mVpeA2C6CZA47EMxMSwosN++Hix9Kmbk
         /ZWc5XkDfc3h+RcZ2lXcHBuaYDynn8WyTJ+j1Qa/uEn0rJ3zXd4kknI7kQzjiHY/zJCq
         LD+Zqz9T3rHP2TqKXdorZbJG6+BQQAEQBTrEDwd6t2Pwn3pwwiaSCQYo46l8Qof78XHi
         WfPA==
X-Forwarded-Encrypted: i=1; AJvYcCUaGGtrgmxzAh1p7NaX6SAQ7beDXM/SRu1flrdRNC6OnI/T+bnsUE2/pm/cR2whw14Bq+Vo4BAB1YYoTN5Wzj5T310XNzL/GuqKY/6m
X-Gm-Message-State: AOJu0Yz+PQGnXF+O1qCo1n/KkhQzco4RjLQeNIbp6K/UYA43KiRbrHWq
	povvFtkluqENqEQkO/gU6YLEjXm7wElECU17T5dLcGDlb3LpH1A0Eu6YZ+98k5O8U9ObJsmLl/f
	UmXXMDO9Leu8QGeCJqjgBNxY57aJbZ5V88/aNkfPd70vbmVD//38=
X-Google-Smtp-Source: AGHT+IGU4SuKe0UpNrDwFY40H12oekaJKWL2kVjkqmbbeng6qEuGh46nbB5bbdPVn+o/CpqYY4EQzeLKzLkDJjn9YZU=
X-Received: by 2002:a25:558a:0:b0:de5:5a6f:a52a with SMTP id
 j132-20020a25558a000000b00de55a6fa52amr13565292ybb.26.1714463420128; Tue, 30
 Apr 2024 00:50:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 30 Apr 2024 09:50:08 +0200
Message-ID: <CACRpkdY8HPt5SMmqpuo-GKGf=94U7E9=5-eYiMpoJXv6kMJB7A@mail.gmail.com>
Subject: [GIT PULL] Pin control fixes for v6.9
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

some belated fixes. Sorry for sitting on them for
so long.

Details in the signed tag, please pull them in!

Yours,
Linus Walleij

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.9-2

for you to fetch changes up to ac816e9eb5cdae3d33a01037740483db6176013a:

  Merge tag 'intel-pinctrl-v6.9-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/intel into fixes
(2024-04-25 14:30:54 +0200)

----------------------------------------------------------------
Pin control fixes for the v6.9 series:

- Fix a double-free in the pinctrl_enable() errorpath.

- Fix a refcount leak in pinctrl_dt_to_map().

- Fix selecting the GPIO pin control state and the UART3
  pin config group in the Intel Baytrail driver.

- Fix readback of schmitt trigger status in the Mediatek
  Paris driver, along with some semantic pin config issues
  in this driver.

- Fix a pin suffix typo in the Meson A1 driver.

- Fix an erroneous register offset in he Aspeed G6 driver.

- Fix an inconsistent lock state and the interrupt type on
  resume in the Renesas RZG2L driver.

- Fix some minor confusion in the Renesas DT bindings.

----------------------------------------------------------------
Billy Tsai (1):
      pinctrl: pinctrl-aspeed-g6: Fix register offset for pinconf of GPIOR-T

Chen-Yu Tsai (2):
      pinctrl: mediatek: paris: Fix PIN_CONFIG_INPUT_SCHMITT_ENABLE readback
      pinctrl: mediatek: paris: Rework support for
PIN_CONFIG_{INPUT,OUTPUT}_ENABLE

Claudiu Beznea (2):
      pinctrl: renesas: rzg2l: Execute atomically the interrupt configuration
      pinctrl: renesas: rzg2l: Configure the interrupt type on resume

Dan Carpenter (1):
      pinctrl: core: delete incorrect free in pinctrl_enable()

Hans de Goede (2):
      pinctrl: baytrail: Fix selecting gpio pinctrl state
      pinctrl: baytrail: Add pinconf group for uart3

Jan Dakinevich (1):
      pinctrl/meson: fix typo in PDM's pin name

Lad Prabhakar (1):
      dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Allow 'input' and
'output-enable' properties

Linus Walleij (3):
      Merge tag 'renesas-pinctrl-fixes-for-v6.9-tag1' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
into fixes
      Merge tag 'renesas-pinctrl-fixes-for-v6.9-tag2' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
into fixes
      Merge tag 'intel-pinctrl-v6.9-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/intel into fixes

Zeng Heng (1):
      pinctrl: devicetree: fix refcount leak in pinctrl_dt_to_map()

 .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml    |  2 +
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c         | 34 +++++-----
 drivers/pinctrl/core.c                             |  8 +--
 drivers/pinctrl/devicetree.c                       | 10 +--
 drivers/pinctrl/intel/pinctrl-baytrail.c           | 78 ++++++++++++----------
 drivers/pinctrl/intel/pinctrl-intel.h              |  4 ++
 drivers/pinctrl/mediatek/pinctrl-paris.c           | 40 ++++-------
 drivers/pinctrl/meson/pinctrl-meson-a1.c           |  6 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c            | 14 +++-
 9 files changed, 100 insertions(+), 96 deletions(-)


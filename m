Return-Path: <linux-kernel+bounces-77974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 310E1860D96
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FAE51F2350A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FD91B59C;
	Fri, 23 Feb 2024 09:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="24n8K8CR"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6F917BCA
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679306; cv=none; b=kIW5/1dGnlYVzduwT/Mtr0bMwkZYOa61pxH4s/6xeQI2qsNUWRLX3oP0r3KKy3JRi374pZDPxcLKjIpGjWRakG635BSqMGsRcKruONlzTD1I0zbi8LSm3F/c0nvIh15oCZW/z/mhWvzKXJH6WGqUDtbSLtBupA+jWcEfeceCXLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679306; c=relaxed/simple;
	bh=vnc7+8egw3iIw28VFsuYobT0LI4KnsWmvInroxJ/0jo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WA7YiT/4EQQ6fEuh0u0QT6BaSV7UDAQ1pHQjjr7LYhFKvnYwpvEd8mEIhcrAhAH8zYZkZnkTbpmZaWOTRvqYCKm2lYmtarvENIqaac801nwTOj/32s6LOx8CQ2ZKtfehXJ5cPIy9oUXUSaGXPBC9CPNopu4OP2JOZr+HTevHL0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=24n8K8CR; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512e568607aso88756e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708679303; x=1709284103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TZHnXaSNGGM/8tmbQNRUWUJH3wRK39Jqt0Yama7CqjM=;
        b=24n8K8CRPjlkuQXY9LKEKNX+OBxA2g6dq5qyi4MxEZ6PVHhLKOV14hhX6WKIc9ENKD
         MpkOFN4iyfCfrUIko89N8ad29DqOI73UNUoh2aCGf7e4PjK1Ok/4ua5IfKksIMzRJfP5
         a2F+iTTjC8nKx4QBEtt4Kw5Y3gjydVRCta5Th2u331tUT9bBkx8t6jj+XpjfrUP6FOkU
         R6y9JGTPOsiLC3ilisvvhZO5QFsTh70Uc4rernanB395wVITLNJJpNt4hPUOEKwZUedX
         Ot+WUn8OsNBj0xYKd/PZK3oJuxtqY9PYCk92S6cddIiZp21UFlivH2mNwf0usGa79svi
         1JmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708679303; x=1709284103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZHnXaSNGGM/8tmbQNRUWUJH3wRK39Jqt0Yama7CqjM=;
        b=sMHxoasVYJUHDl6Ltw3DRYEvGQMXGnRb6HFVRnnHtqfhUic5WTKRa90xv5uKNxsZTu
         uJfR/zLXYtJiCqbR+KE4dMSokJtsFdZH3gqG4VK1jC9zApuh9SwrxKbZrZAKQqekvzs/
         xo7s/GmgDBVP585ca63hC7wXF4+BZ2VTdcAAVUDxfSuYS/fOKFKk07nFsoXBWczY+L4G
         ku6iCldzSF3bkjlenGq7HLJpIbEs5DvhSwdcCk0RHU7C2Tga/i1m1hP3jih4Rox6KH/T
         dDPwYH0S+vWVeoc3AhW78A3t0aSUWVmfFwuS30BDw4kdrRrBUwpXdMWpSQUcKFwD3OFe
         yztQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfa9bWzSAkJo8QvE1XiSF/h6K8VyPS1u2XhZ82NkfcZ1lZcaZUeFVuHkEK/fQu5e58/FG9Zk6sNSoprFtPUDdp49M82AZ+9micOdaO
X-Gm-Message-State: AOJu0YxQskDPliBBJrVhkNQ586Qgalij2+07nsg1sTkN5ys879spOfqL
	eGUwsb3t+pN0nv/a4fMGpLlS6UMARO2SsHpdckOpvhoQYZrbFLAGoyQHvHIbvvU=
X-Google-Smtp-Source: AGHT+IFKO/w/LnEyUSC1iYI3961a+SuU87FoCpSJhLMsEDF83U7W8+M8WE1giHFLjfgr+InuqZTZeg==
X-Received: by 2002:ac2:4ac1:0:b0:512:bc13:5ff0 with SMTP id m1-20020ac24ac1000000b00512bc135ff0mr959352lfp.50.1708679303459;
        Fri, 23 Feb 2024 01:08:23 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d13b:cd88:628f:8c6e])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c351000b0041294d015fbsm1231976wmq.40.2024.02.23.01.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 01:08:23 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: fixes for v6.8-rc6
Date: Fri, 23 Feb 2024 10:08:21 +0100
Message-Id: <20240223090821.15356-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following fix to the GPIO-pinctrl glue code for the next RC.

Thanks,
Bartosz

The following changes since commit b401b621758e46812da61fa58a67c3fd8d91de0d:

  Linux 6.8-rc5 (2024-02-18 12:56:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-fixes-for-v6.8-rc6

for you to fetch changes up to ae366ba8576da0135d7d3db2dfa6304f3338d0c2:

  gpiolib: Handle no pin_ranges in gpiochip_generic_config() (2024-02-20 12:49:14 +0100)

----------------------------------------------------------------
gpio fixes for v6.8-rc6

- fix a use-case where no pins are mapped to GPIOs in
  gpiochip_generic_config()

----------------------------------------------------------------
Emil Renner Berthing (1):
      gpiolib: Handle no pin_ranges in gpiochip_generic_config()

 drivers/gpio/gpiolib.c | 5 +++++
 1 file changed, 5 insertions(+)


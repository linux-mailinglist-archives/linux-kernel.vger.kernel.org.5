Return-Path: <linux-kernel+bounces-27561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AE082F23C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A294D1F242F5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0191C6A5;
	Tue, 16 Jan 2024 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsuCXxpI"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0C01C69A;
	Tue, 16 Jan 2024 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d427518d52so73161125ad.0;
        Tue, 16 Jan 2024 08:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705421802; x=1706026602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=P/cU0ufGt5VaJJABeZ5vsd8TirE4y4F9//uIian6DgY=;
        b=jsuCXxpIqGFeH0ofnQvW3t+GnKDvasinbVLfPISzf2SjheuZcbezqad1+rhSzOix3q
         S3j25fOH9/0+Uc0LquDtbEuUM/RlHyRlLilgRlxIe2AKTOcSibo6vpZPYD6HAVFef2dI
         ylxrJeHr6z4CNKptcUnAdPXacUYC7OnCqycc47TU2vqA3bvZG85QBbC94ZcCX6XkPD7W
         /5x3MdEosf57MiVmExEkNjD8laUGli+EF9ddi10Zkc/i5jWca4Rju4mJDp5OP8NK3UD5
         Fz09I4pk/UfUSEZ2IRwH+jpLDDXgskJm/tj6YxU6IO3GnDCtI1NjwpPCb4xZV7VDvH3j
         2TSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705421802; x=1706026602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/cU0ufGt5VaJJABeZ5vsd8TirE4y4F9//uIian6DgY=;
        b=RpKpHloF2lnO0MUJ37b9XQmGo8juWJcHEZZCk6Jl6nGdIb4KDk9SNv+JRpK61y8m28
         pDwutQ2J3LfjHLxzkPLs7/NN8IJIJzfTMX19NF0SaM3HV4UrHQJ5l0Y5vw9Ge0ILHF0N
         4L7doGF/umuF8fdHBfmbjS32Y6H5xgjZI51NHlIXjHz/TYKsmIBTJf5hJSMNFMrUhQiQ
         p+ZKellT8YfmdkT+RQTxTMR5C9CUpkeZ9KpKPdEz3zyezXox9bBNjcuQHdN9kzLmQpYm
         uYGzFkApK9/qmb6YWYndIibA4kw6pOrBV8tz+tjK8iCESrMeTtAo12MLfKhPbrppvI3b
         odcw==
X-Gm-Message-State: AOJu0Ywmt6ACpwvjunEIBnkwMPTWE/Vjoqo64AYda5DdsxaTOuANCQHo
	XobIxv9I8VWqzvVeKEz2ERrJEbZOsiQ=
X-Google-Smtp-Source: AGHT+IFEyycsQ3FG5D+KcB7ALfSC1dftEKQpgC1gAHUds42MpMhf37DhkUnxJ+oIgDPcgFbSq17+UQ==
X-Received: by 2002:a17:902:c94d:b0:1d3:d105:53a7 with SMTP id i13-20020a170902c94d00b001d3d10553a7mr11232497pla.68.1705421801855;
        Tue, 16 Jan 2024 08:16:41 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bh10-20020a170902a98a00b001d5e5836292sm1477778plb.130.2024.01.16.08.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 08:16:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v6.8-p2
Date: Tue, 16 Jan 2024 08:16:39 -0800
Message-Id: <20240116161639.1127810-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull another hwmon update for Linux v6.8-p2 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.8-p2

Thanks,
Guenter
------

The following changes since commit 052d534373b7ed33712a63d5e17b2b6cdbce84fd:

  Merge tag 'exfat-for-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat (2024-01-12 18:05:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.8-p2

for you to fetch changes up to 2539b15d504c3f9fd8ca82032bf9c80c9864412c:

  hwmon: (npcm750-pwm-fan) Fix crash observed when instantiating nuvoton,npcm750-pwm-fan (2024-01-14 07:44:38 -0800)

----------------------------------------------------------------
hwmon updates for v6.8 - part 2

Fix crash seen when instantiating npcm750-pwm-fan

----------------------------------------------------------------
Guenter Roeck (1):
      hwmon: (npcm750-pwm-fan) Fix crash observed when instantiating nuvoton,npcm750-pwm-fan

 drivers/hwmon/npcm750-pwm-fan.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)


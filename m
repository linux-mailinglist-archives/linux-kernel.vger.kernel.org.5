Return-Path: <linux-kernel+bounces-147158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2488A703B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF7D1C21919
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C82131737;
	Tue, 16 Apr 2024 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Okp++Dsr"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D579B1311AF;
	Tue, 16 Apr 2024 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282786; cv=none; b=Q0r8ufOAeKUqgJ1tC9zssIjLKDDW1xzWChyjvvxzpNBhMu4TbF8SFDYcM1xemKV5CMdcAyeeb+LuzqzNcNd6/xn9wIzUkMdOZ7Es9F+4WVqgn9uqPdPpFqLp+M0D2uLh7Idn3alNiWNogAAChJtbuhw0522XcacYjG3/LJxxO1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282786; c=relaxed/simple;
	bh=4F1ftmc816cykE/9NuGSNEt3mmFFAqeyLuLDqstyLGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KzWS/DtQEtACgrDvxQ9JOUau8s4DMnaGj/u84xY6U91nEVjM7yA4S80QoxPnMN2JjqESxFRHo/x2JAf+dsyNmle1N3btLwvcJ+C4NT0SBKnmQad0oz24vV8d7O9GCuYvCMkfuEAkI8K2q2m/p9M3k8ITlHJDae2Hr2bPtxVt/pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Okp++Dsr; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-518a3e0d2e4so2912553e87.0;
        Tue, 16 Apr 2024 08:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713282783; x=1713887583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DqKSpB0Bzz+WMQXIJGfS9a9HtVJnnDyWNP0C8W0ussg=;
        b=Okp++Dsriywg8X+B9VNfBJvQQvLrKa17i3wKz/xIAQCMVq1T8VA5oUZXhn7agzWjdI
         P+pPKFfFgEAuzb7YIdfh1QjH1y0+6TKTu15/CaGzkZuvl6gujs3YYhuxPNnm9MMPaX/j
         88Wq72GghSs0xuUMz65STxBxoq6rM4y1V2Nglo1715RS/l1bIjwNalSwnYEeAabGwelm
         CuBRsMzlEInH0E7a3+A3zkqvqbGo2nIBUUMfcN70svENGPbaaNQA7NrGmndW6jn/2EWV
         Ue3K+lB7zyfttv+kOjltgaLrcXyhbygecBemG83dsw0okjL/jnViL8S3tid4wSJPpQyp
         3Brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282783; x=1713887583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DqKSpB0Bzz+WMQXIJGfS9a9HtVJnnDyWNP0C8W0ussg=;
        b=w6TW/2jK/ljnvZDsSXuwB/E2uEWraSlGYxGQfnMPY9YONtGljFdblRvupyiWcRhu+y
         98p3u5ax1lB/z2xiONNLjpwLIOoTmk7jLK1Ka8Z1aD+C3V4lPvB1Ss8438bPdMYI19Ay
         LQfJigZIrOqLYaz0agoEh3Ulxjft75fB7I4CKCk6+agfzx/RIXhAl+XBthARKz3qENIx
         8e3ja8T3UgzbRQu0gldg+5xKrlFiSuBEfPHwu2hscvyBonhqChbZ32Lvxr8brQVgfTks
         0APd8JL34zAw2e/qRN3047eAKPuL49Sunyjoi5rbRAA51iCZc5Fw6mecfhCfhxFzzzVC
         8QDg==
X-Forwarded-Encrypted: i=1; AJvYcCUmW2q7T02mqyuzSNImJvq/C1D5Wsh/fgAAN02MGULiWmAtgErAYlRVXvvqCZLjKj79R9N1UfoOV6+ZhHDYshxKVQU49WtWokZMC4+fsTMAim8AR7TMfSEyUm5JjhCp7T8IQv6LuJL8
X-Gm-Message-State: AOJu0Yw1F7s+NkbaW6/9+i3uL48TEqZewe9ogW6bK0L+YkvlCSOj6hcG
	9coMKmsqZ79N42apHdpFNE0/FCnUOd1LuWV9VZkZ86DuZMTwu0VOyZtP4ki7
X-Google-Smtp-Source: AGHT+IHBDQKDbOqWxr28FcYhZUL/CWgKJ03FJ5BMM3V7PY29lsA6jlzODqFLGG2rXwGxX2StnowN2g==
X-Received: by 2002:ac2:5a4a:0:b0:519:589:d478 with SMTP id r10-20020ac25a4a000000b005190589d478mr749422lfn.12.1713282782708;
        Tue, 16 Apr 2024 08:53:02 -0700 (PDT)
Received: from localhost (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id s7-20020a056512314700b0051710d05a34sm1623209lfi.255.2024.04.16.08.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:53:02 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3 0/4] spi: dw: Auto-detect number of native CS
Date: Tue, 16 Apr 2024 18:52:30 +0300
Message-ID: <20240416155257.22429-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main goal of the short series is to provide a procedure implementing
the auto-detection of the number of native Chip-Select signals supported
by the controller. The suggested algorithm is straightforward. It relies
on the fact that the SER register writable flags reflects the actual
number of available native chip-select signals. So the DW APB/AHB SSI
driver now tests the SER register for having the writable bits,
calculates the number of CS signals based on the number of set flags and
then initializes the num_cs private data field based on that, which then
will be passed to the SPI-core subsystem indicating the number of
supported hardware chip-selects. The implemented procedure will be useful
for the DW SSI device nodes not having the explicitly set "num-cs"
property. In case if the property is specified it will be utilized instead
of the auto-detection procedure.

Besides of that a small cleanup patch is introduced in the head of the
series. It converts the driver to using the BITS_TO_BYTES() macro instead
of the hard-coded DIV_ROUND_UP()-based calculation of the number of
bytes-per-transfer-word.

Link: https://lore.kernel.org/linux-spi/20240215180102.13887-1-fancer.lancer@gmail.com
Changelog v2:
- Add a new patch:
  [PATCH v2 3/4] spi: dw: Convert dw_spi::num_cs to u32
- Fix some spelling notes (@Andy).

Link: https://lore.kernel.org/linux-spi/20240222172853.25082-1-fancer.lancer@gmail.com/
Changelog v3:
- Add Andy' Rb tag.
- Rebase onto the kernel v6.9 and resubmit.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (4):
  spi: dw: Convert to using BITS_TO_BYTES() macro
  spi: dw: Add a number of native CS auto-detection
  spi: dw: Convert dw_spi::num_cs to u32
  spi: dw: Drop default number of CS setting

 drivers/spi/spi-dw-core.c | 20 ++++++++++++++++----
 drivers/spi/spi-dw-mmio.c |  8 ++------
 drivers/spi/spi-dw.h      |  2 +-
 3 files changed, 19 insertions(+), 11 deletions(-)

-- 
2.43.0



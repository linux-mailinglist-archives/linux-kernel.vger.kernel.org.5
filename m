Return-Path: <linux-kernel+bounces-160808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E1E8B431B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5FD21F255E0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32546FD5;
	Sat, 27 Apr 2024 00:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAwpVyia"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F2B6116;
	Sat, 27 Apr 2024 00:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714176887; cv=none; b=Ctbr+Tp9eLJlwleBdcBymsPQNg/pV4uWcuRZre5jdoPwHPjcZ8XUAcI7euQAQMlreRn9cmcgs68LQwPQTMf/PD89RmqRTmcxWP3M24Ce/i/Qs8Cb1GfiBVTzLoSgTN0hCXeqjyiy08JAo+nmfOG7ypNLiNhbfvGrBCCXV9WsI/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714176887; c=relaxed/simple;
	bh=hcJaJfLMJFfzCLe9qFLyr3XZcJLOUaXp0xpxmscAAAU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BlTbcQTj+Vt5g+2G1O7dvNk9vk6nBMPOulzkBTMrvoCj22Lwm/ZrxIcdMKTwYgOWUCasXrz2MNyXlqpgYBfA9feNuJkjXI+NZDhEbp30q9YZLHnvyVx45Zp78hCA50Gp6CSAMP/nPzq5l62NdsIwswy/qlf4lG3rgLTY82OlBVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAwpVyia; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34be34b3296so1971972f8f.1;
        Fri, 26 Apr 2024 17:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714176884; x=1714781684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YV6AybQpNM5L7BmGh7OKWpSwXS2G3KXKiGflHVOVNWA=;
        b=gAwpVyia5JBgGKAxiTV1vrMcQlYeqZBRLWZUMMVAA1JxaI1W9Rrq/q/zSkhV4OfW2Y
         1jV/+qkB+6xHJGHqcUwbDRp/Nlb/SZftktLDYBCgzBYn6gimOW3jLidiDST7/UVEHXr0
         JVtxNAzNId4sr0jQeyfrrX7fyhL4LU7O9flYjf8atqkjZSVFIAWC6S1apzDAIGbz9TKd
         /8P9QhFBhAoWkjMC91UabLRVpvmf/JSX5jMXWH4pFDnNRn3pDrPDewF+otqKvt1fUMxy
         uAnzO6hhRybySQjIwCa6M5Bpg7vnU3e+uA4VqJWVQRbusiDRZ/Msaz4HSh9uS7TOruww
         op1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714176884; x=1714781684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YV6AybQpNM5L7BmGh7OKWpSwXS2G3KXKiGflHVOVNWA=;
        b=Kyy0UEfZAyc2+YaA2U8r0GBZ8yKtC2s+CliXaQaA0QuLu9lzEdGPycDL0cJnosh83Z
         ymX7n69ClgmA1i9KOykdkPIUfduSBi2Hfg+iR4e2pf17tgAvDmDI7pZp9SvxGbkKhN5K
         lGJ2+vuCoX/oJQT5V6Szi8Twt4s16hQqq6g49EojV2xZ65t5j0WYQDNSW5ytJMOyroSk
         fu5lo8vvKHtyqIM4Ct4ka2F0rNQkXnKeJcT5dpS8LFauR0Fh4s/JO6JnQZVCWg7eqV9P
         6bnqe2zc50UFLXVbBnesOGgdoTHcDVMLv1ClLke/Ra5pcylkDqd2zDTq7O+nhtblHYwo
         6T4w==
X-Forwarded-Encrypted: i=1; AJvYcCVIHWK3DL4qb22UmewgaEFDo9KSJ5gxutFJGNdimCxKrpVqGvf3S90i6u1AoR0CE2Zcnm/Gco6xLOGlwrK2ZUE0u1uceHXUGBDV35ODbLz8rNdvuDFwhWdv0gLrt8E844IvoZVmHrWETK5o
X-Gm-Message-State: AOJu0YxyFyEspGoJt10sYvxsqjHv+NAg9av/RPBzn95m6mcALnhM7usM
	Z0QakR39KJnsi8+PewPQmMcSbWmsXwiCqa2kNPTe413XthHiKdEM
X-Google-Smtp-Source: AGHT+IGL5dxWGqVeotM/Lk06XoKolWNj02U23g6RMrYPs/XMCqXFfCjzQfg4i39C52BMjACbLqFwrg==
X-Received: by 2002:adf:f5c7:0:b0:34a:d1d4:cb3c with SMTP id k7-20020adff5c7000000b0034ad1d4cb3cmr3481888wrp.39.1714176883758;
        Fri, 26 Apr 2024 17:14:43 -0700 (PDT)
Received: from 2116bb4b8996.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d65c7000000b00349eb6eae3esm23748079wrw.4.2024.04.26.17.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 17:14:43 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	l.rubusch@gmail.com
Subject: [PATCH 0/5] crypto: atmel-sha204a - read out otp zone
Date: Sat, 27 Apr 2024 00:14:34 +0000
Message-Id: <20240427001439.12726-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Read out otp memory zone of this secure eeprom and rng chip. The chip
has an otp zone and data zone, both still not accessed. The otp zone
can be used to store persistently serial numbers or similar, if externally
pre-configured. In any way the Atmel SHA204a needs to be preconfgured and
fuse locked in order to be useful also for the already implemented RNG
functionality. Placing data into the otp zone is optional. If empty, the
chip returns 0xff on all field. The implementation passes the content to
a new sysfs handle to userspace. If the chip is locked or not accessible
no sysfs handle is set.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---

Lothar Rubusch (5):
  crypto: atmel-i2 - add missing arg description
  crypto: atmel-sha204a - remove unused includes
  crypto: atmel-i2c - rename read function
  crypto: atmel-sha204a - add reading from otp zone
  crypto: atmel-sha204a - provide the otp content

 drivers/crypto/atmel-i2c.c     | 30 +++++++++++--
 drivers/crypto/atmel-i2c.h     |  8 +++-
 drivers/crypto/atmel-sha204a.c | 77 ++++++++++++++++++++++++++++++----
 3 files changed, 102 insertions(+), 13 deletions(-)

-- 
2.39.2



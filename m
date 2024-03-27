Return-Path: <linux-kernel+bounces-121879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F8888EEE1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5C91F26492
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA75E1509A2;
	Wed, 27 Mar 2024 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVorGGRW"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A83B15099A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566614; cv=none; b=WU1m7Og2i15/kx0Et6sw5NDVHf0+9Y3JUIVuRUEBiPcbkNvxBv9tS/EdNdj+souIIJo3QSxl5lMV3HflLdWthABCNyLzZJG7tei5nw79BUw34aYQiYA0XCSqWHnEuMNe4eTQqqV7tipWusNXg4LhBaFJPwLy9uAXSHPt/q4/Dfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566614; c=relaxed/simple;
	bh=8dmOsKq57IuaVaer0JOPg69UA1GcaPAsLPAfsZhZQiI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qaIQfKSmmDir9JEbRpicETPjqmtvorlbsQvqb4pE6Q3kGfPPo2otqjOaPbCNHLFaAlBdI8cpfJcDyh2FWyYbknJlIdP0fF6XBzRBQKDiB2Im829Hhk41UmOnb5BCi0IBE/6royAYjTpQaDoBZ6X3dTqcFjzb7fYVs6n6ARzu48Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVorGGRW; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-690be110d0dso1163936d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711566611; x=1712171411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I+9nQ7dH6WY9yuVDU973sw8jAti2zGpoo5WiLa9bEuI=;
        b=PVorGGRWZzilMQ9Z5p0E/Ne6tl2ID2X1MOdviNTkvjWSN4WN3Y9dNNLY8MeeCqNlr4
         FPeOsUqoqLTWmlBtFKDdv3ApwM1h5M3T5giisY+/Rtkja2qmsPv9EMfBr2f+tddi8WnA
         HVPIgf2KSVYyFp3NTF8UqwLilGJuEoMPEFAgOvBy9S1EyCRvSvG5LTdbBHUXsnJr7KR5
         9x3t5TmrmJIHBTT9esoI4Q7CUmgqJzwzZ4pZeDE+fUls8foJGPno3oEEFbFNN5MW8tUY
         zrv6Vf8YXw0lwEGp1ouwVYfW92iS0rW4ew99L0fb6O7jlSndJLOwCHgBIuXeEsx7bRb2
         Pubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711566611; x=1712171411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+9nQ7dH6WY9yuVDU973sw8jAti2zGpoo5WiLa9bEuI=;
        b=hk5t9xONwCBf9PC/J6p0IEsX4dGGEG3DqXkzeKu4pv4/c8mat0qKOXpF9DC/7+OYCZ
         TBjfHGuq5Yq+Vw8blf8ijmGraz2fLy7hEE9YsNSxGrX1QC9BX3Fw7Z2z8kMpTf59oZx9
         aqGYbzgnoTcqBcV9aB687hj7zdxyXynHsyA40KYJGpE2FfUQa/OOxNo929Wv6kLAXkIQ
         NK8faFhfPz5sz4Ln8uEs2/R/ZPp3EmpELznYZZdWXnZbPFf3Fuh55MDr+fIOGIHHeY/J
         CfhVFxto+qBycwFg++pziEZcz2CkqHvbE2SmmKAgRTcfINAfGdOGjKEWqjaE1iLKbsGi
         KdAg==
X-Forwarded-Encrypted: i=1; AJvYcCVyVnaFvMlmK1da9fh4WEoONSij7D/KwiyC06ZIiGqsmpqdKtXuJVGGXRVGRaUpCtzXMz9+FOMp0KHO4p2KtndRU0lrCWURUx4fhab4
X-Gm-Message-State: AOJu0YzqnvVL8SmpIjSGK51d7JPcLacs79mr/gMLpm51rpCqskoEc4pW
	b6OIuK8EM1uYQ68RMxeIkggspAd3daG3DnkAFdki88q+JGkpA4RGddYb7PL0
X-Google-Smtp-Source: AGHT+IHu6MivQFc8ofw8fRsMfLJUOt76eUOv6nrLY3cbrB7L0u8GES2dWHFYcbnketG5FUlT0uUWcQ==
X-Received: by 2002:ad4:4e10:0:b0:696:a0e8:8f2a with SMTP id dl16-20020ad44e10000000b00696a0e88f2amr442653qvb.44.1711566611666;
        Wed, 27 Mar 2024 12:10:11 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:736b:f200:f38a:32d3:e6f6:959])
        by smtp.gmail.com with ESMTPSA id 10-20020a05621420ea00b00696a1f5dd18sm1784789qvk.116.2024.03.27.12.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 12:10:11 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	parthiban.veerasooran@microchip.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] staging: pi433: Fix includes, comments & macros.
Date: Wed, 27 Mar 2024 21:10:01 +0200
Message-Id: <20240327191004.619748-1-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset continues with some cleanups:

1. Untangle include hierarchy.
2. Delete a misleading comment.
3. Make use of general macro instead of magic number.

v2->v1:
        Undo macro update. Remove its inaccurate comment instead.
v2->v3:
        Restore Reviewed-by tag, previously omitted from patches 1 & 3.

Shahar Avidar (3):
  staging: pi433: Use headers in appropriate files.
  staging: pi433: Remove an inaccurate comment.
  staging: pi433: Make use of spi mode macro instead of magic number.

 drivers/staging/pi433/pi433_if.c | 5 +++--
 drivers/staging/pi433/rf69.c     | 1 +
 drivers/staging/pi433/rf69.h     | 1 -
 3 files changed, 4 insertions(+), 3 deletions(-)


base-commit: 20952655235dd9b1447829591774f1d8561f7c6a
-- 
2.34.1



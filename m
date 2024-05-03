Return-Path: <linux-kernel+bounces-168219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A9D8BB54A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADE131C232AF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDCE76034;
	Fri,  3 May 2024 21:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaTNk1PU"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEFF41C7F;
	Fri,  3 May 2024 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714770681; cv=none; b=T03iAgNFJvqYCJWFnXa1fZ13z9ssSxEkHILFbmTaSaMs7Qk+TJV8iRQrxyG7ODeUvRoLP18fdQmQTrOV4bZdNytKKxOGcQmiW1PzKwEn0OMHU7t0+tEcu9Ehhs0bQGZokET4JKIktXAjRwaDWX6OXKomRIi8Emf1b4z/DCU0RKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714770681; c=relaxed/simple;
	bh=d/SD6qIRdSFdmB6XYHh2XnFL0LvVoGCB7gGxH6DO6E0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kr2bAdPr9Qk4u0gidxn4f/KjT4wVN8WkCCJVNE1o0Zy5+BT4BHoerRsTHG+2cZqaV8NQrDgndJPHyBAh+ygiBHPAT73L1zncx2j0IN/QW5lowG+v5RJdqcnqCbjFjVNjo6l06Z8/lQj3OS8AeQpSgBQWnm5ygBXEcBiqWriZ2WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaTNk1PU; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34eb52bfca3so43f8f.0;
        Fri, 03 May 2024 14:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714770659; x=1715375459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gFiIP6TYjHJaDi+mdlJ+P1+Htp6nG8gyq660Ei0mCwI=;
        b=EaTNk1PU2agFC4D9yBcNSVkoridsOET3WUhY5aLUagMuiq5LFaf0YTnRMoIPM0Ede1
         hQiR7xc8JEldpqrKzb33ctfLkePxBQ+ddtM9NleToGAUtVSNvz7rEoKcORyDX2uvEy5k
         UvomMz0FIF7+8KdMrIDqPZ8zdup9WBF03TyqbMmyKJhhFbtDLPHiR5Lq9mNxgmgJfmg2
         aXqLBdcIKhH3EtG+CmbN/eGBnW7l64TxdIK1iTq1kZRgyE1KN4OucjnP/kf7AKqfXrxl
         VGe/mIx5hIgtjg47C2V3ykmSjWjHdkvhdiTHMGKmzLCBorfz0Kfcw3+UTfV2m/Rr2Xii
         XJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714770659; x=1715375459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFiIP6TYjHJaDi+mdlJ+P1+Htp6nG8gyq660Ei0mCwI=;
        b=OX1jfJ3XSbfxX4U9d6nTFVCNWcIxIu9NBlYZXxWmkEdFPPoNEKWJqABNGTCd+lwYI1
         VmkaVYrdePnSFzX6k4tKRHeS5FmVMMX6QSFHrwR7yfgnOdCir/64dZ5aC4EKk/yX9rA5
         sugK/hyFSge+mcl0cWgpFEUdQIvMljZbXArKpUHbTLx7KnPMONZhNeaLv9qGUx7RI99m
         Se0QllMZy58lMNhlzfEk702Ss116yRC4X0s3M7LN6EUt+A+jAEAF9xMK1eJ6PFXqCRs7
         UhnsyYoIG4a2LxkRsJTMbmCyNXIq+MqKvj8ZdrNZbJO8jtddezGmi2RzsPimTYeby2eH
         g5CA==
X-Forwarded-Encrypted: i=1; AJvYcCUJFTYgtxv4U8cUSDrEoIEAUY73zNtmzMy9pCEMP5o992lDdUghN896oGo4wfFxFE7IPEkUzYku/BsOLTaq+pKEd8/EC1zoH2aqs5/UhrkGdQfroLRsFYcaisLftfTjGj5kcO3KEa+F0klM
X-Gm-Message-State: AOJu0YzkUmrH/wgB5X/ECE70XBcoryIaW+hcEbi1hIMuclJ64CPbIes9
	TG8CID43wD0Bx6SQBnqUF7yXSnLlxvTcGb6WCxxYFSHhrSmpuYd2
X-Google-Smtp-Source: AGHT+IGfa5q14NXQ2Z8X2gRIXybvC2IDcQj5fP0NrlA9hdgN8bemn/OKKjEsD1OhXnquVgR9MF06mA==
X-Received: by 2002:adf:fc44:0:b0:34c:fa08:791c with SMTP id e4-20020adffc44000000b0034cfa08791cmr3214794wrs.45.1714770658778;
        Fri, 03 May 2024 14:10:58 -0700 (PDT)
Received: from 58b9ec80ce2f.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id jy9-20020a170907762900b00a598646f173sm1475948ejc.191.2024.05.03.14.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:10:58 -0700 (PDT)
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
Subject: [PATCH v2 0/4] crypto: atmel-sha204a - read out otp zone
Date: Fri,  3 May 2024 21:10:50 +0000
Message-Id: <20240503211054.1231-1-l.rubusch@gmail.com>
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
v1 -> v2
- fix typo in commit title
- drop patch: remove unused includes

Lothar Rubusch (4):
  crypto: atmel-i2c - add missing arg description
  crypto: atmel-i2c - rename read function
  crypto: atmel-sha204a - add reading from otp zone
  crypto: atmel-sha204a - provide the otp content

 drivers/crypto/atmel-i2c.c     | 30 +++++++++++++--
 drivers/crypto/atmel-i2c.h     |  8 +++-
 drivers/crypto/atmel-sha204a.c | 68 ++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 4 deletions(-)

-- 
2.25.1



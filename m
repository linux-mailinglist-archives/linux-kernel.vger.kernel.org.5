Return-Path: <linux-kernel+bounces-35542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 092A58392F0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53EB1F27A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA3C60896;
	Tue, 23 Jan 2024 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k9hQwN2I"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247B0604AC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024074; cv=none; b=N2u5119foCM5eedQuY8Mi+oJ45RPjBYynCP+iWyO97V7iBmpuHqPuJ4bPMeK6yTqNWqFTDqEkbsIjF1bjaxuj1/wiRAQSQ9aYY7FTMraJeNOnGKyOjiPozd3RemJ8lmlSiO5HoNJq6x2EyNsfkaFpC49R67WmWyuRpvPAYVI+EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024074; c=relaxed/simple;
	bh=yG4gZxYa79HahCfvc6InRnmHlNSFjU/8GPPNK6B+dSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTzo8kdp2c4efUhspg1sti4kp89/rCtriF7+hTctL29OFBrSpt7VGxT5GY+C1pblPudciHs5yaVajEatun2Gu3BOZlVCtEW4mtqR0JvNrG73Z8C42HTHGJ4VQPeeCvTBDMqGsPlLkK/pqE/T32xqvAqOxJaFuOzOMmq1IowxZRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k9hQwN2I; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d6b4e2945so53272655e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706024069; x=1706628869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OHi5EgWCeJpCVpQQS24DPa9E+cj9YStk/+6+6uJiCg=;
        b=k9hQwN2I2biGzbOtoHY5qnC5w1AVn9rzJ96gggXEarAggq1SF7rbNcPLQ+Px0ZxHQG
         IbMeFhLj+VDI1rZda7FJz/wrsIzuxZ1e8ljGSaw9b8BdD8ZKnxt6YZhxstYiMqupbnJ3
         CzziWBhjBYnGk91vYNkCpEUGfpohXjmkt8pZ2ylb14+SX2WsQ+RuZ1JRMafBa+j1UHUz
         wJ0pw3X/VScP01U7vqs2oA97ttnTHa9YEN2vNNrTzUCFf/ooEAoOfWX0QkFsDfiTUyvH
         tpeT0lazshYVXJuqzMmFBsXwyGK1gImmEMwvRlC2NmmfjNgzdVr3HG3vryXmIe9B1rXD
         a+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024069; x=1706628869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OHi5EgWCeJpCVpQQS24DPa9E+cj9YStk/+6+6uJiCg=;
        b=EaoijGJlEN69RCZNX+Iih/GLX5d7Pm/3cgJL1vB0SPBLsv+6lxVrV31vsrPwRBdVi8
         vcVF4isqDOQ0fdHSmIMNLOPKjvnUQqFrNbw2uqG4DLt1LgMhQjWpbzyps0uAK8S6ILmo
         LWktM6coW4Ho0VeMqpKztncEJI8mCm7oA9KUm7JHcQJ6ivyqrp3yL06ZPxe1Lz3DozgN
         GzyrONWWysMxo0drexEC+ugwTFzmMk9UYCYtx3W+ul++cQKGCx02YsxNj5nIDQeZ+dDL
         WbxM+s/sMaqHXEhBdqw4S92uIKncfGNq4vzqqj0CREXUFO/KKP1P42wK1H/U39RgClI2
         /8JQ==
X-Gm-Message-State: AOJu0YyogBJtdmOGoMvf5q90TAyyjOuoQx0IsC7JewJ/VgXm3iu4IcHa
	+frxaQFRI8tWojTO7PsGG9KxywmwNPh8PahYtdvs0iKsPp2x6SOMkQDfNz6xZbA=
X-Google-Smtp-Source: AGHT+IEW8wM8jKrmBHWu9oFzJXlcGywLUYOu5woE/V+wgfwbWwJGW6Xexs4KhMhkqwE1PVcIdJYUoQ==
X-Received: by 2002:a05:600c:2053:b0:40d:3afc:9263 with SMTP id p19-20020a05600c205300b0040d3afc9263mr175292wmg.104.1706024069457;
        Tue, 23 Jan 2024 07:34:29 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm42457536wmq.12.2024.01.23.07.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:34:28 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	arnd@arndb.de
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 05/21] spi: s3c64xx: explicitly include <linux/bits.h>
Date: Tue, 23 Jan 2024 15:34:04 +0000
Message-ID: <20240123153421.715951-6-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240123153421.715951-1-tudor.ambarus@linaro.org>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver uses GENMASK() but does not include <linux/bits.h>.
Include the missing header, we shall aim to have the drivers self
contained.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index b350e70fd179..9ce56aa792ed 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -3,6 +3,7 @@
 // Copyright (c) 2009 Samsung Electronics Co., Ltd.
 //      Jaswinder Singh <jassi.brar@samsung.com>
 
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
-- 
2.43.0.429.g432eaa2c6b-goog



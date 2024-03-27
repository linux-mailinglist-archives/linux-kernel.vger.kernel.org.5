Return-Path: <linux-kernel+bounces-120374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 372D488D663
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692231C23431
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601391757E;
	Wed, 27 Mar 2024 06:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gx9FFWc9"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4FA241E9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521124; cv=none; b=vEHe0QVdUZ1goSjT8aLYmvZOrEKqJcQ7/kYn2YJZ362+6WEOngzM4L0Ewr/XC4QQYKd7JsxMzlCnCZQbgd9+0c0A8bkN9PPcfOVrAAFfrVS2hGyocxBr2xn58KETdBJOJuhnNsQ743hrNtC82ijAI7cHpMFs2S0FYXnu7kxMdak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521124; c=relaxed/simple;
	bh=LVtD0MrdI+Mg1oSTGtaKkQKlCvBSZCpoIbcQgD7fo88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SFyN8q+WbX+GcfXp3Abz8aPMpVVAV1CogCSDxQxqRQ6jzYkwSE5Y08/4oKOTzv2rpC9doMNZu/B8moc5oFkc+eUZXMt+kWi0sy2raPT+c4yjTa6/HMItynRoWC0J8YHD2D2cOo2o+yusbNzzGH4SZa8A2rtv3nuUQiIZUbBWt+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gx9FFWc9; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513d717269fso7911730e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711521121; x=1712125921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMhP10tsZ8Q8ucD5kE8dCkCWtaV9oISDHd7XaeWfrBI=;
        b=gx9FFWc9wgg5HySxDdyXyE6hvXct5tS7iI6fBzyqRFF5LJTw8tBQ+XblcI8TUzxWeQ
         bKW/1gWd/7Io/R9tENpnPLtRd5dFR0YNDC+sj0tg64D+EMNu6BPaAG0+xaDphnDb34Lo
         4WZWogsPyUD/1pGRXgSE4YLAp3p/+C/8x+XKJCWAmN1FP31o79yTbnbgcwW3RRgDXWGs
         nHSNWKSKlDi4Ukr7SywvJsMLByFdkXQb9rFoP2W4Wdd7BGDh9oQ8ktTjXR8C7mHAMRaT
         mZkEcfp9hTuahpmN9fqQAMJU1INuPk8htAvsXYS6DOsM4uX0ihZEe+Q4nTbf5FXPdOGR
         gzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711521121; x=1712125921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMhP10tsZ8Q8ucD5kE8dCkCWtaV9oISDHd7XaeWfrBI=;
        b=nBcPSo9XjG+eLo6nMuy0CBiPG6Y9IJf/PgXjdoeh6R+H5zgJr2WhcCBy2RO9e8iSqh
         W0SUfH31KUqbVeLtEKe9rCoI4z5fq1ZD5CwdhdnpgCuMAGYMQOoHHPIg0GQEOaNqekkX
         nq7TpsPSy98o7mI27Ifsc7kSnjG43OULXXU70Ko9PmBaYxqn11LbybSCiAjMgidfUhT4
         hFx+vKe1ehyaLlx4aYT4XIqs0/VyiaQcyD50XXSZyOWVmmZSdE2v1DAIPaN7Yi0v/Vfl
         GiLaL7FAr1a3Qksk0OMS2u485IfoQaGnW3U0Wqjm6f2IuxIv+corDohlZ4cI8N7UXsig
         wxSg==
X-Forwarded-Encrypted: i=1; AJvYcCWDdh1CloWo9z35gb7e1ea9z4kfr2nsVuy0seuvhR87HoC3Vn8M0j2WsASddNG+Ozuly8o56Rg8hitODjRIlTy7jl4va0UFk1+6Oy3S
X-Gm-Message-State: AOJu0Yz1d+qdZkltr03rREqaql+cTdaKNSZtW3In7CmiZcqBbsfWsg8j
	fotve3MhvAQd8OKMg8xQJ3mXwDkAvfuBOcmQQnHGsxaRbEWqVmHl
X-Google-Smtp-Source: AGHT+IHQyGd02XsZG4w/RI5rbhK3c663LjTjeSI1CPeknUDDI126Lsv69fxhT9YI0vQRVD823Q7cLQ==
X-Received: by 2002:a19:690f:0:b0:513:23be:e924 with SMTP id e15-20020a19690f000000b0051323bee924mr976794lfc.59.1711521120864;
        Tue, 26 Mar 2024 23:32:00 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:736b:f200:f38a:32d3:e6f6:959])
        by smtp.gmail.com with ESMTPSA id u22-20020a05600c139600b004148d7b889asm1121360wmf.8.2024.03.26.23.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 23:32:00 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	parthiban.veerasooran@microchip.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] staging: pi433: Use headers in appropriate files.
Date: Wed, 27 Mar 2024 08:31:54 +0200
Message-Id: <20240327063156.96307-2-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327063156.96307-1-ikobh7@gmail.com>
References: <20240327063156.96307-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure rf69.c directly includes rf69_enum.h.
Move rf69_registers.h from header to the relevant source file.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 1 +
 drivers/staging/pi433/rf69.c     | 1 +
 drivers/staging/pi433/rf69.h     | 1 -
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 81de98c0245a..0c12b31c4642 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -45,6 +45,7 @@
 
 #include "pi433_if.h"
 #include "rf69.h"
+#include "rf69_registers.h"
 
 #define N_PI433_MINORS		BIT(MINORBITS) /*32*/	/* ... up to 256 */
 #define MAX_MSG_SIZE		900	/* min: FIFO_SIZE! */
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 5a1c362badb6..bf802f097310 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -11,6 +11,7 @@
 #include <linux/units.h>
 
 #include "rf69.h"
+#include "rf69_enum.h"
 #include "rf69_registers.h"
 
 #define F_OSC (32 * HZ_PER_MHZ)
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index 76f0f9896a52..dd6fa8af9b9c 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -9,7 +9,6 @@
 #define RF69_H
 
 #include "rf69_enum.h"
-#include "rf69_registers.h"
 
 #define FIFO_SIZE	66		/* bytes */
 
-- 
2.34.1



Return-Path: <linux-kernel+bounces-18618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC222826017
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55050B22DF4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13848495;
	Sat,  6 Jan 2024 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aw7KdWLh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B138D8474;
	Sat,  6 Jan 2024 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d604b4b30so7892075e9.1;
        Sat, 06 Jan 2024 07:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704554573; x=1705159373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e3fDW402aU63JvYRAhJVsl7yZwjVojyYxUJdrbQ3u2U=;
        b=Aw7KdWLhi3zkykGKgxKlrIUZLI0rRHHPVGV0Fg0O4QjF/YZX8NnwIljcRw3rteqo7+
         hdvbVat5xG2mIZdcoJO2slvlI6AfxSfPRB/SpTk/HeMbduIqPc4DSGsGnrclF6sW/Q5y
         S31M2DMLFFmSma1LNGATDnnOlYR0dBhZiE8TcWlFLc3RKzSVqID81IjriDZyn6e0AXsV
         agVWZQ6NCL4hcWN9rBwXRMBNbn+eGHQVjIseeFOz4ggDrvBL9z7rCRbeyuZyEc0St+ag
         /riEaYsSEqaM4zGhFrodCX3+K7tBAq0G74+a11dfaZFbmzMnVKZuF3eCWwIsGu0P7aer
         LXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704554573; x=1705159373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e3fDW402aU63JvYRAhJVsl7yZwjVojyYxUJdrbQ3u2U=;
        b=Z2QBkPxqZSnA5+TBf7IaHhRuEQWqVlVaYNS1i0NrZI2kVST24CZ99q0wA2yYYuS0Ge
         mI4IcY6QlqEgaPpA3nwQE1Ps/5AjdGf7T2y3TI9v1fSADpoyc1ai30rVab+PFCkZFYWN
         UYK7+Y7Zdyz8WkTA10bWSZnG96XhzXsLp77Iykfbzoh8SsQMnPWWgZGYAXjlpY8dGNrm
         Kz4QePQ91JFrloj4Pz9COF49tQhMfwrO10u32j505UaxIKYp6p4ZUtjVO808dFd7hE20
         kfxRLkaAdQGeBSCrSI+fLGAazqsCUOS71uUJDOMHpucmLt6dqlk5EUsZD0sBaACAvXnp
         kFKA==
X-Gm-Message-State: AOJu0YzV1w5VUS0B5vY1yIJU4Bg5J2E3NGWM0fXDlYUaXGIg1CQzdVkZ
	ByJXqo6Z86qdeRvpn/fUsFM=
X-Google-Smtp-Source: AGHT+IHfBHIgmYFZp/QnQeyDYv4aaxU4VKiNAoREFpNt4fOpSFsAJ9lRnVVBi3gTZ3O35EG/PF9hsw==
X-Received: by 2002:a05:600c:8a4:b0:40d:5b0d:cebe with SMTP id l36-20020a05600c08a400b0040d5b0dcebemr563929wmp.39.1704554572850;
        Sat, 06 Jan 2024 07:22:52 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w5-20020a05600c474500b0040e34835a58sm4948321wmo.22.2024.01.06.07.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 07:22:52 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Lechner <david@lechnology.com>,
	linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: adc: ti-ads7950: remove redundant assignment to variable ret
Date: Sat,  6 Jan 2024 15:22:51 +0000
Message-Id: <20240106152251.54617-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Variable ret is being assigned a value that is never read, the variable
is being re-assigned again a few statements later. Remove it.

Cleans up clang scan build warning:
warning: Value stored to 'ret' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iio/adc/ti-ads7950.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 263fc3a1b87e..f975de059ba0 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -441,8 +441,6 @@ static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
 	if (ret)
 		goto out;
 
-	ret = ((st->single_rx >> 12) & BIT(offset)) ? 1 : 0;
-
 	/* Revert back to original settings */
 	st->cmd_settings_bitmask &= ~TI_ADS7950_CR_GPIO_DATA;
 	st->single_tx = TI_ADS7950_MAN_CMD_SETTINGS(st);
-- 
2.39.2



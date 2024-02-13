Return-Path: <linux-kernel+bounces-63427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A84F852F17
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1601C22AC7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B653C51C35;
	Tue, 13 Feb 2024 11:21:39 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A806C50249;
	Tue, 13 Feb 2024 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823299; cv=none; b=QDdFPevdpsu3I3OIR3bZFmtAZv6TYOzYZtmLC8NI1LKjmXg/hHooAo+kfQ7TgNzqKRj45C1SoBzcaEB3pzn6wuNrPOL//7CHL4vHA9uduqeIk/b46QYxMOz6Jr3MLC2zDVaZBC/+0c90YdDy17MkOk6cRHBCbY13OmPpD9WDwhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823299; c=relaxed/simple;
	bh=ATeujqNTxGZ7Buahdh3oQZdOez0THha3F4P6l0NgA4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tCCWKCGfrYS2MgU7rjxynO3uS0tyNyWAXAoKezzk7PqLPvWqdtwQBz4pjiHf8H+oD9gufZnOTFT3o75NcoxzXhbUPu0U/Fjpa+iW0wARm9MmbaLkGmckIL1F/HI0hw5WLyMkD8An76do9d/yb8FEnnpTy1JllKuqXNLAnoKUNOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so115134266b.2;
        Tue, 13 Feb 2024 03:21:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707823296; x=1708428096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+NDfFH0YYmBs1BkIUepda9MZ/fKCEXrnoPMYFzSoWw=;
        b=XS2hb0rJ/auqvMk0sJs3IVLHVSrF8MjD4hRyZWMhjuPiSNB74NALYt+GWWPA7r8Gt1
         0YIhdbFicQzI7HCZDoCvJ+Z0/BQqrYZfDY78MI7v+Xp5pkGHjnkMkC2KTQxJU0OUHrE5
         zq4U611jWWn8bZUzPZCl47UX1sRqwONe8F9icwMdzVrI78O8Foh7TkuMN1372/MOBNeP
         YIXBpUSBUoH/Q50JDc5f1fHN2+bGCJE+WzZZisimZG67SYSTegwRkgfE0+L+afjvJIT8
         hP2cUfe69MZq8EQVfaAJ5T1yF32ZIi9mF3+L/XtWM4IfGWdewxYlTUu+NuwpivnMy4Hj
         kZAA==
X-Forwarded-Encrypted: i=1; AJvYcCW7pZl7yYRyd9zDErfoLVN0Tz6Ml1gwg6LOCHnnKhzVX0iXILOLEGOp3p+uzPhDZNfcX7bWvQipz8bOkX839TSTWA9mDsuLdtWm8zVrsRo3CQlfS2FPNMDkKMr9r7QLj3eeZHqgL8pnSg==
X-Gm-Message-State: AOJu0YzGN1+WsGNve0BY2B010dfvDwrP/h+Est7HZh9LQm31qVbvHmol
	Y2ZBNP4Un7EsCm06xyLYBLHrFd4SEELdKTowKzs5rwakUfszZ5Rf
X-Google-Smtp-Source: AGHT+IE5gsXas6kdKZhwJmDWlDfSMfXI2qPBHnsU4sFsofzr2h2eCaSsVtrv46YcecIgd1jl4uVknQ==
X-Received: by 2002:a17:906:80c:b0:a38:8d35:c8b4 with SMTP id e12-20020a170906080c00b00a388d35c8b4mr6499600ejd.46.1707823295630;
        Tue, 13 Feb 2024 03:21:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfKxqAlQPAPM/E19AQlrm0geiBqzNdpK0eVXc1v4+6TtAY2+LC94VNGgsROd4XOJeWmS9kIL4mCuRVwvIVO4Xh9IYFiDGAaJYlLd3vcW96g7ED0+km0eQcKRVF0s71MczlOMezqeiWL6zj3c7x4mmCh+h5ojuDXIKzia1DmtvvwFsa9OPSpLvE1XqBmsae1I1esAezMkght9l3J355kOYJvB6IhyafHm0SmPZbUjiMW5hVnjyIi3Lrd1LRv3BUr5/i4w+5FhaYGUG4IFkDXPTuA+evkmWtsTvLCJDhkkabDkIv3OdI3+WPdXzR6fYNajxCPqF5Vn8b4vashqh1Zzuqjfek
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id vh2-20020a170907d38200b00a3d08f3283fsm442607ejc.104.2024.02.13.03.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 03:21:35 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	linux-wpan@vger.kernel.org (open list:IEEE 802.15.4 SUBSYSTEM)
Subject: [PATCH net 2/7] net: fill in MODULE_DESCRIPTION()s for ieee802154/fakelb
Date: Tue, 13 Feb 2024 03:21:17 -0800
Message-Id: <20240213112122.404045-3-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240213112122.404045-1-leitao@debian.org>
References: <20240213112122.404045-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the IEEE 802.15.4 loopback driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ieee802154/fakelb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 35e55f198e05..2930141d7dd2 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -259,4 +259,5 @@ static __exit void fake_remove_module(void)
 
 module_init(fakelb_init_module);
 module_exit(fake_remove_module);
+MODULE_DESCRIPTION("IEEE 802.15.4 loopback driver");
 MODULE_LICENSE("GPL");
-- 
2.39.3



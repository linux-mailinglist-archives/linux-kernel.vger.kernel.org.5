Return-Path: <linux-kernel+bounces-67832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D9285719B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969C21F23273
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B1A145B07;
	Thu, 15 Feb 2024 23:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f82Gd9Uv"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3BD1EA80;
	Thu, 15 Feb 2024 23:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708039790; cv=none; b=lcneXx6q9i5WDqSrJkgMpyreTaws91euWPptYdLrBBbxzB7pDAyq/cjkmgDK8JezBph1SHO5FoMS7DR9C4Asj578RqTMy+cKhxn/ZhSj7sEImDhkC5XUsoK8aiaNzihJdLiM04POtgIaeMCWRoAbqpd3F+ZljvdR7GjNcv8/C6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708039790; c=relaxed/simple;
	bh=/U6IZO/xhZz9Yo64LAlsJtuJI0I8mp7MDfTv/IwTguI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dr8PxQb8lZsvLBT4zO0JJfTgi19ZPfSV56yQ0k1rsqbos0mBT6KqNxih8jgj0dvPaF74cisMKYFcr4WKs0MNugmQ4Gm15Q7zKLe01sebV+H9Aeg05PqBsCy7gY5mj6J8z7q48e41UzciaKnuwl5DdunNco2XQFPhFuM4TDTTbH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f82Gd9Uv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33b29b5ea96so711645f8f.0;
        Thu, 15 Feb 2024 15:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708039787; x=1708644587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j5Bj9xsaXMX+Tu65Jo5x7Ok2Dy8ft8+EqH3kfAe/1a0=;
        b=f82Gd9UvJ3dFSvPSZRdKjB6pg06fYTvu7JQEzdG7U4BJDQ2nJxleYtX+zIeaNF4SZ7
         h0UhAVCc9HjPaxxUPTx6Dw3lQKxXV9/l9fJparwKLJw6gzJeigu2jbDxdaeCe1J3gvZj
         73pUboey5syyoTIiaEd2QC6rFmWpY2/QsxmseLLTwOAGYK8TT+5fVVF9SBnazAkHWbFj
         IrVgaobxzhkX0vJ8CyDlUA9qcbhEOhBDIBkAZwNWJD3fFinlpw/5Sm0WzdIFbHPDogCP
         aspcCadhToElOIolES/ReDLvhPUOcMPaByx/u6aE+y4gdIl+e+ZodwZeMyF/UhfZaMbl
         ehgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708039787; x=1708644587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5Bj9xsaXMX+Tu65Jo5x7Ok2Dy8ft8+EqH3kfAe/1a0=;
        b=e7h55BkG8gSy7D/HZZjTBDaQuXCuA/Gav30Pl00d5iEdpEtnqlj3lQMoqFzyaKcE7n
         Y7rLxPEvBhcHrv7hdELhn9PN/YzyPOmNZJ5MNKxioiHJ5oNfROQQ0eUiT4+aN+O6EySU
         9kEsT4XKikd8vgzOri3BVjuE4Vyjg2gSH+g7hmU1n51aNKlZVnr2py0JCo0ZEo2hZLqh
         LKoLtPkLhcORroPGKwu2KbZA1ijR8Tb7rycLVPUhoG/A8xZm77iwyTyVCDClVoOu/Sxu
         brREk0V4T9Ty2ae4acryiRvZEz30SW13seBF+H3IEImkguDnrwUtNF/M6R79DZxYV3UD
         liHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjxBVjUewC+yP8IZUJcnmj7koLkw0cMd9VT+e9zTmzynJ8vWyzOZ3XlEwgpD5mRA1Ck+P7jd0L9OCPBb57SBpem7Gdj0oNMFXC57djNZHgGm93mzZ8EXhyJ9qmK/nHLCb/he28B6VGPt0M
X-Gm-Message-State: AOJu0Yw2B9L6c4cIaF5UYnWJBCrHAfxNGklHxrnEUGPsW4ubYq8nojeu
	yMwgoTth1OBFarkmb80XCv9dd9OR67Y6BssOvg+jzF1++HvkNL9C
X-Google-Smtp-Source: AGHT+IFClw2R/gW7b2Gk9VgkZuerndh8UZ6w1NSexmCjQ9JO9ycquNjWnTRLIHCIgXks/FEKHA6Rmg==
X-Received: by 2002:adf:cf04:0:b0:33b:6959:c766 with SMTP id o4-20020adfcf04000000b0033b6959c766mr2630764wrj.29.1708039786517;
        Thu, 15 Feb 2024 15:29:46 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id t12-20020a5d460c000000b0033b48190e5esm455092wrq.67.2024.02.15.15.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 15:29:45 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] serial: lpc32xx_hs: remove redundant check and assignment of hsu_rate
Date: Thu, 15 Feb 2024 23:29:44 +0000
Message-Id: <20240215232944.2075789-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Variable hsu_rate is being checked for an upper limit and is assigned
a value that is never read. The if statement and assignment are
redundant and can be removed.

Cleans up clang scan build warning:
drivers/tty/serial/lpc32xx_hs.c:237:3: warning: Value stored
to 'hsu_rate' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/tty/serial/lpc32xx_hs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index ec20329f0603..269efc5e2d51 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -233,8 +233,6 @@ static unsigned int __serial_get_clock_div(unsigned long uartclk,
 
 		hsu_rate++;
 	}
-	if (hsu_rate > 0xFF)
-		hsu_rate = 0xFF;
 
 	return goodrate;
 }
-- 
2.39.2



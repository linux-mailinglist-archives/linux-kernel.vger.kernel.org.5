Return-Path: <linux-kernel+bounces-79587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E56862481
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5F4283604
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B8225756;
	Sat, 24 Feb 2024 11:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyTK5cBN"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493BC250EB;
	Sat, 24 Feb 2024 11:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708774165; cv=none; b=Zf/3FtF6L0BzZi6IFQarlG2m2VA0cWEn6nZx5bWn/BknkUfQyRtQi90xlkP0vBTL95j8G9w/u4N/iODgNKa8nyGwXFWgMz0ZbEy/MZmjJgbC7kHNhFUY1SE9TDAFljnVLSze+yHpEqsoZtcDuFqLaW/PId3SJvVljfoTygNkdhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708774165; c=relaxed/simple;
	bh=oLDwwbjlfldA8YTQKnJROMeakHh9GmORvJ1FZwNxLQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FOGwdlMw0QvT4EAWfH7CLVzHobaLEIljuXoKG4uwcD3oWNCDQk3fKtQSuYdISNibscVexGocorcuU2ZdWVoeGIfPo4jGOJ7HgVicdlyXv5XQjrdK9FhpJ6QgnkbnfDKPxtxPNfBKd4AeSLBSjpd5P7Yhf1thwGyNPxr7iXriEbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyTK5cBN; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so2116350a12.1;
        Sat, 24 Feb 2024 03:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708774162; x=1709378962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MmK3Tpm9+5KttJbHDCWPd/7vMZzGKkTnGzOOVkaN4Y=;
        b=QyTK5cBNd+V4/72EdyRSZjyYIQkT0EvAM8EpS03PVsfDyO24mIjDkTMXkiiRuxYO3m
         1oWu9ckdD86DH6cFjzTZBCF1V6kT2S0N0mvSqniIV+11BmVNFtBdjlHBxgmw/CSt0cNf
         PQIb1f0ka/aiBVFDPqGcZCXYHyI94tYD46hsqr4/rpRveQj6vOeV01CVCOSQE7TblzOW
         GmNGCrKpXSzd4J01HvpF15Jtvhjzr6ZwTQEz5+jiHQhPKftrPsDLwRooSiireOJ5hkw4
         Zol9mboP2mxH3kEKYQvQYSz9hKd1Y1ilFP6xBKETs3enqiUacIZF3rBL389sB5EB5f4m
         9yUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708774162; x=1709378962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MmK3Tpm9+5KttJbHDCWPd/7vMZzGKkTnGzOOVkaN4Y=;
        b=CTB3TdLsdSidA4RZwAsfRzarZZ3ECbcGJsTpJZ2eHF6wou3db/aFd4/ODGj0Lny7pP
         N1AAZqVFvXYHSvbw625LRdnmXI++lm9y+FTwvRyut4Ap4PoHKYZruaKb1wx0Sb5cI+8y
         ACjSGJDqwbmXzr1Z0utdpiLkMiBidRNNO3nxwZ0XZFS000018oSRvmavBaK3sT8x8xZu
         9cRn/N5sbpI+a29jyx+933/N16r7MT94eyAlm0Gw7vGDI7tBhTCTnFD0DQZ2H82gsMAs
         Slwvio6Dxeg8gbrRyu75WIXlx+ifWJ4CsDVlgAMP/NlvHuq6G/Cwex72966lxqsq5kB4
         88aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrrztE18pTD05NPJWW/4zUY+2GMw7ZUJrVvwccJ2C7FsTHiMLFcBHe3jqiOx1FqxV8/jq+vfxk8zOeXFHiVTENUPJYrWTOjgnLyOJO997dgkXI998uWQB8J1I/pk47xwBrH2O26UJa
X-Gm-Message-State: AOJu0YyYF/v8oFLzq9LEClZcyk6Bo2OI7FNmOtkXX/s9rwiKrO8NYtU+
	qyv2OpqCsyG0canakju7+qNkTu2bRPlzyzPzoKCAOU48QlPl5Iwc
X-Google-Smtp-Source: AGHT+IFdt8w/I4I+8iNW3l4ElfaKirBq2vMB34N6h/jQwawqdL4WS7C2NJySq62HtK3H5NIQ3aOaRQ==
X-Received: by 2002:a17:906:3449:b0:a41:31ed:acd5 with SMTP id d9-20020a170906344900b00a4131edacd5mr1438285ejb.50.1708774162367;
        Sat, 24 Feb 2024 03:29:22 -0800 (PST)
Received: from localhost.localdomain (p5dc68d61.dip0.t-ipconnect.de. [93.198.141.97])
        by smtp.gmail.com with ESMTPSA id s1-20020a170906060100b00a3d9e6e9983sm507181ejb.174.2024.02.24.03.29.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Feb 2024 03:29:21 -0800 (PST)
From: Leif Middelschulte <leif.middelschulte@gmail.com>
X-Google-Original-From: Leif Middelschulte <Leif.Middelschulte@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>
Cc: Leif Middelschulte <Leif.Middelschulte@gmail.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] pwm: imx27: avoid PWM consumer API
Date: Sat, 24 Feb 2024 12:29:01 +0100
Message-Id: <20240224112902.55539-2-Leif.Middelschulte@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240224112902.55539-1-Leif.Middelschulte@gmail.com>
References: <20230906154215.4ikrrbx4xgx2nmu5@pengutronix.de>
 <20240224112902.55539-1-Leif.Middelschulte@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Access struct members directly.

Signed-off-by: Leif Middelschulte <Leif.Middelschulte@gmail.com>
---
 drivers/pwm/pwm-imx27.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index cb564460b79c..d00d79a5edb1 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -255,7 +255,7 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
 	sr = readl(imx->mmio_base + MX3_PWMSR);
 	fifoav = FIELD_GET(MX3_PWMSR_FIFOAV, sr);
 	if (fifoav == MX3_PWMSR_FIFOAV_4WORDS) {
-		period_ms = DIV_ROUND_UP_ULL(pwm_get_period(pwm),
+		period_ms = DIV_ROUND_UP_ULL(pwm->state.period,
 					 NSEC_PER_MSEC);
 		msleep(period_ms);
 
-- 
2.39.3 (Apple Git-145)



Return-Path: <linux-kernel+bounces-51250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA4B84884D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1E31C213AF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8D95FF08;
	Sat,  3 Feb 2024 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="c1a5sTkF"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDC05FDB9;
	Sat,  3 Feb 2024 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706986905; cv=none; b=lM2x80zXeIaxBCGQby0z0bKgkZNyB3n0R3eG2t45vg8fw3/sGlIAhNM0zmGZagv4UrEQg5AwViAxK05wJt4Eb15H84+kmBBpZobHGfEPpgdRBriT7Ffatwr4ISvdF4mdM7tisBa3+RHjcc++Kr7JrAYNHLrhX4xLCfKi38YWGrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706986905; c=relaxed/simple;
	bh=o4HUoGdcsUJOmCXT/I7jQBFT0zSuxvv3O5ivx8MH4k8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oS4X32boZAlVM6kDOx34SnO7/6sCOn+KSX9Gks/gVRMtlWSyNc5dFr31WBp1ibOMbnXB19EEwDIhtTEWU1bi0nj2LiJtA6ul+GVUBpOM6bW0lkb8CMaKeXtqw8nMFlLtbeJ8qcv1eVppnA8NUbIw1pykDKTIdrDQEIQqMZH45ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=c1a5sTkF reason="key not found in DNS"; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-290da27f597so2224884a91.2;
        Sat, 03 Feb 2024 11:01:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706986903; x=1707591703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K6pzRccXqHiPScs411UN1Vn42G0kB1tV+D79pDRrw+8=;
        b=RHfekPCO515B3do6eVgrdL6BSLTswOxktQDn9462cX7crqScJqzJGqGqQ39VAtwxnO
         TF2iU4Abb61ytjs3L+qflGO+NyCj4RNRuXkC0wkxKaEH4CUFl0PCkV9Kq45bekbyXH2l
         y+voxQOzJ6nNoAXCXPVRaVo1mkbWl6A8K/2efgPiuoS3RxdsS2CskDE5nDdBpRvy7b+2
         LOSQkowSAnWnEgDxpNQCHAx2Oe4xOWEa/Xy090lupIoj+huG4G3LioUnlKISTFBXvqEL
         GzAKvUquR/T9lRu4D3akfKq+Rale7AnqVbpllSZAnwjiLuGRpUiVyKzSK90FRmO17NFa
         eFAw==
X-Gm-Message-State: AOJu0YyM7Sd8aGbCplJ+S3dcJYu8EWSX6KFysze3pYu4lOiSFQvIR59j
	tkDf7+o7UNuTDgGaKmwOIYXBN1Q1GaJvxmQABQh1gEnlSb9uGugI
X-Google-Smtp-Source: AGHT+IGDjJjSq2RIm4MGHdWGMS84WofkXvSnx3OCoea9EpmQehAS0JzmLhydK7ygNlhZ7QGykUZCTA==
X-Received: by 2002:a17:90a:1307:b0:296:235b:ac61 with SMTP id h7-20020a17090a130700b00296235bac61mr7603948pja.32.1706986903473;
        Sat, 03 Feb 2024 11:01:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVmH3dAqz2KwHi4fQDIo0hBz1CVbO5dDUdzQzQghoeaTsbB6VQp58Vc8Lvg3h/FtVbyiD7e/ih16tzls6yjm9OKKyo3WgjXwLOW1uFlSmAXVAbz4sq+n+LDdwe/mDoOFdqmJIbaEa9niQ==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id d24-20020a17090ac25800b002966870cbbasm1477690pjx.12.2024.02.03.11.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 11:01:43 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706986901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6pzRccXqHiPScs411UN1Vn42G0kB1tV+D79pDRrw+8=;
	b=c1a5sTkF+ooNMWxgB4F3L8dxKeo2ac9TAfwOSIlPeGG4GgivzbRA5bzUQEi1sx/Bc8j8+d
	odYuCqutrsnWi6B/TQPK8Ewz+RXS59cLXbh7jDImZmdEt7cGVxEGAyHHdphdroVhoD3p73
	C1hl345tbmMWh77OxW9McJxXt6mDzjsdmXVm8h8NcGbR09Z1GixXPc/XwkQoib4kBB5a9x
	dCk9lZKkturi167xbzeTGAxTQQsE2kqujBWA3hrvOnRDmtk04uSqO6yjpHY1SdVqkZG89h
	AE52pfWQuQxPcSr3WFbilrz5X04fe2tDg5iGzdNR4dEL1w4/f1uujY6Md91j+w==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 03 Feb 2024 16:02:00 -0300
Subject: [PATCH 1/3] mmc: core: make mmc_rpmb_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-bus_cleanup-mmc-v1-1-ad054dce8dc3@marliere.net>
References: <20240203-bus_cleanup-mmc-v1-0-ad054dce8dc3@marliere.net>
In-Reply-To: <20240203-bus_cleanup-mmc-v1-0-ad054dce8dc3@marliere.net>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=920; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=o4HUoGdcsUJOmCXT/I7jQBFT0zSuxvv3O5ivx8MH4k8=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvo2trk1VrKcTAOWlzNrMqmne+oTtBU8zuIxlB
 HwTjvuwipGJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb6NrQAKCRDJC4p8Y4ZY
 pkfdD/4vLQQWvPNzefu7QZuxYUKf/gbZ6A5CiI9nSeQK9ITPt2Vuijq4mgVunl7WFOmEuGDeitM
 lLzlWvrNRIHJez+PYKGnr59ZeHPv8GjepsU+pVooHC0vLF2jFwElxzlSXHzv1YegIrN7grqf6vV
 mpPGj8njukdPYa+GTFYsA+O93QJlqfxHdCmT4FWPHuCyFQYlrmvJNB9KZFNw1ohQaHGdM60CbEJ
 0p9vqz/e2wfr2YHniRQX4MsDs4Ju/cESN+vz/h9xAAsjCdTPJ3fsDJbXIFkQuP9HPmhkohvn0Yu
 AJSfp+TWDMuheiHFwtq43dsbrUPnjOE73CSt+yW+bWqtQkQeNQUPtK7X+erZOPMMJtE4n+npOnw
 MGe2TE6U4/Ei4Ud1B8Wgne9tK8yOFBdXY5/Uu7BqXe5JOQl49SYklHBqNcfyddzIIPDnGJ06tjX
 99G1JKNFKNgqsTLLJTfsfEBoXYuyTm6evvrsXON9vd0SlhXsa2Rdz9AmMyAPSlDizRUZ/s9Rtav
 hMCrPKewD6jxPg+Jn0h7KxdaX7GUFuDOizJpFEukpKbUXkg6bTtQa3eACFzjjk2XPTtU2GjfKfk
 sObfZS70rBvnVfxwibs9zUBONrkGIzSNI6iFr2WwckuZhazl8A6ATcBz3pC8IWrpvcX6C+fqGdM
 EOxLW4Zn6QgsPYg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the mmc_rpmb_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index a9b60b91e32f..bd165cef2bbc 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -144,7 +144,7 @@ struct mmc_blk_data {
 static dev_t mmc_rpmb_devt;
 
 /* Bus type for RPMB character devices */
-static struct bus_type mmc_rpmb_bus_type = {
+static const struct bus_type mmc_rpmb_bus_type = {
 	.name = "mmc_rpmb",
 };
 

-- 
2.43.0



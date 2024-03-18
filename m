Return-Path: <linux-kernel+bounces-106481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A9D87EF33
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF06DB20D74
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F60C55E40;
	Mon, 18 Mar 2024 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bReYpJVT"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6D755C04;
	Mon, 18 Mar 2024 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710784298; cv=none; b=B3zbCKYba+P2/b5ay/53j2iUqCOd0hsDTJgfwaDQM+BUHAQz2K004fBOrqpHLUPTPyuVcN2gKc/w/Hxbe780JwROnaMKoWVHeId2UD6M/vOTOlsrNwvkn/twV03FQgSr9wOFcrctWAAh3MKLjBJxgbPNLanSid3ng1WrwgkvN+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710784298; c=relaxed/simple;
	bh=8BWXMGXPrhSjM7hndIIPhTy7ngPeOpfjajBLn5mFHCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LSJ2hkFEzJKlbqh4X+fI9QguJ/TmI9l1e5y9A1HtxymAS9nFTWxYutMvNOiV6YWgsvwA586nKhIEE5oyWX1Z3cB+cY42RV/0MlrDUKDrjnN9t57ICv1woavePYX5xqw3JfZG9ZQhb9DvW/4JtA0kv8SfMB7Tb7Q0xmbKvkUA1ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jessamine.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bReYpJVT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jessamine.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4142296d8aaso5401985e9.3;
        Mon, 18 Mar 2024 10:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710784295; x=1711389095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=G32Lvb6DaT3Z5N2JWzRdtUsZLrSIo1Qe2OqdOhc2VvU=;
        b=bReYpJVTW3Y45xVaJyOoc7fFFMiP1SLlkCBPdyi+W9EWyybRmDOYHAeGOJwpdsnOmh
         6ciALYg/x7PKUWiIz6/GKM39KTUfgXhpK8h3Gsqu/LHP5lKRkOdMYfNy77k+p5pAPsnW
         0cgtS7VmbglGYOz9TThJXdCwWNNuuqThrykc1ryOUj52dYwdQTNqkZm0POQuta7QVJIu
         1AGcCre6R+7NZ4I5NtxT6atVkbpiVZCGXaCnUId+TLLd9rZ0cEfxIhdxiawgkmy0MhGL
         4atdxsiOAivTKhRD55QalQ3GxzkgAEdslFTWrx/tsrDeDoGcxfY1xv5NpCUCf1R6khYm
         gtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710784295; x=1711389095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G32Lvb6DaT3Z5N2JWzRdtUsZLrSIo1Qe2OqdOhc2VvU=;
        b=Q1SMBoMPZhVzFFsb9IGyOd68O/CspF8nJd76/2/kNnG4YL2+kPWOkJCxhM2+8ThVM3
         BttFaPmKfPzosKWDVBhiPBEjVFqlsVuZqGaeF0BPnPNRil/Z8qxhYil1LfoZHI9MZmv3
         y5Ck9n3xz7WsblxJUItXH1t2iJWn31Zgi6MKDLq9o1Rnjv7WJEqiKbEgJPZyh26zFlQQ
         OxHQKx/nY67MFr1MB8Y8zrx5oP9XGUN3g0j+uHIspDa8QsrbsWr2LSs3Ig9NnZ9i27MC
         c7WNOr92limA1YFsiUw2PGC2bsWAjWzuHtOyoqN3/2vdfdCA9Fz74U4GFhbaA3LLRal8
         Zb8A==
X-Forwarded-Encrypted: i=1; AJvYcCUEwotBgZaxvCVJTGV9MlVNCVR/QJ3/0MICOc7xfglVH7Fbs4WW7+kq3SVR/v75ITPxKbzwWkufriL5J62XriNil7ldjQ+eCfWT1pg8mvrY0eFiNJHQCEFlCkzMAbfbox8e9jzNFuzw
X-Gm-Message-State: AOJu0YzIQycv8CKNV2YCYDcgMOL2gv9kQ6bb2mGfLF+7o1rNMzQxguJI
	/te2SdFEGZWFN+li2Q7VRPRwC12f/GobH3ZztEKqkax36C6SDTB/
X-Google-Smtp-Source: AGHT+IGmrpe4rMtrnwz4paciaxKw9R4UIyEVRfiWaf7mvEQqFIOAxd74g/y/KTdzA48sbGltNcPXkg==
X-Received: by 2002:a05:600c:3503:b0:414:4d82:e610 with SMTP id h3-20020a05600c350300b004144d82e610mr210320wmq.7.1710784294555;
        Mon, 18 Mar 2024 10:51:34 -0700 (PDT)
Received: from localhost.localdomain (munkyhouse.force9.co.uk. [84.92.42.80])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c3b0200b004142894df64sm1890789wms.5.2024.03.18.10.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 10:51:34 -0700 (PDT)
Sender: Adam Butcher <adam.jessaminenet@gmail.com>
From: Adam Butcher <adam@jessamine.co.uk>
To: broonie@kernel.org,
	benjamin@bigler.one,
	carlos.song@nxp.com,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org,
	stefanmoring@gmail.com
Cc: adam@jessamine.co.uk,
	kernel@pengutronix.de,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v3] spi: spi-imx: fix off-by-one in mx51 CPU mode burst length
Date: Mon, 18 Mar 2024 17:50:52 +0000
Message-ID: <20240318175119.3334-1-adam@jessamine.co.uk>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adam Butcher <adam@jessamine.co.uk>

c712c05e46c8 ("spi: imx: fix the burst length at DMA mode and CPU mode")
corrects three cases of setting the ECSPI burst length but erroneously
leaves the in-range CPU case one bit to big (in that field a value of
0 means 1 bit).  The effect was that transmissions that should have been
8-bit bytes appeared as 9-bit causing failed communication with SPI
devices.

Link: https://lore.kernel.org/all/20240201105451.507005-1-carlos.song@nxp.com/
Link: https://lore.kernel.org/all/20240204091912.36488-1-carlos.song@nxp.com/
Fixes: c712c05e46c8 ("spi: imx: fix the burst length at DMA mode and CPU mode")
Signed-off-by: Adam Butcher <adam@jessamine.co.uk>
---

v2. Cleaned up body text.  No diff change.
v3. Corrected log message ref to upstream commit being fixed.  No diff change.

The original patch submission up to v4 (first link above) did not contain
the bug that this patch fixes.  It was introduced in the v5 update (second
link).

---
 drivers/spi/spi-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 7c1fcd5ed52f7..100552e6c56bc 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -743,8 +743,8 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 				ctrl |= (MX51_ECSPI_CTRL_MAX_BURST * BITS_PER_BYTE - 1)
 						<< MX51_ECSPI_CTRL_BL_OFFSET;
 			else
-				ctrl |= spi_imx->count / DIV_ROUND_UP(spi_imx->bits_per_word,
-						BITS_PER_BYTE) * spi_imx->bits_per_word
+				ctrl |= (spi_imx->count / DIV_ROUND_UP(spi_imx->bits_per_word,
+						BITS_PER_BYTE) * spi_imx->bits_per_word - 1)
 						<< MX51_ECSPI_CTRL_BL_OFFSET;
 		}
 	}
-- 
2.43.0


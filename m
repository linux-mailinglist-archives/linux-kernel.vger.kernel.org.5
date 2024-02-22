Return-Path: <linux-kernel+bounces-76979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCBA85FF5B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA341F22BED
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BD7154C14;
	Thu, 22 Feb 2024 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6wpBkW/"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95B215697B;
	Thu, 22 Feb 2024 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622944; cv=none; b=OBJWZpY/rfZNnWhy/PqUfcjkdLLcQBG5FyXR6vD0ahUD9ghDTKjep1HUxgyBQqFdxHi5CQv9+1nt5/GNMF1QdjcHpm+/s1PA+pm3EpoQd3JHfdmohu7qO+8i4FbFXJci4Sotm4S36zFvWFUEOagWWBPgNfQM+FSx2L2lyiYMiJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622944; c=relaxed/simple;
	bh=6ticN/bpE5bQI29guc6BdJ1XX9ECPQuvaLfCMOwMkGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWl0xBoNmhUL5Z//XPProrxgCNRb+SCylTvtWOKf1W9Y4w6UQNfb9tSi40cZc29Ui0H8u7uoMZi0MHzkcoOJNTJRCzSotQOktGlUfBKpNLfyUv0LjI73gtDtBiihZFH777x4OXlByCOAMRzo176bcW7jA4aQ9RvEQtYuuee60go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6wpBkW/; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5101cd91017so11408e87.2;
        Thu, 22 Feb 2024 09:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708622941; x=1709227741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEqLZ6Gy6Eae9nuf0RTcmRkVHUtxknsKtEL8YKpPJpM=;
        b=X6wpBkW/AjAfKuZfZRCrDUCjSGMQNiKqX9J6XMiJGUYzk3+Uj8IgeiHkpI8q8mUS0R
         fzSvpEJF2D47Yv1rW1pVC0Xt/AUmX7117LRfXV0Oixa22qZdLczMK/Kb++3tc4Ye8mNu
         rttMYNifr+myP76WgyO+fNpYgxQZ4ev70pCdCILETKafST3W/JQOzj6GQClGOXg3xI8C
         w96QmpMFs4lLV+dSdgpVLKCdUeKagpG44nDtersHgkT77QTT9CsSlfq172mbmKDmkTU7
         vdBNRSkmOpifJhm4pbjvtned4jq5GIfqfhvv3V/HRT4hS8J+n+O6TN+1qOXJo7LUYt/e
         2Reg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708622941; x=1709227741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEqLZ6Gy6Eae9nuf0RTcmRkVHUtxknsKtEL8YKpPJpM=;
        b=moROCRstRozfwjwgwjz/MhuJ2D+hhk6kn6dGxVOIsf0nvJAmJtBLVLsHv4fS+3hYWz
         4kwsZ3/2lHewmUExIr8xWi5ln2ZiNXWk2I9m7i0opvPukhzbahuardIlu+Lgsv0isYNP
         0UZ5bEu3gW6z24xCQgnwkCbQbraJHHxBjihlu1K0f2aVJsdWBwIywijhUxoZ9PsHWUxE
         pRY+9asgLY1MFCZcsK1vFfg8Z1bP6nOwxurzpaOd7oegPmLJO6h5BptdgYJTQhIKQC4H
         eSxgJRR/HSrHo0PSDevrzupwJJ5opd4y1urg+NcJAdNL7wjFUGr21f664IsNB1S+YqJ7
         Xv0w==
X-Forwarded-Encrypted: i=1; AJvYcCXLGR/evcphLg+gYgkGFGWSnFcolGodWYge+Mh0jdyZcuVxIVRk7OYsW2tlm5zaJcoKQRTiJ75HK/ZcLg/07HTeI3RMm02x7Ka3JI8hfYFlgMgx+836Mwo9KSTOWEIr6K/qXcPyPt61
X-Gm-Message-State: AOJu0YwsefU5YSV2rTtxPZYEs8UVYvZMb1fTpEPAnI/v9QSzC2FsmO3G
	MxxBowEJLHTkEnFMBIK+zz7ia0JNz+g4sXN0CtWK9r8uyXGbcpVr
X-Google-Smtp-Source: AGHT+IERl5jcpiHAAZslbiRNDJHAXowyG99S/ycJfYnazvAhZiRB8wV3Diqm1iiGcolRsCoeP39SFw==
X-Received: by 2002:a05:6512:234d:b0:512:e394:2fd8 with SMTP id p13-20020a056512234d00b00512e3942fd8mr191862lfu.50.1708622940663;
        Thu, 22 Feb 2024 09:29:00 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id o16-20020a056512231000b005114a3c1107sm2130612lfu.268.2024.02.22.09.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:29:00 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] spi: dw: Convert dw_spi::num_cs to u32
Date: Thu, 22 Feb 2024 20:28:46 +0300
Message-ID: <20240222172853.25082-4-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222172853.25082-1-fancer.lancer@gmail.com>
References: <20240222172853.25082-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Number of native chip-select lines is either retrieved from the "num-cs"
DT-property or auto-detected in the generic DW APB/AHB SSI probe method.
In the former case the property is supposed to be of the "u32" size.
Convert the field type to being u32 then to be able to drop the temporary
variable afterwards.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v2:
- Just added.
---
 drivers/spi/spi-dw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 6cafeee8ee2a..fc267c6437ae 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -164,8 +164,8 @@ struct dw_spi {
 	u32			max_freq;	/* max bus freq supported */
 
 	u32			reg_io_width;	/* DR I/O width in bytes */
+	u32			num_cs;		/* chip select lines */
 	u16			bus_num;
-	u16			num_cs;		/* supported slave numbers */
 	void (*set_cs)(struct spi_device *spi, bool enable);
 
 	/* Current message transfer state info */
-- 
2.43.0



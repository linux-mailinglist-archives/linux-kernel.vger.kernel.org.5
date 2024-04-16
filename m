Return-Path: <linux-kernel+bounces-147161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EA58A704F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4990F1F21535
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBB0132C1B;
	Tue, 16 Apr 2024 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaQ/mKES"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE0A132484;
	Tue, 16 Apr 2024 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282791; cv=none; b=OV+qZnXH1hIum0pQXnZEvNttw17Dzs9zxRz3j2SfXXa+6euDJr2WgSUoW2mPPyWO37P3as9Y5sJeE/TljZrP7aPCkAtm/rnxn9ags3TXyvkkPEh8KKiDi9Ri940D0W3lhZveNVEWiJ9kSrpprDqd4NXXAfJdFAcvp6P0cGzjFDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282791; c=relaxed/simple;
	bh=UGWxHmZrSPG8/xRqYnebAtoN4G8LcvIkIQJroY+v/X4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6xn6vP39jYFBVSpcMPzGU92dKYfZWZIV17MDdU8UGfr67QvycC8YmS83D6t0Z0UD5vyJ7jeBxcpAdYFIp8EQoAxhFSZQrArVG0K1QVTtNgS5TwuFMBiI8WcWgRoz/3R5k24SCQMON4y+GwvI1HTAGa7xRzk924DW57FjomJXKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaQ/mKES; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d487659bso5523391e87.2;
        Tue, 16 Apr 2024 08:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713282788; x=1713887588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGFEeAw7g7SRdmEPZBJXDlgsScugDV25Y9+Iq5aXYYE=;
        b=CaQ/mKESClwIbJHR0NQ0DHvfFEZ1cFIr+V15F1hiNtHGg+ziUCv4PHiZW4fMC54y4Q
         gueoWdbK6AcgXPOpBdMwnEM3GNePT0vgCv7RKIfVbRjQ4F6ayPWdl7c5/DfT2zwymPm2
         9yAFWh3giEEaUcXCETgCZP05J4LgoW1+T/uWmTllx52DDpVC6p8lX+ORkekv2qB+8Fgx
         EznTDAtV99y0h7k8xmTybp0I/56/4ydooWRZ52uxTWrhSZ8UK+lpuSr1nEo3UxuJiXuS
         jiw2duBONn7WIYd5xikLhMV2NT81AUbo/p0W2DkmR3uV3hFGzqQHriHrHjgoipjvIrPS
         rtZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282788; x=1713887588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGFEeAw7g7SRdmEPZBJXDlgsScugDV25Y9+Iq5aXYYE=;
        b=apUOt50MC3f2TnA8MkxDbtDu13bJM8FpWICFKkaTh+TaigJzAbheJBJGTdwnaMY+xR
         qr+voCJGfXpVSqdIN4EOjsr5tbS5kL+HXWKrrrJUzW7e6rjhWOWydbcyJWRqgPUsYTb/
         MCb93djBQ1HFStSekuCSgaxKwN9AAqhmkOxtQSvdy+eB5wv6dvhtlskC+VyDANMGeUmd
         hLuXzXsoqQVwGBuLi17RtQ8/ze4ZV8T+gKkg71DMXnqNuyh/gqiHigMkWnL7mSEd8cEO
         ptxrRx0pk5GLf42HeOX57qZ68wd5L6Wl1+fgRCteNzqZQadzWP2q7g4BYzsPzYkDlmRD
         Q6Cg==
X-Forwarded-Encrypted: i=1; AJvYcCU6zkDLJ0Kfaxg+EwywhWbQUjkvt70sg89YUluMIW/SVEbFWQWSPb/p7tOb5GaCfjdYFI2r1xMurbsX7i5cUUrgAmMJQi+L42z0xPTQyOOofjt02647kLonXZfjlJmalAZ6SbxBOxOw
X-Gm-Message-State: AOJu0Yxql6oA/WRpHZrjh5Fd9uod+ekBRBfShM5arXY45dud3L912WKK
	PfFkY53Oh+F2HhHbEx8s2Gtuuxc3/oeq5vtleRF063EbDZQ+OV/J
X-Google-Smtp-Source: AGHT+IHmFtrZbedJpSMWdE2mG9MIg7a44E/hkNOlj1XWn6b1agndnR/SwISstCEaUh8i1eubA20Muw==
X-Received: by 2002:ac2:5982:0:b0:516:d692:5e0b with SMTP id w2-20020ac25982000000b00516d6925e0bmr7466849lfn.54.1713282787839;
        Tue, 16 Apr 2024 08:53:07 -0700 (PDT)
Received: from localhost (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id j17-20020a05651231d100b00518b5e1f36fsm968504lfe.233.2024.04.16.08.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:53:07 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3 3/4] spi: dw: Convert dw_spi::num_cs to u32
Date: Tue, 16 Apr 2024 18:52:33 +0300
Message-ID: <20240416155257.22429-4-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240416155257.22429-1-fancer.lancer@gmail.com>
References: <20240416155257.22429-1-fancer.lancer@gmail.com>
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
Reviewed-by: Andy Shevchenko <andy@kernel.org>

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



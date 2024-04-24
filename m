Return-Path: <linux-kernel+bounces-157161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0488B0D98
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094EA28B121
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEA416078B;
	Wed, 24 Apr 2024 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLNgThCM"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BC315FA6C;
	Wed, 24 Apr 2024 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971243; cv=none; b=p5OINEqTKH6Tb6ksrxekN6JYr75HnRSjz4OEQPKTqGoqOYjhHTx5Y36m+ZY9I16mwoCMcDLB1VaffJ1BDiR/1mUctvoUhxshv7+H9YR/7KwSt0nlr5aNh50aWYX5ZShHwDI23+fGvA/rWVCR4mQoPsPoFUsdIv5aXm1omtC16A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971243; c=relaxed/simple;
	bh=UGWxHmZrSPG8/xRqYnebAtoN4G8LcvIkIQJroY+v/X4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azcfP5YEgY8DAqxqeKNlLhk35PQMITA2x5vHKXaHerCddYP9m6ObHiIH3D7F7U/PClHmvRs/kV2zFD/UGJALGeek6yBDW2EZoQD7xkD1GFrhhzvP4Ly1astBn9Rw+jU5I0VHk5YykWaIjPKKw4HLbYg6y99H7HMolS4Q466aaxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLNgThCM; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d88a869ce6so97872651fa.3;
        Wed, 24 Apr 2024 08:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713971240; x=1714576040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGFEeAw7g7SRdmEPZBJXDlgsScugDV25Y9+Iq5aXYYE=;
        b=TLNgThCMlQoL3ZRNS2U8qxuhzNWveQ1ygbV+12lZroF4rQuMWJL78seCYE1bFisQKV
         5rFSlm1A8PyCQdpHpWWdw+n1NMRAbww6eKp2UsFNe9wItwWdAwMGBYJw4hJzrEjuGZDC
         12shhuR1NkVHDeyFoM2ebLF9aB1Jdyfuy7G8usIZXENeIfEdKxnT0tsEL4iyeSnJP5Su
         J9IqAS31gbDBJTzl7fFqhf15V12385unp/UMe0M790Thf/cp93wYRLHUe8CsWulR/r8X
         foQJDhE9QFvSAVtDMeATsQZJOi5tvmNNyqNQ+2jUpASebNYsvTlBLcDHliyIiOhtZDtw
         IEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713971240; x=1714576040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGFEeAw7g7SRdmEPZBJXDlgsScugDV25Y9+Iq5aXYYE=;
        b=LkeFMCSh8+r4aPBKzJfmHSIQAYsFgpr73kImlqGmo8Jhjd7fUJm6otrCQKuDlhJNV+
         r66tlPg4WPQLRUg0Qzj0ZgLTWu0r4p1yR3TvlhyEclxgE6MLLzNn8vh+SKMSJiCn4N7k
         aatFa+8W4WJaBIzx5KS/Dox38Q9Iupi2RSAIG6dKdRrNSrpy3gAWeUfm3IhY+P+ZCRMq
         Ye5ZN2R+lBFyYv4/VaZHfV+BsjX44WmhakHmYtrC15Y/1JxZFR0Y/xe+Ia+y2PEsKG5k
         pImdjE7yqUSm3HZJgU1ZVCwXklFlm3CiN8/wshMdBTyj5RZiFmhWiRV7r3krx51uYr02
         txOA==
X-Forwarded-Encrypted: i=1; AJvYcCVJrQUnn17sc0edSQ/OQ3Ym27gKKzDSWaCcJmmyyOHS0bBxvCleRpnDXjocSQY3Y5AXPBg0gFrLnOvxjBsM3muMFsq3M/yNpmcvbY2bklEsGW/tEyl6nM9zG+LWDzIRMI7MUFGcvBoU
X-Gm-Message-State: AOJu0YwluJyl7ALX+w8v2nCoXNWq7Ne5Qnr5OTcoZOAhejz0YP/6x7F8
	U8LyCtG4prEqa9AgaiUGLEtiHFU/UoVawL2sdUNDUe7QTlfgOlSTjCMupQ==
X-Google-Smtp-Source: AGHT+IGh6P9/jGPmZsaaKejTncr4C3FmUZ48Pp4QBCoWQcVIVrcCpb320zF2eFeI5o4F3q4MUhCN+w==
X-Received: by 2002:a2e:81c2:0:b0:2da:736d:3cf5 with SMTP id s2-20020a2e81c2000000b002da736d3cf5mr1779681ljg.41.1713971239749;
        Wed, 24 Apr 2024 08:07:19 -0700 (PDT)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id b39-20020a05651c0b2700b002dd1f5c8fb7sm1281148ljr.82.2024.04.24.08.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 08:07:19 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4 3/4] spi: dw: Convert dw_spi::num_cs to u32
Date: Wed, 24 Apr 2024 18:06:44 +0300
Message-ID: <20240424150657.9678-4-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424150657.9678-1-fancer.lancer@gmail.com>
References: <20240424150657.9678-1-fancer.lancer@gmail.com>
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



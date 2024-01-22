Return-Path: <linux-kernel+bounces-32490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A40F835C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7305283DA6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE5F20DE8;
	Mon, 22 Jan 2024 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkA1jQZO"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593B41A5BA;
	Mon, 22 Jan 2024 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705910799; cv=none; b=SNEnh5llHTGZOLwXayTtWZqIzX+DQ4StH1h3Pu4LpUv7KbyChl/E5WlZsF67banGerzcJmnID02ZcJM9Cb6Ir1FZm5yRlZS8U+YmYDB6qRYUfNAWACPciSsaoxmIPh69cKctLPfZwW+8wb0J8hc+MASfvEgNFlydqZB00pNly4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705910799; c=relaxed/simple;
	bh=BOkuB+vlOnKyUnrnWBUz0nakWBcjSi7NGxSFQq4VmRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elgaKM+sUReuNUQnR1zAwkMngZjKP0+cIIL5eK1fC7IiWA16o2vXkGMyu5WiR+cgTCETwzLrK/CGz+Fw9ZAytl+qT6Ya1FUG9pJiywfchY9/JFXEEQ8YmdwEL4qsVeOlHmo+3NfgT7M4E6iVV4IcUaTGMMKFNomrGfv8k3pQAv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkA1jQZO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d748d43186so2401255ad.0;
        Mon, 22 Jan 2024 00:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705910797; x=1706515597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VU56JILwy1WXTrtMzKmPdAiKq/ot3j3oAn5XBUHBiYQ=;
        b=XkA1jQZO+J26x3l+PApyQ4xttlIk2DIF+OvUGHlGjD+UDZXNFaWyV2STaLm9EMLFbY
         eQgioxEFSTmqzEGN/nVK/OODs88UFENjv7mcy76dCvCj81dSaXtgJSryc2Yr8n6lEON1
         k0/mtOQ1G8DAz0jMfgnvR4dS/eAF6kLepPqAJY2yXEtlJXr3770oEVtyBwQa5xxTy+BG
         KKkKvgIAm1thV+FpOmaD2RsD04JJSQySwP29OKycLSMGpXcvcydVMmrd+S3SBjNIwxl4
         KxppwJYlO+AliyZxpD2clUS0IX/11r81TTOQZXGVoeVyI36k3e/RelvyXwjeBbGNSHyH
         vhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705910797; x=1706515597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VU56JILwy1WXTrtMzKmPdAiKq/ot3j3oAn5XBUHBiYQ=;
        b=oDhuBCrlN4lm13kvDBp3SiT+ED0M05SBQwy5lG/zZ7tU20ZQEBY6Uwuenw8kFIY9tR
         hS/AeIz0XqBW8bO2D09dRhb63AwscLwc2gT/OOLHEyg7RtL0jDCpk+dvaaEsGQsXpCuO
         WNxL5l/tQklJUolCDUxDKUYPJuavvD5rHPoGhok83KnKwbolVjliWqlpfJ5W/q5iBR5B
         mgRR7MdRgajrNt4lKdjOUbZFagfiRhasQw5Hgmwz+x2EXwQv/f+cPYl+03SXfq5I0OqF
         ij1TWb/2/xeWTiY8OMiFb/UuIAp9ST92NdvsflBD/4qtjquixIpAuzp2JWPwfeyCC+Y5
         k4xA==
X-Gm-Message-State: AOJu0YyYPH0hAwdksEJsyTt3cdrwacJPvWwIn7pnTQLH9+Gz7rFbVfWL
	NodpURcGWt6hshxJLmK4oC/6s/IXOEEO0RWx2FGrzm82c8zm5UHa
X-Google-Smtp-Source: AGHT+IF13paWEa4F0XS+JYHFMWFgLLn9MwQeEuuxtGbot+R0GeOPKiyEbQOUVZSkLU9+kQ1FuLeP3Q==
X-Received: by 2002:a17:903:41c2:b0:1d7:2ede:ce8a with SMTP id u2-20020a17090341c200b001d72edece8amr1243257ple.98.1705910797339;
        Mon, 22 Jan 2024 00:06:37 -0800 (PST)
Received: from localhost ([46.3.240.101])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902c18d00b001d7134d149dsm5764072pld.256.2024.01.22.00.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 00:06:37 -0800 (PST)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	dlan@gentoo.org
Subject: [PATCH v7 3/3] riscv: dts: sophgo: add rtc dt node for CV1800
Date: Mon, 22 Jan 2024 16:06:31 +0800
Message-ID: <20240122080631.2880-2-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122080631.2880-1-qiujingbao.dlmu@gmail.com>
References: <20240122080631.2880-1-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the rtc device tree node to cv1800 SoC.

Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
---
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
index df40e87ee063..0cd7eb9a3048 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
@@ -119,5 +119,12 @@ clint: timer@74000000 {
 			reg = <0x74000000 0x10000>;
 			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
 		};
+
+		rtc: rtc@5025000 {
+			compatible = "sophgo,cv1800-rtc";
+			reg = <0x5025000 0x2000>;
+			interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+		};
 	};
 };
-- 
2.43.0



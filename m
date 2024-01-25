Return-Path: <linux-kernel+bounces-38695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B5683C43A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7571F23ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404C9605AD;
	Thu, 25 Jan 2024 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TyuDFN7b"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A08604D4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706191306; cv=none; b=I7SmDYBdIAy26n+UJPw+WK6m7EpQYcasgYmu0eWgM2SQrl53xQWKsP8Da3E2M0ZXC7Kq/AZVOcOwgW1lcqonCVD2soMOyLniBTtVS/25vLsbsH6wZZtcqsrNs/k2S1ryKlDBWvy6v1DTZbP05ujfQvFCWztUr0Ydft+0o2ZGvN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706191306; c=relaxed/simple;
	bh=JQ0+STV9AqGXR93rvqvT/Fhpuw2Ch/BDzNv9b9Rs614=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lh6+mn5dCWR/+Fl95O6FZO1c+0x1NSWEyeFsq+QYTK5AV2b7Qb7HAkNLflKJKdua7P80/dX8Vwa+x5oZLfGRRY9AN5euFeLhd133GoFtTv/8xj54ADAAY4IHUYB14Q5O/Mjgl3DmZsQvD5qloWjwLSHv1hHqW5MCMwXNn5SiESI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TyuDFN7b; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a31798a73bfso49057866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706191303; x=1706796103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwJ9LZ2cw3a5KQSrNOlRxJLZjD3460dcBT/9JVrzxHs=;
        b=TyuDFN7bQHbl3S2Ur+gM9RXByOLlqprLwAaC0LZ2qytxgcT1hSjvOESBwqAskMTQnp
         hr+D1iajyd+56jGP23le/FXT4jR6BZcxCE96eZm5C4YhjcvvRLD3YGgRlr7ofbrYUpgK
         65WECjF1+dCTXXCYfmlFi013QfC/FLUUtvUBGk0D9d7eAyMd4m2wKOT8WVQjTrKbxmsB
         I0P6sJ3U6WAVChpdaXQ3JRYFsZLi/iOG478Q01VyD20l+ahd2Bqv0XrJLynY8iWhfQ4K
         tdVh5HNTHKqNpJTE8795p4B3iIvy1MyUjMIElUHfnZO0esj0Q/U6R8guwNsoC+f5/aoE
         wHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706191303; x=1706796103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwJ9LZ2cw3a5KQSrNOlRxJLZjD3460dcBT/9JVrzxHs=;
        b=CJIThBFljA3y7Sg7BTadcqPaBboUnChr6z9cOsOrlZZmgRVdNaBNLH1Q0opVEEiPtj
         9lkqb4Fw0LCpJX84Iz/+MhMdCZZBkyqqedqr77TeBxUKjlFS8CO8buL9WL+pTGAl4eKQ
         ejKRDi8ayeYCFh66SD/1Tr5GpFt4b1ZNhvn2aw2xr40xNL6yXJPNzlSKF1QPTwv5CMJT
         UDdJ6OsCNZKeSKKVSTn8IOhbJhJdn6j8CWrNcJer4q3tqRR7fsOfDJGScf7wd9Y4aZtL
         0liNLSniibok5qzZJmdZV7m91jyRRDzaxjVW2MhNesSLTLzCFM1WAxFGUoqO9o/xjaFH
         QdoQ==
X-Gm-Message-State: AOJu0Yy/f7PDYph+nunXoWsjj6nlUtsD5trKopeeTvtGj1Q3V3XVX5fw
	jiP3ebXbxt635fdWYXYPl7XdYTBQ2IZoUILhFGiZ9LFdzDBf/m4Ibe/27/rcQC2ZlMPxPW/86qE
	Bmf4FeA==
X-Google-Smtp-Source: AGHT+IH1Ly+Ije5EF60Sv9Ag9cguIboXYkkLHRFsIOuKq7QuJ/2bZMfnSdOXsrWMbaqAC7Cd6YvmmA==
X-Received: by 2002:a17:906:e2ce:b0:a30:b156:50e4 with SMTP id gr14-20020a170906e2ce00b00a30b15650e4mr586764ejb.42.1706191302914;
        Thu, 25 Jan 2024 06:01:42 -0800 (PST)
Received: from puffmais.c.googlers.com.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id r17-20020a1709067fd100b00a2c7d34157asm1048170ejs.180.2024.01.25.06.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:01:42 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
To: linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	peter.griffin@linaro.org
Cc: kernel-team@android.com,
	tudor.ambarus@linaro.org,
	willmcvicker@google.com,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: exynos: gs101: sysreg_peric1 needs a clock
Date: Thu, 25 Jan 2024 14:01:39 +0000
Message-ID: <20240125140139.3616119-2-andre.draszik@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125140139.3616119-1-andre.draszik@linaro.org>
References: <20240125140139.3616119-1-andre.draszik@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Without the clock running, we can not access its registers, and now
that we have it, we should add it here so that it gets enabled as
and when needed.

Update the DTSI accordingly.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 412d2866dca7..aaac04df5e65 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -364,6 +364,7 @@ cmu_peric0: clock-controller@10800000 {
 		sysreg_peric0: syscon@10820000 {
 			compatible = "google,gs101-peric0-sysreg", "syscon";
 			reg = <0x10820000 0x10000>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_SYSREG_PERIC0_PCLK>;
 		};
 
 		pinctrl_peric0: pinctrl@10840000 {
-- 
2.43.0.429.g432eaa2c6b-goog



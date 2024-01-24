Return-Path: <linux-kernel+bounces-37649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0212583B30C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D71AB24587
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6E01350DE;
	Wed, 24 Jan 2024 20:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlbCS7dN"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1094913475C;
	Wed, 24 Jan 2024 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706128234; cv=none; b=uOo3yboxAZDntLJuJ0+J3odIETvmqBurV4qLpzZLVY9GJ2SYotH7qQMzxbYyi/Myu6Q4BHVnfB9f2JNN2tozbUFuEn7gJwKcPqDsrg5afqXIUvcuq+jSMISKLB2nIBWKz1LPSJ70D+gkkj7eLhbLQm9q2n9l2rccuVoksnFSHsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706128234; c=relaxed/simple;
	bh=WL2tRjg8ew8DqItHe5VMXx4XizhzUARbkSBb7xc+JjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fHNUpguBqKihkIGLeE4wKnnZl+JKwY7PcwchrigPYqjB0MudsOof14hFBpRtgmYSvRHx4V+aJ7+WT3/+G9Kbm518xzZscJ6eSm/q1H0c03tMaLcuzmWWq+SfpfGrdzxfAmGSHHdJdMF1Z1OXg85RrSFANM5ynI0V6iihGZVgdTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlbCS7dN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40eb0836f8dso33037655e9.2;
        Wed, 24 Jan 2024 12:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706128231; x=1706733031; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwDZ7OaLOoaTgMtKqR7jNk1DW8NZBJVNMOjbsbiqpKw=;
        b=VlbCS7dNhqmZAGH0N+edGGQOmfbdh9D+ArAXZ+yJzTNUxh9Hnrot2HBOlMbhYLbf7d
         1jkzhvUh0vZ/i/Z8/bTVhfKY47+5y8YN4moCSqP9X2z7hy+cuk7c9tw8sOW5YMkNNQGr
         D8thE3sIvUJhVUx3DHmvFtR3Ql8B4CBkYwZ3nX6CxfqLeKNOs6XGY5ql9vW5nxxb6kDb
         gJIaYn6cqXN3UYUMjbfoqfYxwH4kj5/Wn6+tJRaamGkL74W9r/kNih5JPR7Sqkhjn3/F
         MHcSmZAOlw/oVf2KwWVZ5BPvQAIkezENz1b2RplFSXSJJKWiYjiFDFbXr4QH4tA/57En
         81Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706128231; x=1706733031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwDZ7OaLOoaTgMtKqR7jNk1DW8NZBJVNMOjbsbiqpKw=;
        b=Eyrn/xkZsOm9zNPH+gGEGzB5UtSquS85qautdblMlsnVDzjoEc7FXCEAenSdQ0zap5
         qhNgRLT2dbsTDlWL49qM1zfP6vOBraZBCjiKIxK7dtWxfjAKn4SAoh6Lup4jGXJ7E8vS
         jUbrimFhU+Kk+BwUbDi9OYD+CNbP/9fCjpXZnPhlFkEhV1pLP0Tuer5fa1iO7UOSAkCm
         SMWbhVEHhuUGs3y7wBYEBiMPspznOcxR9K1kI3HFuKRiS1qx+6KDRWsWIVIaLiIVqn0l
         8zUUdQ7Dwe42ZDK2gvqFWParz8swC+SEbBBv/G5jAjzQwky/uHD6VpqwBqT5NET9AOLu
         bymw==
X-Gm-Message-State: AOJu0YwZ3XjQi1Xjoj0QZIlUTS6M35ai6jqNmk/Cnmhd1em4dwIUq/a+
	gyOuLfE7QEIn0862/lNB5PLe16lwfPhq0djsDLCQx/aCXHSa781p
X-Google-Smtp-Source: AGHT+IGXbvOJHTK/rThOmT1crecXWEtTPAc8HXU8nW+Eq1Sw4iCNC6eKKbn+Ps8UFppe9Zq+1UH1kQ==
X-Received: by 2002:a05:600c:2d8a:b0:40e:86eb:9e7e with SMTP id i10-20020a05600c2d8a00b0040e86eb9e7emr1405413wmg.142.1706128230991;
        Wed, 24 Jan 2024 12:30:30 -0800 (PST)
Received: from [172.30.32.188] ([2001:8f8:183b:50fb::d35])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c458f00b0040d62f89381sm174073wmo.35.2024.01.24.12.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 12:30:30 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 25 Jan 2024 00:30:04 +0400
Subject: [PATCH 1/4] arm64: dts: rockchip: add rfkill node for M.2 Key E
 WiFi on rock-5b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-rk-dts-additions-v1-1-5879275db36f@gmail.com>
References: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
In-Reply-To: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706128223; l=1054;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=WL2tRjg8ew8DqItHe5VMXx4XizhzUARbkSBb7xc+JjU=;
 b=zUPpF+OtMc0JFVxYHKKr0Q3E8J3khN2xHdZhW5GT1e0hcSNmOdPXmJJg0T/SqCHyAK1DRPw26
 ni6pTFSKc+TBft41+kwwrqfotSizXxL3GtEJwgKSxcEx/hSWQEW6UsV
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

By default the GPIO pin that connects to the WiFi enable signal
inside the M.2 Key E slot is driven low, resulting in impossibility
to connect to any network. Add a DT node to expose it as an RFKILL
device, which lets the WiFi driver or userspace toggle it as
required.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index a0e303c3a1dc..9b7bf6cec8bd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -58,6 +58,13 @@ fan: pwm-fan {
 		#cooling-cells = <2>;
 	};
 
+	rfkill {
+		compatible = "rfkill-gpio";
+		label = "rfkill-pcie-wlan";
+		radio-type = "wlan";
+		shutdown-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
+	};
+
 	vcc3v3_pcie2x1l0: vcc3v3-pcie2x1l0-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;

-- 
2.43.0



Return-Path: <linux-kernel+bounces-70025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3848591F0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553ED1F23217
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568827E56F;
	Sat, 17 Feb 2024 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkdgYNN9"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142AF6DCF5;
	Sat, 17 Feb 2024 19:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708196572; cv=none; b=OVFR4A3RemaiLuUm34SYMiV4I4ot7cGsyWM3RiTC5bcYB2jD71QTcNQvCdACmb5CfKX3FnnqzerFCCky1pdSKWp/pxblDIyYE9UFC3M7lDyzXgnipCcFqhvdm3CyK2slBxNgWThozOFD7rc5HLwcbKbHOKCHm+c+npxDMvHXfa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708196572; c=relaxed/simple;
	bh=+gahNNXw/Pm22B5Zq6yjilwXg3lroxCbpY8aZXPC0Go=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IhRe0AnBR/tCJHk+C/XLB7PwDDyiaZ2Y7hPdTMWMfD1QNiqT+71fuQux5/61wC9iVmOpQsJom5xXmE03QFIg3apo8JkGjNOl89teBJcZUpXdrjF5o9am+ggpU91qd9QMB5Vik7ZdzQ9dbB8J0LbmbRqNmsINOy9TZnN768TS5IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkdgYNN9; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-563fe793e1cso1850319a12.3;
        Sat, 17 Feb 2024 11:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708196569; x=1708801369; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Lac2picLjLIoJIqmJ3jwHeZk9Y07zDWjhfc+5OdXmQ=;
        b=XkdgYNN9oirm/pltqghFaJLCsjqh67q+7fB8kSa6US8bBSrDOzgmehcuOq3QT15hlj
         Ru2MwBmFCnZaQzp2/GGXNDLZhIhUJB+nWUDbEr6+kKMyg+s2rKJh1yjky42QIY2u6a26
         3NTRHs40aRa0E8SeHQwPaGmoJrEtBnaxYd2XRyPwwi7BE5kBFqpqj7vqpqyOMk8gF7WO
         fyQEFLyBH3K8ZF/I7BYQpc6zLdjiCkNL46QcrxlIbIMAY6AI1reHsROvDurO7SFWHPNJ
         XKOcPoRf0oNvKg/p8vNpne52iqS+W1/dK6KqHA9Z5ggY17P7J6tY3yi6JANGLvTzARZk
         qyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708196569; x=1708801369;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Lac2picLjLIoJIqmJ3jwHeZk9Y07zDWjhfc+5OdXmQ=;
        b=lQfTakS0X29Tgw90tuM/ruKKVwMnLaWYiS5/8NFdKNj+cdW9JLRNozZPKWCfhVSXZy
         QhJe7pHfN3FfftXSra9ZIwCS+P1BMH1SuvXP384kEHrHy5f33txMK7y5GRtePO6usBq7
         YMK7UwR66jjH/ixeC5jxtkkWPVvZdL/pkZHS00hj5vrXZVLYjwz5mHoj9hCcouYNG+zu
         dxteiczJ2FCgizox47OAu3Mr1hC7QiPVXSgBvzrMEwJGX9RD7vGf+SD418Tz17CBU010
         Lud0Qu7IhxIWvSQFnLVKNIS3UCK4GmAiIPMnO3Ekn3xP6T5XOvnEZAHwDvrijj3bt7qT
         CNEw==
X-Forwarded-Encrypted: i=1; AJvYcCU+S0JYXf9xNJA6HDfQDBQhXLgsEf4RhpNUhnOulRlbnY9tiV3sGQd2VnpT/2KjQvkrho83KNVRFMCH3Xu16ypdV+BxmPtaGBuNu9AtwRWTM+rV5ocHloBm2EY7twjJT9kUFIJyatUSdrlVJblVlQU=
X-Gm-Message-State: AOJu0Yxjzg1T7kMwlt4LjfAADOpyF9NDnjzhqPCDNIIk0vcEGRkdxwPb
	F4rOPERmWjymeVbEH/2e9xoWvs9R/I+QAAJ+0LWSEgJttFFVZhBC
X-Google-Smtp-Source: AGHT+IHUnoow3gnSl7dZKjTAjZ7Dw6aAekHra1nJ9Oj47uNUjo4XtqFr1n7npYF8V87OvInYKn6TWw==
X-Received: by 2002:a17:906:d0c8:b0:a3e:3810:9e43 with SMTP id bq8-20020a170906d0c800b00a3e38109e43mr804180ejb.21.1708196569247;
        Sat, 17 Feb 2024 11:02:49 -0800 (PST)
Received: from hex.my.domain (83.8.201.110.ipv4.supernova.orange.pl. [83.8.201.110])
        by smtp.gmail.com with ESMTPSA id n26-20020a1709061d1a00b00a3e4ce615dfsm317769ejh.197.2024.02.17.11.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 11:02:48 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sat, 17 Feb 2024 20:02:47 +0100
Subject: [PATCH] ARM: dts: exynos4212-tab3: limit usable memory range
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-tab3-limit-usable-memory-range-v1-1-49cc9c86a5cc@gmail.com>
X-B4-Tracking: v=1; b=H4sIANYC0WUC/x2N0QpAQBAAf0X7bMudK/Ir8nDcHlsO7SGSf3d5n
 JpmHogkTBGa7AGhkyOvSwKVZzBMdhkJ2SUGXWhTaFXhbvsSZw684xFtPxMGCqvcKL+tnPLe1m4
 wxkGKbEKer3/Qdu/7ARq6LKhwAAAA
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708196568; l=1185;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=+gahNNXw/Pm22B5Zq6yjilwXg3lroxCbpY8aZXPC0Go=;
 b=tZNoBo5ZsG/QVrkuKO4TO2NXuvdUYWYw6UF8A7eAE5hPJ1Y/QjjwPuwqKIFnNtAwt2PAeHRPg
 plW6pTjZszjASx/zTH5uq7Vy023lVkJTaOTCyCzjWrOmFWRxugBbWAH
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

The stock bootloader on the Samsung Galaxy Tab 3 8.0 provides an
incorrect available memory range over ATAG_MEM. Limit the usable
memory in the DTS to prevent it from doing so, without having to
disable ATAG support.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
index e5254e32aa8f..9bc05961577d 100644
--- a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
@@ -45,6 +45,12 @@ chosen {
 		/* Default S-BOOT bootloader loads initramfs here */
 		linux,initrd-start = <0x42000000>;
 		linux,initrd-end = <0x42800000>;
+
+		/*
+		 * Stock bootloader provides incorrect memory size in ATAG_MEM;
+		 * override it here
+		 */
+		linux,usable-memory-range = <0x40000000 0x3fc00000>;
 	};
 
 	firmware@204f000 {

---
base-commit: 0f1dd5e91e2ba3990143645faff2bcce2d99778e
change-id: 20240217-tab3-limit-usable-memory-range-1d1ffa8dc44d

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>



Return-Path: <linux-kernel+bounces-71646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCDB85A84F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9C2282783
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717853F9E3;
	Mon, 19 Feb 2024 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtEimwRr"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FC73CF76;
	Mon, 19 Feb 2024 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358998; cv=none; b=H1rjkAzSE7T4JySDOT9kbh/CuANsB7/foYUUVIkZ1hUEDcHIDZ1X/BQbH/lMl9aMLv0Zh4GENGkGX9kXtArKJaWohpy6yuYsYoA9zTppbskjiNc5uLgVvmEkV82ZGv4ydCww2NGiX0vOum8Ff6K+j2Yvn0tFDG6+/A+X6YXoMeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358998; c=relaxed/simple;
	bh=4V919eTbFdBw7Tp07YHLEPWHDYxOjIPHYtJG5CrZq5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZzBYOthrplIbA7dfd7z/R4U6+nj1l3KWE7vk8xb/054k06j1u4quEt//eIMjZW1CVyLKjzOS+WSHD8oEXivAiVb9C4NQKHbdqHZn2UVOXMg2zIk4tTU81p6xw6F2hV3htQP7j5CQLz+Ttec4nRi6Mp3hNxj4/yGJQ/X8Y5PXwbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtEimwRr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41262eaa95aso10463715e9.0;
        Mon, 19 Feb 2024 08:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708358995; x=1708963795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcSzz7g/FXeqXPU2ZtW7Zce4uvUpW6Qhsx4YHP77Rr0=;
        b=YtEimwRrMRtPISreOZCYxo0eDHAh868TMFLK+gYEHTY1nUlbuHallkHV+c6So27Fkc
         ohDqvxUVziB3BKw8vyHpYHsRLzXxMAjEzhuCmKmloRa51Lv2TIU+x9fcSKKB3diowq7E
         abH++B55H81Pigxk4+whxDgfBxVEkJgDrWuL5QdPtKeE5BVGI44umvVkr1imE/NqPuFo
         dG8YIY1CJcmQtyuGNN4mMTuIs4DwvRzW5Bmqx0vp4dfiX4anBCycaV/GoZ3mNnPbnkCl
         t9iDdRgsMl3xgY7IEn6MJf+SEltdH/g3UXtYIkpji9vvVbi9EdijO14HIc38wPRsw2Bs
         vqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708358995; x=1708963795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcSzz7g/FXeqXPU2ZtW7Zce4uvUpW6Qhsx4YHP77Rr0=;
        b=r/EzUUqDKEExQvJGdg2sqBLs6JdwwQa7saLEUdIQEfJsom4J+nVkkGt6wyLPNfJwOj
         ubWWADFOr4KVYjdh1KS3ji4i89rWwZP5EcuaLzGJSMDC6GiWNM9JLy1VXndGkMRvHsk2
         5obYQUZ8l+cpJGqIdK37im0WzjpyhYPoMg5V0QaJ+WGiacaN0oKhRzNzktSmpp3LUeqC
         VWtr8Fl3YJU2ZlI1ardq/2pPntkMWAq9c1faFVujbJHoUfpcDGyewUt0zp5usWFQzWCh
         u6d4uqdzLQHCm7UPaBcUhyfxzzhAlZn7Jrauer8F/bLCCJ7CTHf1mP/nKBISPm4SlLXE
         Zhrg==
X-Forwarded-Encrypted: i=1; AJvYcCXdo8BtA810g87VWJVKp2H+b91yrYBFOyhsnmTZXC9RqZRXR4XH6Wbdr76JHRTh2NWJ9YcovRK0VbD4CCLpPwA+7V8eqOz2GMxmxjBI739V8DVMtKVxj+1k6U7wWQPhGD1TqnjulFs5ciIPJ2BYM5o7Am60l6AiloVciYWs3cpiXh9INg3v5xShMfsX
X-Gm-Message-State: AOJu0YwOKkjNgAi3QuU9BXEJZYCUiLn+/44oZc1/D8/EbUpVY7ICsBWj
	2QXbBuBZt1C3nTpCk+ZboY2rc5LVI6K2HqlPxKCZD84ZDnpLSmkM
X-Google-Smtp-Source: AGHT+IHYJOd7OkQJ+RxOn3mWD6F4cG3u5619ahizdkR4xGYSVkPM72ZOGf5heQNBoSanegiBRAFEzA==
X-Received: by 2002:a7b:c850:0:b0:40f:ed18:f74b with SMTP id c16-20020a7bc850000000b0040fed18f74bmr8844128wml.35.1708358995582;
        Mon, 19 Feb 2024 08:09:55 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:3c2e:cd45:f50f:f083])
        by smtp.gmail.com with ESMTPSA id l14-20020a7bc44e000000b00411d1ce4f9dsm11592670wmi.34.2024.02.19.08.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 08:09:55 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 4/4] arm64: defconfig: Enable R9A09G057 SoC
Date: Mon, 19 Feb 2024 16:09:12 +0000
Message-Id: <20240219160912.1206647-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219160912.1206647-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240219160912.1206647-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Enable support for the Renesas RZ/V2H (R9A09G057) SoC in the ARM64
defconfig.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f9cc5bff157c..5d51ab7d14a3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1387,6 +1387,7 @@ CONFIG_ARCH_R9A07G044=y
 CONFIG_ARCH_R9A07G054=y
 CONFIG_ARCH_R9A08G045=y
 CONFIG_ARCH_R9A09G011=y
+CONFIG_ARCH_R9A09G057=y
 CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_ARCH_TEGRA_132_SOC=y
 CONFIG_ARCH_TEGRA_210_SOC=y
-- 
2.34.1



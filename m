Return-Path: <linux-kernel+bounces-146141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7E08A6143
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00C81F223B7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E4E1799B;
	Tue, 16 Apr 2024 03:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIPgwBuX"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE0D2110F;
	Tue, 16 Apr 2024 03:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713236524; cv=none; b=hejJx1Xn3sAisWmM0Uc+S+HZ6GH6DO5Hd6VsLxjFna88hHELXHWt9cy1h5tJuDD+Td8KEkxt1Jvk0jIeiDHO8tb053ZKlw6DUIzt5anQvlwxUMnCxLbzwyqt4jWKcIWYHdBWSMM3Rl5pFcz6/U0gLDlX51XlXP+KIKerAvME61M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713236524; c=relaxed/simple;
	bh=goyH9+TLCFLYzjM6kwvbHz19xxuQz4u4EiT1p7hK700=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cxmUnK4U6+ZypR8hgS1m99gPgv0CLCWi+e3uZmyv5h5N006JmOrea1G2qJo5YmldseBypzcAGaZL+qRugTN7AlUWdochjXUDTeGPm8pkEPxinvcAfik+wLvmI99bQ2Ul6v/70KZr1jDeG0hsrObG4oxx5jOi/jxfo2OsRCqdeMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIPgwBuX; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a4df5d83c7so2525438a91.0;
        Mon, 15 Apr 2024 20:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713236522; x=1713841322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goyH9+TLCFLYzjM6kwvbHz19xxuQz4u4EiT1p7hK700=;
        b=EIPgwBuX610UNFD1+qCcbrgOdxACfy25gMzaCymc1hLLWmi1Y7hUTlQYmqGDers3cx
         m0C0AEf2hWgiHrP+2J6FIhaml4pJOUTmrZG0JtzYRk1E/tXCNMbM7qVg3H13RmqLJ68t
         C5qTDRJUI+Bw3cezDzjZpibQETeZWdFAJlnfOeG5jEX+BPJmDXTWANQkXyRv7FwiClk7
         gA3JghwSp69Y6+mnA96p32RF4oZGn2I4X+/fkfh08Ec3xIJgCoBPcwvQ5fu/h56LzyfU
         +0fzyZgjzaujcC9QB3yAvLyDwx/IXgI93ITxIeM+WSzo0PVofMuJb/4yWO/VyHHH6UKw
         sYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713236522; x=1713841322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goyH9+TLCFLYzjM6kwvbHz19xxuQz4u4EiT1p7hK700=;
        b=SRoCQiJju22r/5PqEuh7RvPdZqV/Bh1s9+V3nQuCC8BeWUkYPNLpvwE6JCkSV0ezhH
         VVzsZXe3VplAmoptVgxowyroSqXFWoqNwjIqvp8y0p4J+obvtkTjL9/LhkQZLocXBnYT
         Iw4oC9XD5O3qMBtA4TWFBerDGvO0jiUXjh2vIDfI1dLDOEP8EN5Z9s1QvYrtiM8TnvU0
         TDkrC2B6dLyddprlJw3cj2vDAwbwbltGKaLBrPNXiyAA3Phte6a9YGe/kCMbAwui1Kty
         vzhCbGcqSZKmlwQHEXQwlXiGg4nWMKj3HAeTdoDri98h4bbu1/vWiMXE12vOhFLmCU7e
         g6ig==
X-Forwarded-Encrypted: i=1; AJvYcCW+TFRgaspeQ3f0uCjtYXkf8fPGKUMoYuOLSHt+44J5Pk1aaLR7Rsf7B88mUZsqddu55kIGb9r6xITilUSKzs4DFh4ZS8L+Ul6ajT0ttz3SaQv+LKguNcIvyYjZR0igEgJOwwpla6hPsw==
X-Gm-Message-State: AOJu0YyPKG/leDCYamIuH6d7b5ofV23K9qdyGpQUDUpJvcgpkG9uVu3Z
	O6L6CGdlCVm9oJuVNY5mqyYTSzuCATaaiGuRDS/am/zSS/cd4QR9
X-Google-Smtp-Source: AGHT+IGoAT+ooiCtpCFxy4xAqYZG4G/w+O0USbguVhVRr8kBlygkh/RDH21n2MkgKqwLt4lC0frHxA==
X-Received: by 2002:a17:90a:8b05:b0:2a7:40ba:48bc with SMTP id y5-20020a17090a8b0500b002a740ba48bcmr9399013pjn.6.1713236522273;
        Mon, 15 Apr 2024 20:02:02 -0700 (PDT)
Received: from localhost.localdomain ([221.220.135.251])
        by smtp.gmail.com with ESMTPSA id v9-20020a17090a458900b0029bacd0f271sm9427284pjg.31.2024.04.15.20.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 20:02:01 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: robh@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	liujianfeng1994@gmail.com,
	sfr@canb.auug.org.au,
	weizhao.ouyang@arm.com
Subject: Re: [PATCH v2 0/3] Add ArmSom Sige7 board
Date: Tue, 16 Apr 2024 11:01:51 +0800
Message-Id: <20240416030151.311231-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171320634254.4749.2865905152184927129.robh@kernel.org>
References: <171320634254.4749.2865905152184927129.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Apr 2024 13:46:53 -0500, Rob Herring wrote:
>New warnings running 'make CHECK_DTBS=y rockchip/rk3588-armsom-sige7.dtb' for 20240413153633.801759-1-liujianfeng1994@gmail.com:
>
>arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts:44.20-49.5: ERROR (duplicate_label): /leds/led-0: Duplicate label 'led_rgb_g' on /leds/led-0 and /pinctrl/leds/led-rgb-g
>arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts:51.20-56.5: ERROR (duplicate_label): /leds/led-1: Duplicate label 'led_rgb_r' on /leds/led-1 and /pinctrl/leds/led-rgb-r
>ERROR: Input tree has errors, aborting (use -f to force output)
>make[3]: *** [scripts/Makefile.lib:427: arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dtb] Error 2

Thank you for checking this. I'm sorry that I added the led label since
v2 without checking. I will check the whole devicetree and send patch v4.

Best regards,
Jianfeng


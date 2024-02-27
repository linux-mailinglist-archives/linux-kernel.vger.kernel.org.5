Return-Path: <linux-kernel+bounces-82554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA4486864D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB8ACB24CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101431B94E;
	Tue, 27 Feb 2024 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGiKGM77"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0109817729;
	Tue, 27 Feb 2024 01:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998452; cv=none; b=A5azyCJr6ZYTDKiIfhex+abb4JeHS1JVCE9sxWPiqQxwIxtCuYgwkoXuTcL7IHyCxmpE70ysHCssMYJz78v89AZHd1Uq4Az6nQYtrHIZdywO2COW8nb+IaVVR4kAVEM1lo5yuMyeD6fmvsfIieej9cTpAdkXDvp8s5NcjdSDJl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998452; c=relaxed/simple;
	bh=7sp5OIimh+NGxS8fpc5RW5A865+3zGI6jwHVqgoNhRM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dJbeebxVekMpRAEnNOF+KCzkbjru6A6Oj6fpqgG8nr5dN/qcHbzVvO0U0aWVt4/1Y2ZIWUFxc3pF8kdLzhegfYKVU9tiyalStqClqIwDPQIuQ1vy/0tN7pqyuvqjh5W2Zs/JfHvsXzQaGooK0CoqqhNsLbmhiphlquTF1mF/jsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGiKGM77; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc0d11d1b7so29783215ad.2;
        Mon, 26 Feb 2024 17:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708998450; x=1709603250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pegTGAgIl7701EaFNdsQSg89lpjeCGj36MeNrr3t5wk=;
        b=OGiKGM77YA+0ZbhWMlx3VAOweVs07IJmQLIPRp0o5KRCQRJ33pAZmk33ZInuAEyOP8
         +QpDJj8FvQGLv4IQStfkHWUV3A3NF5vGfl0tpNHj/itiVP5wdO4wI/1nyiNP/6O5gyp3
         mRCoFFCiFrI3iZhanYLEI8x/ihrhr3E4YtPh1RhAZwMJ5B7tGaqDdPK+B6bab0dXGGpG
         kHHIn/xgQK1AIhIhBNsreKML6VZL93+1ExvNRLlEeOMD8CVRRfB9MWlr7VyK7g1cD3Il
         xvNGMAOAoXKIEy8/R7YYlj39tyvPr8ygR4mibFxRGgEzeQzsunFacmMu8m5ELJ/Cn9Vp
         gVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708998450; x=1709603250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pegTGAgIl7701EaFNdsQSg89lpjeCGj36MeNrr3t5wk=;
        b=Y4QMxQCFRPuc+MVuBn1vU3+FVM3vURlBZAaWU5RK/DvzmcNHO3ejHygqYqiEo51UhP
         Z7vIXssmhUGiYcXESgpdlQujIOCQ9ze3wIdFBSqgmAh4PUBEaYoVjoVoFiOPA2TM2NMR
         b7G9rbmBvjmpoBhUzW7dPVcyO0lnL6I3/Q+T38m65/963wQU8VHcSMes3gVdJi0zKp7S
         M3KemXxRelWSqMAuRM/e/l0eeZEM+dGg3xr+zmMjOYOMuNHPpQoUMDHD8WeZ1g09xkzC
         td+GS/WtUs6U+L4JUlzGjwBpeMXK6T+xJf8Jfe5atjRRctWkvu5gnHPdLlL8O6Bu5dIq
         Dnxg==
X-Forwarded-Encrypted: i=1; AJvYcCW4dUIyLZkeZ8VT9XPjoXVJ7De3bh9K1/OGUYG1QFzWNMsY4xwCvgpd0hYw9+7TcujMIC2lnt914ksQ+G+2qXiCeN0KnikyaxF4MoPpxqYCIryEfdOd+mGue5Eme4S7UJLwckFnVKOMjw==
X-Gm-Message-State: AOJu0Yz16XazFJBxVbhbfaIoJ9zQu4GMay/zWPm1I4ir4EZv900C+gSK
	AS0PLQGK73dysFaRgxHidvoZeEkW3nrLFQR2dqodmM7moZ1NmSV7RpIXBXh1
X-Google-Smtp-Source: AGHT+IEuY0YS9uhhpwyMcXgTwdMTh5gphqL/4vO6O7j6X7sRqCr2NuHIC/jNJLySO4qn3fn7Qq+ouQ==
X-Received: by 2002:a17:903:192:b0:1db:4245:454b with SMTP id z18-20020a170903019200b001db4245454bmr10101016plg.57.1708998450196;
        Mon, 26 Feb 2024 17:47:30 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e381-af24-f369-7cbc-56bf-1d54.emome-ip6.hinet.net. [2001:b400:e381:af24:f369:7cbc:56bf:1d54])
        by smtp.gmail.com with ESMTPSA id kl14-20020a170903074e00b001db4b3769f6sm318893plb.280.2024.02.26.17.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 17:47:29 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/10] ARM: dts: aspeed: Harma: mapping ttyS2 to UART4.
Date: Tue, 27 Feb 2024 09:47:11 +0800
Message-Id: <20240227014719.3037588-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240227014719.3037588-1-peteryin.openbmc@gmail.com>
References: <20240227014719.3037588-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change routing to match SOL(Serial Over LAN) settings.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 8a173863ef24..a0056d633eb1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -12,8 +12,8 @@ / {
 
 	aliases {
 		serial0 = &uart1;
-		serial1 = &uart6;
-		serial2 = &uart2;
+		serial1 = &uart2;
+		serial2 = &uart4;
 		serial4 = &uart5;
 
 		i2c20 = &imux20;
-- 
2.25.1



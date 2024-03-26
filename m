Return-Path: <linux-kernel+bounces-119247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD60588C61C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78977306016
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A3D13C696;
	Tue, 26 Mar 2024 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdG5VOmz"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1B213C67C;
	Tue, 26 Mar 2024 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465238; cv=none; b=agQ5A0l2zmXA7W7dypww2dBURaNISii+tYvJqqedQG74BUL8ZWOx7h72zf37+g3NnaLlnZARikO6bB43/8Gp8JHxhMgQtuocUrLb7ZjHyVe4KRZByw3wqBNSl1b8iKaoaz++2hzr0Dx5TBaRVzCiLfsziKl5pJIL0wGudelpNQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465238; c=relaxed/simple;
	bh=rdSFTvDml3hhugFdPIWsD2smi74wsbvpjShQkzlFdEw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=kQg/BIcm5bQyIruJ0zZ5myN4pynDHGt/AduwA0dl8NR9Tyw4IWX0dJNTB5+1gd/PyKCTI9+kusVRcIPCpKdUtgJKiqFhScJGYGOYY2VnnBofJRUXI1cWKuY0OP81YvA3DnSrlblaeTLThJ3IL5COo/6dxN1U3khRwo6kYavF0Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdG5VOmz; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-22222357d76so2034179fac.2;
        Tue, 26 Mar 2024 08:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711465236; x=1712070036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ep9QVOB8/YOpGWyRSjZf2H1PYHwu34pwGLtmpze6dGw=;
        b=YdG5VOmzfCmx/HS+svIAyzVDG86ij5ulRVfI65dT1QKdI7rlTmKLElfF/+hegIy3IN
         yGnpU8DArz8aqdP3XI4Pk2WqUm+67wP8Llv0kMelkYQWfBbtTfezGQVXXVWkOjUaG9Vl
         AcbiT6yOWwMXycA5GnSbBDIxiKzohUoqaqtjfQufg3VzfNOwBhh+3wUk67boPa1XHQNA
         M5QsKwGPkejec2gsH4h9b73HaFTxR87uLBYIb4RdQZfLg2ybIf+xwyU8/9ShAvN0RVyv
         jzrBr3cftH8KLDkYoXBVsyVg7z5DcjGC/BZOcx4p10Y5dVTlzP/d9pRyGJe16BZk6yKa
         FQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711465236; x=1712070036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ep9QVOB8/YOpGWyRSjZf2H1PYHwu34pwGLtmpze6dGw=;
        b=VnmcnEYJibSVL+FZ+vpCdy8RwM8CQ8T/xQd4+NBhaHI4o7dbmpDx4f8cJHORbOPhvG
         h4/L6/iNmbKRLVTwHk6srEqdQBVIoqdMMsuKYbN8yMJtuVOTUWM1VQK/mPaEz8kBPI9W
         Dgadw5QZ4eyxi+ty5Mok+dWPGowWlExNsd+2BT1XighCxADHjKiyCBwhXrdPkFGNi5/2
         8Txr0AcRwxCbaSIaos4wkaW7xzPV+QWTI8c+dCC3VMTE0MYhHVFpbYli3otA6PWUsnb5
         UCQtkt5zFyZqRXdPjF9OcAZgz0AI7icLx70uBV43vRYxArqzfLPIiVp1+5b7Bp7SC4Ga
         qKJg==
X-Forwarded-Encrypted: i=1; AJvYcCXQxGzIEHdPVLpEN+GJSjmPCa1YgROnWZncimFxmRXboupwWLJWjDUAA5R4YhKQsRkfAOQrwig1OZCSyE+wSIbuQei/H7w/3HrwMpzV4IRv0VSkFdYAvhSU9Ooxh3qVdUpNpaQIx4HYD17tobLAEa6MN9qNANUBC0k/+GUMYCfdMDVDaDx5gi6l
X-Gm-Message-State: AOJu0YyDsl7heUkU949oLg2wFD/V9Yszga5y1uBlTMUV1ZhR56kDsW7U
	xhKp+WfsvQFl2A8LJogv2uyM0/KatI/KFpXfAXTjn2851CBD1/3M
X-Google-Smtp-Source: AGHT+IE9lJtqRc0RFeoGBEWVBCzB5/BipthG8IbTBUUZW2xqn5DBa3mtgCMrQYxtY/j1pt86sk3CAg==
X-Received: by 2002:a05:6870:50:b0:229:f1be:c73e with SMTP id 16-20020a056870005000b00229f1bec73emr10049326oaz.25.1711465236132;
        Tue, 26 Mar 2024 08:00:36 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id l27-20020a635b5b000000b005dcbb855530sm7658404pgm.76.2024.03.26.08.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 08:00:35 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] drivers: watchdog: ast2500 and ast2600 support bootstatus
Date: Tue, 26 Mar 2024 23:00:23 +0800
Message-Id: <20240326150027.3015958-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add WDIOF_EXTERN1 and WDIOF_CARDRESET bootstatus in ast2500/ast2600

Regarding the AST2600 specification, the WDTn Timeout Status Register
(WDT10) has bit 1 reserved. Bit 1 of the status register indicates
on ast2500 if the boot was from the second boot source.
It does not indicate that the most recent reset was triggered by
the watchdog. The code should just be changed to set WDIOF_CARDRESET
if bit 0 of the status register is set.

Include SCU register to veriy WDIOF_EXTERN1 in ast2600 SCU74 or
ast2500 SCU3C when bit1 is set.

v2 -> v3
  - Fixed WDIOF_CARDRESET status bit check and added support
  for WDIOF_EXTERN1 on ast2500 and ast2600.

v1 -> v2
  - Add comment and support WDIOF_CARDRESET in ast2600

v1
  - Patch 0001 - Add WDIOF_EXTERN1 bootstatus
---

Peter Yin (4):
  ARM: dts: aspeed: Add the AST2500 WDT with SCU register
  ARM: dts: aspeed: Add the AST2600 WDT with SCU register
  dt-bindings: watchdog: aspeed-wdt: Add aspeed,scu
  drivers: watchdog: ast2500 and ast2600 support bootstatus

 .../bindings/watchdog/aspeed-wdt.txt          |  4 ++
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi       |  3 ++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |  4 ++
 drivers/watchdog/aspeed_wdt.c                 | 53 +++++++++++++------
 4 files changed, 48 insertions(+), 16 deletions(-)

-- 
2.25.1



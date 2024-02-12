Return-Path: <linux-kernel+bounces-61249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2736850FCE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AFE1B21291
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435B317BA4;
	Mon, 12 Feb 2024 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBI57cVj"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450D212B72;
	Mon, 12 Feb 2024 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707730474; cv=none; b=ZNE4uBnVxoPMH1rTvTr99KsOU237QuUzMOlqwjfjXEnUHH+z3hmboVEJnSvVzbrOATVX2i1do1mq9jHUq2zaLYvtuBy5AeLOaOAXoS7Lo87YR+BSG742aGClVTXnp/cor2B7+U3U7v/Tx1FdUaBJadfb2ziW7ozLkIOlA/Cw+qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707730474; c=relaxed/simple;
	bh=ViKQiSWcWYCkXU6A9PDOO1oKjlvMExVCKTXkGh9et6w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hx+SStRT23HI88Om7M6wzYXUoTGKpMLMvywgFvwPQRnCZRsowPO4bj4gGZwmNmxKVb7k6GV1giv+8J/CFOlnDLdVGloR/Ch16rpwp+teIMIA5q/4McILDNA6BMxCHV6tH1vyL/2Ry7JKse8iKZuUCmiD4Sh2b4Veo7FfBoQUuSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBI57cVj; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e09ea155c5so1239650b3a.2;
        Mon, 12 Feb 2024 01:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707730472; x=1708335272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dnKx8M7/sfj+9SE79BBw1FFhj3SBdGNF9ih2TYOEbAo=;
        b=FBI57cVjJ5XmXKdobSrrb1v+5uFZmiMNboYz7AJLWCCXJt0c0RxErvXmSRWU/srND6
         hZ+puDPs1BRe6p8hXcuK8ijh9xioqcYFVSOoeyA4nIKJtCm7XCVU7SrQELWd40MeB16/
         BXMdF2aruYZeCsu619+/KS2MVqVEALPNm+r0KtU+SMxTUFt4riVXq/GX/wW9Fb+T+SDT
         0fo2V/L4wnPlFeEILzRAkc5F5yHhK8o68rzkDNjKwGDCguogCqEn/7pmwyfxE3MTNWu4
         21VEhvkJJ4aDvxJEIBcC+OMd85mtdQrFGFzJZ+Uegs/zxgns569+s8BZMf+x9vMWeOVx
         jOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707730472; x=1708335272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dnKx8M7/sfj+9SE79BBw1FFhj3SBdGNF9ih2TYOEbAo=;
        b=lDanZW4fqxxrKP/juua1gElfR9/BS5Hx4Y2+IQxMoC6uNwXDcSsOqZl+otj0nwWyp9
         ZYEAUS8JMB+XNRVEIbKd7P1hEK9P01I1JGTNBvAuCYTyhdyz7tzW47t0lUIKF8JtPEbd
         0Hsxge+Aov2xE+4G7vWYFZwt8CorvycAma739vI2N9MFuSluww4JjBE6upjfy+7y3Azm
         uL/pan7UKN21m3bAOpmzgKk67frH/6VcMJqJx5l/zEuA2wSHC9uKqA92N016GvHFDgaA
         Nh/vC9EPI4c5CaVhcH47CwUAqJ43L1ZjJ6Tuk+7FcLM5dxCr/cH3PsiVngXxC/Af/YBo
         7iUg==
X-Gm-Message-State: AOJu0YyogVEF2sXkKdx5GG49gusTUXfsrtBF+GJ2ifwReDwPX3+J0wif
	4oQyOIlIJuPeeDeiZYq+6DdSDmTgXReKw1I8kBo5wtfZ8e6TX8Zx0WhCIlAJ
X-Google-Smtp-Source: AGHT+IEIWIxQirdR5Jrh2d7TTPv/dJNYbCB/uEw31DCCfpvyouy5b1Jg+BSy2r02uRdCwf6uifhe1Q==
X-Received: by 2002:a05:6a00:2d82:b0:6e0:d220:4463 with SMTP id fb2-20020a056a002d8200b006e0d2204463mr3677645pfb.24.1707730472307;
        Mon, 12 Feb 2024 01:34:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXr/ObyCQ014DXM2/K0oQu3x9cHR3rK+8sdyF1ijMmVZwwLkg/BF1Cac1Z9/4ukKdD9RKF7CpX3bG6QY+0pL/GHSaXpeX73nhZUpsddlFF/HbeDbZYxwlU9PAuZC3HhKQBxbjMAvDRJMPFut2awTqJV1TXm6mT651d8LT+XsCWIEHgjxnkp3crCd3K73V3JR79PYjTy3KBDmH6p64LVxcKJufIcorpuBw7Dpyh9u5E1
Received: from rigel.home.arpa ([220.235.35.85])
        by smtp.gmail.com with ESMTPSA id p19-20020a056a0026d300b006e0e3ef5f23sm1042222pfw.101.2024.02.12.01.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 01:34:32 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org,
	corbet@lwn.net
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH] Documentation: gpio: clarify sysfs line values are logical
Date: Mon, 12 Feb 2024 17:34:20 +0800
Message-Id: <20240212093420.381575-1-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clarify that line values are logical, not physical, by replacing high/low
terminology with active/inactive.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 Documentation/userspace-api/gpio/sysfs.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/gpio/sysfs.rst b/Documentation/userspace-api/gpio/sysfs.rst
index e12037a0f2b4..116921048b18 100644
--- a/Documentation/userspace-api/gpio/sysfs.rst
+++ b/Documentation/userspace-api/gpio/sysfs.rst
@@ -87,9 +87,9 @@ and have the following read/write attributes:
 		allow userspace to reconfigure this GPIO's direction.
 
 	"value" ...
-		reads as either 0 (low) or 1 (high). If the GPIO
+		reads as either 0 (inactive) or 1 (active). If the GPIO
 		is configured as an output, this value may be written;
-		any nonzero value is treated as high.
+		any nonzero value is treated as active.
 
 		If the pin can be configured as interrupt-generating interrupt
 		and if it has been configured to generate interrupts (see the
-- 
2.39.2



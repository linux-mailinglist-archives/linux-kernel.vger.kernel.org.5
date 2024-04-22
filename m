Return-Path: <linux-kernel+bounces-153456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AE68ACE50
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06E8FB25324
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4840D152160;
	Mon, 22 Apr 2024 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/5p79N9"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3761514F8;
	Mon, 22 Apr 2024 13:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792754; cv=none; b=S0CoqxVKsSLHHoe5PTqDqCdEdklw8Xa6DVrwC591WFu3KQFNR6dzzJIUbbmZto2g+2Ihn+8Z6CGOtBUj+pjLuNhrMB+fii9l/Qa4B6zj8hDY/VjvW5UUiXHFbbOK1JbTDXZk04Se2Z/FyAKGRvbqFH3Ak4Ky+Wu541OP75Ms374=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792754; c=relaxed/simple;
	bh=I6zTviAUpwvH8g7u39Fogj77XDX9HiwSphiao4M1bek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uQboT8qa9pHS7xEtqz8I75k/TOUzbMZvTaYzwbJu9eHSULbA90kbzmAtjZRa2yMAS6F+Q5GKn1WfWtqhDWdvyhtOTEDgxWlGA1wY4YP6yFKz5wje1wz62b03VQLkWSNmX7a7bkZkiEnb3lQCJzWnscyjz0IMzJdz9rc9AXTjdjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/5p79N9; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516d68d7a8bso4180780e87.1;
        Mon, 22 Apr 2024 06:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713792751; x=1714397551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pERNAC/1G6R8rWK9gYCpNgVxXW3BBITnVp0+rm86Ey0=;
        b=U/5p79N9f1nko73gXsUP6+N0dl3k4WaZvu1iLr9rPQDPcjxvqv/6pRirM7WMg+Q6sB
         PXuiyPfyR+g2qq0Rt+9meeeTlYi3MnvQnIkxlnfXQ7TfhmjgKV4AsGJYwkZZcrXBUU3I
         R2Z40I40jOivY9qQqaoSoBj5snxyvgK0loUzXf/0ONEW6wDk+LR31834WGlmeMKxat18
         xoiZJB2WqDpEZ7UQNWgLgItBX6J3xkPGWJoS8eYbY7ccoFZGLnWGuIVK4bd5VtCAju5R
         PoMMgubXDer/Uug7NtXvAuoL14e6wYy1/+ca/HhYK/YVqgBe26wNWkdcXUxzLlof+XKX
         0/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713792751; x=1714397551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pERNAC/1G6R8rWK9gYCpNgVxXW3BBITnVp0+rm86Ey0=;
        b=t912XDy+QgIaB0p8et9oVqY0D9WXawWwkJbA5CJRQGPJ0ycmwr2OzQrOOCctzmJWD2
         Hd+ul8YxexEwRszEk3rTGToQH/BLk+AaKTb8JwCnexHUT5afaU1vz0StMEfGsna37Apx
         1ZqOGMLb7GnhuS2jRwVOTggc8gFYkdv3tJeVjJtgeR+VTziEy7oHIHISew6JVp8rAOdR
         2GrnN2lFPBPBPtqD5jcZuYECnSPZKWMnkWGgI/Y7nW3VKIUlQ3YFLU2JLKEhIdbiDaI7
         2cKFJBa3y2Lv3FSh/OTW/y/nfIUOF102MmFJPFwkjjpiAHYpAQfhBaSJ4IWiteJ6F/4p
         wqBg==
X-Forwarded-Encrypted: i=1; AJvYcCW9mrHhiSmQdHWjm2VJCY6Msj0nHfq0LJAq31ZsKDwgKUOIVqYcjJK2TKf4tFKGzBi/qcwLarhIjl5xVLJkMetmkWoZrTnqcs8tyPwuN4td1yoHtcIixmUqZ4YysecpEn55A/9Ep1ni/lzyHMDIdVivc/MzVZ1n5gt1DXmALWiFKsNsS/AVAA==
X-Gm-Message-State: AOJu0YxW9ss/LWFkglxNPZRfYdcRTwbNIoerwqWrO/1TS/LN/KB/5q4Z
	AGJa/OUoMtRhq/9THI3Te9UvG51fYWQGwszhhIbiJxzyNnIvMoBr
X-Google-Smtp-Source: AGHT+IHYr/SQLvrDaPycD0DIJxeMydM1vclpT/dW31eMp7lP6Lg2UMH0puva6nFBK2rqFFB63dm5IQ==
X-Received: by 2002:ac2:5f87:0:b0:516:c97d:96b4 with SMTP id r7-20020ac25f87000000b00516c97d96b4mr3741310lfe.2.1713792751047;
        Mon, 22 Apr 2024 06:32:31 -0700 (PDT)
Received: from CVSIT-Server.. ([193.232.173.109])
        by smtp.gmail.com with ESMTPSA id d22-20020ac241d6000000b0051327d2f5e5sm1729568lfi.119.2024.04.22.06.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 06:32:30 -0700 (PDT)
From: Konstantin Pugin <ria.freelander@gmail.com>
To: 
Cc: krzk@kernel.org,
	conor@kernel.org,
	lkp@intel.com,
	vz@mleia.com,
	robh@kernel.org,
	jcmvbkbc@gmail.com,
	nicolas.ferre@microchip.com,
	manikanta.guntupalli@amd.com,
	corbet@lwn.net,
	ychuang3@nuvoton.com,
	u.kleine-koenig@pengutronix.de,
	Maarten.Brock@sttls.nl,
	Konstantin Pugin <ria.freelander@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v7 2/3] dt-bindings: sc16is7xx: Add compatible line for XR20M1172 UART
Date: Mon, 22 Apr 2024 16:32:14 +0300
Message-Id: <20240422133219.2710061-3-ria.freelander@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422133219.2710061-1-ria.freelander@gmail.com>
References: <20240422133219.2710061-1-ria.freelander@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add EXAR XR20M1172 UART compatible line into devicetree documentation.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
---
 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
index 5dec15b7e7c3..c4bedf23368b 100644
--- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
+++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
@@ -12,6 +12,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - exar,xr20m1172
       - nxp,sc16is740
       - nxp,sc16is741
       - nxp,sc16is750
-- 
2.34.1



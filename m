Return-Path: <linux-kernel+bounces-163341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B17D28B69A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D510E1C21B00
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DE314F70;
	Tue, 30 Apr 2024 04:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLJg89DH"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E0C10A1F;
	Tue, 30 Apr 2024 04:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714453143; cv=none; b=OX3q+IWQ0J1SNkfUp90MIhSoMPXkzdiYY71ycr7D3zaP6DmTEmKAGLNJlw+Un5P8PJlhsJxvvRYAUj68XArOy9sOl9gU5oV0lRZzOOnVmIJYwXzUFkRpXyDiHKUcT4G3MUNZW/xDrOwAkSFEQeftYH4FqREfZbkeogNbCj5bc9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714453143; c=relaxed/simple;
	bh=KnLqrgK8jRFLPsrqEc048XqvjNT0fCeor2YfX6tAHuo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d1/mekI3bJobhNIXz3037dPzXXHSr0JovCratEmhW2DtliBcX/ILb7anen87DUUoKlZprJNfxMW4Wdbs7dh0rcVoObu3lYpqAaUfjkL0vfGqOroDPtX0Ou7FL5V4ZcuQoetlMScj8oztq+UVkUAssAyQGjWnlWu894kBoQNhE/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLJg89DH; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c844b6edbbso3140860b6e.1;
        Mon, 29 Apr 2024 21:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714453141; x=1715057941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JZZX64UHLicig7cDGx/C8G/73Ljj8FABVKYw2s5cknE=;
        b=hLJg89DHnkhiy1Gn0EZhqNAMzaTHB2Y+V9Qfhv86/3SpnbjYcJecwwkz/hI/8sCdUj
         nrpYbSa0XVLFJ3fRPgoFvVvx4S0ohpbovEHhl5K7Gu4bmDf8vZpgAyyXOMU26fAhw3H4
         2HgsZMc9kyfizIF4YBGLdwTd8/KwQOJd8gSvtKiBWcVz2loTQQwErltv0rAZU0kCCBHi
         udfHoohFpWaHh64PWvoz5LufE/OBJ8Pwnmn/wtBcppsNwPJMMgebWUfRNIFEt3Yv25ER
         3v7ula4hfeK9nhT2OScUHyarY8uR5mykbqUfxvC3b4kcFpaYMM23VBCVCdMAgmsFmjus
         R2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714453141; x=1715057941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZZX64UHLicig7cDGx/C8G/73Ljj8FABVKYw2s5cknE=;
        b=nt7fPBCiLK3i2Rgh04S3rAqJCQICY4ol24c2qy/m+Vd+8Ti7H3zub39w9tH0iaCs1E
         TS+TFAv9uwdH1NRaR4jJk/FQ01TJ/aEQmMZas/76v9NH/0ZXNDZmcEDrIgZ+s9ANaCoR
         w1ZOeRw1dKV+9KX/2A+Xuft1mEFr836cRdhN2n8+g13DImU2/gIarYqteGgpvQBFW1R3
         nG0zxAGUPJQE1j4lzMduYoZFNSSa9Wss2cak2wCWwDWId77ShvbnTHXSAm0ag8yBVqJf
         GE6onasT5/eDgkaIbtxikXPFnnrOk8HEUd8i52eCYAAOqNTL59SAxN8zmAHUMwfZ2nsU
         uHdw==
X-Forwarded-Encrypted: i=1; AJvYcCUKm08V0SznLTb6HPvo4wJqHgYeFsGQMZ8SkMtQYxVa961zZmP/3gb5W+YNS5VBnf/pSzb5IumaCi6CnlCO3mMfejnHxVYVisGvyEWPvvrZ2O/S5O4jrdGg6V+FZArbtRts5lmB/zu5mA==
X-Gm-Message-State: AOJu0YxTF7OI4PvGwJRnycXim7jRUu07W/JuQd3GI2OMockmkBvOr1xl
	VVGBGh0IqrG7Xt3VKn9ext3FZ9JpjosOhqEDaa+MAl4yrH6bzwqs
X-Google-Smtp-Source: AGHT+IGfAY1Ufnkf1ZxBwe8KUhbMjBJdvnBPDZRufU4lSXsZbA2ge+W9oxfULHpysQpjwGPpE5ZoXw==
X-Received: by 2002:aca:180f:0:b0:3c7:4f9e:ec0c with SMTP id h15-20020aca180f000000b003c74f9eec0cmr12955532oih.32.1714453141505;
        Mon, 29 Apr 2024 21:59:01 -0700 (PDT)
Received: from localhost.localdomain (125-229-150-10.hinet-ip.hinet.net. [125.229.150.10])
        by smtp.gmail.com with ESMTPSA id e15-20020a62aa0f000000b006ece85910edsm20226483pff.152.2024.04.29.21.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 21:59:01 -0700 (PDT)
From: Kelly Hung <ppighouse@gmail.com>
X-Google-Original-From: Kelly Hung <Kelly_Hung@asus.com>
To: robh+dt@kernel.org
Cc: krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	kelly_hung@asus.com,
	Allenyy_Hsu@asus.com,
	Kelly Hung <Kelly_Hung@asus.com>
Subject: [PATCH v7 0/2] modify Signed-off-by field
Date: Tue, 30 Apr 2024 12:58:51 +0800
Message-Id: <20240430045853.3894633-1-Kelly_Hung@asus.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the warning message: 
From: Kelly Hung '<ppighouse@gmail.com>' != 'Signed-off-by: Kelly Hung
<Kelly_Hung@asus.com>'

I replaced Kelly_Hung@asus.com with my private Gmail account.

Due to a security issue with ASUS's mail server, I am unable to use 
ASUS's mail system to send patches out from my build server.
So I executed git send-email using my private gmail accoutt.

Kelly Hung (2):
  dt-bindings: arm: aspeed: add ASUS X4TF board
  ARM: dts: aspeed: x4tf: Add dts for asus x4tf project

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts  | 581 ++++++++++++++++++
 3 files changed, 583 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts

-- 
2.25.1



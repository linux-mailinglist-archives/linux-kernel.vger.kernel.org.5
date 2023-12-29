Return-Path: <linux-kernel+bounces-12971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AB381FDD0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 08:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE761F238F7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 07:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F3163C6;
	Fri, 29 Dec 2023 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDZaLk/N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF8A746A;
	Fri, 29 Dec 2023 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbc648bed4so1703635b6e.3;
        Thu, 28 Dec 2023 23:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703835924; x=1704440724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rSHwqKa1O5F2oXrIiKvFNvbBOMiFR0XtCw83IG7yVSc=;
        b=EDZaLk/NAPL5dSxcZm9V5vYVUZDUcmmgPlWHnrcVDMpQpqB8HC2eOJ986NxveBnhSA
         LG50uam0yfrY8G/ZiA+Zo60hfAGYwotpkzPkWA1jOvo31r+fbgMvLYYWyyETzAsPYN+4
         LNuLVZYV8CJysD3eUQC8qGoYgPxWkzJPaUViuddvtYZ9rvYyILAkA4Uiis9AKEykzv+e
         QKQOUS/cePnxzg3NVixHOIDPM9g5ylxlK9JMeO4KZWfaGILUjQ5YV9U2czo0N3fjhAYa
         jq3Kn92aHkr33J0A1PDZyZQVmAeiPtEed7ILbfE903FwYRshcvNmMMjFyT9lkVPsSEz0
         KGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703835924; x=1704440724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSHwqKa1O5F2oXrIiKvFNvbBOMiFR0XtCw83IG7yVSc=;
        b=vq5NxeoxGSWn6hJyLI0oHWM7VmlmLtnvHfexZ+/aGUsg8MVvs6kFs1bLPd0JFZMXcR
         nbSHPTMvf5M4QqAyeNd6dbhgELTUWJTR13cxQAg4Kj+tQquXIRRn+0PVRlIzZWcbJJA0
         JELg1oSg3gSGvyXdp4fcHJBixEoBHGSD6xRTeGsCvs6utZxhLLY+T4NWqv2djkcXWzlW
         XLjzQ3pLoRuDuCWdf+/FXDm+gcCwI9z5YSAxZCmstyFMzmC0iS9Ss6opby3TfBncFctL
         Cg/I5+fPpl3HcJkkJ+dqXLHNKu+MM1ilQcP4X60lbRW3T34wA2TwUZQd3ZhfxGtpeetD
         pYBQ==
X-Gm-Message-State: AOJu0Yz2uwd/MRODbBqRJXwBdHyL8C9kZIWxcWX8pzJwcs8zwP+gXkiJ
	g23qGZurnUu3FfyCH9mFMO4=
X-Google-Smtp-Source: AGHT+IFoYHqVzhNOZNnASAFhndS87+2zTbD3FPnw3A6TyKRQSRuMabJeS1Kg54KuDlJVbLfIrjXbiw==
X-Received: by 2002:a05:6808:13c2:b0:3bb:e066:7d27 with SMTP id d2-20020a05680813c200b003bbe0667d27mr1025603oiw.91.1703835924688;
        Thu, 28 Dec 2023 23:45:24 -0800 (PST)
Received: from localhost.localdomain ([1.200.140.173])
        by smtp.gmail.com with ESMTPSA id s188-20020a6377c5000000b005c683937cc5sm10305186pgc.44.2023.12.28.23.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 23:45:24 -0800 (PST)
From: jim.t90615@gmail.com
X-Google-Original-From: JJLIU0@nuvoton.com
To: JJLIU0@nuvoton.com,
	KWLIU@nuvoton.com,
	jim.t90615@gmail.com,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	andy@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Subject: [PATCH v10 0/3] Add Nuvoton NPCM SGPIO feature
Date: Fri, 29 Dec 2023 15:45:05 +0800
Message-Id: <20231229074508.2709093-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jim Liu <JJLIU0@nuvoton.com>

This SGPIO controller is for NUVOTON NPCM7xx and NPCM8xx SoC.
Nuvoton NPCM SGPIO module is combine serial to parallel IC (HC595)
and parallel to serial IC (HC165), and use APB3 clock to control it.
This interface has 4 pins  (D_out , D_in, S_CLK, LDSH).
NPCM7xx/NPCM8xx have two sgpio module each module can support up
to 64 output pins,and up to 64 input pin, the pin is only for GPI or GPO.

Jim Liu (3):
  dt-bindings: gpio: add NPCM sgpio driver bindings
  arm: dts: nuvoton: npcm: Add sgpio feature
  gpio: nuvoton: Add Nuvoton NPCM sgpio driver

 .../bindings/gpio/nuvoton,sgpio.yaml          |  87 +++
 .../dts/nuvoton/nuvoton-common-npcm7xx.dtsi   |  24 +
 drivers/gpio/Kconfig                          |   7 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-npcm-sgpio.c                | 612 ++++++++++++++++++
 5 files changed, 731 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
 create mode 100644 drivers/gpio/gpio-npcm-sgpio.c

-- 
2.25.1



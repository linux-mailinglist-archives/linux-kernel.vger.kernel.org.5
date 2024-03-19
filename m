Return-Path: <linux-kernel+bounces-107304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06A887FACC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF12282BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F82E7D06B;
	Tue, 19 Mar 2024 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cotPKsz4"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DA851C28;
	Tue, 19 Mar 2024 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710840923; cv=none; b=XQl8O4swyayx5A3yvxKccyagFpP2aTX5DialzNWGjO4zu1s+4HAD1X0M96/0Wt2owLeAtmMTe0IcjTdl4fJMfK+pfKrtzm6Rltkvl/6joLoxngMKxHUi0DfUNid3N+cYGRtAdxG7hIt6iEEDLkBDCSgIibCmOWflHkTUc8i+YIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710840923; c=relaxed/simple;
	bh=UL1jVOoSsazd/6Mg7jjvAVM7p2M7LyFsuVPFJZXsGIw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e1yL0Pqk6RGH2R69uen7Ol9TidHgMNH9h6U3UOCxawNjut0y4pnKghheSBh1DLHOaudgK/R4EiPUdrzidK/ra0niqcUHLTsHJUR5k5TFIhiDLrfewR+V3PetX8p09OTdcv5I5N94gjsTTP6Ac1APjdqs7I4Xr7SmVgGKQ4I1q+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cotPKsz4; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so3241807a12.0;
        Tue, 19 Mar 2024 02:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710840921; x=1711445721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=32AXx27SSzTCLszDWarNun8O1zcaf1jj0VawsZbBOHE=;
        b=cotPKsz4/8tg+EsAoTC70E4rmMCNO+axhCnuh454mXks4xzwBN2V3psrT6xijxQGet
         aSzmpRb5RaX9IjX+8zsfdSaWD5hVGePLM/Bb/eiHVxBl8O8OFCbPaKaVIanYd9xseyZt
         5H+ZeKE0INFfVfw/Y0sMOkclgMhHrDUEhSdRj40K4Gshi6jjHO6LbvkaXkFu8I9I+gc8
         5MdvHqho8dSGySOXV7yIHNzUdzQBAdi90VyCbmdclb6gfStvK29IEL92ouIq4dOVFC1c
         K+y1D+oBqw+vDSg/ZQMSWgkp9oM6J5quE3xeEiYxW2KDJXhSMg6MbwXqVFlV5NBpZt1A
         Omlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710840921; x=1711445721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32AXx27SSzTCLszDWarNun8O1zcaf1jj0VawsZbBOHE=;
        b=sprxSlxquPEIA23gAzCrXrVCWLg5AjOygIO8fimeqLhbplgvchESLTvDGvQOmpMISU
         B9YYQn6AQVIMhh9Jwa+1h9lnNU1TZMatxudWFpZ2FVpQhRGmH24N1674ua+wR+9Aa7S0
         Siihn93Wbi1XHPmysvBXoUvozAhwQCiD7fkwoBR42uaDAWG+oN4UHlVgYgmnRA3Cksg0
         ZNScyC+uAM3slJO0jmt9LvhvMAqnF21ggPgmqGKHa2i4qV+kGx1/qDLJxSMTjM9ytEC/
         1SuVvEpoo4COdyRAwV8YEv8AcUePVCvm6dc/GxOJsXxW+GpHW0Pj6gDA0SEUKEHIrXCb
         Zrxw==
X-Forwarded-Encrypted: i=1; AJvYcCUxmLUinwAF1uOQI6zoYxlthjJ9R2TiphddaiTxJExvH1mrNWKa4TbaOVnUpH5vIPhdJL3J+YCfkOkEYZUEd1upR99g1JWxtpniQL94SQ5aS142hHq60HyQ2A5rI6lSycC8zuPRpfRXXQ==
X-Gm-Message-State: AOJu0YzB4lf31fyV1IQpR509GaphJBg+4jPedXzQnXdGtwsWB9TQLGQi
	TljF0WPPf6maS4D+GshJ4maKkDvUC93dLz0YK+HSKkOUd7S7Fmlu
X-Google-Smtp-Source: AGHT+IHDM7HsAh3M015ITHV9MavYe4suAIxVy7uxIJgbuM/TKnaJlg+0UVSfSczJwcMqkUErwsaA9g==
X-Received: by 2002:a05:6a20:d49b:b0:1a3:55d2:1489 with SMTP id im27-20020a056a20d49b00b001a355d21489mr2341521pzb.7.1710840921367;
        Tue, 19 Mar 2024 02:35:21 -0700 (PDT)
Received: from localhost.localdomain ([129.41.58.3])
        by smtp.gmail.com with ESMTPSA id n5-20020a170903110500b001ddc0bc5934sm10942432plh.249.2024.03.19.02.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 02:35:21 -0700 (PDT)
From: Manojkiran Eda <manojkiran.eda@gmail.com>
To: patrick.rudolph@9elements.com,
	chiawei_wang@aspeedtech.com,
	ryan_chen@aspeedtech.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	manojkiran.eda@gmail.com,
	jk@codeconstruct.com.au,
	openbmc@lists.ozlabs.org
Subject: [PATCH v2 0/4] Add eSPI device driver (flash channel)
Date: Tue, 19 Mar 2024 15:04:01 +0530
Message-Id: <20240319093405.39833-1-manojkiran.eda@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,

I'm presenting a revised version of the eSPI device driver patch series found at
the following link:

https://lore.kernel.org/openbmc/20220516005412.4844-1-chiawei_wang@aspeedtech.com/

This update addresses the issues identified during the review process.

While the previous patch series attempted to incorporate support for all four
different channels of eSPI using the ioctl interface , this new series focuses
on upstreaming the flash channel (using the mtd interface) initially, ensuring
that all review comments are duly addressed, before progressing further.

Diff between PACTH v1-v2:
1. The commit is split into multiple commits as per the review comments.
2. Explicity renamed the driver to indicate that it only support master attached
flash storage (mafs).
3. Added new kconfig options to enable/disable eSPI mafs support.


Results:

Successfully conducted a flash update via eSPI.




Manojkiran Eda (4):
  Add eSPI device driver (flash channel)
  mtd: Replace module_init with subsys_initcall
  ARM: dts: aspeed: Add eSPI node
  dt-bindings: aspeed: Add eSPI controller

 .../bindings/soc/aspeed/aspeed,espi.yaml      |  94 ++++
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi       |  19 +
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |  20 +
 drivers/mtd/mtdcore.c                         |   2 +-
 drivers/soc/aspeed/Kconfig                    |  38 ++
 drivers/soc/aspeed/Makefile                   |   2 +
 drivers/soc/aspeed/aspeed-espi-ctrl.c         | 197 ++++++++
 drivers/soc/aspeed/aspeed-espi-ctrl.h         | 169 +++++++
 drivers/soc/aspeed/aspeed-espi-flash-mafs.c   | 467 ++++++++++++++++++
 drivers/soc/aspeed/aspeed-espi-flash.h        |  71 +++
 10 files changed, 1078 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml
 create mode 100644 drivers/soc/aspeed/aspeed-espi-ctrl.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-ctrl.h
 create mode 100644 drivers/soc/aspeed/aspeed-espi-flash-mafs.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-flash.h

-- 
2.40.1



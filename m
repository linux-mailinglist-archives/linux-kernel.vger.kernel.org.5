Return-Path: <linux-kernel+bounces-25992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E497E82D976
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84E79281E90
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3756168CE;
	Mon, 15 Jan 2024 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiOude+x"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B345010EF;
	Mon, 15 Jan 2024 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-336c5b5c163so5191695f8f.1;
        Mon, 15 Jan 2024 05:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705324101; x=1705928901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3m3PViSSSvRBvvAf8R0G1zKDb1jwNa59pfSuNx39IjA=;
        b=fiOude+xAh/5BsugYLeaBckaQpIT85DviqTe6kEY4uC/NM/lPs4iUb7jGtjJsQdirK
         ufBRVcUB4xyUAqG+3JqsGwrkpCr89Q5jihTk+XuKXJsCuZ9gwIdGioIF2+D5ze+N2QEO
         WoH89LV2pZuIn4zaHOuiwFonrpNR6M5ayrww3CNmBuO1QWZ1AYcBxK2MkFWYV8z3m2Si
         NXzt2AlFKZ2Hhv+10UHHzsrBXpZAzP0lUgK9Soikp/xUNXpJa9pnfrDWfYCSkxT3Ef0g
         sMSlR34kvCc5HVgeIiXzgMPRoJJ2cZXQYtxr7PsXAf7XZlwcqd9G875al4+VLDt2GheR
         QwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705324101; x=1705928901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3m3PViSSSvRBvvAf8R0G1zKDb1jwNa59pfSuNx39IjA=;
        b=JMl7iMxHXSzI4qi9KmQCDe+lmyo3kM2ooFTYyBHxwe4CvxL0Ufc6v7Ld2JPVXXc+pm
         r5g5CCrjmXBYz8Wqguu31IdTOp/4TqAqj17PRlLOKenQUlNN3Q6cYaBD/QWy1N7xuEP3
         svCxQaaqWSsk7AoGCA0+N5ERPo5B9yjpE6zfFhScPpvLc4NG/xXskPL4QQ1mgdlH09aD
         STaoB6yajb1cX4H9acYOKCXNyZbzRga3+zQ8pczJ3Bn5+rXFNnGXQkxWMi10ueJn8KgB
         EzSx+cefHCWm5LnxQC5/w787Viss0WUGQCvi4NKrNktqbEW43poird5bi6HpEzXVpIYF
         vwrQ==
X-Gm-Message-State: AOJu0YydQOpYqrbxwv46Anm8nhTxDJf+q0tqj7eKtBvyGeBgMlbENPdf
	ElPdIDiIn1Eegdk8wfsy3Dw=
X-Google-Smtp-Source: AGHT+IHYQfEs5XGymkxoK+hmT+5FEpzfUXZVunTBJ4C+DExa/kiwAN/9Ms0uGtOrL086Fib4Yb2a8g==
X-Received: by 2002:adf:fc02:0:b0:336:7934:9b37 with SMTP id i2-20020adffc02000000b0033679349b37mr2871427wrr.25.1705324100705;
        Mon, 15 Jan 2024 05:08:20 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:3d67:232:2eec:2430])
        by smtp.gmail.com with ESMTPSA id d13-20020adfef8d000000b0033739c1da1dsm11843620wro.67.2024.01.15.05.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 05:08:20 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 0/4] Add missing port pins for RZ/Five SoC
Date: Mon, 15 Jan 2024 13:08:13 +0000
Message-Id: <20240115130817.88456-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series intends to incorporate the absent port pins P19 to P28,
which are exclusively available on the RZ/Five SoC.

Cheers,
Prabhakar

v4 -> v5:
* Made struct rzg2l_variable_pin_cfg variables u32
* Updated PIN_CFG_PIN_MAP_MASK macro to use GENMASK_ULL() as reported
  by kernel test robot.

v3 -> v4:
* Rebased the changes on top Claudiu's patches
* patch 1/4 is new patch for using FIELD_PREP_CONST/FIELD_GET as
  suggested by Geert
* patch 2/4 adjusted the code again using FIELD_PREP_CONST/FIELD_GET
* patch 3/4 fixed rzg2l_pinctrl_get_variable_pin_cfg() as pointed by Geert
* patch 4/4 is unchanged
* patches 1-3 have been boot tested on g2l family

v2->v3:
* Fixed build warnings for m68k as reported by Kernel test robot.

RFC -> v2:
* Fixed review comments pointed by Geert & Biju

RFC:
Link: https://lore.kernel.org/lkml/20230630120433.49529-3-prabhakar.mahadev-lad.rj@bp.renesas.com/T/


Lad Prabhakar (4):
  pinctrl: renesas: rzg2l: Improve code for readability
  pinctrl: renesas: rzg2l: Include pinmap in RZG2L_GPIO_PORT_PACK()
    macro
  pinctrl: renesas: pinctrl-rzg2l: Add the missing port pins P19 to P28
  riscv: dts: renesas: r9a07g043f: Update gpio-ranges property

 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi |   4 +
 drivers/pinctrl/renesas/pinctrl-rzg2l.c     | 284 +++++++++++++++++---
 2 files changed, 248 insertions(+), 40 deletions(-)

-- 
2.34.1



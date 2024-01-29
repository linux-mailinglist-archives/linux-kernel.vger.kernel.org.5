Return-Path: <linux-kernel+bounces-42842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A058840797
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB4C1F26D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A067657BD;
	Mon, 29 Jan 2024 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atdMK3XY"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20969657C2;
	Mon, 29 Jan 2024 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536586; cv=none; b=E+4tmxR8nc53ltIVP5aAgZpm5PCsZRxUjUTlhMSqJkxf8IqiMrdOANu8H83KmefkypJnYh9naKNjdfujXZrhgHh886s588+V2O1trgQVYhWBbQLvedXczd9XO98mkoSv8NsdyD86enXdFAb+GWBlrqntoQNum1qZlOjGiWihEmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536586; c=relaxed/simple;
	bh=LjKaS9a9ftamQwX3DEza7SKDpTVw8DPs6rjsrh9fANQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i1xpnj5DjAnVPqJ1GwWwIRMsAANexAh+gumRjqQLzEPTTtGPQLDux2zWArr6J8JP0c1FdS4ncYZ3yO184XDt3t3m99tPU/v0jukg7GSBQS5siIUrpDRRwckp/gaw7ZgcTYUdJ9EK1srQz+9o1GlJISsCCuQKxvbzT/RnohCszWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atdMK3XY; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5110f515deaso1647434e87.2;
        Mon, 29 Jan 2024 05:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706536583; x=1707141383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kLNm6aWjWhP3Zo5PR428kbbo6W3kbQTRbP3vEHT7Ffg=;
        b=atdMK3XYJwQ1Jsbt0SJp513owJvKojgA/IaJgcIImEySyMKSx2TLnDfYnvRIvxv1WR
         8B1jsqqBdZ1AMQI46fQOvPVEOfeN9GElFG3vjSdmtNrzdCUj+nRoUUznnyf/MCrBccKL
         7e5zlIKtJU+mBVR2oZpoEIEKPBPsIJaD+hyQI2QYPcsuH4w2/EJKHK8DH4FmcjehhvOV
         SJxArGmq6XUHrOujCXB/NFkzq05reOhbb84sRQRtTA99EpKm3ITbuX4U3r8hH8UQLz3y
         NL7WhQ1ctFUdq4MBHWAKdABLCNMKvlJo90zJLSI8+IfVTRinyV3O/N2hxTliUrGSNUZI
         FnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706536583; x=1707141383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLNm6aWjWhP3Zo5PR428kbbo6W3kbQTRbP3vEHT7Ffg=;
        b=xHRFVErMyKmH/ljNBgI0fpuhX8v13iRom3DaGLnsl9UFEjVd4YQGT5SxsaNREQg60R
         bwtW/Sw7FDOtMzcQXXgoa/WiUtbPmESow654eNiGtxITE9jYwYB1L6ogOPY/2EGg53OB
         8CGHWlc5NED/CT0WvqSr1v1y3PckUG2/Ty343ZJO5o7xrZbed5hsFC3bTw4KHNrUzZan
         0ewKcB+CndwAJoqR+/Tqpzoshq1YcrhwkkMuejjG89FzzngSUKSZ5IxRc7k00O37rrMA
         PCZUSbwgy4ZS6S8hVLcZNS9EButDZN33fMnNaHOHZYS0+a3Xd0yDfNxihUDaUPybOy9b
         Lcng==
X-Gm-Message-State: AOJu0Yyjlpuh+o2BUmNhMHmRaxXSoG2XLRGKrFQbRV6sm1lY6jvblJRD
	LzTV2gK1WpsoQgIBnAL1HJsh+nWDN3N9udUQhjUDd2KB9q/8M2MW
X-Google-Smtp-Source: AGHT+IEEtghO5GV+T/CBEzKDmZAqom9CfctaZ5B5R9VZvhtHodZrQXvLgfVQnCcQnTFaBnCC9ONtzQ==
X-Received: by 2002:a19:7612:0:b0:50e:36ad:5f6e with SMTP id c18-20020a197612000000b0050e36ad5f6emr3552167lff.20.1706536582819;
        Mon, 29 Jan 2024 05:56:22 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:5616:a18c:ea50:2995])
        by smtp.gmail.com with ESMTPSA id bh5-20020a05600005c500b0033aed46956csm3058057wrb.80.2024.01.29.05.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 05:56:22 -0800 (PST)
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
Subject: [PATCH v6 0/4] Add missing port pins on RZ/Five SoC
Date: Mon, 29 Jan 2024 13:55:52 +0000
Message-Id: <20240129135556.63466-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

v5 -> v6:
- Rebased the changes due to conflict in pinctrl-rzg2l.c

v4 -> v5:
- Made struct rzg2l_variable_pin_cfg variables u32
- Updated PIN_CFG_PIN_MAP_MASK macro to use GENMASK_ULL() as reported
  by kernel test robot.

v3 -> v4:
- Rebased the changes on top Claudiu's patches
- patch 1/4 is new patch for using FIELD_PREP_CONST/FIELD_GET as
  suggested by Geert
- patch 2/4 adjusted the code again using FIELD_PREP_CONST/FIELD_GET
- patch 3/4 fixed rzg2l_pinctrl_get_variable_pin_cfg() as pointed by Geert
- patch 4/4 is unchanged
- patches 1-3 have been boot tested on g2l family

v2->v3:
- Fixed build warnings for m68k as reported by Kernel test robot.

RFC -> v2:
- Fixed review comments pointed by Geert & Biju

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



Return-Path: <linux-kernel+bounces-120047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7444E88D0DA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9A46B219EB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F63113E41A;
	Tue, 26 Mar 2024 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bo/GodDS"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73B813E03D;
	Tue, 26 Mar 2024 22:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492206; cv=none; b=asYaAThRgQKA98wvrjk6Yh1I7oZhhY+dfhJ0+E9zmnZBJ5iRy2jxmDT4q1PpaGD3XrS//NczmrtQKs00MfpLLv9Rcdy5n1B2zUbpSeeJIlyPczFo4ZAWaBvI318eTLQslK9HjxnRoYvMND6wXQUQuxHm4ajSswmBJex5KShc1HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492206; c=relaxed/simple;
	bh=QeYjK/TMtPSocGnoRUFMmCD1HcnoJ81gUzd/wF12x4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pVMnGVe03ok0Auu63cLV7hLIW1M0KtEYdSlGTdZrBZ1/w4cKpxOfFFicLvNAW2HJsoc6ZgnnBta5TIX2fyVVJE9oiwyHbQM6bt2qFM6cmvZalfETJnc18AIQ4y5pexsAALYsEXsYezqipuHAkW76JlK53bZJ5hpNTncVSZXrMto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bo/GodDS; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33ed7ba1a42so4090118f8f.2;
        Tue, 26 Mar 2024 15:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711492203; x=1712097003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7slSHrluo/yZHTT9IkQat6c1ty1R252Rsn9mmiwCGQ=;
        b=Bo/GodDS9r8ouSvLIuAYDKcx3gs3cZI4NgsPMCkuToWM5wTH9ztrm9f5BKNYU4SeaN
         owEV5Dgg0sAwl+sp2Biv0PQDevmplJySvX6E6coJgTmggpSFvUS8OIsyB/m9n/SVx6sD
         7eNoXwFlhtIqNjzES4PeGRedl5qFnEYfuFQg0sIF473FNHUznyeqsO99bUy0/8Aijx/l
         58qG5G8yMMJvrVOq26zKTZi3OlBWXN1Y9yUhiDLMHg2xiWvBu45t+6URSsVfzEp32+Nl
         tXXcaEL5+PgYGrIGLZpRfkf88s0xdqXhqryFQx4/XmB9AKOT1h+0MdrboEmlweD8Dv+W
         b+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711492203; x=1712097003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7slSHrluo/yZHTT9IkQat6c1ty1R252Rsn9mmiwCGQ=;
        b=cZAvfvpqAex33RTS2X3qrcan3/1CCN4H2FIW8jw0n+NRxGvUBVPSN0Kfs61IDrhHFs
         KxGAGrAgjUsMxdOxsqroEp6NN5Xs9BTSnMxqyQSLlPfOV8I6J1EbKAj7gsfKI5D7vxn7
         rX3oJjzrANjkyKfuy9Jte3kUD82y34FgXRQ0+l+em3jzmROROemZ2A6d9dp2CNQR8rFI
         4fUyGRCru2NeL0UsxUrkiCy0ZPAHcpdXnOcP0UMZL6t9fCx8kPHVTYXQ6UliL3Bhwdrq
         C0CuOCbbui2Pjz0XYL8o6U0CqohrlX2vhp5hBlr9FEjmbYLihsFxXOO0tAf+Y81w8N6o
         UFRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpYNDBSoDD0oNbLGTthbk07VYQflRUIHARK/SCld1iZ09wNpvfFFwUW7iBeVH6Wmahrnxe8EjSn1JZURD/nKIs7Zrvlnwoeuapfk681VuGFWDepBTbv3T4fvQoGbWZfYlsEFvlSmgHCU1vRv8B1XIyRaA7ohGnSB7d195RVPHo6r+5QDY=
X-Gm-Message-State: AOJu0YyjTPtis9E+Li0wxv/hUD/Ph7cpMCxgNMxWA1kiEH1ixK2WKWwa
	MBID1yDcPjI9aCgFxp4yALDV0d/UEaAyfoudp5yrincJW+iOXkc8
X-Google-Smtp-Source: AGHT+IGttCqHFnX55tKbvHYsZRUySNn+bm/lcNxQPQ4W7052Y5DqPlhwDpWFvRwf31oB56Tb9JUeIg==
X-Received: by 2002:a5d:4705:0:b0:33e:c271:8c90 with SMTP id y5-20020a5d4705000000b0033ec2718c90mr8694797wrq.10.1711492203016;
        Tue, 26 Mar 2024 15:30:03 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:90ec:252a:cdf5:54e9])
        by smtp.gmail.com with ESMTPSA id bs20-20020a056000071400b00341de138a2esm600647wrb.94.2024.03.26.15.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:30:02 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 04/13] pinctrl: renesas: pinctrl-rzg2l: Allow more bits for pin configuration
Date: Tue, 26 Mar 2024 22:28:35 +0000
Message-Id: <20240326222844.1422948-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The pin configuration bits have been growing for every new SoCs being
added for the pinctrl-rzg2l driver which would mean updating the macros
every time for each new configuration. To avoid this allocate additional
bits for pin configuration by relocating the known fixed bits to the very
end of the configuration.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index fccac6d199cd..f2c71462de92 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -78,9 +78,9 @@
 					 PIN_CFG_FILNUM | \
 					 PIN_CFG_FILCLKSEL)
 
-#define PIN_CFG_PIN_MAP_MASK		GENMASK_ULL(35, 28)
-#define PIN_CFG_PIN_REG_MASK		GENMASK(27, 20)
-#define PIN_CFG_MASK			GENMASK(19, 0)
+#define PIN_CFG_PIN_MAP_MASK		GENMASK_ULL(62, 55)
+#define PIN_CFG_PIN_REG_MASK		GENMASK(54, 47)
+#define PIN_CFG_MASK			GENMASK(46, 0)
 
 /*
  * m indicates the bitmap of supported pins, a is the register index
@@ -102,8 +102,8 @@
  * (b * 8) and f is the pin configuration capabilities supported.
  */
 #define RZG2L_SINGLE_PIN		BIT_ULL(63)
-#define RZG2L_SINGLE_PIN_INDEX_MASK	GENMASK(30, 24)
-#define RZG2L_SINGLE_PIN_BITS_MASK	GENMASK(22, 20)
+#define RZG2L_SINGLE_PIN_INDEX_MASK	GENMASK(62, 56)
+#define RZG2L_SINGLE_PIN_BITS_MASK	GENMASK(55, 53)
 
 #define RZG2L_SINGLE_PIN_PACK(p, b, f)	(RZG2L_SINGLE_PIN | \
 					 FIELD_PREP_CONST(RZG2L_SINGLE_PIN_INDEX_MASK, (p)) | \
-- 
2.34.1



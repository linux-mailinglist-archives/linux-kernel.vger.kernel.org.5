Return-Path: <linux-kernel+bounces-120048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D167C88D0DE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4869F1F66E35
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB8A13E6C2;
	Tue, 26 Mar 2024 22:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzHC9gB5"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1E61CAAE;
	Tue, 26 Mar 2024 22:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492207; cv=none; b=COIOLV2CMBZHi1wZ2/z4LpqAErZn8i75VZyIsedmRPXVumAr8BKq/TLL5GRpsRh34Wf5BoI7xUN271Fkubz1IN7wOYsGkXIRvX4PJLnqZETfR1Cl/H4Zo3keyAr9zS6JId8gxJSroEsl07FWkzEDNSPyaKNSy77cZJlMs0JTmFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492207; c=relaxed/simple;
	bh=nr1KyEnr6RNBT94GwrGI82jLNrmEMY7aUvTUBIXU3UI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jzpCg6CzX6Yxg+YOrowM42AkmbAlDVsX4YTICTeswpDiPgEAsdM4rqzV1FGOXuD9UNnFunrP74Zrdy0iI1TAJDlOTYeqGBiCv6kFAFHIWeJaVl4oYoHW94BFoKQ2g2ap/j4jcj/Cex0LEuyi6dleKOGq3PTin8BrRE5TS5RCIi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzHC9gB5; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-341cf77b86bso1754315f8f.2;
        Tue, 26 Mar 2024 15:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711492204; x=1712097004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgohSLyg2e0nbKWx+Eeh0sacbPLQWN8SXQaLV85doCI=;
        b=OzHC9gB5GCs3+g8a2od9FODGdBlba7+IvgWxXwQnjbtm+ihnZLn+oLs00gl4NPDc92
         LMQne+WBwIDyICOJ+AfBUwahyfgj9/9KbmwtOINPDsT/VQISboEDUoiqaFR9rW7ar+8X
         2naoTvf8E4yuidk32zgk57PJklAesYxgubH0RnM62ovKvQkhQ/rjRvYEzJAC+2G9YfvZ
         kBpy9guEiDOLkwy9R8Zsfhxu25VHP7Tytjp0cMTQEeRj9qqKZIY0dZfW5cURiQrzseGG
         CPJWhYcNLCNkgdc46R4C12RQqc0msw+cx8zJFJlhSfBMkUGU1ixO/fK0rM+CacdQk5hO
         gqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711492204; x=1712097004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgohSLyg2e0nbKWx+Eeh0sacbPLQWN8SXQaLV85doCI=;
        b=fYyAHF7NVXg+TwsphicVdUow1593DONNjLnksqtyiRRErg9uDJ5BG1zXr+776uZxp1
         0/wUczeTJYQeBg//lffEwa+DtQC0y1uWPh1Q3cNklz4V9UWZJpu84Tx6XGNAE4hhaAR8
         MEx1csbt+vBRYiQK9JkLfxu3mKkQ4wEY/hAmT6kITmPHgPA9AxSS8i2MUhkAeUAM4xHQ
         bjxS6GuGj4YTHJ0Q1zYUNOrMnmZg6e5Uvi2jl1lK6fkryNHolq6CsJtH/tEl6DbSh5O3
         oF8am9AI/T+16Mb3yrooTv7yZuHXEfT5YHkATphfTwzUausprNaRayoBRDtIuivq0T1i
         hDbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhxJ067ZF+KZYk5j1AB1kcFYrlYbMnWAAfiJx4ZzBWchwiIzqV2ibHdSnBYsT5PJBvGr9JQmty1oEa4doi1DYlm/5kL6jBhhL2eBAjGWJJlBZGA7DI+LHyvmqrpfIl6hup7uMk0vegi9zU8gXCj0RjfnQjlgl8chT95zwnxd/MbaJ2ADU=
X-Gm-Message-State: AOJu0Yys3Itfhiui1WEwOm1ZsT3KOpUSrnf0f1JCxf/hGfVmFLfSZ8Vv
	L5ZcVH4Noe08FuG6jA7yyiQrcn7qr7Weoqm+5MrC+8hIx/I0LNEm
X-Google-Smtp-Source: AGHT+IG8PXu9DEd+H8iSzgcHcIGuHZ4afYLUbWDKQpVwoIRdyO1PLyIF0JXTT/u9/McJl2CuLnup3g==
X-Received: by 2002:a5d:4b08:0:b0:33d:b2d6:b3a6 with SMTP id v8-20020a5d4b08000000b0033db2d6b3a6mr570127wrq.48.1711492204432;
        Tue, 26 Mar 2024 15:30:04 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:90ec:252a:cdf5:54e9])
        by smtp.gmail.com with ESMTPSA id bs20-20020a056000071400b00341de138a2esm600647wrb.94.2024.03.26.15.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:30:03 -0700 (PDT)
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
Subject: [RFC PATCH 05/13] pinctrl: renesas: pinctrl-rzg2l: Allow parsing of variable configuration for all architectures
Date: Tue, 26 Mar 2024 22:28:36 +0000
Message-Id: <20240326222844.1422948-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Enable parsing of variable configuration for all architectures. This patch
is in preparation for adding support for the RZ/V2H SoC, which utilizes the
ARM64 architecture and features port pins with variable configuration.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index f2c71462de92..da3a54b7b06a 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -322,7 +322,6 @@ struct rzg2l_pinctrl {
 
 static const u16 available_ps[] = { 1800, 2500, 3300 };
 
-#ifdef CONFIG_RISCV
 static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct rzg2l_pinctrl *pctrl,
 					      u64 pincfg,
 					      unsigned int port,
@@ -339,6 +338,7 @@ static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct rzg2l_pinctrl *pctrl,
 	return 0;
 }
 
+#ifdef CONFIG_RISCV
 static const struct rzg2l_variable_pin_cfg r9a07g043f_variable_pin_cfg[] = {
 	{
 		.port = 20,
@@ -2285,13 +2285,11 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
 		if (i && !(i % RZG2L_PINS_PER_PORT))
 			j++;
 		pin_data[i] = pctrl->data->port_pin_configs[j];
-#ifdef CONFIG_RISCV
 		if (pin_data[i] & PIN_CFG_VARIABLE)
 			pin_data[i] = rzg2l_pinctrl_get_variable_pin_cfg(pctrl,
 									 pin_data[i],
 									 j,
 									 i % RZG2L_PINS_PER_PORT);
-#endif
 		pins[i].drv_data = &pin_data[i];
 	}
 
-- 
2.34.1



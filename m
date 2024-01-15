Return-Path: <linux-kernel+bounces-25996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B9682D98A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19A021C2155C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C725517580;
	Mon, 15 Jan 2024 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7BEy2in"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3C3171D4;
	Mon, 15 Jan 2024 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3376d424a79so6728088f8f.1;
        Mon, 15 Jan 2024 05:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705324106; x=1705928906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WclvSvESBcB1ccyxeqjrdGj+frspJc0esD0QtgwrkCo=;
        b=c7BEy2inHAh8liKaRYt9aZWfCtmK6FMbo0y3yKsVHqD4ROhT/7vCeQY7Hr76g01C8w
         n0zlAZ6wgthxFUUAaDkcwYNQnF04UCT3zKmNkV7U63AHlCwNcbMozmr3wSzxdw/dqHZj
         yLJPjA3wAxnid6i3w7uk4lK2aPzh/DcVUCrPY971k423nKTWoMCXzqz4PZcf9Db+nHah
         SWIftww4gAT7Uxs/KjcuSqpXZRY02HXmeaX/A45PAujdQhFeCEyd6teo+zicffA8XqUY
         qbt2zAUxp1tSoXEgQRMiyDJznjG98S7569PL6/bCe1jLL/07ODUnDOGZtzqa6FxRlwkH
         JM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705324106; x=1705928906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WclvSvESBcB1ccyxeqjrdGj+frspJc0esD0QtgwrkCo=;
        b=qFO8nKeqpP3Hq4a3r9MLPdSyXxX39QJ4TGcGs7HjTmdMwLBlGfYVk7NQofkEVQWUFH
         tuwAj51cz5/HyWxRTj269ZEFF0oq7ClTvizQze+H2O3F/NiRJi+IkhOuZlvzbutGXW5a
         EsqAQ5LxJAPBEm1jDd3SotmHTrHkh5xl+mm7T1bsIfg2aP3gfOUaId7eA7/vNJtASLHj
         K+4WyTs/7aDIo7RydLoSTBDDn6FR452ZXsQWqUoUaeswd4kZE8X5f5+PTFGgzpG8NgBd
         Wn3AwQ6VT4e9ZRY+cPemK4EYcNNz+oDG0jU3Ys02AFazaMouInhSvieSFM2FSFeGj5DI
         LZ2g==
X-Gm-Message-State: AOJu0YyojPg4fPZeOOM0Bs9kvwJyHxt2F4/FIQwS0jx5MOICNLb7YAWU
	bhjCU75v7tbJGJDCnvQ8H4M=
X-Google-Smtp-Source: AGHT+IGsOzQ7L6ielq7mxIFwHy6qHtdKpqdw04n+je7tcix4atLkzck0Yy0VuXqfteUT7WaM2h9fFA==
X-Received: by 2002:adf:dd8f:0:b0:336:5f04:bff3 with SMTP id x15-20020adfdd8f000000b003365f04bff3mr2990776wrl.81.1705324105815;
        Mon, 15 Jan 2024 05:08:25 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:3d67:232:2eec:2430])
        by smtp.gmail.com with ESMTPSA id d13-20020adfef8d000000b0033739c1da1dsm11843620wro.67.2024.01.15.05.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 05:08:24 -0800 (PST)
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
Subject: [PATCH v5 4/4] riscv: dts: renesas: r9a07g043f: Update gpio-ranges property
Date: Mon, 15 Jan 2024 13:08:17 +0000
Message-Id: <20240115130817.88456-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115130817.88456-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240115130817.88456-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

On RZ/Five we have additional pins compared to the RZ/G2UL SoC so update
the gpio-ranges property in RZ/Five SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
index d2272a0bfb61..aa3b1d2b999d 100644
--- a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
+++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
@@ -46,6 +46,10 @@ cpu0_intc: interrupt-controller {
 	};
 };
 
+&pinctrl {
+	gpio-ranges = <&pinctrl 0 0 232>;
+};
+
 &soc {
 	dma-noncoherent;
 	interrupt-parent = <&plic>;
-- 
2.34.1



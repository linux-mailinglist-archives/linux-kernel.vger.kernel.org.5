Return-Path: <linux-kernel+bounces-24748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAA582C1C6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ECFF1F24B6D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07746EB52;
	Fri, 12 Jan 2024 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiXFnMCR"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2366E2AC;
	Fri, 12 Jan 2024 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3374c693f92so4690535f8f.1;
        Fri, 12 Jan 2024 06:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705069591; x=1705674391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WclvSvESBcB1ccyxeqjrdGj+frspJc0esD0QtgwrkCo=;
        b=fiXFnMCRuBjSwm73Btaj/H8JIXnPI7NSLtHC1f+2XZhVnVNWfKXO+4yl3hBfbVhmOD
         VN7ICRBp0RNP42BE+1GUFAg1nPZwZqiMlRcRDiVb+bLRL8aFz27ycRZp9sHc9Dlkx6ZY
         9u82MUjwaEsnVFG3b6ElYLPkLB7xsGhNMLuVk1D9YtVGX3f0Jk4AQataLcKZ4ESttT6Q
         2I5gysR8JME1Cyo/Pz14s5IGXa6icjEd3bFuwvr8ezc6HcC9xOaDB+wf9zFM7nSkZdE5
         rBXvNWh7be6ntmlURZpIcfdM/k+DCaQ8V+GnIhki1uHpzLInbZxdtxOfDWTzC/oGo1gt
         6pFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705069591; x=1705674391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WclvSvESBcB1ccyxeqjrdGj+frspJc0esD0QtgwrkCo=;
        b=F0gn30k9bxXr8kJfnbayfDiI94bm6Gnb8z98gmlQ63Jen7uZOqB7U/CtlxjNgnDaHB
         R9AXGcXDhUndAiuTC6v64sv8okj3d6iJIcxQZZeHaYXmV7SS4AlCwWDcuBZVg5vFPzpb
         9LMlV+sEOiORofspjzqLuKSsn8JRr5ZyUcbkAzo/whNY0vRdWV9Cbx9EI7+QZbAwJdj/
         MwUONWzKIENjfiZfIadbtxbSvWAS3+QjFdMoKyTuVVOoKefcKB3+UJHXGvqvanLyPfYD
         qfUt+rKRMKPL4rZz1pqIif0mAOLsYus7HD/wqvKrJ/k/1QZfgEasjXwhCYUydeLlwycX
         rP+g==
X-Gm-Message-State: AOJu0Yya9aI1czSgStXfWKb7he/u1u9DBsNu5MpAkJoPm50o0EJZf5nM
	9SW63RGhtfWiJANVY0JEUic=
X-Google-Smtp-Source: AGHT+IHVtC639FZXHSGXUI4wjXAd7RHB12n7+GICuZHzambNk3DzkW0+DuDqNWSh+t2v9ArOYbiv9A==
X-Received: by 2002:adf:fa51:0:b0:336:c3c7:75e8 with SMTP id y17-20020adffa51000000b00336c3c775e8mr697221wrr.45.1705069591670;
        Fri, 12 Jan 2024 06:26:31 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:494d:c489:3d96:1b15])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d4dc6000000b00336a2566aa2sm4021219wru.61.2024.01.12.06.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 06:26:31 -0800 (PST)
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
Subject: [PATCH v4 4/4] riscv: dts: renesas: r9a07g043f: Update gpio-ranges property
Date: Fri, 12 Jan 2024 14:26:21 +0000
Message-Id: <20240112142621.13525-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112142621.13525-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240112142621.13525-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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



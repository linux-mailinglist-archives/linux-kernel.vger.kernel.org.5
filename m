Return-Path: <linux-kernel+bounces-42846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A658407A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862BD1F237B2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A211066B32;
	Mon, 29 Jan 2024 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPdF4R/4"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F11965BBC;
	Mon, 29 Jan 2024 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536591; cv=none; b=QprtkRb3e9ZQ8u0sKCeEJqEZwgnxN0iiDgPD+XYiqNl9kVXU1hpxVY2To8W2wAerIlSTonAIGiZ5d0i1cXX9KK7dwjOifZS/kGdSFGI107YdmnjvB2B6qrZsb/dT4265kg9xwoVtpFtv2M65CL+JQLeJHM6LyGJg0y8YA3AfPFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536591; c=relaxed/simple;
	bh=FGSEzWn1LxVZjMRgXwDQ9AesgqJ5I8CYMNMEr12U7U8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ao9lcxjSoCDnqksUnkiwu0Qc6tBuu8lHwxUpECVQsUXZm69/BjCC/aXHGU9guS0Bcbxkn77hB4AGQm84t5M23Jc0SpOGIdU7odJhugwvimycHYCnlO33ngu1s9ygmM50k3UBr1o2oVOPNmPqFjHgUoRXsjXKH/XnJ6CPdp4vZmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPdF4R/4; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33ae3cc8a6aso1439272f8f.2;
        Mon, 29 Jan 2024 05:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706536588; x=1707141388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WclvSvESBcB1ccyxeqjrdGj+frspJc0esD0QtgwrkCo=;
        b=UPdF4R/4HpA0gTA5h7cj7VbUvWgfDWse7bQ3LQ9tIRNuF4M8u5mMelc5FlsZhZipH1
         jzrOf2dBLibSfYiV1iwNCJTYVJ7SvnyFpFnC8oDTXxtmqDNAaeJkL8TIrAkCvlOWb3Rc
         k2f++sgdECqMthvxKaBRZQy/wPzPhqMwKWLWpDMMsdpCZEliTT7ncJT1Chk8UgExMR1V
         H+DGNpoYS7kEQuZAge5sPH4iI/Yg0Flwc3KZ9I3Jy7rvEWtNKKM6JNagRy5VwhfqjWE5
         fJ22P2aWtnIZFGJtqLk+3j1R+0LWQkzsoVHMG45o17LHZZIVijLfZV+vd1yugUC2VYII
         TRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706536588; x=1707141388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WclvSvESBcB1ccyxeqjrdGj+frspJc0esD0QtgwrkCo=;
        b=nXUOOPoplC0BNmwaHyjFbN5RUPqNlEPceFmsuPyMkxcEXLvFxs/53wk3jf+C1wrLba
         aSwQ4H2obu4hmUXaxi1LUz1Yd8b8g0hFmpYjnunuUUmkT5FR1SBK4bAyoOMhPP/GzMKl
         6TndNIImjXyHO+DMCkhFhw2y3qT1ZKXX9d7aXa1rF/N+6icd9MhiXEof5cEFJouQ0jns
         BR7cnHffoAesYACi8j/BasagO1BO5ECcmdxjan3h8mayd7DEHZ7uNg7GHiEg8yXQxpQ3
         5I2km9KTF6NtddoTxScC2ALLcWmkMKpKeTn4ORARzNj3GJ2HctCjo9rDFx4EmwgNoAwJ
         5Tcw==
X-Gm-Message-State: AOJu0YypyoHlK9YpVF98iMqi7WNURn+CEfqTz8cIOxTGPxiPuWCobA/v
	Iq7kyEPl/AHSOe/61iWxWcYc6ddFfLdeAYf2wC3Eb7d3pUAkJS18
X-Google-Smtp-Source: AGHT+IE/VmvDYsDUatlkAcbfvFN0EbwPx+JdGJuMYr0hmxp2wA6wVVhbilb4HSjUJXPxhVsTUXxUyA==
X-Received: by 2002:a5d:6da3:0:b0:33a:ed3b:3739 with SMTP id u3-20020a5d6da3000000b0033aed3b3739mr2973996wrs.30.1706536588205;
        Mon, 29 Jan 2024 05:56:28 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:5616:a18c:ea50:2995])
        by smtp.gmail.com with ESMTPSA id bh5-20020a05600005c500b0033aed46956csm3058057wrb.80.2024.01.29.05.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 05:56:27 -0800 (PST)
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
Subject: [PATCH v6 4/4] riscv: dts: renesas: r9a07g043f: Update gpio-ranges property
Date: Mon, 29 Jan 2024 13:55:56 +0000
Message-Id: <20240129135556.63466-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129135556.63466-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240129135556.63466-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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



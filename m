Return-Path: <linux-kernel+bounces-15577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D7D822E5B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66A731F23D78
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E083919BB2;
	Wed,  3 Jan 2024 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JmAvE8mK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4141BDCE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A64F93F69E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704288550;
	bh=Z6kJEMrEbGLyI1yj9sToUKHZA2SkNTvsj92LWdDmHKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=JmAvE8mKLbkDjuRxtxLM2hsONbBLT+kavAVBo+C5vZ/U31Ayvc8SgbrPnnY/B8tFE
	 Uw0I3TJhB4xduhzRuerg4kJfNOA7BNrQkid6ydl3k+XcN+sJitL4uayfKG1/DsW+80
	 ntTS9jRnmwzugU+Eo1dHU2brEUJgB2UVXrInrpN2ZUk6EvP9CZEuigQ8k0YiPkYMjE
	 N8y+sHaLfbiFk2owxUlood2AMFfiE/UkzldF54A+JKjPaVaV0g9VAE10uOS7lz8agX
	 vq/2JF61vZzcx9UcJTc7bolJrv40eMlojC7Rm0n2Sn4lH6R3Im2hZJ2SFiGePjDg4X
	 pFjH76kjduFSw==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-555daab7fc1so1629158a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 05:29:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704288539; x=1704893339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6kJEMrEbGLyI1yj9sToUKHZA2SkNTvsj92LWdDmHKU=;
        b=ioisCTekdsKQaf2w7MJipk3rztKqmvfpuyW3+xCAG5UZhXlyfU7HgkL3XxCWco3Ubs
         /Tm5b/SN9pAqgAExolurS9GyZ0Uma3Es8cVxrVgwmFS4WNN7y6IFlC/O5/f52N8kUnzQ
         iZLvCH70V/T1l0V4HugXbkGOWEBfQhX1sx/ZYvtlEKU+s3Uuoe19T6I52taJUNodfY9q
         v+ZGH6FtmAM5ZRJzRL1RqVj+ia7ILOA3qguF5LK9uH6bdYan0iw3v/j6etU0zwboeuDl
         0ega9XLDJxr+Jjm9BWtuF55JCjDOm0mbpSIE8VYTRkVrTMSB42FhC/h7HwmmAgxKLxA0
         GieQ==
X-Gm-Message-State: AOJu0YzHdc3g6hEUZvsKhh6Vr6qhkZfWFSaoh8xT7O7DxzaygXc5K2QQ
	HtDVAOdRkGI7/ZdgJGfiHzQZd0Na0QQn97QKCHrbYCL57FU0MIHovTyGCu/Tt60gI/wU18I/i9C
	cPNAba8CDWHHn8F3Wu7/wI2muZL8x/uPvcA37X7b7ClogxQ9CL3RzwTKs
X-Received: by 2002:a17:906:3cc:b0:a28:28a3:89a6 with SMTP id c12-20020a17090603cc00b00a2828a389a6mr1880008eja.54.1704288539857;
        Wed, 03 Jan 2024 05:28:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+dUglk3qywpv3HLiAtpq5rTNNTGkv6sHrUH3Nu8K83CpFHOwrW3TADKmgsLV6w9iY21gf0A==
X-Received: by 2002:a17:906:3cc:b0:a28:28a3:89a6 with SMTP id c12-20020a17090603cc00b00a2828a389a6mr1880002eja.54.1704288539708;
        Wed, 03 Jan 2024 05:28:59 -0800 (PST)
Received: from stitch.. ([2a01:4262:1ab:c:5af0:999b:bb78:7614])
        by smtp.gmail.com with ESMTPSA id eu18-20020a170907299200b00a26e53be089sm9549873ejc.44.2024.01.03.05.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 05:28:58 -0800 (PST)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH v2 6/8] riscv: dts: thead: Add Lichee Pi 4M GPIO line names
Date: Wed,  3 Jan 2024 14:28:43 +0100
Message-ID: <20240103132852.298964-7-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103132852.298964-1-emil.renner.berthing@canonical.com>
References: <20240103132852.298964-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add names for the GPIO00-GPIO14 lines of the SO-DIMM module.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 .../dts/thead/th1520-lichee-module-4a.dtsi    | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
index 9865925be372..f674e5acd0f9 100644
--- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
@@ -37,6 +37,45 @@ &uart_sclk {
 	clock-frequency = <100000000>;
 };
 
+&aogpio {
+	gpio-line-names = "", "", "",
+			  "GPIO00",
+			  "GPIO04";
+};
+
 &dmac0 {
 	status = "okay";
 };
+
+&gpio0 {
+	gpio-line-names = "", "", "", "", "", "", "", "", "", "",
+			  "", "", "", "", "", "", "", "", "", "",
+			  "", "", "", "",
+			  "GPIO07",
+			  "GPIO08",
+			  "",
+			  "GPIO01",
+			  "GPIO02";
+};
+
+&gpio1 {
+	gpio-line-names = "", "", "",
+			  "GPIO11",
+			  "GPIO12",
+			  "GPIO13",
+			  "GPIO14",
+			  "", "", "", "", "", "", "", "", "", "",
+			  "", "", "", "", "",
+			  "GPIO06";
+};
+
+&gpio2 {
+	gpio-line-names = "GPIO03",
+			  "GPIO05";
+};
+
+&gpio3 {
+	gpio-line-names = "", "",
+			  "GPIO09",
+			  "GPIO10";
+};
-- 
2.43.0



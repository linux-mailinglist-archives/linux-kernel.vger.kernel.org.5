Return-Path: <linux-kernel+bounces-13944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3FC82155B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 22:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7FB6B20F63
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 21:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E055EAD3;
	Mon,  1 Jan 2024 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WK37HL4r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C34DF49;
	Mon,  1 Jan 2024 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ccbbb5eb77so66940541fa.2;
        Mon, 01 Jan 2024 13:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704142823; x=1704747623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+XZ4nybj4bZroxHF/K5QreEHMx55uD+jWsZAAJ9ETE=;
        b=WK37HL4r+gTQvY23IpoSw+hKZ4lvn4bNDnbu99ofb3udtT3rqRmrQWL70Xpq5NLf2j
         1nIE2G0EeM52a9oS5VcHqqkIeiHsLzFVyy8Slvh4MQF12qb2sRCUlZrBPd7o0qq1qeFw
         XvYwESLG7xycaGEMjwtWAAecxcjf5RMdSXE3FA+21BcVaPqygakRI1KyqtszlT5rbOf+
         9ou+ZWY7rwsnajKKWObHdpUaf6lzpEMNpLYdfkx/Q79D57Y5ItbULlRHPdxo9AmQKtBX
         TgpufY8w1vEwJm/bP/6xE1vl94Y69146xpslKYDaK45pe0AA+TeR3YoDjJHLRiaoCqSm
         7Jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704142823; x=1704747623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+XZ4nybj4bZroxHF/K5QreEHMx55uD+jWsZAAJ9ETE=;
        b=NaxbANyOKtFcp2XgQrJ3QArywmoMj/4h64Y/J7IOMccW4B2ZKicrB3NMfP+0IaVcRo
         oEvCamSDLRDNF+X1A9+2tXRyzbvStSEdRU2V8mTpCWELsBRU1Ej2tOSl4BpfPymIs4Ab
         NR13Txyd2WB/YVTi1gUaRFTVbsYnTNaIouTw0tYpw+F4hrVj+tpjk2erthucdSuuukUl
         zUJlnkOKb62XZ4qTL9zTU2gYKodlTgUylGKKWxaA2N2pXL/T3YVdAZYV1DEVofPJd/0i
         eTb5UOvQYK/27oJhqKYlhpM7HlZzDJXX25wrtDdr6X8thozPgwfHF7iihz3rNT02/Yz8
         A+OQ==
X-Gm-Message-State: AOJu0YznA9OqZM7PGtXoLH/xkTMSO9ICtQfi6d3fZxdYstfL9Cwf5+Ww
	PTYYvnlp6IFJDo855fls3TA=
X-Google-Smtp-Source: AGHT+IEyt54Orz1g1iSdDIT58gjh8S+dJZUEQWPhmkpP2Zw9GRBQBsp4FnO+/E+W4japXdG6IOsJrg==
X-Received: by 2002:a2e:a229:0:b0:2cc:df75:79b3 with SMTP id i9-20020a2ea229000000b002ccdf7579b3mr3727095ljm.12.1704142822801;
        Mon, 01 Jan 2024 13:00:22 -0800 (PST)
Received: from hex.my.domain (83.11.207.119.ipv4.supernova.orange.pl. [83.11.207.119])
        by smtp.gmail.com with ESMTPSA id i15-20020a05640200cf00b0055404e08589sm15122045edu.85.2024.01.01.13.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 13:00:22 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 01 Jan 2024 22:00:15 +0100
Subject: [PATCH 1/2] ARM: dts: exynos4212-tab3: add samsung,invert-vclk
 flag to fimd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240101-tab3-display-fixes-v1-1-887ba4dbd16b@gmail.com>
References: <20240101-tab3-display-fixes-v1-0-887ba4dbd16b@gmail.com>
In-Reply-To: <20240101-tab3-display-fixes-v1-0-887ba4dbd16b@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704142819; l=781;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=kgQ6hReH0wzI/acEF9QXTsrDq3bCAXF+wc7FhUZWg+4=;
 b=7ohf2QoqecR3WiauAHzQUR3+ckbuzk8rHVISPaWwZek5KfK2snxhjEVFaYXEd/XhZKmMWgcbW
 mL7cAAnGc+uCDAIE86dOdGOy9C0Y9j499m3IgkJ5UnsF480rkJKSsaU
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

After more investigation, I've found that it's not the panel driver
config that needs to be modified to invert the data polarity, but
the FIMD config.

Add the missing invert-vclk option that is required to get the display
to work correctly.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
index d7954ff466b4..e5254e32aa8f 100644
--- a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
@@ -434,6 +434,7 @@ &exynos_usbphy {
 };
 
 &fimd {
+	samsung,invert-vclk;
 	status = "okay";
 };
 

-- 
2.43.0



Return-Path: <linux-kernel+bounces-16730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D93782430C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9801F250C5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF978241FC;
	Thu,  4 Jan 2024 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvrdRdyj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2EB241F7;
	Thu,  4 Jan 2024 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d4a2526a7eso3264225ad.3;
        Thu, 04 Jan 2024 05:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704376072; x=1704980872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yp8IfCHTatW0ncFNjRQTUbnECiIcWKU3D3cZUARMrCo=;
        b=CvrdRdyjOMdFeB2V7NM76ENEofdN+nfmZeKVqCMjgWMa5z81xuP6hBaZOHou5LLe/R
         betGbR7ICMuVqDub8gq6CuJT8vjGVjZk+IB0v7bJN1AbRy9Lm43cWMqUtxexhAEWjjsY
         7gyXKCh9AIimIm3h2YGll/WSJf/wfueDvMUkzmP0g7Jk+WYE81ivzJZQ4C0KBPD35Dfv
         056HjU5Gbu0wdeN50GjFzGI2prwzzxCo01Jk61zYN7vXZKwfQFA3wOATk81lpJEctkxi
         waFLfU5vSM2ssce/qsBy1KgoSVwuo8kp0TgmojlB+Rb4n4jgGUwe5juLsPsfrP1WoxMy
         LqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704376072; x=1704980872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yp8IfCHTatW0ncFNjRQTUbnECiIcWKU3D3cZUARMrCo=;
        b=SwsNtf/meRWiWI9snd+BSi0r0Zeo9jG/zd64rbyn/0lCKKBnkwAXGDzpsoHcDhnpYh
         uqvtHCHjQG64JU30fpI9pjH6rf8KZirRT41QUD72QxrXQ16DBsnjfPn62K7Isi3Y0IjB
         RQcsQcZO/TiOpSw9PWsNmug4GXyhHv67U2LcOQCanM7XRp88vYGmKmnJKmTwnNCSe2nA
         /vhXxz0M14NmB7ZI9MgQ01jcHpz99vxcAUWGaJ8My0t24JJYGzzXIucR5nmTpznv/oD9
         2CM0asSJ3glcQ1k/A9qyBARM2QS9wmfZX91JPi6QDQV6xlpd877gJp3Vn1Jm2ksFLKzq
         e0DQ==
X-Gm-Message-State: AOJu0YwJ1WS/BuNuFEqN6GPspprIsDWtbMWKqnvm1tVKWIuncKoTgkHC
	z4bmcXdzrWojljKV8sMTxGY=
X-Google-Smtp-Source: AGHT+IFQHHYmwet3CoyyX/LqgEYVSersCYJ0/Vp/D600j6Qa7Pxw2BNU534S67X/82jEKX0M7gmpsw==
X-Received: by 2002:a17:902:76c6:b0:1d4:3795:710f with SMTP id j6-20020a17090276c600b001d43795710fmr475758plt.135.1704376072280;
        Thu, 04 Jan 2024 05:47:52 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id a22-20020a1709027d9600b001d425d495c9sm22990550plm.190.2024.01.04.05.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 05:47:51 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] ARM: dts: aspeed: Harma: Add PDB temperature
Date: Thu,  4 Jan 2024 21:45:32 +0800
Message-Id: <20240104134532.536793-7-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240104134532.536793-1-peteryin.openbmc@gmail.com>
References: <20240104134532.536793-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PDB temperature sensor.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index ca3052cce0e0..4d5d1c822fa3 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -260,6 +260,11 @@ delta_brick@69 {
 		compatible = "pmbus";
 		reg = <0x69>;
 	};
+
+	tmp75@49 {
+		compatible = "ti,tmp75";
+		reg = <0x49>;
+	};
 };
 
 &i2c5 {
-- 
2.25.1



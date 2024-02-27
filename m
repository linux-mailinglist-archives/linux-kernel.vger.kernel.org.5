Return-Path: <linux-kernel+bounces-82557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F303C86865A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303601C26281
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FDF3CF58;
	Tue, 27 Feb 2024 01:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZ23hbzS"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4C03717B;
	Tue, 27 Feb 2024 01:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998460; cv=none; b=pWJalRYNMfgUitZVXJV3cLrIkboPjIZ8Sjz1K3qaGk7CCywXGTeiUOaT56zahpAAH1J3Qu/kkyj3wsc06h5Ksc4xlx7VKrUobeR1uT5Q+jhhuTPo0l/0q+IUnGMgvpQfzwm5QF0mWU2G3P4oVHs2yXfK13Pzt+9V+5yUddQWfl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998460; c=relaxed/simple;
	bh=9WADVJJVD9uJ1S9KzLlikKR0zghswLsvPBCUmK13lFQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S+5Lpzbq0vpy5ShTaajVdvBZ94o5V2V9gbpN6r3tmigkShuWz42NrwEw91hvB/9mgAoYNNb8rQLRiutrxUqGvqxeWx7civE1JgBmUHAYJHg0isSzYP7EL7u8ooA8XOwRf95l3OQlvbqhGo12iiMXYnQhlQrQ0563CfZbww4wKA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZ23hbzS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc1ff697f9so30447565ad.0;
        Mon, 26 Feb 2024 17:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708998459; x=1709603259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7+fqIWtBV/T+80XSNaZFcmZX/ftnbYEEAJ0ueKG+0WM=;
        b=bZ23hbzSd7Wxer/c6T4de6vRv6x9CV3qKLcqjPqoywDXni/uP6DG1jUxFXUkfXUDTh
         17a82Oe0iead9pd6ME7NdMGcHx2vNfbOFK+M+56xbh0lgep042Tf4zA5xxvuO01ywXei
         LijC6YCKN2HG7Ch+3CTnSjdMN2KvUyJ0jSpKid7iuz61L5qvUZ+UN0MA7w9kn1iuChNh
         dKnVQse4DZ1Iq4k3opF9dUVVWvO8e6IAL227oPa45Nj4Oe1zzBCT8OcE892rOAFXw6Zi
         +61lDx1UyW69vGY2Q9LKdXmEqbzGoNAUfMdh6s+mHN62Lp3hMyxjKnbymyhPLUi0uwVD
         m67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708998459; x=1709603259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+fqIWtBV/T+80XSNaZFcmZX/ftnbYEEAJ0ueKG+0WM=;
        b=BzhucXy2LNHedcwyz4gfFH7G1XeaU51LrP1Ri1lrzjeaBMwpCpcqVgYQf4RfVjXVG/
         Trshr/0TtbZa/sF59XzmUlVWyFDNrRCkkqhrujd9UXa0rJ/B/S+DHXfbrcLZqN6A2Lxz
         26DANXH5PPRH9hgpjcBt3x3lk+Q39VxCeBLDDEXttRHHqRaccSDeCtT3BDmA5soc/nk5
         +oARrnWiODGa1o4UPIsWAuyu7WDAC30ET9ClNLPQL6zapdKlNSzPJUleXG0bvSmgDnFd
         +/O9dIvX2ZU1V5okU426EnvKyoqSdTKSuTXSRnV03riN5rqnsimGs3P8kZTSvxNYut+o
         87og==
X-Forwarded-Encrypted: i=1; AJvYcCVJCW0kKdh0xzo3r6q3YpkrxL40odCbYs/P+TdS1ouQzxBv4RfsyGlu7M8zbkUZpaTAolnrfczzl3RuiVPhWZ4215f6ixXpmh5VPGWJooEU9jo2YilBFAplGxlVyDTW7G1eUJ/LIgZcRA==
X-Gm-Message-State: AOJu0YyVbihSch/NjlbHu39Psee2Rm4RHwvmhNuU8C6hiD3oyHobzEvr
	lkuX+AwEBV9AnHZfY4+pL9W+INapsdKRWIYFMpM6K4nECeC86QsX
X-Google-Smtp-Source: AGHT+IEZepgeDkUT9RDJvALOKsdiZXgwdG6lSfCTNXsWgnFPt2uDjmBS4/7sgyCrveGYIUTBsjSkzw==
X-Received: by 2002:a17:902:9a4b:b0:1db:f952:eebf with SMTP id x11-20020a1709029a4b00b001dbf952eebfmr7108683plv.44.1708998458872;
        Mon, 26 Feb 2024 17:47:38 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e381-af24-f369-7cbc-56bf-1d54.emome-ip6.hinet.net. [2001:b400:e381:af24:f369:7cbc:56bf:1d54])
        by smtp.gmail.com with ESMTPSA id kl14-20020a170903074e00b001db4b3769f6sm318893plb.280.2024.02.26.17.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 17:47:38 -0800 (PST)
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
Subject: [PATCH v4 05/10] ARM: dts: aspeed: Harma: Add spi-gpio
Date: Tue, 27 Feb 2024 09:47:14 +0800
Message-Id: <20240227014719.3037588-6-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240227014719.3037588-1-peteryin.openbmc@gmail.com>
References: <20240227014719.3037588-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add spi-gpio for tpm device.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 36aad01dda20..ca3052cce0e0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -28,6 +28,8 @@ aliases {
 		i2c29 = &imux29;
 		i2c30 = &imux30;
 		i2c31 = &imux31;
+
+		spi1 = &spi_gpio;
 	};
 
 	chosen {
@@ -67,6 +69,25 @@ led-2 {
 			gpios = <&gpio0 124 GPIO_ACTIVE_HIGH>;
 		};
 	};
+
+	spi_gpio: spi-gpio {
+		status = "okay";
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-sck = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
+
+		tpmdev@0 {
+			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
+	};
 };
 
 // HOST BIOS Debug
-- 
2.25.1



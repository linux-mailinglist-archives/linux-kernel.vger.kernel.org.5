Return-Path: <linux-kernel+bounces-47147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0188449D5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFDDB1C23747
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC9C39FF1;
	Wed, 31 Jan 2024 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHXU6wzP"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E384639ADD;
	Wed, 31 Jan 2024 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735820; cv=none; b=Yrp2n6ocdRuOr31iVSxSK17LmXWRolVRBD6kNkxJl7+3YN5O3XdNSHw9NCYy2ulJRoa/9zrVuqHOVwrkLeAcfOY6b2XlAYokEJPf0GT4tkFDXsW+oog6h+HRcgzEhBYLCcvthnb8roHeoUCUXEzj8Q6hdJY3aNNuAfRx8ETjMbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735820; c=relaxed/simple;
	bh=Br7cvUmV1n/kCg8DCyT+jp1U0pFs6MzAm6mRSIHrVlI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tqERfycNSOewciNBUHwXMpV2qdSr933GejGOMdvKcD24202WczMYupG776/HuS3f/rwPJZfBaYdui5426lzxQ4Nn947iQJauplaVG4/Rd4drDzqN490JtaL2r1PjTNyWZvXvPcReAZSa4gtLACtiyVJy/ScKU+quv69vguTjorw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHXU6wzP; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3566c0309fso21412966b.1;
        Wed, 31 Jan 2024 13:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706735817; x=1707340617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aIvaypLdP0+JFHDzqqa1D+EbFHtABYPWV2c8Aa5Q328=;
        b=CHXU6wzPcCB60XEW6rt757fVWhbGqbvzgNy5Ps1rzHPKno0ii2CXTCo0reJ8abwD+L
         5hyKIuFdy/OQp852n9dXBlyqMD1jb/xzPz5O1EvdT9YHhaHx6AjR1j9E/fnh0jTDRwuI
         M7ows883UP1uPnFYKWDtwrWG8GYXplecYzJYscnw0Q9IOhZ7d1yQPSMsYlmJRRrZhUfI
         zkOHgXaTRQzpPZnuDfVNOHPBaObT2XTtoJfblsEO6gLUUQdou2RD0I5dZGRS6FVygz5y
         87RtFV2dXw2l3ayAIP0p9jm8Xn6nNY+naPE3BbLaWTGaz2g0DiHAWW2N1MKmRGaLA8f/
         x+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706735817; x=1707340617;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aIvaypLdP0+JFHDzqqa1D+EbFHtABYPWV2c8Aa5Q328=;
        b=Hy8ElflHUkdo0CIgigrYgkP/E3PQ0WvFzy+QQrmu/GtdmxoVOcEH0Etntrt++WE7nc
         GvmZet+mN1pltDa/xQoGM4sBkOTxt8YakQOFflVXlqz3NzwEWLd98MtHQBDsaYYpXK/G
         l1mNsDv0tFsnJVsXUyUvsVybvvKFJl7nEX5x7ATUy6ypt49KRbXuROp0ckcqAFpohjoC
         NQs2gM2jbAZq2M4mMfPIGLHWpDvI7VTIOxY2T8bp24ihDJHsPIdl07FoagqpaR7mWDBk
         96wvoWcA+to22jmnr5o/CD7mAzZHkyzTLdTrpPIxE3Wn5PWcpPaLAPoX+fgRmounDELU
         lmNg==
X-Gm-Message-State: AOJu0YzKoeay901kbkT+pmO3v0KSo1PBUMxBUBZ3hiWaUDysg+NxC24W
	03Gy87iE9pjCtxxVAIWqHnEU/wwgNddP6PRoEJvPaEdR0BL1xBy+
X-Google-Smtp-Source: AGHT+IHnO3WBh/+ajC4q+i/16gR61Amb9UqtxVbpXreKVzkmjEyKKcJdnZqL0gzfWAOgay1EoAzL9g==
X-Received: by 2002:a17:906:2495:b0:a35:854f:6c9e with SMTP id e21-20020a170906249500b00a35854f6c9emr2058734ejb.51.1706735816769;
        Wed, 31 Jan 2024 13:16:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX6h2Y8J63c7oNmYUJeFHimF+GcNPtlF6WODVlXW+KZ6iCTqVqg0D51fEnFrd9PaRhjVZMpNJaOy2701csFyW8y0S+7/CgZBrNgtpfQ5QMjH5TCCL+CxYGKm0eb62yd17kMdsgnrikdnrrQ7RN0yHC054sAoinbOGzJF/OcbhhEuazViV8Ch9fuHX2KPrdDMQdFmjZfAmcSflVDCUlvyrRV3twI0NTdA6G1uWr/5leHTYx9r3g1pPt8BFAebYLJa9y7YjM4/xqD0AAYwvNpx6x8M6n/re4liSV00Nlsi0Zp8LD1igj6fwWiQubUZ8Bg9Y36dxHYP7Xhp5tHJ2r/3QiJhvIk0g8X73VF2vo/P4MXc74X9IFsLXUf8l0kZINM9D7h07ERqXfY6XQ2Aam1FLixptd7AWHwy0L1F7EC2RrZHxP9Lim31uAmBKQVfqqGbOwZXAxBXqfyQgm9wDKqTALAY2aoWzm3oDK3Y8hw+kPSawpNA8hlxVrMCOcp7FIoj1ZP3t1Y/b2jVCANP7gkha8y76qXMxX4XBnH5El/McGwAP3l8LDmvzdXLRqSpntlGyJUQvnlYt5i+Ht340o=
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id ty5-20020a170907c70500b00a35a8571419sm4040634ejc.135.2024.01.31.13.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 13:16:56 -0800 (PST)
Message-ID: <9b84adf0-9312-47fd-becc-cadd06941f70@gmail.com>
Date: Wed, 31 Jan 2024 22:16:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 4/6] ARM: dts: rockchip: fix rk322x hdmi ports node
To: robh+dt@kernel.org
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 mripard@kernel.org, markyao0591@gmail.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <a493c65e-7cf9-455f-95d5-8c98cad35710@gmail.com>
Content-Language: en-US
In-Reply-To: <a493c65e-7cf9-455f-95d5-8c98cad35710@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Fix rk322x hdmi ports node so that it matches the
rockchip,dw-hdmi.yaml binding.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V2:
  keep reg-io-width together with reg
---
 arch/arm/boot/dts/rockchip/rk322x.dtsi | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip/rk322x.dtsi b/arch/arm/boot/dts/rockchip/rk322x.dtsi
index 831561fc1814..96421355c274 100644
--- a/arch/arm/boot/dts/rockchip/rk322x.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk322x.dtsi
@@ -736,14 +736,20 @@ hdmi: hdmi@200a0000 {
 		status = "disabled";

 		ports {
-			hdmi_in: port {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				hdmi_in_vop: endpoint@0 {
-					reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hdmi_in: port@0 {
+				reg = <0>;
+
+				hdmi_in_vop: endpoint {
 					remote-endpoint = <&vop_out_hdmi>;
 				};
 			};
+
+			hdmi_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};

--
2.39.2



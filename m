Return-Path: <linux-kernel+bounces-142382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A428A2AEF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02DF282598
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909BA57322;
	Fri, 12 Apr 2024 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuajhPRD"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ED8524B8;
	Fri, 12 Apr 2024 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913515; cv=none; b=TY0iLMabfelVXDcQg8aQdGF4hqFlUAQv2DscWoUCno7kl2r9UMkspPs8J3GbESZX20Ad5zGL5duKk6awrlKorZwZP+aDqD8JSuEvdKZsJLZZSDFuv0dgEWVgVTL5E6FfUBn+tv0/SXmWhdVL/kNwdxQYuRhZ0oM78dHh9OnmdR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913515; c=relaxed/simple;
	bh=U5N9M5tPmYDaX0WOpmxpp/zH57wsz4SXr5eYc5QbVjA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vz5sYGPDuR3lH5qTMoswPxv+eX3eCohZ7UnBlw9RdUmMVkz6ozZHIY0MPw6z+hI1ICJjv8Lv849gxEBIZ8TkkKZLFKR+F9PljwRkQ9NBF8XLBpo9JEiorHKDx8Oq6ikOO8gdOmD4OtcO8jPxShgaEmMvR8hO5GldSFCEQ7NyJIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuajhPRD; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5aa1fe2ad39so486459eaf.2;
        Fri, 12 Apr 2024 02:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712913514; x=1713518314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SbzylmHYr/j6rcbPvQmFegZHyso6L6GQACssFL429cI=;
        b=fuajhPRDHP3NyAPU1nbcdGhoKwHGsFPDS16cOKcU/koCks8InVEWFOIlZnJhyJEpnx
         zOb2Pi1L2srK7jlc2K+bY2Fbw55A0z4msvTOFyRZqRkOU2sVYhI7Rtkxdi4ypziuC7GO
         kwd1xkevc1H6DQxPqR+lGHxVWf2vosKluuqfylbiaoUAfpypip3viXHdYXSLPKM6xeUq
         ayYXFHaoYabYd8IOPKA4veT71hkp8L3SKwYEx1xHhv00N4oVcsUp8baHfsAjfv68VqZO
         RrfNWTC1xc9CBqJhY6C0iwPjZt+i/voqMI8Jl1CR1u63elJPluFfMSA51FjP/Vpjzd4n
         3b0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712913514; x=1713518314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbzylmHYr/j6rcbPvQmFegZHyso6L6GQACssFL429cI=;
        b=nRB+9NKnOXyBlK3FfUDKrYBH5yOFJRN35MHO6R+rRE44bIUteTH0U+/KZyC6v0uIpC
         qm6nS647jCyWBKiUkMjRddDyHDbygjG6h0MKY4mkW7ZotzqKkdIlFHi+yBLAvYPoX7L2
         M28TVqdJhGHmkta5Y1KYcLm5VTQNfuveeXboBSJySwSg5bDLYoywd3H1Qup2WEbnWLQb
         1tzrUY1Ww0Sy6qTrViHT7gp3l/6hGxlBG1DlR6n6o43Izxk/DchnLufvQt8JOq6khqrH
         U/PRqR4+OoK7Dfc1HiUw3XvVzpODQSiUI55crZ6SfcmtFpzEaVetPnYbBTrRACUw7dUP
         HEew==
X-Forwarded-Encrypted: i=1; AJvYcCU18/Wh0JJuw3TuN4U1PRS2PfuZ4qsoPX+ncd4GQLsveuAOlQCZW/rfVkDHPJm/BjcRRcPcvZy0eSiCahkl0yeMJpu0t4UB/nYSFdUCoDqODe7xssZby7J6ugPk1SKl/h4HgNKcxseQ9A==
X-Gm-Message-State: AOJu0Yx6rSKX1vMsQ5KJadJbno4gQYBO/IKQqvyr0vTN535Kkqlj3RVB
	1iqc7yCTtXxQgZPBijBKCkkLyrMaByt/nqdsFEd7eIjf2cl/siU9
X-Google-Smtp-Source: AGHT+IFWGE2vq47FAJJHlYYA8HHa90TSGrKT67/8QPdfpzKIGVVQrsZP918bQFRgm9c5uYKokTBswQ==
X-Received: by 2002:a05:6358:9814:b0:186:1d2a:a457 with SMTP id y20-20020a056358981400b001861d2aa457mr2258466rwa.15.1712913513786;
        Fri, 12 Apr 2024 02:18:33 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id b25-20020a63a119000000b005e840ad9aaesm2332711pgf.30.2024.04.12.02.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:18:33 -0700 (PDT)
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
Subject: [PATCH v5 11/12] ARM: dts: aspeed: Harma: Add retimer device
Date: Fri, 12 Apr 2024 17:15:59 +0800
Message-Id: <20240412091600.2534693-12-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412091600.2534693-1-peteryin.openbmc@gmail.com>
References: <20240412091600.2534693-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pt5161l device in i2c bus12 and bus21.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 530f69005857..a5abb16e5d8b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -250,6 +250,10 @@ imux21: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+			retimer@24 {
+				compatible = "asteralabs,pt5161l";
+				reg = <0x24>;
+			};
 		};
 	};
 };
@@ -370,6 +374,10 @@ &i2c11 {
 
 &i2c12 {
 	status = "okay";
+	retimer@24 {
+		compatible = "asteralabs,pt5161l";
+		reg = <0x24>;
+	};
 };
 
 &i2c13 {
-- 
2.25.1



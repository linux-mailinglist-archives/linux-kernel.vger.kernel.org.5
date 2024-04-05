Return-Path: <linux-kernel+bounces-133028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46835899DB2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AAD7B24B46
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AFD16D327;
	Fri,  5 Apr 2024 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjBb9AAI"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C4F16ABFA;
	Fri,  5 Apr 2024 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321830; cv=none; b=aKx8vQcMatzT5QL5k3dLjvN9PMrGhXOQ6FVkd2HkptZ5K2SoXQKT2PfRft53n6l+/1dMwX2UhPFsRv9Kavp455PttOvpRQ5ctf5ZjHisikHj6JKiEbGNK62jf7QvGJupaD+LxITfYlC/aZlS9+YnFDAaIp/pSB6BAL0tUbaj3O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321830; c=relaxed/simple;
	bh=2aa68crBu/KDHO4yjInjYQzDEOU7K6uugXiJZ1PLqUs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZyMC32hpSCzNrBorYah7tBp8tMroVuCHBzBo98aIcoNHT2oDwuLK3VcUPyQEL4a3G5gBTISnkljWfiMnNYqI70lEOjCWODq3pTMR59Ip5JkYdKXDDbZKZs8fCtIEpnS5zmFojEVeZ/712g4ujHHPb+yDDy75UvT+Su51S2KhWUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjBb9AAI; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56df87057bbso2308145a12.3;
        Fri, 05 Apr 2024 05:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712321827; x=1712926627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sBxhYOUHGPOJj+Oh+TP9e12XKFk5G9K5xOSnQRpIOaQ=;
        b=AjBb9AAI5gpa7RQVDO0xap+m4GUsA0kE39IEbNmqmvNIJ/PBNo4GVEzOIA4BwdWmOp
         HeIJz4qUOa6iyBs6D/yupoG2b/W3a3RHQI6llNmSyFI6iz2uRXG5vvy4W469RzGXt0Bc
         JuG3QkcSLtk7wlyLQomn2O75jsgUmDzZX5mv/RUEy3MEnXRAhRkuiDT6p0FdrY3VeVlP
         BFDae0q8cWury0K3JLZKZv/Dx+PcGYqJy9rRZSDfl8ZKROYXMAH6qlcFgeyDnTjnBbWx
         kTskVvwpE+1fDkDvs1eayJCu/Hz7pxjEqmQQDWW+5/RQ/9kB3RWFrhxYDxISTFvlaXEE
         7BXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712321827; x=1712926627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sBxhYOUHGPOJj+Oh+TP9e12XKFk5G9K5xOSnQRpIOaQ=;
        b=lOgj1C35de0RgADckyD0tydkhqaeZnarhjbeToui7JxN4Qw4JpPIE8YNEE3aGboiMF
         d+9PboPLyM1reZcMxA1I3cbEcudIJWgHtzpIM9Ben68dil/0phuvpzfdgAHFunXVvE/t
         nYylT8I7BEv0DXuQp37SFSzDp8jl6UWNuoQo2jyuV/d0+2eTXrGHlbeSZe+U+A2GrORf
         FyEl1NIRMGnro5T7bS0TOrnZrR8Zw2pC4X5bCuSfIeD4fJAQ42EZMyK6Quz1Zbnqgu51
         0euOz/UFtMw7cChW5N9iCQG9iBREzIqwjYTKw7mtSSglcqolTINke/xa4PDQg2aqJp2q
         pamw==
X-Forwarded-Encrypted: i=1; AJvYcCXpVtxOiLRCclQoW2V2QGPO7cReHYMJja21x2EHfST2XBX5tjNAz5C2ywDpEZHWfRhRNKZR3NIoWjOmiPMHr/UPWMH/tF8wIn0sIB5W
X-Gm-Message-State: AOJu0YxNWSzl+1gMCyEUqhB26Imo1BkyUy0Xe5dcoeHgoBRx2ss/qw3t
	9LICTyHHQBdfZg90eALP3fDUGwkfKts9l8JVZ6qiXdepyLPt7wqn
X-Google-Smtp-Source: AGHT+IFc5l6DlZCGShlDoeRFkkj3e62fh6QH3sDCWl+DprBkJYLzp6MOvPOCFDgePSdbeqntlQrQcQ==
X-Received: by 2002:a17:906:2c5a:b0:a4e:233b:e470 with SMTP id f26-20020a1709062c5a00b00a4e233be470mr1019105ejh.53.1712321827037;
        Fri, 05 Apr 2024 05:57:07 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id gx5-20020a1709068a4500b00a4e579ce949sm812121ejc.51.2024.04.05.05.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 05:57:06 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] arm64: dts: mediatek: mt7988: add PWM controller
Date: Fri,  5 Apr 2024 14:55:48 +0200
Message-Id: <20240405125549.11972-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

MT7988 has on-SoC controller that can control up to 8 PWM interfaces.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 3eb5396dea22..27098f724b7a 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -105,6 +105,25 @@ clock-controller@1001e000 {
 			#clock-cells = <1>;
 		};
 
+		pwm@10048000 {
+			compatible = "mediatek,mt7988-pwm";
+			reg = <0 0x10048000 0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_66M_PWM_BCK>,
+				 <&infracfg CLK_INFRA_66M_PWM_HCK>,
+				 <&infracfg CLK_INFRA_66M_PWM_CK1>,
+				 <&infracfg CLK_INFRA_66M_PWM_CK2>,
+				 <&infracfg CLK_INFRA_66M_PWM_CK3>,
+				 <&infracfg CLK_INFRA_66M_PWM_CK4>,
+				 <&infracfg CLK_INFRA_66M_PWM_CK5>,
+				 <&infracfg CLK_INFRA_66M_PWM_CK6>,
+				 <&infracfg CLK_INFRA_66M_PWM_CK7>,
+				 <&infracfg CLK_INFRA_66M_PWM_CK8>;
+			clock-names = "top", "main", "pwm1", "pwm2", "pwm3",
+				      "pwm4", "pwm5", "pwm6", "pwm7", "pwm8";
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
 		usb@11190000 {
 			compatible = "mediatek,mt7988-xhci", "mediatek,mtk-xhci";
 			reg = <0 0x11190000 0 0x2e00>,
-- 
2.35.3



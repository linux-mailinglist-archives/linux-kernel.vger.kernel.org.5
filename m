Return-Path: <linux-kernel+bounces-62996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 730808528A7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA5F284877
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011F9134C0;
	Tue, 13 Feb 2024 06:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3glaTYJ"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983F5134A1;
	Tue, 13 Feb 2024 06:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707804910; cv=none; b=sb6/g5egS/HEkZuMDJ4CYiYIP/KLofmZFe5g1nYr/nrMJe1pJLcWcj/34bSOaaYfjbolMfGhHA8QHAm+i0eoRyIM5sAASW+G4JkICGeJs3ePIYP/gN5nADWUsFKHyd3yijEYBlGrM2Q4cWlP9lSP5wFiac2ORvp4WFoK7YCIwBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707804910; c=relaxed/simple;
	bh=W+XnatEuWjY55uYnIcTVImixNZpiX7TXUq4AWRF7L2U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NQbc8WA5yClp8ThEa0ljOkYCaE75pg19K92uL9YVxrTnhAg7qinaRYMIQxVHNeB54Vm+XfDC86uc1oD5Xt7NJymnGmW3qvaraelGFxVp1o6HWNGC1gTzKRgDJ404tML0giOD2IhKdQO93imLbC1SV3dxV/kI/dJild8tlxbJ+QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3glaTYJ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3832ef7726so457100066b.0;
        Mon, 12 Feb 2024 22:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707804907; x=1708409707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xU96ytnGGcxSAcqxvNbh0M7/JHhcz9bM8B0eaNoETfA=;
        b=e3glaTYJp4d2Iil+rTo7RgluBNMABrj0kjOgdOBGhk3D5ECaCVUkyMHc+9inrbBpU2
         NxchzjnzbIdI4dLWJQxF3MsIOwvkrRakh98ZWdm3sgBcmIwFgmEYv4mfFSfZITPuHqyj
         wY7WKtDwCq/U0Qac5dKjfKmw8FM5DrUBChWmQ1S/DGZARTu5gi+LZtUspOy632t6h9Zb
         +qy3a6CvzGjRF2L8Ck2pMNvyH/MOOSHcwPN7YUchuH6xWZwC/POQjrNJJhzYwyAHJFjt
         1PcXv+gp7IHnTou2wlrKa9sxhSzi9Yg/axs70Rcckc/CyLQMHBFHyaaNDSJCu+4oGeCw
         Ltyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707804907; x=1708409707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xU96ytnGGcxSAcqxvNbh0M7/JHhcz9bM8B0eaNoETfA=;
        b=wyjItYuAycZEfR+GoLMY27NAkcx7zv0MqKAhR/oLtsINXGQnHSVqq9da2+wu39qUL7
         Th6uhMeYs2eNctEP1vq/PDn1RxlI+d2WfYbt8g1yaDEHaY6OxbYJ3A56eDWDlEy14Ush
         PcZfrArJWOKDYgQAdOLMXcV9Dl4pZQLaeR0CB/tucLCIe5Q8+objjehas7AL0nT1IQf9
         Q0xz/HgxiHVew0V83RcmaPyhfQNDigeO/JJwuwUULwqiGvmluoDJEJdSiVZpYx0muZdB
         2IpHiH1qeM25SaiVSglNmR9p+7svfEPmYWeZEtbvMpIhyvTkvDW9ggb7jl0DnMnroJUT
         TqEg==
X-Forwarded-Encrypted: i=1; AJvYcCV2NuojaBf8O3xhXW7Nmsaf0QSVsA6aXAeZ5DHRm7LYrdyCqWxl2V/QEYOvlDJQcspLG8xtgpT1AAUvjAM2TJmshKJUCKQT0zZP18aQAua3I0EfJV0ou1pIK77UTmbQytzEUdaCOC2rLA==
X-Gm-Message-State: AOJu0YwveEqUMP+BFbET65A0XlYeUMBDTWLoRrtIeunymyPwPuVORduw
	19mFbmatNbEcJYMQavlYILfeq9WZt8izFVgXyME2BaFjTdk6Jh8q
X-Google-Smtp-Source: AGHT+IFzSg0OICApgiUNwb4wnigBaoMrIrGDV77w26PaubZJj3Ppm2rFAgElGTRB+vEGLfTc3Y/z5w==
X-Received: by 2002:a17:906:cf86:b0:a28:d1f9:976 with SMTP id um6-20020a170906cf8600b00a28d1f90976mr5110872ejb.65.1707804906663;
        Mon, 12 Feb 2024 22:15:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXA0GOg4AbFYK+3P17jrNUNemuktljTy4SPxvPykPgsseH74kIius1m5cEmLlM9ilsehaRtioqzrXyzv/WAZrNkyBJ+IiQMD6wdrYRQCdWyxJWXB7cCxmtfSRlHLFUMDhT3zdOzP/kLbI/MiJR0WmVM+SdB225+UzC775dZPjttNYjCzylKu8N9jWXnHqgO2xLpncu+wf7hZWa8REiTC85FcDj0FUMySEE+VH+HXEmIY+HO0ykNxOXP7wjLDKt8ZQymypghJiPM1JWlyiiNmPkRvAta3+SXLi2WhNIbH8Ycvu1YeMF9BddVWrIL652YmL6NvipWmFykdgbeaoem8e0jYAlc0R75uhM4TNLJVj8ssLSP9RxfArfgOkG5pGH7sAj7ycMLtEQ7D0jvpqCygfGtUYrsLUw/Kc06BinSu7z5NpSsDvwq/zmnJ3BJhK36cA==
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b00a3cf243de37sm508679ejc.111.2024.02.12.22.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 22:15:06 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] arm64: dts: mediatek: mt7986: prefix BPI-R3 cooling maps with "map-"
Date: Tue, 13 Feb 2024 07:14:59 +0100
Message-Id: <20240213061459.17917-1-zajec5@gmail.com>
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

This fixes:
arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtb: thermal-zones: cpu-thermal:cooling-maps: 'cpu-active-high', 'cpu-active-low', 'cpu-active-med' do not match any of the regexes: '^map[-a-zA-Z0-9]*$', 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#

Fixes: c26f779a2295 ("arm64: dts: mt7986: add pwm-fan and cooling-maps to BPI-R3 dts")
Cc: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
index e04b1c0c0ebb..ed79ad1ae871 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
@@ -146,19 +146,19 @@ sfp2: sfp-2 {
 
 &cpu_thermal {
 	cooling-maps {
-		cpu-active-high {
+		map-cpu-active-high {
 			/* active: set fan to cooling level 2 */
 			cooling-device = <&fan 2 2>;
 			trip = <&cpu_trip_active_high>;
 		};
 
-		cpu-active-med {
+		map-cpu-active-med {
 			/* active: set fan to cooling level 1 */
 			cooling-device = <&fan 1 1>;
 			trip = <&cpu_trip_active_med>;
 		};
 
-		cpu-active-low {
+		map-cpu-active-low {
 			/* active: set fan to cooling level 0 */
 			cooling-device = <&fan 0 0>;
 			trip = <&cpu_trip_active_low>;
-- 
2.35.3



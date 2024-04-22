Return-Path: <linux-kernel+bounces-154054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6138AD6A6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A54E1C21B81
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C271CD31;
	Mon, 22 Apr 2024 21:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Urze3OKx"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577B01CD2E;
	Mon, 22 Apr 2024 21:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821439; cv=none; b=uClKGXYe1EeQthFbRLcIj+em3mivIbqzJImNk1ahVuJ65X+wK4iCYFuvheeoEdk7CQ4eIBGkk6Do2Jybei7va4Ycn+LwJPxqbDU0bSPTmB9hoKfqyNWvtXkkFBh5NiziVtCacKh8W1GFpEX9OXCtz0F8pHK9sDZsaXJrNSv2wSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821439; c=relaxed/simple;
	bh=CBLJuUETsWw8FSa0Cty22OcASFws3i4mNlLYGA8cr64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f03RGtIYDirVRC4SwGyR+Pi3EoSlR09amtOxf/m+YrB9VWrIIqVQhroonaSmPQKAwugOWdNIu5IsDt1WMY6PYyfEbPeiE7//NpiTstgGzCPmVrJoirYC41bjw3sHFi8/uOsvdnhrihbH/fzbnihBDuwWtNt9xExMMKtOnWExk8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Urze3OKx; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34b3374ae22so1089902f8f.0;
        Mon, 22 Apr 2024 14:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713821436; x=1714426236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WI2kxejj/vZx2lacDeJs1j/DLADfz9B0iXyyCxEB4+4=;
        b=Urze3OKxgUM0eJ4VKTlItGBpHiVzkHNXy2pkmtKzHEfQsTETm5UUTLbQjLTlvwiHja
         HYvJtZHx9ou1NFQj7BsJrTyDOywegDZ7ueH2G9ShsiyYWJXiIPhX/1YtWdFCPNZ4xwcH
         WF6d/i1EPm7rLhxFF0CnrO4vinvy6cPdNish2gIRIQfjH67gDJJmwGqB2BDlnfh/oNcF
         58mR9XLQYTA2nSQI0wEmt3zymJebjTgw79osC/y+k5wCcRzGTFz+rpH3jYGQ9AAwuQ6A
         mHNuYX32nS5lIHgjIvV3KfTH8pePanP4eYymeuv4ZUPIbpVHtZKnhcLQA1BwRBPux0ET
         HHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713821436; x=1714426236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WI2kxejj/vZx2lacDeJs1j/DLADfz9B0iXyyCxEB4+4=;
        b=ZqoF7xmdr6QJEoehDgHFCPlaWmMzcplc1tY8M84NusNWh8UPaHzcDQ1vkcuwBNiUS2
         GN3VtsXl8Wim6AfaxvTzIT3I9MPNdsaZ0MC06r8HfPOCEV9XXMTNzm2Au2srOrOUhdFr
         F+aGJvLazzpGdBw0L1ofw/SpvEHBaXfKT+8cXDgRGMuv4SSkSY2j2QLL8V+2WOTCcpFf
         6Wqq5VGsiQ/TFi/uA3lkjwqVHocja7oaiXugcmMGXISLJQggdvG7QFrzJq0VVcTUttp5
         RPdQwApj7KlSBuplJ0p/37B6fdOxHTNYNZtUxbO+GLKUCSg4gGCg9R8c2f2O941As+2Y
         Ar0g==
X-Forwarded-Encrypted: i=1; AJvYcCVH99Np9rDj1Jf4RcchviEGIUhrSEPIezSXIyU42YbTh7w+GaaNfNXtQJfeNtzBMsq/qEXS7+lSACx+mPWW0t038teLAaifvGR0acM7RtTYbipk6xYSiB4V3UxMgncfcmRU2cC2tVENpEtBUf1SrYYhJYfRlOcmTHLzWGMK6LWsCeXW3OOy1PjQkpc=
X-Gm-Message-State: AOJu0Ywk+lTsbt/0DI5JBLbfvSjEN/asW8TEZKUl9vOFAJj2uo4jrxci
	Hbwv8jqwn7RBTBWiaOJTbgexwiZPz0+GUZUugM2M5biFxTFQDK+o
X-Google-Smtp-Source: AGHT+IF1Cm/7lGCzNYr2bL6mfKpqkomAz337gb0HuPFVo4Gw1A3Qk2lrHL4UjNSxUjQJvEluEnBRgw==
X-Received: by 2002:adf:e542:0:b0:349:fa94:ef18 with SMTP id z2-20020adfe542000000b00349fa94ef18mr9517047wrm.50.1713821435333;
        Mon, 22 Apr 2024 14:30:35 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:ab0d:124:447c:bf37])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4844000000b00349f098f4a6sm12886793wrs.53.2024.04.22.14.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 14:30:34 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 4/6] arm64: dts: renesas: r9a09g011: Update fallback string for SDHI nodes
Date: Mon, 22 Apr 2024 22:30:04 +0100
Message-Id: <20240422213006.505576-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422213006.505576-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240422213006.505576-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Use 'renesas,rzg2l-sdhi' as a fallback string for SDHI nodes, where
hs400_disabled and fixed_addr_mode quirks are applied.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
index 50ed66d42a24..e008236c3d2d 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
@@ -71,7 +71,7 @@ gic: interrupt-controller@82010000 {
 
 		sdhi0: mmc@85000000 {
 			compatible = "renesas,sdhi-r9a09g011",
-				     "renesas,rcar-gen3-sdhi";
+				     "renesas,rzg2l-sdhi";
 			reg = <0x0 0x85000000 0 0x2000>;
 			interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
@@ -87,7 +87,7 @@ sdhi0: mmc@85000000 {
 
 		sdhi1: mmc@85010000  {
 			compatible = "renesas,sdhi-r9a09g011",
-				     "renesas,rcar-gen3-sdhi";
+				     "renesas,rzg2l-sdhi";
 			reg = <0x0 0x85010000 0 0x2000>;
 			interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
@@ -103,7 +103,7 @@ sdhi1: mmc@85010000  {
 
 		emmc: mmc@85020000  {
 			compatible = "renesas,sdhi-r9a09g011",
-				     "renesas,rcar-gen3-sdhi";
+				     "renesas,rzg2l-sdhi";
 			reg = <0x0 0x85020000 0 0x2000>;
 			interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1



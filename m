Return-Path: <linux-kernel+bounces-60782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C3585095B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 14:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795BC1F2241C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0085A7B4;
	Sun, 11 Feb 2024 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNVmcJYw"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762C738DD7;
	Sun, 11 Feb 2024 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707657100; cv=none; b=Gy1w8ebEJoV2Q6OiugzpVFwoLDlr2qC5m4yhHjrQ7kbsBd58r6IU3GXlFo0JPxwEq3iWzYDXcwe2jiG5v9nQ7Rtm3YEI1zmZ8JsfokS+oAqY2jthxIL62jbdTej0NlMtvkvyMafdx0/29K+okiB3I9NNEsXKu7pk5rguIP7QVSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707657100; c=relaxed/simple;
	bh=fCDuVgqCUvqlIrOjmEXXJ0TGU1IxFf6PxN/vyeW9r+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5aaSu9ACeu5Y9QqA/pQvDPJLB3kEvVa6zYyCrakUU1RRuMX5FLzI37l3qt9f5v3WRtod7pKcCmuyn4q3mIR22xH6pvY5YcaG9+6gdklvOthN8/VX9f/MiA+nMK7yENnXibH9p+nEkYWSAx/T3F0xcmf/wcsas+NdS2LJbPGd2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNVmcJYw; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c033809f4bso449155b6e.2;
        Sun, 11 Feb 2024 05:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707657098; x=1708261898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+17TsaGlRQebnvLJ9MaJhhv70bTJInAT673gmNoVyOQ=;
        b=jNVmcJYwWS7W8i8t9yKjArCsEre9ZEVCcubeyBNfA6JSZTfxlQH8+YKLkjEqM+hBRw
         S45R/GXA2mk1U7+1P/saZEJzW9nC7sI4V3QY5KP7eOMg8jY9XTDqCb6P828fBEN5Hrjs
         /lOwCGFEq04suxPuH6ur2RTZUzC9Z9xeLCx50IR2Cm1fsYq6yBuJbN/HTf01FjhSalEL
         Z3rgjn5SGp7u0H1MQhAj99B/0dqDZun2qNy9Up2R//rB9YbvU7Gs2WZUYo8JsKIQ6j5W
         Xyi0h8Y4QLWbX/z0yyDbxwI15Sop+GIXf67WyenF/9J4PL/w3QxAtT/7VBdBioySpwjJ
         Po0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707657098; x=1708261898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+17TsaGlRQebnvLJ9MaJhhv70bTJInAT673gmNoVyOQ=;
        b=kH+dsAPU/GahyDXTOy+SD3O0YS3NYhYWg+LOXdUQR5tFes/Nd7C+4XWholUVfAeRuA
         zsyINbTby77J3fLES+by5HmCJlSzJ/LdhrJJ7vrTHKKGPRJJizoTyAwSMkp/AMnancK+
         kc0aVFNCNshUIUm1jIELIK3MYLnoPv1X+r6EN3YX5P5TOEX6dXrpeH7USKlzBMPT1+8X
         tcShfiU64qMjrcsLuMO1qoNKl306qCKiwO7xXJCLi+3xgig3G8uc6HTkWuJdwpaQVo9n
         fMoc5dYUb0MESa3SkjKAYYtxZWBxi/aEJb8Wxj5ZS6eVBREElqiJcM0Dhxfui2sgGO77
         8Wuw==
X-Gm-Message-State: AOJu0YwZGLhgtqk+sKJ8wJLnZnK7mvVBhfNG/yL5S3/zo1MNbXWOohJW
	5ijHNHO+pvbV9OVMjiseyQiTOCZE976dIWzUklTlGDhjWyLJH/BM
X-Google-Smtp-Source: AGHT+IENrMSJhintAcPuTeTvdM3p0AC8ilBsVSzyuIx33BIphupAyNSh9yOhvKTl1x5PKMeAe2JxdQ==
X-Received: by 2002:a05:6808:1642:b0:3bf:e37a:9250 with SMTP id az2-20020a056808164200b003bfe37a9250mr5196233oib.18.1707657098353;
        Sun, 11 Feb 2024 05:11:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUR+uwdHbmGR5T1LnH/0moQujAWWG+E1TJQBV0M5GUeMyPSKmLZUHmmlVrDySRc2OdiNDMGtlxeYQToI1jSKAC5MV3vkHHu41Bv2cLwG0BmHifI9i2pyMTYd8Vn9ElvMAlmcGsX15H8UU0H2QxqUNQnFZHnqo7GXEiqLfz0E1+fRDLhzT64VMSDqZdGEAz+/PFqqW8f7UDulXgw7RUHLmHQF3IpMXYG1QxBF4MBr9j4/7E9u7dqJB+YB9Z8TQ2Umef/BvHYNp8ztxijgxYP8886MPszLGqypKHOlraxv4HQKq8PesywwYIeOsM5+Y+Pjp6MqkxB5wfJb4aMxqNpD5kwVvx5hSlkZb0Ruk5sx8pdU7g4z4RniWdltLo2ho9zp8QlX233lXOJQdLt2/W9qQAP
Received: from aford-System-Version.lan ([2601:447:d002:5be:c8c7:5c6f:e011:4867])
        by smtp.gmail.com with ESMTPSA id wg19-20020a05620a569300b0078437ff4870sm1283636qkn.31.2024.02.11.05.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 05:11:37 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mp-beacon: Enable Bluetooth
Date: Sun, 11 Feb 2024 07:11:16 -0600
Message-ID: <20240211131116.66490-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The imx8mp-beacon SOM has wireless chip supporting Wi-Fi and
Bluetooth shared.  The Wi-Fi is already enabled via the SDIO
interface, so enable the Bluetooth via UART1.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
index e5da90804780..2ec282b91c42 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
@@ -206,6 +206,10 @@ &uart1 {
 	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
 	uart-has-rtscts;
 	status = "okay";
+
+	bluetooth {
+		compatible = "nxp,88w8997-bt";
+	};
 };
 
 &usdhc1 {
-- 
2.43.0



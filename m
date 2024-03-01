Return-Path: <linux-kernel+bounces-88115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D40D386DD7D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9001528AB01
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468D06A356;
	Fri,  1 Mar 2024 08:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2CsqFb4"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C0569E19;
	Fri,  1 Mar 2024 08:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282968; cv=none; b=c0AAb59H1QNUkjxxfVZ2P9e6yN6A1D1JxgMzkJjWWATjgkYSR9imVwXotR18a3c0L1ZojersumsITJlyv7Ni6TvLr9H8zngPswCigiC8RQ+afT1Uk/0+3lzACbOtwg+UlZHi3ilt7VitlI/vc77MRrsQqt31rxKUkPAO8adPu3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282968; c=relaxed/simple;
	bh=sa5cuAjIuCMr9whBvtQoxbnmSuWqX7SQt7wgsIpl4yU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mN2U78O1ZQLp16EB0UfuteJoMxkxCr5So9qKECCmbTEAcseguEgqOIBEGfM8lVyYcj8QiU1xDxMwZgCx7wfVUqjt2vjWchdWvO0/MzvzSTmWGaAvGJfzpRL0hWePyGQqanVS5bMJG5MRS3HqF3VyTLvseErHdAWbMKQeG4LWYmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2CsqFb4; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d22b8801b9so22783431fa.0;
        Fri, 01 Mar 2024 00:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709282965; x=1709887765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lV5qcxH5/4YjqlDteGXW3dYnqwkzrKUYN7w24BcH3V0=;
        b=L2CsqFb4iBPw6PsKX9HLgWFvadFIYr5Ey7aF2oBapZFm/GkhI2pYcmMjMfGcsKTFi8
         EtvJBX/NQKKt3zGMButYtTH1tDhD38FhML5GPiMM+DkTrDzp8o+MC/xJXbIUF380fuwd
         dih/LOmVaPwC88shKoJTJZ0ZHaJzez8+/QJtf2L8C6NBGOpV8aCnGE1e63sjchP/ar4l
         NoucXiyBrkGiC+BZahLi/E/wgg3Ae78MiKpT2KLam+4Z8IzSs/Hwgj7qSNrKgqJ9v0mO
         8UJMLChWbLdAOpuCYyww2rZiR3hSiWbn0GNkhv1/DB425XLuh3xVP27PZdbUgV7b3vmR
         HRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709282965; x=1709887765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lV5qcxH5/4YjqlDteGXW3dYnqwkzrKUYN7w24BcH3V0=;
        b=ciej2fi0No2yLBfkID269j6wu1R4AA7LQYjN+rFMJFSi+N5sOa8UL9W/4kWYkh6ilp
         5196E3ZbU3ay2YN5H8K4I9weNMmsDftSDsujccEQJFWAIMzsUOWGkTsjX9AkUGWTt3Bp
         iufYF2aptbpi2OR6dZ3UQ06Up8YqC1foi45gaHx+5/fpAQEux9GanafLbIQTgA0Ep1XI
         uV+JnTONh7KfxABJR5Rbt8mL5wVEZvpzRhOeY9/7dDEg2ajmyP2/ra4pNGmVnojrCzlo
         +3Zz7PMQwCmu9svayKkSo/mOPN+mnNMmRCrZsGAJgMQjUSy9lqGguNE2br3Tbjw3R/B4
         0OSg==
X-Forwarded-Encrypted: i=1; AJvYcCWssY4/YoFutsyQpfvvy1tZYTCSJc7aKzQM4IX4NEKJxvmFkJRR0DZZTtOTv6xt9MZmj8dWN6SU+X1IG/YWhcJ+10GAKqOA8lsn2EBUR1bMWZ72Gzulwd0QC6vi5D4klPkTChTBugES2A==
X-Gm-Message-State: AOJu0YwXg56x11NpYPS8QQxmFTCK6Tr3g9NvKmSQIrF/u1doLZt4BBao
	PvUpzXx+OgRdTKgIieMjd7sZac25wTvE6QPIl5K5fkzdKsqtNoPP
X-Google-Smtp-Source: AGHT+IHGXXytTrhTsGnkO7q2pjFjkuJVLu9xLQpSTmIYKVBSD0fa3FUbmTGUvfPH6iz8OexmjeyKZg==
X-Received: by 2002:a2e:9691:0:b0:2d2:a2bf:4ae6 with SMTP id q17-20020a2e9691000000b002d2a2bf4ae6mr653809lji.31.1709282964717;
        Fri, 01 Mar 2024 00:49:24 -0800 (PST)
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:46fd:a61a:68:ed87])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c028400b00412b10ce488sm4583566wmk.23.2024.03.01.00.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 00:49:24 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	francesco.dolcini@toradex.com,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v1 1/2] arm64: dts: ti: k3-am62-verdin: replace sleep-moci hog with regulator
Date: Fri,  1 Mar 2024 09:49:00 +0100
Message-Id: <20240301084901.16656-2-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240301084901.16656-1-eichest@gmail.com>
References: <20240301084901.16656-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

The Verdin family has a signal called sleep-moci which can be used to
turn off peripherals on the carrier board when the SoM goes into
suspend. So far we have hogged this signal, which means the peripherals
are always on and it is not possible to add peripherals that depend on
the sleep-moci to be on. With this change, we replace the hog with a
regulator so that peripherals can add their own regulators that use the
same gpio. Carrier boards that allow peripherals to be powered off in
suspend can disable this regulator and implement their own regulator to
control the sleep-moci.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 24 ++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index 6a06724b6d16..ba3b3e18a46d 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -122,6 +122,22 @@ reg_1v8_eth: regulator-1v8-eth {
 		vin-supply = <&reg_1v8>;
 	};
 
+	/*
+	 * By default we enable CTRL_SLEEP_MOCI#, this is required to have
+	 * peripherals on the carrier board powered.
+	 * If more granularity or power saving is required this can be disabled
+	 * in the carrier board device tree files.
+	 */
+	reg_force_sleep_moci: regulator-force-sleep-moci {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		/* Verdin CTRL_SLEEP_MOCI# (SODIMM 256) */
+		gpio = <&main_gpio0 31 GPIO_ACTIVE_HIGH>;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-name = "CTRL_SLEEP_MOCI#";
+	};
+
 	/* Verdin SD_1 Power Supply */
 	reg_sdhc1_vmmc: regulator-sdhci1 {
 		compatible = "regulator-fixed";
@@ -951,14 +967,6 @@ &main_gpio0 {
 		"",
 		"",
 		"";
-
-	verdin_ctrl_sleep_moci: ctrl-sleep-moci-hog {
-		gpio-hog;
-		/* Verdin CTRL_SLEEP_MOCI# (SODIMM 256) */
-		gpios = <31 GPIO_ACTIVE_HIGH>;
-		line-name = "CTRL_SLEEP_MOCI#";
-		output-high;
-	};
 };
 
 &main_gpio1 {
-- 
2.40.1



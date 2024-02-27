Return-Path: <linux-kernel+bounces-82663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A068687F1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848BA1C21988
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC92E4F1E3;
	Tue, 27 Feb 2024 03:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjelYzTz"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15CB4EB32;
	Tue, 27 Feb 2024 03:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709005566; cv=none; b=eaCiqm1iIJvKaYgbOGYS+PgglqGzixxqUgusUGL9JwJlXkdQES/oestRbujA0LwLfqedf3zQ4FrH2rybnsM5kg+B8pdf1IFXM+AoAFbEDdEeENfIPyp9PyyZ/tu84IjUXZ2McbWmGHIH6zfS2WBxpgKDf1jj/t8jbxJ4WmZALVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709005566; c=relaxed/simple;
	bh=mmlLq1nOScDbgyJjv8cbQMfU0vZVtoIx8JKAAQBTMCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIKxIandB5W5SN6vHOr2QXcPjlnOtGMiagRQ9/wb+c1O73WvPxYwXiw7yrt9bTz6INeGuS1IpWVG+O+3KsrSyu1jSVuUltURE3L6tFxD7eV3F7amLHpCzPveGFk4ViJfITRrdyMi0BllyfPxxo3vX6s/DlUyIZzmuO8TxdV4u88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjelYzTz; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bc332d3a8cso265672039f.2;
        Mon, 26 Feb 2024 19:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709005564; x=1709610364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JQWVgvsVSAXBFHOY8s9spMi4UJ0tFbH9CvikIMLXfY=;
        b=kjelYzTz8ahzH7vXvkp4meFSfW8Q23gqgVhxWskL8BsQUQxjb1Hdfdo8dYeKA0arEz
         91KmfLel/xb0nvCOlghenodwY762MBs9mhtmOZUtSkl6i2j9Zgpa5ixWOQavxpIicvio
         cirtpXso/DrWPisIZBMnuDjQxgWKvC3d6WC2BCSgynIHXGjayaPYaOozqg1uPQjaii3y
         5CNc29gtCPR0aA9HHcRW1Tbakes2M1oEdc7eugjt3sFrkU375+U8Op/iGI2ExQWdX4YA
         720mSgDcrj3xaKx4AVZQnULjqMP8R6F/rGOoaqI+6hZ9Aeu9NfuZ8VKW1zfoqSrqc5P2
         P2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709005564; x=1709610364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JQWVgvsVSAXBFHOY8s9spMi4UJ0tFbH9CvikIMLXfY=;
        b=PYRTCa6fXHZXZaegxNQhPw2cflnq5wmXwkVMcpAmwPlCIugZ4Y3LkTJDUIKRwtu7hK
         ycwm91uKX7/28EOIARSlknCC4hLz3J9YUWcoEoyc58DvQocq8V5yr65YwRJhnvIYAMql
         /f5bsHtJ5u4mDiRRdknPgv/7csxbBYVaASysMqQPqM2J009XeoX6pZnR05XWJzLAz5zA
         7C6y7MIYbkcj+o3vmaiaDf179XwIxUppu+sDZOK/WN5Uaqf4DWloAAbYM+zsfnmkrRGs
         JBD3ngfS5cEmar200FRiO3bBqjGqjVu3lvzcoul5uzQrCWYZ00scxbBI0l6Wr7Omghen
         tkeA==
X-Forwarded-Encrypted: i=1; AJvYcCUc8h8nYQoafoH8ORrZwnQf6YvlcFEzbQJD65TWa4yQk7kQz0b2c5Lj6bIBXCNXlRpbaglijWaBlsIvrUh+nyAjUJ7tl+Q4FJHKg7GpExuK6qATdJVMmCG0SUBMnhk7LVEJHke1DIg8X3x2UTPNFjEfMhxZWAVURqwZMHWiPrzilp7PIkTdgp1suvSE
X-Gm-Message-State: AOJu0Yw+mtrreRwtClYn5B6L9STnFD5iwOz4e4w7HNU4WiLB7qQ7uVV5
	HhNQ889yz/NO09rVCllIQxBc1b3qFCcHQ865xg97ptXkX3NxTKSN
X-Google-Smtp-Source: AGHT+IEvUosRcO3cAs604DIvzG8GjuAYhfLZpRke5iMYbs0MEdBufngZycVwxslAbjglBaiBIvbwKA==
X-Received: by 2002:a92:d448:0:b0:363:b8fb:fcb7 with SMTP id r8-20020a92d448000000b00363b8fbfcb7mr9849922ilm.16.1709005563780;
        Mon, 26 Feb 2024 19:46:03 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:1712:c48b:aaa0:cd8b])
        by smtp.gmail.com with ESMTPSA id w4-20020a92ad04000000b00362b4d251a5sm1891566ilh.25.2024.02.26.19.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 19:46:03 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: dri-devel@lists.freedesktop.org,
	linux-renesas-soc@vger.kernel.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] arm64: dts: renesas: r8a77951: Enable GPU
Date: Mon, 26 Feb 2024 21:45:34 -0600
Message-ID: <20240227034539.193573-5-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227034539.193573-1-aford173@gmail.com>
References: <20240227034539.193573-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPU on the R-Car H3 is a Rogue GX6650 which uses firmware
rogue_4.46.6.61_v1.fw available from Imagination.

When enumerated, it appears as:
powervr fd000000.gpu: [drm] loaded firmware powervr/rogue_4.46.6.62_v1.fw
powervr fd000000.gpu: [drm] FW version v1.0 (build 6513336 OS)

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/renesas/r8a77951.dtsi b/arch/arm64/boot/dts/renesas/r8a77951.dtsi
index bea4edd17d53..3e9defaeb00f 100644
--- a/arch/arm64/boot/dts/renesas/r8a77951.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77951.dtsi
@@ -2771,6 +2771,16 @@ gic: interrupt-controller@f1010000 {
 			resets = <&cpg 408>;
 		};
 
+		gpu: gpu@fd000000 {
+			compatible = "renesas,r8a77951-gpu", "img,img-axe";
+			reg = <0 0xfd000000 0 0x20000>;
+			clocks = <&cpg CPG_MOD 112>;
+			clock-names = "core";
+			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&sysc R8A7795_PD_3DG_E>;
+			resets = <&cpg 112>;
+		};
+
 		pciec0: pcie@fe000000 {
 			compatible = "renesas,pcie-r8a7795",
 				     "renesas,pcie-rcar-gen3";
-- 
2.43.0



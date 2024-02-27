Return-Path: <linux-kernel+bounces-82662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8728687EE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDCC42890AE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035BF4EB39;
	Tue, 27 Feb 2024 03:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMYLb8mP"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66114DA11;
	Tue, 27 Feb 2024 03:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709005564; cv=none; b=PF0KpbJEVbyQvXqALNPBjkrCgpL7BdoP8znqayd2koihY6Y3WA1obl54Y7s3EIQsTz1ehIyT3HLCvbNlkBqOdNF/yG5vVXqHz8ATsORSQdu6ZKLgLDM2iZ4MTQcOa5+2TSOKv0EiCd8a5niS2KV/RNa9yWw1P/Poe2mBbRA3u0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709005564; c=relaxed/simple;
	bh=978k3peN9JdSkAeLAZxAgp9ZWfU7hMfXepKf85SgcpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clARK6ElZ2Q/kfMhaceVPq2JmItWWTrW117kgQ5Lq6bW+lUFw5TI2ddt9drppxud8q7Sv+q1WN7j7fPK0DrQNJmXpFgMfPl9Y3X57/VWBXAh5/7bZX5ctueyKjfY7RAsi2vCjvSsN/TRPxZFYnP/3HPNDpiXHV5jt7B0+AEupWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMYLb8mP; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-363bdac74c6so10192225ab.2;
        Mon, 26 Feb 2024 19:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709005562; x=1709610362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tA/OqBDxHzMzuOM7arRYERa2rELcIZBY7XfgMgE4ynA=;
        b=IMYLb8mPmufPGqokXKhh7cOCU2m0Ct0MuBNaiR+rqdudTL9NC/yxXo6HcU7eOnSCiu
         89F+jLsxP9wEDhwqWMULLj7QNnAcEVNZ5kToyGpHn0h1p133i+n6T5qM4rLYO3bzITv9
         kgnBQvzDafubiBP8Dti2tkVBkSJriiz6zIWWpcZNIF348WxJWCKYURiU8/lJus1BEZA+
         09p1nGXy1McAOP7AHfLGwTkhv7bXesQsXMocu1GmH0lC+3DLWijJrGO4hxEh+7U+C9J7
         Yn1Qa4RQoRKgUZ5aMJeqz/ZyE5CZwEujTVZuK3yg2D/eaOoJCuzitN71Jsvn1d1ow6wk
         uO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709005562; x=1709610362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tA/OqBDxHzMzuOM7arRYERa2rELcIZBY7XfgMgE4ynA=;
        b=VmovYyKUoo9A5fu8nqGe+ai2X280DWw0U7wMscy/ftV+SzVDzaLn1RjvnNKAwMyCVL
         I1fWVnZmgTjhCjQW4Ii0U+QWqg5w03/5M1T/nKYA/CnTTowtrIH2pQThizK9dKro4mOu
         tzci4VOkj5u34nftM/BULVZO8kHQWANQCcyIbTkWywGpIbsPr3+1CKFVDUsUO1CJNUfR
         fy4wPs2aSgQfxGHqAN2T3eplEXF1jS3ucOcR9uuonPStMB7WHasm5HQHmQ7WQUYRwHhU
         tShOZ2c695HnVnTcoW5F+bWi9heNw0Tv1RPWh+yjWJK6xxKPQTCxAYhGEAo6D5ddbdkH
         edmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDMACr7wIN8JDLkuoun9Wj+28dRXXLiUtOmN0UQNMHlv+9qbVMvwYFcDVMiCPJ6XwyFspJIOUgS9eUBJRmsBVbS+cTruTV+J7LAqe2//Q7YEshFGnTSShof3UoeE6YhGUrySoNPyNkUdm9fNnj9M8G6PBjwk3Dm55PUEj8y5X8/PN9qlZTTvUolRd/
X-Gm-Message-State: AOJu0YzKxBeFMIThlOXkzcssZe/wPnD+0N8TiJUnSu7tWo5DKg8fuuzD
	0iR08wOnCPFQ7bZUFLbLRFbJN3Bbhk+u2+LNwtoYy8RBZTpOSLM1
X-Google-Smtp-Source: AGHT+IGQczT/wDuY+Cr9M1yRRAPJftGBz/LLp0J3qOzY2+JJTzEk6HQsjw4c+SqdK+MXfA2bjYuM9A==
X-Received: by 2002:a05:6e02:11aa:b0:365:85c:58f8 with SMTP id 10-20020a056e0211aa00b00365085c58f8mr8612657ilj.13.1709005562006;
        Mon, 26 Feb 2024 19:46:02 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:1712:c48b:aaa0:cd8b])
        by smtp.gmail.com with ESMTPSA id w4-20020a92ad04000000b00362b4d251a5sm1891566ilh.25.2024.02.26.19.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 19:46:01 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: dri-devel@lists.freedesktop.org,
	linux-renesas-soc@vger.kernel.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] arm64: dts: renesas: r8a774e1: Enable GPU
Date: Mon, 26 Feb 2024 21:45:33 -0600
Message-ID: <20240227034539.193573-4-aford173@gmail.com>
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

The GPU on the RZ/G2H is a Rogue GX6650 which uses firmware
rogue_4.46.6.62_v1.fw available from Imagination.

When enumerated, it appears as:
 powervr fd000000.gpu: [drm] loaded firmware powervr/rogue_4.46.6.62_v1.fw
 powervr fd000000.gpu: [drm] FW version v1.0 (build 6513336 OS)

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
index be55ae83944c..398c9df1577b 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
@@ -2464,6 +2464,16 @@ gic: interrupt-controller@f1010000 {
 			resets = <&cpg 408>;
 		};
 
+		gpu: gpu@fd000000 {
+			compatible = "renesas,r8a774e1-gpu", "img,img-axe";
+			reg = <0 0xfd000000 0 0x20000>;
+			clocks = <&cpg CPG_MOD 112>;
+			clock-names = "core";
+			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&sysc R8A774E1_PD_3DG_E>;
+			resets = <&cpg 112>;
+		};
+
 		pciec0: pcie@fe000000 {
 			compatible = "renesas,pcie-r8a774e1",
 				     "renesas,pcie-rcar-gen3";
-- 
2.43.0



Return-Path: <linux-kernel+bounces-82665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38048687F8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E52D28A3CD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ED550A68;
	Tue, 27 Feb 2024 03:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRVO44j3"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3D44F21D;
	Tue, 27 Feb 2024 03:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709005569; cv=none; b=I5Fo1x+ISCrXBmF5EuMybN3QjGtWhflxMujxXH/4k1e9Z+YbXhksN0fWew4neKli1XX3wx27Q24IW3it5kJyrSSwK49q+wCX1r3a8vB6TM497A+hGireqz9XMFKJZg8xaftBH4oRR6P2Z45xr1d2g8MBa3AQ4JVF8yOaNCCsO90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709005569; c=relaxed/simple;
	bh=U0lXaNVTMjzgpymz11YyhWetT7KDSKee0kupvHaq/ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KukfAMS+hoQiECSpyDis5u3P9InL4whmDT7+MflfbU61bJVxMRvh73WH0GNbGadjDxtt1d0P8p/gqgYDBrBDVhY1UVfL3Q6yBnYaG1VAa383YEh32GeX/EEC+EG1U7rmdfqzWjBUPuQOH/bOSMqF8pshSAZMF/2iYXUweXgxWQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRVO44j3; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3652731b2b7so13811365ab.2;
        Mon, 26 Feb 2024 19:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709005567; x=1709610367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJfm+NHY1Z+Lw1sZYXXZ3jyQox+hLwhKq3O8TxYABL8=;
        b=BRVO44j3vwnh2X3MvZNJFoFSab6byM2h/uJ8j7WIdjhYLTxQ21LimqM8LHoS6JbakF
         osgm/miu8sYAqwPzMaJgriqxCLo7K4nz3RDzn4UqXDqXbkM7sF+OMIUyYkJgW45adFE7
         e8Wab0TR5rkwWTJeWuAL19slw2Kkq9nM+Q/XxRSQarXbVB6vk0cAd/DV/4L+m/es8Npp
         wpNHs1CmUqZ55Q/mxEWQnXU1lCTWxswlIcLzIjN5flZ+m9zB2K1K3NjdoQ8vqRu599pL
         d+yzvwuebNfT9QDk6Qnsygwvt0xoCv39ol4zEDK6xqgPlfoYPm91inBCZ7CrOT+rqtzi
         wWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709005567; x=1709610367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJfm+NHY1Z+Lw1sZYXXZ3jyQox+hLwhKq3O8TxYABL8=;
        b=c9Uxm32ahSJSHsF8eNsXLDUqvRMESgfahncBrFmi0Oz4YzD/2c+G6riKStf5tEwcVB
         hogImQwd/alivmmZhozSqaWVau53foHkMWMf6EuKsWWAbdJqoLdWKdQYXAs68DeM9Y9+
         D9xmqY1pxWsD8xY0RU7eQSabF0VGtt5bADvHbWiyA7xMq6kdlQsJCwHGKcFzHbgUkPkU
         jJbgB1GY1dOIo1MVz9+KVQeH2FJX1q+dJQjL3cQ9N+fc7S8wzGaNKLHoESQZZH3OdQJ7
         OOwpNlRC5wwRIgEvPzqJQxwtoUioWwqQ1YcMMrKzDO7LIB7/S9MgPZhZe6sBOwPtdcjM
         TTJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHfDAeUQsyEF9XZEySu+2hWDYAs4NOdxgx/SaW3lGvMXbecoeKqK4oNegl8dz9HOTKQoSStUebJGnWTYgSy4hlzm9FW7QeLGT8EVvGcF/JE0mCbkUXLkSjZs/3UC7HUrSWlHG2pbC7hraBvRYQDrhE3A3CvxpCWhKf0siSX+VsR00LWZc74z1HfnsZ
X-Gm-Message-State: AOJu0Yw137cpty4vGIWaiv31Gu9NrTzJ/zR9e2qAdXGjrZ2lYZ9amHhl
	AK76WAQo3eUSn/NpSPWgkaDJuSLSUNl/ir3tqdN+MwiSiiyOQihn
X-Google-Smtp-Source: AGHT+IHL1bo8nIvPJXhU/N96DuypsbyD1/7pheO1VuJUDwHDG0U2xYsyb1SRuUQCwpJMqpKqxuW6vA==
X-Received: by 2002:a05:6e02:1bce:b0:365:24d9:9477 with SMTP id x14-20020a056e021bce00b0036524d99477mr12614317ilv.15.1709005567198;
        Mon, 26 Feb 2024 19:46:07 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:1712:c48b:aaa0:cd8b])
        by smtp.gmail.com with ESMTPSA id w4-20020a92ad04000000b00362b4d251a5sm1891566ilh.25.2024.02.26.19.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 19:46:06 -0800 (PST)
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
Subject: [PATCH 6/6] arm64: dts: renesas: r8a77961: Enable GPU
Date: Mon, 26 Feb 2024 21:45:36 -0600
Message-ID: <20240227034539.193573-7-aford173@gmail.com>
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

The GPU on the R-Car M3-W+ is a Rogue GX6250 which uses firmware
rogue_4.45.2.58_v1.fw available from Imagination.

When enumerated, it appears as:
powervr fd000000.gpu: [drm] loaded firmware powervr/rogue_4.45.2.58_v1.fw
powervr fd000000.gpu: [drm] FW version v1.0 (build 6513336 OS)

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/renesas/r8a77961.dtsi b/arch/arm64/boot/dts/renesas/r8a77961.dtsi
index 58f9286a5ab5..cc17e624c069 100644
--- a/arch/arm64/boot/dts/renesas/r8a77961.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77961.dtsi
@@ -2438,6 +2438,16 @@ gic: interrupt-controller@f1010000 {
 			resets = <&cpg 408>;
 		};
 
+		gpu: gpu@fd000000 {
+			compatible = "renesas,r8a77961-gpu", "img,img-axe";
+			reg = <0 0xfd000000 0 0x20000>;
+			clocks = <&cpg CPG_MOD 112>;
+			clock-names = "core";
+			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&sysc R8A77961_PD_3DG_B>;
+			resets = <&cpg 112>;
+		};
+
 		pciec0: pcie@fe000000 {
 			compatible = "renesas,pcie-r8a77961",
 				     "renesas,pcie-rcar-gen3";
-- 
2.43.0



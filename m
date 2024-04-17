Return-Path: <linux-kernel+bounces-148396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4161A8A81F6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A3D2827D1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD42813C9AA;
	Wed, 17 Apr 2024 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUZdX5Hx"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4AB13C832;
	Wed, 17 Apr 2024 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352854; cv=none; b=ZiA4RROgPXAaE6cSCNGC0iL7HJ+ZeQaJqOVNyg4rZUJa4OY7lb7OUR5xzf8B0417+sqXfXg5OW4nxnqDE/9dTsuNcOyCnCc+Zr089SiwqZhkkx/ICrijLA+XovI7bwvhJBKDAH0/gEvMUrJph7eHpO8jDuVhZHJ9wXlEV5uq87s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352854; c=relaxed/simple;
	bh=Rq3gwc3GhQoOVdIkD+E2nDoNRsGfnXD8UQcYyZRBeno=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y/871eAAVRCOngcqOJve1X91vBa7optgQYWzEFXSV9JTSRDLXMjqFvS4hIGqLZDsK4hCFLLQz2MstrZFQurx8dUAUl7y7lF8ARAdyMmK4tsbe+/3pGspmrL8TGiB8ecgpukPYyRGfZTrDwSaiG7LzQFTPxYKyufisPXeioBqrCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUZdX5Hx; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-349c5732fd1so369053f8f.3;
        Wed, 17 Apr 2024 04:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713352851; x=1713957651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K0HtLEl+svfltZjXnicchhY/2KiEAj25KRuBPUpt5y4=;
        b=RUZdX5HxpG751V+43C4ivDnSnEJ/QYYJNWmIM6h/QpBbH0lqCg6wLaaNjxZYutT2tR
         wWc6NJiOyn1LX5XxBxGRfgRprqW9HiCH+h4gRduHaf9skVcVtXc/X3rF1Yn6quFpOvrw
         r18uc6ZW9GDDbMmWA+oMpX8zKqL1z2p8KyDyW+SP4wq8LXHEeDRn6RpVe9gdx9Dbe3St
         aRtNEgCkpYbPF2/5vWClP+Af5hcpYefsF5BMsHvdZIxPsVj1pSPKDtFz+9B28kT6pJYI
         oHN3mQ4fgzUKfrt8ziYa78k+Tohq2e+wLi0CLN5jjBNPen1+7qLHoxaWTIGdGKalDMlJ
         +fmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713352851; x=1713957651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0HtLEl+svfltZjXnicchhY/2KiEAj25KRuBPUpt5y4=;
        b=CN2pWsQSfwhqd8aNNL/v8ncz2S8kNLTQ1IZttmFGiuG8CKwmz0PeiHTpPm2DiDaqgm
         we1230+FxGNKveYv4820NbvxP7oUO+4sQ5MLS9N7a7QSN8uNUbQEBhVjLAjvx4tlLSms
         wR3EBGJm2zEXPrtJMnmrSvwyy+rBmmIk/DT8df83P4IGH7U/hh5RKUs/nsPjngdbTEvM
         iw84lvdW1koi5Ex3GB2djOC2srYcizDGiKP3AdaK5UqER8wddq9CyBjQVzt8C+ImEeo7
         KdxuYkZjTgXAIKiFCeJ4nusZlZqPwPfrF3JzkMsoKWnhi5hgKDyi1v3ZI2QQi+nvfD9u
         FalA==
X-Forwarded-Encrypted: i=1; AJvYcCW/5AGkDjhzzyww3/wtCrLnmLCrrSA/OS0Q+0YjQlIH9Onq3YVPKQkKIxBkhXMXU2KMY/9Y0RCNjMAJluFVEfhbQM4HYJxrufOowICCsmBCt7TrZKGVBCpRZiB8B41xfdoOvHwpU2p9/w==
X-Gm-Message-State: AOJu0YzyAX7ixu00vk2t9JPjld9s48omcLtj7TP74pzao0dsWjLQLPOD
	xV6cQgHs0eBOMr4DFUmdkUmzX7xID5M+0qBEnfeGsLkOuWFnBU0yGtmlXI+l
X-Google-Smtp-Source: AGHT+IFx3TGm17jFArQN3cZD10pBddDq6RwvKkHMTLewGmYFVsrglztmCcq+WIj2Mtsi4qv31jIqMA==
X-Received: by 2002:a05:6000:1b06:b0:348:104c:c105 with SMTP id f6-20020a0560001b0600b00348104cc105mr5487835wrz.46.1713352850611;
        Wed, 17 Apr 2024 04:20:50 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:2595:4364:d152:dff3])
        by smtp.gmail.com with ESMTPSA id e15-20020adfef0f000000b00349bf6bf2c8sm1325737wro.28.2024.04.17.04.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 04:20:50 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] arm64: dts: renesas: rzg3s-smarc-som: Enable eMMC by default
Date: Wed, 17 Apr 2024 12:20:03 +0100
Message-Id: <20240417112003.428348-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Enable eMMC by default on the RZ/G3S SMARC platform, as previously done
on RZ/G2L boards and other Renesas platforms.

The SW_CONFIG2 setting selects between the uSD0 card and eMMC. By setting
SW_CONFIG2 to SW_OFF, we select eMMC by default.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 1f87150a2e0a..8a3d302f1535 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -25,7 +25,7 @@
  *	SW_OFF - SD2 is connected to SoC
  *	SW_ON  - SCIF1, SSI0, IRQ0, IRQ1 connected to SoC
  */
-#define SW_CONFIG2	SW_ON
+#define SW_CONFIG2	SW_OFF
 #define SW_CONFIG3	SW_ON
 
 / {
-- 
2.34.1



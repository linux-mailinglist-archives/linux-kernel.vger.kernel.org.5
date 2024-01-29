Return-Path: <linux-kernel+bounces-42978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8BF84098F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4FF1C23268
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF5A155A3B;
	Mon, 29 Jan 2024 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsS2/bAw"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F242B154BEE;
	Mon, 29 Jan 2024 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541398; cv=none; b=tHOmiwpOWacV/htS/AEhvdv2iwadlrwPx1ec7xrvZ5/ibwC9Qs5RK0eML975z1ry6pfjy90Ik3dVkjasenasWKeIqMnJG3LBa57qPKXGtkvDqdvC4Gkzr1g49WkpexKSYN4lHedVWagzxfYtOyXVi8HM3RV1btRDvjLceB0v/yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541398; c=relaxed/simple;
	bh=UZfV+7nzQjsF2UELFcWkXOI/dVH5yQJV/6seSEnMvPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FbiiGMYC94BVzSrNC3JgOKaGYhualTz7OilnEr8Li71VyPKMhjrNrPFmUppMVGUB6RCNqtR4lAtnUsTu6e4ot3Cc7V2YOYaAsIcibHjQEpML58EgD9tXd1Zs4mC2rXVWWBm/YxaScFvV5UH5WPZBu2i6LCoBP2wd7CE0bM5Zpws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsS2/bAw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40ef207c654so14162785e9.1;
        Mon, 29 Jan 2024 07:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706541393; x=1707146193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4bMMpLXuQIixNeR6WwJ9UQMuCJ9W4sOuZfXsidKNW4=;
        b=BsS2/bAw+cyCok0z7NtZTYKRMyg7rdP334vVPOzosB2jZwFYKsmRr506C5S9qQIqWu
         xWu4JdbtL5LummzltBIVckrImQEQkhHZgMoAALjDuiZmb7B9wVdWBFF8bG/CLuWGtz3l
         KOtD8Fheeftm3sSCRDw6ryvpo9b5eyiMl2cLwwSFYNB95RiEhKGzMDlbKipAHDliUini
         TdiNdHJ5GqLhgJQ74Gs+xNPxkvDxmno6WRLJg20ftCbh0FqW7ZuMuUFia51ixMHOSPf4
         Dd9V5QKt6fHA+1pp1De1hRK4j2v1IyfGgBB8PCazHdcF7GMDI6CgjcaiOk0RwVwCPbYn
         AXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706541393; x=1707146193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4bMMpLXuQIixNeR6WwJ9UQMuCJ9W4sOuZfXsidKNW4=;
        b=RCvjCVC8GlWWyxQtAhMDHht0bLu3tN4VEcdnD9SLsLQr1S8vAuzMX3zkn0y6f/Crtd
         xxoNWc/S8a8grKkGvJVDNycrcIJ8lapeiq8D2BBT+ab615EUX0NpKtHIqxoOI/ZTac+t
         kqujtK2IO7m7Nl2x+q+UfxUAzpIXMFjQL6zBJpQaJRn9E7AD4aIJCDp+e+7ndwhayRHU
         gnHfMYyeswxly37u5DdoLa9fgHjQw1JxX0nXActrNAqtW2Msy9/mQWofz7BpF2/NRzU/
         dAs8ROVmX+AHgRrKT1agS6RgCgBZ4365jtIM9KZ8/CN45CPkt3kdnBGUBbrnELXkKjrR
         u39g==
X-Gm-Message-State: AOJu0YzL6Cinc/FjdeoaqciaIa85AbvE0FIUgExD2yXLlxkCmUcH5RhC
	jMV+/F63GwBVl6cANrENWPFX8ZrvVpDM1DPq0uiukGekgKqgrwlJ
X-Google-Smtp-Source: AGHT+IGC87bYjEe1iZ7p/5fpoWfZzxhMEEhDy0q4/HOyZO3KfblXARleUUPCKunnw42Wa9PiyCeq9w==
X-Received: by 2002:a5d:47a9:0:b0:33a:f34c:23a0 with SMTP id 9-20020a5d47a9000000b0033af34c23a0mr1892243wrb.2.1706541393177;
        Mon, 29 Jan 2024 07:16:33 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:5616:a18c:ea50:2995])
        by smtp.gmail.com with ESMTPSA id h4-20020adfa4c4000000b00337d4eed87asm8397774wrb.115.2024.01.29.07.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 07:16:32 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5/5] riscv: dts: renesas: rzfive-smarc-som: Drop deleting interrupt properties from ETH0/1 nodes
Date: Mon, 29 Jan 2024 15:16:18 +0000
Message-Id: <20240129151618.90922-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Now that we have enabled IRQC support for RZ/Five SoC switch to interrupt
mode for ethernet0/1 PHYs instead of polling mode.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../riscv/boot/dts/renesas/rzfive-smarc-som.dtsi | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
index 72d9b6fba526..86b2f15375ec 100644
--- a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
@@ -7,22 +7,6 @@
 
 #include <arm64/renesas/rzg2ul-smarc-som.dtsi>
 
-#if (!SW_ET0_EN_N)
-&eth0 {
-	phy0: ethernet-phy@7 {
-		/delete-property/ interrupt-parent;
-		/delete-property/ interrupts;
-	};
-};
-#endif
-
-&eth1 {
-	phy1: ethernet-phy@7 {
-		/delete-property/ interrupt-parent;
-		/delete-property/ interrupts;
-	};
-};
-
 &sbc {
 	status = "disabled";
 };
-- 
2.34.1



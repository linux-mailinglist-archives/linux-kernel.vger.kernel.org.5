Return-Path: <linux-kernel+bounces-128721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BECB895EA2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BACE628676E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B3215E5C4;
	Tue,  2 Apr 2024 21:20:48 +0000 (UTC)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796C915E5AD;
	Tue,  2 Apr 2024 21:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712092848; cv=none; b=EPWwuI/pBo9iUkgKwYQdEFsGNiCh/xkm25S+xBsiXO4fevZzZYEbhd/6ob4wO/VUFwzdf6VVaT80cpQE03zH/4rJCH47O6Y/XSMhT9WdN3okZzJwukYC6nDNSPLjhVeFhBkPr3bnyi1/j6IKxFqz9htXyFchHskbs1mkPFz55s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712092848; c=relaxed/simple;
	bh=m6mZHCeGuDWGjAxF8kCCNOZBAJYiCuwiwCd5ET9tL9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WD6ar353d1MZEILKxQ5Hj+5uhhNvylx0Mccd6NYa0vTQ1KFsf/eIT37wDqtxT9dLPf+WhLiStKEzqbXGYR90XH2CKbq2hiqEpBVoxw78+Jc3tBB/sAeR0gjGkLIAkGhd2uh1pLAEg9CAX8Y5o6WNyLhlnRzxMID6nVa4hM20vTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 7866B8804D;
	Tue,  2 Apr 2024 23:20:44 +0200 (CEST)
From: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Haojian Zhuang <haojian.zhuang@linaro.org>,
	=?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	Lubomir Rintel <lkundrak@v3.sk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Rob Herring <robh@kernel.org>
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Karel Balej <balejk@matfyz.cz>,
	David Wronek <david@mainlining.org>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 9/9] MAINTAINERS: add myself as Marvell PXA1908 maintainer
Date: Tue,  2 Apr 2024 23:20:36 +0200
Message-ID: <20240402212036.6378-1-duje.mihanovic@skole.hr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402-pxa1908-lkml-v9-0-25a003e83c6f@skole.hr>
References: <20240402-pxa1908-lkml-v9-0-25a003e83c6f@skole.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add myself as the maintainer for Marvell PXA1908 SoC support.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c121493f43d..a7c19ffb739e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2371,6 +2371,15 @@ F:	drivers/irqchip/irq-mvebu-*
 F:	drivers/pinctrl/mvebu/
 F:	drivers/rtc/rtc-armada38x.c
 
+ARM/Marvell PXA1908 SOC support
+M:	Duje Mihanović <duje.mihanovic@skole.hr>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+T:	git https://gitlab.com/LegoLivesMatter/linux
+F:	arch/arm64/boot/dts/marvell/pxa1908*
+F:	drivers/clk/mmp/clk-of-pxa1908.c
+F:	include/dt-bindings/clock/marvell,pxa1908.h
+
 ARM/Mediatek RTC DRIVER
 M:	Eddie Huang <eddie.huang@mediatek.com>
 M:	Sean Wang <sean.wang@mediatek.com>
-- 
2.44.0




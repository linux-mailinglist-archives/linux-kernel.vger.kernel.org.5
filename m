Return-Path: <linux-kernel+bounces-157550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD898B12BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D43828151B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB50C4597F;
	Wed, 24 Apr 2024 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEgXKmyM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9632C84F;
	Wed, 24 Apr 2024 18:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984158; cv=none; b=o2H6xrSOAiMP/0vfD1YbuHfZnkReoJUkxBGxuZomzTFNb4rFz8JG62jgBqaUS0163YFdlHNRFpx3hqBE5qXkuPdDZ1haLZCflZZ7ZfuTTAsTxLikUmqXJJsEKEmadlvTqm4xzsTVxQTYr+qZ8sEx05TQ9Wt3GWEyXqtRXkGhvyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984158; c=relaxed/simple;
	bh=CP8WfTDyvgYNfa6AxhA6VjlMigbLNYOvffOz1XRpFWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YXn+apzEPccx/UWS2H+IMKjEfukV4kNfINJn1gXzMbJIp3SnoS1wBQVC2E/ervNbqGkYOuyug1ldL39ekUpNAdT9A6JqklvI2HQ49bzacZSdn8VglxhXuxpAsT6S6UyFTwkASBz/nzzBcef0wVQqyRNGy20MKPvfX6r3b/0dKAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEgXKmyM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CEDFC4AF0A;
	Wed, 24 Apr 2024 18:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713984157;
	bh=CP8WfTDyvgYNfa6AxhA6VjlMigbLNYOvffOz1XRpFWw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vEgXKmyMlfjzGjfZToH0m5KMt4CE3/1hWUDo/8wdSxv/gHJpCkYuWL82iQEx5g3EW
	 rtZLPgGUnWWGVu7jRx7X87rJDemytYjWHNAuZIDTg1TJ3intp+YgdYes12lQ8luDfB
	 AI9fqc807HDcN+jFnRmCwVl9oMuYQGApq581ZXEmsCZ0fPBBjoAgEB3xETOW4R2vG5
	 PNcepVs32s7tkB55bB62BcOgsCf+xkkj2OKOu09sCbJB8CkylT4CEgJDsUREz0tusu
	 mqOpu3sqGjvRGorbOzrNxZBAtmYnkThfKu5SV7Uyh1kvWa7HWabFdeVahy1IMy0PKZ
	 48ufA4lp1g3ow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D430C4345F;
	Wed, 24 Apr 2024 18:42:37 +0000 (UTC)
From: =?utf-8?q?Duje_Mihanovi=C4=87_via_B4_Relay?= <devnull+duje.mihanovic.skole.hr@kernel.org>
Date: Wed, 24 Apr 2024 20:42:39 +0200
Subject: [PATCH v10 12/12] MAINTAINERS: add myself as Marvell PXA1908
 maintainer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240424-pxa1908-lkml-v10-12-36cdfb5841f9@skole.hr>
References: <20240424-pxa1908-lkml-v10-0-36cdfb5841f9@skole.hr>
In-Reply-To: <20240424-pxa1908-lkml-v10-0-36cdfb5841f9@skole.hr>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Haojian Zhuang <haojian.zhuang@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Lubomir Rintel <lkundrak@v3.sk>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Rob Herring <robh@kernel.org>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=906;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=IAO2s2H9eu3z+8543Qj+Twu7btrO5EN1Y9FniKrdIpI=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBmKVKVE2n5S7pMEvJ2dz5c5NHiJUcq66HbNB47N
 dzaKjRup7+JAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZilSlQAKCRCaEZ6wQi2W
 4WZCD/0e6BPwFLQgizdDY83IxSn9oXdBBmvVOC8UrCDlq+RZqV20ZPSC/Fwa2WvlgS3KujswLP4
 Ic9DKe9rZkIIUzr+QzaL3Z94bgSVXDxfs2W/rHMRlD2v/EH/A5k6ciR5cou9lcRkl68SYwevmVj
 qzaxs5gh5OG27pKWbunNHSHMhmDWhbawbWz5KFEfkcYe4FcsaYqigw3JPpiKVFGGNfKJ5w0x/xb
 pyDhPqrE96Irc77j37PGHeNJhmHX6dPgnEP7w997pE0d3kwNwlfW7IC2huzz+WHiZBq1p5lZcpA
 bwqEbB65dA7F6PhfErDC8Ohp3jWgvDDEU2z2OVEBL7fX3MLC0W1s0QrVm8xhEPKDwrh3GnrJPBO
 q79TUoZZTAD1oryVw/CBdRbl1ee1nGRxNWdByJekEBSWDYkGXk7qeqorzBQYFEP/uHEbn0Ck5EW
 HlPjUn4MOdn184Ngh4Y/hYwkXH11GQo7jgysCLviH0RVOi/SZwxh9Hlzv2uxMZ7j82JCxtDAdN3
 ph7B+fWWz9WM6+jC40qrOWsPSPj75Z8Z9tIuykacvdZasIdGRN9M9WDrqyZCcR9Qz3pp8ME2faJ
 jCU3+2ERgJOpCD0Nmp4IzLZqa7cLY4i6KACiJ5e0dg36zY+Ley0m9nxNBUS3g+HhOwgHi+5Vb24
 r9I3U9sMvziOoyA==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Endpoint-Received: by B4 Relay for duje.mihanovic@skole.hr/default with
 auth_id=112
X-Original-From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Reply-To: duje.mihanovic@skole.hr

From: Duje Mihanović <duje.mihanovic@skole.hr>

Add myself as the maintainer for Marvell PXA1908 SoC support.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ebf03f5f0619..5d48ac9801df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2370,6 +2370,15 @@ F:	drivers/irqchip/irq-mvebu-*
 F:	drivers/pinctrl/mvebu/
 F:	drivers/rtc/rtc-armada38x.c
 
+ARM/Marvell PXA1908 SOC support
+M:	Duje Mihanović <duje.mihanovic@skole.hr>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+T:	git https://gitlab.com/LegoLivesMatter/linux
+F:	arch/arm64/boot/dts/marvell/pxa1908*
+F:	drivers/clk/mmp/clk-pxa1908*.c
+F:	include/dt-bindings/clock/marvell,pxa1908.h
+
 ARM/Mediatek RTC DRIVER
 M:	Eddie Huang <eddie.huang@mediatek.com>
 M:	Sean Wang <sean.wang@mediatek.com>

-- 
2.44.0




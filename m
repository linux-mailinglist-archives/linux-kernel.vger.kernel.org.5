Return-Path: <linux-kernel+bounces-72024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EB885ADF5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668A61C219EF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC7E54BD2;
	Mon, 19 Feb 2024 21:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mai.rs header.i=@mai.rs header.b="weLCNlM7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DlSJa2u3"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3141482C3;
	Mon, 19 Feb 2024 21:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708379209; cv=none; b=mybwbHYSzsM2fUeoFAPlkFNZPc2ADMnU6Pxt0qEWbpxkAyxiWYeGApJ6FAavsblZB0pj64kq9ocza/FsC7ejB+Jn1u79garnAJoH4Y57/kzK9hvxgK0eSU5NCWxTxkNd+AeZ5A9MnQjKqyNnZol5naa1VkJ2p1+GHNo8DN1CcCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708379209; c=relaxed/simple;
	bh=pX7vlRKzjwZqjEZhPCdp6sZvYIXFuI8KsiHdiUUODoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DwhQ0IbQgv1h/x/Gip4pPCa/s/xoVqVAGbEbnBL45exK120S6TkTrBJT1dc7y4VzyNz39RrMewORyy/1wzy/Yg839FxCROGsZ6oQtUTlCLJ+gzLolgwVO6yZ/PsAFWfZDPGOq5u28+FBZoaUURbOzIFd2nj6ZKVd2tfk4I8khG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mai.rs; spf=pass smtp.mailfrom=mai.rs; dkim=pass (2048-bit key) header.d=mai.rs header.i=@mai.rs header.b=weLCNlM7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DlSJa2u3; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mai.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mai.rs
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 82C5A1380063;
	Mon, 19 Feb 2024 16:46:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 19 Feb 2024 16:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mai.rs; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1708379206; x=1708465606; bh=1feYDj8c2GFhXtQn58Kwa
	4gOwxd+KSsz5/PmCXrsOZM=; b=weLCNlM7mpb59dLHcwDx4fjOT+9Fi6Hx/i4QQ
	ux6u2p9oXhQpXlh+103EtKxI6PBNv4n8FQ8+e6e1gK9lExw2uUaqYoVkydq9yNCM
	nrb7lowYyPcG053gunBDp2XbDRuavY5sNzjfIIJwxACt7qUQK5oT5+/c4YUF+Mkm
	6MwJMeD8MEtucomYOLTE3Q4wIexY6hkDB6ajuTU4+SM+cXCYoe1wcGsyW3eJ/EMn
	vLmP+Lx3cvLuXVhjYenZbIbrO0ETGW8NTviE0YJFDE6ZtGvVQSIkYNcNaxMrsWVD
	1XLxc1ZppV17bQMS9lGfquEN3V5VeMyRirIE7gg1vhEl5u7IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708379206; x=1708465606; bh=1feYDj8c2GFhXtQn58Kwa4gOwxd+
	KSsz5/PmCXrsOZM=; b=DlSJa2u3gKYNxDHHRiriv2IvOa85kTp5ZcHSdUDxJE3Y
	1z2aCPVgzpQonHArt1YUqhrVnu5HKgvG5i50WTCH9cIQK9XUpzEZZN/MAxFaimlO
	E7+9EDwKlDtbWBCg4jLVYGbXXyUyE/9e/OT+theXvcr0urUlsQrq+a0T0/cns/xS
	4FcVS9w84kA4Iwf4OUWhi24h9QFPDuwNQhEGqZwiztamWEZnuCXr+3tTsGt+7+TV
	Q12/HqiR1Hai7paXrGpwJEKBS0lfINaa8B/qT5CxqXxOUzK9i54YH1RxLWclam/x
	begaQ9DZrAm4JucPTfBjRkc6rJSyBmWx5Pf03K6WVw==
X-ME-Sender: <xms:RszTZSmlweWgh8kPoopBNXtShoBOTgLmUJ3FCjBMhCT3f6JVaeCzTA>
    <xme:RszTZZ1EmOV7KAnBPqZAQf8NQMoQRClAkyPdg3FuwLcnVie0NNSIdp9y1-eixVfCV
    Xq2pgjH-bXwpKVBHg>
X-ME-Received: <xmr:RszTZQqdlu2zrnSMWVC1__hemYqBgIC3B6-XawSzegdPq5MdRMz0IoYmujwfzac>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuehrhigrnhht
    ucforghirhhsuceosghrhigrnhhtsehmrghirdhrsheqnecuggftrfgrthhtvghrnhepge
    eiteekgfeihfeggedtgeejgfelieffkeeivdduvddugeffteefleehheeiiedunecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsrhihrghnthesmhgrihdrrhhs
X-ME-Proxy: <xmx:RszTZWlFUzCqYQpiPUK1ov6TO-I9FFEXdMZrsF-hDXJURa7RyPBdMQ>
    <xmx:RszTZQ2o4KoDrg20iRTPYEvAFZNncVmp3Q57tQwDHMi_iSo-3xNo4A>
    <xmx:RszTZdvXhUuVoGHUuFUVBKptIvAgADhRkcpmhksgWNgpzSl_QIJL8Q>
    <xmx:RszTZWO3I9TNm7pD6JrPn_dKM6gW1u5JOCqadcgjTMGsSZMU7J5Cag>
Feedback-ID: i891b436e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Feb 2024 16:46:44 -0500 (EST)
From: Bryant Mairs <bryant@mai.rs>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luca@z3ntu.xyz
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 0/2] Add samsung-milletwifi 
Date: Mon, 19 Feb 2024 22:43:15 +0100
Message-ID: <20240219214643.197116-1-bryant@mai.rs>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for samsung-milletwifi, the smaller cousin
to samsung-matisselte. I've used the manufacturer's naming convention
for consistency.

Hardware currently supported:
- Display
- Cover detection
- Physical buttons
- Touchscreen and touchkeys
- Accelerometer

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bryant Mairs <bryant@mai.rs>
---
Changes in v3:
- Minor style changes to the DTS
- Corrected list of supported hardware peripherals
- Link to v2: https://lore.kernel.org/all/20240215172617.115307-1-bryant@mai.rs/
---
Changes in v2:
- Squashed DTS work into a single commit
- Add touchkeys to the DTS
- Link to v1: https://lore.kernel.org/all/20231105204759.37107-1-bryant@mai.rs/
---

Bryant Mairs (2):
  dt-bindings: arm: qcom: Document samsung,milletwifi device
  ARM: dts: qcom: Add support for Samsung Galaxy Tab 4 8.0 Wi-Fi

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm/boot/dts/qcom/Makefile               |   1 +
 .../qcom/qcom-apq8026-samsung-milletwifi.dts  | 573 ++++++++++++++++++
 3 files changed, 575 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwifi.dts

-- 
2.43.0



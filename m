Return-Path: <linux-kernel+bounces-67402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 052BB856B1A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7094B2E102
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EB3138489;
	Thu, 15 Feb 2024 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mai.rs header.i=@mai.rs header.b="PbRbU7JB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PY7XrJJr"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C23E1369A2;
	Thu, 15 Feb 2024 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017984; cv=none; b=iR46PKukd6Y5GvAbIoTY3xvLirrijkNmn6LNaBMxfYelPb287VixMc1F5afwItapF/BbpDkLRWRkYWlbR/uVtVwQHc3lreoeUVWzjUxj80qPIguvEJDQ5VewBb5KmE7+7ADDhyOlajjXKbjn2b9fh7HpVzMrNNJ1G6CgrRd+4ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017984; c=relaxed/simple;
	bh=jLfDGBorgsnjXYJBTWI/GaiSFQdK44fYLGCUNXbjhw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iEiSiNlttARtbXUb03+ADfS/oT4fOjBKA+wDPP6SMlLf36OCLeeR4toud7QFEiTXpomlU/FYZZWZohbX0FmE76z+y/klC5LdVYT4GLUCMLroH3RNEOeFhiorusiNUOxFA3mrnU69GGd1UV5F++xn5j4nrFbV+a2BoHCUFKAajMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mai.rs; spf=pass smtp.mailfrom=mai.rs; dkim=pass (2048-bit key) header.d=mai.rs header.i=@mai.rs header.b=PbRbU7JB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PY7XrJJr; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mai.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mai.rs
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 17B15138009A;
	Thu, 15 Feb 2024 12:26:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 15 Feb 2024 12:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mai.rs; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1708017981; x=1708104381; bh=fQZdaVp4DDsm5XDmrXzzI
	iRsQ41MBd8wovYL0HPc63k=; b=PbRbU7JB9U4NCPjt2uga/82YJjkB9rvuViuCR
	f9RGmF9OA2aQKk7SuXaL9ZHh7JxFPwukq7ICbFiPTFHxI5E/c85RLcykU8dbUOZq
	uBaLUMjJRIAPs1biuOe7gDUGryVKx7NuOYVh8U0Dlckw8803qAeuhSw7j2iaVWrY
	O6yIVD7j3FBb7biDTLqOFXaTxtI1T1CdQSL4BFOF8nfXqASpoRw3rhgLs3juE5vT
	NhYdpqPheAn/ZCFsx0I2VOqFx4ZgfsW8TM2KBxKbD5eFS5e699+Cjs+Qk1XwT2w1
	Nqwv/Sh2tFZAg/kjq5vnecswiDNcotWJIb52XweD8Th6TbHgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708017981; x=1708104381; bh=fQZdaVp4DDsm5XDmrXzzIiRsQ41M
	Bd8wovYL0HPc63k=; b=PY7XrJJrsXfRNtrLiP+y8AzLq8UWJDh0hWYCAPbylrKO
	ZhD/EfDHC6DO8DlH74E5tWO+FA5dABCri20eXBPVufCyeQqeIb8ueGbOzOPP8NNo
	0U0ObciyKH769UNd2BCS3b5DrAh0CoNGDWHbWfA6ZDNyiF3qbQMjHmh8Tdr7Vc4a
	G62ft1ZfyRATFHfXJIsDQGhFPZCGsP5oYcmgB9aEuN4O+2DbvnEUaCJ28f/IfYlQ
	v68gR1jPPlJOY1xm2d8Zg6XmuOM1g0fRomu0s5TXyH7uiRJ2e0Z2y3G8E++P28Kg
	5m46aJzlNLucOe0Vl1M7xqOVehC/9IxdTPh1sg2X4A==
X-ME-Sender: <xms:PEnOZWy4dtjYb9d4UjzhMR_4YNvtHPoLV5N2cg3pqjoWXZfdkS-z6Q>
    <xme:PEnOZSSqw8clnXMTGbF9nf7B7Od3dW_Z3t7eAgaebaMs7bcz7hLXZ4XC6nUK05aHC
    d_7786oOPrljpVV2Q>
X-ME-Received: <xmr:PEnOZYUhvOF-93tzwp-TZEDXX9EVhsj5kn88aPnuKcVIM6gVzREfl9Qk2mgfCa4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuehrhigrnhht
    ucforghirhhsuceosghrhigrnhhtsehmrghirdhrsheqnecuggftrfgrthhtvghrnhepge
    eiteekgfeihfeggedtgeejgfelieffkeeivdduvddugeffteefleehheeiiedunecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsrhihrghnthesmhgrihdrrhhs
X-ME-Proxy: <xmx:PEnOZcgvt6RMXe-88_UaLxrd1GQIcVXg3JNzra9OcCAZYQ1hO6dIDQ>
    <xmx:PEnOZYDMkG_rvOkdFwFmyhYJXNW9Uan2dUGIMusCnfZUNy9MUJtphQ>
    <xmx:PEnOZdKuSJ-QOKAQL-G97vRUc266nyFo0FzD1nWMT9zSNZr60HYg0g>
    <xmx:PUnOZU7JKRoa3RCYnwzZhT9rW83puDlToT2AjYxOziGqNjRcsDycrg>
Feedback-ID: i891b436e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 12:26:19 -0500 (EST)
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
Subject: [PATCH v2 0/2] Add samsung-milletwifi
Date: Thu, 15 Feb 2024 18:19:47 +0100
Message-ID: <20240215172617.115307-1-bryant@mai.rs>
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
- GPS
- Display
- Wi-Fi
- Bluetooth
- Cover detection
- Physical buttons
- Touchscreen and touchkeys
- Accelerometer

Signed-off-by: Bryant Mairs <bryant@mai.rs>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
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
 .../qcom/qcom-apq8026-samsung-milletwifi.dts  | 568 ++++++++++++++++++
 3 files changed, 570 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwifi.dts

-- 
2.43.0



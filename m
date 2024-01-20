Return-Path: <linux-kernel+bounces-31807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 497128334E1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 14:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AFA11C2137D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA0AFBE9;
	Sat, 20 Jan 2024 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="B7o8g2ge";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OU0Y1Li0"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C35EEED7;
	Sat, 20 Jan 2024 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705758946; cv=none; b=lzHMFAciTrw+EmOcmvk2onjVfVj8o1mxOnYTO/epFpAS0EwVu13ypOqQx2Z1A2iYYDq44yMFChdjmSaPidOmK6WT/Ej/FRfv8Y13d/Or6jmWvQQN6o06ZNfR6gDeDfDS+W4Bok+jgUW75XZOJdHDxCcx3+s9EsXU/6wuQBb1wxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705758946; c=relaxed/simple;
	bh=BWC5RH22RQmNpifbhKrxSu/ykLI79UCxDTBp1sCJGV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KR4bukDhw4LA19zRQo9GTcHCNyl7WYfbx7gXRvKlcaQL7k7Iq0QGYtGTO1hwkjRd3gNE9ytavyxi1Yer2D5nhG0ztYP8OioDP52lhV4BMKPt9+lXczt17as5csF+E41UWrtxeUM1M6u6Lofq02VKtjvF6wzrU0xVR4/dWTG2sEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=B7o8g2ge; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OU0Y1Li0; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id ED64F5C00FE;
	Sat, 20 Jan 2024 08:55:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 20 Jan 2024 08:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1705758942; x=1705845342; bh=9ijthPNIeb
	SJSQYxWt79GWhaSuh0UMR6m/aWq9NGuS8=; b=B7o8g2gesQQ32xjebrNMFDgsxm
	owB+ZpUxM9FAqJrQ+5okB6KXgjJ3wW/xZb0Cgj/q7Xh3IzdKBb+WdY1rpDKfSnm5
	u6uRezdKTylz9hjbm/0zgrJWgNGPCyi/VyZ5vpIKgJaKcXEXaTU8c3avnP/1EaEK
	0YH7TddjoglH05Ubn1yUKSGUUrtO2Cyyk4V7BQ/nK1GqO5et1yCzFlJEA8tfXAvp
	NnITfU9huOIGnU8KdYDmhNJtpZMNgOeI0FGTmPrZO+bgVegAyOVEe0Svb1Pm1dMB
	zAXjUpR5lTPCrJI0IqDXrY88+UhCDd7CXqsb9DArlbRQtYBama74rr9fPoMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705758942; x=1705845342; bh=9ijthPNIebSJSQYxWt79GWhaSuh0
	UMR6m/aWq9NGuS8=; b=OU0Y1Li0hxUHJREOnyBxc5an8vQDj/Uo9VfyvhaQCv1W
	SDePqeI3lwRBZDTsjaiKKHzIIb5ToASCc7rrWrojkbnWYD13CotL3fCdDVPCtb+n
	00BmSc1BHhrUxNiyqbE7Syl9VU76rD/fjo8Q4yFKyL5p/wNun5K+dj+lTPHXOOcr
	0/uZRSECpmPrT+JgjvncNNWUbBAwSjU5I8NjX0wUATyvCMaaD282rSCawY2u9b57
	+ezLyVuT/Y/y4x1mpKKc3x/qynRQS6HhxTpRS01Q6x7w+pV6KtTTXz1Rsr4HACRw
	/SpHSUpQln7of2gHTXwnRDWfxAgddQF3vsrJEmH6JA==
X-ME-Sender: <xms:3dCrZXv1F2HmI57sidI02oSqtT-nFZhjGbs-4LA1k11tSZJ_5EXWIQ>
    <xme:3dCrZYcjGh2bi5rr_gVLFG4kISKKPegQDW3JeIzYIfmUb9Xn8XlycF0Il30wAfVdV
    RTGttktMw>
X-ME-Received: <xmr:3dCrZazC4KmsbSxJ_ttpV9EQFCJhXLCNdVMd0kqWCafELus_Tm8Ak8wRVS7rBOfOvoLfZH4G2N_c-baD4Zz9vBOAnYWX7fvzX94>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekvddgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhimhcunfhu
    nhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrhhnpe
    duhfdtveeujeejjeffieevgfdtudegfeffvedugfetteehudevteehtefgieeitdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmsehfvg
    grthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:3dCrZWPXDCfzkzvJdXYL-p6xCSBkzIp2bAiuM_bjyXnZ8mB6nwj4Fw>
    <xmx:3dCrZX9rgs8fogj9mBDx1Z8_fnTtf_w7sBwkLXhDu7y3CL-nYlUldQ>
    <xmx:3dCrZWV7FkMM4D8wyQbw_xxENwLqvjg3NwC9e6pEw5iYAn1tqhI8AQ>
    <xmx:3tCrZdcUaUbI0E2FAWcAERSsCeRIsOhtBAySSvOdvtZ5lkqBAQpIJg>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Jan 2024 08:55:35 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation); Sun, 21 Jan 2024 00:55:30 +1100
From: Tim Lunn <tim@feathertop.org>
To: linux-rockchip@lists.infradead.org,
	conor.dooley@microchip.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski@linaro.org,
	devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Tim Lunn <tim@feathertop.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Chris Zhong <zyw@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Zhang Qing <zhangqing@rock-chips.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] dt-bindings: rockchip: Add support for rk809 audio codec
Date: Sun, 21 Jan 2024 00:55:26 +1100
Message-Id: <20240120135529.899403-1-tim@feathertop.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip RK809 shares the same audio codec block as the rk817 mfd, and
is compatible with the existing rk817_codec driver. There are already
about seven rk809 based boards that implement this codec in existing
device tree files.

This series documents the audio codec properties in rockchip,rk809.yaml
bindings and updates the example with their usage. It also fixes a typo
in the existing example that was causing the example to be validated
against the wrong binding.

Changes in v3:
- split out clocks into separate patch and group example properties
  where properties are introduced.
- Address review comments
- drop clock descriptions that arent required
- set maxitems on clocks

Changes in v2:
- Fix vcc-supply warning detected by dt_binding bot
- Fix missing include and pinctrl for codec example

Tim Lunn (3):
  dt-bindings: rockchip: rk809 fix existing example
  dt-bindings: rockchip: rk809: Document audio codec properties
  dt-bindings: rockchip: rk809: Document audio codec clock

 .../bindings/mfd/rockchip,rk809.yaml          | 42 +++++++++++++++----
 1 file changed, 35 insertions(+), 7 deletions(-)

-- 
2.40.1



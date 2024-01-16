Return-Path: <linux-kernel+bounces-27412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C50E82EFA0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD57C1C2341B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684651BC57;
	Tue, 16 Jan 2024 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="tJXofF7I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="coCSC9Jg"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9D912B7A;
	Tue, 16 Jan 2024 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id E51075C01A6;
	Tue, 16 Jan 2024 08:21:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 16 Jan 2024 08:21:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1705411275; x=1705497675; bh=YOvwe5sp9z
	vUo6Rpj6VCafW5qclDGLNfQgRXc/raG44=; b=tJXofF7Ipkw9IK/+JxHNfSGWdP
	lOwP71PTukALc49FwudQYa9RTAEE6XZOXPiZm3ZnkJV+koW2pKoeB9TtM14jicXn
	c8FfOdy5O5kOWjwKUGJWpfqoc+YSbxupMNrDTv+DQ8nB0aegAqzCSX5pZvTVtdxH
	hw83yEdDdfX4Rww0Uo6ET3hl/FhJErlcqlmlvv2DUFL3aDebk888wSH0c9Ybn/KM
	D2FZSlEdyoJm/mEw4c7tuo6FOJaKuhVeOaCBylyB+GEF9fiFEinxRhKWS0UGKy+9
	KavjiDHQp5RHpBLRcDRTkYb2plo2sb33dmPlJ5jL2ENjUIzSIRZSluqy0rhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705411275; x=1705497675; bh=YOvwe5sp9zvUo6Rpj6VCafW5qclD
	GLNfQgRXc/raG44=; b=coCSC9JgdPguzEjD1s1erwzPKwp3oGEA93/64ie0+gOd
	FIQK2jUjesbOnd8EhD8siya7S4kh+qAqdzGSpKBBFDTwIpnud61fAMrd5KFHRG4v
	6N+6G6zOK8Q3upYCWcGjCyCszIWGp/49OZrMH2RSaqgNjgjuR+XgVn78a0nlPc4R
	HFSPyNr6lc6MaCO1FAVsyCt3G3rFND97a+Q7G1tOV1Fx+kWY+ImA1XW8j6bdlc6+
	zRtDzXWE9l2FT1h2TQ70jPsgRDJ+GqlErqIRhdbcg6SYcJGcrX9w5i2eQyb8VTce
	PIODkZ0tbbi19jTA2GUzqTvPE11SVOdsSmWuLukUEw==
X-ME-Sender: <xms:yoKmZXdRgGyXIjljxBNhU8oRTdbv0-x4yRJ5oRQSLh9Yr1wtWYd_xg>
    <xme:yoKmZdO1fQ_oelj3FNYr-b8-6xTaJF51ATszze5EytCGmY5QND-U02JUbsL6sMZsY
    lczn_2YzQ>
X-ME-Received: <xmr:yoKmZQhVxhmUkgP_amlnDQqa7SfAV0kl_tC5tZmt24fwhv-77ZYif-oHH1W7s4sY6h14kYPuSB6H3aGU8oH-IRtUT9gpoUD2LqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejfedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhimhcunfhu
    nhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrhhnpe
    duhfdtveeujeejjeffieevgfdtudegfeffvedugfetteehudevteehtefgieeitdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmsehfvg
    grthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:yoKmZY_QGsJcWHpSm5Qi8aZCiLiH7F3Frxi1wRwqaKxtusaObZPH5w>
    <xmx:yoKmZTsL4z6e3OiDX_G3IBYLo6WxbDvFfB9PQNCE3jFzTB3yQEJCNA>
    <xmx:yoKmZXFmDcilmX18hs_8zSHEhbDv4QxOHeDKR5ta7hJuRnl9KcttYQ>
    <xmx:y4KmZUni3oRHt9N_TyfKBAIyuu55VVtd_B3O1-H6CDBVmfd2ULrjXQ>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jan 2024 08:21:08 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation); Wed, 17 Jan 2024 00:21:03 +1100
From: Tim Lunn <tim@feathertop.org>
To: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Tim Lunn <tim@feathertop.org>,
	linux-arm-kernel@lists.infradead.org,
	Chris Zhong <zyw@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Zhang Qing <zhangqing@rock-chips.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] dt-bindings: rockchip: Add support for rk809 audio codec
Date: Wed, 17 Jan 2024 00:20:59 +1100
Message-Id: <20240116132102.3272682-1-tim@feathertop.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip RK809 shares the same audio codec as the rk817 mfd, it is also
using the same rk817_codec driver. However it is missing from the
bindings.

This series documents the audio codec properties in rockchip,rk809.yaml
bindings and updates example.

Changes in v2:
- Fix vcc-supply warning detected by dt_binding bot
- Fix missing include and pinctrl for codec example

Tim Lunn (3):
  dt-bindings: rockchip: Document rk809 support for rk817 audio codec
  dt-bindings: rockchip: rk809 fix existing example
  dt-bindings: rockchip: Update rk809 example with audio codec
    properties

 .../bindings/mfd/rockchip,rk809.yaml          | 46 ++++++++++++++++---
 1 file changed, 39 insertions(+), 7 deletions(-)

-- 
2.40.1



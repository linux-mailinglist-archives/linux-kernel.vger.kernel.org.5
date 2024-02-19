Return-Path: <linux-kernel+bounces-72025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E002785ADF8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3611F22C35
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D5B54FAA;
	Mon, 19 Feb 2024 21:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mai.rs header.i=@mai.rs header.b="PzcbEHme";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WqPazQyo"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E99C482FC;
	Mon, 19 Feb 2024 21:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708379211; cv=none; b=qB1xIdOj7rTmysyQhqeVSBK/EUN2mDVW3Y6s0sZ6+Xc1eSgcEtCXxBJA9c5XLPWZXupGzgyuCQEqViYLKUREEbv4rYv+SjyB8P+DGqLk4gxSdyOvqiAL1iHjq2uBos15TW77ubGaJUckQ0OT6xZ+Q6gdeRp1VgapxADzZDos0io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708379211; c=relaxed/simple;
	bh=7dNIONGfw8c2XXjF5qp+9x27wEYri99mOp6cpI5f8qM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqWxx9/5gfF9AP7nsQNgBA4Peuwhqnt8/xKhxxX/KpvvyO6icHM8bv5eJp5Z3UDBtVA1Tyo7qpEqbNfD6MJkaWQCpwqPpStd2x/hva8caW5H6p29z8+yi3Rn1HwLO+GK6znyiwMuIjrxRgiyh8Nvl1WTMjDuLplCCJf80eUz0lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mai.rs; spf=pass smtp.mailfrom=mai.rs; dkim=pass (2048-bit key) header.d=mai.rs header.i=@mai.rs header.b=PzcbEHme; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WqPazQyo; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mai.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mai.rs
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 5850F5C00AB;
	Mon, 19 Feb 2024 16:46:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 19 Feb 2024 16:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mai.rs; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1708379208; x=
	1708465608; bh=w7kcGbrAfPlLUWjYOO6KPjshmKNEIHE0dRljasmBcZs=; b=P
	zcbEHmeoC0G14o8HcdiZB0+r2g9b53QCO0/d4wyRUFnmB5jYuQw/NiQ+JK+jhr5+
	aKv6+QKMD79khcxiAhNVjZjS+Oagt5X1itwjlH8LwcLnVVDxzxrpyotQHWfRk6Yt
	eif+HqXG3qfl21NrAfBOmrh7Q7LeSAgyZmS1p5RxFTeABqfpxS8Q76u0mguzM7aN
	Vb0OCh2Lew+4XyG4jkvrrI4bToHqrORCmVKmlTkMDR/LL62F0cwBxPoXqywaCiNQ
	QL9xcl3DINTJ0Vup0e5XMoP5OTnLzDIvdVGoYSor9PjjJstmJtb0v7uaLIlAKUW5
	pQ3sC8OwxOkq9ZAY1ZiJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708379208; x=
	1708465608; bh=w7kcGbrAfPlLUWjYOO6KPjshmKNEIHE0dRljasmBcZs=; b=W
	qPazQyoB9cAEgL9WACIltk/mpx9KbpZDzRUeovQFCHZr7bxe8LQYrbVTJ4BmQPYo
	nu/yFQmcEPICFK4gfcqGJN+t62KUwUvVFHQfE5iGPYobBJ0IhWT/FqhZBGF2EfG6
	iQflLzApFiDQQR76VO7bWMZSgNh073S0DPF9+xRyyIJgEbXJ1R/3wyjk8wpkKfYd
	4N0o10zU4tptWLrY8jgPvi4aJWayeOqED4oZylv8oKdFIiImag2bxoKv0s9wfjdc
	6Fo9ywP8g/2naKXc/37EsiU6Z8kyNuZrQSqV6h/W1Vw/tgyA74UhIlW/Mjt+or3m
	U1ZBnLaZTio2W/lYfO5RA==
X-ME-Sender: <xms:SMzTZW7-OHr3izgR3QsnlGzWUpBoEQyzCPg2V3s1S8QqjP0EiHW_4A>
    <xme:SMzTZf5EOXgBr0J1LHPYxMvhJhyI11tOWTaejxl0-4riMhNET7JE6kDnK4dHbX3Fx
    nf6pewpTm9wB7Ywew>
X-ME-Received: <xmr:SMzTZVfs5nniqfZXceHp76OSnibR_LKQ_HdqrvQJCU1yocEZSpo4QB6joPX3xiY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgdduheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehrhigr
    nhhtucforghirhhsuceosghrhigrnhhtsehmrghirdhrsheqnecuggftrfgrthhtvghrnh
    epffetieevteehteehhfejudetheegjeegleehgefhkefhjeeiueduudeiieelffetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghrhigrnh
    htsehmrghirdhrsh
X-ME-Proxy: <xmx:SMzTZTI3wPbkh1b3MOLUiJAqUXbcEbNEuCQhIblgOdYWxWg_3qN8uQ>
    <xmx:SMzTZaIwyjs2HMo_JtClculsgqELghB1QlJ8OH73JRToUTzP0n0_2A>
    <xmx:SMzTZUzdBu-5WKlOFiXj5jH7Uz800W9PUGdR01Ye__05AXELzG5EDA>
    <xmx:SMzTZcCPqnVLVnVTBpJOKmVzHUMFkk37arAgIBq40gcWlCbPK7n-Dw>
Feedback-ID: i891b436e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Feb 2024 16:46:46 -0500 (EST)
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
	Linus Walleij <linus.walleij@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: qcom: Document samsung,milletwifi device
Date: Mon, 19 Feb 2024 22:43:16 +0100
Message-ID: <20240219214643.197116-2-bryant@mai.rs>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219214643.197116-1-bryant@mai.rs>
References: <20240219214643.197116-1-bryant@mai.rs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding documentation for Samsung Galaxy Tab 4 8.0 Wi-Fi
tablet which is based on Snapdragon 400 (apq8026) SoC.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Bryant Mairs <bryant@mai.rs>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 2b993b4c51dc..c11bb2a81643 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -104,6 +104,7 @@ properties:
               - huawei,sturgeon
               - lg,lenok
               - samsung,matisse-wifi
+              - samsung,milletwifi
           - const: qcom,apq8026
 
       - items:
-- 
2.43.0



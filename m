Return-Path: <linux-kernel+bounces-67403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52F1856AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72211C20C7E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F801384B7;
	Thu, 15 Feb 2024 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mai.rs header.i=@mai.rs header.b="MojeDEE3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UVqgCMJp"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D896137C5A;
	Thu, 15 Feb 2024 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017985; cv=none; b=ruh/qnubaxcIRnHTFjZz03rQ3IuYPYpAKIlwqlJTLFD6txLE+6WSIVwWcAQZ1HhCXlxOkpj5DVluvvaCmUAPijC8IY8gar2JHlsUz0A0jfyhtevRs3YE3ROnLG2W0PT63NalncYQRZVGnOmnEXPWkgt3bPEluGtaXZr6FfFsqzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017985; c=relaxed/simple;
	bh=vHW2SdPx66QaVHd5OEKrzmd4YCLVf3sAAhYcAkajZEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eu2ZkwvspOVJ8LUnq9URqgdP43+eDPoUoJxkHLAbPvn/nQNbiRLMg/W8vfRRJ9MJhUoHv7bDsX6aVuYyDY8/DrVO65+2bSn6+6QNDNWWnt3djCQGI8OfWwijb09NnBqXsQt7dWPqSXj9/ZLgcnRkJom6kmf+79LT/S0ylK1VjeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mai.rs; spf=pass smtp.mailfrom=mai.rs; dkim=pass (2048-bit key) header.d=mai.rs header.i=@mai.rs header.b=MojeDEE3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UVqgCMJp; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mai.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mai.rs
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id F017711400AA;
	Thu, 15 Feb 2024 12:26:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 15 Feb 2024 12:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mai.rs; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1708017982; x=
	1708104382; bh=ajV4Wfo3bjUkDmNJ54WpcCeMruSQx7HHmGTGNXffK7s=; b=M
	ojeDEE37l6uYeXyB0CSv2f5FxCiYPbZCZlhVHf/szvaZvK84+ZMtawhKM5L5S6HC
	AYQQpr3fq4uCQqXbiFfHVClINUtS2omWIWqy+/E5yQLsbfJL8lngiYXiwqyHMyQ5
	A+0rMetxUftxGNWYj1la+LjnLI3f7TDCMNeOBQv9vSmfI0+wWRukYsDrZPZW8AQV
	rREO+YlsEhcA5P8quBPobYVeY3LyI1bATmv+yWpsqf++eLgipv76h1x24oZxPzWi
	7ojmvR3P1mGTNJrfzoAYea9fABz13XkhOvSGXOTu9W1RFrn4RyFeBeVL8LIYq5Y+
	YVJ1d8OE/1R2zgZsbwddw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708017982; x=
	1708104382; bh=ajV4Wfo3bjUkDmNJ54WpcCeMruSQx7HHmGTGNXffK7s=; b=U
	VqgCMJpcoItABJCOkoL0q+DE4yCqObLpm0rd5rzH/4JsbuntWNYoB8CTCiTCC6sg
	BGnFe+hzm4bpUb5NywWo19mHfBXK91QzZ5Q6Z44//b2FETjzFuli8BRmr3wY+Cto
	MacJfNxvKR+FsaQpq9CPsonLT9NrgDaGDZgaTWPjqvJsvPfblGUZnYDoA9Z9bmfe
	IG0/CE09mUhpV37YH8xTZwGWZD5AjatkBc8pieGxXuvZz++Ocf7A6wmjTqT6/v1/
	6tSxTkVwTztITQDYGiH7mQe1ciyVmtodZpCI7Na58p1fytYMZYxuie5XrUmzsEu1
	gXANrV6p9Cu3RT9fcbBBg==
X-ME-Sender: <xms:PknOZa5OJXXIUwpQg9NZ6cRNvuChoSHvNu9N0R7HVSCMvKTD8p5OiA>
    <xme:PknOZT7w8BkNSxQZhQbGB36hFOw08AfgwjIipc1CpuIsZIcn2QRd8ZNcYXWb1sVYV
    w95AZxd8zgeTa3Y1w>
X-ME-Received: <xmr:PknOZZdW9rcl_gIF6X5WgxeRxiZNA0eUc0uh8WzLdmPL4GVBJD-ljKXJhjmfsiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehrhigr
    nhhtucforghirhhsuceosghrhigrnhhtsehmrghirdhrsheqnecuggftrfgrthhtvghrnh
    epffetieevteehteehhfejudetheegjeegleehgefhkefhjeeiueduudeiieelffetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghrhigrnh
    htsehmrghirdhrsh
X-ME-Proxy: <xmx:PknOZXL0xa-gOlKptpfFLhfmZEckaUrFD9Iz5YkWRJQzxzorE2BkNw>
    <xmx:PknOZeJEQyL-Z9uilnersqUVl1Ew2d5L5_d92WAS7wf8n484Bg5Q5Q>
    <xmx:PknOZYz8xQPckquX0pfU5F4VszNjN1-AwBtBljQ510YE1WHMlKegoQ>
    <xmx:PknOZQBurkl6gQNnwZgbyej0SbkbNuM-BnUfR2osD9voAwqc053INw>
Feedback-ID: i891b436e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 12:26:21 -0500 (EST)
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
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom: Document samsung,milletwifi device
Date: Thu, 15 Feb 2024 18:19:48 +0100
Message-ID: <20240215172617.115307-2-bryant@mai.rs>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215172617.115307-1-bryant@mai.rs>
References: <20240215172617.115307-1-bryant@mai.rs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding documentation for Samsung Galaxy Tab 4 8.0 Wi-Fi
tablet which is based on Snapdragon 400 (apq8026) SoC.

Signed-off-by: Bryant Mairs <bryant@mai.rs>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
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



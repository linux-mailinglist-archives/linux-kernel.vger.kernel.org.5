Return-Path: <linux-kernel+bounces-126728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D298F893C05
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA721C20BDD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2CA47A4C;
	Mon,  1 Apr 2024 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9UV/SI6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9787846556;
	Mon,  1 Apr 2024 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980676; cv=none; b=SqhSdOgG54K7JYnQzglOU4NHQzgwszu5d8ZxOYCQXAGjgtYWfX5slmDg16xXt36FuPFXuWHHeudjQBl0FuL8nOLp8Bj4fs1lN31jvVnVXXjFUkeAebq+svC0TfnamY7dQYT+bNBaJbflxTJLMr+bP+rew6VToYsSs2S0O0uN2jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980676; c=relaxed/simple;
	bh=gQyWe9opeUQSkJDFGJUnjt63TNsnB2Bwm4InukxdKdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e3sge6zDhvsZVoEMVN2dbTqz/MdnznM28UPC6/RmLP0YY5XgcEDdpK2XQCCCdwcPO5lonR6Q2sHFU3T6SfaZcWW1p4VLS7GUNeL2RJsnekj+YPkBOJF3z51uQ0005GAKx5c8h2u1QmOp0y61bYHLXBFgcVr+haZx8e+XestJhBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9UV/SI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE93C433F1;
	Mon,  1 Apr 2024 14:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980676;
	bh=gQyWe9opeUQSkJDFGJUnjt63TNsnB2Bwm4InukxdKdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I9UV/SI61wjYKBUCjkeEsc21SGYaIq9pU6DcphszK6F6UvvOvjPTitqZaUaD8HKWo
	 KTd8KkR9SvTV2bCEt71gwe4wA24gMy8X4vJVSc7tAlkJn2CVJUoS30afkPK4yxa+K8
	 dk9Nz9sbiB7Dx0nze6fgq5FpXPAks78d2KFkYvWPkMqT/sNNhcJCi8hhyQHAD7DcCv
	 0ydshRIoeCmjTgbrGn8g2VlWbXjNbk9QTlfxTE8PjsoKmRtCzT+SO1yY5YEdrtiAc7
	 G/QTwicGIpnftLvW+xKdrRVCiuFKtWn2Tg0Hx57EFglbAX/t6TICHjIwcEKXitxiaE
	 N/Fhzw3bZuzxA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 6/6] arm64: dts: marvell: cn9130-crb: drop unneeded "status"
Date: Mon,  1 Apr 2024 16:10:51 +0200
Message-Id: <20240401141051.98233-6-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401141051.98233-1-krzk@kernel.org>
References: <20240401141051.98233-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devices are enabled by default.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
index d48dd6bca6e5..5e7d6de3cdde 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
@@ -82,7 +82,6 @@ sfp: sfp {
 		tx-disable-gpios = <&expander0 2 GPIO_ACTIVE_HIGH>;
 		tx-fault-gpios = <&cp0_gpio1 24 GPIO_ACTIVE_HIGH>;
 		maximum-power-milliwatt = <3000>;
-		status = "okay";
 	};
 };
 
-- 
2.34.1



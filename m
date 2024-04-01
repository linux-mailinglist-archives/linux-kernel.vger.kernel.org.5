Return-Path: <linux-kernel+bounces-126710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28336893BDC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865E728212A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465CE405FB;
	Mon,  1 Apr 2024 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zig7SzoK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C83542045;
	Mon,  1 Apr 2024 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980565; cv=none; b=Ge9okm07cUIWJd/rrG4jnr1gvM33KuY1s9EtB5Y42SOsCdBIXf7IhODe16i/FU9JG1knlbB/QLW4/DQVoH21rT/y0zYFa5DFyo8Lh4jSiCrR4ylcgMgbWtqtyib5jLayc7X/ahqYe2NYt96QzyU92So68hzEOAz5XRejo1QQbgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980565; c=relaxed/simple;
	bh=6K/PinWHR3sTmDMjATthgmSTnL3+5Hm58yDFuv6xcGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AT43QkcRbqaKdqamkjJ3dSasdAH+1WS+o2KVJwsTF8B7kw4kq+YxRBCGvHB8eZUtVToxkcW7hPZ26kvInKZKZJTU+UhTUglYEsW9UEPq2H/mgPQ4qMpkDO81AHhMUwEy+6c12UDDcOYlfkNAM9/AxHXPX6U6U8xISVIxc4rmt/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zig7SzoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C771C433F1;
	Mon,  1 Apr 2024 14:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980565;
	bh=6K/PinWHR3sTmDMjATthgmSTnL3+5Hm58yDFuv6xcGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zig7SzoKTGVc5GuQP4chZcQ1YphrAMHZf7p/citd3xU3nNzFkio3wndCUTK6dLK2b
	 A3CHAxqmH/bNPzJbHVkkDcM1JonwV4AK+fX7O8VLwwlrEnbz/oBfZisMr3HPKYLDnX
	 R2guMuaflJLESsWbILx+icSw1dShlyl8vQ2ciue08Uhisf371B7dP0iPSkOlWvicNg
	 CNJT9sZdVzQLKQjd+bPPAtxi+nC1eeaQg7ZduMpYLm20POI1L68ZPlkpl3VzZM8ciS
	 KIU9A9dbZXP7vstC+LsNhTVWl7ou5tXWzJEuH8C54tkxq0j0BWZ62tmCYTkbzq45Op
	 /B7KE8zf6DTwg==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-realtek-soc@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/3] arm64: dts: realtek: rtd139x: add missing unit address to soc node
Date: Mon,  1 Apr 2024 16:09:11 +0200
Message-Id: <20240401140912.97157-2-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401140912.97157-1-krzk@kernel.org>
References: <20240401140912.97157-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"soc" node has "ranges" property thus add matching unit address to fix
dtc W=1 warnings:

  rtd139x.dtsi:50.6-120.4: Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/realtek/rtd139x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/realtek/rtd139x.dtsi b/arch/arm64/boot/dts/realtek/rtd139x.dtsi
index a3c10ceeb586..e8af39193e75 100644
--- a/arch/arm64/boot/dts/realtek/rtd139x.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd139x.dtsi
@@ -47,7 +47,7 @@ osc27M: osc {
 		clock-output-names = "osc27M";
 	};
 
-	soc {
+	soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.34.1



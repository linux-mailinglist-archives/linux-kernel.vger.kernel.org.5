Return-Path: <linux-kernel+bounces-92443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE48F87203B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99ED6B26BE3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5FE8662B;
	Tue,  5 Mar 2024 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaehtikR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BD085959;
	Tue,  5 Mar 2024 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645536; cv=none; b=k1xI/XyG8PnlqRGOnN0Eup0MwhumrCFwWyhFQ7cK3C7RVOGuONYNM48eZ4U9EBzTlFCCEspZ3cAZ8bV+8Q/q1eEM+ltalJ7sOOSkRTbGW3YDeBR6wrKA+KiKHQMfmC//XhQNV5Nbzpoz8jtBqBvre58LFcM7hcvsYeHNv1xvDko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645536; c=relaxed/simple;
	bh=j2QxGDEhq99RHC8PPIr7+4POEgFQFJ0Y8qdfPyL6lA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WocHKEVxmQ+s5NIWoJqzuNGljP4/3ZqJ+2PKiklKczxZfT82VC7Hqy09G2u90aLhDauLSxajjDj7vZAo5gBwZ9EzBayK6IAvManLuwPdnZ+QQzxNnjgSdKSSOf/puU3AMyQ06f5Qsm467/iY68GTS8GzXqiKBPNUQ4CzdV3v4NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaehtikR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0A35C433B2;
	Tue,  5 Mar 2024 13:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709645535;
	bh=j2QxGDEhq99RHC8PPIr7+4POEgFQFJ0Y8qdfPyL6lA4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EaehtikRo2RXGapAhCRTcyCb1PfQIuJNUcsejMGXdO8zS6aq7+ZRVInuo2vrbSWBd
	 ahd2Lt3oGM2A+AsUshzrMWZgyvObBfqrTFp6jeVUQ0G4heWXf1QFh3cK77ZSQl2h+P
	 kIHs19WPnXexq8aXvxVbHdyhWC82qWM7dR0Umfy3pJhVysGpnkNJ2IzZ2U6/zlV9tQ
	 L+FLcXjClaMIxIVkdfLtpzSSvl5NfPKBGrr1YM5qCx4STHdDL6QixVf/oiRmpYgiPM
	 kaullGnT4nLKHYivhE2qFsKjWPD6vutekgt3putW1fq2LDAMOtaKPL+UdJLwiMKhx9
	 Nc24YaD/m2Bkg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5918C54E5C;
	Tue,  5 Mar 2024 13:32:15 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 05 Mar 2024 21:32:14 +0800
Subject: [PATCH v5 3/5] dt-bindings: phy: hisilicon,inno-usb2-phy: add
 support for Hi3798MV100 INNO PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-inno-phy-v5-3-dc1cb130ea08@outlook.com>
References: <20240305-inno-phy-v5-0-dc1cb130ea08@outlook.com>
In-Reply-To: <20240305-inno-phy-v5-0-dc1cb130ea08@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jiancheng Xue <xuejiancheng@hisilicon.com>, 
 Shawn Guo <shawn.guo@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, 
 David Yang <mmyangfl@gmail.com>, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709645533; l=829;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=6dFyqSF2W3Rgkd9gq9kKKbV4XaRy0uRiH6eHrHgNDio=;
 b=+egDR1/Qmctv6w54Lz4Mc/tEJnd4aFHGjswWikeghXVIeMPQUH9OvB7sx50pFyY3OJOW1l2j1
 KBmBd29EgVRDveojk1lNQ383uT5vmXi1CgMIRh2a28RWPYldEE0DW4M
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Hi3798MV100 also has a similar INNO USB2 PHY with slightly different
register fields offsets. Document it in the binding.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
index ba82405ddf51..7f0811a2dc2b 100644
--- a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
@@ -14,6 +14,7 @@ properties:
     items:
       - enum:
           - hisilicon,hi3798cv200-usb2-phy
+          - hisilicon,hi3798mv100-usb2-phy
 
   reg:
     maxItems: 1

-- 
2.43.0



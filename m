Return-Path: <linux-kernel+bounces-64722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0258541F3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC8A1C22D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE01BA39;
	Wed, 14 Feb 2024 04:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="RBK2IUaC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sj/mhshv"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8744C153;
	Wed, 14 Feb 2024 04:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707883674; cv=none; b=isB5rZo9oRYglus2q2rFuqeYw9Nio0hK/7cL0zm7BtrWmkpuAl8ntkxNdDUPLOuioBGAywdCmj8ldfOLz5ijp9NcttK/aYLAwkwqx++nsH1geInHKBvkUAQXRrUXWd/xKoVvSnkspT5IzH1fwJQx/UqjWWxcfV9DPagbX4l4cDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707883674; c=relaxed/simple;
	bh=qPwgmLSzBZOQwKE/cW1mJxW1yPhS7I2984nFz6JbLBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TWFUeXD/A7VGpwum95avBN78J+ZJuirGnTa3oY5ztf663AkoSri5qoU2LvQemlhhsxFE/WH7AYTbmnjb8vLjDD7ch6dlzo0NkhprI+PIpdbo1gU0EaePZWsXeqQcBZt8A9j9LSj1uiEKDmJomHYLLT8VI8jwRUUpHyIlNBeMkqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=RBK2IUaC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sj/mhshv; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id DA17F1380098;
	Tue, 13 Feb 2024 23:07:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 13 Feb 2024 23:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1707883671; x=
	1707970071; bh=GWcf2ViSQbSAWLVPyT3EBLhQvOVzCrCtXD9HBxRw93M=; b=R
	BK2IUaCtxJeprbY7POmyAJaf98rvLnu4ZDHhe51nQGhMGk231n8siC/4VY6BiGg8
	7Udkz9Heh0AGyjehkJBAYR/Xn1twwxXyQVpAkH30hlQjNkxxd0G2bK5LWFJ1dfs4
	KiTYpK/rs4vUpP3/iBG/UCxlrOlDut8z1eFaTP36wC21JF4IfwL0xfv/xUUiMp5h
	pmhNyHgLlqP7ndds59bycGs4YXI3yIAqNaIs4cp9+r5DPskL5CL85qzrHEMhuHmm
	35hl6VdFMdLs9QxgjnQv/axkr+UGfqVAD5z2hk5b8X/dRxVlezJ76W8/iL0SFoT5
	5vePfC4uXtln2lCqzUMVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707883671; x=
	1707970071; bh=GWcf2ViSQbSAWLVPyT3EBLhQvOVzCrCtXD9HBxRw93M=; b=s
	j/mhshvQTEiXgCqN9mNQ5t4vSadKR9JMlGVn6MbFwy0A/DvvGeKeDM1F1d0j8J7u
	+AO1Y94eBfeCokrRXRG2QZMmzEeRrjSu21ta2oHKGavZMi/XvkhUnW2iUZcJnWAl
	8ClBFx1PkHh6cN8gIr9dzAJmAaEbiRh6rX3CcjfaqlHFh7TzwmEm7F4YfBTxBNt+
	N5WqcQoxxt2Ih9ibnl+8Eciy4lX/68mDxnxrTMHofh7YVf0HBvX5Ry1ANopQP6UK
	mUPhAxFMoHXdV4+wgqmtDwLpQUBAWRLqyNM94RGk1S5y7VvhSkp4QJ060Rx7anVH
	kc/86PgzbewDkT7aA46UQ==
X-ME-Sender: <xms:ljzMZUnwfskBm2GxLZq4IbaJ_cTey0wqGd79RL5mBZiKq1rvd0pQrQ>
    <xme:ljzMZT0BMPA0HcfLzrwXSxwidRdsaXFPbK2B0_aSkfBmm4I0tWl8y2HCB0b_ph2Je
    f0qfIAYzA>
X-ME-Received: <xmr:ljzMZSqtKWeRZouAVRGhpFcNXHr0b8Sg5J2w3sljJYoXN-fYavbMnzRjqNVY4iejr-nUKIjC0diZhJd5sbogDhehNonT_I46rrI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeigdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhmucfn
    uhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvghrnh
    epfeffuefhteegieekjeevgfdtfeethefgvdfhteefueffuefhhfefkefgkeegheeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhimhesfh
    gvrghthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:ljzMZQnj7bHbsWDK3g1bf1v43Q0N1s0gSR7INWMnIw5OCuY7G8ZJMA>
    <xmx:ljzMZS2F09Iwxg7c6nfYJ7_4FPgeUy5GvgInn9KPiiYEXhlFlBEKBA>
    <xmx:ljzMZXu-GBoF1H3PxdOYqtjQxT9gGc4WYQb99zBaZIcKxBcsi68o0A>
    <xmx:lzzMZcOQhcTjQURBhesDzEwxBXCGNtetNs1Yr2b6HSDLlZuBQo0FhQ>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 23:07:45 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation); Wed, 14 Feb 2024 15:07:43 +1100
From: Tim Lunn <tim@feathertop.org>
To: linux-rockchip@lists.infradead.org
Cc: Tim Lunn <tim@feathertop.org>,
	Andy Yan <andyshrk@163.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jagan Teki <jagan@edgeble.ai>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Ondrej Jirman <megi@xff.cz>,
	Rob Herring <robh+dt@kernel.org>,
	Tianling Shen <cnsztl@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: arm: rockchip: Correct vendor for Orange Pi RK3399 board
Date: Wed, 14 Feb 2024 15:07:28 +1100
Message-Id: <20240214040731.3069111-2-tim@feathertop.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240214040731.3069111-1-tim@feathertop.org>
References: <20240214040731.3069111-1-tim@feathertop.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vendor for this board was incorrectly listed as Rockchip. Fix this
now while they are not used anywhere, in the future they may be used by
bootloader to select dts.

Update the vendor to Xunlong.

Signed-off-by: Tim Lunn <tim@feathertop.org>
---

 Documentation/devicetree/bindings/arm/rockchip.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 5cf5cbef2cf5..29f922f3ca4e 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -626,9 +626,9 @@ properties:
           - const: openailab,eaidk-610
           - const: rockchip,rk3399
 
-      - description: Orange Pi RK3399 board
+      - description: Xunlong Orange Pi RK3399 board
         items:
-          - const: rockchip,rk3399-orangepi
+          - const: xunlong,rk3399-orangepi
           - const: rockchip,rk3399
 
       - description: Phytec phyCORE-RK3288 Rapid Development Kit
-- 
2.40.1



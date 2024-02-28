Return-Path: <linux-kernel+bounces-84725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB25F86AACB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38F0AB23A4E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD3744C64;
	Wed, 28 Feb 2024 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJe6AZHW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7F32E419;
	Wed, 28 Feb 2024 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110947; cv=none; b=cmK6L70FWwqTyMTMuuMGc6wkgLK+r/HoJffSbrPpk1W989jMhHoVAltfTRNyY3qrJl6M/guomjFnIwL7CL0cWVbgSd2gLI1ufDazLBDcsZqQ0I+ULbuaQ5Tva5kFmzx5k9J63X/Ld15Y+kPGGv5Zh2sjs0v4LoaVNxN4Q1+vsZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110947; c=relaxed/simple;
	bh=bb2xZt+30fqdXEdZ9V7XtTzgRG4KIIUrzd6gD3RtxUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RHuDxbADUBdRAZEhcDXeM87fvz7uW03P2XsatOGu7vXewydjUexBRRXHvm1MKEBMTCvqk69QxeQqEYxtH+NUKk87fo/CeeIcme+7M1ezGdQdhkCpRU+uUcD9wt1I8cGc15VwJKNR4kyYjq6DXg7t5rxCbXMPgsMMTqRiLo1s9oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJe6AZHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 112AFC32785;
	Wed, 28 Feb 2024 09:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709110947;
	bh=bb2xZt+30fqdXEdZ9V7XtTzgRG4KIIUrzd6gD3RtxUU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IJe6AZHWruFwI13hV/BLDkWWC4Zg9e7yGwGjIDoLUN55BQxAN/UCL0DKWQCNVrukC
	 MSKCvLnlS+HRKbW+WoTMdGvDAIjiEkTY3xJpj/b73aOJMTHaGD9wFATSILSk9QbqZq
	 wh/u7QqUofWJQb5DoIexBVqz0B2w1bU1mcWldceIM/3t/17Vz4lhRCPAwOg6UTdnV3
	 c0IQQGM0g4Q9Gos3R34KZplvZV7vzlYXwCr2JMGKKSXrbzzhjShMnkOAkzlWk2Pt89
	 zcuMnU+8k8TKa7HmZs1Qn4B3Ex55Jk83dSYCJE0Vk9A86/ViL8SkQ96FlIVTvp9Qfp
	 5HHCTojUQOEaQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B2BC54E59;
	Wed, 28 Feb 2024 09:02:26 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Wed, 28 Feb 2024 17:02:33 +0800
Subject: [PATCH net-next v6 09/11] dt-bindings: net: hisi-femac: add
 binding for Hi3798MV200 FEMAC core
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-net-v6-9-6d78d3d598c1@outlook.com>
References: <20240228-net-v6-0-6d78d3d598c1@outlook.com>
In-Reply-To: <20240228-net-v6-0-6d78d3d598c1@outlook.com>
To: Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709110945; l=785;
 i=forbidden405@outlook.com; s=20240228; h=from:subject:message-id;
 bh=COJmDTQSvWrCuczgOVd8svTjkGxYhL4n6fAjqOWpCZY=;
 b=BRBk7J2qE7S7G9bi3QzqNa6odKfDqKNHbp6g03RevnuAm1PXeDcjwIgnbEdnYWEFqlTmbOifA
 19dDDWgGvMLB/B+5oXomn3RkmpCFsYbrlxZX/8FveA2dg6TOXj8zObp
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=KAWv6ZzFsT54MGllOczJgFiWB+DuayEmyn24iiVVThU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20240228 with auth_id=136
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

HiSilicon FEMAC core is also found on Hi3798MV200 SoC. Document it in
binding.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
index d56ff8538a86..0e5e62d2b8aa 100644
--- a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
+++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
@@ -17,6 +17,7 @@ properties:
     items:
       - enum:
           - hisilicon,hi3516cv300-femac
+          - hisilicon,hi3798mv200-femac
       - const: hisilicon,hisi-femac
 
   reg:

-- 
2.43.0



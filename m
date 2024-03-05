Return-Path: <linux-kernel+bounces-91840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBD4871764
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DB36B233A3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ACD81745;
	Tue,  5 Mar 2024 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTCXQn3u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E980B7EF10;
	Tue,  5 Mar 2024 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709625073; cv=none; b=q6ktrwyLygp80TvSoAcKptWXN4SOzihvJ5C+5//CDfm7hsA57qVLjKjI8EqnCKesnAQ4ua7Hy/iLRYrg8vn5KndfpxWas4JmE8jpQSH/PcwIggSmYQjvhSOMsSvqNTmOXNn8cV0cXCfBpj+sxGmwJruwVt4tMOXPB9Zgs/2gs70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709625073; c=relaxed/simple;
	bh=gkNA5inb3gzyItpjdDTlzlxSK3vaHY84ceRjoy9uGP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NiQMsGEh9CuU26bxm72D7+SUWDQzHuQMz7LoVv3RFejPU6LsH7gigJjbMlozZmFVfwu0VPtIowrahmg7E+me1hmFU4qyMqFFpSwpHXKERjr4udu+g4AC9HUhhRfrZPNMlNF80qDUItPYrbKTrLhNGM8qCzGakaKAY84W3yeTxdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTCXQn3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 754B3C43142;
	Tue,  5 Mar 2024 07:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709625072;
	bh=gkNA5inb3gzyItpjdDTlzlxSK3vaHY84ceRjoy9uGP4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZTCXQn3u6QdWpy3Wi7JsZVX7JO/AQHvrrbQEYvN3odNDv/5D6F+CQNcHlsNj9RfRU
	 kq3dYd7oJE4i6N6sBiLBORo861JBAwDNaeQXjxuSNSu6CPFelAKbbKTlLzqgUksaUT
	 7KePu/nq3UQVyafQS1ljZmIS+jcbpHiwSSIGWh6wzKqPi/U9GZFVm2j73CTSaOTXAq
	 RYZt+meNFCu2mSG+VDrH0mRx6KYr6Xqiu6NP3wk8XXgYmhMCXCvswonPlj+zsPM0Cl
	 5iBdnO/y6hK+9o0Kk9s72QL+jGOlRZp2PrlUHoYbjk0WO9H6LqGELcLWU7acdE5L0s
	 d1EueQJ/3icLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65001C54798;
	Tue,  5 Mar 2024 07:51:12 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 05 Mar 2024 15:51:15 +0800
Subject: [PATCH net-next v8 6/9] dt-bindings: net: hisi-femac: add binding
 for Hi3798MV200 FEMAC core
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-net-v8-6-166aaeea2107@outlook.com>
References: <20240305-net-v8-0-166aaeea2107@outlook.com>
In-Reply-To: <20240305-net-v8-0-166aaeea2107@outlook.com>
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
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709625070; l=785;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=oXZR+lwkSXsM/Qjr88QbgRS9lNfkCukHdVr29JA1ajo=;
 b=itcoDlV36tm20BWjf6gNCXqr5a/EwpHWRe9U6NEoM3heTV4jVsE2/xYuSJdjKLdVwoCAAziuC
 2v7rlQJvjBCBsTybsyTlUvayc42I/YXv3ivj56LRXaIRyndawqolbAt
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
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
index ff6b090ed34e..4f51c5ec90b3 100644
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



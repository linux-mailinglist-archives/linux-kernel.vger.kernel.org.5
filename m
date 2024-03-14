Return-Path: <linux-kernel+bounces-103528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE3F87C0A9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2BA282A8E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86FB73178;
	Thu, 14 Mar 2024 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="xp0HhZIj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="wly61FZx"
Received: from fallback3.i.mail.ru (fallback3.i.mail.ru [79.137.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C97818E20;
	Thu, 14 Mar 2024 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710431647; cv=none; b=XvzgqjwAQFLg9ZjV2MyIsVyvY4oiZUF2nMKYxLsG54L8Mq3qQSYTg224biRdI9eI4LX+waPpXDb7E9IQAxLqxFEMQiFCmU4rizySX0P10A25hk2YjH2Kbv1jqkwS4UmdZ6jDz1+4yWCA9anIE8GLP67ngQ8XU4exV6WFMoLXWsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710431647; c=relaxed/simple;
	bh=+j30LRvuGHqE7HBb4akmSSbhqJww4uAZqRDe/hf9WNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tQbvcuA1d3ySleHr4L9m9owaw/LAZ95NA27y1xNySr68u5nPerOhwfSGKXAwbJeL8G82aCBVt0hlml6Yd1Mg+HLDmGGb3SwPDLwCTkB+nczZc0hqCQZB4adaNTm47yKAApi4hetLey0rY6xR8Uxor205sFHZwUiTxmKtwMWs2aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=xp0HhZIj; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=wly61FZx; arc=none smtp.client-ip=79.137.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Dt/BJ8xOR6hRD8ABYOTFm56uFr9XBUUszh6WQrGnBi8=;
	t=1710431644;x=1710521644; 
	b=xp0HhZIj8+cZuJYYLAnkyayGeoqXAtIqFP0YO7HHGEWhjIpwi1kn8tMJ9eFXhsI8VMKf9FE48dh7hPRciwmvOzn3L8evGpxSeMUBp4+JxGH8HCJANTIod4JYyvkMseZvd1tx0EszS5ideReTMbgqoYD591fcmgx1ffM6d9ZLRkjKjpqJoVNzG9Ws9PGKRHXnOrtR/TZPtzKH9uQy9+05W6n7S/WFsBpxKuLVcAJfB8yB+sBsH/BSKwuIEGZ2xzydhv7251Bp2aQNrI1fft21LTnIFEk2RL8Jh0zcBQYldmjfYalLlQTy4/6YpnncMYdH/n3mFxuKAqvg/pni6RY36g==;
Received: from [10.12.4.6] (port=54220 helo=smtp32.i.mail.ru)
	by fallback3.i.mail.ru with esmtp (envelope-from <hitechshell@mail.ru>)
	id 1rknP7-00CNO7-9h; Thu, 14 Mar 2024 18:54:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=Dt/BJ8xOR6hRD8ABYOTFm56uFr9XBUUszh6WQrGnBi8=; t=1710431641; x=1710521641; 
	b=wly61FZxWsM9sBEy4xI7ycxdlt7rFjfe/E4mupsdtaXLBosKNYCu6s14Hvw+oWr+K/xaP4oZ3ff
	YEOq08Ll0TLg5LQDgs0ShOpXqWPlJVbcYaas5d4zsVSOVrjNw3KTHxprriI1cPRcFI18rv2E7HLtA
	GxUWo3OFpRMB3U7t5eMc2ODTw0ULRx2O9okvJKOS0cl7VjF8YGTpbWR0UfICvgi9hz3m4vIkmOavS
	iad3f4IPk1H40vVWBNLcjkpny9dpjAbgU5BtOvsGj0q4S8MhV+OnuEpXBWGFJq9idpsD1B++O5TTD
	z66FWiZ4EHOogbdESVhZUgEe9kTrMaZIdFaQ==;
Received: by smtp32.i.mail.ru with esmtpa (envelope-from <hitechshell@mail.ru>)
	id 1rknOt-00000007WvT-09Si; Thu, 14 Mar 2024 18:53:47 +0300
From: Denis Burkov <hitechshell@mail.ru>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Denis Burkov <hitechshell@mail.ru>
Subject: [PATCH 1/2] dt-bindings: arm: sunxi: Add PocketBook 614 Plus
Date: Thu, 14 Mar 2024 20:53:05 +0500
Message-ID: <20240314155306.11521-1-hitechshell@mail.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD987C0EE6E7F0A597D21AFE2E000C69B1FBAF020A234192257182A05F538085040B460D2F1FC506B5A91417EB218679B82283679ED793C6075A626F5E7A5DB85024868178014C6CACD
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE73B44982FA5E78411EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637E1B356F17606A5B08638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8CE85A9EAFAB6BB6A216C4BA03E6A86A56A4FC8F65B6B2C4020879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C07E7E81EEA8A9722B8941B15DA834481FA18204E546F3947C64E7220B7C550592F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063706586D6E6283AEAE389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F7900637781DD771F5A5B9F4D81D268191BDAD3DBD4B6F7A4D31EC0BE2F48590F00D11D6D81D268191BDAD3D78DA827A17800CE7C721D8A86C020C7FEC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5278DA827A17800CE7390FB772827C5A6B2EB15956EA79C166176DF2183F8FC7C0F43AACC0BCEB2632725E5C173C3A84C306E6634A6CB1A5BE35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A547F0AC3D6A09ABD75002B1117B3ED6969DC4E9342477F165B2920F75BA9A967F823CB91A9FED034534781492E4B8EEAD5C5DFC4BFF39B799F36E2E0160E5C55395B8A2A0B6518DF68C46860778A80D548E8926FB43031F38
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFFF68005373D2F237942C13613764E4AC3D1AE296441560B7CA8FBDC4BC2FD04F768602CF99B169967C77D8D956826D3353AC3A3CF8C59B49A570E4E846A1ABAD829779E884EFD0E742BF32D1DA1046D202C26D483E81D6BEAB6E9BFA52983102758FA77D78A604EFC3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojXiTM5LlaqzJYDBtCAoQ/Dw==
X-Mailru-Sender: 7219FA8B682B638D379344632618B47A1B17C5D1FFC949FC66B41F5249512E9180B87DBA1C6A6B16DD7143E30D734E3D46315093CA775BF3554C0F224C5326CDBE1FA5EEA7DC04A0851DE5097B8401C6C89D8AF824B716EB5DB38D7CCF7198FF1D0BEC28C16373053DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B485448333635D8AFAF2FD4A3C9FF394F5AC027C2622A123E1049FFFDB7839CE9E436D59F16A22D110C8E214B0619F2A9BB497EDD552E1633AD4C903DFE5C2A6B8
X-7FA49CB5: 0D63561A33F958A5F2B08E73FD5D8A9A2305DA89DE4EA26AC6CF61D7CB8E3FFFCACD7DF95DA8FC8BD5E8D9A59859A8B6EC0BC6DB5D5D7B8BCC7F00164DA146DAFE8445B8C89999728AA50765F7900637889750A55773577B389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8BA7556051D6825FBF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE7040597DFFE1F52DF731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojXiTM5LlaqzLsRk86nQvPsg==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Add a new board name.

Signed-off-by: Denis Burkov <hitechshell@mail.ru>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 09d835db6db5..43491e7f8a5e 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -774,6 +774,11 @@ properties:
           - const: pocketbook,touch-lux-3
           - const: allwinner,sun5i-a13
 
+      - description: PocketBook 614 Plus
+        items:
+          - const: pocketbook,614-plus
+          - const: allwinner,sun5i-a13
+
       - description: Point of View Protab2-IPS9
         items:
           - const: pov,protab2-ips9
-- 
2.43.0



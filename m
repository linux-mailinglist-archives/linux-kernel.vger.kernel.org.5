Return-Path: <linux-kernel+bounces-95434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A6B874D98
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45461F26840
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A24B12CD81;
	Thu,  7 Mar 2024 11:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bz37Yb7a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2EF129A93;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811290; cv=none; b=fUYm1rdqx6ABGTuozo/80UEjlgSqgNF4zpbn+5Q+otoA6EF0oKKEg3zI0+LcA1H/dBVqD3zPOc5F8jW/28P1urJxCLNtQED5h/ipm030vYwrD7w3GkYZy1tOB36L8YK4o0bkSgDP9M5OWSEiVXs8GMDo6YgIaJiDT11MDUCOqA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811290; c=relaxed/simple;
	bh=QDh37/hypKzqzSrGrTAeVEghHDvc7ycpYvDwVjDq178=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sRIcr7IkXXgHgRYKMCvRLiR7M72sytgihES2Em4W6wzLOVHPjsPNfA2odJ2SdTNd5dwx/FewjTV9/GlGX0vr5RrEyzPmv10pslZNY/y3Y+ykZ/Rzo34DDb8T8QT2KxERXKmh+gXg07+itNsvQPCjbgBjBzCQyuPljNE9CBtjtSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bz37Yb7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2562C32782;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709811289;
	bh=QDh37/hypKzqzSrGrTAeVEghHDvc7ycpYvDwVjDq178=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Bz37Yb7ad1lzCD0WwQtOoGJGdVvWdrOWZfy7AhVxIep3+gdZ5TdRf+DKLXoR5YudK
	 FA+5llLm4HUtaWbVNZDjDcm1Bbsw1OCl12sKRozzfs/e+y7+gOew5s15hs2Pa+fFXE
	 Io6RzZlZS0/nfHH3L6V8k6Ns5JrK4Wdq3by1mM9dtse9qUXBf6o40Nw9j9FgMrkH4T
	 m8dXN8eQUNKL32x9T1V1Yi5h19FlWfLwC6FnYMUUhokUGcp+QNinH+8gOTdhnBApB3
	 5BFOqR0WAlrsLRJ3emC5yoQhXJDNqu0yhP6kPhmq988L7yKaHoGO0rGvIZv6ezN03N
	 oOIbp6zsHJQiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED02C54E5C;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 07 Mar 2024 19:34:55 +0800
Subject: [PATCH net-next v9 9/9] net: hisi_femac: remove unneeded
 MODULE_ALIAS()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-net-v9-9-6e0cf3e6584d@outlook.com>
References: <20240307-net-v9-0-6e0cf3e6584d@outlook.com>
In-Reply-To: <20240307-net-v9-0-6e0cf3e6584d@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709811287; l=761;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=dDYro7mR0AilpKVwze2YXBVItXvJMbJiAARD8z9wFaE=;
 b=ZsFqnBAGeG9f/aryzU52MMSSSlpZY8ZJ+hotrM3dwtl098m7Q1xxZZFHugXHBEntBKAg8fEG5
 OFrDoOG8OtXBliMT1F20zdydJMoPMedsRt2KXRpdbSwHH7IKyrSkQmT
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

We already have MODULE_DEVICE_TABLE() that creates the correct alias.
Remove unneeded MODULE_ALIAS().

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/net/ethernet/hisilicon/hisi_femac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
index a4f856710d96..ea8f60f292c1 100644
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -1015,4 +1015,3 @@ module_platform_driver(hisi_femac_driver);
 MODULE_DESCRIPTION("Hisilicon Fast Ethernet MAC driver");
 MODULE_AUTHOR("Dongpo Li <lidongpo@hisilicon.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:hisi-femac");

-- 
2.43.0



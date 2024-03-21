Return-Path: <linux-kernel+bounces-110350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C471C885D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639561F21390
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F03FBE6F;
	Thu, 21 Mar 2024 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="xArCIqZm"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5AD12B70;
	Thu, 21 Mar 2024 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038886; cv=none; b=aHc67uChsuQpnIZiMfF/e6O1JXq4pd+xa2xSIpugK9NikjYi3qinTfR+ZAAdpu+z70eue1NKwhC22hO5CzGz+SA/dMtOhvVcpxek/SW70J0HGtlvh2r63TsGHSZ6hrWZi1TXHZcdRBuc6rDC8JCZ7n+QrPsMRP8/AaRWscr5gPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038886; c=relaxed/simple;
	bh=RtgR1YRVTtLrIQG2IlxnE4nb8snfNhPNpqkH/yys6d4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=STEiqzYyGS8cu5D7pLoIHOCOny6RCektnwj1adXEEJPssxokXcNNOpfFB6q+blElTv1Nln4BCgVp12D4Pz1GnhW0I6EZQfjy5mpjU2y4NUoezIWW33T22C2nKw1hsjgKqPTSh52sSNkbCpAWMBhYt22J0Wxe3Pw29krcf7/WNLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=xArCIqZm; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 70F3C1FA90;
	Thu, 21 Mar 2024 17:34:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1711038873;
	bh=qBN5oreNyLNY6HCijsSUjXMliK6o7sVw0PR0u0KgDOo=; h=From:To:Subject;
	b=xArCIqZmGYRgvYJPgtLxeBlxZhomkggW9o03F+mkIh9REO4rvZ4kDthsLaH5gqIaM
	 q1svvI13ybbLRu4HLv7KwLjkNKhWU8MO6/YnU49n5bZI7nUDhG2JQzqYHjogkh/93R
	 eSKbsUQAKgV8Rw/35CgMnuI/INxOY5zgvran9IgFbVb/1KRaB6G7LYDIqP2FAtfC96
	 ujLb96NyZQ/tUwqdAFM+UfvEThHXoZdY8CRPtnvSV1Z5fXCbDg18VcR779OqdM3Yn/
	 qltxiNm65VzVK++noNFzjZrXB/mIU7V0Q/QjYS+vnpDmAE9IKDHVpdy340j1uUZg99
	 1YyyeolpdpI3A==
From: Francesco Dolcini <francesco@dolcini.it>
To: Brian Norris <briannorris@chromium.org>,
	Kalle Valo <kvalo@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add myself as mwifiex driver reviewer
Date: Thu, 21 Mar 2024 17:34:20 +0100
Message-Id: <20240321163420.11158-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed on the mailing list [1], add myself as mwifiex driver reviewer.

[1] https://lore.kernel.org/all/20240318112830.GA9565@francesco-nb/

Signed-off-by: Francesco Dolcini <francesco@dolcini.it>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43b39956694a..1d155a96bb56 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13110,6 +13110,7 @@ F:	drivers/net/ethernet/marvell/mvpp2/
 
 MARVELL MWIFIEX WIRELESS DRIVER
 M:	Brian Norris <briannorris@chromium.org>
+R:	Francesco Dolcini <francesco@dolcini.it>
 L:	linux-wireless@vger.kernel.org
 S:	Odd Fixes
 F:	drivers/net/wireless/marvell/mwifiex/
-- 
2.39.2



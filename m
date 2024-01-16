Return-Path: <linux-kernel+bounces-28133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AB182FAA1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A499028C2C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C521586E7;
	Tue, 16 Jan 2024 20:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn0T2p/n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28FC1586CE;
	Tue, 16 Jan 2024 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435207; cv=none; b=Zp9t2it7C26V4/WIF1Nj0S9en6YLy1hZsiVNd/Mb2/ICLbl3xSpBy+OOrF6womSSEClOMjibQxGPU03l26BkM8hfsOxgSUGnios/hMKLF9p6T+W0zcAH1eJl4QJyTIasn9+AWe9qhsWWrIkjmkIslvywOhUPtm69isHLxQatjjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435207; c=relaxed/simple;
	bh=Mon5scDBKET6/L7FX799ZvcaKqwGFd5fDZLd2md0Dmc=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=Ae07f5joxO2d6FxBZyMLIuGhKAIuu97+ndN19m7zTHmycCWHgqxFq8g3Zywww760kILQZmFj279oPgO1j8PD/SlERBQ4CIipxK23rE8p8KSIK12/GgwGt5fsXkAsZMQxEtf2pA0yiLH7w5QhTwQa79WecsqPStkrlYHePWhU1Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn0T2p/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4A2C433F1;
	Tue, 16 Jan 2024 20:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435207;
	bh=Mon5scDBKET6/L7FX799ZvcaKqwGFd5fDZLd2md0Dmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dn0T2p/nbQCUmA15Xpt1+vp+oAEqkpNyCwa43TuPUvxNe0EbbRNwQ67Nl+ZnXDKvT
	 r3Zfz2jekwMin0Zf1/IPsaYbN4FO71CfCbCrTd2+PoRytYwSpo0lMaLpmYuyd51rSh
	 XiED5e2EOV1KfsaCo/zbaVjHuML6lA45ppcGDOC6FPGcqU7djWCG/xI7hpgcKgAzxs
	 W3a+VlomjWszRICSCGia+gDogiado0ArjQjv3vnD5UZpxqxmUDIrdlPYzqJ2L2VacW
	 ZL1eomqqOw0UrrphpnfH7p+DdyXPhHQR21cMpyPr/PhBKzKVE9KgCxS9AOLGAM55ht
	 3TLD3KWn0Opsw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lin Ma <linma@zju.edu.cn>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	roopa@nvidia.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 45/47] bridge: cfm: fix enum typo in br_cc_ccm_tx_parse
Date: Tue, 16 Jan 2024 14:57:48 -0500
Message-ID: <20240116195834.257313-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195834.257313-1-sashal@kernel.org>
References: <20240116195834.257313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Lin Ma <linma@zju.edu.cn>

[ Upstream commit c2b2ee36250d967c21890cb801e24af4b6a9eaa5 ]

It appears that there is a typo in the code where the nlattr array is
being parsed with policy br_cfm_cc_ccm_tx_policy, but the instance is
being accessed via IFLA_BRIDGE_CFM_CC_RDI_INSTANCE, which is associated
with the policy br_cfm_cc_rdi_policy.

This problem was introduced by commit 2be665c3940d ("bridge: cfm: Netlink
SET configuration Interface.").

Though it seems like a harmless typo since these two enum owns the exact
same value (1 here), it is quite misleading hence fix it by using the
correct enum IFLA_BRIDGE_CFM_CC_CCM_TX_INSTANCE here.

Signed-off-by: Lin Ma <linma@zju.edu.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_cfm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_cfm_netlink.c b/net/bridge/br_cfm_netlink.c
index 5c4c369f8536..2faab44652e7 100644
--- a/net/bridge/br_cfm_netlink.c
+++ b/net/bridge/br_cfm_netlink.c
@@ -362,7 +362,7 @@ static int br_cc_ccm_tx_parse(struct net_bridge *br, struct nlattr *attr,
 
 	memset(&tx_info, 0, sizeof(tx_info));
 
-	instance = nla_get_u32(tb[IFLA_BRIDGE_CFM_CC_RDI_INSTANCE]);
+	instance = nla_get_u32(tb[IFLA_BRIDGE_CFM_CC_CCM_TX_INSTANCE]);
 	nla_memcpy(&tx_info.dmac.addr,
 		   tb[IFLA_BRIDGE_CFM_CC_CCM_TX_DMAC],
 		   sizeof(tx_info.dmac.addr));
-- 
2.43.0



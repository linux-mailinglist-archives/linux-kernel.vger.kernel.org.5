Return-Path: <linux-kernel+bounces-28010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D932482F906
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52AA81F2635F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D9613DBA7;
	Tue, 16 Jan 2024 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsnWr9/7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4191F13DB8E;
	Tue, 16 Jan 2024 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434830; cv=none; b=faHnIqXuuzkMznzChC28Zii2KgZTauAHcKEwB0n4AdYegvvVwHMYzhsiqPrrIqzYDxnvKLqQ2tPx9PIkLZxgzUcYBUEgggOGyMjscO5+Fk8Lal6mv8bvcimYNqaje7TCIbr2v+7VkvnINnS6nwiqC3mgk7XXIx7Ubj3WvukKG8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434830; c=relaxed/simple;
	bh=Mon5scDBKET6/L7FX799ZvcaKqwGFd5fDZLd2md0Dmc=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=jJslXBsVm0OqblEASi5/VB4eDHkUq+BxRLIlfZiMtrgP6U4l6gsZ/eTmWa0ASZzgJd2lnMy32Ml7UDUct4zeB75J7kwjqsQI+0Rec7LD9WJ+paHM58Wdyv+Iu4jC2c2wpneWgKlV2afjoh+lEucorDAiOa/6SUBSGTpvGw6tgxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsnWr9/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB93C43399;
	Tue, 16 Jan 2024 19:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434830;
	bh=Mon5scDBKET6/L7FX799ZvcaKqwGFd5fDZLd2md0Dmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XsnWr9/7o/RjDf+fcE6H72pM7cIbK4cKJj71yr2L/IfUaSurs5HuIv8t1nx62v3RF
	 NC93Mce1JTVbX00FhpB6koWxCTMlJiAvYNdkkoxjy+35940h0tuerfnq5M2GwL4TCR
	 sAlw/vxPiywa2r+9oJx9HfNRrZ0bqxxQcPGfVQ56hvE32ZFUoZb2aPAduTgi01H3U5
	 34ApxrzQGMv6jVd46tE0JzvMzpdQCWq24T84Y955B+twxcdYOa5nSkw1MZZbAaV8On
	 D+of/+zOUIcF8yLiJ9qEUea6YqpQhU5uUCJ3/CPa5wGv/Gtbem59+BZmns+YpIADIx
	 itrYLTin1ax+Q==
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
Subject: [PATCH AUTOSEL 6.6 098/104] bridge: cfm: fix enum typo in br_cc_ccm_tx_parse
Date: Tue, 16 Jan 2024 14:47:04 -0500
Message-ID: <20240116194908.253437-98-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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



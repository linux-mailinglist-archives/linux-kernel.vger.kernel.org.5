Return-Path: <linux-kernel+bounces-28083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D537182F9F7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0021F25475
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A31014DB4C;
	Tue, 16 Jan 2024 19:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOchg01F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474F314D457;
	Tue, 16 Jan 2024 19:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435060; cv=none; b=FuI7WNJaxZrC3/5KhhImeYU//4VKqRaCPQm6OmPc3qnBMm2QHVsbzxTu/cGfnQJDxEDM+pUbTeUi5s2o11sMgr7cgKHmChj3YBBHitwFt+5oY+bAmSI7icGgAkHOdlPrcgux77r3VoAcTyWCcxkCmRDJiaszeQoC/gxOzQABHkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435060; c=relaxed/simple;
	bh=Mon5scDBKET6/L7FX799ZvcaKqwGFd5fDZLd2md0Dmc=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=p3SIpGdqnCCDOUSAJP2d/L+CL6mjt7CuTLbwBCG7XwE40ph03x2abEtNrgpJCEvfq/hErM5fCrp/gYG2kyIOHRllQX1KpYyQ/LFehSHS8c2+EDWU2C0oXqJe4Ww7zp7KL9cpgo09LkZFjl7TTPTk1i/AzEP58WIJOIWQju+irG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOchg01F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C622DC43399;
	Tue, 16 Jan 2024 19:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435060;
	bh=Mon5scDBKET6/L7FX799ZvcaKqwGFd5fDZLd2md0Dmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YOchg01FxVcoaVq2PBoAQVDpbV5eR1cbkHoao1PRkQw47fpP973wSwcH+YMvf+/Ug
	 lXLXeGTQekYUH9AG4snNtu3d2Q3fqTYPJsduEHrYbh5uWzdP7qWX85fSHgmnqtB26l
	 idhR0l8wAFUFAcqDuzC6Cg7KtQ8YWo7kmYurLFj3ZaT9wBV0WFrVTmKmSZP/EfYeFJ
	 Z1DBD7c52PKd23gEQ8jlFFwpO5kr2vl6f3HaSBLCDlXHDK7BN8p/rRmONd9DoyFgji
	 JUt9giS1hUxUQ/TyDV8jxDPPwepx0k6A7q76NhRx0RDabai+XRCtGGAYJYAES06SjM
	 4TOMeq9V5xe5g==
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
Subject: [PATCH AUTOSEL 6.1 65/68] bridge: cfm: fix enum typo in br_cc_ccm_tx_parse
Date: Tue, 16 Jan 2024 14:54:04 -0500
Message-ID: <20240116195511.255854-65-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
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



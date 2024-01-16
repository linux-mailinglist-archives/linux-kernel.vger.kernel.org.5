Return-Path: <linux-kernel+bounces-27875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CD782F713
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17B51C24721
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59FE6D1D7;
	Tue, 16 Jan 2024 19:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7AIde1o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0BC1D551;
	Tue, 16 Jan 2024 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434412; cv=none; b=hn7eYXn0NiKwvjhRpBynSADa4FGvUVYXXj8QPZfGhyhRw8FDUlJD2sQIbvxcgxMubhSKqDwLS8EBid8NTUMEaoE5T+JM5ISpOYTK/V3Tt9SIBcgDhXfKV3NAftayQSyCFHgj5tsDB/PVAhfzcAbT0p1wYZdWrJ7RWF0XbmrT5TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434412; c=relaxed/simple;
	bh=Mon5scDBKET6/L7FX799ZvcaKqwGFd5fDZLd2md0Dmc=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=hm4FgAlfPiIYd8MVLwmkpVhxV66H1ujZHH6DpueejQ5cPSyF+t5v+QjANZSD0W+sTfUSQDgCih2Y3NBKWiiRjMAnfKEGVWLIR7bTs9jS7A0TocA+VoM38fXHSqW6xJKxff9/pxnKFd8zqTjS7Lfg/XJUl1+p0e8S6ocZ5hXmaKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7AIde1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41049C433F1;
	Tue, 16 Jan 2024 19:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434411;
	bh=Mon5scDBKET6/L7FX799ZvcaKqwGFd5fDZLd2md0Dmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T7AIde1okNzBlAfcrkKyx3QvQvigBT+rS4EAApoMhknp/5lBqkFdesqWkNeDvKRYe
	 Upcz1oh2aGauBd9S8acMI7xzJo99+2Jf6LbuCNGYdHcDjlh5FaPds38eAqlHFOtlDJ
	 p+UwQJ/eUAj7c6Wa/I3ZyzkFwDGxI/A78NzZfECeqm++kFqlarlP7qPgiC/QA0HZ5y
	 KzmecEWubNwKJgfhQPZ4fu8DCTUTu2AGkyuz98H6xURvb45aFrtztBJXF7s+EJv9sT
	 1LZ4U+iFIW+soKERBJGZGql+sBhuIS147TEjDYunfUHMxf6qqja+Pmt1nMCpGBK92p
	 ci7YciB9Z8a0A==
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
Subject: [PATCH AUTOSEL 6.7 101/108] bridge: cfm: fix enum typo in br_cc_ccm_tx_parse
Date: Tue, 16 Jan 2024 14:40:07 -0500
Message-ID: <20240116194225.250921-101-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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



Return-Path: <linux-kernel+bounces-147046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61088A6EAB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02FF91C227D1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D141A12FF75;
	Tue, 16 Apr 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Ktc/mFMg"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AD212E1DE;
	Tue, 16 Apr 2024 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278654; cv=none; b=rDqQp0+1/Pw7zlKa/7x8yKtlmaH01nkcJzuZIuIg35Qw/PqM8bWWAaKRTj4nhZqMfMM72kv4oh5zF1YNjNoH5ZSSbztCBi8OkDAuZGnNlWqnBbTvpOuecVZdgHb4cW0ZAM4yzKIotvyupwSNkVekgpYi66qyT/YK+PaxkKPxQuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278654; c=relaxed/simple;
	bh=o4ZOIcqpBZ2ScPAygv+rbNYIAA7PYEWjMlaH8XOvMJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cgyVMNjBYbFNlAIqpQDaM2yjdcBHfApMaO0AA9lB3remHZGbUhngZmVW2G8uVs80I2bvtuZWHeA8hlBOVq3TU4T2jG1wwEffEjt9i3mJXrTi/HIBvqo8uVf0KusKI7kwOe+yNvR6GOMuiFP+M9TCB/K1KTI/okM935fsUPBGsa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Ktc/mFMg; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 74A76600A5;
	Tue, 16 Apr 2024 14:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713278649;
	bh=o4ZOIcqpBZ2ScPAygv+rbNYIAA7PYEWjMlaH8XOvMJM=;
	h=From:To:Cc:Subject:Date:From;
	b=Ktc/mFMgo9hWpkLij6VpxVjtIpbb8Uz3yFZYMrAoUnaEMbxj6GSqFFT5zhwsjO5i8
	 hZmsrUY1cb/rgAtajaLi0nRSWfJgmx+S4Bo4lyE+7Ayk6fqoxFmFuBFHEGgGMrkwcB
	 5R/4uShxm7EcZLAzfedAF35xvctIBXUDILxejDOx2qRYKCw9YD4kJDI/KihKVyx5L7
	 935YtTvCoD3pNs5FmKlsBbzV6iI5iwd+dAEvphsXCzDLWbBSLAY9A2JJDVVDQYQoa5
	 a2fOloVEhEUvNE5ldQNofWfWxH+DphjGebSkiwCTbgwI5jjRfW93BUQIcGCojKCyD3
	 TJ5Xc20wJu/ng==
Received: by x201s (Postfix, from userid 1000)
	id 8CFE32061E5; Tue, 16 Apr 2024 14:43:35 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: intel-wired-lan@lists.osuosl.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH iwl-next] igb: flower: validate control flags
Date: Tue, 16 Apr 2024 14:43:35 +0000
Message-ID: <20240416144335.15353-1-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This driver currently doesn't support any control flags.

Use flow_rule_match_has_control_flags() to check for control flags,
such as can be set through `tc flower ... ip_flags frag`.

In case any control flags are masked, flow_rule_match_has_control_flags()
sets a NL extended error message, and we return -EOPNOTSUPP.

Only compile-tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 74a998fcaa6f..e4c65d3819d7 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2597,6 +2597,9 @@ static int igb_parse_cls_flower(struct igb_adapter *adapter,
 		return -EOPNOTSUPP;
 	}
 
+	if (flow_rule_match_has_control_flags(rule, extack))
+		return -EOPNOTSUPP;
+
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
 		struct flow_match_eth_addrs match;
 
-- 
2.43.0



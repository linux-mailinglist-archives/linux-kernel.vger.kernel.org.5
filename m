Return-Path: <linux-kernel+bounces-147047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B46648A6EAC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749F51F22358
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652AA1304BE;
	Tue, 16 Apr 2024 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Xgb85BgK"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B1512E1E4;
	Tue, 16 Apr 2024 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278654; cv=none; b=gPS0ErDN+lc6IyCzQTOXvGwkXE7bHddZIoNPoNQHjtGvO6FY7AKp/HGicGh8f13cdk3hu+u+DdNQa4zkLYLSgdYvTnFw/Qc7pjVytFdbC7jGDwgxskeCELDWHrjji324WQWc7/iOiPS8EEIXdIKRRbnLDfYfY2VC/hVgSBFhlJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278654; c=relaxed/simple;
	bh=5BwHBYqxMFeIngfy155cTEhlu7ALrPnplvMVvaMfee0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c6MTUoQXmlcc9WD6Mxx6XMEMzOFrxpa4R98ihslnbDlTqLOqBe9NndWlbPAJoz+tBTluoTjIh9obJlsPJt1qaINNKrjZoTX86fnwsWxv7u1fkav4eOQWRw70YlczUQHmiVXWYE+rKHHfKbcWH/LbtpZh1pcLkvOnc3FlsPtaNXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Xgb85BgK; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id C7327600AF;
	Tue, 16 Apr 2024 14:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713278649;
	bh=5BwHBYqxMFeIngfy155cTEhlu7ALrPnplvMVvaMfee0=;
	h=From:To:Cc:Subject:Date:From;
	b=Xgb85BgKLWsdRhM36K3eRzcf4c9sMeZX5xgUX0gQUPqGHoy2FUs/6nFwcqiQwx/0e
	 izTYlD7ipM+2kp9dWZfiJfbhUlIc1N8Ec26EjadQUwcNQVp3uAG+Hg97/Qm/Wg1+xb
	 BLURF7GjjF7V2qn7U/8HD93L3sVmancpYp1/AtXCWpPj4w/4GF+1RIIjYs//9yRtFS
	 TlqqtjUwS5HcmYgKCzetYA5plB3rj4D7lMMRQeS1wi3JMtnsTkh1KORyiR2DIAHnY0
	 oJ8evaBerEj6DPiis11bO/+rIYju6KBSWG9XEX4i9Di83kGkUEpEM9o9y6RXkT/5ri
	 7JsOZ3Nnt/hUA==
Received: by x201s (Postfix, from userid 1000)
	id 3185F203455; Tue, 16 Apr 2024 14:43:27 +0000 (UTC)
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
Subject: [PATCH iwl-next] iavf: flower: validate control flags
Date: Tue, 16 Apr 2024 14:43:25 +0000
Message-ID: <20240416144325.15319-1-ast@fiberby.net>
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

Use flow_rule_has_control_flags() to check for control flags,
such as can be set through `tc flower ... ip_flags frag`.

In case any control flags are masked, flow_rule_has_control_flags()
sets a NL extended error message, and we return -EOPNOTSUPP.

Only compile-tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 13361a780ece..f14355d52f47 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3757,6 +3757,10 @@ static int iavf_parse_cls_flower(struct iavf_adapter *adapter,
 
 		flow_rule_match_control(rule, &match);
 		addr_type = match.key->addr_type;
+
+		if (flow_rule_has_control_flags(match.mask->flags,
+						f->common.extack))
+			return -EOPNOTSUPP;
 	}
 
 	if (addr_type == FLOW_DISSECTOR_KEY_IPV4_ADDRS) {
-- 
2.43.0



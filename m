Return-Path: <linux-kernel+bounces-135714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A57E189CA24
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207DB1F26F80
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67B7143C57;
	Mon,  8 Apr 2024 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="dTf7BMKW"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14F8142E89;
	Mon,  8 Apr 2024 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712595326; cv=none; b=DWr0glSyeF1hIEGhjhcRzcMWGU5PxOhki3l1TUCNOgtOb1I/vSNpVbrxxB7i3mnoLCDx4DPFBFh53Uv4p1KR+ujJr6YSY9AqFROIXWecgVZSbWVoXn0Bm3rk4pXMcht1bhgWGQ8CGYNya0gOGlgN0LBmWNuSHouf4dGY0NCnrXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712595326; c=relaxed/simple;
	bh=rxCeD0zXP2xZQuy+YjwSC3L91TCIGxlJUXBLMuIWqw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oK8856bf6iJjhRv185Pz2g8jETtFawsbm7YzMP1fNPL4NPF70haGK93qNoElPBjwDXWrmIV8FNmjC2n/NzlnXBZlXpJkeGxvX9BxIPKaA7YQlEYmb2a2UrLZ23kL8M7Ss63KX8b0+a76SE5AGZRTYnc3/iR51a0hkR3sNhIyGBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=dTf7BMKW; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 55FF3600A5;
	Mon,  8 Apr 2024 16:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712595320;
	bh=rxCeD0zXP2xZQuy+YjwSC3L91TCIGxlJUXBLMuIWqw8=;
	h=From:To:Cc:Subject:Date:From;
	b=dTf7BMKWiuKOqL6bVPPr46cjwRBsFBm5m1lsnBq9TFfkSvYwqEAyLEHDwNk1u+HwI
	 bIHK2GwSXOOC0ozViTZoSvgsjsQKvnxhhiyDq1xuSY3FRQOVNMPcxaGbhiEwPv1y8V
	 z9OAfwLt68a4up46XZOCd+IZuIjv9xBlPZjgZFs8EDm1uiwaiDP4chIo67mHZCyubP
	 JR9oH+CEhoC7lm4L+S1C/nMOgPOql2dDRmsltXqmcbIE7ip+vhs1wOsHW5W4NpIaqS
	 5r4F6JFu8oiuii+T9dtfbRltTo2jiq2Y2CNoWvD9ozhGwK9xVlq9TZCyTA9BBCdlOF
	 0MQeBBPhx0gfg==
Received: by x201s (Postfix, from userid 1000)
	id 103CB201CE7; Mon, 08 Apr 2024 16:55:09 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Raju Rangoju <rajur@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] cxgb4: flower: use NL_SET_ERR_MSG_MOD for validation errors
Date: Mon,  8 Apr 2024 16:55:04 +0000
Message-ID: <20240408165506.94483-1-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace netdev_{warn,err} with NL_SET_ERR_MSG_{FMT_,}MOD
to better inform the user about the problem.

Only compile-tested, no access to HW.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 .../ethernet/chelsio/cxgb4/cxgb4_tc_flower.c  | 64 +++++++++----------
 1 file changed, 30 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
index 72ac4a34424b9..3a6987cafe590 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
@@ -305,7 +305,7 @@ static void cxgb4_process_flow_match(struct net_device *dev,
 	fs->mask.iport = ~0;
 }
 
-static int cxgb4_validate_flow_match(struct net_device *dev,
+static int cxgb4_validate_flow_match(struct netlink_ext_ack *extack,
 				     struct flow_rule *rule)
 {
 	struct flow_dissector *dissector = rule->match.dissector;
@@ -321,8 +321,9 @@ static int cxgb4_validate_flow_match(struct net_device *dev,
 	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_KEYID) |
 	      BIT_ULL(FLOW_DISSECTOR_KEY_VLAN) |
 	      BIT_ULL(FLOW_DISSECTOR_KEY_IP))) {
-		netdev_warn(dev, "Unsupported key used: 0x%llx\n",
-			    dissector->used_keys);
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Unsupported key used: 0x%llx",
+				       dissector->used_keys);
 		return -EOPNOTSUPP;
 	}
 
@@ -339,13 +340,15 @@ static int cxgb4_validate_flow_match(struct net_device *dev,
 		struct flow_match_ip match;
 
 		if (eth_ip_type != ETH_P_IP && eth_ip_type != ETH_P_IPV6) {
-			netdev_err(dev, "IP Key supported only with IPv4/v6");
+			NL_SET_ERR_MSG_MOD(extack,
+					   "IP Key supported only with IPv4/v6");
 			return -EINVAL;
 		}
 
 		flow_rule_match_ip(rule, &match);
 		if (match.mask->ttl) {
-			netdev_warn(dev, "ttl match unsupported for offload");
+			NL_SET_ERR_MSG_MOD(extack,
+					   "ttl match unsupported for offload");
 			return -EOPNOTSUPP;
 		}
 	}
@@ -576,7 +579,7 @@ static bool valid_l4_mask(u32 mask)
 	return hi && lo ? false : true;
 }
 
-static bool valid_pedit_action(struct net_device *dev,
+static bool valid_pedit_action(struct netlink_ext_ack *extack,
 			       const struct flow_action_entry *act,
 			       u8 *natmode_flags)
 {
@@ -595,8 +598,7 @@ static bool valid_pedit_action(struct net_device *dev,
 		case PEDIT_ETH_SMAC_47_16:
 			break;
 		default:
-			netdev_err(dev, "%s: Unsupported pedit field\n",
-				   __func__);
+			NL_SET_ERR_MSG_MOD(extack, "Unsupported pedit field");
 			return false;
 		}
 		break;
@@ -609,8 +611,7 @@ static bool valid_pedit_action(struct net_device *dev,
 			*natmode_flags |= CXGB4_ACTION_NATMODE_DIP;
 			break;
 		default:
-			netdev_err(dev, "%s: Unsupported pedit field\n",
-				   __func__);
+			NL_SET_ERR_MSG_MOD(extack, "Unsupported pedit field");
 			return false;
 		}
 		break;
@@ -629,8 +630,7 @@ static bool valid_pedit_action(struct net_device *dev,
 			*natmode_flags |= CXGB4_ACTION_NATMODE_DIP;
 			break;
 		default:
-			netdev_err(dev, "%s: Unsupported pedit field\n",
-				   __func__);
+			NL_SET_ERR_MSG_MOD(extack, "Unsupported pedit field");
 			return false;
 		}
 		break;
@@ -638,8 +638,8 @@ static bool valid_pedit_action(struct net_device *dev,
 		switch (offset) {
 		case PEDIT_TCP_SPORT_DPORT:
 			if (!valid_l4_mask(~mask)) {
-				netdev_err(dev, "%s: Unsupported mask for TCP L4 ports\n",
-					   __func__);
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Unsupported mask for TCP L4 ports");
 				return false;
 			}
 			if (~mask & PEDIT_TCP_UDP_SPORT_MASK)
@@ -648,8 +648,7 @@ static bool valid_pedit_action(struct net_device *dev,
 				*natmode_flags |= CXGB4_ACTION_NATMODE_DPORT;
 			break;
 		default:
-			netdev_err(dev, "%s: Unsupported pedit field\n",
-				   __func__);
+			NL_SET_ERR_MSG_MOD(extack, "Unsupported pedit field");
 			return false;
 		}
 		break;
@@ -657,8 +656,8 @@ static bool valid_pedit_action(struct net_device *dev,
 		switch (offset) {
 		case PEDIT_UDP_SPORT_DPORT:
 			if (!valid_l4_mask(~mask)) {
-				netdev_err(dev, "%s: Unsupported mask for UDP L4 ports\n",
-					   __func__);
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Unsupported mask for UDP L4 ports");
 				return false;
 			}
 			if (~mask & PEDIT_TCP_UDP_SPORT_MASK)
@@ -667,13 +666,12 @@ static bool valid_pedit_action(struct net_device *dev,
 				*natmode_flags |= CXGB4_ACTION_NATMODE_DPORT;
 			break;
 		default:
-			netdev_err(dev, "%s: Unsupported pedit field\n",
-				   __func__);
+			NL_SET_ERR_MSG_MOD(extack, "Unsupported pedit field");
 			return false;
 		}
 		break;
 	default:
-		netdev_err(dev, "%s: Unsupported pedit type\n", __func__);
+		NL_SET_ERR_MSG_MOD(extack, "Unsupported pedit type");
 		return false;
 	}
 	return true;
@@ -727,8 +725,7 @@ int cxgb4_validate_flow_actions(struct net_device *dev,
 			 * the provided output port is not valid
 			 */
 			if (!found) {
-				netdev_err(dev, "%s: Out port invalid\n",
-					   __func__);
+				NL_SET_ERR_MSG_MOD(extack, "Out port invalid");
 				return -EINVAL;
 			}
 			act_redir = true;
@@ -745,21 +742,21 @@ int cxgb4_validate_flow_actions(struct net_device *dev,
 			case FLOW_ACTION_VLAN_PUSH:
 			case FLOW_ACTION_VLAN_MANGLE:
 				if (proto != ETH_P_8021Q) {
-					netdev_err(dev, "%s: Unsupported vlan proto\n",
-						   __func__);
+					NL_SET_ERR_MSG_MOD(extack,
+							   "Unsupported vlan proto");
 					return -EOPNOTSUPP;
 				}
 				break;
 			default:
-				netdev_err(dev, "%s: Unsupported vlan action\n",
-					   __func__);
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Unsupported vlan action");
 				return -EOPNOTSUPP;
 			}
 			act_vlan = true;
 			}
 			break;
 		case FLOW_ACTION_MANGLE: {
-			bool pedit_valid = valid_pedit_action(dev, act,
+			bool pedit_valid = valid_pedit_action(extack, act,
 							      &natmode_flags);
 
 			if (!pedit_valid)
@@ -771,14 +768,14 @@ int cxgb4_validate_flow_actions(struct net_device *dev,
 			/* Do nothing. cxgb4_set_filter will validate */
 			break;
 		default:
-			netdev_err(dev, "%s: Unsupported action\n", __func__);
+			NL_SET_ERR_MSG_MOD(extack, "Unsupported action");
 			return -EOPNOTSUPP;
 		}
 	}
 
 	if ((act_pedit || act_vlan) && !act_redir) {
-		netdev_err(dev, "%s: pedit/vlan rewrite invalid without egress redirect\n",
-			   __func__);
+		NL_SET_ERR_MSG_MOD(extack,
+				   "pedit/vlan rewrite invalid without egress redirect");
 		return -EINVAL;
 	}
 
@@ -864,7 +861,7 @@ int cxgb4_flow_rule_replace(struct net_device *dev, struct flow_rule *rule,
 	if (cxgb4_validate_flow_actions(dev, &rule->action, extack, 0))
 		return -EOPNOTSUPP;
 
-	if (cxgb4_validate_flow_match(dev, rule))
+	if (cxgb4_validate_flow_match(extack, rule))
 		return -EOPNOTSUPP;
 
 	cxgb4_process_flow_match(dev, rule, fs);
@@ -901,8 +898,7 @@ int cxgb4_flow_rule_replace(struct net_device *dev, struct flow_rule *rule,
 	init_completion(&ctx.completion);
 	ret = __cxgb4_set_filter(dev, fidx, fs, &ctx);
 	if (ret) {
-		netdev_err(dev, "%s: filter creation err %d\n",
-			   __func__, ret);
+		NL_SET_ERR_MSG_FMT_MOD(extack, "filter creation err %d", ret);
 		return ret;
 	}
 
-- 
2.43.0



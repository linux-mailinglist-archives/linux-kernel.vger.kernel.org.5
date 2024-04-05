Return-Path: <linux-kernel+bounces-132582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 424F78996D4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739901C210D9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4053F13E3E3;
	Fri,  5 Apr 2024 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CfAs1bOw"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E1913D53E;
	Fri,  5 Apr 2024 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303129; cv=none; b=bdzO4ioqH+kZG3SHkjqIAUnpvjJzsZw8qTIY5+4BWZnzy3ldGNO1LRA+aHAfJxJbW0rDl/BXC4YAI20Tgdxot8avCcrzpoGEKnVC8WOmdj2rs3zzCmkWZkVEth9n791MxpKRfbeFt7uJje9yQKXy6ZLmvKfVvQFX2nEcV/PMngI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303129; c=relaxed/simple;
	bh=hG/7WXbVHwPtjqKBcDc2XwtEgfdfo2i1v9NTvMXhAsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fRj0KIyz4EsEQIsusuZSWzTZ0xDNvHSUM8Msv5rCBn8aQ1X0/JR5rFC9sJjTwLGNfaawYrYQ69WhbnFGpqSTuDlULJP38U43Yb16TcLdIT21YrPNWwwC/Fo1TNZt9ZSF79uSQiozeNYY5d83t+wanGKtFsrvfTNMTGY8thSCU+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CfAs1bOw; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712303127; x=1743839127;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=hG/7WXbVHwPtjqKBcDc2XwtEgfdfo2i1v9NTvMXhAsY=;
  b=CfAs1bOwTvtWL6AhDM1wS947iswdOUYniVJ6Gap59lTvdAkP+ALKJaaJ
   wD/RsfKB30Jvmglr+3VCBzZqzERKlfSXaDbLGMSYaKvHZSUpDgCjL6LFT
   cc/gSbaaN/CNHrMBIK1LY4aWBbTDBs91Wd3sEW9cvA7JxS4TsVN05+N4O
   Bksk147FakfRU5zXLZkVlSujgIiw0r8jT7xavelgm5XLLs/4FB2lf/VR+
   D+YtGOABkD3VF2YYAmKh9uw/fRSknzZdYM8CZRAxq/X25B+pnv7nx1rq3
   3VHYh7xz7xC/m/WKVJmMmKF4S3gt3Xq9UMEH4loH5J8PZWxMIzedfGC6F
   A==;
X-CSE-ConnectionGUID: LnJ8QAI7QrCTf6/TR/LIZQ==
X-CSE-MsgGUID: zx1E/0f7Tt+Tn7q5T9/slQ==
X-IronPort-AV: E=Sophos;i="6.07,180,1708412400"; 
   d="scan'208";a="19563251"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2024 00:45:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 00:45:08 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 00:45:06 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 5 Apr 2024 09:44:50 +0200
Subject: [PATCH net-next v2 2/2] net: sparx5: add support for tc flower
 redirect action
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240405-mirror-redirect-actions-v2-2-875d4c1927c8@microchip.com>
References: <20240405-mirror-redirect-actions-v2-0-875d4c1927c8@microchip.com>
In-Reply-To: <20240405-mirror-redirect-actions-v2-0-875d4c1927c8@microchip.com>
To: Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Ratheesh Kannoth <rkannoth@marvell.com>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Daniel Machon <daniel.machon@microchip.com>
X-Mailer: b4 0.14-dev

Add support for the flower redirect action. Two VCAP actions are encoded
in the rule - one for the port mask, and one for the port mask mode.
When the rule is hit, the port mask is used as the final destination
set, replacing all other port masks.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../ethernet/microchip/sparx5/sparx5_tc_flower.c   | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
index fb2e3004183a..82dd270adae6 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
@@ -1038,6 +1038,30 @@ static int sparx5_tc_action_mirred(struct vcap_admin *admin,
 	return vcap_rule_add_action_u72(vrule, VCAP_AF_PORT_MASK, &ports);
 }
 
+static int sparx5_tc_action_redirect(struct vcap_admin *admin,
+				     struct vcap_rule *vrule,
+				     struct flow_cls_offload *fco,
+				     struct flow_action_entry *act)
+{
+	struct vcap_u72_action ports = {0};
+	int err;
+
+	if (admin->vtype != VCAP_TYPE_IS0 && admin->vtype != VCAP_TYPE_IS2) {
+		NL_SET_ERR_MSG_MOD(fco->common.extack,
+				   "Redirect action not supported in this VCAP");
+		return -EOPNOTSUPP;
+	}
+
+	err = vcap_rule_add_action_u32(vrule, VCAP_AF_MASK_MODE,
+				       SPX5_PMM_REPLACE_ALL);
+	if (err)
+		return err;
+
+	sparx5_tc_flower_set_port_mask(&ports, act->dev);
+
+	return vcap_rule_add_action_u72(vrule, VCAP_AF_PORT_MASK, &ports);
+}
+
 /* Remove rule keys that may prevent templates from matching a keyset */
 static void sparx5_tc_flower_simplify_rule(struct vcap_admin *admin,
 					   struct vcap_rule *vrule,
@@ -1189,6 +1213,11 @@ static int sparx5_tc_flower_replace(struct net_device *ndev,
 			if (err)
 				goto out;
 			break;
+		case FLOW_ACTION_REDIRECT:
+			err = sparx5_tc_action_redirect(admin, vrule, fco, act);
+			if (err)
+				goto out;
+			break;
 		case FLOW_ACTION_ACCEPT:
 			err = sparx5_tc_set_actionset(admin, vrule);
 			if (err)

-- 
2.34.1



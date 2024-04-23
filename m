Return-Path: <linux-kernel+bounces-154861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0378AE224
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D05E1F25CE8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7776965189;
	Tue, 23 Apr 2024 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="DRopk1Cb"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E9560267;
	Tue, 23 Apr 2024 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868095; cv=none; b=tf+YotlAzGDpjTxS5Z8RxtbUzjBhs6aNKLxiWoqYNGF1STiUh5Gg/+yJIWLdIWu1bOxPiDdgGUSxcYOByClvMDyZ08l6uandIFs2ZT5w9+3YZnKqF9Ck6D6b9FSYdelj//Qn6sv9mv+OycJYBNdXIcT7nHsdQcOOhk+uqolzbzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868095; c=relaxed/simple;
	bh=39WhF6eCSOF/ZCUdao6fmDVARxWuHqpggCtYOqxbRdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f3IAcp5c6a7S4XHfMWDuILc32rM+IKvqoPnaT0DGm6GmSd0zOkv7/U1NMhlaG5o7xdgdHlkVYOipMFZAMw8U0lDDcI9kV35+Cw+5g7KJtuNemAYbgaOlFCXKtlBU9g59c7FwgrvZUzO4lreRdbV0mSouLmu1O1D95cT1URfaxk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=DRopk1Cb; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 29706600A7;
	Tue, 23 Apr 2024 10:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713868084;
	bh=39WhF6eCSOF/ZCUdao6fmDVARxWuHqpggCtYOqxbRdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DRopk1CbxQFpR7TwvdM4LduXW51OoycFf176Xzt0GSHWRVRlo9Sa+0GfjFY3CopnG
	 tLAyQFME3G2F3goHqEyYYyjrxDVNSURLwnTsRa678RL1cgZMh+eMTtPLlZlgZO5IHw
	 R9epoP7Li6mTiNjf1ns9eO8YfP/6J5dLkdRiuURfFFpwUv1FxJCV5mzpN1OHt2UMyz
	 HsmMyu2SLZ12JRIpB+4R+tJ0qrDwz5gXFU2EZBro5v7TiKYKem3y3ndNGi3Uyvb2FL
	 av/uwjNBrdv4GXtyAlY1FHLoE087RSPnHgFT9pXq6teEA4leaqRQYNPafcGHCpo0MD
	 I2KEwvAYaSHTQ==
Received: by x201s (Postfix, from userid 1000)
	id 61B34216B93; Tue, 23 Apr 2024 10:27:29 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 2/2] net: sparx5: flower: check for unsupported control flags
Date: Tue, 23 Apr 2024 10:27:27 +0000
Message-ID: <20240423102728.228765-2-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423102728.228765-1-ast@fiberby.net>
References: <20240423102728.228765-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use flow_rule_is_supp_control_flags() to reject filters with
unsupported control flags.

In case any unsupported control flags are masked,
flow_rule_is_supp_control_flags() sets a NL extended
error message, and we return -EOPNOTSUPP.

Only compile-tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
index d846edd77a01..f81d89f8f620 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
@@ -197,6 +197,11 @@ sparx5_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
 		}
 	}
 
+	if (!flow_rule_is_supp_control_flags(FLOW_DIS_IS_FRAGMENT |
+					     FLOW_DIS_FIRST_FRAG,
+					     mt.mask->flags, extack))
+		return -EOPNOTSUPP;
+
 	st->used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL);
 
 	return err;
-- 
2.43.0



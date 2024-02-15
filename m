Return-Path: <linux-kernel+bounces-67281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CAB856925
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA1C7B2AEAF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D5A135A48;
	Thu, 15 Feb 2024 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="n15Yix4h"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CA213342A;
	Thu, 15 Feb 2024 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013203; cv=none; b=Mf7cqjeqk7i5EAGsO/QXqqC1UNXMSWlYcUVpDWvWijPRumkdqutpR42c5u96wB6RZIWmLSe2MbZZsCCTLzfyeKouHCtkLfOOBfpV/FdWqZ6u3m00w2E6K8MW6LBrEqLkkgKY7CUlrg2JFvCUWlP8Al8Y2izGensHNO2r+7WE95I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013203; c=relaxed/simple;
	bh=oHc3l+4peZjS6tTsw+CB3JlnCa+oPdVEiLwpuc9h+V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VE4YaNWn46KBYsP4Vnw1vaoZrhZ38YR070v3o28bL/kaVHL/gzdKiYt74zDm5Ujt/GIBg5hZupi/vV0owPtlpvpMxdG7Ke7Heh+ca1m09Ipe+Jvij66v1X1/Qvr7k3RLt5hVjVRiiBY3m3x+wliOcHGQh8nHzZy0aqN34V0wEnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=n15Yix4h; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 10341600D7;
	Thu, 15 Feb 2024 16:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1708013196;
	bh=oHc3l+4peZjS6tTsw+CB3JlnCa+oPdVEiLwpuc9h+V4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n15Yix4h0hq6UboabRZQnLStC8gIBPLyq0ecgocjRzIqbkNz4Km3tIMCyNdElXxh1
	 5bIP78T9SFflzyPNYBxcx3YVVASQouXni6P7U8aAA+mh1ChXJVNyKjsZqFQfWXZOIh
	 aZcudveYRJQjDirHg5GHuglnfSo1/kP86IAAoFKrDYjzHdK8jOKCaqKk6kVdC92mvg
	 ZeetVKQpww2FQCY3YppZ0UXmEBm1RmsqlFk3V5LXlsLsQa7hSQjRanju3TfjjWklhM
	 A0G1j+PLcgAGpvnwIeKYWjP4cFrVLuu7tHLpy1HZMtR7Z7sFPahtYxHQzyZqMZjEEP
	 nOYm62BHwE08g==
Received: by x201s (Postfix, from userid 1000)
	id 5820721472C; Thu, 15 Feb 2024 16:05:55 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llu@fiberby.dk
Subject: [PATCH net-next 3/3] net: sched: make skip_sw actually skip software
Date: Thu, 15 Feb 2024 16:04:44 +0000
Message-ID: <20240215160458.1727237-4-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215160458.1727237-1-ast@fiberby.net>
References: <20240215160458.1727237-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

TC filters come in 3 variants:
- no flag (no opinion, process wherever possible)
- skip_hw (do not process filter by hardware)
- skip_sw (do not process filter by software)

However skip_sw is implemented so that the skip_sw
flag can first be checked, after it has been matched.

IMHO it's common when using skip_sw, to use it on all rules.

So if all filters in a block is skip_sw filters, then
we can bail early, we can thus avoid having to match
the filters, just to check for the skip_sw flag.

 +----------------------------+--------+--------+--------+
 | Test description           | Pre    | Post   | Rel.   |
 |                            | kpps   | kpps   | chg.   |
 +----------------------------+--------+--------+--------+
 | basic forwarding + notrack | 1264.9 | 1277.7 |  1.01x |
 | switch to eswitch mode     | 1067.1 | 1071.0 |  1.00x |
 | add ingress qdisc          | 1056.0 | 1059.1 |  1.00x |
 +----------------------------+--------+--------+--------+
 | 1 non-matching rule        |  927.9 | 1057.1 |  1.14x |
 | 10 non-matching rules      |  495.8 | 1055.6 |  2.13x |
 | 25 non-matching rules      |  280.6 | 1053.5 |  3.75x |
 | 50 non-matching rules      |  162.0 | 1055.7 |  6.52x |
 | 100 non-matching rules     |   87.7 | 1019.0 | 11.62x |
 +----------------------------+--------+--------+--------+

perf top (100 n-m skip_sw rules - pre patch):
  25.57%  [kernel]  [k] __skb_flow_dissect
  20.77%  [kernel]  [k] rhashtable_jhash2
  14.26%  [kernel]  [k] fl_classify
  13.28%  [kernel]  [k] fl_mask_lookup
   6.38%  [kernel]  [k] memset_orig
   3.22%  [kernel]  [k] tcf_classify

perf top (100 n-m skip_sw rules - post patch):
   4.28%  [kernel]  [k] __dev_queue_xmit
   3.80%  [kernel]  [k] check_preemption_disabled
   3.68%  [kernel]  [k] nft_do_chain
   3.08%  [kernel]  [k] __netif_receive_skb_core.constprop.0
   2.59%  [kernel]  [k] mlx5e_xmit
   2.48%  [kernel]  [k] mlx5e_skb_from_cqe_mpwrq_nonlinear

Test setup:
 DUT: Intel Xeon D-1518 (2.20GHz) w/ Nvidia/Mellanox ConnectX-6 Dx 2x100G
 Data rate measured on switch (Extreme X690), and DUT connected as
 a router on a stick, with pktgen and pktsink as VLANs.
 Pktgen was in range 12.79 - 12.95 Mpps across all tests.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 include/net/pkt_cls.h | 5 +++++
 net/core/dev.c        | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index a4ee43f493bb..a065da4df7ff 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -74,6 +74,11 @@ static inline bool tcf_block_non_null_shared(struct tcf_block *block)
 	return block && block->index;
 }
 
+static inline bool tcf_block_has_skip_sw_only(struct tcf_block *block)
+{
+	return block && atomic_read(&block->filtercnt) == atomic_read(&block->skipswcnt);
+}
+
 static inline struct Qdisc *tcf_block_q(struct tcf_block *block)
 {
 	WARN_ON(tcf_block_shared(block));
diff --git a/net/core/dev.c b/net/core/dev.c
index d8dd293a7a27..7cd014e5066e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3910,6 +3910,9 @@ static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
 	if (!miniq)
 		return ret;
 
+	if (tcf_block_has_skip_sw_only(miniq->block))
+		return ret;
+
 	tc_skb_cb(skb)->mru = 0;
 	tc_skb_cb(skb)->post_ct = false;
 	tcf_set_drop_reason(skb, *drop_reason);
-- 
2.43.0



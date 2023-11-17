Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1A07EEE64
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbjKQJZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjKQJZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:25:24 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E984A5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:25:19 -0800 (PST)
X-UUID: 7176b2f80282472e8574b30914f06033-20231117
X-CID-UNFAMILIAR: 1
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_HamU
X-CID-O-INFO: VERSION:1.1.32,REQID:f3eccf0c-00ab-417d-ae43-71e88bacfbc8,IP:5,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:8
X-CID-INFO: VERSION:1.1.32,REQID:f3eccf0c-00ab-417d-ae43-71e88bacfbc8,IP:5,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_HamU,ACTION:
        release,TS:8
X-CID-META: VersionHash:5f78ec9,CLOUDID:dc328295-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:2311171725081OFJBT2L,BulkQuantity:0,Recheck:0,SF:66|24|16|19|44|102,
        TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_USA,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 7176b2f80282472e8574b30914f06033-20231117
X-User: jiangyunshui@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
        (envelope-from <jiangyunshui@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 58554572; Fri, 17 Nov 2023 17:25:07 +0800
From:   jiangyunshui <jiangyunshui@kylinos.cn>
To:     linux-kernel@vger.kernel.org
Cc:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        yunshui <jiangyunshui@kylinos.cn>, k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] netfilter: Correct misspelling comment word against
Date:   Fri, 17 Nov 2023 17:25:05 +0800
Message-Id: <20231117092505.34063-1-jiangyunshui@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yunshui <jiangyunshui@kylinos.cn>

The word 'agaist' on comment of struct tcp_error is misspelled.
Correct it to be 'against', avoiding confusing other developers.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: yunshui <jiangyunshui@kylinos.cn>
---
 net/netfilter/nf_conntrack_proto_tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index 4018acb1d674..6c7d1df2a11e 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -796,7 +796,7 @@ static void tcp_error_log(const struct sk_buff *skb,
 	nf_l4proto_log_invalid(skb, state, IPPROTO_TCP, "%s", msg);
 }
 
-/* Protect conntrack agaist broken packets. Code taken from ipt_unclean.c.  */
+/* Protect conntrack against broken packets. Code taken from ipt_unclean.c.  */
 static bool tcp_error(const struct tcphdr *th,
 		      struct sk_buff *skb,
 		      unsigned int dataoff,
-- 
2.25.1


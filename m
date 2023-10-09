Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4840C7BD226
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 04:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344825AbjJICyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 22:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjJICyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 22:54:35 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92388A4;
        Sun,  8 Oct 2023 19:54:33 -0700 (PDT)
X-UUID: 32ffd98f3bf5458f9196de2ce6920fc6-20231009
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:5774f625-9af4-41ad-8b8e-617d319afdd0,IP:-15
        ,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-20
X-CID-INFO: VERSION:1.1.32,REQID:5774f625-9af4-41ad-8b8e-617d319afdd0,IP:-15,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-20
X-CID-META: VersionHash:5f78ec9,CLOUDID:6fb8b8bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:231009105417AZF97K5Y,BulkQuantity:0,Recheck:0,SF:100|17|19|42|101|24
        |102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil
        ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 32ffd98f3bf5458f9196de2ce6920fc6-20231009
X-User: guodongtai@kylinos.cn
Received: from localhost.localdomain [(39.156.73.14)] by mailgw
        (envelope-from <guodongtai@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 260471370; Mon, 09 Oct 2023 10:54:16 +0800
From:   George Guo <guodongtai@kylinos.cn>
To:     fw@strlen.de
Cc:     coreteam@netfilter.org, davem@davemloft.net, dongtai.guo@linux.dev,
        edumazet@google.com, guodongtai@kylinos.cn, kadlec@netfilter.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pabeni@redhat.com, pablo@netfilter.org
Subject: [PATCH v2] netfilter: cleanup struct nft_table
Date:   Mon,  9 Oct 2023 10:55:48 +0800
Message-Id: <20231009025548.3522409-1-guodongtai@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231007105335.GB20662@breakpoint.cc>
References: <20231007105335.GB20662@breakpoint.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add comments for nlpid, family, udlen and udata in struct nft_table, and
afinfo is no longer a member of struct nft_table, so remove the comment
for it.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 include/net/netfilter/nf_tables.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 7c816359d5a9..9fb16485d08f 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1198,10 +1198,13 @@ static inline void nft_use_inc_restore(u32 *use)
  *	@hgenerator: handle generator state
  *	@handle: table handle
  *	@use: number of chain references to this table
+ *	@family:address family
  *	@flags: table flag (see enum nft_table_flags)
  *	@genmask: generation mask
- *	@afinfo: address family info
+ *	@nlpid: netlink port ID
  *	@name: name of the table
+ *	@udlen: length of the user data
+ *	@udata: user data
  *	@validate_state: internal, set when transaction adds jumps
  */
 struct nft_table {
-- 
2.34.1


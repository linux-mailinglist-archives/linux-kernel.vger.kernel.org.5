Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152717ADF86
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 21:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjIYTYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 15:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjIYTYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 15:24:46 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8999BE;
        Mon, 25 Sep 2023 12:24:39 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AED1D5C27BA;
        Mon, 25 Sep 2023 15:24:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 25 Sep 2023 15:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jcline.org; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1695669876; x=1695756276; bh=5YkBrqvzG1
        Jlekk42DoeCAtVDkGf3aQHqWIlJPo84PU=; b=rTEv/5QNmW1lbqE89+kczg1HvU
        PNborzPx7y2hTwMUgI6jTqbOgjhh6Z8OoPg7sgEJZ+R5H8oA3zeNtvlgjE4DPpvO
        WhpqknfknLmkDndQ5JSCQY6IAkDcFdOH1COKOzRRwKGUROUjoAK92ZUltgMaO7pN
        nbm6pLSoX8rtEQ12h/C52Hy7E36j+jyhPeJCt0jW5QDeBPYgCJKqJdvjIVOPgKDi
        83oZ9Voe4ofLn0zX52fZtHn85BSgLa8zYLQdQ72sFdAnXvoGKkCWP77DqAovz8FB
        jY2Q52SKWREr8/kc6bx7e69RbPMCq1QSFd7OWK89HINq5rFhlp3eVzcDz+Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695669876; x=1695756276; bh=5YkBrqvzG1Jle
        kk42DoeCAtVDkGf3aQHqWIlJPo84PU=; b=a8xN2o4LLDEoxAjLlu75CRIZh+ExM
        qsHmiFc7jjjoNQapYXt7/BOX3wBRzLXKetMTmMnVTf+2QJ8iBDCG4CTthCu38SVz
        xfGoxbzmQxukhQYdbpxy6bQtCb1PmWXoQbW7DyFkIEHFkyMxfADTvPvMWRTvIYzw
        /ZES2SdfcTBX9qXywqA627qjYV/zI1SWZC4iidI6lMGF7yRvj5c5junvtfk1z1kp
        ktsRtZ0pbLZoQsgDtwTpDLTA7fbl6XV/vmkX/xqjzcsvHW/uvkMf4CkSuvma1O4o
        ruJI29GUZHJwnjmBdkzAaMZxbylGXg8sqWTfYSyu2kX5EveIgx4e3pLqw==
X-ME-Sender: <xms:dN4RZf-VY4Tdr6CaCVkW1XzH35ox1cirpY8ip6vlQk9ywfciy7VWew>
    <xme:dN4RZbsTNIjMS2-U8ynYebeDZ2PSG8rnjzHr9ATZdxVGyNbQis_j2mN8KBTuVI-5h
    aSmQAu6Juu3GH9db5c>
X-ME-Received: <xmr:dN4RZdDAqhkDW5CGVVB4M0xaylW8PKtWErbvjlv4lUMaNk_dWHFjguPvkV7HdbaGMJyARmEFC0lzbhW7IcIkFKYgwvHokqnwwSLE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgedgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflvghrvghm
    hicuvehlihhnvgcuoehjvghrvghmhiesjhgtlhhinhgvrdhorhhgqeenucggtffrrghtth
    gvrhhnpeevleevfeehuefhhfeiudevgfdufeeivdefudetjeelffelgffgkedvuefhgfet
    veenucffohhmrghinhepshihiihkrghllhgvrhdrrghpphhsphhothdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvghrvghmhies
    jhgtlhhinhgvrdhorhhg
X-ME-Proxy: <xmx:dN4RZbdkkrsH-03oU-ruhJfuzskx6Qm33PkCB1Xw086OdVHrSt974w>
    <xmx:dN4RZUMQySrDol70N-GqvJcIRP5aUrL_oxk5Q4rX2r6olHVQeCcAIw>
    <xmx:dN4RZdm64nQGMH5agL90VLoGYjtMW9TYjE40nPQptoVzRr4BvFl7KQ>
    <xmx:dN4RZToh9iQN6wvxHod5Dpxd5FzKBowpDI5opgN7EgFFAiCWwl4aag>
Feedback-ID: i7a7146c5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Sep 2023 15:24:35 -0400 (EDT)
From:   Jeremy Cline <jeremy@jcline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Lin Ma <linma@zju.edu.cn>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeremy Cline <jeremy@jcline.org>,
        syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
Subject: [PATCH v2 net] net: nfc: llcp: Add lock when modifying device list
Date:   Mon, 25 Sep 2023 15:23:51 -0400
Message-ID: <20230925192351.40744-1-jeremy@jcline.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device list needs its associated lock held when modifying it, or the
list could become corrupted, as syzbot discovered.

Reported-and-tested-by: syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c1d0a03d305972dbbe14
Fixes: 6709d4b7bc2e ("net: nfc: Fix use-after-free caused by nfc_llcp_find_local")
Signed-off-by: Jeremy Cline <jeremy@jcline.org>
---
Changes from v1: added the correct Fixes tag

 net/nfc/llcp_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index f60e424e0607..6705bb895e23 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1636,7 +1636,9 @@ int nfc_llcp_register_device(struct nfc_dev *ndev)
 	timer_setup(&local->sdreq_timer, nfc_llcp_sdreq_timer, 0);
 	INIT_WORK(&local->sdreq_timeout_work, nfc_llcp_sdreq_timeout_work);
 
+	spin_lock(&llcp_devices_lock);
 	list_add(&local->list, &llcp_devices);
+	spin_unlock(&llcp_devices_lock);
 
 	return 0;
 }
-- 
2.41.0


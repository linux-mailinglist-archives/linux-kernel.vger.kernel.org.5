Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACB675D5A4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 22:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjGUUYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 16:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjGUUYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:24:30 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E1D4487;
        Fri, 21 Jul 2023 13:24:00 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 2745332009DD;
        Fri, 21 Jul 2023 16:23:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 21 Jul 2023 16:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1689970985; x=
        1690057385; bh=U14PeO4+rXqVyLZW6g7EGR1pARLExleSWSzTTiiVnD0=; b=O
        9AZpXGtG1+nbrF+df1ZkaI9sWVwjcMNZ2tkAmkrxfA94xjQyGO0K20UAfn217jkW
        wQ2RA1c8r5pcVvEQixsI4JiOxoRxKYc+sJ6Gt9uruj+xxi0ASYkN2gDsOH4uDCjt
        xl0sJbM7l3bMnBbxeuZB5regErt4SjBHnLWU3/EeNlpNd4vuagxXYNmOcsfSD5Jx
        oyLBB8+d5/0BxL/dZzJHMVbw8nwMCtEJjUbcfQhoJ27+q0U+RjYBQ6ufFX4dsnxM
        R0z5zJaMN8Fpd/CDuw4yEvq/KMCNfNBqxLasG0qWzx+79C/3gCa7DqpJAhtO0cX7
        tAtSF/JbNf/tBV0MGuk9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1689970985; x=
        1690057385; bh=U14PeO4+rXqVyLZW6g7EGR1pARLExleSWSzTTiiVnD0=; b=r
        D8J1ZMVLa6cetBxRc5F8peayoVjio3BOb1j+qdaIv1zePCJTRIoPreevyCF/pcNP
        qDbmsOs5GlpQiXIklu36WYRxQ2+qzVMh6SUfNvy9huXo5TneAyOewLeqVrM3r/Ey
        cqfNyPwDvgYXNt6iuNh4QulmnEwVkrBN8r0mqdZ83f06yIrOM5tbOlRPe4JjrcBD
        ObUk3OU08pZnKpttN/hH8ladIUxqXqkzIbtv6Mw1fqEBM7JOf/d/cZMfWae38W+/
        m8Q1qPZDu9Wv1z4l0Fj1xI9dXBpXJxy7k/6CqyTBP7z4sNDIMNA20v4PqxocrH9U
        55IFaW0wUnFnr1vQyoSVw==
X-ME-Sender: <xms:Kem6ZDSux0ba9jIle5RLpcbT5377HxLkzFG4rxBmlnNACSJZ1vV5lw>
    <xme:Kem6ZEwAboGPzXkdKPEpvo0B8jNJgTJnAxzpWRKiMRbQ0kjU8-9ghGk8W4Y4gLmxI
    d2n0qgxPk70BL07Yg>
X-ME-Received: <xmr:Kem6ZI3AihUx73PXpTfDJYr6N9ABdKSfu0csHnSz2-aqrCMYIplR1gMf5ZTTdampSyr9HiIB08LcK9BF72UlrWY_sRGXCmhOFnAspJR7TVc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgddugeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:Kem6ZDAW8uHIsESSG87e1un28AHoOx8BMMvGw5AAcAMM0dM1gloXMQ>
    <xmx:Kem6ZMhWhgR7ji46BCNuRhM3folke8ynZwyyzMf8anj5UmcniNdFNA>
    <xmx:Kem6ZHo_cZBFsIJzGKr8VjtomBUHAK4Xj9QFTg6xWz60jDZ0dHT1iw>
    <xmx:Kem6ZLQ0nQ7dEG1RgqyH9hGHY2I1t9dSmnK9Zt_M-L4Ak7YkpZZEjg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jul 2023 16:23:04 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     kadlec@netfilter.org, edumazet@google.com, fw@strlen.de,
        kuba@kernel.org, pabeni@redhat.com, pablo@netfilter.org,
        dsahern@kernel.org, davem@davemloft.net,
        alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v6 1/5] netfilter: defrag: Add glue hooks for enabling/disabling defrag
Date:   Fri, 21 Jul 2023 14:22:45 -0600
Message-ID: <f6a8824052441b72afe5285acedbd634bd3384c1.1689970773.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689970773.git.dxu@dxuuu.xyz>
References: <cover.1689970773.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to be able to enable/disable IP packet defrag from core
bpf/netfilter code. In other words, execute code from core that could
possibly be built as a module.

To help avoid symbol resolution errors, use glue hooks that the modules
will register callbacks with during module init.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/netfilter.h                 | 10 ++++++++++
 net/ipv4/netfilter/nf_defrag_ipv4.c       | 17 ++++++++++++++++-
 net/ipv6/netfilter/nf_defrag_ipv6_hooks.c | 11 +++++++++++
 net/netfilter/core.c                      |  6 ++++++
 4 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index d4fed4c508ca..d68644b7c299 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -11,6 +11,7 @@
 #include <linux/wait.h>
 #include <linux/list.h>
 #include <linux/static_key.h>
+#include <linux/module.h>
 #include <linux/netfilter_defs.h>
 #include <linux/netdevice.h>
 #include <linux/sockptr.h>
@@ -481,6 +482,15 @@ struct nfnl_ct_hook {
 };
 extern const struct nfnl_ct_hook __rcu *nfnl_ct_hook;
 
+struct nf_defrag_hook {
+	struct module *owner;
+	int (*enable)(struct net *net);
+	void (*disable)(struct net *net);
+};
+
+extern const struct nf_defrag_hook __rcu *nf_defrag_v4_hook;
+extern const struct nf_defrag_hook __rcu *nf_defrag_v6_hook;
+
 /*
  * nf_skb_duplicated - TEE target has sent a packet
  *
diff --git a/net/ipv4/netfilter/nf_defrag_ipv4.c b/net/ipv4/netfilter/nf_defrag_ipv4.c
index e61ea428ea18..a9ba7de092c4 100644
--- a/net/ipv4/netfilter/nf_defrag_ipv4.c
+++ b/net/ipv4/netfilter/nf_defrag_ipv4.c
@@ -7,6 +7,7 @@
 #include <linux/ip.h>
 #include <linux/netfilter.h>
 #include <linux/module.h>
+#include <linux/rcupdate.h>
 #include <linux/skbuff.h>
 #include <net/netns/generic.h>
 #include <net/route.h>
@@ -113,17 +114,31 @@ static void __net_exit defrag4_net_exit(struct net *net)
 	}
 }
 
+static const struct nf_defrag_hook defrag_hook = {
+	.owner = THIS_MODULE,
+	.enable = nf_defrag_ipv4_enable,
+	.disable = nf_defrag_ipv4_disable,
+};
+
 static struct pernet_operations defrag4_net_ops = {
 	.exit = defrag4_net_exit,
 };
 
 static int __init nf_defrag_init(void)
 {
-	return register_pernet_subsys(&defrag4_net_ops);
+	int err;
+
+	err = register_pernet_subsys(&defrag4_net_ops);
+	if (err)
+		return err;
+
+	rcu_assign_pointer(nf_defrag_v4_hook, &defrag_hook);
+	return err;
 }
 
 static void __exit nf_defrag_fini(void)
 {
+	rcu_assign_pointer(nf_defrag_v4_hook, NULL);
 	unregister_pernet_subsys(&defrag4_net_ops);
 }
 
diff --git a/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c b/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
index cb4eb1d2c620..d59b296b4f51 100644
--- a/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
+++ b/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/icmp.h>
+#include <linux/rcupdate.h>
 #include <linux/sysctl.h>
 #include <net/ipv6_frag.h>
 
@@ -96,6 +97,12 @@ static void __net_exit defrag6_net_exit(struct net *net)
 	}
 }
 
+static const struct nf_defrag_hook defrag_hook = {
+	.owner = THIS_MODULE,
+	.enable = nf_defrag_ipv6_enable,
+	.disable = nf_defrag_ipv6_disable,
+};
+
 static struct pernet_operations defrag6_net_ops = {
 	.exit = defrag6_net_exit,
 };
@@ -114,6 +121,9 @@ static int __init nf_defrag_init(void)
 		pr_err("nf_defrag_ipv6: can't register pernet ops\n");
 		goto cleanup_frag6;
 	}
+
+	rcu_assign_pointer(nf_defrag_v6_hook, &defrag_hook);
+
 	return ret;
 
 cleanup_frag6:
@@ -124,6 +134,7 @@ static int __init nf_defrag_init(void)
 
 static void __exit nf_defrag_fini(void)
 {
+	rcu_assign_pointer(nf_defrag_v6_hook, NULL);
 	unregister_pernet_subsys(&defrag6_net_ops);
 	nf_ct_frag6_cleanup();
 }
diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index 5f76ae86a656..ef4e76e5aef9 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -680,6 +680,12 @@ EXPORT_SYMBOL_GPL(nfnl_ct_hook);
 const struct nf_ct_hook __rcu *nf_ct_hook __read_mostly;
 EXPORT_SYMBOL_GPL(nf_ct_hook);
 
+const struct nf_defrag_hook __rcu *nf_defrag_v4_hook __read_mostly;
+EXPORT_SYMBOL_GPL(nf_defrag_v4_hook);
+
+const struct nf_defrag_hook __rcu *nf_defrag_v6_hook __read_mostly;
+EXPORT_SYMBOL_GPL(nf_defrag_v6_hook);
+
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 u8 nf_ctnetlink_has_listener;
 EXPORT_SYMBOL_GPL(nf_ctnetlink_has_listener);
-- 
2.41.0


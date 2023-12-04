Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B586B80407F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbjLDU5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbjLDU45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:56:57 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E80D138;
        Mon,  4 Dec 2023 12:56:57 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 9504C5C0238;
        Mon,  4 Dec 2023 15:56:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 04 Dec 2023 15:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1701723416; x=
        1701809816; bh=UcXo1ArXPqQ9bSXiMAigIass8f59dei4sHavEoNqsjQ=; b=c
        0OTYxpp26YKzc32ZOiRJF//hyv+3DhxRi7QfGrwB0zs0s5UFfcPRBJLf1vQ5Sq+o
        WfqSka+3EKQx7EgLlHJ2sJPMnYKWLts0ITDv2ZuFKh6zXjSkOLd+AyTw8kw5iZij
        Tte6OTJPANmkM+9g03vuD+m2DhN0ViNQX230e9j4vGWXmJDcZ+gt46b+0Ls/5hGy
        192j6YeoavpycENV2pEK4A2CVQx+1eZWvQleIlSL804SqVj0uByArBQKnOBa7AQs
        Y91e7a+hAiNqGIJTgIeBuaKnDRXfgi9kCo+ypYj6ngukz21dsJdVHKggDPjxwfYZ
        1LzUKz1/e4c7Yju6UzK8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701723416; x=
        1701809816; bh=UcXo1ArXPqQ9bSXiMAigIass8f59dei4sHavEoNqsjQ=; b=2
        EZLbM7XdJ77A2rIAaZN0pdUhDtynCbJCX3TwVdaGivcTey1LwXKQZQXkwfqaWbDF
        WMuXbku35SVwOTxTNwQ2OiBSZBoPPQa63W48hzIBdE102n6bvm/ai5y1mwFQiCRk
        TVQGBxUILiR+qb8Y/qb9CIpYuTNNW5vS0pkzkgApfNxQRDXA3dcrEW0BpuUfCTSA
        K2/m8pk98r98akzxzrMs3LzFpMJqkvKjKeyTXk+ghmlc0wxnoTY0yl9jN/QR6uOi
        pWwls3cAatqcL5uG3QHuy6//xDfIRdxxdEB8Yyv/QNpMr6W141ifg7ufTLmAWlRr
        q4rvXX2izNAfDuZIuQmiw==
X-ME-Sender: <xms:GD1uZS1qnhTt2dSEez7TZ37Oh4C4vzhCdyteAlR-AdLtzhN-5CzX9g>
    <xme:GD1uZVG_SUq_0xwINiDxyWiK-TBIxSaI_EI8pp_pJPIo4E6HorJGo8qj4wd2Bg12F
    dJ6e9w7iMTYU8BHnQ>
X-ME-Received: <xmr:GD1uZa6TVXdC50VTzPR7XMZHWIKt4a_GOQoBK88x4c4zFtJxx7NqAroXMTvy33d7OEs2cPzWKyHYXM5cgjoILrmtbx7u0IgQ3knBOjMSfeE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpefgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleej
    jeekgfffgefhtddtteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:GD1uZT2haf-ugO1Cbokod6hIgnY2vcyK-opZujVADbJF30oIjaJIGA>
    <xmx:GD1uZVE5Vm0OvFqKa1dAYoW8bdx3zqSf2S6XBwxOhAeIwNx0G_hXvA>
    <xmx:GD1uZc_Jx5o-NJSYsM0ynN9j4qSELoEevez1YyoNg9vyWVlVxTCEyw>
    <xmx:GD1uZbWuA25p1yLkXsLBg_ThwPqmYUXNA2_1lxcvl6L0xgruYjMDAA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Dec 2023 15:56:54 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        Herbert Xu <herbert@gondor.apana.org.au>,
        steffen.klassert@secunet.com, pabeni@redhat.com, hawk@kernel.org,
        john.fastabend@gmail.com, kuba@kernel.org, edumazet@google.com,
        antony.antony@secunet.com, alexei.starovoitov@gmail.com,
        yonghong.song@linux.dev, eddyz87@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, devel@linux-ipsec.org
Subject: [PATCH bpf-next v4 02/10] bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
Date:   Mon,  4 Dec 2023 13:56:22 -0700
Message-ID: <e0e2fc6161ceccfbb1075d367bcc37871012072d.1701722991.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1701722991.git.dxu@dxuuu.xyz>
References: <cover.1701722991.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds an unstable kfunc helper to access internal xfrm_state
associated with an SA. This is intended to be used for the upcoming
IPsec pcpu work to assign special pcpu SAs to a particular CPU. In other
words: for custom software RSS.

That being said, the function that this kfunc wraps is fairly generic
and used for a lot of xfrm tasks. I'm sure people will find uses
elsewhere over time.

Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/net/xfrm.h     |   9 ++++
 net/xfrm/xfrm_bpf.c    | 102 +++++++++++++++++++++++++++++++++++++++++
 net/xfrm/xfrm_policy.c |   2 +
 3 files changed, 113 insertions(+)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index c9bb0f892f55..1d107241b901 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -2190,4 +2190,13 @@ static inline int register_xfrm_interface_bpf(void)
 
 #endif
 
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF)
+int register_xfrm_state_bpf(void);
+#else
+static inline int register_xfrm_state_bpf(void)
+{
+	return 0;
+}
+#endif
+
 #endif	/* _NET_XFRM_H */
diff --git a/net/xfrm/xfrm_bpf.c b/net/xfrm/xfrm_bpf.c
index 3d3018b87f96..3d6cac7345ca 100644
--- a/net/xfrm/xfrm_bpf.c
+++ b/net/xfrm/xfrm_bpf.c
@@ -6,9 +6,11 @@
  */
 
 #include <linux/bpf.h>
+#include <linux/btf.h>
 #include <linux/btf_ids.h>
 
 #include <net/dst_metadata.h>
+#include <net/xdp.h>
 #include <net/xfrm.h>
 
 #if IS_BUILTIN(CONFIG_XFRM_INTERFACE) || \
@@ -112,3 +114,103 @@ int __init register_xfrm_interface_bpf(void)
 }
 
 #endif /* xfrm interface */
+
+/* bpf_xfrm_state_opts - Options for XFRM state lookup helpers
+ *
+ * Members:
+ * @error      - Out parameter, set for any errors encountered
+ *		 Values:
+ *		   -EINVAL - netns_id is less than -1
+ *		   -EINVAL - opts__sz isn't BPF_XFRM_STATE_OPTS_SZ
+ *		   -ENONET - No network namespace found for netns_id
+ * @netns_id	- Specify the network namespace for lookup
+ *		 Values:
+ *		   BPF_F_CURRENT_NETNS (-1)
+ *		     Use namespace associated with ctx
+ *		   [0, S32_MAX]
+ *		     Network Namespace ID
+ * @mark	- XFRM mark to match on
+ * @daddr	- Destination address to match on
+ * @spi		- Security parameter index to match on
+ * @proto	- L3 protocol to match on
+ * @family	- L3 protocol family to match on
+ */
+struct bpf_xfrm_state_opts {
+	s32 error;
+	s32 netns_id;
+	u32 mark;
+	xfrm_address_t daddr;
+	__be32 spi;
+	u8 proto;
+	u16 family;
+};
+
+enum {
+	BPF_XFRM_STATE_OPTS_SZ = sizeof(struct bpf_xfrm_state_opts),
+};
+
+__bpf_kfunc_start_defs();
+
+/* bpf_xdp_get_xfrm_state - Get XFRM state
+ *
+ * Parameters:
+ * @ctx	- Pointer to ctx (xdp_md) in XDP program
+ *		    Cannot be NULL
+ * @opts	- Options for lookup (documented above)
+ *		    Cannot be NULL
+ * @opts__sz	- Length of the bpf_xfrm_state_opts structure
+ *		    Must be BPF_XFRM_STATE_OPTS_SZ
+ */
+__bpf_kfunc struct xfrm_state *
+bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *opts, u32 opts__sz)
+{
+	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
+	struct net *net = dev_net(xdp->rxq->dev);
+	struct xfrm_state *x;
+
+	if (!opts || opts__sz < sizeof(opts->error))
+		return NULL;
+
+	if (opts__sz != BPF_XFRM_STATE_OPTS_SZ) {
+		opts->error = -EINVAL;
+		return NULL;
+	}
+
+	if (unlikely(opts->netns_id < BPF_F_CURRENT_NETNS)) {
+		opts->error = -EINVAL;
+		return NULL;
+	}
+
+	if (opts->netns_id >= 0) {
+		net = get_net_ns_by_id(net, opts->netns_id);
+		if (unlikely(!net)) {
+			opts->error = -ENONET;
+			return NULL;
+		}
+	}
+
+	x = xfrm_state_lookup(net, opts->mark, &opts->daddr, opts->spi,
+			      opts->proto, opts->family);
+
+	if (opts->netns_id >= 0)
+		put_net(net);
+
+	return x;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_SET8_START(xfrm_state_kfunc_set)
+BTF_ID_FLAGS(func, bpf_xdp_get_xfrm_state, KF_RET_NULL | KF_ACQUIRE)
+BTF_SET8_END(xfrm_state_kfunc_set)
+
+static const struct btf_kfunc_id_set xfrm_state_xdp_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &xfrm_state_kfunc_set,
+};
+
+int __init register_xfrm_state_bpf(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
+					 &xfrm_state_xdp_kfunc_set);
+}
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index c13dc3ef7910..1b7e75159727 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4218,6 +4218,8 @@ void __init xfrm_init(void)
 #ifdef CONFIG_XFRM_ESPINTCP
 	espintcp_init();
 #endif
+
+	register_xfrm_state_bpf();
 }
 
 #ifdef CONFIG_AUDITSYSCALL
-- 
2.42.1


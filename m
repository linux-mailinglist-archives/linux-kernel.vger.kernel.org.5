Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A08D7FC1D9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346709AbjK1Rza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346718AbjK1Ry5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:54:57 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D33F19A9;
        Tue, 28 Nov 2023 09:54:56 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 84CC8580546;
        Tue, 28 Nov 2023 12:54:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 28 Nov 2023 12:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1701194095; x=
        1701201295; bh=dglH5gXWrAma2xG/u6UyN2gBVthWUPYa50A8Hb6InUE=; b=W
        ufyli4REJ6JnBRtaCU0Pz86CKsnf932Pu+Z1cKsmfMjG+Ci4d7bs9UUBeQFI2a3Z
        8XUw42JDgjOHCUPM3IqNgQMLNWZZBE5mt7sCPf5c/ysdk++c7IoenDZg4nBbOHgK
        b9IZnrV6XiK0nqYbArcBNb84FCOoqEtRH0UyQl56be+MlJddD5cNNA3uURFbIVQ9
        K5KOpbQzaNS7V84uasdXFWMEdArjFCSVP7ZNZ3te7gFsthpvlohNiLJLLqAgZhF5
        KUceYnLFE63tbc7oQuSWRgc8+PLMOovz3AwuVJzUPYagEBjCQ86VfUz3SMNvKPpm
        ncjiXkY5X+M9c8irtsWsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701194095; x=
        1701201295; bh=dglH5gXWrAma2xG/u6UyN2gBVthWUPYa50A8Hb6InUE=; b=y
        5wRvLz4my7qdH4DHDizhlFoKpOIq6VA5lVQT2dAdB9OCLcoHpLR2/h0Ya2qG5SXF
        lrr7hXSr1D61GEM6vFPQYc55luZEnd/oNsvWfA6lBCoTuSinKaDEhPF7E3VvImCG
        t6exMEvJQ3gChzFrKv9T6gjnoqsnCCFTjk7Q+eVc7xINCj4UrYNRrvqhVjrPJxQb
        GQr6pK+b45s7QtsFOCBOeVBSkDUZou2MeHBjateUWZuvq6JFP+GyeAGpl974niC/
        AfCOMPr2zLvHhDZKlvRYJrshrkjlk3DyUJMn8Im9dU7FDs7CAHXkeEJUkMo8D4PW
        BVQwi6K/oLv8bMcVsxPng==
X-ME-Sender: <xms:bylmZWO4XUb9EqEM6kK8jyLoBBMWTq5gDHokmdt7hRMZDiDnJd-v9A>
    <xme:bylmZU-QykbjCCqzLdHG23jCSf3ylOUY8PtbySJa4j30eZHmyhjBFxToH6rhANTHs
    jGmldZoGmRuWjUJ1Q>
X-ME-Received: <xmr:bylmZdTDGqQivf7yrOZDNNv2HTLOCBS9VyVVUwlm7Rd5M0V72OLDfYafMtxCbYktMIFeRI39Zz36nptph-Ruqkwm2w2r5fBpykwFSWBeLhvmAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeifedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculddvfedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeigeffteehteffhe
    ejkeefjeeuudfgvdekkeetudeghedugffgleffhefgjeevgfenucffohhmrghinheplhhl
    vhhmrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:bylmZWtFqY_DIcSfbFUCTdRsfZhPtVOkkehK_kjwG5GUiD4K65Cl2A>
    <xmx:bylmZed0WETNxDW3GiDSQZmCAZbiA6Hk64YnwvkRrqha2IVhKQ_APA>
    <xmx:bylmZa3siyrx_9Djkorp1ValDwlR-pkwuJWvHBND0_0U_APEgit68Q>
    <xmx:bylmZaFLmtqr7-sonV0zW190AeyfNWycjj9dIAL-ZnKr-gGpSUvKEA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Nov 2023 12:54:53 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     ndesaulniers@google.com, andrii@kernel.org, nathan@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, steffen.klassert@secunet.com,
        antony.antony@secunet.com, alexei.starovoitov@gmail.com,
        yonghong.song@linux.dev, eddyz87@gmail.com
Cc:     martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, trix@redhat.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        devel@linux-ipsec.org, netdev@vger.kernel.org
Subject: [PATCH ipsec-next v2 3/6] libbpf: Add BPF_CORE_WRITE_BITFIELD() macro
Date:   Tue, 28 Nov 2023 10:54:23 -0700
Message-ID: <ed7920365daf5eff1c82892b57e918d3db786ac7.1701193577.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1701193577.git.dxu@dxuuu.xyz>
References: <cover.1701193577.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to reading from CO-RE bitfields, we need a CO-RE aware bitfield
writing wrapper to make the verifier happy.

Two alternatives to this approach are:

1. Use the upcoming `preserve_static_offset` [0] attribute to disable
   CO-RE on specific structs.
2. Use broader byte-sized writes to write to bitfields.

(1) is a bit a bit hard to use. It requires specific and
not-very-obvious annotations to bpftool generated vmlinux.h. It's also
not generally available in released LLVM versions yet.

(2) makes the code quite hard to read and write. And especially if
BPF_CORE_READ_BITFIELD() is already being used, it makes more sense to
to have an inverse helper for writing.

[0]: https://reviews.llvm.org/D133361
From: Eduard Zingerman <eddyz87@gmail.com>

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/lib/bpf/bpf_core_read.h | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index 1ac57bb7ac55..7a764f65d299 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -111,6 +111,42 @@ enum bpf_enum_value_kind {
 	val;								      \
 })
 
+/*
+ * Write to a bitfield, identified by s->field.
+ * This is the inverse of BPF_CORE_WRITE_BITFIELD().
+ */
+#define BPF_CORE_WRITE_BITFIELD(s, field, new_val) ({			\
+	void *p = (void *)s + __CORE_RELO(s, field, BYTE_OFFSET);	\
+	unsigned int byte_size = __CORE_RELO(s, field, BYTE_SIZE);	\
+	unsigned int lshift = __CORE_RELO(s, field, LSHIFT_U64);	\
+	unsigned int rshift = __CORE_RELO(s, field, RSHIFT_U64);	\
+	unsigned int bit_size = (rshift - lshift);			\
+	unsigned long long nval, val, hi, lo;				\
+									\
+	asm volatile("" : "+r"(p));					\
+									\
+	switch (byte_size) {						\
+	case 1: val = *(unsigned char *)p; break;			\
+	case 2: val = *(unsigned short *)p; break;			\
+	case 4: val = *(unsigned int *)p; break;			\
+	case 8: val = *(unsigned long long *)p; break;			\
+	}								\
+	hi = val >> (bit_size + rshift);				\
+	hi <<= bit_size + rshift;					\
+	lo = val << (bit_size + lshift);				\
+	lo >>= bit_size + lshift;					\
+	nval = new_val;							\
+	nval <<= lshift;						\
+	nval >>= rshift;						\
+	val = hi | nval | lo;						\
+	switch (byte_size) {						\
+	case 1: *(unsigned char *)p      = val; break;			\
+	case 2: *(unsigned short *)p     = val; break;			\
+	case 4: *(unsigned int *)p       = val; break;			\
+	case 8: *(unsigned long long *)p = val; break;			\
+	}								\
+})
+
 #define ___bpf_field_ref1(field)	(field)
 #define ___bpf_field_ref2(type, field)	(((typeof(type) *)0)->field)
 #define ___bpf_field_ref(args...)					    \
-- 
2.42.1


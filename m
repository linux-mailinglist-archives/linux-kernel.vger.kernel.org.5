Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C939680144F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjLAUYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjLAUX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:23:58 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D21710F4;
        Fri,  1 Dec 2023 12:24:02 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6FB97580994;
        Fri,  1 Dec 2023 15:24:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 01 Dec 2023 15:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1701462241; x=
        1701469441; bh=uvTwqTAZ/68O3KK7heo5AiD3gEgHNW4W5lf/fdX2H2o=; b=K
        KxjWq6I0Rx6qT+PjICwtMdv+khHm0zKdXc8MnzTorgJsfseEYpzPsvP+8RjmabMc
        peFPWIYTZCRHo9m+V7VsSUr+7N5jL06vqSR6ubrmDhpwci2C6b+QzstBnbi3CJNA
        l+qcQco9tUoqN06VdvZCIvFvEs/ity9Ndf1hnuSQ0gWrp/XP3FpzpUX85tiZkZI2
        loxmtdCX9OYRmM8G/OZsrpXOlaZU1iad1K6Ogg1ZOub+JM/59MiWXFQJbCFhpees
        yAjou/5l2yj+AWDugeBUJoKX95P5LSDZbevlTklW27HaDhvw+joYBLcsomeiKzQG
        uEScp44bYagRepShCxjRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701462241; x=
        1701469441; bh=uvTwqTAZ/68O3KK7heo5AiD3gEgHNW4W5lf/fdX2H2o=; b=C
        I8LCAn0eZsG2zJ4sBKcca3TYOfWtlOD5UfNzpbdV/9icdG4MY8Fi33fwGAH8r3e8
        RG3643pqYELdxubemBKeLgSUzJbMpulD1hlhJABQdO4QAGkC4sjNg2sd72qXUfMr
        RY7CTFUOO6ygyC1XePaZjClGQbz3ux0BpvIwS+sXU0HNwIkRPk5CTpLhXJudN/Qf
        a213iXebdLi7UmCBq/kAYlQVD/C2DMcGkZIkpxjsyVPLNO+/O8LQWF5NhMB5G05G
        dxJbpRohGnHTbjDF4WUBmwkZa0ZkpaN+2bnsmxrdARmbt25yck2Omzn+8R0eT/wo
        UBHegv8Sa+Kvj/c2yBPOQ==
X-ME-Sender: <xms:4UBqZaVvQIAZyHdcOttCcIDqI46CUytrn79KWNV1uLw-qbENrt2wKg>
    <xme:4UBqZWnjz8kdVwI2gAd8DsaDgWRFTXQfYsSG3e_tHnF8W_ilR9bDOJ3R3L-3_egSv
    rDpl2xJ0bQfcueHfg>
X-ME-Received: <xmr:4UBqZeaBAF5S2U0xHTQiEq8tSAqP5pa9fERzNLguXwj0GWxj6w9j7Wcl47VnhFX4u9X9WHnFPzh8N4JeiIxuwYQA-DSuxPp6D91MqKFvBxqB4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:4UBqZRVf1_Niz9ZcCw_lMQV3sbSMJdBs3Lnq2173sXzP8RbjysPSEA>
    <xmx:4UBqZUkewGuEJ1VzygStHTSThoHywugLuL3vRUPEH47JTzOlygk-WA>
    <xmx:4UBqZWcXNTYXWF_TNuUznzcy9Tnw2CbWxt3ln5dl_FxV-_zwREIxcQ>
    <xmx:4UBqZcEAEEZdgZRdsjMYvQuNSoVIvf_BzaquY9FyoHSSVN4S2JptUw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 15:23:59 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        andrii@kernel.org, steffen.klassert@secunet.com,
        antony.antony@secunet.com, alexei.starovoitov@gmail.com,
        yonghong.song@linux.dev, eddyz87@gmail.com
Cc:     mykolal@fb.com, martin.lau@linux.dev, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        devel@linux-ipsec.org, netdev@vger.kernel.org
Subject: [PATCH ipsec-next v3 5/9] libbpf: selftests: Add verifier tests for CO-RE bitfield writes
Date:   Fri,  1 Dec 2023 13:23:16 -0700
Message-ID: <e4d14fb5f07145ff4a367cc01d8dcf6c82581c88.1701462010.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1701462010.git.dxu@dxuuu.xyz>
References: <cover.1701462010.git.dxu@dxuuu.xyz>
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

Add some tests that exercise BPF_CORE_WRITE_BITFIELD() macro. Since some
non-trivial bit fiddling is going on, make sure various edge cases (such
as adjacent bitfields and bitfields at the edge of structs) are
exercised.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_bitfield_write.c       | 100 ++++++++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bitfield_write.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 5cfa7a6316b6..67b4948865a3 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -6,6 +6,7 @@
 #include "verifier_and.skel.h"
 #include "verifier_array_access.skel.h"
 #include "verifier_basic_stack.skel.h"
+#include "verifier_bitfield_write.skel.h"
 #include "verifier_bounds.skel.h"
 #include "verifier_bounds_deduction.skel.h"
 #include "verifier_bounds_deduction_non_const.skel.h"
@@ -115,6 +116,7 @@ static void run_tests_aux(const char *skel_name,
 
 void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack); }
+void test_verifier_bitfield_write(void)       { RUN(verifier_bitfield_write); }
 void test_verifier_bounds(void)               { RUN(verifier_bounds); }
 void test_verifier_bounds_deduction(void)     { RUN(verifier_bounds_deduction); }
 void test_verifier_bounds_deduction_non_const(void)     { RUN(verifier_bounds_deduction_non_const); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_bitfield_write.c b/tools/testing/selftests/bpf/progs/verifier_bitfield_write.c
new file mode 100644
index 000000000000..8fe355a19ba6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_bitfield_write.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <stdint.h>
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+
+#include "bpf_misc.h"
+
+struct core_reloc_bitfields {
+	/* unsigned bitfields */
+	uint8_t		ub1: 1;
+	uint8_t		ub2: 2;
+	uint32_t	ub7: 7;
+	/* signed bitfields */
+	int8_t		sb4: 4;
+	int32_t		sb20: 20;
+	/* non-bitfields */
+	uint32_t	u32;
+	int32_t		s32;
+} __attribute__((preserve_access_index));
+
+SEC("tc")
+__description("single CO-RE bitfield roundtrip")
+__btf_path("btf__core_reloc_bitfields.bpf.o")
+__success __failure_unpriv
+__retval(3)
+int single_field_roundtrip(struct __sk_buff *ctx)
+{
+	struct core_reloc_bitfields bitfields;
+
+	__builtin_memset(&bitfields, 0, sizeof(bitfields));
+	BPF_CORE_WRITE_BITFIELD(&bitfields, ub2, 3);
+	return BPF_CORE_READ_BITFIELD(&bitfields, ub2);
+}
+
+SEC("tc")
+__description("multiple CO-RE bitfield roundtrip")
+__btf_path("btf__core_reloc_bitfields.bpf.o")
+__success __failure_unpriv
+__retval(0x3FD)
+int multiple_field_roundtrip(struct __sk_buff *ctx)
+{
+	struct core_reloc_bitfields bitfields;
+	uint8_t ub2;
+	int8_t sb4;
+
+	__builtin_memset(&bitfields, 0, sizeof(bitfields));
+	BPF_CORE_WRITE_BITFIELD(&bitfields, ub2, 1);
+	BPF_CORE_WRITE_BITFIELD(&bitfields, sb4, -1);
+
+	ub2 = BPF_CORE_READ_BITFIELD(&bitfields, ub2);
+	sb4 = BPF_CORE_READ_BITFIELD(&bitfields, sb4);
+
+	return (((uint8_t)sb4) << 2) | ub2;
+}
+
+SEC("tc")
+__description("adjacent CO-RE bitfield roundtrip")
+__btf_path("btf__core_reloc_bitfields.bpf.o")
+__success __failure_unpriv
+__retval(7)
+int adjacent_field_roundtrip(struct __sk_buff *ctx)
+{
+	struct core_reloc_bitfields bitfields;
+	uint8_t ub1, ub2;
+
+	__builtin_memset(&bitfields, 0, sizeof(bitfields));
+	BPF_CORE_WRITE_BITFIELD(&bitfields, ub1, 1);
+	BPF_CORE_WRITE_BITFIELD(&bitfields, ub2, 3);
+
+	ub1 = BPF_CORE_READ_BITFIELD(&bitfields, ub1);
+	ub2 = BPF_CORE_READ_BITFIELD(&bitfields, ub2);
+
+	return (ub2 << 1) | ub1;
+}
+
+SEC("tc")
+__description("multibyte CO-RE bitfield roundtrip")
+__btf_path("btf__core_reloc_bitfields.bpf.o")
+__success __failure_unpriv
+__retval(0x21)
+int multibyte_field_roundtrip(struct __sk_buff *ctx)
+{
+	struct core_reloc_bitfields bitfields;
+	uint32_t ub7;
+	uint8_t ub1;
+
+	__builtin_memset(&bitfields, 0, sizeof(bitfields));
+	BPF_CORE_WRITE_BITFIELD(&bitfields, ub1, 1);
+	BPF_CORE_WRITE_BITFIELD(&bitfields, ub7, 16);
+
+	ub1 = BPF_CORE_READ_BITFIELD(&bitfields, ub1);
+	ub7 = BPF_CORE_READ_BITFIELD(&bitfields, ub7);
+
+	return (ub7 << 1) | ub1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.42.1


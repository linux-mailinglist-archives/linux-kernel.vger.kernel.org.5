Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F36680DB6E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345016AbjLKUUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345042AbjLKUUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:20:39 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C118A111;
        Mon, 11 Dec 2023 12:20:41 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id EDEC258094E;
        Mon, 11 Dec 2023 15:20:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 11 Dec 2023 15:20:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1702326040; x=
        1702333240; bh=/AYNOAxNgVK/QVMc0AlL/YbO7UaSJXnY0NdrYpUsy9Q=; b=O
        rScFgsrSI3Ca63LEb5JY4G8lVxf12WyeFKd6fIM6DpEvW7GDQSLPlhLm3hNXZqBQ
        4NfFvZGb4/eatIePZmyf3go5LxO+nQ+ck/E+Bbw5wJ8R+84RYc1QvrPdyB+GpL46
        ZRBY7FJX4wAtZA38ynaB4/OqtGReFQs5nkNw9HIHwxtzCuYmdoYl8LEAGPtBiAxQ
        TjaDtF4n3zLZZRT3o0svJim/bNxe6FMvktw2PsTnYxvF7PcUtOdje/gcQmsiNBge
        Cun65vH241pu8q7LyJoSWtmfbMNl/tdmC0C3nRuSsjp7skVW7X4uc6IIytyivIcQ
        Xf4nHdUdnM1gyYU/8pLdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702326040; x=
        1702333240; bh=/AYNOAxNgVK/QVMc0AlL/YbO7UaSJXnY0NdrYpUsy9Q=; b=d
        SsN1w6nyi+D6SqhFggOXfULg8IhaQ/iIi/Wf2nMyMosIq+LuZqju0TOml0piTCcD
        Rtd+lkQiYXhoi6nGzpMMbdse58+Iw0HM/AfwU5AB5PNGpVEMScVY/9l7gRNxBu5z
        B/AYM/90WT4sSjrwJMFSKRb9XS1WrPFY0y18EYMonKVDdNg+XfdN2JsYtFQonU7u
        23OQQqzcTzuZ8gNKcfexQu8MC7CJ/NYJ95q8krGgDsqsjgX6MUXdx/tbsqIJzp2/
        0DAu++4Ban0VBk8EXGoQ4el/N/Xr7/UH5bS8oL1ExlQyFD5dx/rJwt7D4bvbW7Uj
        R4ULyeMoU3q90Y89rJ3lQ==
X-ME-Sender: <xms:GG93ZYNkl02u_0a2CEo-Kc6rZGlpfl5vslgCOsvWw7sEUFV3_pecVg>
    <xme:GG93Ze-ZfZjd0AaiwBUCY_yL6BNJVxvoJgDra5yYzBA5AlKoG012U4SJG7JZaU5Yh
    462N1mHz1VxSteqCw>
X-ME-Received: <xmr:GG93ZfSce-c3NpM7K_fwbePCooZfZH0zRdYmkPOylliJdaYg4sdYpAMdMPd9_YhmEH3J6VizgCoIGZTpNqDcNLAbCdFbX99RK3XHuKp20gU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:GG93ZQt4eCyIDtgH1-JOtTAbXMNuvazeFw2c_qXVe6PQ-CvurMwqLA>
    <xmx:GG93ZQfDjJtd1m1TLV8eJtBeQ1rbaFh6ZL_a63l9kDdvyUwqK7ITxg>
    <xmx:GG93ZU3wgQ_JJivs4ZiG3UyjBjZAdSUlR9dis5Vk1qLAm_jnrDckng>
    <xmx:GG93ZUFk8tr0smit5rebNRJsRQUfCt7obY25452nzmPR36JAg2qFJg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 15:20:38 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     ast@kernel.org, andrii@kernel.org, shuah@kernel.org,
        daniel@iogearbox.net, steffen.klassert@secunet.com,
        antony.antony@secunet.com, alexei.starovoitov@gmail.com,
        yonghong.song@linux.dev, eddyz87@gmail.com, eyal.birger@gmail.com
Cc:     mykolal@fb.com, martin.lau@linux.dev, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        devel@linux-ipsec.org, netdev@vger.kernel.org
Subject: [PATCH bpf-next v5 5/9] bpf: selftests: Add verifier tests for CO-RE bitfield writes
Date:   Mon, 11 Dec 2023 13:20:09 -0700
Message-ID: <72698a1080fa565f541d5654705255984ea2a029.1702325874.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1702325874.git.dxu@dxuuu.xyz>
References: <cover.1702325874.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_bitfield_write.c       | 100 ++++++++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bitfield_write.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 8d746642cbd7..ac49ec25211d 100644
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
@@ -116,6 +117,7 @@ static void run_tests_aux(const char *skel_name,
 
 void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack); }
+void test_verifier_bitfield_write(void)       { RUN(verifier_bitfield_write); }
 void test_verifier_bounds(void)               { RUN(verifier_bounds); }
 void test_verifier_bounds_deduction(void)     { RUN(verifier_bounds_deduction); }
 void test_verifier_bounds_deduction_non_const(void)     { RUN(verifier_bounds_deduction_non_const); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_bitfield_write.c b/tools/testing/selftests/bpf/progs/verifier_bitfield_write.c
new file mode 100644
index 000000000000..623f130a3198
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
+__success
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
+__success
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
+__success
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
+__success
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


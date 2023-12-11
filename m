Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D6380DB6C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345044AbjLKUUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344991AbjLKUUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:20:33 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ED6E3;
        Mon, 11 Dec 2023 12:20:39 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id CC69C580941;
        Mon, 11 Dec 2023 15:20:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 11 Dec 2023 15:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1702326037; x=
        1702333237; bh=Z+7Afm7t3HxDVtoQyXLZsXvB2QVInlcd4KmkW3EtfRk=; b=R
        aRLt9SVSyKuuDe22zYwMyaVAE8/6rnKefPjC2wNw1goQIuwQ1Vw05Bbj2RamKY25
        uXsFyUz60bnpgmJ0CHih/h6ydoKK29oZaj4UXxozABRc9lkTOlBo4Wzo8cAOe7bD
        IkYKurm8uYAqnD0xXGFgZjRXNQM0vG4MM43ZNen8hE2/q8/61zpWywU3ETcCwmaf
        OXlNH330vVlGJLiXVIWN+tKU2Cl5jvYXE9HDyRImOO8pqpJgX0DwSJuun8pTBPYM
        1eqfBmm/X46cbdwuNmlKpS2niX04HsLcOKkPz2xyFnvcLJMh6dUbH9pCNge+nUJJ
        ziQl7sn+BfI9ej4T9q3Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702326037; x=
        1702333237; bh=Z+7Afm7t3HxDVtoQyXLZsXvB2QVInlcd4KmkW3EtfRk=; b=W
        STchHOMpPccC2UrdnlLgaMC6ATGPAGtAvN3fcGijk+M5jNSEsGzo35xbR2WNmoQI
        qpJbKAbV3oTDC4OeY1P809RDlYkYc5sHoBAxUyVXg+eK2Y/wRbwTCEczaBPahzFo
        Vi3lK3EL+ixFnWr/vNuwDqorTbzR+OWUunuubnFuuCPer2amY9BWkGxDGwLg2QVU
        aLTHkB5xB3caMnQFAn6ZGueAn3FgdRcBjyYwUaN4NExJKNeXqAqltjkFkKAH9f2I
        HaKH9DYEkC+P3A8vZZ5nWn74lZd6N0Xy8hWgvyetTMVacciDO1UZ4fbilVnddtTc
        w7aa4H1yx6LHDE3TikWHw==
X-ME-Sender: <xms:FW93ZRMfAXxieoocSn6IU9TurPXVnRy0N5s8OWLkZu3w-QlyXArBUg>
    <xme:FW93ZT9p3zUE3Fukmvf4Myh3TPi5zqaaTbao5_C1nvXuYDq_6Eu60JuVbkY-vUWAb
    1IaaAJwTWr9iN8rgw>
X-ME-Received: <xmr:FW93ZQTCIkiFdL54_r5CIwxiqwApfFa0hMdYr2PHOtD9VjjOw-hMSRuSMrz7AQoFXsCzupU54kY1W7b_l6zsy5gM68QS0jpuBj0lslb3ExQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:FW93Zdufr4khrf19SFrMpJhs1oWAlGSTOv33NpHkXtQXSEWPTVfkiw>
    <xmx:FW93ZZeWje3zb1T9sODRyKZuGijKllq92KEVhOysBDCmKz2rpRF_Gw>
    <xmx:FW93ZZ1kr6BeUeWt2dgrrA8k_VjNIla-5Kapc5JObQnrKKU8BJ4vpg>
    <xmx:FW93ZRFXv9fZcu78l3SJCyhYIIdETj0FEsgro6qz4z__FSijprS4xQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 15:20:35 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     ast@kernel.org, andrii@kernel.org, shuah@kernel.org,
        daniel@iogearbox.net, steffen.klassert@secunet.com,
        antony.antony@secunet.com, alexei.starovoitov@gmail.com,
        yonghong.song@linux.dev, eddyz87@gmail.com, eyal.birger@gmail.com
Cc:     mykolal@fb.com, martin.lau@linux.dev, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@linux-ipsec.org, netdev@vger.kernel.org
Subject: [PATCH bpf-next v5 4/9] bpf: selftests: test_loader: Support __btf_path() annotation
Date:   Mon, 11 Dec 2023 13:20:08 -0700
Message-ID: <660ea7f2fdbdd5103bc1af87c9fc931f05327926.1702325874.git.dxu@dxuuu.xyz>
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

This commit adds support for per-prog btf_custom_path. This is necessary
for testing CO-RE relocations on non-vmlinux types using test_loader
infrastructure.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 1 +
 tools/testing/selftests/bpf/test_loader.c    | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 799fff4995d8..2fd59970c43a 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -71,6 +71,7 @@
 #define __retval_unpriv(val)	__attribute__((btf_decl_tag("comment:test_retval_unpriv="#val)))
 #define __auxiliary		__attribute__((btf_decl_tag("comment:test_auxiliary")))
 #define __auxiliary_unpriv	__attribute__((btf_decl_tag("comment:test_auxiliary_unpriv")))
+#define __btf_path(path)	__attribute__((btf_decl_tag("comment:test_btf_path=" path)))
 
 /* Convenience macro for use with 'asm volatile' blocks */
 #define __naked __attribute__((naked))
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index a350ecdfba4a..74ceb7877ae2 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -27,6 +27,7 @@
 #define TEST_TAG_RETVAL_PFX_UNPRIV "comment:test_retval_unpriv="
 #define TEST_TAG_AUXILIARY "comment:test_auxiliary"
 #define TEST_TAG_AUXILIARY_UNPRIV "comment:test_auxiliary_unpriv"
+#define TEST_BTF_PATH "comment:test_btf_path="
 
 /* Warning: duplicated in bpf_misc.h */
 #define POINTER_VALUE	0xcafe4all
@@ -58,6 +59,7 @@ struct test_spec {
 	const char *prog_name;
 	struct test_subspec priv;
 	struct test_subspec unpriv;
+	const char *btf_custom_path;
 	int log_level;
 	int prog_flags;
 	int mode_mask;
@@ -288,6 +290,8 @@ static int parse_test_spec(struct test_loader *tester,
 					goto cleanup;
 				update_flags(&spec->prog_flags, flags, clear);
 			}
+		} else if (str_has_pfx(s, TEST_BTF_PATH)) {
+			spec->btf_custom_path = s + sizeof(TEST_BTF_PATH) - 1;
 		}
 	}
 
@@ -578,6 +582,9 @@ void run_subtest(struct test_loader *tester,
 		}
 	}
 
+	/* Implicitly reset to NULL if next test case doesn't specify */
+	open_opts->btf_custom_path = spec->btf_custom_path;
+
 	tobj = bpf_object__open_mem(obj_bytes, obj_byte_cnt, open_opts);
 	if (!ASSERT_OK_PTR(tobj, "obj_open_mem")) /* shouldn't happen */
 		goto subtest_cleanup;
-- 
2.42.1


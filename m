Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02303804086
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346139AbjLDU5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbjLDU5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:57:06 -0500
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AEED65;
        Mon,  4 Dec 2023 12:57:02 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 23A39580A13;
        Mon,  4 Dec 2023 15:57:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 04 Dec 2023 15:57:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1701723422; x=
        1701730622; bh=Z+7Afm7t3HxDVtoQyXLZsXvB2QVInlcd4KmkW3EtfRk=; b=B
        HnJ+fx+0FdYXhJNFTepTS8dgk8/FV5xe82ChHPFkZM0vgsOl7kqB/LJGQNwKSEgQ
        gWnEcUfwsJWB3q7ylWh9bqsyiw0G0azF415Y70zo/7h8fZfhQUCSNjuJroHHjdDY
        yjqiDbvYRQ6ojKe0QH48phnhnqjYcDunfnyr1VK+mraWa8JB6s6dE8F9NrgC/Oqx
        LZIiP8x8f6tnuHqAEMtpn6K6z1/UiVw7hxr0Mx0Maf0kUXIK00y3unwl5ptm/xmV
        zmrmpf7YNAwqrPu50dOAZ07Uui10fF6SzqG7z/xDSIELv7Fvmu4p7vLwzJ8XpqN8
        eIltoRmlbaXEdBRteIdvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701723422; x=
        1701730622; bh=Z+7Afm7t3HxDVtoQyXLZsXvB2QVInlcd4KmkW3EtfRk=; b=X
        8zDzbqlktm9phtZLiEx7t2HmUnqILJP9B7xAZglUWUssyZU6OyfOHH+K9FOUdvuZ
        VI6kxzuXEX52AuAmUgdKD7XK8QVsqJYqvxORM+k130h8dUuNckTF5R6iKwc0sC84
        WOMu0/skQER+Gm7d55kc2/6TxgYwztXxlS66LoXAVXTkf/hHERS5eHQJKwEakNgj
        OB/eNCzZMzLyroQEKXeBL1nzJIdbj09iSqjZxNKcE9bVIx7L7SRe+JVhjKB0C2nc
        rID7r3Y9U7uEat3dQ4jY2pnlUHFh39Ry55RCd3y+SGIf4/TObNsrGB54Ju55Hf5Q
        KOeF6jyYw53IuHvKg4E7g==
X-ME-Sender: <xms:HT1uZdVJvEyDOH-DMGy8mm5gPDvvB4-7dj8jlJsoiWNp7Tfa0dy2hg>
    <xme:HT1uZdnp0uT1dpXnlWtMcY90ulNz_wiqjxYvhAFcorio2cWHG2vGu_w1e-mmpmih3
    5pnvGCEn0gnQNhgAw>
X-ME-Received: <xmr:HT1uZZbfUqWJSZxJ549WiolBIBcLcCLY1M6VtmqOQhT_3LnDvtuEp7AbQMGuGl1p3COxyhrsly2LuXwgKlFBduxIllcj4V-wnmGCEVQxis0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:Hj1uZQVjVVATGaV__TN5rrE-wuvmSnd3mN0AFRuEyj9ocaglznARRA>
    <xmx:Hj1uZXlrMcare_8s4AH0ewFi7cHYK32pqfOAPaCpVkiqtpizxuSUcw>
    <xmx:Hj1uZdcUDEwpQVuVLFFv9x66tsKO_p-JS-T6aC4dSrob-8Dn1FlKag>
    <xmx:Hj1uZXH7yx2nbabPmhKY6tkhNQentTtl0nPcBdO2BnzwvKd3WxVRNA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Dec 2023 15:57:00 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     daniel@iogearbox.net, shuah@kernel.org, andrii@kernel.org,
        ast@kernel.org, steffen.klassert@secunet.com,
        antony.antony@secunet.com, alexei.starovoitov@gmail.com,
        yonghong.song@linux.dev, eddyz87@gmail.com
Cc:     mykolal@fb.com, martin.lau@linux.dev, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@linux-ipsec.org, netdev@vger.kernel.org
Subject: [PATCH bpf-next v4 05/10] bpf: selftests: test_loader: Support __btf_path() annotation
Date:   Mon,  4 Dec 2023 13:56:25 -0700
Message-ID: <16ffaa4173791228ed2274c1d06c0eaf159f5d9c.1701722991.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1701722991.git.dxu@dxuuu.xyz>
References: <cover.1701722991.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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


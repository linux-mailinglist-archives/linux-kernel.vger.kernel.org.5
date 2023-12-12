Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9BF80F5D1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376685AbjLLSxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjLLSxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:53:37 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6868E98
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:53:43 -0800 (PST)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E44043F183
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1702407221;
        bh=oy3yei2rg4WxuRtRv9nehp5lTXGEBe4zj8pVFHRLyyM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=vBd3EWs1CmWh4ZXGDH2SdR+81/tP5s/2lFeeXPc8DZUbCrM3lLpzXLe8AtlZobjgU
         Xc4L8KPfVI/iglzRS5YmTe9kleN0VeVMnDfdC+hDpL1luZwSsglg1Gar3M+cYr8fV/
         OyWTEmM6Uv2Vi6+1mQBwJoEQl1cpTLhUw6oVPdHY4fdSuObkSy+voXprQoxFW7RP6Y
         6Kr9A5QQr+lhsUfzdos3xwi+Ustt/jBvXGRnIVL5GoxQhpwETGmNJl6YMx2ZXo1GhI
         S/Jh5Q+7eQl8/AFiOVDu6Nwn3rHNb29eg83ATG7KERHAB7N+6GwjOZrLT91PxqYQwy
         k3GXcLBy8RYRw==
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-333501e22caso4896876f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:53:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702407221; x=1703012021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oy3yei2rg4WxuRtRv9nehp5lTXGEBe4zj8pVFHRLyyM=;
        b=i7MC7pw3KZHw/p4QBFmevSnokHKYmz4ZTc++gfiMvVM/0pcgkmBNaUhuT/OM3YyfT4
         tqXGfrZ71o7+mLFOeUAQjw7Ur85kg7wxgtXgGKlrmjxGwJhkOXSDeGNm5Aux+nikMEIy
         ++lCd4yRxvuVbvSY5FXFiFdfWmAWSZCfAwZ9svOuZBE4+7f9TArRx3K+0PhehVYA3TCz
         Gq3fFGHjshiZ+y5woDTLfJdg7qW+AqiRSuAjA0GfvisnVAlWUH5lgAdk1QjhMcgsjjSS
         92AYO3pqMZ4qIlkMFBjqKQHWYHepA04/qffh77qlP75b16ADiXZUnDYiCA0dRJs4AxtT
         CMJA==
X-Gm-Message-State: AOJu0Yxt/FkAWeeEcGtrsK9oFATs9T4cckfdVfMLZLZ1QyuzAnSNVxtl
        TkwBnEcat122/T8JRzlXWC1nqL8WLSpNr0/h5uMsuQufi4q8JUbZbmMm+trRxu4/8GnxpYhYLyw
        TNyGlZWMLrD+OnxGHZ15TauMsko9DKNkMruFpYbjUw8QLaer6DQ==
X-Received: by 2002:a05:600c:1ca9:b0:408:3696:3d51 with SMTP id k41-20020a05600c1ca900b0040836963d51mr3050485wms.4.1702407221000;
        Tue, 12 Dec 2023 10:53:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEY8RaVRxGkcwHbCxP7MnxLEzZhzdesazz+/W/UPY/1JFlhJvYYb81ZQG7QD6lP8CGFiYuj/A==
X-Received: by 2002:a05:600c:1ca9:b0:408:3696:3d51 with SMTP id k41-20020a05600c1ca900b0040836963d51mr3050477wms.4.1702407220640;
        Tue, 12 Dec 2023 10:53:40 -0800 (PST)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id w7-20020a05600c474700b0040c41846919sm11369638wmo.41.2023.12.12.10.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 10:53:40 -0800 (PST)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] objtool: Make objtool check actually fatal upon fatal errors
Date:   Tue, 12 Dec 2023 18:53:38 +0000
Message-Id: <20231212185339.1562967-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently function calls within check() are sensitive to fatal errors
(negative return codes) and abort execution prematurely. However, in
all such cases the check() function still returns 0, and thus
resulting in a successful kernel build.

The only correct code paths were the ones that escpae the control flow
with `return ret`.

Make the check() function return `ret` status code, and make all
negative return codes goto that instruction. This makes fatal errors
(not warnings) from various function calls actually fail the
build. E.g. if create_retpoline_sites_sections() fails to create elf
section pair retpoline_sites the tool now exits with an error code.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 tools/objtool/check.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e94756e09c..9146177fc9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4669,166 +4669,168 @@ static void free_insns(struct objtool_file *file)
 int check(struct objtool_file *file)
 {
 	int ret, warnings = 0;
 
 	arch_initial_func_cfi_state(&initial_func_cfi);
 	init_cfi_state(&init_cfi);
 	init_cfi_state(&func_cfi);
 	set_func_state(&func_cfi);
 	init_cfi_state(&force_undefined_cfi);
 	force_undefined_cfi.force_undefined = true;
 
-	if (!cfi_hash_alloc(1UL << (file->elf->symbol_bits - 3)))
+	if (!cfi_hash_alloc(1UL << (file->elf->symbol_bits - 3))) {
+		ret = -1;
 		goto out;
+	}
 
 	cfi_hash_add(&init_cfi);
 	cfi_hash_add(&func_cfi);
 
 	ret = decode_sections(file);
 	if (ret < 0)
 		goto out;
 
 	warnings += ret;
 
 	if (!nr_insns)
 		goto out;
 
 	if (opts.retpoline) {
 		ret = validate_retpoline(file);
 		if (ret < 0)
-			return ret;
+			goto out;
 		warnings += ret;
 	}
 
 	if (opts.stackval || opts.orc || opts.uaccess) {
 		ret = validate_functions(file);
 		if (ret < 0)
 			goto out;
 		warnings += ret;
 
 		ret = validate_unwind_hints(file, NULL);
 		if (ret < 0)
 			goto out;
 		warnings += ret;
 
 		if (!warnings) {
 			ret = validate_reachable_instructions(file);
 			if (ret < 0)
 				goto out;
 			warnings += ret;
 		}
 
 	} else if (opts.noinstr) {
 		ret = validate_noinstr_sections(file);
 		if (ret < 0)
 			goto out;
 		warnings += ret;
 	}
 
 	if (opts.unret) {
 		/*
 		 * Must be after validate_branch() and friends, it plays
 		 * further games with insn->visited.
 		 */
 		ret = validate_unrets(file);
 		if (ret < 0)
-			return ret;
+			goto out;
 		warnings += ret;
 	}
 
 	if (opts.ibt) {
 		ret = validate_ibt(file);
 		if (ret < 0)
 			goto out;
 		warnings += ret;
 	}
 
 	if (opts.sls) {
 		ret = validate_sls(file);
 		if (ret < 0)
 			goto out;
 		warnings += ret;
 	}
 
 	if (opts.static_call) {
 		ret = create_static_call_sections(file);
 		if (ret < 0)
 			goto out;
 		warnings += ret;
 	}
 
 	if (opts.retpoline) {
 		ret = create_retpoline_sites_sections(file);
 		if (ret < 0)
 			goto out;
 		warnings += ret;
 	}
 
 	if (opts.cfi) {
 		ret = create_cfi_sections(file);
 		if (ret < 0)
 			goto out;
 		warnings += ret;
 	}
 
 	if (opts.rethunk) {
 		ret = create_return_sites_sections(file);
 		if (ret < 0)
 			goto out;
 		warnings += ret;
 
 		if (opts.hack_skylake) {
 			ret = create_direct_call_sections(file);
 			if (ret < 0)
 				goto out;
 			warnings += ret;
 		}
 	}
 
 	if (opts.mcount) {
 		ret = create_mcount_loc_sections(file);
 		if (ret < 0)
 			goto out;
 		warnings += ret;
 	}
 
 	if (opts.prefix) {
 		ret = add_prefix_symbols(file);
 		if (ret < 0)
-			return ret;
+			goto out;
 		warnings += ret;
 	}
 
 	if (opts.ibt) {
 		ret = create_ibt_endbr_seal_sections(file);
 		if (ret < 0)
 			goto out;
 		warnings += ret;
 	}
 
 	if (opts.orc && nr_insns) {
 		ret = orc_create(file);
 		if (ret < 0)
 			goto out;
 		warnings += ret;
 	}
 
 	free_insns(file);
 
 	if (opts.verbose)
 		disas_warned_funcs(file);
 
 	if (opts.stats) {
 		printf("nr_insns_visited: %ld\n", nr_insns_visited);
 		printf("nr_cfi: %ld\n", nr_cfi);
 		printf("nr_cfi_reused: %ld\n", nr_cfi_reused);
 		printf("nr_cfi_cache: %ld\n", nr_cfi_cache);
 	}
 
 out:
 	/*
 	 *  For now, don't fail the kernel build on fatal warnings.  These
 	 *  errors are still fairly common due to the growing matrix of
 	 *  supported toolchains and their recent pace of change.
 	 */
-	return 0;
+	return ret;
 }
-- 
2.34.1


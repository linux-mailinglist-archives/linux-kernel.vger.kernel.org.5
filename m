Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6560781132A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbjLMNnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbjLMNnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:43:11 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB31DC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:43:17 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 692393F184
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 13:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1702474995;
        bh=zGwI2oNuAcGXzDM0lEo9IfpuoUY3xfRn5ssNrL4TUxo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=dEtDjiUGcGq96oEv9U+z5thFBu1Fe0Wr5GHq6v5URzl2Fq9EdmKynHk5K90GKLMcG
         WP21Zmvy98Wg30Il666ABynOhAypOCP4O4L2Z0Jj6L2vOkeMkDE8Co95nUgz1V+X9m
         RdnVWHeHAvebcFqX17AtWLOxUy9AiifFmNFa4qiOlvMQNftOxNw51wbeCq9aPCII9g
         r30Odrg8Ru0mTb6W7nUm15bpvnWISSrB8z1yo+X/mDap1byKwdeKiYw//Yd5fe/MwC
         qhfRqGIdAizyvhX8oSSRsFeNOk9KxqTJZa+/aFx7SaKNXiesHP3wc2gJ+GEFbgjd5F
         aQrxJOE0cio+A==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40c421f2686so25261285e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:43:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474995; x=1703079795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGwI2oNuAcGXzDM0lEo9IfpuoUY3xfRn5ssNrL4TUxo=;
        b=lPvHcOBdkbxnxxk5eRKdazdrL6yRekVKxZPUppsbO9WqKkPPw6zNduGcmuLSBdIVn8
         McPY4f95VQCIflWOI60UTAXT3CUCNAvITWUcBBSfV7jIMw61MmYGp35fRO0nmUktycHu
         8BgK8K6pKPcB+ro/6V2+cT5mthIKwH9u9+imnQiC3bui4WNyIOX5uP00vmO5Vmw925r8
         aT7QDWm9IeGrzHaIF0/KfWd3OcIun57JNBMOlm/FAsxfOhCb6vg0AHasmIeUOuL455fS
         NWPtzecHkQRQ98EgHwBMvwTYRuds3C8gtFtWnTuCJSf2AKnvPs+I0SR4oYPWRgkWdCyT
         N2+A==
X-Gm-Message-State: AOJu0YxULII1Gcvhj3aQ4k6LtNDnDpWv2hvPWR/j81MZ3Ow6KVPxbI7H
        B1A4ymxQKyJl3L2pQ3K+VV54uZcJPVRpR7LQW8e2DauEImkn3hiSL9LDFmd9IDzbzmddqy/Z/Sg
        F7ZTqwUMluxAUk1Lz96d+RWpRtiB7ZiuwAxkBusASxQ==
X-Received: by 2002:a05:600c:3146:b0:40c:3e8b:8672 with SMTP id h6-20020a05600c314600b0040c3e8b8672mr1709085wmo.132.1702474995049;
        Wed, 13 Dec 2023 05:43:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsVB3aey4dRXrduEcUoMRr+37le60sab3mGJ5283xEgXOneCJ3xOEDRLqSRV8hwb93oAUIAA==
X-Received: by 2002:a05:600c:3146:b0:40c:3e8b:8672 with SMTP id h6-20020a05600c314600b0040c3e8b8672mr1709078wmo.132.1702474994694;
        Wed, 13 Dec 2023 05:43:14 -0800 (PST)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b0040c58e410a3sm3236396wmq.14.2023.12.13.05.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 05:43:14 -0800 (PST)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     jpoimboe@kernel.org, peterz@infradead.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] objtool: Make objtool check actually fatal upon fatal errors
Date:   Wed, 13 Dec 2023 13:43:00 +0000
Message-Id: <20231213134303.2302285-2-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213134303.2302285-1-dimitri.ledkov@canonical.com>
References: <20231213134303.2302285-1-dimitri.ledkov@canonical.com>
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
 tools/objtool/check.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e94756e09c..15df4afae2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4669,166 +4669,163 @@ static void free_insns(struct objtool_file *file)
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
-	/*
-	 *  For now, don't fail the kernel build on fatal warnings.  These
-	 *  errors are still fairly common due to the growing matrix of
-	 *  supported toolchains and their recent pace of change.
-	 */
-	return 0;
+	return ret < 0 ? ret : 0;
 }
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D076B7A7179
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 06:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjITEPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 00:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjITEPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 00:15:00 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DF7CA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 21:14:54 -0700 (PDT)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 074993F680
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695183293;
        bh=9EvSlPl6agaWTAcgjdEpRt93clJ5AzKIreNbbX3/T8E=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=FVYimQUtwWwCJkoAr+B2sk0kH7RdJx7MtsS55o3ztMmm2LfxTyANAyRyi75q3kLNB
         DcgZ7uFBfzVA29xOAbjRWMRU/+jzJYyvTb3c9FipSRiRnwaOPBGMqQpexjMyOXvd0W
         P+ujbkiRms/vGywVkzH0swUv4URzvmaUeuNj6PmlwV/FZJ8IYYtxPj8Q1ml5V7LGKZ
         OqkG2xZ4P/NYG0o+ZYnyjrjyAYA0KXMS8ChtBd0AF29oB2ajDRY2VLbJZvPspL+19b
         MvOw4mBsHiVrtXnb3NU1O7M1vDUSj8kufc+qbHoZn6dB4YEe7VzY7mM5pBbVwskd3d
         xkrjBjDGYBdiQ==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2764e63b6abso3033008a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 21:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695183289; x=1695788089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9EvSlPl6agaWTAcgjdEpRt93clJ5AzKIreNbbX3/T8E=;
        b=Mcv8IsD4I3cYGszUlGbzb97qXZQgZRFZq96bjw2ZXdr5RkrSqLzmbtS25QzsgWgwg0
         TLpCF1QwKSpt4bMIcqxhzcu7dZpzxKCLwN1fXTsf9HI0fy2RLaKO4jsG/A40XGbpovm+
         xerTl++VGRahbpGaDMxiAKZsiytDWJt2nPFGNHR9tnSm1iDfNEcwanYNfGBGbccMUSBX
         iUCoqVk2uUbYPlF4v6dyvQ1Xl4mHGRVOn92I2q5qpiyOVbEguBAKeTV3uiNgXsa3KWap
         Iv0/nxyrjUs1QHK9yzn6crxdA+UR+0lELU38B/u0/uu69OUPeWrfBu5yWMhib3Q68Jbf
         cNXQ==
X-Gm-Message-State: AOJu0YxP6d2duEXJm8SYzfWytUg53/TQxYIrNIOMADKsmD3tQTXPL+ii
        Qb9KqxqBLAHxsYSb5fn/DZx7gEo3xEOurhzm+4Vi3EYjlwdP0pHGqYlTuQUuuHc/rRsY67ChYi0
        dOvtyZy88rtyj3QePbKw1XR7uN1h953K0UFVn3hMllQ==
X-Received: by 2002:a17:90a:8d0a:b0:267:fb26:32bd with SMTP id c10-20020a17090a8d0a00b00267fb2632bdmr1598821pjo.7.1695183289302;
        Tue, 19 Sep 2023 21:14:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtMWX1vRkRmkdHXVrH//u7RSJ6kA4XAgXlQzAmWikvv3pQ4DLvVIvlXkWSt3seiMrND4ecHA==
X-Received: by 2002:a17:90a:8d0a:b0:267:fb26:32bd with SMTP id c10-20020a17090a8d0a00b00267fb2632bdmr1598811pjo.7.1695183288894;
        Tue, 19 Sep 2023 21:14:48 -0700 (PDT)
Received: from canonical.com (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
        by smtp.gmail.com with ESMTPSA id t24-20020a17090ad51800b0026596b8f33asm360059pju.40.2023.09.19.21.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 21:14:47 -0700 (PDT)
From:   Koba Ko <koba.ko@canonical.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH] x86/arch: Fix access invalid member when disable CONFIG_UNWINDER_ORC
Date:   Wed, 20 Sep 2023 12:14:46 +0800
Message-Id: <20230920041446.300415-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_UNWINDER_DRAME_POINTER doesn't have bp and sp members.
this leads the compilation error when only enable CONFIG_UNWINDER_DRAME_POINTER.

arch/x86/net/bpf_jit_comp.c:3022:72: error: 'struct unwind_state' has no member named
'sp'; did you mean 'bp'?
3022 | if (!addr || !consume_fn(cookie, (u64)addr, (u64)state.sp, (u64)state.bp))

Fixes: f18b03fabaa9 ("bpf: Implement BPF exceptions")
Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
 arch/x86/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 84005f2114e09..db2b09949d407 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3012,7 +3012,7 @@ bool bpf_jit_supports_exceptions(void)
 
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie)
 {
-#if defined(CONFIG_UNWINDER_ORC) || defined(CONFIG_UNWINDER_FRAME_POINTER)
+#if defined(CONFIG_UNWINDER_ORC)
 	struct unwind_state state;
 	unsigned long addr;
 
-- 
2.34.1


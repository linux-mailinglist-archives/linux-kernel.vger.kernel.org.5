Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155227D5404
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343623AbjJXO2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbjJXO2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:28:42 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661D2111
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:28:40 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-991c786369cso675312066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698157719; x=1698762519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QgspBun1+2eUbkCbF+tTe8as0uNaaylH89IwTYG9YWY=;
        b=Hff+xy0y034vF74B1B1Vb+9PTtJkund58SL+9FabknU5TDbAzMx5ulew/f3Vo+Wae+
         w139P3alvu6o3xNlsaytMMp2II72L4zUG2XWoOVQS4Lu7zvCS178Hn9QCVwAL7GoHdEp
         z8z/RVm1iezDr4V79jY9eQIKajJSKsyzvYZNpYYtPiR8gV0XOWEcJunDoDSNvsjVNpwb
         /SwowLQO98Ffn4s0nz6zgzccxgzIv/0eF3WBfYJN+pIoa+U4hnH+GLrdgNdfZSLEol5k
         AsARfleI9IB6DqIdbwC9o0soKrdRvi8TgwZUAInRO8eJp4RrksdsAJkq7twerco4TZdI
         HEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698157719; x=1698762519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgspBun1+2eUbkCbF+tTe8as0uNaaylH89IwTYG9YWY=;
        b=GoeL+EGdlGDA4RwdzQXJeO18wmaJquWY1b22OZNep0UDM3XTUax4UPr+lDtCZAQLV8
         qchfXl5x7uSDi/DUy5vnpsejySfCD4qoV10Q7VpptUAWcyPmGyjpHlh94Qdexe6NypCu
         3woLTzvpLY4CZEAYz5DOlPfwUzG2F5cngN7Amftvcneesn5SfEgt9h74JW8gq91P/Q8D
         IpIkzMZESsJBddeX91qvxFAw2gVfu+HTZyXavouj3Htva6SmM9Qb6S/Zp4LfFnl0xwDT
         K9ob8uyI2XLWcYw/HTrIgjH828bfzm2JZ7+42obNfkDxI4kYdp2IUYzuHaUcN5Tlg1oy
         AySw==
X-Gm-Message-State: AOJu0Yx0M6nS1W+2nIH+NQvQb5rQk4xunRfIow1nO+5h3v2OELoG/rUj
        fRlN+Yns1mT0WESChgGQNcM=
X-Google-Smtp-Source: AGHT+IEyaxcPf8wdD4yUbSwphTA+tm7lqytrSUzgycOK6QN6zJqMbu0VOnu7U6J9j9UtqJHALHpPQQ==
X-Received: by 2002:a17:907:360d:b0:9ae:406c:3420 with SMTP id bk13-20020a170907360d00b009ae406c3420mr9839238ejc.30.1698157718632;
        Tue, 24 Oct 2023 07:28:38 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id j20-20020a170906051400b009bf7a4d591dsm8284585eja.32.2023.10.24.07.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 07:28:38 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] x86/percpu: Return correct variable from current_top_of_stack()
Date:   Tue, 24 Oct 2023 16:28:14 +0200
Message-ID: <20231024142830.3226-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

current_top_of_stack() should return variable from _seg_gs
qualified named address space when CONFIG_USE_X86_SEG_SUPPORT
is enbled.

Fixes: ed2f752e0e0a ("x86/percpu: Introduce const-qualified const_pcpu_hot to micro-optimize code generation")
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index a807025a4dee..4b130d894cb6 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -534,7 +534,7 @@ static __always_inline unsigned long current_top_of_stack(void)
 	 *  entry trampoline.
 	 */
 	if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
-		return pcpu_hot.top_of_stack;
+		return const_pcpu_hot.top_of_stack;
 
 	return this_cpu_read_stable(pcpu_hot.top_of_stack);
 }
-- 
2.41.0


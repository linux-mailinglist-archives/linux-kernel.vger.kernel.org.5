Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E407D2046
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 00:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjJUWSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 18:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJUWSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 18:18:49 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF32AD
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 15:18:47 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso1428499f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 15:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697926725; x=1698531525; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BeP8FAJB4LBtTMfR08jqyQhrVoE0AYbnRicZ8aW/tbA=;
        b=gD5AlzmA0y+vMtBXY0DHnb2w5i6Ws8BubVX+2HPo//P+4iwpBb0zVvFsJEvPle6XVX
         lA/uAiHu/XFpGskJq0hBaHkvEDTtfPEgx52hDt4U/r/JNc/v7joENtam3lk4nY4SH9l2
         I8LwZ/JVENh59tumEZuEJ6AZbfa6XkDu5JBlhvI9wzugDLpVmyNGbikiSnk5W7mKVlIC
         h+Shi2508BMsuSxjAQx726PAqwwF96Bw4WEVbevi8JYJ06whXgUjypV7UL5zcAlpKJEZ
         J97XXV7Yooe332mZWOb9FNptjBB6CqHtf1dxG4YQ2bpmqhWier6Hfi36cfI7lgzXTuTH
         ZsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697926725; x=1698531525;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BeP8FAJB4LBtTMfR08jqyQhrVoE0AYbnRicZ8aW/tbA=;
        b=E2St6qqbzct1N2rdyKt20R4A74lnwhElIygfRpOn7zyxjqUMOT24MiB9vqy95A349V
         ycObbmDFb2pQ0x7ZZ5qnssQw1kAYI6nC6ZPZZt+MSolifBRhDNhldhj4KWGK1m8R72fg
         6D9vn2RnuJOVa51YrK48OazPmvzmuuW3oYrouixooZXd28oAGWzm7Lt31hkaUPdwYYPx
         RsGeC1Pi/afncUX4rmyM6pYORkKnjnMOa+YpUBXghJ6tjA4yR3TemgeJc2CWZyYNKsMU
         7TYsQo7GomDeAHrNe/eBxsEqQqcXCszjv1Vup2gBp6As6SYHtonak/jzFwrjUf9OgKzS
         fOSQ==
X-Gm-Message-State: AOJu0YxLlqtavmur/I6VjclUAlKZQFgIkW2yEn6JKeBOPbDi5vq/aknz
        NgUQt/FSTAJjqYkxnTKMCA==
X-Google-Smtp-Source: AGHT+IHiMSLkGvJiij/dtWNYTD7+mKUOnqJj/iaaCuZAsSHsT6sQ21KZrodJguYiymwoGdLWY8RTxw==
X-Received: by 2002:a5d:6d44:0:b0:31f:f753:5897 with SMTP id k4-20020a5d6d44000000b0031ff7535897mr3359024wri.59.1697926725347;
        Sat, 21 Oct 2023 15:18:45 -0700 (PDT)
Received: from octux.home ([2a00:23c8:881a:8601:d29:30a8:9a8e:f4a6])
        by smtp.gmail.com with ESMTPSA id a6-20020adfeec6000000b0032da8fb0d05sm4437064wrp.110.2023.10.21.15.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 15:18:45 -0700 (PDT)
Date:   Sat, 21 Oct 2023 23:18:43 +0100
From:   Jules Irenge <jbi.octave@gmail.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        petr.pavlu@suse.com
Subject: [PATCH] x86/kprobes: Remove unnecessary extern keyword
Message-ID: <ZTROQyJ4xp75e0dA@octux.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at arch_unoptimize_kprobes()

warning: function "arch_unoptimize_kprobes"
with external linkage has definition

The reason is the function is already declared in the header file
as extern

Remove unnecessary "extern" keyword

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 arch/x86/kernel/kprobes/opt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 517821b48391..f20ea996abbf 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -526,8 +526,8 @@ void arch_unoptimize_kprobe(struct optimized_kprobe *op)
  * Recover original instructions and breakpoints from relative jumps.
  * Caller must call with locking kprobe_mutex.
  */
-extern void arch_unoptimize_kprobes(struct list_head *oplist,
-				    struct list_head *done_list)
+void arch_unoptimize_kprobes(struct list_head *oplist,
+			     struct list_head *done_list)
 {
 	struct optimized_kprobe *op, *tmp;
 
-- 
2.41.0


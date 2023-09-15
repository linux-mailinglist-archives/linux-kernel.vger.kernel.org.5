Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4317A1B1F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbjIOJqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjIOJqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:46:11 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611794202;
        Fri, 15 Sep 2023 02:45:07 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401ec23be82so20118245e9.0;
        Fri, 15 Sep 2023 02:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694771105; x=1695375905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PcHdcbwkyI2KBO66Ajq1JQVmk6ciemJsAbh2k4h4Zc0=;
        b=N9hYy2uOjSthXWglg4pTfeUTbG+jCKxp8keTbwFLx7m3nKI7FBD6un6c0oMU2fOQWU
         XEKP3koUDqkoNY6Cc0YpRP/ahWpNMb1LE1riolUoqQ2FWlva9iTMnYljEDWOMRIlqW2Z
         sktGkuLC0e1PkzUbfVu9OMO4kT81Hckefpj3S8zeNYAzp3735VMw5xqEvyF935gEGfCT
         HI3mb9sgFD0mJBBdE74BJvzhWJMo7mSQG16lVFGs/EVRC8AX+Zra8P0VNQT4FaBKn2sX
         Jzck3FOFGwJL2flW4c4Uc8hMCmGTgAoyp0bXrPBD4iVkWYdPx3Sid6E6WIATBBXTXpr2
         dRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694771105; x=1695375905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcHdcbwkyI2KBO66Ajq1JQVmk6ciemJsAbh2k4h4Zc0=;
        b=Ql4NU+qP9Rz1df9Q5zcNI41DIki+eEiWhoGLXPHtFfXcHLAGkJ604TmzrEBPyUsGi4
         LLWW+mz3fZ9Fa3vFkfs2FTok7ySpPksZOe1R0HfdMWnhnur6+IG8f6srwBh6rCl4/WbV
         rUrQcbTcYDINBGhR3s7rRzuD7TZL3QZa/L1lYNAWIQVyFZuCUysmRe6/NVZhhzCgB5/C
         Qe0NMG5ETKG2GwX5KT4GkBg3EKM25aJvOiicnkPvlv/Ynfz6Vo0Ggrew6lgkmZjRUcjA
         j1nr99WD2h7KWVLWq1YPfkgHeADPko0aIf+vhsRpyi2yHGe14JA/UhoLPU9gpuW+yXUU
         5S7w==
X-Gm-Message-State: AOJu0YyAx6wDBs/NhkKIFARhYblCC3Dv7yCujL+Bkh9MYoAPi73BfAqc
        9zkXIiHe1RoVsx6g85bxTYv7OTrHXAE=
X-Google-Smtp-Source: AGHT+IHcAxY3KBswu7vLyAhTnyF5CMfsR313J8qut93P5wn/eA3roirSWTQYJC2OZs/RmjPjholv9w==
X-Received: by 2002:a5d:604e:0:b0:31f:9501:fc0c with SMTP id j14-20020a5d604e000000b0031f9501fc0cmr826673wrt.45.1694771104913;
        Fri, 15 Sep 2023 02:45:04 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id p6-20020a7bcc86000000b003fbdbd0a7desm6954127wma.27.2023.09.15.02.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:45:04 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 15 Sep 2023 11:45:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip: core/urgent] panic: Reenable preemption in WARN slowpath
Message-ID: <ZQQnnjzxbTwpn61F@gmail.com>
References: <3ec48fde01e4ee6505f77908ba351bad200ae3d1.1694763684.git.lukas@wunner.de>
 <169477058360.27769.17772363826818333894.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169477058360.27769.17772363826818333894.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* tip-bot2 for Lukas Wunner <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the core/urgent branch of tip:
> 
> Commit-ID:     cccd32816506cbac3a4c65d9dff51b3125ef1a03
> Gitweb:        https://git.kernel.org/tip/cccd32816506cbac3a4c65d9dff51b3125ef1a03
> Author:        Lukas Wunner <lukas@wunner.de>
> AuthorDate:    Fri, 15 Sep 2023 09:55:39 +02:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Fri, 15 Sep 2023 11:28:08 +02:00
> 
> panic: Reenable preemption in WARN slowpath
> 
> Commit:
> 
>   5a5d7e9badd2 ("cpuidle: lib/bug: Disable rcu_is_watching() during WARN/BUG")
> 
> amended warn_slowpath_fmt() to disable preemption until the WARN splat
> has been emitted.
> 
> However the commit neglected to reenable preemption in the !fmt codepath,
> i.e. when a WARN splat is emitted without additional format string.
> 
> One consequence is that users may see more splats than intended.  E.g. a
> WARN splat emitted in a work item results in at least two extra splats:
> 
>   BUG: workqueue leaked lock or atomic
>   (emitted by process_one_work())
> 
>   BUG: scheduling while atomic
>   (emitted by worker_thread() -> schedule())
> 
> Ironically the point of the commit was to *avoid* extra splats. ;)
> 
> Fix it.

> diff --git a/kernel/panic.c b/kernel/panic.c
> index 07239d4..ffa037f 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -697,6 +697,7 @@ void warn_slowpath_fmt(const char *file, int line, unsigned taint,
>  	if (!fmt) {
>  		__warn(file, line, __builtin_return_address(0), taint,
>  		       NULL, NULL);
> +		warn_rcu_exit(rcu);
>  		return;

BTW., one more thing we might want to consider here is to re-enable 
preemption in warn_rcu_exit() a bit more gently, without forcing a
pending reschedule, ie. preempt_enable_no_resched() or so?

Thanks,

	Ingo

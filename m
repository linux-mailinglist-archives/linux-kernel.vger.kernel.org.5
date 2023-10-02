Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA477B5AB4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjJBS5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjJBS5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:57:39 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5184B3;
        Mon,  2 Oct 2023 11:57:35 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98377c5d53eso10134666b.0;
        Mon, 02 Oct 2023 11:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696273054; x=1696877854; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6otIAIPh5XIg1eGDA9+e/nRojsDL+BWNZmCLTXEiHIA=;
        b=SkY7fLwEi05LRe4HbNrtDKgquzKBUKQVBBSW7ldg4gktqWijMcLhgG0qQGhrkC5Gdx
         hiYkLIWkmZOXsnU/aoXyzHYcOVY15S/rjBU3GeA44TcyrHfsX2cysX/cn0W3WDm3j9gH
         +tvmjzs/3rdMceWT0ufdLlzBumWUYhndYNj1o6syLCq1+9o+gcgKpz20wqZEBZbVMEYW
         aKiF2LldMkiy2h6jdoOAzklnMsFKO62RMTc0sisQpw1QjhIPdbznjFmpNxF8LJx3B535
         M2gsACbAoE1xlFJw/qlgtJUy2/j4KFEGxr0BB1XLawHm1Mi3LohrJb36Nx48gN7FryRy
         p5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696273054; x=1696877854;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6otIAIPh5XIg1eGDA9+e/nRojsDL+BWNZmCLTXEiHIA=;
        b=biPmDiKJZ1IahmGqDAh9v6bMNgNpUYJavD81jhXfV0f3eW6o2lqxwnWjzzBOuH2KEG
         l+9JnfMPj+haYgKzp2/ViNLiNrAa6gTkMTeUv05zMp6d3PGZACvQUomeDJj2u5iRjyPF
         7gEJtLVdUMqbCPvhF75cZ04agsceU1QNkJjdiU+skFxqq/U8CHqHWEbzJgf8CayRLQht
         q7mBm/Hv80z7Gl+BRgdIghcGnPnBuC8BEFXxVPHgCmzn+C2FoRKOGPE3TItVxsqlUZVU
         QoCWY0zYaLRKf9Z8sZnSd2El9XGRb33X8nSmzAhA+hIpNFctoUG05/HpiRxTt0aG48Si
         0TlA==
X-Gm-Message-State: AOJu0YxvgArJxfPiIZdIFucs6+XUD6EP5IeJ29cTJNqZ6klmLtsT6SK4
        ZtOIFeWN8+uVhuOtl6bQvBE=
X-Google-Smtp-Source: AGHT+IHD8FhvaBavsFW1owvzNtaVcgzQZwpKsi3fOHEFxFljS9IxvDlviiFOn1pYk31ZGH6V97T+BQ==
X-Received: by 2002:a17:906:1097:b0:9a9:e393:8bcd with SMTP id u23-20020a170906109700b009a9e3938bcdmr9775679eju.5.1696273053905;
        Mon, 02 Oct 2023 11:57:33 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id z17-20020a1709067e5100b0099bc80d5575sm17245551ejr.200.2023.10.02.11.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 11:57:33 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 2 Oct 2023 20:57:31 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Kir Kolyshkin <kolyshkin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
        musl@lists.openwall.com, linux-api@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] sched/headers: move struct sched_param out of uapi
Message-ID: <ZRsSm7vDnMVEEk/f@gmail.com>
References: <20230808030357.1213829-1-kolyshkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230808030357.1213829-1-kolyshkin@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kir Kolyshkin <kolyshkin@gmail.com> wrote:

> Both glibc and musl define struct sched_param in sched.h, while kernel
> has it in uapi/linux/sched/types.h, making it cumbersome to use
> sched_getattr(2) or sched_setattr(2) from userspace.
> 
> For example, something like this:
> 
> 	#include <sched.h>
> 	#include <linux/sched/types.h>
> 
> 	struct sched_attr sa;
> 
> will result in "error: redefinition of ‘struct sched_param’" (note the
> code doesn't need sched_param at all -- it needs struct sched_attr
> plus some stuff from sched.h).
> 
> The situation is, glibc is not going to provide a wrapper for
> sched_{get,set}attr, thus the need to include linux/sched_types.h
> directly, which leads to the above problem.

Meh, I truly detest this patch, because 'struct sched_param' is very much
part of the syscall ABI signature:

  include/linux/syscalls.h:

  asmlinkage long sys_sched_setparam(pid_t pid,
                                        struct sched_param __user *param);
  asmlinkage long sys_sched_setscheduler(pid_t pid, int policy,
                                        struct sched_param __user *param);
  asmlinkage long sys_sched_getparam(pid_t pid,
                                        struct sched_param __user *param);

... but OTOH let's not pretend that UAPI headers have much justification
to exist unless they are useful & can be utilized in some of the most
common user-space library environments as-is. Namespace collisions happen.

So I'm inclined to apply this workaround, but changed the title and added
the caveat below to the changelog:

    sched/headers: Move 'struct sched_param' out of uapi, to work around glibc/musl breakage

    ...

    Oh, and here is the previous attempt to fix the issue:
    
      https://lore.kernel.org/all/20200528135552.GA87103@google.com/
    
    While I support Linus arguments, the issue is still here
    and needs to be fixed.

    [ mingo: Linus is right, this shouldn't be needed - but on the other
             hand I agree that this header is not really helpful to
             user-space as-is. So let's pretend that
             <uapi/linux/sched/types.h> is only about sched_attr, and
             call this commit a workaround for user-space breakage
             that it in reality is ... Also, remove the Fixes tag. ]
    

So unless Linus objects, I'll apply this to tip:sched/core for a v6.7 merge.

Thanks,

	Ingo

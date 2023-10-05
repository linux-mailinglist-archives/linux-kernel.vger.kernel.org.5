Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4CD7BA914
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjJES30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjJES3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:29:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEEA90
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 11:29:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-538e8eca9c1so2289264a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 11:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696530561; x=1697135361; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aAPCOlOeIttr2KomN5sigTojx4YhzVJLuuUcz+l6ZkU=;
        b=acDwDm0LglTFnHjnlbIJbgJ0F6scUXGHFHaiviFrT/uVt212RQeaIg4iwocUml6FJz
         +u05kzsiy1CDffHPqzVQthCM07W5a4RBD00yW8VhtZmhTV6g8nZ6iMlGZ8BCnr80FubS
         U6anaG0mVAy5lgJe82FcHsW2lbB+InRszpNzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696530561; x=1697135361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aAPCOlOeIttr2KomN5sigTojx4YhzVJLuuUcz+l6ZkU=;
        b=l3A6eWsAMhdCHOBOTmZyYaul0IB1CmE19h4YKWJplaIiEe7rMKAE0KEB2v0xHTAZ70
         tF3EYgzUpj16RKMVlM1DVDU1IW6kT4xMWrrw6pmoKwz1r1957vSXfZqjk8BiOCmA6njI
         9OuyeVDLZP10e8IISgI1WcG+lC5ORHsP0/zLKRIkHu1UH1E48WxxewySqaR3QkGxDDEH
         yu7+8/tIYgdWF+J3xYEEbyAQW65/wDX2oZP54fYoDRmBAHFpOg6Qq2ft/Ui+0LtQF1pI
         dS8wVBqxDpIaT5JxmvsX5oJoQdrv5R1Etsnn3vbIGpEj7SEGPixiDb3clhhO2ucI2pyz
         gsvw==
X-Gm-Message-State: AOJu0YxXfiBN0iJ1dKCurL7VZIEhKTm5TI7X8ZfqXje0eD6/NxZzkQiW
        Ct49ErgH0QZ0LzQuroIbF0M4mnvGiSjXobVdW/rMNA==
X-Google-Smtp-Source: AGHT+IGvbxj+WNkZWLf/Kd9W6U6hVmbkWDw5z1yJ2NMsSKuitlupdyLifNRgtITVxIqe/k/1zqFVvA==
X-Received: by 2002:aa7:cd79:0:b0:522:564d:6de with SMTP id ca25-20020aa7cd79000000b00522564d06demr5706399edb.36.1696530561011;
        Thu, 05 Oct 2023 11:29:21 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id k18-20020a05640212d200b00537fa467ddasm1427614edx.65.2023.10.05.11.29.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 11:29:20 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-533c8f8f91dso2333537a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 11:29:20 -0700 (PDT)
X-Received: by 2002:aa7:c6c4:0:b0:532:ec54:bfff with SMTP id
 b4-20020aa7c6c4000000b00532ec54bfffmr5269546eds.16.1696530559930; Thu, 05 Oct
 2023 11:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230628142129.2468174-1-leitao@debian.org> <ZRV1bIuSXjZ+uPKB@gmail.com>
 <20231005162545.GFZR7jiUNyNkscijUl@fat_crate.local>
In-Reply-To: <20231005162545.GFZR7jiUNyNkscijUl@fat_crate.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Oct 2023 11:29:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTHeQjsqtHcBGvy9TaJQ5uAm5HrCDuOD9v7qA9U1Xr4w@mail.gmail.com>
Message-ID: <CAHk-=wjTHeQjsqtHcBGvy9TaJQ5uAm5HrCDuOD9v7qA9U1Xr4w@mail.gmail.com>
Subject: Re: [PATCH v3] x86/bugs: Add a separate config for each mitigation
To:     Borislav Petkov <bp@alien8.de>
Cc:     Breno Leitao <leitao@debian.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2023 at 09:26, Borislav Petkov <bp@alien8.de> wrote:
>
> I happen to know that Linus wanted those per mitigation, perhaps to be
> able to disable only a subset of them.

Partly for that - some of them are more obnoxious than others, and
cause more changes to code generation.

And partly I want separate configs for just source code readability,
so that we see *which* butt-ugly piece of crap code is for what
reason.

> Linus, what are you thoughts on it, should we continue with a Kconfig
> option per mitigation or should we hide them all behind a single Kconfig
> option - which would be a lot simpler and easier?
>
> Apparently people want to completely remove the mitigations crap for
> some configurations at build time already.

I'd be perfectly happy with a top-level Kconfig question for "enable
mitigations", which could be a config with three values ("all", "none"
and "finegrained").

But see above (particularly the second thing) on why I want us to
still have individual config options for each individual issue. I'm
not convinced a lot of people *care* about the "finegrained" case of
enabling/disabling each mitigation at build time), but I do use it
myself because some of the mitigations end up changing code generation
*so* much that it gets hard to even read the generated assembly (ie
all the retpoline crap looks *horrendous* if what you actually want to
do is check that some change helps code generation and want to
actually look at the resulting *.s files).

Same goes for some perf runs, so this is not *just* "I do a build and
look at the result" - I want to be able to run it too.

So I'll keep the mitigations that don't f*ck up my system too much,
and then because I actually do look at the generated code when I match
up source and result (ie the whole "annotate" thing in perf), things
like retpoline really do end up screwing things up horrendously, in
ways that some of the other mitigations don't.

Maybe I'm odd in the above "disable some mitigations to see the code
generation", but the source-level "readability", and the "this crazy
code is because of this mitigation" is still important, I feel.

I do *not* want to live in a world where we have random crazy code and
just a "#ifdef CONFIG_MITIGATIONS" around it. Those

    IS_ENABLED(CONFIG_RETPOLINE) || IS_ENABLED(CONFIG_SLS))

"complex" conditionals may also be annoying, but dammit, they are
important documentation about why we do those things, and unlike just
comments that will inevitably bit-rot, they have semantics and get
tested.

                  Linus

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE3A790936
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 20:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjIBSfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 14:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjIBSfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 14:35:24 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C010B9B
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 11:35:20 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9338e4695so1425801fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 11:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693679719; x=1694284519; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J/s2SUIeu/g9knbkXuWUdnUEN4bDEYaWZmr3ygikOSs=;
        b=N8tEI/5JyEVvBIfl7YYLCOSLU6Tuh9JaejWEnpruYb+JP+9aWTeSUxCRBBNAGPDs/+
         42E0msCen9GGDKksBZjHXJuPudZOgZiH2MEM+/XWU75AkHG/Yv8QtWOaRUImCBvumj3y
         AkZyKBwLWfXIRNzw4eoWAG5rx1mwmpZJfHPa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693679719; x=1694284519;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/s2SUIeu/g9knbkXuWUdnUEN4bDEYaWZmr3ygikOSs=;
        b=TCXbzmDSSVjlqhRRhlp+6mPIlMcVKVxEXO19eYbDWaBPbgELDtOqoXLKPHTYT1BxJD
         ryJK1VXwKvGgtCJsfAV6aPQ43C1GtNO76Fsg8I7LMD1j98Sy6Z5qw88JVj9Zx686W+45
         x/u8jbUPUBkZIw/xcaVAvQn1FLq1yB/QrBJn7UC27wz65s98xk7reC6TobqB0BP8+Kqp
         Ny+ZhO8+UQZIflVn2/v0rYrVgtGZLfJWMyQZ74IwmuHgEB+MbmZYJNL3ot0lTIrffHhM
         L8g3OWCz4x4vnKIj9O8FAM2BTfPDTggYCwCXmx/0L9b1/Ld9/9q8RIArpp/SoS0h6Twk
         LfyQ==
X-Gm-Message-State: AOJu0YxuqF+z7cwPA7dc+6X+sT5+0fk3SWY8z3o7bTAYiNyCP1Kpykur
        UpVY87wB/JOv8zECJG7liGGGTmNAt0WP8zIZ0NhzGwcw
X-Google-Smtp-Source: AGHT+IEOm8zr6MK02k28uUz43EleVGjBMt+JMXiVFCC7SHK83Q0ndVYpGk/V5NJ61cW/Kshk2ZLF+Q==
X-Received: by 2002:ac2:5bcf:0:b0:4f8:6abe:5249 with SMTP id u15-20020ac25bcf000000b004f86abe5249mr3609659lfn.3.1693679718626;
        Sat, 02 Sep 2023 11:35:18 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id r7-20020a19ac47000000b00500cfb168a3sm1045421lfc.139.2023.09.02.11.35.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 11:35:17 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-500c63c9625so323670e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 11:35:17 -0700 (PDT)
X-Received: by 2002:a05:6512:39d5:b0:4f8:5886:186d with SMTP id
 k21-20020a05651239d500b004f85886186dmr4181820lfu.9.1693679717140; Sat, 02 Sep
 2023 11:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230902101046.bfe957bc51ecd91781200708@kernel.org>
In-Reply-To: <20230902101046.bfe957bc51ecd91781200708@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Sep 2023 11:35:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjpVAW3iRq_bfKnVfs0ZtASh_aT67bQBG11b4W6niYVUw@mail.gmail.com>
Message-ID: <CAHk-=wjpVAW3iRq_bfKnVfs0ZtASh_aT67bQBG11b4W6niYVUw@mail.gmail.com>
Subject: Re: [GIT PULL] bootconfig: Updates for 6.6
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sept 2023 at 18:10, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
>  - fs/proc: Add /proc/raw_cmdline for boot loader arguments.

Honestly, I pulled this, and then I unpulled again.

This seems such a *silly* thing. It's also actively confusing, since
this "raw" file internally in the kernel is called
"boot_command_line", vs the "saved_command_line" of the regular one,
and we also have 'extra_command_line' and 'static_command_line' etc,
so where does this all end?

So the name doesn't even make any sense. It's not "raw" in any sense
of the word. It just happens to be the one that came from the boot
side.

In other words, this smells like a complete hack to me. It makes no
sense, and it should *not* be added to the top-level /proc filesystem
as some kind of fundamental file.

And not only is it a special case that isn't worthy of adding to the
top-level /proc directory, it only has _one_ special case user that
could possibly care.

And this is all self-inflicted pain because the bootconfig code
corrupted the original command line, and decided to expose that
corrupted thing in /proc/cmdline.

So because you made a mess of it originally, you're now making a
*bigger* mess of this all.

No, thank you. The way to fix a mess is not to make it worse. And this
just makes things worse.

I suspect the fix should always have been to make the extra stuff be
somehow clear so that you can parse it. Not make another file that has
the exact same contents for most people.

Maybe a marker of "this is the end of the 'extra command line", the
same way we have that "--" for "this is the end of the stuff the
kernel should parse".

           Linus

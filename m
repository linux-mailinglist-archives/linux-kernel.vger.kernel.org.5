Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522FC7E4A83
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343545AbjKGVXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbjKGVXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:23:19 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960A910D5;
        Tue,  7 Nov 2023 13:23:17 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-58786e23d38so2517966eaf.3;
        Tue, 07 Nov 2023 13:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699392196; x=1699996996; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p9gkRH7EgBc/EFjx3UGdMuaLkXzoxuUFSfx0n9wI7SU=;
        b=IbWNkgrx4rxAfg8/YZoxByXnWrBkZfgyCu4m7L8LrFmg1WtJmXLlrp7QlopQmOZFSG
         otBHyUXlHp2p59d94314iMPnQm9ptrtzpMvGF1gO/wDIL9pCdGrFLeKnLWhT2JDWxg3s
         IhDnn/apUO13piiJID0sA3htcQXYVNSf3xEAzuW7XNod2VSHRKxbpeYo+w6AgFGjt0ph
         ZEnqm9CDk3A2vlGasRuP6oktb9IAvH2jFJlWr7hQQ2D9URbjeyB7l1bqxx+kMHlZ4Prc
         yl46bU5OwjpKB1LOcvJL1B6B2iAHJxCs9hmezIdUvb1/0f0i55OZY3wub5xkwIsoInxW
         RgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699392196; x=1699996996;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9gkRH7EgBc/EFjx3UGdMuaLkXzoxuUFSfx0n9wI7SU=;
        b=cijgYq+5N8Ia+Rz5cv1hj3jpQLV6RBG8KmSD9KGgUzu/uSAi+ol7zAF54BD9OXgEp1
         nodWxd2AMeKuknjI1koCYyhPX2ypg5k2zcrNFDaCH96JRnXMnCcKbF9O1YeMn/DHy5yl
         DoPKBtgwR6JZ7kzcn7S4kfNnm+qYl9XkZ/9GeXVxC0RIfnWN2f7b54ev+CKoBn/roJqZ
         8cpwV7UELKw4BgQge/RrQhCHpLidmLr1runrJ4/G8DseMI+HNw7ltfUp9PkdRBGlvnzV
         lqsjDqqmJYO55L6orEPe9pua54ap/MC40ZIJBgDF5yrF+RbTyzU3DfT2lX8rzZU7Ta7P
         NXlg==
X-Gm-Message-State: AOJu0Yx8wBik4ZIV9HugEwfEbHB35erfhqb41bEITZKr0kJcJGOQdo8T
        ORRgPDnmcpocPIGyzKN/dO7ED3VddQk0yTX/nak=
X-Google-Smtp-Source: AGHT+IH9iCJh9FMWUN07cTY3FUAPQ9BbAXQBdoliTW5WLBxkBSnWDnNDeflruDGHAIyIymjEuK2ubuNKjzaTnXlo4Lw=
X-Received: by 2002:a4a:e1d4:0:b0:581:e819:cac5 with SMTP id
 n20-20020a4ae1d4000000b00581e819cac5mr31277772oot.9.1699392196640; Tue, 07
 Nov 2023 13:23:16 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:158f:0:b0:4f0:1250:dd51 with HTTP; Tue, 7 Nov 2023
 13:23:16 -0800 (PST)
In-Reply-To: <20231107205151.qkwlw7aarjvkyrqs@f>
References: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
 <202311071228.27D22C00@keescook> <20231107205151.qkwlw7aarjvkyrqs@f>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 7 Nov 2023 22:23:16 +0100
Message-ID: <CAGudoHFsqMPmVvaV7BebGkpkw=pSQY8PLdB-1S3W5NpYh6trmA@mail.gmail.com>
Subject: Re: [PATCH] fs/exec.c: Add fast path for ENOENT on PATH search before
 allocating mm
To:     Kees Cook <keescook@chromium.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/23, Mateusz Guzik <mjguzik@gmail.com> wrote:
> On Tue, Nov 07, 2023 at 12:30:37PM -0800, Kees Cook wrote:
>> On Fri, Sep 16, 2022 at 02:41:30PM +0100, Josh Triplett wrote:
>> > Currently, execve allocates an mm and parses argv and envp before
>> > checking if the path exists. However, the common case of a $PATH search
>> > may have several failed calls to exec before a single success. Do a
>> > filename lookup for the purposes of returning ENOENT before doing more
>> > expensive operations.
>> >
>> > This does not create a TOCTTOU race, because this can only happen if
>> > the
>> > file didn't exist at some point during the exec call, and that point is
>> > permitted to be when we did our lookup.
>> >
>> > To measure performance, I ran 2000 fork and execvpe calls with a
>> > seven-element PATH in which the file was found in the seventh directory
>> > (representative of the common case as /usr/bin is the seventh directory
>> > on my $PATH), as well as 2000 fork and execve calls with an absolute
>> > path to an existing binary. I recorded the minimum time for each, to
>> > eliminate noise from context switches and similar.
>> >
>> > Without fast-path:
>> > fork/execvpe: 49876ns
>> > fork/execve:  32773ns
>> >
>> > With fast-path:
>> > fork/execvpe: 36890ns
>> > fork/execve:  32069ns
>> >
>> > The cost of the additional lookup seems to be in the noise for a
>> > successful exec, but it provides a 26% improvement for the path search
>> > case by speeding up the six failed execs.
>> >
>> > Signed-off-by: Josh Triplett <josh@joshtriplett.org>
>>
>> *thread necromancy*
>>
>> I'll snag this patch after -rc1 is out. Based on the research we both
>> did in the rest of this thread, this original patch is a clear win.
>> Let's get it into linux-next and see if anything else falls out of it.
>>
>
> So the obvious question is why not store lookup result within bprm,
> instead of doing the lookup again later.
>
> Turns out you had very same question and even wrote a patch to sort it
> out: https://lore.kernel.org/all/202209161637.9EDAF6B18@keescook/
>
> Why do you intend to go with this patch instead?
>

Welp, should have read the remaining follow up discussion.

Even so, the patch which is only doing the lookup once cannot be
legitimately slower.

Note there is often perf variance between different boots of the same
kernel and I suspect this is what justifies it.

I would suggest adding a runtime knob to control whether 1. lookups
are done late (stock kernel) 2. there is one upfront lookup like in
the original patch and finally 3. stuffing file into bprm

Then a bunch of runs with the knob cycling between them could serve as
a justification.

If the patch which dodges second lookup still somehow appears slower a
flamegraph or other profile would be nice. I can volunteer to take a
look at what's going on provided above measurements will be done and
show funkyness.

-- 
Mateusz Guzik <mjguzik gmail.com>

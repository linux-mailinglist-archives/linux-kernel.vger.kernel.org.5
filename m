Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0AF7C6143
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 01:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjJKXx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 19:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376579AbjJKXx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 19:53:58 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA7A90;
        Wed, 11 Oct 2023 16:53:55 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-4a18f724d47so134504e0c.3;
        Wed, 11 Oct 2023 16:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697068434; x=1697673234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUtRXirdj/rui6epJsUlvt/EsmEY1Wgvv8OAOJHEF+4=;
        b=F6HGtgeq3XUqZKdYelJ8qXfWwoE6AykAAjgW+L9+9490zKBfCmLbWTotqDXxsXhP+Y
         kS6XLojqTYPg7aGKvJztOQtbtwgnro5ZFDvvKU++SrUmpEFvb2HL2dRbpIbjLsLceihi
         SA8UXsgEnbEqgn5b7tdpFYsYQa6zyrMWEVztqPwmULjb00o8CKw9BAb6LsWcz263J/ie
         +XL/Zn7wuY175Bs+CddeVCPd7ihP6obiaurQ1KcsR3vMzrWDDhJIhHToMxQ+NbjHoK0g
         DGH7NBxbxovH6L0WQOMex7XoB8A3qg4LGhbgWAnyj3umg/59GPhlMAxJvvKypJgmhKUT
         NA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697068434; x=1697673234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUtRXirdj/rui6epJsUlvt/EsmEY1Wgvv8OAOJHEF+4=;
        b=ExuE5cuNzxuwji+l7owd+McRAR93oE2l4iG3KwmM4+6mBOQ83mt+bOLlg7LCXpRHgF
         9Hm5Lnjaz6wy6ujGdHZ0oApBbgEMYO36E4cv+EXF9yhiYRecEJCgZP+HLfsUjyxqPd39
         /S7WwfZKq/WSBf5ncDwx4sIhdR1Bc4k9CKakYbUfG8UbmpMH6q+P5nm81rMeIr+Fbif4
         o2haJ73vi6x4+z6tbPDDnIijYzeGQvxnZLr14AcwFXmGOIbaCpNv1AtWVO7zYyHvGIJ1
         DrYecSq+NBk9hJeFkeYogluRS37WEu+wdGmeNZxXrTjxsdX54f4ftGaX3reOoTHkM2Za
         Kzzw==
X-Gm-Message-State: AOJu0Yynl08vK3T4gk1N7drzVydUFtdgFandfNQzmtRADCWr7M0qAcn9
        j/fpBq3Rc1+newrHYLsqbyVNTZhdPt5qfKmynpI=
X-Google-Smtp-Source: AGHT+IHEP24cW7bJTMG7j9O7/PrmB2IivXDbB+fxOo6F7UkPE1P/21ax1Hkz75j24bn+XAEKV0AGU3W76LFSjvnzgRs=
X-Received: by 2002:a1f:e641:0:b0:49d:e70:6258 with SMTP id
 d62-20020a1fe641000000b0049d0e706258mr16202662vkh.3.1697068434490; Wed, 11
 Oct 2023 16:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230907204256.3700336-1-gpiccoli@igalia.com> <e673d8d6-bfa8-be30-d1c1-fe09b5f811e3@redhat.com>
 <202310091034.4F58841@keescook>
In-Reply-To: <202310091034.4F58841@keescook>
From:   Ryan Houdek <sonicadvance1@gmail.com>
Date:   Wed, 11 Oct 2023 16:53:43 -0700
Message-ID: <CABnRqDdzqfB1_ixd-2JnfSocKvXNM+9ivM1hhd1C=ejLQyen8g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Introduce a way to expose the interpreted file
 with binfmt_misc
To:     Kees Cook <keescook@chromium.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
        ebiederm@xmission.com, oleg@redhat.com, yzaikin@google.com,
        mcgrof@kernel.org, akpm@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, willy@infradead.org, dave@stgolabs.net,
        joshua@froggi.es
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 10:37=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Fri, Oct 06, 2023 at 02:07:16PM +0200, David Hildenbrand wrote:
> > On 07.09.23 22:24, Guilherme G. Piccoli wrote:
> > > Currently the kernel provides a symlink to the executable binary, in =
the
> > > form of procfs file exe_file (/proc/self/exe_file for example). But w=
hat
> > > happens in interpreted scenarios (like binfmt_misc) is that such link
> > > always points to the *interpreter*. For cases of Linux binary emulato=
rs,
> > > like FEX [0] for example, it's then necessary to somehow mask that an=
d
> > > emulate the true binary path.
> >
> > I'm absolutely no expert on that, but I'm wondering if, instead of modi=
fying
> > exe_file and adding an interpreter file, you'd want to leave exe_file a=
lone
> > and instead provide an easier way to obtain the interpreted file.
> >
> > Can you maybe describe why modifying exe_file is desired (about which
> > consumers are we worrying? ) and what exactly FEX does to handle that (=
how
> > does it mask that?).
> >
> > So a bit more background on the challenges without this change would be
> > appreciated.
>
> Yeah, it sounds like you're dealing with a process that examines
> /proc/self/exe_file for itself only to find the binfmt_misc interpreter
> when it was run via binfmt_misc?
>
> What actually breaks? Or rather, why does the process to examine
> exe_file? I'm just trying to see if there are other solutions here that
> would avoid creating an ambiguous interface...
>
> --
> Kees Cook

Hey there, FEX-Emu developer here. I can try and explain some of the issues=
.

First thing is that we should set the stage here that there is a
fundamental discrepancy
between how ELF interpreters are represented versus binfmt_misc
interpreters when it
comes to procfs exe. An ELF file today can either be static or dynamic, wit=
h the
dynamic ELF files having a program header called PT_INTERP which will tell =
the
kernel where its interpreter executable lives. In an x86-64 environment thi=
s
is likely to be something like /lib64/ld-linux-x86-64.so.2. Today, the Kern=
el
doesn't put the PT_INTERP handle into procfs exe, it instead uses the
dynamic ELF
that was originally launched.

In contrast to how this behaviour works, a binfmt_misc interpreter
file getting launched
through execve may or may not have ELF header sections. But it is left up t=
o the
binfmt_misc handler to do whatever it may need. The kernel sets procfs
exe to the
binfmt_misc interpreter instead of the executable.

This is fundamentally the contrasting behaviour that is trying to be
improved. It seems
like the this behaviour is an oversight of the original binfmt_misc
implementation
rather than any sort of ambition to ensure there is a difference. It's
already ambiguous
that the interface changes when executing an executable through binfmt_misc=
.

Some simple ways applications break:
- Applications like chrome tend to relaunch themselves through execve
with `/proc/self/exe`
  - Chrome does this. I think Flatpaks or AppImage applications do this?
  - There are definitely more that do this that I have noticed.
- In the cover letter there was a link to Mesa, the OSS OpenGL/Vulkan
drivers using this
  - This library uses this interface to find out what application is
running for applying
     workarounds for application bugs. Plenty of historical
applications that use the API
     badly or incorrectly and need specific driver workarounds for them.
- Some applications may use this path to open their own executable path and=
 then
   mmap back in for doing tricky memory mirroring or dynamic linking
of themselves.
   - Saw some old abandoned emulator software doing this.

There's likely more uses that I haven't noticed from software using
this interface.

Onward to what FEX-Emu is and how it tries working around the issue
with a fairly naive hack.
FEX-Emu is an x86 and x86-64 CPU emulator that gets installed as a
binfmt_misc interpreter.
It then executes x86 and x86-64 ELF files on an Arm64 device as
effectively a multi-arch
capable fashion. It's lightweight in that all application processes
and threads are just
regular Arm64 processes and threads. This is similar to how qemu-user opera=
tes.

When processing system calls, FEX will intercept any call that
consumes a pathname,
it will then inspect that path name and if it is one of the ways it is
possible to access
procfs/exe then it redirects to the true x86/x86-64 executable. This
is an attempt to behave
like how if the ELF was executed without a binfmt_misc handler.

Pathnames captured in FEX-Emu today:
- /proc/self/exe
- /proc/<pid>/exe
- /proc/thread-self/exe

This is very fragile and doesn't cover the full range of how
applications could access procfs.
Applications could end up using the *at variants of syscalls with an
FD that has /proc/self/
open. They could do simple tricks like `/proc/self/../self/exe` and it
would side-step this check.
It's a game of whack-a-mole and escalating overhead to try and close
the gap purely due
to, what appears to be, an oversight in how binfmt_misc and PT_INTERP
is handled.

Hopefully this explains why this is necessary and that reducing the
differences between
how PT_INTERP and binfmt_misc are represented is desired.

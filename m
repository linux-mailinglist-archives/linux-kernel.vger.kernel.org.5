Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617B77BA648
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjJEQdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235720AbjJEQc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:32:29 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D93E8A63
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 01:26:17 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-495c10cec8aso285232e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 01:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696494376; x=1697099176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wu34Y5Uk7m/dwq+bUXLfA0oFG0rxnym2Ri9SezksNJI=;
        b=VUEEnWSVqa9xxze/PoT41G+0XRhy4/zzHBnveDM/NlTMDTJeaD296Ybc0WRi1BN1GI
         Tp+vJADTxeSGHtqWAQ90iESvtUeU70x8t3e9M0VWW1JFxoVEsVa0ApNLsOvwtCJsbz98
         KVtegdj7bqyPoKGQRn7pEn9fIXG8kkGDvfb71Xy0gLIPZerquxkueYmauRMjY+K3NG1U
         IXMKzn9YbPGr1XrtDQ93DEUZYhbH6X/LkmD+Ju3K82pKOjlNlL0qaEJnh6lci2x7OV7O
         BlbFZVLLe2gwBlsDawEPMvj6a4AVxeBv1GeHIjecx0vjkuwJaimY5P5z6HpiSpSxl1+e
         F+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696494376; x=1697099176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wu34Y5Uk7m/dwq+bUXLfA0oFG0rxnym2Ri9SezksNJI=;
        b=i/xUIZmcjel2K+Z2wrH7vu2ZJY/RIg1uPMjlpB3gtOwDbA+0BUhIbXD/5I2BAZXku3
         g8jIyXxUg55xcMvFjIw89yMzXbFTLivqMjW+hTLGTcPKPNfPEH5YVKUAGP/0YBO+Ege+
         tJMpLSAws3ZWTVJWvtwxp7i0iXst0ObxoxIM9uaAI+pabmiNz9FmsZaycc19II6HwB1I
         OAGkBG0WtI473cs7PegMk2VHS6SkQXJbulezJBwLQodfcSYOfai1T4f4msjDC2GRmsFP
         ipllLbAAqRKbksbyyTOWDTD7XESo8jJyv1rbVy+9IC5Ewb+dDYizEnrGXefWktT/B9gI
         HOhA==
X-Gm-Message-State: AOJu0YyKjzVrsA84EWBOhD/EqBGit/a/6YO0JiCCjGQiMx6z7im2Iz0Z
        0dvbRiUCn1yeRhkTrzSAiv7LMEfwHDD/zPs38bX1/6pUHQOKrg==
X-Google-Smtp-Source: AGHT+IH91h/0wFFtByhJgTE2boW4aB3prn7JVRy76cCLxfhOYQAam2XmIZ9Slh4BkeC4r1XLdHzw7nkVWi8b1RyK5fg=
X-Received: by 2002:a1f:d803:0:b0:495:dcd2:d12a with SMTP id
 p3-20020a1fd803000000b00495dcd2d12amr4528807vkg.9.1696494376216; Thu, 05 Oct
 2023 01:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjrZgxjHZuXwrGeFnng_whUmtToCWE5GQ+HORhGSeiX8g@mail.gmail.com>
 <ZRhKq6e5nF/4ZIV1@fedora> <CAB=+i9QiJ=BXkQuCFJTh3dMXrkKQvVA2EM51Mj6SsDMimWQ71g@mail.gmail.com>
 <20231002104056.GA13957@noisy.programming.kicks-ass.net>
In-Reply-To: <20231002104056.GA13957@noisy.programming.kicks-ass.net>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Thu, 5 Oct 2023 17:26:04 +0900
Message-ID: <CAB=+i9RCCxHH755gWm+Y=3xdpXoRWbz1nwO3_CKDM8Vdmki0dA@mail.gmail.com>
Subject: Re: Linux 6.6-rc3 (DEBUG_VIRTUAL is unhappy on x86)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Kaplan <David.Kaplan@amd.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 7:41=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Sun, Oct 01, 2023 at 11:17:21PM +0900, Hyeonggon Yoo wrote:
>
> > OK, I looked into this a little bit, and it turns out that the problema=
tic
> > address here is from cleanup_trusted() in
> > security/keys/trusted-keys/trusted_core.c.
> > (and it's builtin due to CONFIG_TRUSTED_KEYS=3Dy)
>
> That code is insane.. wth would you want to use an explicit
> static_call() in either __init or __exit ?!?
>
> I think the reason we support init was because it was just really hard
> to avoid throughout the abstraction layers etc.. But this seems to be
> the only __exit user, and it is really quite daft.

Actually that's a good point (that static call in __exit is a bit insane).
One thing I still wonder is,  will the alternative instructions functionali=
ty be
affected in the same way as static calls? Because it's just another way to =
patch
kernel code at runtime.

> > The function is marked as __exit, so it does not fall within the
> > 'core kernel text address range,' which is between _stext and _etext
> > (or between _sinittext and _einittext). and thus __text_poke() thinks t=
hat
> > it's vmalloc/module area.
> >
> > I think __text_poke() should be taught that functions marked as __exit
> > also belong to kernel code just like __init.
>
> Should we not do something like:
>
> #ifdef MODULE
> #define __exit __section(".exit.text") __exitused __cold notrace
> #else
> #define __exit __section(".discard.exit.text")
> #endif
>
> It's not like that code should ever be ran or referenced when built-in.

It looked fine to me, but with a quick testing my linker seems to be unhapp=
y
(removed duplicate lines):

$ make -j12 bzImage
  DESCEND objtool
  DESCEND bpf/resolve_btfids
make[4]: 'install_headers' is up to date.
  CALL    scripts/checksyscalls.sh
  UPD     include/generated/utsversion.h
  CC      init/version-timestamp.o
  LD      .tmp_vmlinux.btf
`.discard.exit.text' referenced in section `__mcount_loc' of
vmlinux.o: defined in discarded section `.discard.exit.text' of
vmlinux.o
`.discard.exit.text' referenced in section `.smp_locks' of vmlinux.o:
defined in discarded section `.discard.exit.text' of vmlinux.o
`.discard.exit.text' referenced in section `__bug_table' of vmlinux.o:
defined in discarded section `.discard.exit.text' of vmlinux.o
`.discard.exit.text' referenced in section `__jump_table' of
vmlinux.o: defined in discarded section `.discard.exit.text' of
vmlinux.o
`.discard.exit.text' referenced in section `.static_call_sites' of
vmlinux.o: defined in discarded section `.discard.exit.text' of
vmlinux.o
`.discard.exit.text' referenced in section `.retpoline_sites' of
vmlinux.o: defined in discarded section `.discard.exit.text' of
vmlinux.o
`.discard.exit.text' referenced in section `.return_sites' of
vmlinux.o: defined in discarded section `.discard.exit.text' of
vmlinux.o
`.discard.exit.text' referenced in section `.call_sites' of vmlinux.o:
defined in discarded section `.discard.exit.text' of vmlinux.o
`.discard.exit.text' referenced in section `.ibt_endbr_seal' of
vmlinux.o: defined in discarded section `.discard.exit.text' of
vmlinux.o
  BTF     .btf.vmlinux.bin.o
pahole: .tmp_vmlinux.btf: Invalid argument
  LD      .tmp_vmlinux.kallsyms1
.btf.vmlinux.bin.o: file not recognized: file format not recognized
make[2]: *** [scripts/Makefile.vmlinux:36: vmlinux] Error 1
make[1]: *** [/home/hyeyoo/Desktop/linux/Makefile:1165: vmlinux] Error 2
make: *** [Makefile:234: __sub-make] Error 2

--
Hyeonggon

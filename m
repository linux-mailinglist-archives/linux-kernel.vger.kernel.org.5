Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C8D7BD008
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 22:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344557AbjJHUOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 16:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344467AbjJHUOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 16:14:16 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B535299
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 13:14:14 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ba1eb73c27so74178966b.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 13:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696796053; x=1697400853; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UYvMlmI9M7/YUJkI+f1pO6RxL0gTPMbx932oD4jWB14=;
        b=QE6PcEx3lS6bwsGmXp0AszHk9k30aPn9DXyfQ5pOFuPJY8ODPQT4z/ATPhzUh/12s6
         eRyj8rQndoaVwVj5n+aV5oFVlXrT6zN8Gusyt+dwIqUclsnfYW7VEVJUANTCBtwkCvHJ
         zZwEEwvkZii+Axk5Ni/s8LdmFjgGCxo41Vgdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696796053; x=1697400853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYvMlmI9M7/YUJkI+f1pO6RxL0gTPMbx932oD4jWB14=;
        b=me3JgWEIdNvVFsRVKLPfsbyFLzNq4REKBIWEhxIbV7Jq6ntidyBsFhApvxim7H/xf+
         5xsIriBVEfBnJS85dT/6baYp2/whhVRowlOXzSKGGGWEKEvnkbjc7pI3sPn9+ylVT9Kt
         2pyQHy97jRF2iyVaDmXNNjll1pdQaogf2VYy88J+84ZINHAE8sTFDUM6XBj782uG7ZY8
         +XokBOFVbyRwit09RwEwzNecaGwv7CPtBocntDLy+8pjZ5rxdsftsSyOWIXu1JP7wgou
         smody/zpZ9T5Plc1uwBKI2OMFNzpOqadAP7sYvRCTbnePUaRT4vrvLBff1KK8Cma/4U5
         gK7w==
X-Gm-Message-State: AOJu0Yxl/OWh3rusEF2RVKsb00xepydx0rROOkxKMWDdmkjUhivp7Z9s
        /qIvSHbXd2EXQgTMpT34inzbRfinQ+adZGq2yXj1HQ==
X-Google-Smtp-Source: AGHT+IFShEp+75QBtpXcowBOTkaF9uj4laEQGbr024UKbpFfoUUn3in6m+BTZ4PDLIAdK95YnGOpyg==
X-Received: by 2002:a17:906:100b:b0:9ae:5270:46d5 with SMTP id 11-20020a170906100b00b009ae527046d5mr13706018ejm.73.1696796052740;
        Sun, 08 Oct 2023 13:14:12 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id ks8-20020a170906f84800b00982a92a849asm5870790ejb.91.2023.10.08.13.14.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Oct 2023 13:14:12 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-532c81b9adbso6754777a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 13:14:11 -0700 (PDT)
X-Received: by 2002:a50:fb87:0:b0:532:e1a2:b0b8 with SMTP id
 e7-20020a50fb87000000b00532e1a2b0b8mr12953692edq.8.1696796051558; Sun, 08 Oct
 2023 13:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231004145137.86537-1-ubizjak@gmail.com> <20231004145137.86537-5-ubizjak@gmail.com>
 <CAHk-=wgepFm=jGodFQYPAaEvcBhR3-f_h1BLBYiVQsutCwCnUQ@mail.gmail.com> <CAFULd4YWjxoSTyCtMN0OzKgHtshMQOuMH1Z0n_OaWKVnUjy2iA@mail.gmail.com>
In-Reply-To: <CAFULd4YWjxoSTyCtMN0OzKgHtshMQOuMH1Z0n_OaWKVnUjy2iA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Oct 2023 13:13:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whq=+LNHmsde8LaF4pdvKxqKt5GxW+Tq+U35_aDcV0ADg@mail.gmail.com>
Message-ID: <CAHk-=whq=+LNHmsde8LaF4pdvKxqKt5GxW+Tq+U35_aDcV0ADg@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86/percpu: Use C for percpu read/write accessors
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
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

On Sun, 8 Oct 2023 at 12:18, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> Let me see what happens here. I have changed *only* raw_cpu_read_8,
> but the GP fault is reported in cpu_init_exception_handling, which
> uses this_cpu_ptr. Please note that all per-cpu initializations go
> through existing {this|raw}_cpu_write.

I think it's an ordering issue, and I think you may hit some issue
with loading TR od the GDT or whatever.

For example, we have this

        set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);

followed by

        asm volatile("ltr %w0"::"q" (GDT_ENTRY_TSS*8));

in native_load_tr_desc(), and I think we might want to add a "memory"
clobber to it to make sure it is serialized with any stores to the GDT
entries in question.

I don't think *that* particular thing is the issue (because you kept
the writes as-is and still hit things), but I think it's an example of
some lazy inline asm constraints that could possibly cause problems if
the ordering changes.

And yes, this code ends up depending on things like
CONFIG_PARAVIRT_XXL for whether it uses the native TR loading or uses
some paravirt version, so config options can make a difference.

Again: I don't think it's that "ltr" instruction. I'm calling it out
just as a "that function does some funky things", and the load TR is
*one* of the funky things, and it looks like it could be the same type
of thing that then causes issues.

Things like CONFIG_SMP might also matter, because the percpu setup is
different. On UP, the *segment* use goes away, but I think the whole
"use inline asm vs regular memory ops" remains (admittedly I did *not*
verify that, I might be speaking out of my *ss).

Your dump does end up being close to a %gs access:

   0: 4a 03 04 ed 40 19 15 add    -0x7aeae6c0(,%r13,8),%rax
   7: 85
   8: 48 89 c7              mov    %rax,%rdi
   b: e8 9c bb ff ff        call   0xffffffffffffbbac
  10: 48 c7 c0 10 73 02 00 mov    $0x27310,%rax
  17: 48 ba 00 00 00 00 00 movabs $0xdffffc0000000000,%rdx
  1e: fc ff df
  21: 48 c1 e8 03          shr    $0x3,%rax
  25:* 80 3c 10 00          cmpb   $0x0,(%rax,%rdx,1) <-- trapping instruction
  29: 0f 85 21 05 00 00    jne    0x550
  2f: 65 48 8b 05 45 26 f6 mov    %gs:0x7ef62645(%rip),%rax        # 0x7ef6267c
  36: 7e
  37: 48 8d 7b 24          lea    0x24(%rbx),%rdi

but I don't know what the "call" before is, so I wasn't able to match
it up with any obvious code in there.

              Linus

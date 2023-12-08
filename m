Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE6B80AE8A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574761AbjLHVEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjLHVE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:04:29 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D3DBD;
        Fri,  8 Dec 2023 13:04:35 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c19467a63so28048995e9.3;
        Fri, 08 Dec 2023 13:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702069474; x=1702674274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6NtR+oTUIOd2AHKXBfJVs3VbzXFOw3VtZb1y+6tew0=;
        b=a6D3M7CDcqiuZtCqTSvzJ7k8oed6Ew4yV2mX/vdl94cgE9gPgYLYvw3M61+WxNlU5E
         cZlq3U14wS/5i54nyxlv2fHwZAQ9RZXXZQOXlkpfxxyUZn+FEU68FzJIOjwD3yT3ykQQ
         Y/J7NK4NNiemwdlUFFmmlIVBalIESJaUhv49VoxhXvPBg+d45bLAVNkEbOQ0brasAwyz
         6Fz2QzllfTtYVOnEeWDW1fo8mIeVzXVJ42wmS/mXiSgUW/SxsXzYPnpX9/jjRFg40v3m
         5ZoWSCzeSv4FUfH7leiB6ZnnNU8rGP18gtGDmkn+bYluKJFa9FzEGRwSA+eJDXTOG/eG
         FOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702069474; x=1702674274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6NtR+oTUIOd2AHKXBfJVs3VbzXFOw3VtZb1y+6tew0=;
        b=QI+Q0/by4A4Jak8lYYiz9Lqx5MxRshGmOxdRsdfZIWm4RdhM/62ZPJt1vpEZ687sIN
         xGz+u6+tZVVArL6zoeQAk114zIDB0SY7ISo/Y9zYCpnxZxkcDCNlOi94zyR8DLF9Ps66
         9wyB8UoIjOtcbe80usyy7CYc7FV1Gb9X2QUxDNNsxSxlOCi5RrUFuhjmiB3lKpXxobQM
         RfEnKrYgkINkneEu7c6Tu74UG0oQt982xSpnpu+RwFwyZB/uRP7wQF8eP7/4Oj5FO/Vu
         XkPIJr6Z/RvIk2WImVcvd2BVO2/RgmxZ1Fto3kdDfkPeBP1rHk5xcTeH3ZBvSunX93EF
         9eSg==
X-Gm-Message-State: AOJu0Yz8j5O7YcuPMDor7aFvpeXW4qhcXjAsmAak+zt9ii7c13KhdfqR
        kGOf0HDQn1lDbIaDGRVrM2LyzgGjY+LQpXhQxwI=
X-Google-Smtp-Source: AGHT+IEkTtKeS6XS1G3jyMsgzOhUXClVJ029bbBc4Aqz+vIee0Tzhjlve6H0wlutP+qM9rQB9kK5huFu1aQL+LEf+9E=
X-Received: by 2002:a1c:4c0a:0:b0:40c:2ad3:1aed with SMTP id
 z10-20020a1c4c0a000000b0040c2ad31aedmr288910wmf.35.1702069473424; Fri, 08 Dec
 2023 13:04:33 -0800 (PST)
MIME-Version: 1.0
References: <20231206163814.GB36423@noisy.programming.kicks-ass.net>
 <20231206183713.GA35897@noisy.programming.kicks-ass.net> <zu5eb2robdqnp2ojwaxjhnglcummrnjaqbw6krdds6qac3bql2@5zx46c2s6ez4>
 <20231207093105.GA28727@noisy.programming.kicks-ass.net> <ivhrgimonsvy3tyj5iidoqmlcyqvtsh2ay3cm3ouemsdbvjzs4@6jlt6zv55tgh>
 <20231208102940.GB28727@noisy.programming.kicks-ass.net> <20231208134041.GD28727@noisy.programming.kicks-ass.net>
 <CAADnVQJFB_CPtFS3=VV=RwnP=EQRL3yEsR8wXVcicb07P8NODw@mail.gmail.com>
 <20231208201819.GE36716@noisy.programming.kicks-ass.net> <CAADnVQ+1nVBuKkjdvh0eu19p+J0UqbO9mcCf3yzVeQtALxzQ+Q@mail.gmail.com>
 <20231208205647.GL28727@noisy.programming.kicks-ass.net>
In-Reply-To: <20231208205647.GL28727@noisy.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 8 Dec 2023 13:04:22 -0800
Message-ID: <CAADnVQKjAwWLfn-gBxq03qv4SQTt0YguYSDZXj8L6nmBZqU66g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/cfi,bpf: Fix BPF JIT call
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Song Liu <song@kernel.org>,
        Song Liu <songliubraving@meta.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Joao Moreira <joao@overdrivepizza.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 12:56=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Dec 08, 2023 at 12:45:51PM -0800, Alexei Starovoitov wrote:
>
> > I mean we don't need to store a pointer to a func in stubs.
> > Can it be, roughly:
> >
> > extern void bpf_tcp_ca_cong_avoid(struct sock *sk, u32 ack, u32 acked);
> > KCFI_MACRO(hash_of_cong_avoid, bpf_tcp_ca_cong_avoid);
> > u32 __array_of_kcfi_hash[] =3D {hash_of_cong_avoid, hash_of_set_state,.=
..};
> >       .bpf_ops_stubs =3D __array_of_kcfi_hash,
>
> But then how do I index this array? The bpf_ops_stubs thing having the
> same layout at the target struct made it easy and we could use 'moff'
> for both.
>
> That also remains working if someone adds a member to the struct or
> moves some members around.

I was thinking to just moff/2 assuming u32 array will have the same order,
but I missed the fact that init() and release() in tcp_congestion_ops
come after some variables.
And you're right it's more fragile when things change in tcp_congestion_ops=
.
Storing u32 hash as (void *) into function pointers is just ugly.
Let's go with your initial approach.

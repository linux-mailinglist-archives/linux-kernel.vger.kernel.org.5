Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DD780AD3F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbjLHTki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbjLHTkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:40:33 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD5E199F;
        Fri,  8 Dec 2023 11:40:39 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so2226369f8f.0;
        Fri, 08 Dec 2023 11:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702064438; x=1702669238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGqhfgnTbLSQhTQ1bMee6eK6lcK7c6hE95qruhtgvEk=;
        b=VHC0k+mMONG1sn2lHi5PinhxgLT6ZlhKXS2rTAWvS9SpRi8uFvV7GBrsxTuRgYQnT2
         A3Of7SnVGOKgHlovRIP/zry3ZoAeqRuDeZJ79WqQeRol+BMjtJDSJ+I4mokRcbwJAig9
         pQZyj46RCdbQ9edaCL+ffQELcz/Z0pLYl2mEVMH/HRuFwS0yBX2AytHap/RNiw5eQKSs
         Wlt0GqIOz2BcFhZiHXc+SshWBB459LuR6gqghQ5O0jM8fuLW02M5g/t201V82hJ8K94R
         1hnXaCmckIA07XlON021roKBQE2mH4J93iTIUUR7TXIlUM652fB4eRySiG49crimotyX
         cXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702064438; x=1702669238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGqhfgnTbLSQhTQ1bMee6eK6lcK7c6hE95qruhtgvEk=;
        b=ASM7MJfpyKRPlX/sc3Hu0jZNxSOjHOcCiq61fj5YR2PDrIUJwSY5d3W+R7YxJ2qEBQ
         d2zk8wCgx3+PxUgdDpk/YYwc3KXaugznW3zc6IAyciNE5hou9gaLGvf5r09Y3YxMm5kb
         7fU/ewsNgh2uu4sdJO6DBIGSG8N4L0Il8RUsVwA/j1TFptyKvkpCIqCb0BuaNpR4n+a9
         1t9JUiEW84fq4VPl6BLRdvSccqJHvqEnP80p5In/r7MabqKoH4VPIJwdTj0I2YfaF3kF
         V6imkHKKyMzLFODSO9dKa5XNR2PF7cr06D52xnfGLCXHrUjuxLNAGs2EXnmlkm6ToWOr
         f4xg==
X-Gm-Message-State: AOJu0YycaT6A0uUQL2NIhhzVYG/UU69pu81FB/9a2fqATqy2+aP4sJ8j
        6GVmoXyB+t4ik47hjENzDOh5bOFjrwEtKq7bXH7ejDPv8Ms=
X-Google-Smtp-Source: AGHT+IHt0AOwYtDELssGf1Db4Jmn3pjjJiojkcuC4s+RabiD4a0X0j4NeWSW3wWlhqFCkvQtOof9Rit1N2UOiD+eLQA=
X-Received: by 2002:a05:6000:543:b0:333:381d:6a26 with SMTP id
 b3-20020a056000054300b00333381d6a26mr334324wrf.135.1702064438187; Fri, 08 Dec
 2023 11:40:38 -0800 (PST)
MIME-Version: 1.0
References: <20231204181614.GA7299@noisy.programming.kicks-ass.net>
 <20231204183354.GC7299@noisy.programming.kicks-ass.net> <CAADnVQJwU5fCLcjBWM9zBY6jUcnME3+p=vvdgKK9FiLPWvXozg@mail.gmail.com>
 <20231206163814.GB36423@noisy.programming.kicks-ass.net> <20231206183713.GA35897@noisy.programming.kicks-ass.net>
 <zu5eb2robdqnp2ojwaxjhnglcummrnjaqbw6krdds6qac3bql2@5zx46c2s6ez4>
 <20231207093105.GA28727@noisy.programming.kicks-ass.net> <ivhrgimonsvy3tyj5iidoqmlcyqvtsh2ay3cm3ouemsdbvjzs4@6jlt6zv55tgh>
 <20231208102940.GB28727@noisy.programming.kicks-ass.net> <20231208134041.GD28727@noisy.programming.kicks-ass.net>
 <20231208172152.GD36716@noisy.programming.kicks-ass.net>
In-Reply-To: <20231208172152.GD36716@noisy.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 8 Dec 2023 11:40:27 -0800
Message-ID: <CAADnVQKsnZfFomQ4wTZz=jMZW5QCV2XiXVsi64bghHkAjJtcmA@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 9:22=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Fri, Dec 08, 2023 at 02:40:41PM +0100, Peter Zijlstra wrote:
> > On Fri, Dec 08, 2023 at 11:29:40AM +0100, Peter Zijlstra wrote:
> > > The only problem I now have is the one XXX, I'm not entirely sure wha=
t
> > > signature to use there.
> >
> > > @@ -119,6 +119,7 @@ int bpf_struct_ops_test_run(struct bpf_p
> > >     op_idx =3D prog->expected_attach_type;
> > >     err =3D bpf_struct_ops_prepare_trampoline(tlinks, link,
> > >                                             &st_ops->func_models[op_i=
dx],
> > > +                                           /* XXX */ NULL,
> > >                                             image, image + PAGE_SIZE)=
;
> > >     if (err < 0)
> > >             goto out;
> >
> > Duh, that should ofcourse be something of dummy_ops_test_ret_fn type.
> > Let me go fix that.
>
> Next one.. bpf_obj_free_fields: field->kptr.dtor(xchg_field);
>
> The one that trips is bpf_cgroup_release().
>
> objtool doesn't think the address of that function 'escapes' and
> 'helpfully' seals that function, and then BPF thinks it does escape and
> manages the above indirect call and *boom*.
>
> How can I tell which functions escape according to BPF such that I might
> teach objtool this?

I'm not following.
Are you asking to annotate
__bpf_kfunc void bpf_cgroup_release(struct cgroup *cgrp)
somehow so that objtool knows that it will be called indirectly?
typedef void (*btf_dtor_kfunc_t)(void *);
        btf_dtor_kfunc_t dtor;
but the bpf_cgroup_release takes 'struct cgroup*'.
From kcfi pov void * =3D=3D struct cgroup * ?
Do we need to change it to 'void *cgrp' ?
What is "sealing" by objtool?

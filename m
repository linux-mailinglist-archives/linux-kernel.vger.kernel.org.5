Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CED57F56A7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 03:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjKWC6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 21:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjKWC6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 21:58:08 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DDD101
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 18:58:14 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-4ac023c8f82so159356e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 18:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700708294; x=1701313094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNqhJS4E6ntiOthoCCp30Dce98FPuWbxjBUizuT5qHE=;
        b=iP1qw2WkutAlJ0p9m1MAxYyEou3SU380kIzvq0R6Q6L3KBhyhqnLJ38MeIt7SvrDY8
         4riBLYMR7dNR3UvqvOPqkpF+z/SIZr/XwECHUA97Ied6IgKwxNNfOPY/Ch9AHLdB7Zna
         /RV3xbbCTIT0A3FOud7n8d6adkI5Ue9Ywo8yXU8aWk+uK01l/Of9IyMF57SqQZ+3N9aV
         mPT8KgiBy9iia9Wm2UsSvDPDjgzGT65mQOhWf2/3xcfxBtzex8JzmlLyL1n7QmdsSvso
         K9G1xCSzpoqedHsMpFV3egUVKjxkVKRa4HacUdgZ6j9A1IcpdWQzsvzMZT4E/Pnd4hbx
         YHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700708294; x=1701313094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNqhJS4E6ntiOthoCCp30Dce98FPuWbxjBUizuT5qHE=;
        b=a+DaiNCH2lH1+2o72yUcOzBYlkC1NdxOEWSciwajV8yutMLPyMJxUhDQlOlnT7mYrX
         zvaVzp4307Y+uDpWlm1Ghb86Cu8jQlimdl0LglMquh1zxlxBGDBAqS6dZuv5Of+6gvF1
         Sty2Iv5ak6OssszKxXlu7ZgHeDfTIXiVa/q7cK4xtgq06sXuhMXNtEfRYtnCr1cCaQsh
         IUGrj9PHU3OzS8nqDDUeLgO3Uk2xy9WYzzMPItcNcsvGnuEUbc4fgm3WgSbGRP1GIdHx
         zjHiVMb+qLH353G2pznXISERv4r5Kyzob2rbK6KI87V8DRo3+WmsB1Jv62xaO+T0ZVn3
         m4OA==
X-Gm-Message-State: AOJu0Yy0CEt0/iFSGK7WNX8+O+gzzCE801q5NghoJxez7thntfVgY3PF
        ovHsMCuaTCtiZUxrJqeWX2GMkap0OtTKlv2ezOc=
X-Google-Smtp-Source: AGHT+IH5KZJpl6aREdAr1HdnesbhNhwGxOkUSqrOml8nuuykUyEAOW12bLklefdZVae2hePno5m1rPkBu+fZtOFCkVs=
X-Received: by 2002:a67:f546:0:b0:462:877d:7d05 with SMTP id
 z6-20020a67f546000000b00462877d7d05mr4431612vsn.24.1700708293822; Wed, 22 Nov
 2023 18:58:13 -0800 (PST)
MIME-Version: 1.0
References: <20231122231202.121277-1-andrey.konovalov@linux.dev>
 <CAB=+i9QFeQqSAhwY_BF-DZvZ9TL_rWz7nMOBhDWhXecamsn=dw@mail.gmail.com> <CA+fCnZdp4+2u8a6mhj_SbdmfQ4dWsXBS8O2W3gygzkctekUivw@mail.gmail.com>
In-Reply-To: <CA+fCnZdp4+2u8a6mhj_SbdmfQ4dWsXBS8O2W3gygzkctekUivw@mail.gmail.com>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Thu, 23 Nov 2023 11:58:02 +0900
Message-ID: <CAB=+i9RnOz0jDockOfw3oNageCUF5gmF+nzOzPpoTxtr7eqn7g@mail.gmail.com>
Subject: Re: [PATCH mm] slub, kasan: improve interaction of KASAN and
 slub_debug poisoning
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Feng Tang <feng.tang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 11:31=E2=80=AFAM Andrey Konovalov <andreyknvl@gmail=
.com> wrote:
>
> On Thu, Nov 23, 2023 at 1:39=E2=80=AFAM Hyeonggon Yoo <42.hyeyoo@gmail.co=
m> wrote:
> >
> > On Thu, Nov 23, 2023 at 8:12=E2=80=AFAM <andrey.konovalov@linux.dev> wr=
ote:
> > >
> > > From: Andrey Konovalov <andreyknvl@google.com>
> > >
> > > When both KASAN and slub_debug are enabled, when a free object is bei=
ng
> > > prepared in setup_object, slub_debug poisons the object data before K=
ASAN
> > > initializes its per-object metadata.
> > >
> > > Right now, in setup_object, KASAN only initializes the alloc metadata=
,
> > > which is always stored outside of the object. slub_debug is aware of
> > > this and it skips poisoning and checking that memory area.
> > >
> > > However, with the following patch in this series, KASAN also starts
> > > initializing its free medata in setup_object. As this metadata might =
be
> > > stored within the object, this initialization might overwrite the
> > > slub_debug poisoning. This leads to slub_debug reports.
> > >
> > > Thus, skip checking slub_debug poisoning of the object data area that
> > > overlaps with the in-object KASAN free metadata.
> > >
> > > Also make slub_debug poisoning of tail kmalloc redzones more precise =
when
> > > KASAN is enabled: slub_debug can still poison and check the tail kmal=
loc
> > > allocation area that comes after the KASAN free metadata.
> > >
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >
> > Thank you for looking at this quickly!
> > Unfortunately the problem isn't fixed yet with the patch.
> >
> > I applied this on top of linux-next and built a kernel with the same co=
nfig,
> > it is still stuck at boot.
>
> Ah, this is caused by a buggy version of "kasan: improve free meta
> storage in Generic KASAN", which made its way into linux-next.
> Reverting that patch should fix the issue. My patch that you bisected
> to exposes the buggy behavior.

1. I reverted the commit "kasan: improve free meta storage in Generic KASAN=
",
    on top of linux-next (next-20231122), and it is still stuck at boot.

2. I reverted the commit "kasan: improve free meta storage in Generic KASAN=
",
    on top of linux-next (next-20231122),
   _and_ applied this patch on top of it, now it boots fine!

--
Hyeonggon

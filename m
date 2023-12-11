Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D903380C1A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 08:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbjLKHGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 02:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjLKHGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 02:06:42 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ACA9B;
        Sun, 10 Dec 2023 23:06:48 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54c77e0835bso5898079a12.2;
        Sun, 10 Dec 2023 23:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702278406; x=1702883206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2MEib+MwJnReuRpmTAL60gewi5yJRdPEiiZIiH6sIs=;
        b=kbWeYfDeQwNmQZ/EUodeZiwXdzODWgnjwoDFMTvMQZ6WbW2n7jTTfvfLavPnAEIDN4
         qYZkD2bXczI8p1/PuPfAAbxMwyPPLEDX2nAUnxoYe70Lbmkly4VAiGgF5XEZ6EwaKk9p
         YP5q1XV0XiQ6p6VnLvkXcN/FZnTjGPAU6NgPx52YIw0aQLpxuXKpva40nfEhyR/Lvauf
         mWHG7iwWbN6SdX7n/B21eJNAsAontSkLPLSr88HKyJX3J1Tz7FqllP/0KFXKEgoJoF9s
         ZL9wOJWi7HT9I3qVmsyExm5Ohk/LACly3c1CCtAQv3CC+iaUUdX19flUdqv93gEVqPyr
         GsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702278406; x=1702883206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2MEib+MwJnReuRpmTAL60gewi5yJRdPEiiZIiH6sIs=;
        b=Pz/tCv+SRncY33AHX975dJhZDBkd50O7ED5MdaHDTrM2FPVJRNvK6iYhpOhTkUVvKj
         T1rMx4+pVVGDiYofQJUQg01Kn5Gatx9uPSlWAhZ/DaztZI6BQe9j9Def3cH6J6Tnyghb
         50VrgGXiG8kw8vzHja1vyag/w0B94h1F3wQhmDAg6pdXjpUmGmDI9AL1pvkeHGQcb6tJ
         9dyOP93/R0TidS+naEXRG5IZ7x8vhZI5MIDHlMuwkieGEXOdAW4WWVgo9F8PeBeg0k54
         pifuagB6NB5JfM+OG9oYLWKQWZDtNwIct9pnxHc8Q4gB/087YCuHPQcY0mrhufaBWIB2
         ov+Q==
X-Gm-Message-State: AOJu0Yw7NC1TACWER1J3y22iEExR7Sg8MsYxAArSPKBq3+KWitBrrt/A
        Vdwmr5Nwsh9RTlnacZ4rNHc2YZ6HkSzMV+9q03o=
X-Google-Smtp-Source: AGHT+IF//nxtCvAma1TadxlfNQPlRR3CFEQ4xRj0CGPayT2SdFQ3qJP++BEu7p7l8iDwmIb5RHRpf0zbRWHN36j381c=
X-Received: by 2002:a50:9e6d:0:b0:54c:b175:87bf with SMTP id
 z100-20020a509e6d000000b0054cb17587bfmr2344684ede.2.1702278406336; Sun, 10
 Dec 2023 23:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20231201112918.294b40b1@canb.auug.org.au> <CAFULd4Yfh0=TkhoevuJP1kghP5VLFj2zP9av68_s2pez3n2iog@mail.gmail.com>
 <20231204150807.600c2f09@canb.auug.org.au> <CAFULd4Y4n4uGy-pTc0PD6+-OytzGZHeJTPZ_CPJDq7VM7ChRdA@mail.gmail.com>
 <20231211161946.2f151d13@canb.auug.org.au>
In-Reply-To: <20231211161946.2f151d13@canb.auug.org.au>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Mon, 11 Dec 2023 08:06:37 +0100
Message-ID: <CAFULd4Ysr_UxiE=jXoXMuJpzdzunNS=03tL2D0V+3zyr5tod+Q@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the tip tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

On Mon, Dec 11, 2023 at 6:19=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> On Mon, 4 Dec 2023 08:02:56 +0100 Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > On Mon, Dec 4, 2023 at 5:08=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.=
org.au> wrote:
> > >
> > > On Fri, 1 Dec 2023 13:09:45 +0100 Uros Bizjak <ubizjak@gmail.com> wro=
te:
> > > >
> > > > On Fri, Dec 1, 2023 at 1:29=E2=80=AFAM Stephen Rothwell <sfr@canb.a=
uug.org.au> wrote:
> > > > >
> > >  > After merging the tip tree, today's linux-next build (x86_64 allmo=
dconfig)
> > > > > produced these warnings:
> > > > >
> > > > > WARNING: modpost: EXPORT symbol "const_pcpu_hot" [vmlinux] versio=
n generation failed, symbol will not be versioned.
> > > > > Is "const_pcpu_hot" prototyped in <asm/asm-prototypes.h>?
> > > > > WARNING: modpost: "const_pcpu_hot" [arch/x86/kernel/msr.ko] has n=
o CRC!
> > > > > WARNING: modpost: "const_pcpu_hot" [arch/x86/kvm/kvm.ko] has no C=
RC!
> > > >
> > > > My build doesn't produce any warnings. A defconfig + enabling kvm.k=
o as module:
> > > >
> > > > ...
> > > >  AR      built-in.a
> > > >  AR      vmlinux.a
> > > >  LD      vmlinux.o
> > > >  OBJCOPY modules.builtin.modinfo
> > > >  GEN     modules.builtin
> > > >  MODPOST Module.symvers
> > > >  CC      .vmlinux.export.o
> > > >  CC [M]  arch/x86/kvm/kvm.mod.o
> > > >  CC [M]  fs/efivarfs/efivarfs.mod.o
> > > > ...
> > > >
> > > > Does the attached patch help? Or is there anything else I should do=
 to
> > > > trigger the above problem?
> > >
> > > The patch does not help.  I am just doing an X86_64 allmodconfig buil=
d
> > > with CONFIG_WERROR=3Dn. gcc is
> > >
> > > $ x86_64-linux-gnu-gcc --version
> > > x86_64-linux-gnu-gcc (Debian 13.2.0-2) 13.2.0
> > >
> > > This is a cross build with a ppc64le host.
>
> I am still seeing the warnings ...

The -v3 patch series that fixes this and the remaining sparse warnings
sits unreviewed for a week at [1].

I don't know why it is not being considered.

[1] https://lore.kernel.org/lkml/20231204210320.114429-1-ubizjak@gmail.com/

Thanks,
Uros.

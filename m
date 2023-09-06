Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC15C7944FF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244706AbjIFVQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244694AbjIFVQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:16:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0D29C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 14:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694034941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gGIDxeEIjrmniLnAwcRaZhEhoprTMiMG+eryvzhOGZk=;
        b=S52MmvrPqzj9nFVT4lCqL4jT3Z36E95UQGqjHG8MfUqu6l008q9rjlGT5ha5Z9pi8ZnyRZ
        tG8iBudnI1QK7y4bqTdOQVR2kRRrRng8gdwoxmb/VinNCwHS9doMb+jccGD+M1f4zY2QBc
        IedJUoIa5J3zqvwGw/KERden43JYz6g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-LpsW5_pQNd2MtPTC0nETPg-1; Wed, 06 Sep 2023 17:15:39 -0400
X-MC-Unique: LpsW5_pQNd2MtPTC0nETPg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-412136f4706so3524361cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 14:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694034939; x=1694639739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGIDxeEIjrmniLnAwcRaZhEhoprTMiMG+eryvzhOGZk=;
        b=K5cJzCRggfjJN94nTp0pzR/d7CddAK1Tdi/WKt/b9qvLyt+1TFuiass8OtzePjrB3+
         JWNoL37n/13ktbGpOUMzGLmpeY+Vfo0naBzwsMw6Bod9HbewBVQ/53pOVWvePy9mpCey
         Y93hhcKMlswlsa0EjCkWUyaGy/0NeK4xa2n7vMuqtrsJy+53RTTidrB6WTToe9nd+UfG
         UvVdO9kDX92fPAS35x0bn1B12Oez8K2IseWY1zJ11ez7eoJiZUlQtmUiUXoteXo7Gh0w
         JO8ssOtL62IFikrvykjJF0hWJwHR6F67RFKsfIhNJ6du7iAm5ev5mZQjmAaAd2/6vqdU
         e7Vg==
X-Gm-Message-State: AOJu0YxKNcJD+1tVyNudutz8GHhNXdXj9Jgh3pEj2rZr3rFNoVhw3jJy
        KV2BVBYHuh2eaYC8uBVb5SQH0EbsXFACmQbSs5eb63lP1onVJmcfyLV87ocymRXEsQ8g2ZGAiee
        Vznz5LRNWIbUUR3+CUq3iXIJx5/bZeKBVLbzriuEN
X-Received: by 2002:ac8:5788:0:b0:404:a649:879c with SMTP id v8-20020ac85788000000b00404a649879cmr23505198qta.49.1694034939055;
        Wed, 06 Sep 2023 14:15:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGTlsLimhiG7g4l7TR8BKuZzowkBAwxrjki6I+0aIHLfI7xehZRFgZM0GOD3X1kn8Abbi99S9xon3gEc25KOE=
X-Received: by 2002:ac8:5788:0:b0:404:a649:879c with SMTP id
 v8-20020ac85788000000b00404a649879cmr23505184qta.49.1694034938822; Wed, 06
 Sep 2023 14:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-92f37526-d36c-48c0-8fbd-7676df1b6086@palmer-ri-x1c9> <2a4f1f47e945772b9fbb53a51e148636e0ae6e48.camel@redhat.com>
In-Reply-To: <2a4f1f47e945772b9fbb53a51e148636e0ae6e48.camel@redhat.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Wed, 6 Sep 2023 18:15:27 -0300
Message-ID: <CAJ6HWG6Wi7Th=bcfxdnpg_Mu1UyV1wTuJV67b=3J2FjLykCBRA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 5/5] riscv/cmpxchg: Implement xchg for variables of
 size 1 and 2
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        peterz@infradead.org, boqun.feng@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, parri.andrea@gmail.com,
        andrzej.hajda@intel.com, guoren@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 6:59=E2=80=AFPM Leonardo Br=C3=A1s <leobras@redhat.=
com> wrote:
>
> On Thu, 2023-08-10 at 09:23 -0700, Palmer Dabbelt wrote:
> > On Thu, 10 Aug 2023 09:04:04 PDT (-0700), leobras@redhat.com wrote:
> > > On Thu, 2023-08-10 at 08:51 +0200, Arnd Bergmann wrote:
> > > > On Thu, Aug 10, 2023, at 06:03, Leonardo Bras wrote:
> > > > > xchg for variables of size 1-byte and 2-bytes is not yet availabl=
e for
> > > > > riscv, even though its present in other architectures such as arm=
64 and
> > > > > x86. This could lead to not being able to implement some locking =
mechanisms
> > > > > or requiring some rework to make it work properly.
> > > > >
> > > > > Implement 1-byte and 2-bytes xchg in order to achieve parity with=
 other
> > > > > architectures.
> > > > >
> > > > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > >
> > >
> > > Hello Arnd Bergmann, thanks for reviewing!
> > >
> > > > Parity with other architectures by itself is not a reason to do thi=
s,
> > > > in particular the other architectures you listed have the instructi=
ons
> > > > in hardware while riscv does not.
> > >
> > > Sure, I understand RISC-V don't have native support for xchg on varia=
bles of
> > > size < 4B. My argument is that it's nice to have even an emulated ver=
sion for
> > > this in case any future mechanism wants to use it.
> > >
> > > Not having it may mean we won't be able to enable given mechanism in =
RISC-V.
> >
> > IIUC the ask is to have a user within the kernel for these functions.
> > That's the general thing to do, and last time this came up there was no
> > in-kernel use of it -- the qspinlock stuff would, but we haven't enable=
d
> > it yet because we're worried about the performance/fairness stuff that
> > other ports have seen and nobody's got concrete benchmarks yet (though
> > there's another patch set out that I haven't had time to look through,
> > so that may have changed).
> >
> > So if something uses these I'm happy to go look closer.
>
> IIUC patches 4 & 5 will be used by qspinlock, which may not be done yet, =
so we
> don't have an use for them for the time being.
>
> Otherwise, any comments on patches 1, 2 & 3?

Hello Palmer,
Any chance of patches 1, 2 & 3 being merged in this merge window?

Thanks!


>
> >
> > > > Emulating the small xchg() through cmpxchg() is particularly tricky
> > > > since it's easy to run into a case where this does not guarantee
> > > > forward progress.
> > > >
> > >
> > > Didn't get this part:
> > > By "emulating small xchg() through cmpxchg()", did you mean like emul=
ating an
> > > xchg (usually 1 instruction) with lr & sc (same used in cmpxchg) ?
> > >
> > > If so, yeah, it's a fair point: in some extreme case we could have mu=
ltiple
> > > threads accessing given cacheline and have sc always failing. On the =
other hand,
> > > there are 2 arguments on that:
> > >
> > > 1 - Other architectures, (such as powerpc, arm and arm64 without LSE =
atomics)
> > > also seem to rely in this mechanism for every xchg size. Another arch=
s like csky
> > > and loongarch use asm that look like mine to handle size < 4B xchg.
> > >
> > >
> > > >  This is also something that almost no architecture
> > > > specific code relies on (generic qspinlock being a notable exceptio=
n).
> > > >
> > >
> > > 2 - As you mentioned, there should be very little code that will actu=
ally make
> > > use of xchg for vars < 4B, so it should be safe to assume its fine to=
 not
> > > guarantee forward progress for those rare usages (like some of above =
mentioned
> > > archs).
> > >
> > > > I would recommend just dropping this patch from the series, at leas=
t
> > > > until there is a need for it.
> > >
> > > While I agree this is a valid point, I believe its more interesting t=
o have it
> > > implemented if any future mechanism wants to make use of this.
> > >
> > >
> > > Thanks!
> > > Leo
> >
>


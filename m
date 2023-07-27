Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96296765857
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjG0QKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjG0QKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:10:51 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595C52D45
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:10:50 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fd28ae8b90so84835e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690474249; x=1691079049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+xfXf+SFs/NOQ0ksDMyvLO9Rn9nyk/jrsGlS1L+bV0=;
        b=HNw8nz0xuMd6I06v9gLe+J2yV8MPgI8J2E5/EZv/9K3qWytBcWtWVxd/j8l3ukt38o
         oM7WDr546z3dwDSFzyEapFRJ9fefeWObkTYraPGNw+mLrVSFsFWyFJ0SxDIFQlC46Jts
         BtvyD/9uo3LZXF1kkibNRVOk1ovES2+gn7X8ClzU2sNt854JwBI7jkypTw809782Gpbg
         NZ2dDpFhYyaAlXpWOo92DRA4/ABK/KJhmP0aKtOulHfSiH8OfBmIR2ifp4mxbpzP0drz
         LqQX8wBjQCuHL186Lmb5WfDmCq/npG9nCajsEEhBCVYJUK9iwjTc1E35hiq+nUKvNtW0
         Z/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690474249; x=1691079049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+xfXf+SFs/NOQ0ksDMyvLO9Rn9nyk/jrsGlS1L+bV0=;
        b=MJpZbRyvMbFLE7yt4Nc/a6kg/917jaPAeikVmMCbpQBm2ror5ylEIoB7y1Ni5grLZZ
         XLv3HyhGyAPxicddd4FaKz4JnpkQ4uWrbzW73qDPtjRhp7e4RVpFtdzIYhFOckbfb+Po
         ApFnXBpV7UiFA1kTxPC0jt1YDbTBhlsHBrkRq+4xFRrj7aI4m9NnCvoFdWavbvvNiljX
         H0/3tSIdUa/qvKirTWL5FsL9rj98WyGtAIblGgfdKTaX0/Zv7NqtV+ebntqUKLF9qOr6
         aK+0fVR30do4y8PKDl9xF4thN95C6eptz1FGihGKIuyoiAJMHuJcrL3ij1+puh/91tUU
         yqbA==
X-Gm-Message-State: ABy/qLZWl+J9Vnuh8FqG6qgZwxnuvbedPnN8OCSsHlg9dBdHsvZy8HQ5
        fVIKAWsqfzyjIOx/qpph08ytFah417uFndstwUayMQ==
X-Google-Smtp-Source: APBJJlG5VES8QxpxVaDTzmDFfw3ngkuISlX1JRoJU8AZ/7z1v8YbcFTVffCgNO7Uu39CC/q8qvlVgovVBaTNMEm38V8=
X-Received: by 2002:a05:600c:4fcc:b0:3f7:e4d8:2569 with SMTP id
 o12-20020a05600c4fcc00b003f7e4d82569mr88727wmq.5.1690474248653; Thu, 27 Jul
 2023 09:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230726214103.3261108-1-jannh@google.com> <31df93bd-4862-432c-8135-5595ffd2bd43@paulmck-laptop>
 <CAG48ez1fDzHzdD8YHEK-9D=7YcsR7Bp-FHCr25x13aqXpz7UnQ@mail.gmail.com>
 <20230727145747.GB19940@willie-the-truck> <13dc448b-712e-41ce-b74b-b95a55f3e740@rowland.harvard.edu>
In-Reply-To: <13dc448b-712e-41ce-b74b-b95a55f3e740@rowland.harvard.edu>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 27 Jul 2023 18:10:12 +0200
Message-ID: <CAG48ez3OXbiruoATeSp-PZ9ZdDcFuwJ4+XCS6EgY_jrtcqqGcw@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix vma->anon_vma check for per-VMA locking; fix
 anon_vma memory ordering
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Will Deacon <will@kernel.org>, paulmck@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 5:44=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
> On Thu, Jul 27, 2023 at 03:57:47PM +0100, Will Deacon wrote:
> > On Thu, Jul 27, 2023 at 04:39:34PM +0200, Jann Horn wrote:
>
> > > Assume that we are holding some kind of lock that ensures that the
> > > only possible concurrent update to "vma->anon_vma" is that it changes
> > > from a NULL pointer to a non-NULL pointer (using smp_store_release())=
.
> > >
> > >
> > > if (READ_ONCE(vma->anon_vma) !=3D NULL) {
> > >   // we now know that vma->anon_vma cannot change anymore
> > >
> > >   // access the same memory location again with a plain load
> > >   struct anon_vma *a =3D vma->anon_vma;
> > >
> > >   // this needs to be address-dependency-ordered against one of
> > >   // the loads from vma->anon_vma
> > >   struct anon_vma *root =3D a->root;
> > > }
>
> This reads a little oddly, perhaps because it's a fragment from a larger
> piece of code.

Yes, exactly. The READ_ONCE() would be in anon_vma_prepare(), which is
a helper used to ensure that a VMA is associated with an anon_vma, and
then the vma->anon_vma is used further down inside the fault handling
path. Something like:

do_cow_fault
  anon_vma_prepare
    READ_ONCE(vma->anon_vma)
    barrier()
  finish_fault
    do_set_pte
      page_add_new_anon_rmap
        folio_add_new_anon_rmap
          __page_set_anon_rmap
            [reads vma->anon_vma]

Anyway, I guess I'll follow what Paul and Matthew said and go with
smp_load_acquire().

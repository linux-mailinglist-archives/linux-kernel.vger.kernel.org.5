Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15FE7B263B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjI1UD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 16:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjI1UD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:03:56 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31729193
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:03:54 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a1d0fee86aso95028497b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695931433; x=1696536233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsHLGxGeDn14ekxmLTtpNWlyKujIB9kYU0PV2IMFY58=;
        b=vf6iMiuE+fHZpEy28IjSRzP/TfvLZVhU7z3LQIjZuNsmbbmlUaJvrTk2vIN14ySUT5
         gC8skrwWSoEp7oVaMXQbYrxNkpUkwfzkVK9o2OB9Mirr0IuuQ9lXMcVuCv75x2DYlk23
         MTKQywDHjRdWN6XBA1AHq2NnfLD1mBMeOuAEXWXrPO0W5CyU7RF7bq+Ll2lfOnXVIoC8
         CuaC7j5RdQ0dZgdqOQIvUZ5Bbu24OZkXWgp5lnZpQ2eg76nhEh3ECrqYtt14n1KlnLqF
         rRW3Illf8V2VQBVCkllQ/071P50WUnoc9v4KyQbptSe6ai/7S2lvyMkx+YMkGwmlmkAg
         6MKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695931433; x=1696536233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsHLGxGeDn14ekxmLTtpNWlyKujIB9kYU0PV2IMFY58=;
        b=LVafY6iciHPfncPoyg3zQPRWEjKRhTSHF2h6ukgNCB5+LohH6gqOsZ5a/IaA05S6ZS
         42TLug6pDH24XyTjUqh8rjw8hBjxs/PlAHSgAo/ZBj9vh1a88wCHdX66oNXGLUlArVEE
         bmqWOgWjTtzmG6x6ZXj0RU7xWk7vKkvi9DO+rFC0qgvWTJNcmzl9klyJ3jmV3sbT16PS
         jL6Jlj0yfWbynC9Uba2ILBh051c2A2VOk3qcNiZH6eXyTpRBIDohpalPqZCRJqEl/Uqv
         swuUIR5KFV2Ja1wDe5NPdqWgdg1I1Zz948vuRVFJwVz+ss7MYKO1iKa1UKA/T6sGFZ6c
         gpSQ==
X-Gm-Message-State: AOJu0YwyASDsp5NLupK9aMZ9uVDTXPo6INY/jpsa1c6YtTzoVKB8eoRW
        JKPVn1UXAZ3ttZI98fZaRdWEBgJTh2tdLj/8ojBY3g==
X-Google-Smtp-Source: AGHT+IF643ukEV0mPuP85u4NKNRshxRfoC17PtT7KMQhkXUBySTKl68yBv/jOJAcKvvLEWiANUN/7F/cxIBnZMzGJuo=
X-Received: by 2002:a81:49c8:0:b0:59f:8026:4260 with SMTP id
 w191-20020a8149c8000000b0059f80264260mr2399284ywa.24.1695931433221; Thu, 28
 Sep 2023 13:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230923013148.1390521-1-surenb@google.com> <20230923013148.1390521-2-surenb@google.com>
 <ZRWogK5s5/giHuGu@x1n>
In-Reply-To: <ZRWogK5s5/giHuGu@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 28 Sep 2023 13:03:42 -0700
Message-ID: <CAJuCfpEPzJZmrMsD2JkcUjnhhW4sm9i=-1U9n-87YPLWopgm2w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] userfaultfd: UFFDIO_REMAP: rmap preparation
To:     Peter Xu <peterx@redhat.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, david@redhat.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 9:23=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> Suren,
>
> Sorry to review so late.
>
> On Fri, Sep 22, 2023 at 06:31:44PM -0700, Suren Baghdasaryan wrote:
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index ec7f8e6c9e48..c1ebbd23fa61 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -542,6 +542,7 @@ struct anon_vma *folio_lock_anon_vma_read(struct fo=
lio *folio,
> >       struct anon_vma *root_anon_vma;
> >       unsigned long anon_mapping;
> >
> > +repeat:
> >       rcu_read_lock();
> >       anon_mapping =3D (unsigned long)READ_ONCE(folio->mapping);
> >       if ((anon_mapping & PAGE_MAPPING_FLAGS) !=3D PAGE_MAPPING_ANON)
> > @@ -586,6 +587,18 @@ struct anon_vma *folio_lock_anon_vma_read(struct f=
olio *folio,
> >       rcu_read_unlock();
> >       anon_vma_lock_read(anon_vma);
> >
> > +     /*
> > +      * Check if UFFDIO_REMAP changed the anon_vma. This is needed
> > +      * because we don't assume the folio was locked.
> > +      */
> > +     if (unlikely((unsigned long) READ_ONCE(folio->mapping) !=3D
> > +                  anon_mapping)) {
> > +             anon_vma_unlock_read(anon_vma);
> > +             put_anon_vma(anon_vma);
> > +             anon_vma =3D NULL;
> > +             goto repeat;
> > +     }
>
> We have an open-coded fast path above this:
>
>         if (down_read_trylock(&root_anon_vma->rwsem)) {
>                 /*
>                  * If the folio is still mapped, then this anon_vma is st=
ill
>                  * its anon_vma, and holding the mutex ensures that it wi=
ll
>                  * not go away, see anon_vma_free().
>                  */
>                 if (!folio_mapped(folio)) {
>                         up_read(&root_anon_vma->rwsem);
>                         anon_vma =3D NULL;
>                 }
>                 goto out;
>         }
>
> Would that also need such check?

Yes, I think they should be handled the same way. Will fix. Thanks!

>
> > +
> >       if (atomic_dec_and_test(&anon_vma->refcount)) {
> >               /*
> >                * Oops, we held the last refcount, release the lock
> > --
> > 2.42.0.515.g380fc7ccd1-goog
> >
>
> --
> Peter Xu
>

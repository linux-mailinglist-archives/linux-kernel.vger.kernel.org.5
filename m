Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934167FE4C3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 01:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343723AbjK3AVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 19:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjK3AVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 19:21:31 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086D21A3;
        Wed, 29 Nov 2023 16:21:38 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7b35d846f36so7132539f.0;
        Wed, 29 Nov 2023 16:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701303697; x=1701908497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sEYAfmnmUKDzXdKzmpSP1T6NxdrFel4xsutg1ntZcg=;
        b=nM/jMiOM/X7yEyya+qb4zJZ2Rc/yGKBWae5hbSJUOmxi66a2zB6oS6qtpAtRF1G+ek
         mfDaZXX3wwQpMWuj5tDUqAoeL1iGUvfkUUFd2s1fbGGiku7s7VIPX+nzJx95CWdxfgTE
         1uB5yG6eRhpQWnBo957cKAqCR59B8uFpfAWcRzIWPXSXSlk0D+JlafDTVvhKPizbTlMN
         gaxAQKgxHO5CJW4Ae8bhqJPHHOGuJfbz1rUpi/rd9qwRdm9qHSgT5OMMXCdhkOJLxOjH
         kceAbVvR/Ezt8HhTlUzlu1E/uNTWc1XmFNmOkLXGmH2P33u7BHXgIMYvSyuhGKQB+d+i
         k/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701303697; x=1701908497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sEYAfmnmUKDzXdKzmpSP1T6NxdrFel4xsutg1ntZcg=;
        b=E7ucRgCYIapB0OY5VCh/D4G+idueKTGU2U4HjJyT3GDnoYfiFpLERW644VXP2bE+kM
         hSGXMHG+CStLZMdhkKJPPZxVUn64Ot2SvqAyVMi01PTDgerpyhrAfyz21BxL9HNvHFr0
         LG4Mr7k2G4hQpdrtn8u30dDMaO6BvMdE751b/f+BojOq5q/ssO2TrlwAWRTc+tHTeE3r
         JDi9bCjoggAf3Iinv6k6k/IjRm5CCG5HfT38C0O1aToqIHF6LmlkHxX2CjAQLpRKEFNd
         +JsKEjjoncgPpnJvHq+q92xp/JA/9eviKrchXod+/GKFc7XYBv7zZnj8eHmdA5gMF13w
         /5/g==
X-Gm-Message-State: AOJu0YwOMmrnzTHMVhsZbXjzvqnLxdXr30sfgTqOL6S/kExFEt/9F/Qb
        JbUzYuFnkwwvIktNZmY/gyT1blqK+8LRazROnWA=
X-Google-Smtp-Source: AGHT+IFnjon5ckFouO3ILdmOgn+ew1aPuvqBrEyBZkvxwT6MjHsyijlRuwmCEMmG8avlJLyEGPgvzflmo9ozXUtwHyo=
X-Received: by 2002:a6b:e602:0:b0:79f:d04d:ce5a with SMTP id
 g2-20020a6be602000000b0079fd04dce5amr17455738ioh.2.1701303697230; Wed, 29 Nov
 2023 16:21:37 -0800 (PST)
MIME-Version: 1.0
References: <20231127234600.2971029-1-nphamcs@gmail.com> <20231127234600.2971029-4-nphamcs@gmail.com>
 <20231129151721.GC135852@cmpxchg.org>
In-Reply-To: <20231129151721.GC135852@cmpxchg.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 29 Nov 2023 16:21:26 -0800
Message-ID: <CAKEwX=M=iFGS6PQyF7FiV2JDhN0uLzSiJ3TK30nGiV1mM1wZ+A@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] zswap: make shrinking memcg-aware
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
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

On Wed, Nov 29, 2023 at 7:17=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Mon, Nov 27, 2023 at 03:45:57PM -0800, Nhat Pham wrote:
> >  static void shrink_worker(struct work_struct *w)
> >  {
> >       struct zswap_pool *pool =3D container_of(w, typeof(*pool),
> >                                               shrink_work);
> > +     struct mem_cgroup *memcg;
> >       int ret, failures =3D 0;
> >
> > +     /* global reclaim will select cgroup in a round-robin fashion. */
> >       do {
> > -             ret =3D zswap_reclaim_entry(pool);
> > -             if (ret) {
> > -                     zswap_reject_reclaim_fail++;
> > -                     if (ret !=3D -EAGAIN)
> > -                             break;
> > +             spin_lock(&zswap_pools_lock);
> > +             memcg =3D pool->next_shrink =3D
> > +                     mem_cgroup_iter_online(NULL, pool->next_shrink, N=
ULL, true);
> > +
> > +             /* full round trip */
> > +             if (!memcg) {
> > +                     spin_unlock(&zswap_pools_lock);
> >                       if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> >                               break;
> > +
> > +                     goto resched;
> >               }
> > +
> > +             /*
> > +              * Acquire an extra reference to the iterated memcg in ca=
se the
> > +              * original reference is dropped by the zswap offlining c=
allback.
> > +              */
> > +             css_get(&memcg->css);
>
> struct mem_cgroup isn't defined when !CONFIG_MEMCG. This needs a
> mem_cgroup_get() wrapper and a dummy function for no-memcg builds.

I got this exact same issue a couple of versions ago, but it was
hidden behind another helper function which can be implemented as a
no-op in the case of !CONFIG_MEMCG, so I forgot about it until now. It
always strikes me a bit weird that we have mem_cgroup_put() but not an
equivalent get - let me correct that.

>
> With that fixed, though, everything else looks good to me:
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks for the review, Johannes!

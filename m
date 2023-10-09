Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D647BE881
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376833AbjJIRmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjJIRmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:42:24 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C46494
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:42:22 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a7afd45199so4863477b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 10:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696873341; x=1697478141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cb0uZrY/3TILfAVALBuGEDwFiKHgMkaqJMCkS/04CB0=;
        b=4ifFbbafcNFvRuONQ0Ek7mXv7E+UzMVlmN0I9UlhvT0WKEPBI7wkgImwJYBkD19axl
         01tYwmwbPiPhfjuCYuDD4liYN20J0oRHOdB6Th0MCpTd2+V2K8/M8XdE4St6t800lLyl
         TMZR37bM9EPUgF9knV8iLoITp4GXOe/JubV52gjOULFdi4MkHjsMImawqd1mNc5A/K8d
         bAu+wNu/FH5MjVc07HyqvH9FnGC8/S8AyXq0uFWKsEMi+rl8tRVL9zDk7WqjEQJ7zVFm
         OmXxlS8/M3fw0s9ctRwgnmK2mw3+/dlbG9igbXywW1257CoX5ZD29/1BHyKe8L1OX+0b
         pYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696873341; x=1697478141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cb0uZrY/3TILfAVALBuGEDwFiKHgMkaqJMCkS/04CB0=;
        b=B1Rt5itKlogRbd3Z1JN9yca9e8ZUB8hIY9hEyXftv+ksBifoz3Yiitcy09j8CKEZAK
         q/o5az2dI2Sg4kSQ0VUGgV5hpOgW0AzHQUC5jRny/9QMVXqysZWEMk67AleN5LN1PvTD
         sfKUg9VSLiMimAPwcn8Y35Je+/YwCNwJlCuyeV/sdN02KWy3SXeGVa1k1Dz8JLRYSIw/
         NxSW+EI9DhLOqNyI4G0t8NNWLPmgpq5Hz0gV0Q3+XRz9rH5BpYb7W9sYutaLksnWZW/I
         agQbKtqvLIMLtUt4xLCNvvA8hlj3R5eW3MsLczi4TXnkKLLhBQ82V9FkQqkPevDfvMmr
         HDHQ==
X-Gm-Message-State: AOJu0YwC4sU+gXFp/6vi/aKlqdv6/oxBj1HFsxYsdF3M1OyimY9GYRCm
        clmBU05uwpr4spOPK40FGGDCrTQJFWcAgyJTQki8Bg==
X-Google-Smtp-Source: AGHT+IHMH3wuv6VHnU1LFK6j5ABUDadWUen6GvhH1X9fEE8784TzsZ7qLpN9Ols3i1rWVHoiWUoehTs/WUyECkmP1UU=
X-Received: by 2002:a25:d310:0:b0:d2c:32cb:c631 with SMTP id
 e16-20020a25d310000000b00d2c32cbc631mr14321282ybf.27.1696873341362; Mon, 09
 Oct 2023 10:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <ZSPayGSz6HQBp+3W@gmail.com> <202310092030430136422@zte.com.cn> <ZSP3cuEsgwWcIKRw@gmail.com>
In-Reply-To: <ZSP3cuEsgwWcIKRw@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 9 Oct 2023 10:42:08 -0700
Message-ID: <CAJuCfpFabCn8gcuLV322RKC=xzVm0C+64HQP+CkFNJZ4VO42ZA@mail.gmail.com>
Subject: Re: [PATCH linux-next 2/3] sched/psi: Avoid update triggers and
 rtpoll_total when it is unnecessary
To:     Ingo Molnar <mingo@kernel.org>
Cc:     yang.yang29@zte.com.cn, peterz@infradead.org, hannes@cmpxchg.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 5:52=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrote=
:
>
>
> * yang.yang29@zte.com.cn <yang.yang29@zte.com.cn> wrote:
>
> > From: Yang Yang <yang.yang29@zte.com.cn>
> >
> > When psimon wakes up and there are no state changes for rtpoll_states,
> > it's unnecessary to update triggers and rtpoll_total because the pressu=
res
> > being monitored by user had not changed. This will help to slightly red=
uce
> > unnecessary computations of psi.
> >
> > And update group->rtpoll_next_update after called update_triggers() and
> > update rtpoll_total. This will prevent bugs if update_triggers() uses
> > group->rtpoll_next_update in the future, and it makes more sense
> > to set the next update time after we finished the current update.
>
> >       if (now >=3D group->rtpoll_next_update) {
> > -             update_triggers(group, now, &update_total, PSI_POLL);
> > -             group->rtpoll_next_update =3D now + group->rtpoll_min_per=
iod;
> > -             if (update_total)
> > +             if (changed_states & group->rtpoll_states) {
> > +                     update_triggers(group, now, &update_total, PSI_PO=
LL);
> >                       memcpy(group->rtpoll_total, group->total[PSI_POLL=
],
> >                                  sizeof(group->rtpoll_total));
> > +             }
> > +             group->rtpoll_next_update =3D now + group->rtpoll_min_per=
iod;
>
> So please also split out the second change into a separate patch as well,
> as it's an unrelated patch to the state-change optimization.

I think that the second part could have been done in the first patch
to place the "group->rtpoll_next_update =3D now +
group->rtpoll_min_period" line at the right place from the beginning.
Also when posting the next version please add the version number to
all the patch titles in the patchset, not only to the cover letter.
That helps with finding the latest version.
Thanks!

>
> We have a "one conceptual change per patch" rule for most things.
>
> Thanks,
>
>         Ingo

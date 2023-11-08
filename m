Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA21C7E4F6F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 04:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjKHDVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 22:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKHDVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 22:21:20 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F77C83
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 19:21:18 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c503da4fd6so85322211fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 19:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1699413677; x=1700018477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YETPjkkEJ+eOL+x0rpdKFBs7s921JwD4CQwiOeV5Rjc=;
        b=OY/C68NP14S+ViGJLTMODIVZaiwt7OzShGtXBRf6npUL0/84eYeYK33Td4fymuNGSp
         83t3X5w/DxNST/A+ruIcrSUkC6f033ooUs14l+dkTQ20Q/yYRXMhRAEvz9dncIVBIvbS
         RsjMHkbai7qGjglk0oNBdVopIrUrgHJHN+SOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699413677; x=1700018477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YETPjkkEJ+eOL+x0rpdKFBs7s921JwD4CQwiOeV5Rjc=;
        b=BJuZmEn9Q7DA475tKAwApFvpf3nzqUr3qQBCRu+5VILqpdeigoEfOIV0JViybLc1SR
         knEBlWwEA845q4EZ5nnmXi0bH4fW7wuc7eQLEifaHKRomP4Lncv+AFK1XX9+EpM0iPWA
         fBZEPZoMCvlJUmn27+V+YQhkUj6xjR+jCkI+ZyTxGI6fvSwSkbMNa3dXryL7vSwX9Ljg
         PzTSNw1ywpR1+14WeInZQ59rRk39uu8L0zyM/yBv+4/6XjXTARhJ4UCLPkAX3yeQ2YMT
         238vj07ROW2OxIMR0Zro7+WcIUkfWagQjFN7nStzc64VyN/YswZOgXorjXk7zqqf+UYj
         flGw==
X-Gm-Message-State: AOJu0YyWdtFKYr6RROWpoken18EaAEI4cerVOf24w5T+j9KS0qpL0wzv
        eSkWUx1n3x8JDhimshuVGSQ205alJDGMzzeF2AXHYMe1hyBJO/z+OXU=
X-Google-Smtp-Source: AGHT+IFraHWDPSTWqrlFEBC0CjrTNjqsQ/1UEAm4GUSrEhF2sCCAWPLUzUxt9rB7hPZJGhJTkmKHF6/tTRoOY/uc5x8=
X-Received: by 2002:a2e:88cd:0:b0:2c5:2eaa:5397 with SMTP id
 a13-20020a2e88cd000000b002c52eaa5397mr596035ljk.11.1699413666538; Tue, 07 Nov
 2023 19:21:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699095159.git.bristot@kernel.org> <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
 <CAEXW_YS=PrWDx+YGVR7bmq0_SoKNztzGrreApCd9qk1yBLA5bA@mail.gmail.com>
 <CAEXW_YQ8kv3tXQJexLSguPuWi0bXiReKDyYNo9+A-Hgp=Zo1vA@mail.gmail.com>
 <CAEXW_YSjsZSrJK_RbGmbLNy4UrLCgu+7NPZjg-wiLuNbGOGr+w@mail.gmail.com>
 <20231107114732.5dd350ec@gandalf.local.home> <7d1ea71b-5218-4ee0-bc89-f02ee6bd5154@redhat.com>
 <3e58fad7-7f66-4e48-adcc-0fda9e9d0d07@kernel.org>
In-Reply-To: <3e58fad7-7f66-4e48-adcc-0fda9e9d0d07@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 7 Nov 2023 22:20:55 -0500
Message-ID: <CAEXW_YT-d4uNr4eyfXeCdUCmYu8LgYtMXTQVN=RXkjmxPz9d0g@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Tue, Nov 7, 2023 at 1:50=E2=80=AFPM Daniel Bristot de Oliveira
<bristot@kernel.org> wrote:
>
> > The code is not doing what I intended because I thought it was doing ov=
erload
> > control on the replenishment, but it is not (my bad).
> >
>
> I am still testing but... it is missing something like this (famous last =
words).
>
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 1092ca8892e0..6e2d21c47a04 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -842,6 +842,8 @@ static inline void setup_new_dl_entity(struct sched_d=
l_entity *dl_se)
>   * runtime, or it just underestimated it during sched_setattr().
>   */
>  static int start_dl_timer(struct sched_dl_entity *dl_se);
> +static bool dl_entity_overflow(struct sched_dl_entity *dl_se, u64 t);
> +
>  static void replenish_dl_entity(struct sched_dl_entity *dl_se)
>  {
>         struct dl_rq *dl_rq =3D dl_rq_of_se(dl_se);
> @@ -852,9 +854,18 @@ static void replenish_dl_entity(struct sched_dl_enti=
ty *dl_se)
>         /*
>          * This could be the case for a !-dl task that is boosted.
>          * Just go with full inherited parameters.
> +        *
> +        * Or, it could be the case of a zerolax reservation that
> +        * was not able to consume its runtime in background and
> +        * reached this point with current u > U.
> +        *
> +        * In both cases, set a new period.
>          */
> -       if (dl_se->dl_deadline =3D=3D 0)
> -               replenish_dl_new_period(dl_se, rq);
> +       if (dl_se->dl_deadline =3D=3D 0 ||
> +               (dl_se->dl_zerolax_armed && dl_entity_overflow(dl_se, rq_=
clock(rq)))) {
> +                       dl_se->deadline =3D rq_clock(rq) + pi_of(dl_se)->=
dl_deadline;
> +                       dl_se->runtime =3D pi_of(dl_se)->dl_runtime;
> +       }
>
>         if (dl_se->dl_yielded && dl_se->runtime > 0)
>                 dl_se->runtime =3D 0;

I was wondering does this mean GRUB needs to be enabled? Otherwise I
can see that "runtime / (deadline - t) > dl_runtime / dl_deadline"
will be true almost all the time due to the constraint of executing at
the 0-lax time.

Because at the 0-lax time, AFAICS this will be 100% > 30% (say if CFS
has a 30% reservation).

And I think even if GRUB is enabled, it is possible other DL task may
have reserved bandwidth.

Or is there a subtlety that makes that not possible?

thanks,

 - Joel

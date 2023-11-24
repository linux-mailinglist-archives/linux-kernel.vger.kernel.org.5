Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD75A7F6DD0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344795AbjKXIPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344572AbjKXIOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:14:55 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0912B10EC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:15:01 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c503dbe50dso19513851fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700813699; x=1701418499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oXYAGeXachCCe2/bIuP5OEv/Ub7oTlTCCZrnr5GJzY=;
        b=H2EPh4l5Irng4ffln7rTANrVyjn1TPTepjwmQrRqpFFoc9G8vwM9JnjaMUQPjZhWnS
         Jtv+9T7A0JCJTPFH1tXzI8VEpYl4OJgOqQFjoH8+4EiXG8/ohULopJ2IqC1UOcZ5AYdJ
         RwOQssp1b0KPG92lt8f4u/evcuaeJuBjgSjcH4Os26AXfTUKc3rp9cKHwohjYG8SbVgs
         5PI2WbR8NZfr6Ck4hkQ82jBYMfePQ441WNc+IdqeziL1lkw2ROZepxNxvdbPhucW/IOZ
         ukcLQQlqnFkXBUVewN7B2yupHw3GY3LyDcTDWYUNj0AJ/j/Xft8NJq828J6yxm19K4y6
         Cy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700813699; x=1701418499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6oXYAGeXachCCe2/bIuP5OEv/Ub7oTlTCCZrnr5GJzY=;
        b=VHvZT3WPJgOWzNixzNihCi3fkcm8/kzT7yV157HbIXvS0iBlT2YZ5tNVtH9iHmTTYK
         MDPiG70BNmYlz2RGrY+95XoQufPOfq6oxwt7xAapG5QhVzM0H8/cQXUP1NFU0kYktwNg
         If+FfKiSygPS/P7zx0COdgCPwvtC4cE7robAQNL5rcGOYIikVC2o0yxstTw3YRukq+XI
         6+diDaEFYZpiYDJIch53r1SS7TaB5TKzCiIUtUZc1Bqr/hRYlxW1klPvdIi04DCjlKgH
         lAGwX7ygyev8S8/bZeeElviXV7nEwawxSQxXdFQ1tmFnLafceFKO9E3eCx+CspSmMLXJ
         BD4g==
X-Gm-Message-State: AOJu0Yzd5FnlonIcuVFlnKPU+/qWPbvqu79WdMpqol9nWH0my+cQThk+
        66cA7Z2N+f5EvFve2ig3VdeElXhhkWpje0DPlSyv3T/4zKQ38A==
X-Google-Smtp-Source: AGHT+IFRMh+bKAjZCpJBgtB/uvXxgv0uD8dPXcIWu+uZcx/fWJ9STjrWR/3JOQ4bOsE/AYrcPq1JnUdVcqrQsbVwcP8=
X-Received: by 2002:a2e:97d8:0:b0:2c8:83c7:4046 with SMTP id
 m24-20020a2e97d8000000b002c883c74046mr1291556ljj.26.1700813698968; Fri, 24
 Nov 2023 00:14:58 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-5-ryncsn@gmail.com>
 <CAF8kJuNbcvwmojMB2Vp2LjTBxZtKFO_Zng4TODqADxmNPn2kCg@mail.gmail.com>
 <CAMgjq7D_OJiaNPWquFqxk5DKZXqoUMrD7Y_CRM7D0RnRnHmW7Q@mail.gmail.com>
 <CAF8kJuOzXAy8Er_knD0hi60Tb+XDMrijg-W83KD=Zdjqbu1Dmw@mail.gmail.com>
 <CAMgjq7DNVkyhwyXz9PRcp3XTBNvznZ97dOFFA_DGsJks12_pQw@mail.gmail.com> <CAF8kJuM05apUTd9Mpv6s4sZ6SfSAWD+hM_KLiDfatoXu5QwFbg@mail.gmail.com>
In-Reply-To: <CAF8kJuM05apUTd9Mpv6s4sZ6SfSAWD+hM_KLiDfatoXu5QwFbg@mail.gmail.com>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Fri, 24 Nov 2023 16:14:41 +0800
Message-ID: <CAMgjq7Bax-EOiXXDRxpHFoyrQWRQdSWbZ0KN7-W8YsocV5C97w@mail.gmail.com>
Subject: Re: [PATCH 04/24] mm/swap: avoid setting page lock bit and doing
 extra unlock check
To:     Chris Li <chrisl@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
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

Chris Li <chrisl@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8823=E6=97=A5=
=E5=91=A8=E5=9B=9B 04:57=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Kairui,
>
> On Wed, Nov 22, 2023 at 9:33=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
>
> > > There are two different charges. Memcg charging and memcg swapin char=
ging.
> > > The folio_put will do the memcg discharge, the corresponding memcg
> > > charge is in follio allocation.
> >
> > Hi Chris,
> >
> > I didn't get your idea here... By "memcg swapin charge", do you mean
> > "memory.swap.*"? And "memcg charging" means "memory.*"?. There is no
>
> Sorry I should have used the function name then there is no ambiguity.
> "memcg swapin charge" I mean function mem_cgroup_swapin_charge_folio().
> This function will look up the swap entry and find the memcg by swap entr=
y then
> charge to that memcg.
>
> > memcg charge related code in folio allocation (alloc_pages_mpol),
> > actually the mem_cgroup_swapin_charge_folio here is doing memcg charge
> > not memcg swapin charge. Swapin path actually need to uncharge
> > "memory.swap" by mem_cgroup_swapin_uncharge_swap in later part of this
> > function.
>
> I still think you have a bug there.
>
> Take this make up example:
> Let say the for loop runs 3 times and the 3rd time breaks out the for loo=
p.
> The original code will call:
> filemap_get_folio() 3 times
> folio_put() 2 times
> mem_cgroup_swapin_charge_folio() 1 time.
>
> With your patch, it will call:
> filemap_get_folio() 3 times
> folio_put() 2 times
> mem_cgroup_swapin_charge_folio() 3 times.
>
> Do you see the behavior difference there?

Hi Chris.

folio_put will discharge a page if it's charged, in original code the
2 folio_put call simply free the page since it's not charged. But in
this patch, folio_put will cancel previous
mem_cgroup_swapin_charge_folio call, so actually the 3
mem_cgroup_swapin_charge_folio calls will only charge once. (2 calls
was cancelled by folio_put).

I think this is making it confusing indeed and causing more trouble in
error path (the uncharge could be more expensive than unlock check),
will rework this part.

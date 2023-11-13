Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951CD7E9569
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 04:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjKMDVx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 12 Nov 2023 22:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjKMDVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 22:21:52 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA3D171A;
        Sun, 12 Nov 2023 19:21:49 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1ef9f1640a5so2521519fac.3;
        Sun, 12 Nov 2023 19:21:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699845705; x=1700450505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IXaHoWTH5TfdwPuBhxO14PPRkamm2oo7dJQsnN3xB4=;
        b=aGRNtMmrGgKtQ1gjHfWhbNPX0/mZ5DI5aR1vDVO3IDUJRafLuY6lVSGB1sLZIaPWdP
         JkpHXDe7YNcx96zY0okqgIwZDUdJg65OYfDI6kXpYh65Bv4HdSoAPpx07xM1LUjBEH7E
         s/tY8iOg0Ncf6WTsR9s16DSe6BrBNzGL/Z/S8+5n0pupuVbyU3VDew6dYkRBWoj3aOWU
         JwI945E13syjpUMoR8r5B9pU5QAr1TR87NyVgQg5uo47v1MBHXXmq1ZxiYqA40yS978e
         o6LlMykRr4pUesxnYC9VhXStCS4BxtauM48WQBW8b89yQ6fiqDIWFdCD/1PXsbrshdgP
         6rIA==
X-Gm-Message-State: AOJu0YxUgzFnlPbDskkZ9OUvRgl4ncNCxiduZcBdWYYjkGKfr8Ha1o3P
        PXqWJjemgLcgks3O6Dnhn0p6BakOhF5HG2LXtuM=
X-Google-Smtp-Source: AGHT+IEm0cqoDvrOkrZPoECzg54LBCYQyrtnHyH0Jyw/MEHgPLdqfdb+bCZuIioHUR/Jm8i15kxOz+UbC2lDC3gcglc=
X-Received: by 2002:a05:6870:c4b:b0:1db:70ee:efed with SMTP id
 lf11-20020a0568700c4b00b001db70eeefedmr7409499oab.18.1699845705545; Sun, 12
 Nov 2023 19:21:45 -0800 (PST)
MIME-Version: 1.0
References: <CAJvTdKn-xtmin9OjnzHg8wy4PM8Lc3Per=3y3UWORhjdroYP3w@mail.gmail.com>
 <CAHk-=wjvJ44a9Z=tkR2o-heQ4XLp0sgynDOhe6JH2fgg=MMMXA@mail.gmail.com>
 <CAJvTdK=OSTgYkut=-r95nAYOvVfUt3Cah92qudifeQW4ZJHT7Q@mail.gmail.com> <CAAYoRsXvKwhrw3gRQJ-STO48_7yxEiqwt5tgzDbkzA--N_XX6A@mail.gmail.com>
In-Reply-To: <CAAYoRsXvKwhrw3gRQJ-STO48_7yxEiqwt5tgzDbkzA--N_XX6A@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Sun, 12 Nov 2023 22:21:34 -0500
Message-ID: <CAJvTdKnqCOALF6k_PqFz75AGwFpoB41vv8fo1PxaEW71zdqcRA@mail.gmail.com>
Subject: Re: [GIT PULL] turbostat for Linux-6.7 (with signed tag)
To:     Doug Smythies <dsmythies@telus.net>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,
Thanks for the ping.
Yes, I look in patchwork for those assigned to me (looks like rafael
didn't assign those) and also for the word "turbostat".
My oversight that I didn't notice there were some in there -- will
catch in next batch.

thanks,
-Len

On Sun, Nov 12, 2023 at 10:51 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> On Fri, Nov 10, 2023 at 7:39 PM Len Brown <lenb@kernel.org> wrote:
> ...
> >
> > (Same code as previous pull request, with addition of a signed tag.
> >  Hopefully it verifies okay at your end.)
> >
> > Turbostat features are now table-driven (Rui Zhang)
> > Add support for some new platforms (Sumeet Pawnikar, Rui Zhang)
> > Gracefully run in configs when CPUs are limited (Rui Zhang, Srinivas Pandruvada)
> > misc minor fixes.
>
> Hi Len,
> What about the patches that have been submitted since your last turbostat update
> release of 2023.03.17? I submitted one on 2023.04.03. I haven't sent "RESEND"s,
> because I know you only do update releases every 1/2 year or so, and in the past
> you have always dealt with the interim patches then.
>
> Reference:
> https://patchwork.kernel.org/project/linux-pm/list/?series=&submitter=&state=&q=&archive=&delegate=107
>
> ... Doug
>
> >
> > thanks!
> > Len Brown, Intel Open Source Technology Center
> >
> ... [deleted]...



-- 
Len Brown, Intel

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22B8779CAE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 04:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbjHLCs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 22:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbjHLCs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 22:48:27 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA7730E7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 19:48:27 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-3493d0f785dso36265ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 19:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691808506; x=1692413306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxwplmLw+2JXkb5WdLZaW6GfeS9OxDdNZrnocn749ls=;
        b=PZ2MuncHZhfjcO+ZSWYBG7AjpER7iFNiyG2mAvkgdjnqDE404SW+LGIzxTRFgtG/rA
         Ze5AjzQ1Yy6pxjuG/liV8H0vsgWl6cL4Vuty19T8nqFCdlUudHH28vjS+kc8KHSgVRzF
         S/wsfc2ATtlf3lbb8xR8qx4UFCXH+nyFivMwVpobvy+pJO9hGHi7NKsPgm9yoPhoW+g5
         9ouYTGgP7V2H029wqXksIxTE8AoVWslw/7k9FdxPXjL7r9PBR87wzLF5hmNVuNueBkGL
         sq5YgWODSp05WxdnyzZ//RBLnSX+oNz2TaLLW5HKNsZ/qSosxxAeF3oSbrg8sY2jeIg+
         eRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691808506; x=1692413306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxwplmLw+2JXkb5WdLZaW6GfeS9OxDdNZrnocn749ls=;
        b=lcf3A/XyDDIuEVPoAr8G0i4UZ1Lukoj68MD5dlVMFGjAged+Z/cFAoXaC8eaKYoSzb
         RUNYt1fjtLRb+yhpkuzy/sRaUPs4MRneXuQKjC5DDRDFHLQFcBdEmuC5Bm+KMX9zto0g
         CBoZt946w/2VGIQvwKcgAGS6p6ocyd+HBGs2fz8YEWjwkcI2/uSC1jcf+ANF/mvztRTJ
         f0Bxzjn/SBkctF/HKlpiEozxrQ233BzIIFqhC14jqrphfsvEX/2QkK28aj8CeuKI7Ob1
         qOcrbBU7MvGNk25gVCzEAVRxQLIPdTuQmyTgHma1qVHiwhuOTmDnAJD99Ta5UkkG+LQu
         oFDw==
X-Gm-Message-State: AOJu0YzUGJeEna2Eh8uoR87Mq67sZ4Rf4HANLXjr09wKeaE092nVJ5rF
        eYq03JlXvGbZsxMOpfPvS0mVLuorM+9OGv/WWOFD/4DiNzbaJeoeaILITA==
X-Google-Smtp-Source: AGHT+IFnzx7aA6O7TSV89X1m1NxIeDXFyw3EhhedxkxdblAh5xXKf6r7j546dl/0kV6VsxKDAEpjRluabdZ7l7IKu8Y=
X-Received: by 2002:a05:6e02:1d9e:b0:349:413d:ab1f with SMTP id
 h30-20020a056e021d9e00b00349413dab1fmr394918ila.22.1691808506444; Fri, 11 Aug
 2023 19:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230809045810.1659356-1-yosryahmed@google.com>
 <ZNNTgZVPZipTL/UM@dhcp22.suse.cz> <CAJD7tkYhxbd2e+4HMZVKUfD4cx6oDauna3vLmttNPLCmFNtpgA@mail.gmail.com>
 <ZNONgeoytpkchHga@dhcp22.suse.cz> <CAJD7tkb9C77UUxAykw_uMQvkzGyaZOZhM0nwWn_kcPjV0umyuA@mail.gmail.com>
 <ZNOVS0Smp2PHUIuq@dhcp22.suse.cz> <CAJD7tkZFxbjas=VfhYSGU84Y5vyjuqHqGsRjiDEOSDWh2BxNAg@mail.gmail.com>
 <ZNYnx9NqwSsXKhX3@dhcp22.suse.cz> <CAJD7tkbJ1fnMDudtsS2xubKn0RTWz7t0Hem=PSRQQp3sGf-iOw@mail.gmail.com>
 <ZNaLGVUtPu7Ua/jL@dhcp22.suse.cz> <CAJD7tkbF1tNi8v0W4Mnqs0rzpRBshOFepxFTa1SiSvmBEBUEvw@mail.gmail.com>
 <CALvZod55S3XeK-MquTq0mDuipq8j0vFymQeX_XnPb_HuPK+oGQ@mail.gmail.com>
 <CAJD7tkYZxjAHrodVDK=wmz-sULJrq2VhC_5ecRP7T-KiaOcTuw@mail.gmail.com>
 <CALvZod46Cz_=5UgiyAKM+VgKyk=KJCqDqXu91=9uHy7-2wk53g@mail.gmail.com> <CAJD7tkY-ezyYebvcs=8Z_zrw2UVW8jf2WvP1G8tu2rT=2sMnAA@mail.gmail.com>
In-Reply-To: <CAJD7tkY-ezyYebvcs=8Z_zrw2UVW8jf2WvP1G8tu2rT=2sMnAA@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 11 Aug 2023 19:48:14 -0700
Message-ID: <CALvZod5fH9xu_+6x85K38f63GfKGWD1LqtD2R4d09xmDtLB7ew@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Fri, Aug 11, 2023 at 7:36=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Fri, Aug 11, 2023 at 7:29=E2=80=AFPM Shakeel Butt <shakeelb@google.com=
> wrote:
> >
> > On Fri, Aug 11, 2023 at 7:12=E2=80=AFPM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > [...]
> > >
> > > I am worried that writing to a stat for flushing then reading will
> > > increase the staleness window which we are trying to reduce here.
> > > Would it be acceptable to add a separate interface to explicitly read
> > > flushed stats without having to write first? If the distinction
> > > disappears in the future we can just short-circuit both interfaces.
> >
> > What is the acceptable staleness time window for your case? It is hard
> > to imagine that a write+read will always be worse than just a read.
> > Even the proposed patch can have an unintended and larger than
> > expected staleness window due to some processing on
> > return-to-userspace or some scheduling delay.
>
> Maybe I am worrying too much, we can just go for writing to
> memory.stat for explicit stats refresh.
>
> Do we still want to go with the mutex approach Michal suggested for
> do_flush_stats() to support either waiting for ongoing flushes
> (mutex_lock) or skipping (mutex_trylock)?

I would say keep that as a separate patch.

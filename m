Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC91080F968
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbjLLVcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjLLVcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:32:22 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FD0A7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:32:28 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a1f33c13ff2so530520766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702416747; x=1703021547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STJ8s+1ZgorKbcpwDfrOVd1KChXP1BeRsHF4DNQJ/gw=;
        b=hSMeK58c792RnmYoJ8J2F1F9xGI3KyC+D4HUfiUyNaCRh/lgkMyvpNNTc/Qls6Soni
         lgxPubAcVOoUijFpSyhto6Rr6bNxBwx826swYgSlJfhGIfwOq1yOPN4AHmCVrS0LoXln
         hI225BSygKIp7ITrmAAT5zIkfz/lHRA76duyP3cSHBfnsy8AXoX8eGTogEEfijUZ5rmK
         OJyOUC+/O0OKLpjG9y34epF4XnlX8yytLeciTUBGADI3kGePSTWdeEJZr2W+qIkJFj+d
         vA9y2GjnfuYDEr8sSqofxqgXlN25km2FaiYffPgjTc/HG9yqFJMye6+co4oT9p7Tbo1j
         8dxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702416747; x=1703021547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STJ8s+1ZgorKbcpwDfrOVd1KChXP1BeRsHF4DNQJ/gw=;
        b=Oa1sRSYh4HwWhmD6TKKdVf2DDCFfxJCrZkVYArZeqHOQM0mP//i5vV/6ljuigaF0bV
         l0m3gQz5DnlHcdMC69K/0/7dFtsyNUFR8xonnDFCRdYsuFM04qzNqvvLcz7ZeDHPwfyq
         fpss46fnAocut8FL6nrpnxFyuvjpUWORmO+ppaEhFuPxEAIBIXdj8CmMPbdhO4WyTVCn
         eByMFn6DOwZRhVdstdyiyK4M1bwNfuKfDZ2L0/UnW86OMLMqCux+0KHVdRZXZnDAecJl
         pXfRubgIA+rdn1nCyHdcKNbEsqFaxmaJChV1cTHlpXSrEMnS4jaPCdX0rSCcG23brYIU
         8zcA==
X-Gm-Message-State: AOJu0YxFNRoWZ4WoZcbFprLd2DPoUcTvHWa4GBOfLh/vVwOpSaFlc3dy
        SVRk3BMTO/TiiV4kweZIpXN+bUqTrEb4KssD0zHffQ==
X-Google-Smtp-Source: AGHT+IH0fVR2m3wicfc1ELe6nAiJDzi+m6wO1H72mGA0fKcCQZvoNdz/jyd5VQOICC3W8TgaUHAOGDtzkrg1CHbJ1SM=
X-Received: by 2002:a17:906:f112:b0:9e5:2c35:50e9 with SMTP id
 gv18-20020a170906f11200b009e52c3550e9mr2896390ejb.77.1702416746431; Tue, 12
 Dec 2023 13:32:26 -0800 (PST)
MIME-Version: 1.0
References: <20231211140419.1298178-1-schatzberg.dan@gmail.com>
 <20231211140419.1298178-2-schatzberg.dan@gmail.com> <CAJD7tkZQ2aakT8M2bTg0bp4sDtrGYv_4i4Z4z3KBerfxZ9qFWA@mail.gmail.com>
 <ZXjQLXJViHX7kMnV@dschatzberg-fedora-PF3DHTBV>
In-Reply-To: <ZXjQLXJViHX7kMnV@dschatzberg-fedora-PF3DHTBV>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 12 Dec 2023 13:31:46 -0800
Message-ID: <CAJD7tkY6iTxKe4Nj00sN3vh26Cw2Sw+kTkY40r000+ttN-dFpg@mail.gmail.com>
Subject: Re: [PATCH V3 1/1] mm: add swapiness= arg to memory.reclaim
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Huan Yang <link@vivo.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chris Li <chrisl@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 1:27=E2=80=AFPM Dan Schatzberg <schatzberg.dan@gmai=
l.com> wrote:
>
> On Mon, Dec 11, 2023 at 11:41:24AM -0800, Yosry Ahmed wrote:
> > On Mon, Dec 11, 2023 at 6:04=E2=80=AFAM Dan Schatzberg <schatzberg.dan@=
gmail.com> wrote:
> >
> > contains* the*
> >
> > I think this statement was only important because no keys were
> > supported, so I think we can remove it completely and rely on
> > documenting the supported keys below like other interfaces, see my
> > next comment.
> >
> > > +       to reclaim.
> > >
> > >         Example::
> > >
> > > @@ -1304,6 +1304,17 @@ PAGE_SIZE multiple when read back.
> > >         This means that the networking layer will not adapt based on
> > >         reclaim induced by memory.reclaim.
> > >
> > > +       This file also allows the user to specify the swappiness valu=
e
> > > +       to be used for the reclaim. For example:
> > > +
> > > +         echo "1G swappiness=3D60" > memory.reclaim
> > > +
> > > +       The above instructs the kernel to perform the reclaim with
> > > +       a swappiness value of 60. Note that this has the same semanti=
cs
> > > +       as the vm.swappiness sysctl - it sets the relative IO cost of
> > > +       reclaiming anon vs file memory but does not allow for reclaim=
ing
> > > +       specific amounts of anon or file memory.
> > > +
> >
> > Can we instead follow the same format used by other nested-keyed files
> > (e.g. io.max)? This usually involves a table of supported keys and
> > such.
>
> Thanks, both are good suggestions. Will address these.
>
> > > +       while ((start =3D strsep(&buf, " ")) !=3D NULL) {
> > > +               if (!strlen(start))
> > > +                       continue;
> > > +               switch (match_token(start, if_tokens, args)) {
> > > +               case MEMORY_RECLAIM_SWAPPINESS:
> > > +                       if (match_int(&args[0], &swappiness))
> > > +                               return -EINVAL;
> > > +                       if (swappiness < 0 || swappiness > 200)
> >
> > I am not a fan of extending the hardcoded 0 and 200 values, and now
> > the new -1 value. Maybe it's time to create constants for the min and
> > max swappiness values instead of hardcoding them everywhere? This can
> > be a separate preparatory patch. Then, -1 (or any invalid value) can
> > also be added as a constant with a useful name, instead of passing -1
> > to all other callers.
> >
> > This should make the code a little bit more readable and easier to exte=
nd.
>
> I'm not sure I understand the concern. This check just validates that
> the swappiness value inputted is between 0 and 200 (inclusive)
> otherwise the interface returns -EINVAL. Are you just concerned that
> these constants are not named explicitly so they can be reused
> elsewhere in the code?

Yes. The 0 and 200 values are already hardcoded in multiple places,
and we are adding more places now and more hardcoded values (i.e. -1).

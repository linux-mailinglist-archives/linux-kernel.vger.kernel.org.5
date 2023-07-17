Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31AD75614B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjGQLMh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 07:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGQLMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:12:33 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CD61B9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:12:32 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-ca3cc52ee62so4448210276.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689592351; x=1692184351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5M3eKlOLXU3pQ7+5774W6+fwrz4LECOlXFjGVOciNs=;
        b=ZclCCTf7gGY6mLfdIzeO/IzHlVDJQK/Zc9JT5zS3wLeOdqdrWSUySb5cE3W8u6olU1
         wLPfpmN375obBMuw/iOnTGtEbXDwd4R14AdubLIqYunhuJRgRx1XhHL4eI2KT3jrmySE
         BlLio5d5ucPGukyZV3NxXDL2Ae/u1iqQuqgTzqvF6jFecSCgMBj5lftivdp5xu+ks5ya
         OXwA89MbTwEFKe4cKYr1nD92Fx4+S5olzVeMBDzKZ7Gw4kHwB9sZdTpx9uJ7K+uuaXsV
         EzskzPGCKWktvc+gHQpocCON2O+LOXHXAGcV643qS4JtOp9MNIGN5B8CkiYJKwRpDDje
         Z/Gw==
X-Gm-Message-State: ABy/qLZkA5qOc+nR9JfQ5GTaRDJRrl8ZIphnFcdijiMhK0F+u1305kEU
        04u6qLzrO+6VMA4g1OW16vgWUdmcZhJbHw==
X-Google-Smtp-Source: APBJJlGSztBpHEV6fjwu3g6gE95WDUqAd9FYjHeJDgiXc39pQLTCOHtcJwx5Z1Hs6szEbwTToNzeQA==
X-Received: by 2002:a25:aba2:0:b0:bad:125f:9156 with SMTP id v31-20020a25aba2000000b00bad125f9156mr11889592ybi.35.1689592351471;
        Mon, 17 Jul 2023 04:12:31 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id g4-20020a05690203c400b00bc7c81c3cecsm2849910ybs.14.2023.07.17.04.12.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 04:12:31 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-57764a6bf8cso44226547b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:12:31 -0700 (PDT)
X-Received: by 2002:a81:5a8b:0:b0:57a:8de8:ef46 with SMTP id
 o133-20020a815a8b000000b0057a8de8ef46mr13079737ywb.39.1689592350801; Mon, 17
 Jul 2023 04:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAMw=ZnSmZTBs+bJsQ_Y2CVO8K3OTuHOZDKW4cbxKpGbo4Vgs7Q@mail.gmail.com>
 <2023071226-crafty-deviator-12e2@gregkh> <CAMw=ZnRjnxWnmoFuw2prxFS55vAGQ1hpfKeHYFfG5Oa0LB_jYA@mail.gmail.com>
 <2023071233-empirical-overturn-744c@gregkh> <CAMw=ZnRRviBNi_LK9VOSUV9PNHe3jurUcLfgLpbTOsp_eE4WyA@mail.gmail.com>
 <2023071350-specked-botanist-6ba8@gregkh> <CAMw=ZnQZ9ds3xsa2AZv_F13dB6rR4XzGPrBjJHSga1oU5xRezQ@mail.gmail.com>
 <2023071552-quilt-tranquil-b7bf@gregkh> <CAMw=ZnROWgDOiAr1iikTWa7Qm81HoE17NuEdLt8hwGnkKSnoCg@mail.gmail.com>
 <2023071643-broiler-level-afbf@gregkh> <ZLUIViihakhyPV1N@redhat.com>
In-Reply-To: <ZLUIViihakhyPV1N@redhat.com>
From:   Luca Boccassi <bluca@debian.org>
Date:   Mon, 17 Jul 2023 12:12:18 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnTOgGcQ70E57H1GEr9yZVG-FVHZZ69JYMFqvsO9mgxdDg@mail.gmail.com>
Message-ID: <CAMw=ZnTOgGcQ70E57H1GEr9yZVG-FVHZZ69JYMFqvsO9mgxdDg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
To:     =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, lennart@poettering.net,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 at 10:23, Daniel P. Berrangé <berrange@redhat.com> wrote:
>
> On Sun, Jul 16, 2023 at 08:28:10PM +0200, Greg KH wrote:
> > On Sun, Jul 16, 2023 at 06:41:04PM +0100, Luca Boccassi wrote:
> > > On Sat, 15 Jul 2023 at 07:52, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > If you are not willing to take the time to determine how this proposed
> > > > change will affect the kernel developers and infrastructure by doing
> > > > some modeling based on our past history, then we have no reason to even
> > > > consider accepting this change as you are stating that you have no idea
> > > > how it will affect us.
> > >
> > > There's no need for that to tell you how this will affect you: it will
> > > not. Every now and then you'll receive a one-liner patch to apply.
> > > What's so terrible about that?
>
> I think that's not entirely accurate, as this *will* have an impact on
> anyone involved in backporting fixes for the kernel stable trees, when
> they need to resolve conflicts on the SBAT file. It shouldn't have a
> big impact, but we should be honest that it will be a non-zero impact.
>
> Lets say mainline branch has had 2 security vulnerabilities A and B,
> each of which was associated with an increment of the SBAT version
> number. The first flaw A changed SBAT from 7 to 8,and then the second
> flaw B changed SBAT from 8 to 9.
>
> If someone wants to backport the fix for bug "B" they will get a
> conflict on the SBAT file when cherry-picking the patch. When that
> happens they must decide:
>
>   * It is acceptable to ignore issue A, because it didn't affect
>     that branch. The conflict is resolved by having the backported
>     patch increase SBAT version from 7 to 9 directly.
>
>   * It is required to first backport issue A, because that also
>     affects that branch. The conflict is resolved by first backporting
>     the code fix & SBAT change for A, and then backporting the code
>     fix and SBAT change for B. SBAT changes from 7 to 8 to 9 just
>     like on master.
>
> IOW whomever is doing backport patches for stable needs to understand
> the semantics of SBAT and how to resolve conflicts on it. If they get
> this wrong, then it breaks the protection offered by SBAT, which would
> then require a 3rd SBAT change to fix the mistake.
>
> This likely means that stable tree maintainers themselves need to
> understand the SBAT change rules, so they can review conflict resolution
> for any proposed changes, to sanity check what is being proposed.

This can be solved by just not changing the generation id in the same
patch that fixes a bug, but as the last step in a series, which
doesn't add the cc: stable nor the other tags. If we want to bump the
generation id in a stable branch, we'll then have to send an
appropriately crafted patch targeted at the right place. That way even
if the fixes get backported, there is no additional burden on any
kernel maintainer.

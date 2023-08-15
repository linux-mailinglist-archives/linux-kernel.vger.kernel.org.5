Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA21377D019
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbjHOQ1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238443AbjHOQ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:26:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED56410E0;
        Tue, 15 Aug 2023 09:26:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BB5765BDD;
        Tue, 15 Aug 2023 16:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD9CC433C8;
        Tue, 15 Aug 2023 16:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692116800;
        bh=m5LH//dTNqZX2XqTcfZFxJBA1o3a7fGIZvj4YOCtVvo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SA8cSYZgvFUrwLFqXSZBO70j7jXXxTNAwRb2Vz7W42IW+YNPlhYiRZxHBwfQhJbfe
         bPDyqQPnRdbVJeU+eW5ZZ+mJuqtfIFPaADNKVQgYmEV6k7U/Xx+eKDapa0SGxhYLgH
         P2DgHc5FbyhTSXmMIHTVnH41BAgldJAW8F4RBgoKtkLBgXXGCTG1vguCOTcszPl+7C
         dIzh53BnEdJ5AhIuujWTqOlA6BGghXacOEr7A00njJVAJ0aVxgpEmrvW93YIpJ9UXh
         HaEoEOd7hvOPl0M/ZC1bJ2echeiUmZRemOpsNkdZGQYi1QAqPDWc35UHSrs/B+y/ta
         i+wyuksiwVzBA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2b9cf2b1309so65328951fa.0;
        Tue, 15 Aug 2023 09:26:40 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw0DwHfUg8UdoV5o7SCM10gqAA4Y9RitTeGZJ3ukxbAap6cLGcl
        zTmsNHujgJqX0mrqX5DavOuR5bjhwOjO0ynt0vo=
X-Google-Smtp-Source: AGHT+IHRxXncn2Rfe0JZo7xFbxGA0aclyCi/KEx+qg0KxgNeMtqU6KN30mTri9iYKlFPM2r9NQc1ubofSkn+b0XKQe4=
X-Received: by 2002:a2e:80d7:0:b0:2b6:d0c1:7cd0 with SMTP id
 r23-20020a2e80d7000000b002b6d0c17cd0mr785695ljg.22.1692116798820; Tue, 15 Aug
 2023 09:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230815091931.4dd2b277@canb.auug.org.au> <8c946512-0cc4-fbc5-ca36-0e2c6d636eb2@huaweicloud.com>
 <c39a3bff-01b9-4007-80ac-00ce2b11a902@kernel.dk> <CAPhsuW7ck4Bb8NVUdgZZJqzNCYMgT9rspKshr2Zi=8xo2cQLaw@mail.gmail.com>
 <48f834c2-b283-4b02-9407-4a0842d4ed72@kernel.dk> <CAPhsuW4YNWksHgTZGzX8Rj1+gU-aqQjiYueNRNHPryxOk2WXqQ@mail.gmail.com>
 <a30e4e08-7b8c-498c-b8af-82262b3ec6ff@kernel.dk>
In-Reply-To: <a30e4e08-7b8c-498c-b8af-82262b3ec6ff@kernel.dk>
From:   Song Liu <song@kernel.org>
Date:   Wed, 16 Aug 2023 00:26:25 +0800
X-Gmail-Original-Message-ID: <CAPhsuW5AHQkf6wO_4Z6VFbTCxNN9GchW_ZPxmC1vtc23ByPc6g@mail.gmail.com>
Message-ID: <CAPhsuW5AHQkf6wO_4Z6VFbTCxNN9GchW_ZPxmC1vtc23ByPc6g@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the block tree
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 12:20=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 8/15/23 10:17 AM, Song Liu wrote:
> > On Wed, Aug 16, 2023 at 12:07?AM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 8/15/23 9:58 AM, Song Liu wrote:
> >>> On Tue, Aug 15, 2023 at 11:08?PM Jens Axboe <axboe@kernel.dk> wrote:
> >>>>
> >>>> On 8/14/23 9:21 PM, Yu Kuai wrote:
> >>>>> Hi,
> >>>>>
> >>>>> ? 2023/08/15 7:19, Stephen Rothwell ??:
> >>>>>> Hi all,
> >>>>>>
> >>>>>> In commit
> >>>>>>
> >>>>>>    71070e7bd25d ("md/raid10: fix a 'conf->barrier' leakage in raid=
10_takeover()")
> >>>>>>
> >>>>>> Fixes tag
> >>>>>>
> >>>>>>    Fixes: 4d27e927344a ("md: don't quiesce in mddev_suspend()")
> >>>>>>
> >>>>>> has these problem(s):
> >>>>>>
> >>>>>>    - Target SHA1 does not exist
> >>>>>
> >>>>> Sorry about this, the commit was picked from previous md-next branc=
h,
> >>>>> and I didn't know that it will change...
> >>>>
> >>>> It's most likely not your fault, I'm guessing Song rebased that bran=
ch
> >>>> and this is why the sha changed. Song?
> >>>
> >>> Yeah, it is my fault. I am really sorry for this issue.
> >>>
> >>>>
> >>>>> Is there any way that I can fix this ?
> >>>>
> >>>> Only way to fix this is if I rewind my branch and Song updates his
> >>>> branch to not have this issue, and then sends a new pull request.
> >>>
> >>> Yes please. Let's fix this.
> >>
> >> Please send a new one, I've dropped the old one.
> >
> > Is this the for-6.6/block branch? I haven't seen the change yet. The to=
p
> > commit on the branch (as I see) is
> >
> > 306d74055754 ("ublk: Switch to memdup_user_nul() helper")
>
> Where are you looking? It's at:

I am looking at

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git

It appears to be some lag from git server?

Thanks,
Song

>
> commit 66a6a5d0ec852eaced589da066376e69397cd71e (origin/for-6.6/block, fo=
r-6.6/block)
> Author: Ruan Jinjie <ruanjinjie@huawei.com>
> Date:   Tue Aug 15 19:48:14 2023 +0800
>
>     ublk: Switch to memdup_user_nul() helper
>
> since about 15 min ago.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEF477CFC7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbjHOP7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238421AbjHOP7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:59:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD7FA6;
        Tue, 15 Aug 2023 08:59:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6486B65D29;
        Tue, 15 Aug 2023 15:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEAAC433C8;
        Tue, 15 Aug 2023 15:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692115140;
        bh=1Y7nNKZoL5vZuqjM0T2oWip7nSAhTkaDfQ7znTgkl4Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LCjHKL+tEBN6FM35elPyd2K45ondYQPrFaaELtlD9wQHte1DjFSkLsjvGXZVvTU7Z
         Rul9l7e3MzkMK7gz3KbwXiaNcOifdzkwGW5l5GVUlZwonjxKKpS6oyQeNM7gURJsEd
         wtAiZ/0Dv8Zvujhh+0+ZqtreQQ2nFf/n4lqR3HyT7d6nbEwJgWQN4BGRUi24o0bVFI
         zhFTyt+ZOzzJpLEh0TZjJ6TXpNZ2Nfp68X5k0u/6e+mALzz9MdByL3vmSqUbSDo3Xg
         QHIWRYkBainHgkHGMgZiyUi3KnKRnpXYd2LqLgQVLUXLxQxODTYJA2W1YVASJJD6is
         rIrWep7jk2W5w==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4fe389d6f19so8747455e87.3;
        Tue, 15 Aug 2023 08:59:00 -0700 (PDT)
X-Gm-Message-State: AOJu0YwHd4Ri4K+CA54tlMIGQbeix4OQ8DNjNogynMqifUVNb8KaXh3E
        5LOlFlXjHB6g8Lg1kx0kMto4pmYinCaFDcXVTgw=
X-Google-Smtp-Source: AGHT+IFzJgtFEftmVwno8Fv0kJrkjgAY4IZdyQru+3V2xxVzSAPdLi+BACqxEBt89UjbBC7lBsi1pHFnvmeP2Mpj6pg=
X-Received: by 2002:ac2:4d91:0:b0:4fe:8ba9:4c7 with SMTP id
 g17-20020ac24d91000000b004fe8ba904c7mr7884917lfe.26.1692115138833; Tue, 15
 Aug 2023 08:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230815091931.4dd2b277@canb.auug.org.au> <8c946512-0cc4-fbc5-ca36-0e2c6d636eb2@huaweicloud.com>
 <c39a3bff-01b9-4007-80ac-00ce2b11a902@kernel.dk>
In-Reply-To: <c39a3bff-01b9-4007-80ac-00ce2b11a902@kernel.dk>
From:   Song Liu <song@kernel.org>
Date:   Tue, 15 Aug 2023 23:58:45 +0800
X-Gmail-Original-Message-ID: <CAPhsuW7ck4Bb8NVUdgZZJqzNCYMgT9rspKshr2Zi=8xo2cQLaw@mail.gmail.com>
Message-ID: <CAPhsuW7ck4Bb8NVUdgZZJqzNCYMgT9rspKshr2Zi=8xo2cQLaw@mail.gmail.com>
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

On Tue, Aug 15, 2023 at 11:08=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 8/14/23 9:21 PM, Yu Kuai wrote:
> > Hi,
> >
> > ? 2023/08/15 7:19, Stephen Rothwell ??:
> >> Hi all,
> >>
> >> In commit
> >>
> >>    71070e7bd25d ("md/raid10: fix a 'conf->barrier' leakage in raid10_t=
akeover()")
> >>
> >> Fixes tag
> >>
> >>    Fixes: 4d27e927344a ("md: don't quiesce in mddev_suspend()")
> >>
> >> has these problem(s):
> >>
> >>    - Target SHA1 does not exist
> >
> > Sorry about this, the commit was picked from previous md-next branch,
> > and I didn't know that it will change...
>
> It's most likely not your fault, I'm guessing Song rebased that branch
> and this is why the sha changed. Song?

Yeah, it is my fault. I am really sorry for this issue.

>
> > Is there any way that I can fix this ?
>
> Only way to fix this is if I rewind my branch and Song updates his
> branch to not have this issue, and then sends a new pull request.

Yes please. Let's fix this.

Song

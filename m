Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5125B77D004
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjHOQRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238510AbjHOQRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:17:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF5510FF;
        Tue, 15 Aug 2023 09:17:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A02F763623;
        Tue, 15 Aug 2023 16:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B567C433CA;
        Tue, 15 Aug 2023 16:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692116250;
        bh=GJXhOxTLVC2pcbScX6mfprqGw84nW3G86vknwi41jo8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Cpw+gwOYLNsi4QpcFnwyqjCH26xhX0Hl5k1pGttX61FCOXGrEdLCL5csJknp/14v3
         wYf3LJtzf4anRPzstWm1pZthixbfTQE0SO8Zoi1qqfajf7QGtU8oV4Bnb7VsXWBlSo
         u+3llvCOWahvSldt6IKTAnmQ6dQLsTm9xLISY4XbC8zGw53nsWFaJSs9Mfu6/P4Ah3
         KLlOmoHaAQ/OuWWIXzcg/7NxofXLKpVcIOmIEKRsGXvIwQFnk3osjhj8rF+bZHWevI
         NjDHDoep9GrzLAdVmbq4RefkWXxJM+6BKKOCu9XoDy+XwghYHyO+EqA0DOR3JXtD25
         fNnnmZr+pYvoA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4fe0eb0ca75so8351986e87.2;
        Tue, 15 Aug 2023 09:17:29 -0700 (PDT)
X-Gm-Message-State: AOJu0YwnYMQqN01WEocBWu+pt/2ilq5wourFscUgStHriOt5RNy/f45f
        MMVaX6H63KYCYE8bFMY0Vt8z/4SLLzmstIfQeXY=
X-Google-Smtp-Source: AGHT+IFAN8fCvLU1je2c5LvUa+6QYsdOh2vE0bLXOUw+dBC6cLXKkFvXkfB+PTTDOAcfCKPec1981ivpXkrq1b4r5uM=
X-Received: by 2002:a05:6512:692:b0:4f8:5cde:a44f with SMTP id
 t18-20020a056512069200b004f85cdea44fmr11778345lfe.10.1692116248032; Tue, 15
 Aug 2023 09:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230815091931.4dd2b277@canb.auug.org.au> <8c946512-0cc4-fbc5-ca36-0e2c6d636eb2@huaweicloud.com>
 <c39a3bff-01b9-4007-80ac-00ce2b11a902@kernel.dk> <CAPhsuW7ck4Bb8NVUdgZZJqzNCYMgT9rspKshr2Zi=8xo2cQLaw@mail.gmail.com>
 <48f834c2-b283-4b02-9407-4a0842d4ed72@kernel.dk>
In-Reply-To: <48f834c2-b283-4b02-9407-4a0842d4ed72@kernel.dk>
From:   Song Liu <song@kernel.org>
Date:   Wed, 16 Aug 2023 00:17:14 +0800
X-Gmail-Original-Message-ID: <CAPhsuW4YNWksHgTZGzX8Rj1+gU-aqQjiYueNRNHPryxOk2WXqQ@mail.gmail.com>
Message-ID: <CAPhsuW4YNWksHgTZGzX8Rj1+gU-aqQjiYueNRNHPryxOk2WXqQ@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the block tree
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 12:07=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 8/15/23 9:58 AM, Song Liu wrote:
> > On Tue, Aug 15, 2023 at 11:08?PM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 8/14/23 9:21 PM, Yu Kuai wrote:
> >>> Hi,
> >>>
> >>> ? 2023/08/15 7:19, Stephen Rothwell ??:
> >>>> Hi all,
> >>>>
> >>>> In commit
> >>>>
> >>>>    71070e7bd25d ("md/raid10: fix a 'conf->barrier' leakage in raid10=
_takeover()")
> >>>>
> >>>> Fixes tag
> >>>>
> >>>>    Fixes: 4d27e927344a ("md: don't quiesce in mddev_suspend()")
> >>>>
> >>>> has these problem(s):
> >>>>
> >>>>    - Target SHA1 does not exist
> >>>
> >>> Sorry about this, the commit was picked from previous md-next branch,
> >>> and I didn't know that it will change...
> >>
> >> It's most likely not your fault, I'm guessing Song rebased that branch
> >> and this is why the sha changed. Song?
> >
> > Yeah, it is my fault. I am really sorry for this issue.
> >
> >>
> >>> Is there any way that I can fix this ?
> >>
> >> Only way to fix this is if I rewind my branch and Song updates his
> >> branch to not have this issue, and then sends a new pull request.
> >
> > Yes please. Let's fix this.
>
> Please send a new one, I've dropped the old one.

Is this the for-6.6/block branch? I haven't seen the change yet. The top
commit on the branch (as I see) is

306d74055754 ("ublk: Switch to memdup_user_nul() helper")

Thanks,
Song

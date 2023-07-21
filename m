Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F34375C113
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjGUIPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjGUIPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:15:33 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DE4270A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:15:31 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-263121cd04eso894248a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689927331; x=1690532131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pd2HhKZxSyoZydvli66d5N9UqG8GWNvUPymvOuFu+BY=;
        b=WrqNWxA6ozYcj57TebNYbv3CyPO4HiaeGg8dhFmCNz2fu3TAP3T7amvGX2pGp3cOZk
         0mv7FhbktJWEcOEpBX8bx85ELIypT5ZslXmYriWWqWV/DK3thkXFHcupNZL7CCnEtGh2
         0b5BrMeVMnT8MhHGYtLLTW2LyuvDpptlTQ6hOCRJYaiH7MbaOt0wu3Ty8M5gT+4BxJ15
         OmysFFZhihSq/aQQVdCiBHAa0gWsvdQetNvzA+1eekZ8tJsU7kKoj6Fu2OJXFnTtY6s+
         E8pkbfOrvGplHvCVGaQe4RVURpfq9qeyCDvpQgQIMtAFE2vIDspDQ3j2B8ydhek++41s
         3/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689927331; x=1690532131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pd2HhKZxSyoZydvli66d5N9UqG8GWNvUPymvOuFu+BY=;
        b=bqe/RWNu71v3o/pVwkdv8HWx0seCPLp/MxKH6foUDsIWesO/Mdkc7flkZ1aFa/vQ/Z
         SbNu0Bb/rAwMBQ1V+Gv2B1TPWPWRXbe+aFT+OXQyb8Q6wHtluW3HEDuuj0ujAo1eKSZy
         s+tOgLhC2w7J2j6L5MUhj/Y20l7LOtP6pusd2LtciPq88SAHQ32JeODuJPMhz6qXNi69
         xsSYs24HDIW3YdAlqtt6XLWF+zMSkcSUxrypoD5uooQx3hATeiAnPjVuM5LBr2oldSLI
         9KH63zJcpdR6AVtqJGLhlU0z1ASiqElptB9BZPiPp0oe1h8Np/Z9WdzZgt7b5FK+drTA
         w2Eg==
X-Gm-Message-State: ABy/qLbtcmWwzF8BMtghecZzdLp+BdditvIhQY+FGFcvzBZEd80UJnPh
        mb4Sanjr59nYGp2IPl/Kq8LB2sRnyE2hnFCza+Q=
X-Google-Smtp-Source: APBJJlG1rDRObtkpxXKFgC+LcsERPI9sM+v6zog7x9RE1PuPwGG6oQ1tTBurwjrnhgRoza+RywP8Zc9+I4RW4uZoTb8=
X-Received: by 2002:a17:90a:d711:b0:263:5c78:4b63 with SMTP id
 y17-20020a17090ad71100b002635c784b63mr779192pju.45.1689927330568; Fri, 21 Jul
 2023 01:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230515095956.17898-1-zyytlz.wz@163.com> <kyzmstq5dodvgpmd7rge3gtdikbbpauw6fide7vccgii4xtb6n@bwrwjsx4ylmx>
In-Reply-To: <kyzmstq5dodvgpmd7rge3gtdikbbpauw6fide7vccgii4xtb6n@bwrwjsx4ylmx>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 21 Jul 2023 16:15:19 +0800
Message-ID: <CAJedcCzmx02bfa22QezE8mu-iDsSdSy_oApT2ozCWO8O-8MJEQ@mail.gmail.com>
Subject: Re: [PATCH] fs/jfs: Add a mutex named txEnd_lmLogClose_mutex to
 prevent a race condition between txEnd and lmLogClose functions
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, shaggy@kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michal,


Michal Koutn=C3=BD <mkoutny@suse.com> =E4=BA=8E2023=E5=B9=B47=E6=9C=8820=E6=
=97=A5=E5=91=A8=E5=9B=9B 17:56=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello Zheng.
>
> On Mon, May 15, 2023 at 05:59:56PM +0800, Zheng Wang <zyytlz.wz@163.com> =
wrote:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-use-after-free in instrument_atomic_write include/linu=
x/instrumented.h:87 [inline]
> > BUG: KASAN: slab-use-after-free in clear_bit include/asm-generic/bitops=
/instrumented-atomic.h:41 [inline]
> > BUG: KASAN: slab-use-after-free in txEnd+0x2a3/0x5a0 fs/jfs/jfs_txnmgr.=
c:535
> > Write of size 8 at addr ffff888021bee840 by task jfsCommit/130
> >
> > CPU: 3 PID: 130 Comm: jfsCommit Not tainted 6.3.0-rc7-pasta #1
>
> Is this still pertinent with the current mainline? (There were some
> changes to jfs.)

Thank you very much for your reply and suggestion. I thought that this
BUG still exists in the current mainline kernel version. Since I am
not very familiar with this part of the code, I am not sure if the
proposed fix is correct.

>
> > Through analysis, it was found that a race condition occurred between t=
wo
> > functions lmLogClose and txEnd, which were executed in different thread=
s.
> > The possible sequence is as follows:
> >
> > -----------------------------------------------------------------------=
--
> > cpu1(free thread)        |        cpu2(use thread)
> > -----------------------------------------------------------------------=
--
> > lmLogClose               |        txEnd
> >                          |        log =3D JFS_SBI(tblk->sb)->log;
> > sbi->log =3D NULL;         |
> > kfree(log); [1] free log |
> >                          |        clear_bit(log_FLUSH, &log->flag); [2]=
 UAF
>
> That looks sane to a by-passer.
>
> > Fix it by add a mutex lock between lmLogClose and txEnd:
>
> It doesn't feel right wrt "lock data, not code" heuristics.
> And when I apply that, it turns out there's already jfs_log_mutex.
> I'd suggest you explain more why a new lock is needed (if that's the
> preferred solutino).

You're right, I think my fix method is not a good solution. Hoping you
and other developers can help fix it.

>
> Thanks,
> Michal

Once again, I appreciate your help and will take your feedback into
consideration when working on a solution.

Best regards,
Zheng

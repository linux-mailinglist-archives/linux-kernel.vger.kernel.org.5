Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C55D772388
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjHGMMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjHGMMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:12:43 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51DB212F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:12:11 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so103295e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 05:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691410327; x=1692015127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ta/WOuRSiRVtqcU+Clzhq9Brgubf9rWM0gdEtm6Z4BE=;
        b=bnX03fJgvPunKrLJ+Z76u1UtH6c4zssGgOkdtt7zV+7pPoEmfuzk12wzclk4B9FVJi
         7e+ePJMa0VAL4nRD7AfaJDmz4B9RbQppttQ7D4aWoA7EwMwNxHGJ7LzOWwk0SSzAzf7n
         Fl49AxXEmvl1+bp7SdZjAIt/O9biO8OxpY5Cyaoka3lid9Kuneszf8JrSPIhC9pS/JfK
         OrwPJp5NIhXVm3xlLpBFTzIzBzaZHbRQnt/FNBPPr+6c9r0HK7+bhOnMYgQcpSNGaW4v
         sZru5w5o/1Hd5Lp88C4QwV01gIKZxctsKZYp9jdD/e9vKAvfYjaAQRtnnc9upQloM4x7
         P6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691410327; x=1692015127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ta/WOuRSiRVtqcU+Clzhq9Brgubf9rWM0gdEtm6Z4BE=;
        b=Di29e2LFlytxsI3DfB6sC84zk5MisPnHW572yeDtwC9lcBubia2meM/VpbV1Dp7z21
         AcucbjAmQtWUvT0Uf/w6JpiM2HEVPfZZFxG+clLqsMOYeAYCGH77p8D/iuumdnxTD85T
         PgsD+aa6R8UNzNBWMnS+QOgESESHUrVtTEF6y6UbyfQYVFB0LyHcpa3Tx9MIiF6YAd8C
         WyS0vfq4X3Ao/PWkitRK74oL+0buVO6rbcRWYvlFGAEc7MpzJd3OXWPOUJ9+xeI3AAZE
         YIEirDatl55VuQ1ezOV3DhoXbVr2xjQXHP3mVZS06mCDols51073ovIWCkFLcx1Q2ODA
         A9Uw==
X-Gm-Message-State: AOJu0YysDsp3WP1gYb9zqcnzuy4dwvMvVCW0ckCzLl5hhTvSuuBzms49
        IEVNAeSBq+Lo38K7MDX6/zZA1sEsH9JrbYoVqG8veUGRCNUWyIay1R+hYQ==
X-Google-Smtp-Source: AGHT+IECvjHgSmIAlxGvyVvwhb3NLn83CQAD+Z9z/aIFjQmIF6915gw4nfaTY/yIAeWHxeeKGpOTapsUSZelKUaIalA=
X-Received: by 2002:a05:600c:4746:b0:3fe:5ec3:447f with SMTP id
 w6-20020a05600c474600b003fe5ec3447fmr44406wmo.1.1691410327495; Mon, 07 Aug
 2023 05:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b35ea205ffc35fe1@google.com> <000000000000efbc2306024b74cf@google.com>
In-Reply-To: <000000000000efbc2306024b74cf@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Mon, 7 Aug 2023 14:11:55 +0200
Message-ID: <CANp29Y6ow1PS1NaiX-aSpRqGJQv0bE2QhzCBuhO-vEJa8RgjAw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in validate_mm (2)
To:     syzbot <syzbot+70b97abe3e253d1c3f8e@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, jonathan.cameron@huawei.com,
        krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, luca@z3ntu.xyz, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 3:49=E2=80=AFAM syzbot
<syzbot+70b97abe3e253d1c3f8e@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit ef513aa7aa5038d2f53e9f2932af5006f37ed0b6
> Author: Luca Weiss <luca@z3ntu.xyz>
> Date:   Thu Apr 13 23:17:49 2023 +0000
>
>     dt-bindings: iio: adc: qcom,spmi-vadc: Allow 1/16 for pre-scaling
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D11aeb085a8=
0000
> start commit:   a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git://git.k=
e..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df5e1158c5b2f8=
3bb
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D70b97abe3e253d1=
c3f8e
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1511d490a80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D130e5cfb28000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: dt-bindings: iio: adc: qcom,spmi-vadc: Allow 1/16 for pre-scali=
ng

No, that's wrong. Please ignore the email.

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE56376A083
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjGaSkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjGaSkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:40:25 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795DC1BC5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:40:24 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5222c5d71b8so7010978a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690828823; x=1691433623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VbqTPQRqx5r6b8SVskB/TyQ1aJsbLTn8hYnlmIsS2WQ=;
        b=Zuy0CCRclkOgd6i0onP3AHjnvLf5Pi/PG33b2RnSaMRaFYgnrijDZynKSRGcGPfFtn
         6HGAR5J+8e4+PeBtmkgx/cZ61q/v0PXGPWnIfmIlf8GAFb2KPPI0Ls7ce18qnxqxiFIR
         7KILYcWIkQNM6iceCUchGu6R8RHp5jfNYsK6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690828823; x=1691433623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VbqTPQRqx5r6b8SVskB/TyQ1aJsbLTn8hYnlmIsS2WQ=;
        b=i2YTxQkh0ZLsoHSSjijjtbhd/+UasNZ8ldY+6cNN+KKro4lKvrzNdJxZAdsa13Q2Nl
         G3PajJrLeEE/gqhfaKq8giH7dMqF/ttWrYoom25BeVYHtq5BcETaCNzrZxSAeHWRJth7
         pSoI97AswjPXQP9MxsGCfltN3ak2j07Lt+X6QXThz77WEzZDZVOdxf29ZUioRGJ4btse
         99tCneLb+Bh260tykNAa3w6qjUHOSlaj01Rjlpx8BWastTpoA72z+o2Asae+MayTYq/i
         aul9yDhM/FTnfpYTweBIqwN4ROSa2SMXHR2RHAHgWnkS/s3zVLvRKaAZd330XS6sFHTP
         HfAA==
X-Gm-Message-State: ABy/qLYsgyjkYrqOBs674kvabVN5a5sipHGsOWhm5MP/sMdwxn6GhzH3
        l3pTHOFkAxer9trioQfWahknHoznM+FWLk+cMbw9DDR2
X-Google-Smtp-Source: APBJJlFWGNXe4swzVdalBQhhIjCze8aKGfXwjkJyQ6Uhk0Hi0OKvPJomZC/w1FVXgfdCzOykRfdeuQ==
X-Received: by 2002:aa7:db49:0:b0:522:38f9:e653 with SMTP id n9-20020aa7db49000000b0052238f9e653mr586908edt.30.1690828822848;
        Mon, 31 Jul 2023 11:40:22 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id u19-20020a056402111300b0050bc4600d38sm5765400edv.79.2023.07.31.11.40.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 11:40:22 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5221b90f763so7027425a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:40:21 -0700 (PDT)
X-Received: by 2002:aa7:d7d1:0:b0:51e:25af:dc59 with SMTP id
 e17-20020aa7d7d1000000b0051e25afdc59mr532272eds.40.1690828821624; Mon, 31 Jul
 2023 11:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twNnV4zMCvrPkw3H-ajZOH-01JVh_kDrxdPYQErz8ZTdA@mail.gmail.com>
 <CAHk-=wi=eDN4Ub0qSN27ztBAvHSXCyiY2stu3_XbTpYpQX4x7w@mail.gmail.com>
 <ZJX27JDyrgvdeCe4@slm.duckdns.org> <ZMdu1YqUI7VIEq1y@alley>
In-Reply-To: <ZMdu1YqUI7VIEq1y@alley>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Jul 2023 11:40:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJSzSkF-FDcHydR61Q3_q4xCiqq37tfXdijaCxsDF86Q@mail.gmail.com>
Message-ID: <CAHk-=wiJSzSkF-FDcHydR61Q3_q4xCiqq37tfXdijaCxsDF86Q@mail.gmail.com>
Subject: Re: arm32 build warnings in workqueue.c
To:     Petr Mladek <pmladek@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Dave Airlie <airlied@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 at 01:20, Petr Mladek <pmladek@suse.com> wrote:
>
> Would it help to use const variables?

I guess it would _work_ these days (I think modern C has picked up
what C++ idiom of "const variable with an initializer is a constant"),
although with old compilers I would actually not be at all surprised
to see 'const variable' uses being turned into "load from memory",

But I don't see any real advantage, and it gets very nasty for non-static ones.

I think people just need to expand some things manually if they use a debugger.

It's not like we don't use macros absolutely EVERYWHERE ELSE, and any
gdb user already has to deal with it. The workqueue flags are the
least of your problems.

So I think the whole "gdb debug info" argument is complete garbage,
and was never true at all. If you want gdb to know about these
constants, you just do the same thing that gdb users already have to
do for other things.

We have all those gdb python helper scripts for other kernel magic -
some of it *much* deeper magic than a trivial "combine a few
constants".

And honestly, I don't understand why anybody seriously believes that
those WORK_STRUCT constants are somehow very important. We have many
*much* more fundamental constants that are #define's. Thinking that
WORK_OFFQ_CANCELING needs special gdb understanding when we have
PAGE_SIZE that does not seems entirely crazy to me.

              Linus

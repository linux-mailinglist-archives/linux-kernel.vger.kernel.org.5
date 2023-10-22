Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD987D250E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 19:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjJVRzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 13:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVRzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 13:55:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE394E8;
        Sun, 22 Oct 2023 10:55:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81347C433C7;
        Sun, 22 Oct 2023 17:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697997304;
        bh=RwTN09OOF3+q/gCRFPuLyVsNrVbvI4OB4BmftOBJWOI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VtiyibkxKJoKyM6eoslEdsigREPvsClIaQ9leafyYX28oqTXmcECmeqTUGa9VdVBn
         /7MOQ0C0u7NGyzki8EqJwzeRJTWhUU7ntYkAqRQMwYpAGx/tUn6SuqGVlsqnbryrYu
         bpzCkPcCFdv+ZmvBHmCiFwdi9ylPToUCIjH8Svky51tf9APLWkMyRKrMCAie2fxPP/
         OELmi38W1MdDGfckagp4AvKIRa4W7QBUphN2onI+BJm6K/vrgRtWwRct1wXvdcgBgf
         N5a9bPGgxfrZELpY+EG0xNZlKuIzMoFytSNtJhV3wguycltbsPQSwYqvA1J31+32gW
         pNUsXBKyNfkMw==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1dd5b98d9aeso1366456fac.0;
        Sun, 22 Oct 2023 10:55:04 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxhn+RbutDeQFXCIha2tHsEBdTRHnXQmIqwTwPxDoohQNI/kOhh
        nG+xl/gDq8WiznDLSmYiBUf3rd/wmwZFK3OW0BI=
X-Google-Smtp-Source: AGHT+IFflmnrimbwd1C7xDN6rUa/dxrRoHjp3Pgelkx9Qh4ZRdVW90MimT27fZV1TreUT1EH6GgU7k5aOq03PnX+akg=
X-Received: by 2002:a05:6871:70d:b0:1e9:8a35:863d with SMTP id
 f13-20020a056871070d00b001e98a35863dmr5649897oap.19.1697997303904; Sun, 22
 Oct 2023 10:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231020161217.255765-1-ak@linux.intel.com>
In-Reply-To: <20231020161217.255765-1-ak@linux.intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 23 Oct 2023 02:54:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR4Z3O+qZwhc6w7MGEbJsd6B8QZtz1p4_F7OO3jK+aigA@mail.gmail.com>
Message-ID: <CAK7LNAR4Z3O+qZwhc6w7MGEbJsd6B8QZtz1p4_F7OO3jK+aigA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Add inline-account tool
To:     Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
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

On Sat, Oct 21, 2023 at 1:12=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> A common cause of binary code bloat is excessive inlining. Traditional
> tools (like nm --size-sort -t d) don't address that directly because
> they only see the final functions, but don't know about inlines.
>
> This patch adds inline-account that makes it easy to track that down
> by accounting code bytes to all functions visible in the debug informatio=
n,
> as well as code lines.
>
> Here are some examples:
>
> Show all inlines that increase code size by >1K in the core scheduler:
>
> $ inline-account.py --min-bytes=3D1000 kernel/sched/core.o



How to use this tool?

I did not get any output.




masahiro@zoe:~/workspace/linux-kbuild(a)$ ./scripts/inline-account.py
--min-bytes=3D1000   kernel/sched/core.o
Total code bytes seen 0

Code bytes by functions:
Function                                           Total          Avg   Num

Code bytes by nearby source line blocks:
prefix
Line                                               Total
masahiro@zoe:~/workspace/linux-kbuild(a)$ ./scripts/inline-account.py
  kernel/sched/core.o
Total code bytes seen 0

Code bytes by functions:
Function                                           Total          Avg   Num

Code bytes by nearby source line blocks:
prefix
Line                                               Total
masahiro@zoe:~/workspace/linux-kbuild(a)$ ./scripts/inline-account.py
  lib/maple_tree.o
Total code bytes seen 0

Code bytes by functions:
Function                                           Total          Avg   Num

Code bytes by nearby source line blocks:
prefix
Line                                               Total







I do not think this patch is mature enough
regarding the coding style.

Please polish the code.







--=20
Best Regards
Masahiro Yamada

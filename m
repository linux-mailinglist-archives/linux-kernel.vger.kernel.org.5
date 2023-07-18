Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6261E75802E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjGROyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjGROyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:54:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE4D115;
        Tue, 18 Jul 2023 07:54:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1D9861615;
        Tue, 18 Jul 2023 14:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C1BC433C7;
        Tue, 18 Jul 2023 14:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689692081;
        bh=9OaB5dqsAbuBmRO7nPr865+hWKTbzSRKJYIF02YafGU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lTGTF0/dnJXKBhdJ66cxFn5JJeAe3IA5xkOCD6kBzS1taG3uyca7Vz9agtkgUWZ6M
         QRxfd7V4Jiekj2irkYIvVdbspjsYa7NjH37P39kX8r7lRZOsAIjJPd39RTsXr7LDVF
         OYPzg8OKkXAyzMhoRb/1cp/MpsDGQNRFU/eD2uYD7K6YwtumV5VTpY7oU5z3g2fcbJ
         iF5+s5ZgQY4e3niwRRvwk8hw2GKppdNREeML2YihU2ju3nbOG6zx/9cactDiL/CV2/
         gjYNmztRjhmlfBed52q101+sQ5zsrPcQ9qgLT+7H0beyWwvIXLBQbZ/UUJaedj8/Pl
         RRnq1uHS0n2cA==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-51e619bcbf9so8058490a12.3;
        Tue, 18 Jul 2023 07:54:41 -0700 (PDT)
X-Gm-Message-State: ABy/qLYzT0TSEsC2ix3id5Wi5htVdRXIsMSWuW0/EJ+0eevqTV+ShBLo
        4PBCgwRxTtc+FyGUmUhHRN09XG0BeVRPupJ7Pfo=
X-Google-Smtp-Source: APBJJlEPp/jeYj7ifTq6Z1UeMXDuB13B48p6+HZD4sidUY6d7T/+wMBz2ezjoHGMdXtjKUh0C91ZG9oDc3l/COjBzPA=
X-Received: by 2002:aa7:da95:0:b0:51e:e67:df4d with SMTP id
 q21-20020aa7da95000000b0051e0e67df4dmr91347eds.38.1689692079543; Tue, 18 Jul
 2023 07:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2307180025120.62448@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2307180025120.62448@angie.orcam.me.uk>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 18 Jul 2023 22:54:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4ewzWuZRe0RX+j2x2R_fROVExHuogWNaWBmFA=Tgb=Og@mail.gmail.com>
Message-ID: <CAAhV-H4ewzWuZRe0RX+j2x2R_fROVExHuogWNaWBmFA=Tgb=Og@mail.gmail.com>
Subject: Re: [PATCH 0/3] MIPS: Fix build issues from the introduction of `need-compiler'
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jan-Benedict Glaw <jbglaw@lug-owl.de>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Maciej,

Even if patch-2 resolves the problem, I don't think patch-3 is
necessary because the original patch makes code simpler and more
compact.

Huacai

On Tue, Jul 18, 2023 at 10:42=E2=80=AFPM Maciej W. Rozycki <macro@orcam.me.=
uk> wrote:
>
> Hi,
>
>  With the addition of the `need-compiler' variable the `Makefile.compiler=
'
> fragment is not included with no-build targets such as `modules_install',
> which in turn means $(call cc-option,), etc. are no-ops with these target=
s
> and any attempt to evaluate these function calls causes all kinds of weir=
d
> behaviour to happen.
>
>  The solution is to avoid making these calls in the first place, as they
> are surely irrelevant where the compiler is not going to be otherwise
> invoked.  This small patch series fixes two places known-affected in the
> MIPS Makefile fragment and also included a follow-up revert of an earlier
> misguided attempt.  See individual change descriptions for details.
>
>  Verified with `decstation_64_defconfig' and `fuloong2e_defconfig' using
> `modules_install'.  Please apply.
>
>   Maciej

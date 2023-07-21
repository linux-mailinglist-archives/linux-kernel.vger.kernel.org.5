Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D2075C857
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjGUNvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjGUNvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:51:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFAA35B1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:51:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D285E61B0C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 13:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DEAC433C7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 13:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689947437;
        bh=2U2DacFLhUUtqfp0Si4LVyjKQgQWEgSA987Rg+G6CfU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UYzzANqHBWaMcoqDv5HkO8fhMTl7gyh6yDpnKlJVOQfDBU0+GkfRCCv71Day6sClO
         YPkWXyD5UirQpm2crKNN7NByL1aU2QvSausDqAmT2ATKV6u7+NGlkb6F+K5j97ZNkS
         3m5xad+SqZXaKopQyPfjmeUHcQfx3LTlnaRJpMFwANZNrEzaW1OXbjm+I69BFPI175
         JPQ9qDAxti6Z1O72VtTKsQUTTJoVxHRNcEXf4Ix4kGnFOb7lnxpNYnMNuufJTng3eP
         Nd9ie7IlfbMKLJlC5lq0yD6QHFS7xuRRZtQJmXt3+L2QDPzP2WJowqitq6pibTaTYj
         gncr2fbsTK5Qw==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2b743161832so28626591fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:50:37 -0700 (PDT)
X-Gm-Message-State: ABy/qLZhmXgUefBdKJqKPyvRhB2Ylpej5QnouEOYIRwEuJwvtzZ1e0jz
        pIUcq50LdQI8Dre7YPt7MtXES3jxqbNuo7VF3xY=
X-Google-Smtp-Source: APBJJlGj7WMr4TOPJf7emio4BW3vSAkkVdQ4c3oRT7ZHEN0zxxnxx4KHhKNCugcAp2P53SnvlqZGuCG373aMQpTa+Tk=
X-Received: by 2002:a2e:8003:0:b0:2b9:5695:d10d with SMTP id
 j3-20020a2e8003000000b002b95695d10dmr1514394ljg.36.1689947435674; Fri, 21 Jul
 2023 06:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <87lef931x3.fsf@kernel.org>
In-Reply-To: <87lef931x3.fsf@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 21 Jul 2023 22:49:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR_pO_47yiKdGY-4m7es6Y-Tj_Vwo26_+xJYd3L0dfhXg@mail.gmail.com>
Message-ID: <CAK7LNAR_pO_47yiKdGY-4m7es6Y-Tj_Vwo26_+xJYd3L0dfhXg@mail.gmail.com>
Subject: Re: [regression] GNUmakefile broken on v6.5-rc1
To:     Kalle Valo <kvalo@kernel.org>
Cc:     regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 9:05=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote=
:
>
> Hi Masahiro,
>
> For a long time I have been using GNUmakefile in the top level source
> directory to change compilers, enable ccache etc. Here's a simplified
> GNUmakefile example:
>
> CROSS_COMPILE=3D/opt/cross/gcc-13.1.0-nolibc/x86_64-linux/bin/x86_64-linu=
x-
> include Makefile



You need to export the variables.


The following should work.



export CROSS_COMPILE=3D/opt/cross/gcc-13.1.0-nolibc/x86_64-linux/bin/x86_64=
-linux-
include Makefile






--=20
Best Regards
Masahiro Yamada

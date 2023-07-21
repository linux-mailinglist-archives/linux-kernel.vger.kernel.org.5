Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290D675BF04
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjGUGiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjGUGi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:38:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871AE1BF7;
        Thu, 20 Jul 2023 23:38:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 137F8612DC;
        Fri, 21 Jul 2023 06:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9E1C433C9;
        Fri, 21 Jul 2023 06:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689921489;
        bh=lryGXV4qukqPvZOw3q1o5gPb4Cucaex0+yNNmyeBp50=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AhzhJXyR60ORK3ahnF5MuyIbQgu9//kITF0ffM9vT6sSRmkV70zPXOyWJ3VFnTOpU
         mezxB5IDQtnGBETpeyioLpL/8BzYtdmRDOZxkJCo+rZuzlNzn3Wf6Cf78nTpCI/C6N
         3qkFFvSb+9GpvY0HYb/RNCeevY1KQ77OFZIFCaTA94eEY56Az1FjyuDbCy2p2PHNxZ
         ilFLszam5xWVR0mFElC9dKVXVDi9HY584ild5Tob8rQcO3sp9S6CXFt4ud4h0pRdCV
         NLfvCRvdPS77Sb1e9VFLAbxZDQY7rGBUbTU0tEF1X2hYuLF9ilddlkcvLIuwTeIoW9
         y+3EBWFnCCTbw==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-56584266c41so1091351eaf.2;
        Thu, 20 Jul 2023 23:38:09 -0700 (PDT)
X-Gm-Message-State: ABy/qLYRNXadGlTopidsrD/f/DdhjJSiBSnNyeEf6rBfULADGOBaviWt
        gLx9Yh3RpWzMiqHzQTS8MlWu5cqsbAOLrxpios0=
X-Google-Smtp-Source: APBJJlHg3TdiQ2vDqsbZGPmyi7IEIOlxl/z9KgZxYUQqQSLjnMK+nXliBPDkYpxB5vphECx11cxumtRaGt0aw1aUKwQ=
X-Received: by 2002:a4a:2401:0:b0:566:f94f:cd28 with SMTP id
 m1-20020a4a2401000000b00566f94fcd28mr1075903oof.3.1689921488673; Thu, 20 Jul
 2023 23:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <boris.20230717111132@codesynthesis.com> <CAK7LNATAYqG+Y-XubnU9EJqc3R9QhWCn1nfiGMLU63W7k0vpxQ@mail.gmail.com>
 <boris.20230718060325@codesynthesis.com>
In-Reply-To: <boris.20230718060325@codesynthesis.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 21 Jul 2023 15:37:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNARt3do8BR2eUp4JscgCwsHy9Kz=KHHnAvrB7v7yO1FJrA@mail.gmail.com>
Message-ID: <CAK7LNARt3do8BR2eUp4JscgCwsHy9Kz=KHHnAvrB7v7yO1FJrA@mail.gmail.com>
Subject: Re: Qt6 port of kconfig qconf
To:     Boris Kolpackov <boris@codesynthesis.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Jul 18, 2023 at 1:12=E2=80=AFPM Boris Kolpackov <boris@codesynthesi=
s.com> wrote:
>
> Masahiro Yamada <masahiroy@kernel.org> writes:
>
> > I like 1 or 2, depending on the size of #if soup.
>
> Looks like it won't be too dense if we are willing to only care about
> the latest version of Qt5 (i.e., 5.15.0 or later) since most of the
> changes appear to also work in the latest Qt5 (they may also work in
> earlier versions, but I don't have easy access to those to check).
>
> Should we go with support for "latest Qt5" and Qt6?


Yeah, I think so.




--=20
Best Regards
Masahiro Yamada

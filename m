Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B10D7546F2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 07:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjGOFjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 01:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOFjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 01:39:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FA13AA1;
        Fri, 14 Jul 2023 22:39:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46F2C60304;
        Sat, 15 Jul 2023 05:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55E5C433CC;
        Sat, 15 Jul 2023 05:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689399584;
        bh=EoC7y3rLdsTfdggC5ynHU58rMj0H+USBvF2tf7JCyGc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Miy423FMByR4Mt9Mua6XH9tmYZvsLJslHdxjnKySlfbtmniZQXalrENN/Fxix3Vet
         CFLXEuE0apDpD+Q18wTAMJb8LOajcHeDDs86flbTYZHRDHAkgtqHQ2Sryavowta+eW
         Rkhz0aU0pWIw+HjP9MiNU6VVUQJkaa/PaSpiMMYoUHhfocXHFvpehwV1c7T8j0iD8q
         8xtxeaJAeuMeRfdyXGbS4lYe7uqQN8QjvBTk5BpcCDnpsJ8VmLRlUA14Rft0lXsgeZ
         XvKaT+aLuUgoRgWSzkGEzcYvkIZ9M1p+Ghl4HrT8CohNDtEP3Vm6/ZYG1JqPnARoX5
         jataUoLhDvmZw==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-56347da4a50so1797261eaf.2;
        Fri, 14 Jul 2023 22:39:44 -0700 (PDT)
X-Gm-Message-State: ABy/qLbg7GbEqV/AMkelfn9jw5qLJ/lwSKBizpTAxOZO82KYXQUiRQlp
        Kn7svz2sCF5dZIcaDPz+JzAX18jhyXmR8Dn/MbA=
X-Google-Smtp-Source: APBJJlH+rK8S6u2KM7p7YAxOaFaTck4jBygqc6Df57rcB1UhTIYwDXWuRAWE79tRtcn0Ok3nSryS8fx6ETzofuUbWQ4=
X-Received: by 2002:a4a:86cd:0:b0:566:6971:9379 with SMTP id
 y13-20020a4a86cd000000b0056669719379mr800864ooh.1.1689399583837; Fri, 14 Jul
 2023 22:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230704000120.8098-1-rdunlap@infradead.org> <87mszyz4lc.fsf@meer.lwn.net>
In-Reply-To: <87mszyz4lc.fsf@meer.lwn.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 15 Jul 2023 14:39:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNASXk28=uxS4ENz7w5hCahseN8HLcbJaAbLVU7=78vThTw@mail.gmail.com>
Message-ID: <CAK7LNASXk28=uxS4ENz7w5hCahseN8HLcbJaAbLVU7=78vThTw@mail.gmail.com>
Subject: Re: [PATCH] kconfig: docs: mention gconfig at top of kconfig.rst
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Jesse Taube <mr.bossman075@gmail.com>,
        linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2023 at 4:16=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> Randy Dunlap <rdunlap@infradead.org> writes:
>
> > Jesse mentioned that gconfig is missing from the top of the
> > kconfig.rst file, so add it for completeness.
> >
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Link: lore.kernel.org/r/CAJFTR8QgYykuEq_AkODEWPUYXncKgRBHOncxT=3DypZTQO=
Dkyarw@mail.gmail.com
> > Cc: Jesse Taube <mr.bossman075@gmail.com>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: linux-kbuild@vger.kernel.org
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Nicolas Schier <nicolas@fjasle.eu>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: linux-doc@vger.kernel.org
> > ---
> >  Documentation/kbuild/kconfig.rst |    2 ++
> >  1 file changed, 2 insertions(+)
>
> Applied, thanks.
>
> jon


Unless it is too late,

Acked: Masahiro Yamada <masahiroy@kernel.org>


--=20
Best Regards
Masahiro Yamada

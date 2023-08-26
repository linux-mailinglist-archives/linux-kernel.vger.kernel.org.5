Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4101A7893F5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 07:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjHZFj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 01:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHZFjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 01:39:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AB0268F;
        Fri, 25 Aug 2023 22:38:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEDD5624C9;
        Sat, 26 Aug 2023 05:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5568AC433CC;
        Sat, 26 Aug 2023 05:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693028337;
        bh=Ff+w4unXcyWxKJf/xFhZoCcGgfpukrGhib7/Mm9VbU4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mP8PtUpKrPQNIu5CTYPuLMve3p24Mb1rz5TA6UAP496G7Ppl8x+d3u+izvoaRP+55
         IjXrKVqe1iO/RH6D2w7UzBepezInElvWXTaVIN/4KG5E3/ia0a028a0cIKrOwg9r2o
         L/G2E7z+/OyNCQPpPqi+5D3jvaUlOcW3ezku1BMx5SBQJi56u6sgO33Gh71peEqu6b
         WlcselPAGIwW6rZud8oYuiD76FQBCYRD3nX7U+5sDw6EmqFgiO57kHpLHDxaewV8t9
         1vrEQuu8CmrOIGAfE5diX0CYszp/76807UhCcYirGIwyfs6N9l1SJ6p7EEjRkLMtTs
         Ww/3CbBXw3uVg==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6bca3588edbso1123649a34.0;
        Fri, 25 Aug 2023 22:38:57 -0700 (PDT)
X-Gm-Message-State: AOJu0YypAPDSCkUvKfwQhiEYCIrNpdZI60IC8Tc3CrPZlg3cRwdU+PkD
        cbwDyWi7lzX4QwGph5UwNL3nzCcpBXbTCpUaWI0=
X-Google-Smtp-Source: AGHT+IGHMUNZvYZiv+FVl9g5GzqXimaanOxBwjsWql3Vi+JFrQBO/HjvjkEpzIgr+endMg8gfK9L8f8wx+HNE/vQtQs=
X-Received: by 2002:a05:6870:d106:b0:1bb:a468:9e6c with SMTP id
 e6-20020a056870d10600b001bba4689e6cmr5349648oac.23.1693028336518; Fri, 25 Aug
 2023 22:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230817012007.131868-1-senozhatsky@chromium.org>
 <CAK7LNASJWKSsdzn5ccgWaC35-XvHGU7pnE6C=eZFDbqrrghtdQ@mail.gmail.com>
 <20230820024519.GK907732@google.com> <CAK7LNAS9KC1GjPgadMEivSpy4TMYU8mQ+BrtfJpNs2kvhK18yA@mail.gmail.com>
 <20230820072119.GM907732@google.com> <20230820073332.GN907732@google.com>
 <CAK7LNARTZXvWD8PrA3bC+Ok7LK85qO=pkMs4kOPGn90OBooL6w@mail.gmail.com>
 <20230822061203.GA610023@google.com> <CAK7LNAS0qEZk+xAq84=7SuJSQz5F3dNBjYKPoeKTd_caq-QMKg@mail.gmail.com>
 <20230824012027.GD3913@google.com> <CAK7LNATvDBwN7X8X0mVqcQn6dKxGFhkgt9Qb5CZ6p+6Eafxd0w@mail.gmail.com>
In-Reply-To: <CAK7LNATvDBwN7X8X0mVqcQn6dKxGFhkgt9Qb5CZ6p+6Eafxd0w@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 26 Aug 2023 14:38:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNARMOpzpr6E6XG-ro5dUgFWMP9r5rqET1WquOvvsckbKyA@mail.gmail.com>
Message-ID: <CAK7LNARMOpzpr6E6XG-ro5dUgFWMP9r5rqET1WquOvvsckbKyA@mail.gmail.com>
Subject: Re: [RFC][PATCH] kconfig: introduce listunknownconfig
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Ying Sun <sunying@nj.iscas.ac.cn>,
        Jesse T <mr.bossman075@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Tomasz Figa <tfiga@chromium.org>, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Aug 26, 2023 at 10:12=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> On Thu, Aug 24, 2023 at 7:50=E2=80=AFPM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > On (23/08/24 10:00), Masahiro Yamada wrote:
> >
> > > For the MFD_RK808 case particularly,
> > > I believe Kconfig showed MFD_RK8XX_I2C
> > > as a new option.
> >
> > I think there were some other unmet dependencies for MFD_RK8XX_I2C and
> > I don't think the new config was shown. But even if it was, we still
> > would have no idea that this meant "MFD_RK808 is not available anymore
> > and the corresponding code won't get compiled". So the "this is not
> > recognized anymore" is still needed and is quite helpful.
> >
> > Would you be OK with "list missing" being a warning (not a terminal
> > condition)?
>
>
> I am fine with implementing both.
>
> But, I'd like to implement them as separate options.
> (one option for warn unknown symbols,
> another for for turning warnings into errors)
>
>
>
> As I replied to Tomasz, I am considering about
> env variables vs command line options associated with W=3D option.



With a little more thought, the command line option approach
would require more code changes and efforts.


So, I am OK with adding new env variables.
Could you add two env variables?


I think

the first two hunks (show warnings for symbols not found in Kconfig)
        -> KCONFIG_WARN_UNKNOWN_SYMBOLS

the last hunk (turn warnings into errors)
        -> KCONFIG_WERROR


(You can suggest a better naming if you have, but I guess
KCONFIG_WARN_*  will be consistent in case
more warning requests come up.)





--
Best Regards
Masahiro Yamada

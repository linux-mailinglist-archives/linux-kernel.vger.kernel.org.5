Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0F578D353
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 08:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbjH3GYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 02:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjH3GYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:24:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD43E9;
        Tue, 29 Aug 2023 23:23:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DE6A62A11;
        Wed, 30 Aug 2023 06:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCB1C433C7;
        Wed, 30 Aug 2023 06:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693376636;
        bh=RYSnPcWKe633760Uix59PDBhfOKOvleACAnROEZxNeE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W0JiNj0qryyt6+tgjN+v22hFaVrF4TtDXaTGhshK1A60gI+oEBquXQ24WyIvRlFlo
         XMsD3Ece5ktC+vLU1xTnx4D8GbmlOxXUjIHlrDSry7RnM9t+JKEGVlQuj2579tHDj2
         9slPeuf0x/+6HTRp7wCn+x+1j/Z08l7bFC9Onmnz+DBZtkmHrx75R0XiR2SbJOBGuP
         zqC0Lf1GS6bXD5+dV4uneWoKUARtTkKqVXzyncenZs3jJ45l5HPTyuaf045VhvMqwR
         jCIifF6sops5o7jj3zwqrdeUptG87YMPvLDUriZO54fDYUhHxfwMhH3L2UOTnmr0p0
         2Vo4L9kX4XYAw==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-99bf1f632b8so702763466b.1;
        Tue, 29 Aug 2023 23:23:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YxpfFSjEDz1z/0E2mMymphgyvPs8tCzbfn2IpXZfUx/4zXEdv69
        EaiR0N/T8DVvuhgTMRS5OJCMB6JnaIGMAK4myn8=
X-Google-Smtp-Source: AGHT+IHw34WkfmCXFTSf4XA+iMg7UzvONtAWWlBKIoZBaadfF6M0zvmKa9Ot/m5tpS4tEkMHn3FvLUJXjo6h9oxNiVs=
X-Received: by 2002:a17:906:cc18:b0:9a1:ddb9:6547 with SMTP id
 ml24-20020a170906cc1800b009a1ddb96547mr936705ejb.57.1693376634841; Tue, 29
 Aug 2023 23:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <1692434183-2054-1-git-send-email-yangtiezhu@loongson.cn>
 <ZOxkt/6EkQIy+Jkt@alpha.franken.de> <ZO4Mdr9/XUkXDK9j@alpha.franken.de>
In-Reply-To: <ZO4Mdr9/XUkXDK9j@alpha.franken.de>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 30 Aug 2023 14:23:42 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4XDRGkFaqyOnTyDQo8M=nEUYf4B8kSiEWQpq6QB-yz5g@mail.gmail.com>
Message-ID: <CAAhV-H4XDRGkFaqyOnTyDQo8M=nEUYf4B8kSiEWQpq6QB-yz5g@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Modify die() for MIPS
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
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

Hi, Thomas,

On Tue, Aug 29, 2023 at 11:44=E2=80=AFPM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Mon, Aug 28, 2023 at 11:11:19AM +0200, Thomas Bogendoerfer wrote:
> > On Sat, Aug 19, 2023 at 04:36:19PM +0800, Tiezhu Yang wrote:
> > > v4:
> > >   -- Add BUG() at the end of nmi_exception_handler()
> > >   -- Return earlier in die() if notify_die() returns NOTIFY_STOP
> > >   -- Update the patch titles and commit messages
> > >
> > > v3:
> > >   -- Make each patch can be built without errors and warnings.
> > >
> > > v2:
> > >   -- Update the commit message to give more detailed info, split into
> > >      three individual patches, suggested by Maciej, thank you.
> > >
> > > Tiezhu Yang (4):
> > >   MIPS: Add BUG() at the end of nmi_exception_handler()
> > >   MIPS: Do not kill the task in die() if notify_die() returns
> > >     NOTIFY_STOP
> > >   MIPS: Return earlier in die() if notify_die() returns NOTIFY_STOP
> > >   MIPS: Add identifier names to arguments of die() declaration
> > >
> > >  arch/mips/include/asm/ptrace.h |  2 +-
> > >  arch/mips/kernel/traps.c       | 15 +++++++++------
> > >  2 files changed, 10 insertions(+), 7 deletions(-)
> >
> > series applied to mips-next.
>
> I've dropped the series again after feedback from Maciej, that this
> still needs more changes.
I feel a little surprised. This series has appeared for more than ten
days and received some R-b, and we haven't seen any objections from
Maciej. If there are really some bugs that need to be fixed, I think
the normal operation is making additional patches...

Huacai

>
> Thomas.
>
> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessaril=
y a
> good idea.                                                [ RFC1925, 2.3 =
]

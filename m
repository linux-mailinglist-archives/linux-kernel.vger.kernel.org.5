Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B4B75D927
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 04:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjGVCjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 22:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGVCjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 22:39:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401D319A2;
        Fri, 21 Jul 2023 19:39:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C813761DC7;
        Sat, 22 Jul 2023 02:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3489CC433C8;
        Sat, 22 Jul 2023 02:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689993548;
        bh=+RqEIaoI8OE5D71pEAjzNeOQhQuC/8XCkx88Si4hPEY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lHQLpKIy8JpBgFyrPafh3ZlCMAmb5NNqb2ChqP4Y9lwUnc+xW615GHHbGgFaN9DdM
         Wfjiq/dhrF4dkEkqhY29ZE/MZFb3/YeujDuynCH9Q/ZOIIbNiSMU6ab/wOh9kPMPV2
         f7KdLyio6uZHl8BYcx/ZeKh9Xt2a16sgS47pD/TCFMKTPZt/ePJyNnyeszgE1lCefD
         vPZ2TZ7QPtW2kCprDEer5hTvx4eUDDS0ITZ6Ea1CH1MrZbJbX7x8rKVzSpsk+TIeh5
         F6Y0iyYtviuDa0mV6/YePJr3rCFVLJVStSUK+JcnoDc4TtACYD4k7/1smzI40w2mGK
         iHzT9OWWB0g4w==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9936b3d0286so403780866b.0;
        Fri, 21 Jul 2023 19:39:08 -0700 (PDT)
X-Gm-Message-State: ABy/qLbuvHcUrkiEJFenKYdCqbw6K8ddVThbuldckTBtp4wE/Dt1jbGy
        h6Uuob92OEb+fcAmEYOIntU/cYjEQirSeT2KJtY=
X-Google-Smtp-Source: APBJJlEG/RmL8tu3vSMZ8UlWQ25SvxEDikE4JTHxKsNUTT0esW+CutZqjvYr2T0viznIahAjE4tSh9FlLngWD1otfuI=
X-Received: by 2002:a17:907:2cef:b0:99b:4a6f:9c72 with SMTP id
 hz15-20020a1709072cef00b0099b4a6f9c72mr3709167ejc.72.1689993546316; Fri, 21
 Jul 2023 19:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <87edl6wr9p.fsf@meer.lwn.net> <20230717192456.453124-1-costa.shul@redhat.com>
 <87tttxc9tt.fsf@meer.lwn.net>
In-Reply-To: <87tttxc9tt.fsf@meer.lwn.net>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 22 Jul 2023 10:38:54 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6K3OOHxYxxTWDDN3FiJ0zQd4H2b1zBPhmNHpBekkPbAg@mail.gmail.com>
Message-ID: <CAAhV-H6K3OOHxYxxTWDDN3FiJ0zQd4H2b1zBPhmNHpBekkPbAg@mail.gmail.com>
Subject: Re: [PATCH v3] docs: move loongarch under arch
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Wu XiangCheng <bobwxc@email.cn>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:LOONGARCH" <loongarch@lists.linux.dev>
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

Hi, Jonathan,

On Sat, Jul 22, 2023 at 4:02=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> Costa Shulyupin <costa.shul@redhat.com> writes:
>
> > and fix all in-tree references.
> >
> > Architecture-specific documentation is being moved into Documentation/a=
rch/
> > as a way of cleaning up the top-level documentation directory and makin=
g
> > the docs hierarchy more closely match the source hierarchy.
> >
> > Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> >
>
> This, I think, is ready to apply, but I sure would like an ack from the
> loongarch maintainers.  As it stands, please let me know if you object,
> otherwise I'll apply this in the near future.
This looks good to me.
Acked-by: Huacai Chen <chenhuacai@loongson.cn>

>
> Thanks,
>
> jon

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05987F0B57
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 05:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjKTETA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 23:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTES6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 23:18:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FE2E5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 20:18:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94046C433CC;
        Mon, 20 Nov 2023 04:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700453934;
        bh=eJc3t+vjty0J6ATUE4Rsu1fv8yiYA2QdwTT2oLeeNpc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G/2HIGaIq7151RXjukRJmEbQbVLRf20uMRs4ARHzoBejz0WoIhuw34AJGl7dDmlGQ
         FT0Lzt+sDylZNbyTpXPvH/ipyE8oa7wyIAmNJvWA08d0hle+bUNW2lv1L8ta1gu/dz
         VbTqckmIC1eZpHNdxPwebpe1oNTRuS6dMIN7TOs2BgnvvqClE5ffP2UNx9JSTqCRle
         qNpp9USlyq9Xx35DMG4rngRY/V6iIB2WpwOj/f8hJklD+pOffb73KO5sijsW++Wb0G
         qZicqxiQWpPnuCgWs2x1Sv7NeLYzPdhIb3/s3Uf3fX7/7LArr10uKbvGTWQyNSdBcx
         Ck1KGLdk6f7Kg==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1ef36a04931so2500035fac.2;
        Sun, 19 Nov 2023 20:18:54 -0800 (PST)
X-Gm-Message-State: AOJu0YxvF/RqVfDFADUOMVRs3Z08xFsZEip+YJNvzqp+JklNCeR6jOKy
        m7hmI1r5WlzCnRP7H5DItIDNiu5vHauQQmlelhc=
X-Google-Smtp-Source: AGHT+IFjUvCUwL9dlENvgBWSAvBVxN2mi2cDv4rqkgfxU4VoW6wZ29EQ2LekMKBcBn1C8Sq7Y6MIhJJPQ/V/mcv6WHM=
X-Received: by 2002:a05:6870:f69e:b0:1e9:a3e1:c388 with SMTP id
 el30-20020a056870f69e00b001e9a3e1c388mr6972167oab.41.1700453933986; Sun, 19
 Nov 2023 20:18:53 -0800 (PST)
MIME-Version: 1.0
References: <20231118081334.1308242-1-masahiroy@kernel.org> <ZVp26K9b8Apuy3FD@fjasle.eu>
In-Reply-To: <ZVp26K9b8Apuy3FD@fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 20 Nov 2023 13:18:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNATj65c0beTb5oXMDskiaFnxp1hoMOF0yG15pGv7cujNEg@mail.gmail.com>
Message-ID: <CAK7LNATj65c0beTb5oXMDskiaFnxp1hoMOF0yG15pGv7cujNEg@mail.gmail.com>
Subject: Re: [PATCH] scripts: clean up IA-64 code
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
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

On Mon, Nov 20, 2023 at 5:58=E2=80=AFAM Nicolas Schier <nicolas@fjasle.eu> =
wrote:
>
> On Sat, Nov 18, 2023 at 05:13:34PM +0900 Masahiro Yamada wrote:
> > A little more janitorial work after commit cf8e8658100d ("arch: Remove
> > Itanium (IA-64) architecture").
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/checkstack.pl        |  3 ---
> >  scripts/gdb/linux/tasks.py   | 15 +++------------
> >  scripts/head-object-list.txt |  1 -
> >  scripts/kconfig/mconf.c      |  2 +-
> >  scripts/kconfig/nconf.c      |  2 +-
> >  scripts/package/kernel.spec  |  6 ------
> >  scripts/package/mkdebian     |  2 +-
> >  scripts/recordmcount.pl      |  7 -------
> >  scripts/xz_wrap.sh           |  1 -
> >  9 files changed, 6 insertions(+), 33 deletions(-)
> >
>
> Thanks, looks good to me.  Might you want to also remove replace the last
> references in the kbuild files?
>
> scripts/recordmcount.c  uses cpp symbol EM_IA_64

Thanks, I will remove it too.

> Makefile                contains two comments with examples naming IA64


Which line?  I could not spot them.


> scripts/checkstack.pl   still holds credits for its (now removed) IA64 po=
rt,
>                         but that might have been left by intention


I hesitate to touch the credit. So, this is intentional.




>
> Nevertheless:
>
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
>
> Kind regards,
> Nicolas



--=20
Best Regards
Masahiro Yamada

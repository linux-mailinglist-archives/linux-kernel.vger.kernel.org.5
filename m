Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F0E79C8BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjILHxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjILHxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:53:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95739E78;
        Tue, 12 Sep 2023 00:53:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5E2C433CA;
        Tue, 12 Sep 2023 07:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694505229;
        bh=vzB3LIA1z0/wCi7ZCm6mXrxoTMuvofC+wO3dSIHccsE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yb4nyA3w6L2SD5tDqPRSE1ZjRvoycS+xtXqC9g4eaOZ1mIkaNpX3+EjgDOISNCIY8
         zgIyhHLSwotiKtgRSkQxBvO1UejGTZtX+61C62kLa9QvfX/ofOfLMGI1+T/XcKD8/M
         szfWHOCaLdlHGjERQ6KVhPd7m4yZc4wEFO/az6f7p26LhJzCjSJhuRv7K2TxbBa29p
         h2CE9QcEOuH9B2ztIYZ2Om1+G55eo3xDb/hUP0pe2C2GfBmS87c/42kScxPjqlXz3O
         uuDEzz2xqxJ3s/JU/uPNm2PL7ug0RY/7MC0NnbQ8DFWN8/vPvOHcmMoGmU39jEXCqL
         qRXyCCXS6lMNg==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3aa1446066aso3690877b6e.1;
        Tue, 12 Sep 2023 00:53:49 -0700 (PDT)
X-Gm-Message-State: AOJu0YwejhdR7YSId9kinMg93W8uKobdAydS1e5UcHF4Cd9LFq+qBCCD
        KxWml2t4n6kOijkO84YGKnjoTBLKCNR1RoAod4k=
X-Google-Smtp-Source: AGHT+IE6EiAkzrS51ztkq9S+4sGhkm7OjLRVelglK7j4MmP6A4JqcM3HPvNuTjHMSpQFeUi95/Hw0Iy5OEq47LgMaJ8=
X-Received: by 2002:a05:6870:d114:b0:1bf:61d1:a4d4 with SMTP id
 e20-20020a056870d11400b001bf61d1a4d4mr15117181oac.6.1694505228587; Tue, 12
 Sep 2023 00:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230911234418.38154-2-leobras@redhat.com>
In-Reply-To: <20230911234418.38154-2-leobras@redhat.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 12 Sep 2023 16:53:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNASKRoxLwz1jvsbbxv0=JQtySG4O7eN2+_PT6q20G7YT9g@mail.gmail.com>
Message-ID: <CAK7LNASKRoxLwz1jvsbbxv0=JQtySG4O7eN2+_PT6q20G7YT9g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] scripts: Introduce a default git.orderFile
To:     Leonardo Bras <leobras@redhat.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 8:45=E2=80=AFAM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> When reviewing patches, it looks much nicer to have some changes shown
> before others, which allow better understanding of the patch before the
> the .c files reviewing.
>
> Introduce a default git.orderFile, in order to help developers getting th=
e
> best ordering easier.
>
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
>
> Please provide feedback on what else to add / remove / reorder here!
>
> Changes since RFCv1:
> - Added Kconfig* (thanks Randy Dunlap!)
> - Changed Kbuild to Kbuild* (improve matching)
>
>  scripts/git.orderFile | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 scripts/git.orderFile
>
> diff --git a/scripts/git.orderFile b/scripts/git.orderFile
> new file mode 100644
> index 000000000000..819f0a957fe3
> --- /dev/null
> +++ b/scripts/git.orderFile
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +


Please use "# SPDX-License-Identifier: GPL-2.0".

/* ... */ is not a valid comment style for the orderfile.




> +# order file for git, to produce patches which are easier to review
> +# by diffing the important stuff like header changes first.
> +#
> +# one-off usage:
> +#   git diff -O scripts/git.orderfile ...
> +#
> +# add to git config:
> +#   git config diff.orderFile scripts/git.orderfile


These comments are bogus.


I guess this comment header was copied from QEMU,
but you changed the file path
from scripts/git.orderfile to scripts/git.orderFile.


You need to adjust the comment lines to


    git diff -O scripts/git.orderFile ...

    git config diff.orderFile scripts/git.orderFile



Or, you need to get the file path back to scripts/git.orderfile








> +#
> +
> +MAINTAINERS
> +
> +# Documentation
> +Documentation/*
> +*.rst
> +
> +# build system
> +Kbuild*
> +Kconfig*
> +Makefile*


Kbuild* and Makefile* are interchangeable.
(both are for GNU Make)

Kconfig* are different types.


Better to arrange the order to

Kconfig*
Kbuild*
Makefile*





> +*.mak

QEMU consistently uses only *.mak.

I just realized the kernel tree uses both *.mak and *.mk

masahiro@zoe:~/ref/linux(master)$ find .  -name '*.mak'
./tools/scripts/utilities.mak
masahiro@zoe:~/ref/linux(master)$ find .  -name '*.mk'
./tools/testing/selftests/lib.mk
./tools/testing/selftests/ptp/testptp.mk





BTW, I quickly tested this, but
it did not work as I expected.





masahiro@zoe:~/ref/linux(aaa)$ git diff --name-only d34599b^..d34599b
MAINTAINERS
drivers/Kconfig
drivers/Makefile
drivers/cache/Kconfig
drivers/cache/Makefile
drivers/cache/ax45mp_cache.c

masahiro@zoe:~/ref/linux(aaa)$ git diff --name-only -O
scripts/git.orderFile d34599b^..d34599b
MAINTAINERS
drivers/cache/ax45mp_cache.c
drivers/Kconfig
drivers/Makefile
drivers/cache/Kconfig
drivers/cache/Makefile

masahiro@zoe:~/ref/linux(aaa)$ git diff --name-only -O
scripts/git.orderFile d34599b..d34599b^
MAINTAINERS
drivers/cache/ax45mp_cache.c
drivers/Kconfig
drivers/Makefile
drivers/cache/Kconfig
drivers/cache/Makefile





My expectation was the following:

MAINTAINERS
drivers/Kconfig
drivers/cache/Kconfig
drivers/Makefile
drivers/cache/Makefile
drivers/cache/ax45mp_cache.c


It did not work like that.
Am I missing something?





> +
> +# semantic patches
> +*.cocci
> +
> +# headers
> +*.h
> +
> +# code
> +*.c
> --
> 2.42.0
>





--=20
Best Regards
Masahiro Yamada

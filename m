Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13807EDF9D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345003AbjKPLYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjKPLYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:24:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EB585
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:24:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38CBC433C8;
        Thu, 16 Nov 2023 11:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700133854;
        bh=bCJDoiy/sh3xNRf75ljpDp88pdpsa7M3K2V68jRgzUc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RgfqziOiMbINq8HsxM2OAWW6UCsAyV7XWuCw4XgE4yIDcKrLWhbVjO9zGgXUn/IBH
         Yzqen8E/CLSc5Cul2RCbpoWLUv8uPnAOaUvzFxm1HFdkAqy5Jio0nGKgkbONaVaPGc
         HApbsRDtLrGaVQd5J0jT4nYKDfn18zREeuLVcXuB6xBn3CdYLmoC9lY8C3sQCuU8tv
         Ayh8grmY4D7wuuSAjZN2fZ++x+zglxTbv/p5DaeHnqL7dOoZuBf1B1LuTlSLaKr6ob
         ZLKQqew/+zPbTioOFky+qHOuyOg9/KU/95hzlBHScr0JfB47lvdRZdnoLLe/YLrzYD
         W9GAJA/RQukmw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1ea82246069so303969fac.3;
        Thu, 16 Nov 2023 03:24:14 -0800 (PST)
X-Gm-Message-State: AOJu0YwC9MFCFjzpw6m4RRNAoj8Ho8ZfaObjEL1FdOOUpnvO1er1SJua
        gLr2V+n4mtzCFm6GfJrab+0CNxZeQsRcjpo2N0g=
X-Google-Smtp-Source: AGHT+IGL1ooWzMLrBnh/iCwVNzs90f3ifC9jhTcii0/52JPkolBSjjXLnYQxLMim+v61DF/rNDA0d1ek2Yflzrf5s4I=
X-Received: by 2002:a05:6870:648f:b0:1e9:bbfe:6457 with SMTP id
 cz15-20020a056870648f00b001e9bbfe6457mr21480433oab.6.1700133854051; Thu, 16
 Nov 2023 03:24:14 -0800 (PST)
MIME-Version: 1.0
References: <ZVWMCZ/jb4nX3yHn@work>
In-Reply-To: <ZVWMCZ/jb4nX3yHn@work>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 16 Nov 2023 20:23:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR1i8HP8E3UmmSggZMka+UbJswU_bVMyxmRt4CbQhoTAA@mail.gmail.com>
Message-ID: <CAK7LNAR1i8HP8E3UmmSggZMka+UbJswU_bVMyxmRt4CbQhoTAA@mail.gmail.com>
Subject: Re: [PATCH][next] Makefile: Enable -Wstringop-overflow globally
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 12:27=E2=80=AFPM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> It seems that we have finished addressing all the remaining
> issues regarding compiler option -Wstringop-overflow. So, we
> are now in good shape to enable this compiler option globally.
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  Makefile                   | 3 +++
>  scripts/Makefile.extrawarn | 2 --
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 690cde550acd..452b7d0e19e9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -985,6 +985,9 @@ NOSTDINC_FLAGS +=3D -nostdinc
>  # perform bounds checking.
>  KBUILD_CFLAGS +=3D $(call cc-option, -fstrict-flex-arrays=3D3)
>
> +# We are now in good shape to enable this option.

Please remove this comment.

It it fine to mention it in the commit log, but
not in the Makefile.



I hope somebody will double-check this patch in CI infrastructure.




> +KBUILD_CFLAGS +=3D $(call cc-option, -Wstringop-overflow)
> +
>  # disable invalid "can't wrap" optimizations for signed / pointers
>  KBUILD_CFLAGS  +=3D -fno-strict-overflow
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 2fe6f2828d37..1527199161d7 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -106,7 +106,6 @@ KBUILD_CFLAGS +=3D $(call cc-option, -Wunused-const-v=
ariable)
>  KBUILD_CFLAGS +=3D $(call cc-option, -Wpacked-not-aligned)
>  KBUILD_CFLAGS +=3D $(call cc-option, -Wformat-overflow)
>  KBUILD_CFLAGS +=3D $(call cc-option, -Wformat-truncation)
> -KBUILD_CFLAGS +=3D $(call cc-option, -Wstringop-overflow)
>  KBUILD_CFLAGS +=3D $(call cc-option, -Wstringop-truncation)
>
>  KBUILD_CPPFLAGS +=3D -Wundef
> @@ -122,7 +121,6 @@ KBUILD_CFLAGS +=3D $(call cc-disable-warning, restric=
t)
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, packed-not-aligned)
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, format-overflow)
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, format-truncation)
> -KBUILD_CFLAGS +=3D $(call cc-disable-warning, stringop-overflow)
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, stringop-truncation)
>
>  ifdef CONFIG_CC_IS_CLANG
> --
> 2.34.1
>


--=20
Best Regards
Masahiro Yamada

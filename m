Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C74A7F3D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 06:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjKVFHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 00:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjKVFHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 00:07:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5504B2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 21:06:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37048C433D9;
        Wed, 22 Nov 2023 05:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700629616;
        bh=SMGTFpMUFlePRZDNEdBRTyt1TtPx97T5y1jxAfBIUSM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GaRMpUoaPyy3aSywdp6J6l22pCBtNs3hRaJQRZASU9tAnhti0l0mDlEsIkQc3GhO6
         djblblh5NoFSagsCE/4PaWxFrKAXRQTDNvB2ORoFb7XFDBuOIG2gNWcSUYnsGfH19O
         o3Tj9tPXQ2vdFB8dwERopYuVdeonl4vsXhE6RmUio3mNsoA7NCrzbOkpwPv3RcYILo
         Fu4qP1eqiXSIpa+ehx/y4X24in0Hj0vGNLv8qKKSXDzZtcC5S8kbOQLVc3BkizmB7o
         qInxZYnJ0WLCVT2RdvOYERGmFmfhjNBB0Sbh6JtiAnZYzmun6u2mBF8xF5v5I10lLK
         cV0ya4BLlKAbA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5842ea6f4d5so4025042eaf.2;
        Tue, 21 Nov 2023 21:06:56 -0800 (PST)
X-Gm-Message-State: AOJu0YwF0kKMNI0MPi++9/UvHjEyJSDbvKosf96wwXUJuviXiRfFdWNd
        jy+gCTLsizpRvR76RJc0o2X3nVmuz2gKKvqnXOs=
X-Google-Smtp-Source: AGHT+IFfI0wltrJTCmjSnaFWjgTR0bE9i7u+a83ILZJxT8zkqo4A5hXAfq7+yqFlRkIw3OdhdV+yCULgGoDc4ULVp+o=
X-Received: by 2002:a05:6870:1612:b0:1f9:67db:2d51 with SMTP id
 b18-20020a056870161200b001f967db2d51mr1686219oae.31.1700629615555; Tue, 21
 Nov 2023 21:06:55 -0800 (PST)
MIME-Version: 1.0
References: <20231117-maintainers-v1-1-85f2a7422ed9@google.com>
 <CAK7LNARAvH=tWpsXJ640y04Ju8UbPmDze_NC6ax1EKK4Xy73fw@mail.gmail.com> <5EB120AB-1F30-4403-B652-DC0D2772B25E@kernel.org>
In-Reply-To: <5EB120AB-1F30-4403-B652-DC0D2772B25E@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 22 Nov 2023 14:06:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNARV5aCbvVr4GxWCorGbH-vvXy0NbbW1G6W4a0POGg=wZQ@mail.gmail.com>
Message-ID: <CAK7LNARV5aCbvVr4GxWCorGbH-vvXy0NbbW1G6W4a0POGg=wZQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: refresh LLVM support
To:     Kees Cook <kees@kernel.org>
Cc:     ndesaulniers@google.com, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Nov 22, 2023 at 1:47=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
>
>
> On November 19, 2023 9:17:20 AM PST, Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
> >On Sat, Nov 18, 2023 at 4:24=E2=80=AFAM <ndesaulniers@google.com> wrote:
> >>
> >> [...]
> >> Wake me when you need me.
> >>
> >> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > [...]
> >(The patch was addressed to Kees, so I will not touch it.
> >I think he will pick it up.)
>
> Yeah, I will snag this soon: I'm out this week for US Thanksgiving, but w=
ill get it to Linus shortly. (Unless someone else picks it up before then.)
>
> -Kees
>
> --
> Kees Cook


For the "KERNEL BUILD + files below scripts/" bit,


Acked-by: Masahiro Yamada <masahiroy@kernel.org>

--=20
Best Regards
Masahiro Yamada

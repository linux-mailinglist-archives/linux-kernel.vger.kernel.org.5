Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C5E7AAA3E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjIVH2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjIVH2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:28:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C1FF7;
        Fri, 22 Sep 2023 00:28:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D548C433C8;
        Fri, 22 Sep 2023 07:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695367705;
        bh=wgQZWXAwvdKZPHFA5FAhGqf9aLotY806Yvs6HB1H2gw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m+ztdVAPrL7mMa6wX1EVnVgqn6QEODSE3XB2mUoauK32b9YeZBmDfaHCQTmgT7PM1
         Be5C1gftDkFcy+pH35VA+VeDcXx6MQoVLbm4MmO1Wh95Pm4GEcTOwKoLZkyebv+Yyh
         zeLWA+Mv45IA3K/vkykJg1AfGL2VtHi35MAGrYSYvtV5owsg/mnPOFJ+YBLs6sdxKo
         pkk/xleZ+5Hs2KW4nCdHKkSr8kgXlXIyoX3EYTYLBt+M6c6WHgUwmVjvL+wZjMjWAG
         bTa9a4fsAQOzNs66+guBHD2ZTlc8KCuqlgh3JUfF8j47b8FAIh48OEYjyVft+tn7XJ
         KcSQwH9gV8Y+w==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-57354433a7dso922940eaf.1;
        Fri, 22 Sep 2023 00:28:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YxMhsKrhpWILq4YNMN0EEnLlApQv/v3HLL5YFecPTEQmmDrZ9ey
        G+kEtP1jf0mgpUCsKwq0A48eEl6jrmBTW6vy5DY=
X-Google-Smtp-Source: AGHT+IFJFH31u8ht5yLCWJBfJuCh90gnONcYxjRKS5LpCmKkwzgzTqyv6U1+tXkxSg8nibSjTmpqNvJITUrEywuR1Bw=
X-Received: by 2002:a05:6870:248a:b0:1d5:a377:f360 with SMTP id
 s10-20020a056870248a00b001d5a377f360mr7476864oaq.41.1695367704525; Fri, 22
 Sep 2023 00:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230920015559.1877441-1-aik@amd.com> <CAK7LNARrb_NLpBL19LHEdg0WJKsncaUPQLk-wxhR+Rh8sps3jQ@mail.gmail.com>
 <a6a90c61-e884-4b18-83b7-ca3d2e0378e7@amd.com>
In-Reply-To: <a6a90c61-e884-4b18-83b7-ca3d2e0378e7@amd.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 22 Sep 2023 16:27:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS+PefrZnUO1R4v8pa6V7Mh_R92dNAR96Wucz0tf1HEpg@mail.gmail.com>
Message-ID: <CAK7LNAS+PefrZnUO1R4v8pa6V7Mh_R92dNAR96Wucz0tf1HEpg@mail.gmail.com>
Subject: Re: [PATCH kernel] kbuild: get rid of unwanted "+" when
 CONFIG_LOCALVERSION is set
To:     Alexey Kardashevskiy <aik@amd.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 10:30=E2=80=AFPM Alexey Kardashevskiy <aik@amd.com>=
 wrote:
>
>
> On 20/9/23 21:59, Masahiro Yamada wrote:
> > On Wed, Sep 20, 2023 at 10:56=E2=80=AFAM Alexey Kardashevskiy <aik@amd.=
com> wrote:
> >>
> >> The scripts/setlocalversion script correctly tries not adding "+" when
> >> CONFIG_LOCALVERSION is defined.
> >
> > I am afraid you are misunderstanding the script.
>
> Possibly :) I should have read of "+set"... sorry :-/ Thanks for
> spending time looking at this.
>
> > CONFIG_LOCALVERSION and the "+" sign is unrelated.
>
> How come?
>
> scripts/setlocalversion -> if [ "${LOCALVERSION+set}" !=3D "set" ] ->
> scm_version --short -> echo "+".
>
> Where is that LOCALVERSION supposed to come from, and when? Is not
> LOCALVERSION related to CONFIG_LOCALVERSION?


1) LOCALVERSION is an environment variable.


  $ LOCALVERSION=3D-foo make
           or
  $ make LOCALVERSION=3D-foo



2) CONFIG_LOCALVERSION is a CONFIG option

  $ make menuconfig

    and set the value.


1) and 2) are orthogonal.
If you set both, you can get both of them.





> >> However, instead of grepping for it
> >> (as it is done for CONFIG_LOCALVERSION_AUTO=3Dy), it relies on LOCALVE=
RSION
> >> set in the shell which is not.
> >>
> >> Export LOCALVERSION so scripts/setlocalversion could see it and not ad=
d
> >> unwanted "+" at the end of the kernelrelease.
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> >
> >
> > So, scripts/setlocalversion will always see
> > defined LOCALVERSION.
> >
> > With your patch, LOCALVERSION would be set to an empty value,
> > which would make the following condition always false.
> >
> > elif [ "${LOCALVERSION+set}" !=3D "set" ]; then
> >
> >
> > Your patch is equivalent to deleting
> > line 175-183 of scripts/setlocalversion.
> >
> > Of course, that is wrong and unacceptable.
>
> Ok. What is the right way of getting rid of the "+"? Thanks,







--
Best Regards
Masahiro Yamada

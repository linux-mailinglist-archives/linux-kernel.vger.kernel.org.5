Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1160D7E0EA6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 10:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjKDJmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 05:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKDJmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 05:42:52 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAA01BD
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 02:42:49 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso4739258a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 02:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699090968; x=1699695768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbfL3NkpfKmXRCHooSUmBGmgS2c222w1KL1iym/+IkE=;
        b=Rh2SZz8RJ0C1a+fxZtvSOC/eoaA7HqxREtfN67/IUy4spMiDkPVjnppj85In8wqNlH
         6VyXTXDU508S0+N5je5CwlW/BtxJqKW4QQQBpW+D39r9UUozhEsW5Ei9i4LpxNG8AG23
         ALgEisSXhcrybWCZk+3rZ0USYsPVwtpEVnEYfVFrKyNirZi+ACM5dzef6V5/N04wmOl/
         eu9u/m4g2DVYHwWso4DQE9vkWEOZ+7Nv3pU91l6EpNTGfNo88M+jBLekif/GISNNKl7T
         85fRIdwQB0+Mn7iEu3SdXlJRfaZD2sLS1HZKX4+1t2fLZIsg4u9G5zAYeK527tmcOpWA
         pWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699090968; x=1699695768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbfL3NkpfKmXRCHooSUmBGmgS2c222w1KL1iym/+IkE=;
        b=oFN7naJmYT1hJ3D2BSKpvPaghut/UmOiQ3lvXdUphlqdgEeCtD52jkSWh1pFGFSjdy
         RENArePrVGNr7tVNspkh1uLicO8AzIctSlwlkqxKQipXEzuGSqvuSqXn60rFggcRu6RA
         05UIQFgBW9jRT/c0r9PFBsA6ZJYB3g7SjkDM3CDgVsJxkVBPerw/1MG2OPTEPbyftz+L
         7xoPL2g97dzm/9mmgfNLiLrbzSZQjGelsauuqMESns5Z2GPfyZClV3RlLaU6p9FyC9sj
         uL73XWbje6NX4frVe69Y5zW70r3p5n9OfmG/zDacWAJ1JXCw5eYppIRsTj+CKN3lUZEk
         Kh/w==
X-Gm-Message-State: AOJu0YxuozW2OBHS/pj3WbIXDSiBLNRlOImNtBAXyb3W0gFZISq1Kgru
        WkflmW2NxOOcDdPzfkv1f0c9R6sqGYf8bja/Pu0=
X-Google-Smtp-Source: AGHT+IFAHNDkINjU+Y5YPivroCWJYoBJBuwLvpBetinur2scmP7PDHWMEUo6pHc1DTONAZV4gYyQrLs4lzdWmyR0oUc=
X-Received: by 2002:a17:907:1b02:b0:9ae:82b4:e309 with SMTP id
 mp2-20020a1709071b0200b009ae82b4e309mr9393758ejc.0.1699090967781; Sat, 04 Nov
 2023 02:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <ZUNsmJGbYwgPaUpY@debian> <CADnq5_Minarw2D_TeRdkm6nJOP_4qHM+MxiMeLWMXqHxjq22Xw@mail.gmail.com>
 <CADVatmO9NCs=ryNg72HNzMDpqg862gpGnnFhQ4uwTpEkjOkCLw@mail.gmail.com> <CADnq5_Ou7Cq071DJZnq+3PDNqkd3ZJb+dCEvMjiked6_t=E6MA@mail.gmail.com>
In-Reply-To: <CADnq5_Ou7Cq071DJZnq+3PDNqkd3ZJb+dCEvMjiked6_t=E6MA@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sat, 4 Nov 2023 09:42:11 +0000
Message-ID: <CADVatmN4njCTGxNPjtpX9gdaySUxW07petaRP1uOzHaQNxf7fQ@mail.gmail.com>
Subject: Re: mainline build failure due to 7966f319c66d ("drm/amd/display:
 Introduce DML2")
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Roman Li <roman.li@amd.com>,
        Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        regressions@lists.linux.dev, Leo Li <sunpeng.li@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        "linux-kernel@vger.kernel.orgLinus Torvalds" 
        <torvalds@linux-foundation.org>, dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2023 at 22:53, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Thu, Nov 2, 2023 at 1:07=E2=80=AFPM Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > On Thu, 2 Nov 2023 at 16:52, Alex Deucher <alexdeucher@gmail.com> wrote=
:
> > >
> > > On Thu, Nov 2, 2023 at 5:32=E2=80=AFAM Sudip Mukherjee (Codethink)
> > > <sudipm.mukherjee@gmail.com> wrote:
> > > >
> > > > Hi All,
> > > >
> > > > The latest mainline kernel branch fails to build x86_64 allmodconfi=
g
> > > > with the error:
> > > >
> > > > drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c: =
In function 'dml_prefetch_check':
> > > > drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6=
707:1: error: the frame size of 2056 bytes is larger than 2048 bytes [-Werr=
or=3Dframe-larger-than=3D]
> > > >  6707 | }
> > > >       | ^
> > > >
> > > > git bisect pointed to 7966f319c66d ("drm/amd/display: Introduce DML=
2")
> > > >
> > > > I will be happy to test any patch or provide any extra log if neede=
d.
> > >
> > > This was reported earlier and fixed by:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D089dbf6a06f1dcaeed4f8b86d619e8d28b235207
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Db141fa036c901303ca5659cc22e9c08f8b097892
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D5b2c54e0d0ea09f7a3b500510731878326e1117e
> > > but I guess maybe different compiler versions are still hitting this.
> >
> > Yes, I should have mentioned. gcc-11 and gcc-12 failed to build. but
> > gcc-13 was ok.
>
> Should be fixed with Nathan's patch:
> https://patchwork.freedesktop.org/patch/565675/

Yes, it does. Thanks.

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>


--=20
Regards
Sudip

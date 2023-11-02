Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE047DFCA9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377542AbjKBWxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbjKBWxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:53:30 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2148919E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 15:53:24 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1efad296d42so845018fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 15:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698965601; x=1699570401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywkZ1ZWfNmiVp7a6UPS372ot5uoGxaI4T7nCnN1k30I=;
        b=MnLxoWM8ob4Zx//8ViOEUf6RWbekkZlruX1TnINSxjK28prfVdMkvIe/25mfjeuSy+
         kug2IZlggaoKMMohTeWqgLO3WmZKNAHlDtfFY+CX0Keysw7jsrke7Q388sCnPoEvMZBY
         KkZp+KRIcUmdK1HTSHnxEVAQQKmPUcS4PO5YCuNXxXtHdfragGzQgfmPeh4+ETXV8Zv8
         iYNHTqA4bh/gC7tzmsgf1akohi6G5oXMNkle81ZxcOHt47J/ygfQey0RCLqoLHmA6mbk
         BvZzvslpwtDPnwPuLtroLB3Tx4S1Cus6KpZ/fkaHAGyMgDobDMFYEpzeYf3J5rq+SFiy
         FUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698965601; x=1699570401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywkZ1ZWfNmiVp7a6UPS372ot5uoGxaI4T7nCnN1k30I=;
        b=NGNPiZ+afDgTEMbPNTp0avUYm/SS7uERhvA2DJdarouiE6CKX28D9bNwNYJ2RST+9K
         xBDb+xGwtwg6Jim89z7HBL5NYB4461lKkmbKAhjxO8MI+ZacAD8o7+l+o3hFCgC3glQZ
         pZiJDAIPxHmDcZRkK9Eb3gZC034RhFw9e6fowoPC72UCpzz3lQ2h8Z5RfFDtUddaquUD
         Qo8/0Y0Mn6zCVhCeaDCAC+/ZlwfK1+wmZUwwlSY0rTtts/y06lperyIk0HEdbCzpxbX1
         z0XshbMsGznQAMoCObEVWQb/jII5TV3TRG/F3iBErXmTdeW/6yoFNA3MSnhHnallwQNn
         ndJA==
X-Gm-Message-State: AOJu0YyqVxAvMzAc6aG6LuFd7R5J54Uqhn8+wm168X1hrq8GUp1y1oDD
        xDOCfs1ZKr03e70kXDcvvG5hFq+MTycQciDZWiayXRjuR5E=
X-Google-Smtp-Source: AGHT+IE1yCCtzM/K8cFr0IT8oP2y3RjE6Uh5RrkvdH5l8sS2cDigljS/xmdpOFoQ2Ifca4c1s8xNpN5SqSINFrPB+PA=
X-Received: by 2002:a05:6870:2007:b0:1dc:c65e:ded2 with SMTP id
 o7-20020a056870200700b001dcc65eded2mr24706945oab.12.1698965601603; Thu, 02
 Nov 2023 15:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <ZUNsmJGbYwgPaUpY@debian> <CADnq5_Minarw2D_TeRdkm6nJOP_4qHM+MxiMeLWMXqHxjq22Xw@mail.gmail.com>
 <CADVatmO9NCs=ryNg72HNzMDpqg862gpGnnFhQ4uwTpEkjOkCLw@mail.gmail.com>
In-Reply-To: <CADVatmO9NCs=ryNg72HNzMDpqg862gpGnnFhQ4uwTpEkjOkCLw@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 2 Nov 2023 18:53:10 -0400
Message-ID: <CADnq5_Ou7Cq071DJZnq+3PDNqkd3ZJb+dCEvMjiked6_t=E6MA@mail.gmail.com>
Subject: Re: mainline build failure due to 7966f319c66d ("drm/amd/display:
 Introduce DML2")
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 1:07=E2=80=AFPM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> On Thu, 2 Nov 2023 at 16:52, Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Thu, Nov 2, 2023 at 5:32=E2=80=AFAM Sudip Mukherjee (Codethink)
> > <sudipm.mukherjee@gmail.com> wrote:
> > >
> > > Hi All,
> > >
> > > The latest mainline kernel branch fails to build x86_64 allmodconfig
> > > with the error:
> > >
> > > drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c: In=
 function 'dml_prefetch_check':
> > > drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:670=
7:1: error: the frame size of 2056 bytes is larger than 2048 bytes [-Werror=
=3Dframe-larger-than=3D]
> > >  6707 | }
> > >       | ^
> > >
> > > git bisect pointed to 7966f319c66d ("drm/amd/display: Introduce DML2"=
)
> > >
> > > I will be happy to test any patch or provide any extra log if needed.
> >
> > This was reported earlier and fixed by:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D089dbf6a06f1dcaeed4f8b86d619e8d28b235207
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Db141fa036c901303ca5659cc22e9c08f8b097892
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D5b2c54e0d0ea09f7a3b500510731878326e1117e
> > but I guess maybe different compiler versions are still hitting this.
>
> Yes, I should have mentioned. gcc-11 and gcc-12 failed to build. but
> gcc-13 was ok.

Should be fixed with Nathan's patch:
https://patchwork.freedesktop.org/patch/565675/

Alex

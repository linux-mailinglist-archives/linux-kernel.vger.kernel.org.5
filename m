Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6E37D5BE3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344322AbjJXTw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344318AbjJXTwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:52:54 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9992C10D3;
        Tue, 24 Oct 2023 12:52:52 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1ea05b3f228so3228931fac.1;
        Tue, 24 Oct 2023 12:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698177172; x=1698781972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4v0Tx3LEGkdavh4vYYD99MkxxVJWO8xEM2BO5mWKw0=;
        b=Gpi77K2lRhIiYDXvP/TemUoLJ8wLxskX4dpU/rgpxRUkc1Yeh2uf825uArq7xNgzsc
         P1lNtQ+e+EfqbE8BN8zdEkLCIOXcCi5ztfFTKzz7n7AEz5uNY8Xc02mlVD4rYaYemk4P
         zSqfgg4O6Ztbpjt5aKGT4mRruIsev1xZ8DY6FthHKymVuGHLpkBlFWg7Zy0zmN1igujT
         EKIqvdShOxc4ymFZTjVSg1LmzPIuTMXoy8/m8P6fFRSKkf0EI7yKZ0gSc1xrgCY7UNv+
         c4dcBHd4rreLkelbIwbygZEWbR7txTi9oRowwdFTX01Z0xgyEIPnLNdVJb1ftfIpY+wv
         4+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698177172; x=1698781972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4v0Tx3LEGkdavh4vYYD99MkxxVJWO8xEM2BO5mWKw0=;
        b=MPtF9BcBqNl3N0eHVcxHE3c9DL8Y0XMSCxdrCn56cuZqK4pvSmB3DD5nGRmfg/N+3s
         bIMn2FJtMlxPvvLMe3yh+i9BZ+9yzz5arF1eFESEgczCP+nFblRY+6QZ1GWRfAYeIGZI
         +fEZU1CiZDJDoa4AzgrCpflstKSQHufUg72KtEinx3NVciUzoyNcZ9bUr3F5wgiqEPcE
         aTzRY2tHNscp0JrLOvfCCY4rs6uQ9rl6zRW1MWL58vUCtPPrKwIiYJB0giS+ATfUO4WW
         iSy2YDuMzR6+eNcxkdFXvAy+J0K+M4YUd+Z4HYTIOLwgVShEiQwVRDy2qKdXPIfYafFg
         vOeA==
X-Gm-Message-State: AOJu0Yz+qPIYf1+q2l8RFoDzySpyupZLFiR+rIRTLtYZXr8xPgq7YSb4
        I+jUMMjys9GGf5Eijz0Y7BfLRp+ZsorscEzE2p0=
X-Google-Smtp-Source: AGHT+IF5+l/sIaMZYDwt0jM872L+aYqrqvPjN3KGyHM9mIDlE++bIFQ2z35Msbz7vXspgGElyXY2/Rr4ZNW2sTnJAJ8=
X-Received: by 2002:a05:6870:4c02:b0:1be:ceca:c666 with SMTP id
 pk2-20020a0568704c0200b001bececac666mr19072674oab.14.1698177171769; Tue, 24
 Oct 2023 12:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231010124357.5251e100@canb.auug.org.au> <20231019120618.71424848@canb.auug.org.au>
 <20231024115903.2d73440c@canb.auug.org.au> <CADnq5_Od1cQFp=5__LexMKzXwtnmcmcAidE-XsLkL3N4oz+5sg@mail.gmail.com>
In-Reply-To: <CADnq5_Od1cQFp=5__LexMKzXwtnmcmcAidE-XsLkL3N4oz+5sg@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Oct 2023 15:52:40 -0400
Message-ID: <CADnq5_P1fOw4pmh56D6E8m6JvMggsMFQhtGv=xhdkUbsUhdRYQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Airlie <airlied@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Roman Li <roman.li@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 8:57=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Mon, Oct 23, 2023 at 8:59=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.o=
rg.au> wrote:
> >
> > Hi all,
> >
> > On Thu, 19 Oct 2023 12:06:18 +1100 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
> > >
> > > On Tue, 10 Oct 2023 12:43:57 +1100 Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
> > > >
> > > > After merging the amdgpu tree, today's linux-next build (x86_64
> > > > allmodconfig) failed like this:
> > > >
> > > > drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c: =
In function 'dml_core_mode_support':
> > > > drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:8=
229:1: error: the frame size of 2736 bytes is larger than 2048 bytes [-Werr=
or=3Dframe-larger-than=3D]
> > > >  8229 | } // dml_core_mode_support
> > > >       | ^
> > > > cc1: all warnings being treated as errors
> > > >
> > > > Caused by commit
> > > >
> > > >   7966f319c66d ("drm/amd/display: Introduce DML2")
> > > >
> > > > (or maybe something later that changed storage size).
> > > >
> > > > I have used the amdgpu tree from next-20231009 for today.
> > >
> > > This build failure now (presumably) exists in the drm tree.  I am sti=
ll
> > > applying the 2 patches from Rodrigo to my tree as a work around.
> > >
> > > I would have expected that this was fixed in the amdgpu tree before
> > > Dave was asked to merge it ...
> >
> > Any progress here?  I am still applying the 2 patches.
>
> The two patches are in my -next tree and in the PR I sent last week.

Looks like the gitlab migration over the weekend lost some history.
I've fixed it up.

Alex

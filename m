Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4101F7D507B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbjJXM5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbjJXM5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:57:31 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D495190;
        Tue, 24 Oct 2023 05:57:28 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-5841bdf1b81so2420053eaf.0;
        Tue, 24 Oct 2023 05:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698152248; x=1698757048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnNh0LRnjCLPjE/B6+4yEhPIsqvJNOCipSkYbYzorsc=;
        b=hwrYGc1I2+z191YbNIqk2+OCp0QK94+jh9To1HGH+Jc1Gz/wqObrf0c+BgGjQSQZjj
         d11GnzAUsO9l2uyP+QmeXqMHeScEjRxuTCgkRMmn139vSJSpkCw8mPeH1d8WEyNMHHc4
         BGiRfTgbPRyswMZTg55IZCv3Nzxs0N/qCvuiZQpiiUcQ7QUqB80+Ow+lyDf2rrw7A+NQ
         o6oPlwiG5r8MQGHSNOLagzODIRgjKqYZMTX82DaZOtaKAFVhKboNFjxhDLNTUASIv0Mu
         9P/Qaif024ag307/ZRdbzTmI2w7N1lMEyo/ZMJDO5dhK7g6b5ehb/pDBlovjmWVwaobM
         cMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698152248; x=1698757048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnNh0LRnjCLPjE/B6+4yEhPIsqvJNOCipSkYbYzorsc=;
        b=DG8R93PliLXeJWGi58FcD+oiwiKND1BMsz4lol2OqSZuOCNdSJtUY9ACyRgGqTpx+O
         paI8034NeMUax8WN4u9tguwN4csCuw89ATGafsWK8eey5bPsQSg0pVz2HxN4phu2SOxj
         RNxl05lDscpCieQreH+JNpoSVltBKjtpvSpPvVAp6nLJSldzTReJIlsB6xp+UQs0H1hC
         9EdyKxIW8P32amwdf3eHFf0iC0HAu0M/BPwSwKZVqtLCbBTrKNWpbeLZQd7BdsUprohj
         btl/8s8mRsgsleYDjUR6RvmoeplKaHSWDydd1U1GR6d0iaZVXiXBy24gYNmybi5f8Z8U
         552w==
X-Gm-Message-State: AOJu0YzhSt3Yhd28rAq02UzoQ+ssfEyn2COQlwuGbqua5uM5KZCv1RP3
        Ocqff4VHPlyg0KSO4sMHl5ehrEczlbB4ay7nV0I=
X-Google-Smtp-Source: AGHT+IGzsmQgOu7FVSXytUl8xoOGDU4hlcS/YQUZmgz7buw+9C5uBE1jP5997/JEOCTssiaEhiIMBVKRhijVGl2jRaE=
X-Received: by 2002:a05:6870:e2ce:b0:1e9:d8a4:551f with SMTP id
 w14-20020a056870e2ce00b001e9d8a4551fmr14638728oad.17.1698152248003; Tue, 24
 Oct 2023 05:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231010124357.5251e100@canb.auug.org.au> <20231019120618.71424848@canb.auug.org.au>
 <20231024115903.2d73440c@canb.auug.org.au>
In-Reply-To: <20231024115903.2d73440c@canb.auug.org.au>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Oct 2023 08:57:16 -0400
Message-ID: <CADnq5_Od1cQFp=5__LexMKzXwtnmcmcAidE-XsLkL3N4oz+5sg@mail.gmail.com>
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

On Mon, Oct 23, 2023 at 8:59=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> On Thu, 19 Oct 2023 12:06:18 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > On Tue, 10 Oct 2023 12:43:57 +1100 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
> > >
> > > After merging the amdgpu tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > >
> > > drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c: In=
 function 'dml_core_mode_support':
> > > drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:822=
9:1: error: the frame size of 2736 bytes is larger than 2048 bytes [-Werror=
=3Dframe-larger-than=3D]
> > >  8229 | } // dml_core_mode_support
> > >       | ^
> > > cc1: all warnings being treated as errors
> > >
> > > Caused by commit
> > >
> > >   7966f319c66d ("drm/amd/display: Introduce DML2")
> > >
> > > (or maybe something later that changed storage size).
> > >
> > > I have used the amdgpu tree from next-20231009 for today.
> >
> > This build failure now (presumably) exists in the drm tree.  I am still
> > applying the 2 patches from Rodrigo to my tree as a work around.
> >
> > I would have expected that this was fixed in the amdgpu tree before
> > Dave was asked to merge it ...
>
> Any progress here?  I am still applying the 2 patches.

The two patches are in my -next tree and in the PR I sent last week.

Alex

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D249578F2F2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347012AbjHaS4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237254AbjHaS4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:56:10 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66B4FB;
        Thu, 31 Aug 2023 11:56:06 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401ce65dfc4so3912255e9.0;
        Thu, 31 Aug 2023 11:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693508165; x=1694112965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70+hbPdCGwbal0A00oV8Qd5IExBJqMtjUwdtyT1yesg=;
        b=opRaAoy4UEtI3D79clL3Y89jjF5zQ/Ykv35RKzbjlSUu1RtLS16cHwKySLPAR29zkt
         gGxyuIwSmsti+k4iLGrovRW6Mdsoh+5csWKn85aen2lJpGb6Y7zq3EiyLYsr17BJeiiP
         HkhoBxQuBOxJjJoMwhS3drzfjBcMWFxLRoq+tROffJjcFgzVY52UTBxmYSj/hI1rbA6m
         0zcpfj47EVn79uysakK9ECDNB5STkrv3e8bUlzUkhKUhk+YY3WGeVt98xNorRRsovswz
         6M294GGk3xaN2X4qvvyUyR8O2ESuK5T1RMAQn2sF1LNAj8aFQA3UbN1+aI4MY/U+Rn2o
         wrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693508165; x=1694112965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70+hbPdCGwbal0A00oV8Qd5IExBJqMtjUwdtyT1yesg=;
        b=TovnhvvitP0utSnG2cFqOK7lqxzQYFUXLsM7RJvtqWk2oiRxl2QsEumnODgj2y5/WQ
         GQe+Czv+RPxS3ULDjRmLD+crzB3Y2q4zurK24Yfm73htLcHqv3iz2yRW24zJIxRHNSQ2
         rH3pU2/wKDH5niGQWK92uefGeXqssX+F2HTvjG808pXGPl1PhQUR8GcSFs3YgshTcd1P
         N9Wy4k3yvBguyg/zEgN5SkehYQOGQcBuOulTuiSWvwC9ls1Ffk5efEwhArwpMwog20x+
         wsp/xxr4oj9U8iJY29+e2qHIHJ0bH3d23NS/aj1ikcrUx7guFOyvHKXRSCLiviVhPVuI
         v+YQ==
X-Gm-Message-State: AOJu0YwOyZqh5zPFBLjgIv0U9lc5ydl2AiMg43/pvs8GSk8np0bixrnD
        O18TcuWQx1A36/4H/uMEjUl0O9klv2WfXDrPf9bdsnXO
X-Google-Smtp-Source: AGHT+IF9ZKWCgd8d7R7zW6WSPi4FSXNFrrb++2Kkp9AV6hYPajY6HNBp7SI8K1T9gYypIbwS+iblGsap0riFAFU/lik=
X-Received: by 2002:a05:600c:8505:b0:401:c717:ec68 with SMTP id
 gw5-20020a05600c850500b00401c717ec68mr140636wmb.3.1693508164875; Thu, 31 Aug
 2023 11:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230724012419.2317649-1-sashal@kernel.org> <20230724012419.2317649-13-sashal@kernel.org>
 <CAPaKu7RTgAMBLHbwtp4zgiBSDrTFtAj07k5qMzkuLQy2Zr+sZA@mail.gmail.com>
 <55fc4a28-1e17-44df-2069-a688828080e6@gmail.com> <2023083145-scoured-celery-2511@gregkh>
 <c657653e-24d8-5790-a91c-4c13bb9eaeb0@gmail.com> <2023083144-railroad-daybreak-7f41@gregkh>
In-Reply-To: <2023083144-railroad-daybreak-7f41@gregkh>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Thu, 31 Aug 2023 11:55:53 -0700
Message-ID: <CAPaKu7Q2vq5m6Av6L2LthnFy5w2XtjKUYF8Z2__0hVp0vj2L1A@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.10 13/22] drm/amdgpu: install stub fence into
 potential unused fence pointers
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Sasha Levin <sashal@kernel.org>, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        stable@vger.kernel.org, Lang Yu <Lang.Yu@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 7:01=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Aug 31, 2023 at 03:26:28PM +0200, Christian K=C3=B6nig wrote:
> > Am 31.08.23 um 12:56 schrieb Greg KH:
> > > On Thu, Aug 31, 2023 at 12:27:27PM +0200, Christian K=C3=B6nig wrote:
> > > > Am 30.08.23 um 20:53 schrieb Chia-I Wu:
> > > > > On Sun, Jul 23, 2023 at 6:24=E2=80=AFPM Sasha Levin <sashal@kerne=
l.org> wrote:
> > > > > > From: Lang Yu <Lang.Yu@amd.com>
> > > > > >
> > > > > > [ Upstream commit 187916e6ed9d0c3b3abc27429f7a5f8c936bd1f0 ]
> > > > > >
> > > > > > When using cpu to update page tables, vm update fences are unus=
ed.
> > > > > > Install stub fence into these fence pointers instead of NULL
> > > > > > to avoid NULL dereference when calling dma_fence_wait() on them=
.
> > > > > >
> > > > > > Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > > > > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > > > > ---
> > > > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++--
> > > > > >    1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > We start getting this warning spew on chromeos
> > > > Yeah because the older kernels still kept track of the last VM fenc=
e in the
> > > > syncobj.
> > > >
> > > > This patch here should probably not have been back ported.
> > > >
> > > > Why was that done anyway? The upstream commit doesn't have a CC sta=
ble and
> > > > this is only a bug fix for a new feature not present on older kerne=
ls.
> > > It is part of the AUTOSEL process.
> >
> > Could we prevent patches from being backported by adding a Fixes: tag?
>
> Yes, that will show exactly where the patch should be backported to.
This is also AUTOSEL'ed to 5.15.  That might need a revert as well,
depending on when the amdgpu feature landed.


>
> thanks,
>
> greg k-h

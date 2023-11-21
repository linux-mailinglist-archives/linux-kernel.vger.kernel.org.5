Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDD47F3689
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbjKUSxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbjKUSxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:53:12 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9585C193
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:53:08 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6cd0a8bc6dcso3670480a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700592788; x=1701197588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MJviHtyv8L1V4pX3J+mGOhL9XRHlVW6pwIEatSbK/o=;
        b=i+NZ6TQ+Oyx+LrBQJHazOwyILM2aww5VZVym4TmGadmMg4QBd5c/DuOQ3MJvMO41wA
         a+ybzYMe6sXMm7v7EfDx1NtQpl2gxejwWJSMNVvuoP+9d//jcZoca7Ab+EDxpGWFB6Lm
         SFJYdc7DuzLanpL7IJynJyCbXi/QREG48sOYQGgBN6bo4tVJSp+enBW1wsYqO3Nqw/I6
         +fytCFWNlS7Xa2RLS7gGd9es9w9cmVDXqo4en02Imiea8jEhG2TWhJrGtuIbsPqz6UHW
         6pSq9S+mVQxilVKeNHjsPgNtN+TK6/3HHWiuBI1ujzF0PK/st4sXVB//Wjb/t62teUIO
         6vzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700592788; x=1701197588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MJviHtyv8L1V4pX3J+mGOhL9XRHlVW6pwIEatSbK/o=;
        b=AtHvu7MNdmmhsDVlyHYB6eV/F3dS58A3FtGCGGR4QKUW9ZukCN5XZ/bUCWeTe32l7B
         dEAZRsiX1JL1ELAJo9eacjClY0GHhjmgMvVUWWIMdgBQOWPQ9krrirumazkkp7QlloKG
         QgvuwrsmdCGPvDSNUANvNBa69+tjdZLhT7KrxSUeD3qziaGxmHaEwA2c0inmUZqxVahM
         1Zkh5uKgCWSeIHE6P/y6eR85UST7Oie93y/hnakVZKbmCJbfDWbU7l14NVcjYvteLaZJ
         4u0UkYj0Y2NQTgv/hxFmooqiegjrpHyrJeraJXXqjOMS0Nah28D/AsrlWlrWkm2Iqn2+
         AXwA==
X-Gm-Message-State: AOJu0YzDw49iLrmO++c8PTrqS8VOow1OpvWGpyeMUkkbIDZ/FyS6lSMk
        ykfw+oaabPwY57yK0qHd5bEIhQIbOqGMrFpDIZc=
X-Google-Smtp-Source: AGHT+IE4CuBHJccxLbxl9uGN4mYz2Nq3566nDVcfvuXoHLGqjwkxWr/FWzsJgyhoRhGglObIvVU6uSnFU4vVZm9S4z0=
X-Received: by 2002:a05:6870:bacf:b0:1f9:5155:b135 with SMTP id
 js15-20020a056870bacf00b001f95155b135mr187608oab.39.1700592787805; Tue, 21
 Nov 2023 10:53:07 -0800 (PST)
MIME-Version: 1.0
References: <20231121043621.9351-1-u202112078@hust.edu.cn> <bac617fe-6b23-411f-8dc9-c97cc84208f3@amd.com>
In-Reply-To: <bac617fe-6b23-411f-8dc9-c97cc84208f3@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 21 Nov 2023 13:52:56 -0500
Message-ID: <CADnq5_P-Wr8C75vueF_oEqfp+PB2rf8KcJE8z4Xtd84jLB96bA@mail.gmail.com>
Subject: Re: [PATCH] gpu: display: remove unnecessary braces to fix coding style
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     RutingZhang <u202112078@hust.edu.cn>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 4:27=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 21.11.23 um 05:36 schrieb RutingZhang:
> > checkpatch complains that:
> >
> > WARNING: braces {} are not necessary for single statement blocks
> > +                if (pool->base.irqs !=3D NULL) {
> > +                        dal_irq_service_destroy(&pool->base.irqs);
> > +                }
> >
> > Fixed it by removing unnecessary braces to fix the coding style issue.
> >
> > Signed-off-by: RutingZhang <u202112078@hust.edu.cn>
> > Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
>
> Subject line prefix should be "drm/amdgpu".
>
> Apart from this nit it looks good to me, but might be already fixed
> internally.

Applied.  Thanks!

Alex

>
> Regards,
> Christian.
>
> > ---
> >   drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/dr=
ivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> > index 447de8492594..6835dbb733a2 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> > @@ -713,9 +713,8 @@ static void dcn21_resource_destruct(struct dcn21_re=
source_pool *pool)
> >                       pool->base.hubps[i] =3D NULL;
> >               }
> >
> > -             if (pool->base.irqs !=3D NULL) {
> > +             if (pool->base.irqs !=3D NULL)
> >                       dal_irq_service_destroy(&pool->base.irqs);
> > -             }
> >       }
> >
> >       for (i =3D 0; i < pool->base.res_cap->num_ddc; i++) {
>

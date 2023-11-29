Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34AB7FDC28
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjK2QDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjK2QDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:03:52 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72811D5C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:03:59 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1f9efd5303cso3639063fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701273836; x=1701878636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7UzJljfmHlY261/3G0aNDMRQkGttOqN4meo5L3GUQc=;
        b=kL9M8ObDNtwxcwV6CkWC2if56952gmg0x0BXwf6ul37+GQQ3MtBOrkS4p4pjZTai2f
         6j0Jw0yEi5Az/olt760ThTt2qpGbpsdXeP1Oq2UofNnpacwI1mGCctwCYNwYLTGOlUS1
         cEKwPAwc2Ki/auIlJ82OExwIGoCAogSD/opPp5FDfX+kEyneX0Wou2mZ909cuDB5YV5x
         m3b+DvuMuK1hCo3rqY+9gK3NL3ud5Upyp1iMCUfVRxxqher8DOSD7tgaaxqDsezYTERg
         nmEoxR6zjMTEhZ5mPtOVlsS9KFzHLAXoWNRuv6fqOOboNu2aEVBLy+sPcl/fTbfFTPis
         HBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701273836; x=1701878636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7UzJljfmHlY261/3G0aNDMRQkGttOqN4meo5L3GUQc=;
        b=t/mHZiujRmtvOaaUyfsc41TW06h0I7+x9Ptmh6V+h+JvUkvh9dovvmWYyGoiwvzEbm
         kcrs0HBoeKUBCwquFbXsi4FDYFyl7GRReVxYTo6w8TTIfthTWly465BJQOt3EZ3zTxk/
         7BEtLPjCj8FN0iWD5+hFg8Z91E4yypmSO4KrZ41A8qtahTo64h1A1apBUubYFqrxHNHf
         RbX+JCAS71SIf8nK3piNRu2lbvTtoyhDu0h/f1cThDkgVn67NYtvD/eY6gze/mCjwabR
         fqJlpWvt/TiAjcDBdHTH6gCMTQQG5Vq2s/loYm8idTkPMBOIeiUxM8g0ASGyIe34cVki
         g10w==
X-Gm-Message-State: AOJu0YwVhF/zOGFoPr2uBfuUQfuPYUxodn2UeV7cdiFhy4MO0XCZ77wH
        oOUIgkn73KPcHJMBOJPAPxo4Tyb5lVs8f2EZ3nmrb16s
X-Google-Smtp-Source: AGHT+IHoiXJZJAh5s4piufZ3+jeW0dyXseOkzVDXDHtjOgJ+lFkK8YIUj/kC/67GEby9dpMyF6D+LaQMEnf6B2u6Dj4=
X-Received: by 2002:a05:6870:82a8:b0:1f9:5cba:10f with SMTP id
 q40-20020a05687082a800b001f95cba010fmr23212183oae.38.1701273835699; Wed, 29
 Nov 2023 08:03:55 -0800 (PST)
MIME-Version: 1.0
References: <20231129152230.7931-1-n.zhandarovich@fintech.ru> <6a26b0c9-cbea-4ca2-bc16-79ed53e3a6fe@amd.com>
In-Reply-To: <6a26b0c9-cbea-4ca2-bc16-79ed53e3a6fe@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 29 Nov 2023 11:03:44 -0500
Message-ID: <CADnq5_P-Bxghq4N4GXZXUNwGR5BPyU2qQXDYzDeNkvn=VSTfwg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/r600_cs: Fix possible int overflows in r600_cs_check_reg()
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 10:47=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 29.11.23 um 16:22 schrieb Nikita Zhandarovich:
> > While improbable, there may be a chance of hitting integer
> > overflow when the result of radeon_get_ib_value() gets shifted
> > left.
> >
> > Avoid it by casting one of the operands to larger data type (u64).
> >
> > Found by Linux Verification Center (linuxtesting.org) with static
> > analysis tool SVACE.
>
> Well IIRC cb_color_bo_offset is just 32bits anyway, so this doesn't
> change anything.

All of the GPU addresses in the structure are u64.  The registers are
32 bits which is why they are 256 byte aligned.  That said, I think
the MC on the chips supported by this code are only 32 bits so we
shouldn't see any addresses greater than 32 bits, but this seems like
good to do from a coding perspective.  Otherwise, we'll keep getting
this patch.

Alex


Alex

>
> Regards,
> Christian.
>
> >
> > Fixes: 1729dd33d20b ("drm/radeon/kms: r600 CS parser fixes")
> > Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> > ---
> >   drivers/gpu/drm/radeon/r600_cs.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/r600_cs.c b/drivers/gpu/drm/radeon/=
r600_cs.c
> > index 638f861af80f..6cf54a747749 100644
> > --- a/drivers/gpu/drm/radeon/r600_cs.c
> > +++ b/drivers/gpu/drm/radeon/r600_cs.c
> > @@ -1275,7 +1275,7 @@ static int r600_cs_check_reg(struct radeon_cs_par=
ser *p, u32 reg, u32 idx)
> >                       return -EINVAL;
> >               }
> >               tmp =3D (reg - CB_COLOR0_BASE) / 4;
> > -             track->cb_color_bo_offset[tmp] =3D radeon_get_ib_value(p,=
 idx) << 8;
> > +             track->cb_color_bo_offset[tmp] =3D (u64)radeon_get_ib_val=
ue(p, idx) << 8;
> >               ib[idx] +=3D (u32)((reloc->gpu_offset >> 8) & 0xffffffff)=
;
> >               track->cb_color_base_last[tmp] =3D ib[idx];
> >               track->cb_color_bo[tmp] =3D reloc->robj;
> > @@ -1302,7 +1302,7 @@ static int r600_cs_check_reg(struct radeon_cs_par=
ser *p, u32 reg, u32 idx)
> >                                       "0x%04X\n", reg);
> >                       return -EINVAL;
> >               }
> > -             track->htile_offset =3D radeon_get_ib_value(p, idx) << 8;
> > +             track->htile_offset =3D (u64)radeon_get_ib_value(p, idx) =
<< 8;
> >               ib[idx] +=3D (u32)((reloc->gpu_offset >> 8) & 0xffffffff)=
;
> >               track->htile_bo =3D reloc->robj;
> >               track->db_dirty =3D true;
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2D07FAD6A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjK0WXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbjK0WXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:23:03 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E2C26A2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:20:50 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-586a516755aso2569324eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701123649; x=1701728449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOCoZok9ZC4QmtYsZ8TfeK+iIljTTrbyrnD/jz9we80=;
        b=KSPmIhAp5y1qxCpj2vQ0V5fxZ22y8Cb67PTeKA0TdfTNRULl4gCqSTmy7ODjjc3T45
         G3jUqkYEAxlAfpL5MRL4p7sob0vnew90Gjc1DYz3wqcHuS2vkx+OUiXrwVNFfLbNW4YY
         vTRXdMBSyQsrL9DQX0wn1S/qyj0eIau9uYg3Mvyaiu2W3kOrlfKYm45V6g2ZsCaFzAGa
         3ifXrI6s8w3CblfrCq942yKIxW+cVeDjq8tv6VcI7j2QEtXvGARnNNh1H/5PRIUkJTTj
         U6PBH433e1fdKhJSb4TqmZ1RETxFQsUdHngH7pkp+iyIr9yl4+9YP3F2s7xbJLi4LoYJ
         dPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123649; x=1701728449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOCoZok9ZC4QmtYsZ8TfeK+iIljTTrbyrnD/jz9we80=;
        b=LYP17deBODUkhO4EvgvOqKXLWhRLD+a4Ic8OBTIa4MzEYxD2E7R4YY7tdDyfkqRt44
         g3uCU68rQMeRntunuGApwS2v325EvWmZl2WOxTbIOawgVJt7uu6Sr6pkZEmQFY3wxzuv
         JqUA5owB9LD/dSLKbgjPDseYUhdaod9F5I3RJQdXy6Ufv6DiS5hkuXX+BVA5MVQ6tzJz
         7EThbIQJsZFloCPUh/FO7ntKIYHVjJuF7XsgVgCnIp0QiXReK8+x5W7AnRcvToZmY/5W
         YULPLJIiZ17POFZTRVnl6aq0493ng7TwFmVOaIb1iNxAPDnPXr8GFxeFfXaCU0bYmV1q
         01hQ==
X-Gm-Message-State: AOJu0YwQLIocpx6N1CEwtbPBABDjAn0L6U4y/W4g5DUlz4GY427yK21H
        9BRbs2Rwz5NdHgOJDlfnUtHCaU971UOTVCoh4Q8=
X-Google-Smtp-Source: AGHT+IG606uGqVxVZUsnYhGnoio+vCyrTchzuHhHlW4YCPROWTyaN9UgJO6ZL1UuPP5MxYL7nL/3g2frkr9mEuro9o0=
X-Received: by 2002:a05:6870:1603:b0:1f9:eb7e:6621 with SMTP id
 b3-20020a056870160300b001f9eb7e6621mr6732690oae.18.1701123649584; Mon, 27 Nov
 2023 14:20:49 -0800 (PST)
MIME-Version: 1.0
References: <20231122093509.34302-1-yaolu@kylinos.cn> <20231123012234.5783-1-yaolu@kylinos.cn>
 <80ea6067-c531-4765-8576-265e565525fa@amd.com>
In-Reply-To: <80ea6067-c531-4765-8576-265e565525fa@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 27 Nov 2023 17:20:38 -0500
Message-ID: <CADnq5_M7TjyM5n7X1mvxRzrckd4meVsvJMrMyt-BpciEPcqC-Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Fix cat debugfs amdgpu_regs_didt causes
 kernel null pointer
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Lu Yao <yaolu@kylinos.cn>, airlied@gmail.com, daniel@ffwll.ch,
        alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Applied.  Thanks!

Alex

On Thu, Nov 23, 2023 at 3:22=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 23.11.23 um 02:22 schrieb Lu Yao:
> > For 'AMDGPU_FAMILY_SI' family cards, in 'si_common_early_init' func, in=
it
> > 'didt_rreg' and 'didt_wreg' to 'NULL'. But in func
> > 'amdgpu_debugfs_regs_didt_read/write', using 'RREG32_DIDT' 'WREG32_DIDT=
'
> > lacks of relevant judgment. And other 'amdgpu_ip_block_version' that us=
e
> > these two definitions won't be added for 'AMDGPU_FAMILY_SI'.
> >
> > So, add null pointer judgment before calling.
> >
> > Signed-off-by: Lu Yao <yaolu@kylinos.cn>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> > Changes in v2:
> >    1. Drop dev_err message.
> >    2. Change error code from 'EPERM' to 'EOPNOTSUPP'
> > Link to v1: https://lore.kernel.org/all/20231122093509.34302-1-yaolu@ky=
linos.cn/
> > Thanks Christian for his comments.
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_debugfs.c
> > index a53f436fa9f1..e098cd66fa2a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > @@ -638,6 +638,9 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct=
 file *f, char __user *buf,
> >       if (size & 0x3 || *pos & 0x3)
> >               return -EINVAL;
> >
> > +     if (adev->didt_rreg =3D=3D NULL)
> > +             return -EOPNOTSUPP;
> > +
> >       r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> >       if (r < 0) {
> >               pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> > @@ -694,6 +697,9 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struc=
t file *f, const char __user
> >       if (size & 0x3 || *pos & 0x3)
> >               return -EINVAL;
> >
> > +     if (adev->didt_wreg =3D=3D NULL)
> > +             return -EOPNOTSUPP;
> > +
> >       r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> >       if (r < 0) {
> >               pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>

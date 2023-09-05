Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DD9792CA2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjIERnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjIERmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:42:36 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7693EDE7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 10:21:42 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3ab3aa9ae33so1244298b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 10:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693934434; x=1694539234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egYVobOFWuQdqjUEm4ZqKsY7Z50WC1t7+JHeJD3kmhA=;
        b=UsOXt8428Ah/d2nvggeCD7CpIJpYQp1uzM2U8dLjrnif/EKHSWSr7bDBNLR5XWkROk
         LNChe4i4Mt0ll+wC4gflYncwgC1mlU6BX+dPZoEr65W1HgmJZ+MyN1zovs/6Gq/8/kan
         ElsUBaeTuJIs32NGi6+epPdoKX6HsgVTfG4SIWiL1JcOuu6ksE6094VrHAmoSv4cY3ba
         vE8BHcUY54VtaSaGKDT/FKPEMUbZlcROsF6rjymrXEAfyc/pBZkFzVdKuUWF5ZwFuOXq
         wIikVqFSzkxUpQCikN4MNyJ46oZ/WGZtLF3mc8Lmw1elSJDA54t1yGIRWqu9xGL3i8+o
         PBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693934434; x=1694539234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egYVobOFWuQdqjUEm4ZqKsY7Z50WC1t7+JHeJD3kmhA=;
        b=cVa2LXW6kXVI8YDJvxWaAyDMmFmhEalpys4Xa8rF09+bXUW2cScFDOvYD7fsNlBTZm
         jrFpzTunrKsOK2Y7X2fxvDWxbG4WGFFK0rXqnULZEAVyOmUt44ISOUL8x4wlX1g1UERU
         5aVnu87YwWU5VDeMtcGvlI40vS8vjdQeH6/woare+qoi6kNc7QidNLJaS6j+y93yR08+
         22ng01AYtQginvnxE2R7r+XxcPMh6745ZTwBGKndsF1ujB8pYHIJPk3ALo8PfAEqogbU
         cZ03eh4SdrZvB379NrC7IZ/FOtMVgOE8V7h/TCybnBI+h/x2u9kdzYCHJDPYwOC/r6nw
         uf6g==
X-Gm-Message-State: AOJu0YwS1jO0cFR7grQ9edZDIASHuwxrrafjGJbCRzb1QCMdZIFTwfPp
        2jeqVnXrkzKszTl77/kQSlpfuFeO+9GmU/nHQJKuyRc/
X-Google-Smtp-Source: AGHT+IH3pexwwwaLVpB98fPK/JpecnRxp70TiquGAO7pJC/SgsuI+6nqiWAxDzNgHEj6QTnxUCmibNW7V0by24Ms4z0=
X-Received: by 2002:a05:6808:1304:b0:3a7:65ae:9ccf with SMTP id
 y4-20020a056808130400b003a765ae9ccfmr17483691oiv.22.1693934434263; Tue, 05
 Sep 2023 10:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230901070240.31027-1-jiapeng.chong@linux.alibaba.com> <a975bbdb-8cd9-35b2-ce98-f711439db3a5@amd.com>
In-Reply-To: <a975bbdb-8cd9-35b2-ce98-f711439db3a5@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 5 Sep 2023 13:20:23 -0400
Message-ID: <CADnq5_O9zME2oxfSB1Gy6NMfOietEqN08Os36s6Vc2Kpdj0VQQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: clean up some inconsistent indenting
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Xinhui.Pan@amd.com, Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
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

Applied and dropped the printk.

Alex

On Fri, Sep 1, 2023 at 3:40=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> Am 01.09.23 um 09:02 schrieb Jiapeng Chong:
> > No functional modification involved.
> >
> > drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c:34 nbio_v7_11_get_rev_id() warn=
: inconsistent indenting.
>
>
> We should probably not have a printk here in the first place.
>
> Christian.
>
> >
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D6316
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/=
amd/amdgpu/nbio_v7_11.c
> > index 7c08e5f95e97..76e21357dd4d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
> > @@ -31,10 +31,9 @@
> >   static u32 nbio_v7_11_get_rev_id(struct amdgpu_device *adev)
> >   {
> >       u32 tmp;
> > -         printk("%s, getid\n",__func__);
> > -
> > -             tmp =3D RREG32_SOC15(NBIO, 0, regRCC_STRAP1_RCC_DEV0_EPF0=
_STRAP0);
> >
> > +     printk("%s, getid\n", __func__);
> > +     tmp =3D RREG32_SOC15(NBIO, 0, regRCC_STRAP1_RCC_DEV0_EPF0_STRAP0)=
;
> >       tmp &=3D RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F=
0_MASK;
> >       tmp >>=3D RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_=
F0__SHIFT;
> >
>

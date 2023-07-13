Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8F9751CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbjGMJOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjGMJOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:14:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C93A19BC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689239642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EINzy8OMuu+nLPtYF3xlSMnhvtIBY4/1ybYAlD/eApY=;
        b=axyd7YLGtrvTWGQqm5GM5ZswI9ooU/AQl4yMRKZATOxoVyvuOWuWaGXPvQk3I1DPllxkXt
        XEkdv4ugDSXc0UyFSqcwmEEp5N46yfN3Nn2mKqnoXWnJFJfbBf6WVtlxERFneIwMu40ZGx
        nxW1e3anjGYT4mTOH1MftUmKg6i4n6g=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-2Ia3RGDvNIq8NOZ5_9Kv3g-1; Thu, 13 Jul 2023 05:14:00 -0400
X-MC-Unique: 2Ia3RGDvNIq8NOZ5_9Kv3g-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4fbca600934so109813e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689239639; x=1691831639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EINzy8OMuu+nLPtYF3xlSMnhvtIBY4/1ybYAlD/eApY=;
        b=LJFz32XMMmibhC51OQQr+udvfDIZY4h/A2YQyoUDLKz1FTQeU6EasA7Kv82+LYJXmQ
         KjTFqXWz9IVouEqi0i4nYuQ83jeIoa+w9+0yB0VEgKpNjHlzUd5FU2BlCSFaI4PfmCpH
         FKtFELkJ9HcX5FbCsWdxMTBpA8nNYKxbDVxT+2kXBOmG06E4cOVr9Xugi7A36adg1CjY
         KtZ7MAVSF2uk1PI6kQKIQlt8FNs2B43MAPrGtvILTvu6XiV/lwTJ4jHSEEDybwL/4cci
         Y0RG861eNUcOT36dGRFtc8/idSP5EpPqZKtQv5ED+FJA+jNh8be2Xx0AZh+hpGJXRbQU
         yYrQ==
X-Gm-Message-State: ABy/qLZGK+RAXcDXNpIT9MdsRhLcyCCYmuKacymxDGyY5aHvpH662ox6
        H8jSKk+HHJLcktQRk9Qn5RSKvvmV51lUcFV6ZklETxb61Js0q8eCyBHxCG9TllWwgW2emBCZVM1
        dfdBHQ7f9zIVG59WEt6u6MAbJkUKEQsQg72VeZbYZ
X-Received: by 2002:a05:651c:198a:b0:2b6:120a:af65 with SMTP id bx10-20020a05651c198a00b002b6120aaf65mr1098584ljb.3.1689239639061;
        Thu, 13 Jul 2023 02:13:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF9pWLznHO6dCvVxwuohZtwG1kEt1OdgiJxyzIeD3eMvB3IqEKi9luli955rnWYGXvh91SLOIVoA6r9lksfANY=
X-Received: by 2002:a05:651c:198a:b0:2b6:120a:af65 with SMTP id
 bx10-20020a05651c198a00b002b6120aaf65mr1098567ljb.3.1689239638795; Thu, 13
 Jul 2023 02:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230710070505.53916-1-xujianghui@cdjrlc.com> <1ddf673283e93e83d912066f2241b976@208suo.com>
 <ZKvK4NXzkKZTE35E@debian.me>
In-Reply-To: <ZKvK4NXzkKZTE35E@debian.me>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 13 Jul 2023 11:13:47 +0200
Message-ID: <CACO55tuG+4=4MTGq=FRuuP8dJaAHwtMCy3e9H8v5d8dVGsnkJw@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/iccsense:
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     sunran001@208suo.com, airlied@gmail.com, daniel@ffwll.ch,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 11:10=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.co=
m> wrote:
>
> On Mon, Jul 10, 2023 at 03:06:47PM +0800, sunran001@208suo.com wrote:
> > Fixed error: 'do not use assignment in if condition'
> >
> > This patch fixes error: 'do not use assignment in if condition'
> > in drm/nouveau/iccsense
>
> I guess this is checkpatch fix, right?
>
> >
> > Signed-off-by: Ran Sun <sunran001@208suo.com>
> > ---
> >  drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> > b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> > index 8f0ccd3664eb..2428f3d6e477 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> > @@ -322,7 +322,8 @@ int
> >  nvkm_iccsense_new_(struct nvkm_device *device, enum nvkm_subdev_type t=
ype,
> > int inst,
> >             struct nvkm_iccsense **iccsense)
> >  {
> > -    if (!(*iccsense =3D kzalloc(sizeof(**iccsense), GFP_KERNEL)))
> > +    *iccsense =3D kzalloc(sizeof(**iccsense), GFP_KERNEL);
> > +    if (!*iccsense)
> >          return -ENOMEM;
> >      INIT_LIST_HEAD(&(*iccsense)->sensors);
> >      INIT_LIST_HEAD(&(*iccsense)->rails);
>
> Your patch is corrupted (tabs converted to spaces) because you're using
> Roundcube. Please use git-send-mail(1) instead.
>

oh right, I didn't notice with the patches I reviewed already here.
Yeah, none of them apply, please use git to send those patches.

> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara


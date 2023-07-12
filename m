Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984227511E1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 22:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjGLUjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 16:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGLUjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 16:39:11 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C6A10E2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 13:39:10 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb7373dd35so1538857e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 13:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689194348; x=1691786348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3Aw+/y9y4d+i3cxzJxMrhK42+dQ+oiMMdAhC+nVYJU=;
        b=D65i0ZgJZryvUj4mF/jaQIHWSquZLHKSFoRxBZb00GXYUT8PREoM42YBQyW6a4GRuU
         tWmYjYU8Gnr1iRDSYv7vhgP5J2oCjk1eIOp+pQQMGDRkHi+14LjerjcTMo7JtIm+icr7
         8aZw9WlQLF1toaY62FQWLyftpPjTrrdykg9r7BElThk51Z+J4einHxBSlDsTBuYmszq8
         wo0TfaGUt6IItjuVuK/gEGhpssX7XD1nClK6Y+dlbFSZR4596hdUadHi+WMQjdkEt5tb
         S3LAYgHsil6bBeORflHQmb6wTlQdKc5f9MZeNe1ljdclQbjWoaxn0nchSittu4er0ZOy
         zPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689194348; x=1691786348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3Aw+/y9y4d+i3cxzJxMrhK42+dQ+oiMMdAhC+nVYJU=;
        b=EIgriym6aA1bhCR7scBAkN+o15TOy+CzjtWMOg7w+1+t+YoSS9vYV9h1zMNgDaTZ8E
         pcTUI5nunxcDi3aJUOFtaKj6yyGxOsFQc7sWGG80B1hb4VkksLDGdHKxXqcIMgu8adSK
         rpX9aCGRLEYaMsGkw2/geFwQsoD0GKN/AG1zm76eHu+L5Y710uWeT0GkbzFCt8Lq9X5h
         eFsJmiqMliVCAjbzgzajDzn5kCfU4qegQVdUb2365sV0a8W3kLZ5x0Hdy6neM6YRmaTy
         J0p19qMr9Tut7km/FjFO/kcTygVdfUF1aD8mCu75Jzzg+o8ZteP5TAKf/6QIYv4bkYgJ
         oh7Q==
X-Gm-Message-State: ABy/qLbp1RpX6gIjspY08MzQ67VSeJ13dg9cT74hgbezry8RhhLZ1uLm
        svPd07h4XuhWe4HC32Cow6yVsJJgt/zLE1FqFa4=
X-Google-Smtp-Source: APBJJlE4zSFvx6Zo3GKHIRV22wEE/iuCXt9jm8m6cfRi1vG5WKOsAupCfTIazj1pe2+m712CCradYuymkKMJMTKAtmc=
X-Received: by 2002:a05:6512:234d:b0:4f8:586a:d6ca with SMTP id
 p13-20020a056512234d00b004f8586ad6camr1125246lfu.9.1689194347888; Wed, 12 Jul
 2023 13:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230522201838.1496622-1-kherbst@redhat.com> <CACO55tuZeJZ6GTA+ooaXsSgde2Zy70qpe8Cg_AEfZRXtmd2LWA@mail.gmail.com>
 <CAPM=9txP3D8p9H=xCvBocFVssH=YP0h12FEOTnuTF7_pEUpRow@mail.gmail.com>
In-Reply-To: <CAPM=9txP3D8p9H=xCvBocFVssH=YP0h12FEOTnuTF7_pEUpRow@mail.gmail.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Thu, 13 Jul 2023 06:38:56 +1000
Message-ID: <CACAvsv6-AJ4EHg7pNUWgsnCN0CYrO8gWd3NR8pu32a-wXSOjeA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau/acr: Abort loading ACR if no
 firmware was found
To:     Dave Airlie <airlied@gmail.com>
Cc:     Karol Herbst <kherbst@redhat.com>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>, linux-kernel@vger.kernel.org,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gourav Samaiya <gsamaiya@nvidia.com>
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

On Thu, 13 Jul 2023 at 05:31, Dave Airlie <airlied@gmail.com> wrote:
>
> On Tue, 23 May 2023 at 19:37, Karol Herbst <kherbst@redhat.com> wrote:
> >
> > On Mon, May 22, 2023 at 10:18=E2=80=AFPM Karol Herbst <kherbst@redhat.c=
om> wrote:
> > >
> > > This fixes a NULL pointer access inside nvkm_acr_oneinit in case nece=
ssary
> > > firmware files couldn't be loaded.
> > >
> > > Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/212
> > > Fixes: 4b569ded09fd ("drm/nouveau/acr/ga102: initial support")
> > > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> > > ---
> > >  drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c b/drivers=
/gpu/drm/nouveau/nvkm/subdev/acr/base.c
> > > index 795f3a649b12..6388234c352c 100644
> > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c
> > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c
> > > @@ -224,7 +224,7 @@ nvkm_acr_oneinit(struct nvkm_subdev *subdev)
> > >         u64 falcons;
> > >         int ret, i;
> > >
> > > -       if (list_empty(&acr->hsfw)) {
> > > +       if (list_empty(&acr->hsfw) || !acr->func->wpr_layout) {
> >
> > Now thinking about this, it should probably also check acr->func...
>
> with that fixed if you think you need it,
I don't *think* you do.  I believe modprobe will fail for any case it
can be NULL.

>
> Reviewed-by: Dave Airlie <airlied@redhat.com>
>
> >
> > >                 nvkm_debug(subdev, "No HSFW(s)\n");
> > >                 nvkm_acr_cleanup(acr);
> > >                 return 0;
> > > --
> > > 2.40.1
> > >
> >

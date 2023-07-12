Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EFC751144
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 21:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjGLTbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 15:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjGLTbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:31:08 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4517C1FC3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:31:03 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b74791c948so6436794a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689190262; x=1691782262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVtSCpW+Tth4mC3MWGAVEkXOAuk+fenRNi3sCg0wW/s=;
        b=r32FMANDItl8SWdMt3H1qMFDlAHWoxWPe6MrEB33WVrdTB8FoKKtRmyAx5c6yFfK0e
         1oOPzWmuNc6xljTGS/Z3ai96BCd7pCg45e+Mv9tfebdsFfxen9ScPuKZHpaJGC/4EQv+
         J1/KhQ5rUKe0SFwZ/8/5bbM3Mn7TINH3RXSbno8ZRUvc6MTmhZlHZ8Ih71+15+c9jfR2
         CjxvCRzZBzoQ9J3PUoJqXnwgHHlpNcC0ZF1szDyIyPteTEErrvpAfhbKAl0XqeufIRaN
         sjL8Wt+uGr7P+5xN+x7EFC+Ha50BJcGI0UCqoNr733Z/dyLS0NZjjZbGHe8F+jsYAbNm
         Qdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689190262; x=1691782262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVtSCpW+Tth4mC3MWGAVEkXOAuk+fenRNi3sCg0wW/s=;
        b=Gy1reS3U4r558IVCXjt+Bkome0VjBpS/ha2Aie9Xl74PeqQWVKH/0ulIk1y6hkyn0S
         BPX3+6GANji+mu2LvX/qi/zY+NbccaQpHzN2/SLOU23X4LXNTdlRimUP8I4UTlH11z2P
         WnE7J6Lt5iiQjMi1Ih4RqSdJvUMYTjKR49mYqUn8KNXDELI+svvJGdzQGVDe75TtB3gZ
         bZFwA+LY3hyLSV/f5zs/miBvM3oui1fNxtYMmABwxsI87EiwLfOxhp/y7l/gR3DGSbmj
         3ZrckX3IJCFv2PvUzaHccTFX9cqJRnZdKmg8qBIyx1SxfjVpCjcXYl8ELTwFVgRAWBQv
         gIpQ==
X-Gm-Message-State: ABy/qLZUwn4pNmCfyX6AuOmxPgG0P2+uhSFWFSUirexShCQsMpix0NpY
        q/FN7IDviz4TmAz1npb3KI8n5waUS3nIc5ztltLud3Sv
X-Google-Smtp-Source: APBJJlEt110G42kGYTiSWg5RkQiygRnhzKc4MikyaoVcdGUWksdFdFLUXc1bxTG+gXM5gOw+VMyJ2yO+C7wyuDUzvdI=
X-Received: by 2002:a05:6870:b24e:b0:1b3:e46a:7164 with SMTP id
 b14-20020a056870b24e00b001b3e46a7164mr21502131oam.40.1689190262500; Wed, 12
 Jul 2023 12:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230522201838.1496622-1-kherbst@redhat.com> <CACO55tuZeJZ6GTA+ooaXsSgde2Zy70qpe8Cg_AEfZRXtmd2LWA@mail.gmail.com>
In-Reply-To: <CACO55tuZeJZ6GTA+ooaXsSgde2Zy70qpe8Cg_AEfZRXtmd2LWA@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 13 Jul 2023 05:30:49 +1000
Message-ID: <CAPM=9txP3D8p9H=xCvBocFVssH=YP0h12FEOTnuTF7_pEUpRow@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/acr: Abort loading ACR if no firmware was found
To:     Karol Herbst <kherbst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
        Gourav Samaiya <gsamaiya@nvidia.com>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>
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

On Tue, 23 May 2023 at 19:37, Karol Herbst <kherbst@redhat.com> wrote:
>
> On Mon, May 22, 2023 at 10:18=E2=80=AFPM Karol Herbst <kherbst@redhat.com=
> wrote:
> >
> > This fixes a NULL pointer access inside nvkm_acr_oneinit in case necess=
ary
> > firmware files couldn't be loaded.
> >
> > Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/212
> > Fixes: 4b569ded09fd ("drm/nouveau/acr/ga102: initial support")
> > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> > ---
> >  drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c b/drivers/g=
pu/drm/nouveau/nvkm/subdev/acr/base.c
> > index 795f3a649b12..6388234c352c 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c
> > @@ -224,7 +224,7 @@ nvkm_acr_oneinit(struct nvkm_subdev *subdev)
> >         u64 falcons;
> >         int ret, i;
> >
> > -       if (list_empty(&acr->hsfw)) {
> > +       if (list_empty(&acr->hsfw) || !acr->func->wpr_layout) {
>
> Now thinking about this, it should probably also check acr->func...

with that fixed if you think you need it,

Reviewed-by: Dave Airlie <airlied@redhat.com>

>
> >                 nvkm_debug(subdev, "No HSFW(s)\n");
> >                 nvkm_acr_cleanup(acr);
> >                 return 0;
> > --
> > 2.40.1
> >
>

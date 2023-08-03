Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2580276EE3F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbjHCPfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbjHCPfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:35:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B233AB2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691076897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GAn60s5VL8+3FWf4gqWswaZZmaZpliVGHrn8c7NwxLc=;
        b=XNktx60WFw8epYmRkMJ5rM13O2OviH3vMMW6anJfX0VglUELfE8jNoC1dysUGB/w/UcaBt
        pypx3lxiGw7lELcPmYBM7mOgAZIjTKNYObQQQWjOMig8m06/L1XXsTg0+hX5m0Emtu8TEZ
        R7hs0vNfiQBigPgSDUGB+GnRLbEBeQs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-D3sLpWfhMv2GD2PDUGwQ6A-1; Thu, 03 Aug 2023 11:34:56 -0400
X-MC-Unique: D3sLpWfhMv2GD2PDUGwQ6A-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b04d5ed394so1646591fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 08:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691076894; x=1691681694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAn60s5VL8+3FWf4gqWswaZZmaZpliVGHrn8c7NwxLc=;
        b=CRFOqQaUf2SRp1EGdbg8ZNpiHH4XDdPg9G+9/bJR8Pgd/4sq/+jTqehpP8DufJPG+8
         tOvCGCXr1ArqQ6yWC/JZwLW6yyualqOaP6SIftY2u86b54W569oyVximvNrTGGuUljNL
         Cw+TN4QdpR3qf1WZ8BjgzD1V5+vsBv2nw2bNrbF9o1FYHifjwm7OGJBgN5pSDjavgqvw
         qS2k7ALedehtELy3dnThmDb5zwTVX1a4ehR2IADciq5w6L27awLY0aTT6fKCkZB8aGw4
         JfMvP+R5u5yNlrjWzQ7n5ZL9ytozf9mrV7OQosxyrmUGgNQF8jpoLzrSZBdKHPfsWCYE
         67lg==
X-Gm-Message-State: ABy/qLZ4THDdpOxb6knoJPSFPxYseZMY+NHizKeB5haBcoVZ/YDQGuvU
        L8yOw7gZ+YyfDy0fsFALA/ddCryzbd7ZllABKLAq9gDmBAdnlDwwOcJzZgi8g1GQnhYoA+TPYOs
        TcV/rr5inIKBh17GLqM5qSIHVq5O0AvGPN/j5rprd
X-Received: by 2002:a2e:a7cf:0:b0:2b6:9969:d0ab with SMTP id x15-20020a2ea7cf000000b002b69969d0abmr12388653ljp.4.1691076894709;
        Thu, 03 Aug 2023 08:34:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEz/wDErpCcQsXauXulvVlKBxx8fIp7/uctE6vRdS4DBK25r+JCF/5qhcGyR21XS9Fl91S59IuTEBpqIWDsIHQ=
X-Received: by 2002:a2e:a7cf:0:b0:2b6:9969:d0ab with SMTP id
 x15-20020a2ea7cf000000b002b69969d0abmr12388632ljp.4.1691076894406; Thu, 03
 Aug 2023 08:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230803143358.13563-1-arnd@kernel.org>
In-Reply-To: <20230803143358.13563-1-arnd@kernel.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 3 Aug 2023 17:34:43 +0200
Message-ID: <CACO55tskNHHpEjQK-+wBR+nVgz+Fq31U0_FKmNGSL2JDCMnJUA@mail.gmail.com>
Subject: Re: [PATCH] [RESEND] drm/nouveau: remove unused tu102_gr_load() function
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        Gourav Samaiya <gsamaiya@nvidia.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Thu, Aug 3, 2023 at 4:34=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> tu102_gr_load() is completely unused and can be removed to address
> this warning:
>
> drivers/gpu/drm/nouveau/dispnv50/disp.c:2517:1: error: no previous protot=
ype for 'nv50_display_create'
>
> Another patch was sent in the meantime to mark the function static but
> that would just cause a different warning about an unused function.
>
> Fixes: 1cd97b5490c8 ("drm/nouveau/gr/tu102-: use sw_veid_bundle_init from=
 firmware")
> Link: https://lore.kernel.org/all/CACO55tuaNOYphHyB9+ygi9AnXVuF49etsW7x2X=
5K5iEtFNAAyw@mail.gmail.com/
> Link: https://lore.kernel.org/all/20230417210310.2443152-1-arnd@kernel.or=
g/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I send this one back in April, and Lee Jones sent a similar patch in May.
> Please apply so we can enable the warning by default.
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c b/drivers/gpu=
/drm/nouveau/nvkm/engine/gr/tu102.c
> index 3b6c8100a242..a7775aa18541 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c
> @@ -206,19 +206,6 @@ tu102_gr_av_to_init_veid(struct nvkm_blob *blob, str=
uct gf100_gr_pack **ppack)
>         return gk20a_gr_av_to_init_(blob, 64, 0x00100000, ppack);
>  }
>
> -int
> -tu102_gr_load(struct gf100_gr *gr, int ver, const struct gf100_gr_fwif *=
fwif)
> -{
> -       int ret;
> -
> -       ret =3D gm200_gr_load(gr, ver, fwif);
> -       if (ret)
> -               return ret;
> -
> -       return gk20a_gr_load_net(gr, "gr/", "sw_veid_bundle_init", ver, t=
u102_gr_av_to_init_veid,
> -                                &gr->bundle_veid);
> -}
> -
>  static const struct gf100_gr_fwif
>  tu102_gr_fwif[] =3D {
>         {  0, gm200_gr_load, &tu102_gr, &gp108_gr_fecs_acr, &gp108_gr_gpc=
cs_acr },
> --
> 2.39.2
>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

Will push to drm-misc in a sec


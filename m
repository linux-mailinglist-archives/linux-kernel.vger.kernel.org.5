Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB9E758CF2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjGSFR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjGSFR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:17:26 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4DE1FC3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 22:17:24 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fbbfaacfc1so10685306e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 22:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689743842; x=1692335842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gx9Abb9INC5EOsKVb3k5BkOEXlQkiI5XeDiYpmyACHE=;
        b=ik0PA+XyZ6EQ/iPxbOeyzFxJOT6AEKqgv5X0qSAxZFf6BrQMhiytm4lEtObYr+z1l/
         R92CB3J7nufWgv5X2vd+cyfYhE6bbuzh/GF6h0IH+Y/rZ3/Xz0ir/bGe6mdoms6oKgpv
         Od8BWJq6L7EI4PmPQuWh7mZlCyrLj2anYmaZxz9LpoqNqFCWpV5oQ5gH2gJo5uScvgQa
         XL2URV7ieiRCuHfm6vjzslUUwcLeqYr4Q/4oY+q7CHOc1LEAJrZpNLwJhlf7mR17RT/A
         IRRRQTrK9PDvyXojw1qbLs//XPiEdJvCdpOG4IBDLs74Wh0wk22Br0ILtgdRywnFSqrR
         O6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689743842; x=1692335842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gx9Abb9INC5EOsKVb3k5BkOEXlQkiI5XeDiYpmyACHE=;
        b=bibBcO/P60A9kFOOfSRSKYmKx8fyTSl0c+gQ7Xuy2Tm4zGyw0ygNmYEpjIXwAIj8oo
         VywgmuyuucEj0XiZ/1OobXzv4IQ0Gm1qkfo9QNL+aEGQOKx8qYxE0x5rGcMfGpnHETuE
         ewaIXTV4V0RKNWJrucoSmRD+NqUSWZzsIttoNVWwnWfpxUfmisjQEH9yNzHU4LHy3aY/
         2Y/S6wIYk8JMDtYQYM3refc+cULcAfcjTn63Hu+N5JDLKpgXErhq7FOzQGsrTdRRe+gK
         VkQ3DDIpKZk7cQ/A2siWQwBVUfRto3t9PsKNrAwjqsC1zjf9EvI7Ip/Ngswd+fdTQ+aM
         B0cQ==
X-Gm-Message-State: ABy/qLZI7DkGRQSGrd3qYkuMiGx9Rkq2xAqV7XaIluY8bZ9yCMy39Wua
        BP/7bkH+SEaTfsjO9YOnvShyXAWQERoUfGU62CrUQcRgq7c=
X-Google-Smtp-Source: APBJJlG4kEIE9+L4K9I3qpDvgrniK4lv3rFr3CmpqBIzXWyBnGue4o8nlEF85TgW7NuQkBwv9nyNeQ3tvFDxxDTDqSE=
X-Received: by 2002:a19:6703:0:b0:4f9:7aee:8dc5 with SMTP id
 b3-20020a196703000000b004f97aee8dc5mr10604774lfc.19.1689743842233; Tue, 18
 Jul 2023 22:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230707215851.590754-1-lyude@redhat.com>
In-Reply-To: <20230707215851.590754-1-lyude@redhat.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Wed, 19 Jul 2023 15:17:10 +1000
Message-ID: <CACAvsv743W4i8ad=orgoUy+Hox0z2CL9rXw18od-oeiB=b25Xg@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/nvkm/dp: Add hack to fix DP 1.3+ DPCD issues
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Karol Herbst <kherbst@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2023 at 07:59, Lyude Paul <lyude@redhat.com> wrote:
>
> Currently we use the drm_dp_dpcd_read_caps() helper in the DRM side of
> nouveau in order to read the DPCD of a DP connector, which makes sure we do
> the right thing and also check for extended DPCD caps. However, it turns
> out we're not currently doing this on the nvkm side since we don't have
> access to the drm_dp_aux structure there - which means that the DRM side of
> the driver and the NVKM side can end up with different DPCD capabilities
> for the same connector.
>
> Ideally to fix this, we want to start setting up the drm_dp_aux device in
> NVKM before we've made contact with the DRM side - which should be pretty
> easy to accomplish (I'm already working on it!). Until then however, let's
> workaround this problem by porting a copy of drm_dp_read_dpcd_caps() into
> NVKM - which should fix this issue.
I wouldn't worry about this.  I'm moving basically everything to the
DRM side of the driver for the GSP work anyway.

Ben.
>
> Issue: https://gitlab.freedesktop.org/drm/nouveau/-/issues/211
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c | 48 ++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c
> index 40c8ea43c42f..b8ac66b4a2c4 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c
> @@ -26,6 +26,8 @@
>  #include "head.h"
>  #include "ior.h"
>
> +#include <drm/display/drm_dp.h>
> +
>  #include <subdev/bios.h>
>  #include <subdev/bios/init.h>
>  #include <subdev/gpio.h>
> @@ -634,6 +636,50 @@ nvkm_dp_enable_supported_link_rates(struct nvkm_outp *outp)
>         return outp->dp.rates != 0;
>  }
>
> +/* XXX: This is a big fat hack, and this is just drm_dp_read_dpcd_caps()
> + * converted to work inside nvkm. This is a temporary holdover until we start
> + * passing the drm_dp_aux device through NVKM
> + */
> +static int
> +nvkm_dp_read_dpcd_caps(struct nvkm_outp *outp)
> +{
> +       struct nvkm_i2c_aux *aux = outp->dp.aux;
> +       u8 dpcd_ext[DP_RECEIVER_CAP_SIZE];
> +       int ret;
> +
> +       ret = nvkm_rdaux(aux, DPCD_RC00_DPCD_REV, outp->dp.dpcd, DP_RECEIVER_CAP_SIZE);
> +       if (ret < 0)
> +               return ret;
> +
> +       /*
> +        * Prior to DP1.3 the bit represented by
> +        * DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT was reserved.
> +        * If it is set DP_DPCD_REV at 0000h could be at a value less than
> +        * the true capability of the panel. The only way to check is to
> +        * then compare 0000h and 2200h.
> +        */
> +       if (!(outp->dp.dpcd[DP_TRAINING_AUX_RD_INTERVAL] &
> +             DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT))
> +               return 0;
> +
> +       ret = nvkm_rdaux(aux, DP_DP13_DPCD_REV, dpcd_ext, sizeof(dpcd_ext));
> +       if (ret < 0)
> +               return ret;
> +
> +       if (outp->dp.dpcd[DP_DPCD_REV] > dpcd_ext[DP_DPCD_REV]) {
> +               OUTP_DBG(outp, "Extended DPCD rev less than base DPCD rev (%d > %d)\n",
> +                        outp->dp.dpcd[DP_DPCD_REV], dpcd_ext[DP_DPCD_REV]);
> +               return 0;
> +       }
> +
> +       if (!memcmp(outp->dp.dpcd, dpcd_ext, sizeof(dpcd_ext)))
> +               return 0;
> +
> +       memcpy(outp->dp.dpcd, dpcd_ext, sizeof(dpcd_ext));
> +
> +       return 0;
> +}
> +
>  void
>  nvkm_dp_enable(struct nvkm_outp *outp, bool auxpwr)
>  {
> @@ -689,7 +735,7 @@ nvkm_dp_enable(struct nvkm_outp *outp, bool auxpwr)
>                         memset(outp->dp.lttpr, 0x00, sizeof(outp->dp.lttpr));
>                 }
>
> -               if (!nvkm_rdaux(aux, DPCD_RC00_DPCD_REV, outp->dp.dpcd, sizeof(outp->dp.dpcd))) {
> +               if (!nvkm_dp_read_dpcd_caps(outp)) {
>                         const u8 rates[] = { 0x1e, 0x14, 0x0a, 0x06, 0 };
>                         const u8 *rate;
>                         int rate_max;
> --
> 2.40.1
>

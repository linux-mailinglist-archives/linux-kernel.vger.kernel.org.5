Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051E979F10F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjIMSVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjIMSV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:21:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177C019BF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:21:25 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9ad8bf9bfabso17897966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694629282; x=1695234082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nc0iKQaFbvx2OY31KmNWuTwAoAIg4JTwX3WveSIcUxk=;
        b=oUZ9PV8e935ursdhAkBJgyDO4xxPe7LrX7oO7sjvS2fgPJv+swVso6crjlJgyBp3yT
         HatF1znbxHj6NNqJPnhza4FwLhQEaeq86dsaAgyqa+bjje2HL6nj9r5N0t67Rz8FYCXw
         99tJtLL6gfdDsC2EkLbWisoUEY0KLGP+V12bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694629282; x=1695234082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nc0iKQaFbvx2OY31KmNWuTwAoAIg4JTwX3WveSIcUxk=;
        b=XWWSBKaj5S0IsJSZFaPi9FBYzv8ZQ8tC5LPmN5x2cVqprmvNvImvJzZQs4124SarRI
         wqyykmO8/WlSbpA4NioUA4KyLcEFxvQVTVAgioo+CkZsN0t2vFXvxMwucMHkAcczzVYs
         gkIdA8VdFMqnhBksPmr6/X9wmeGN6X8PYTGScg0DdjuK9UjMOcnDV+Tv+YucXjA5O8B4
         IdjVgXJb1jyFKZKRbr08SqyWcGgtcfLf+tdaVjxMqK5gHuLKVc038c6qHzHm+zu0IdYb
         RXdSy4U29kMiQl/iD3N8eWkjsqaeGAqzmGM5QkPCCmKf3VxWk3AlFDX+fh9LD2Rud7AR
         RJlA==
X-Gm-Message-State: AOJu0YwyWMy4KbDZF0rlBCqttjSHxDYJWRCBnchuSQ8LYteDGRjqVUEJ
        o3Tt+N8zoyObTy53nwNKRHaKSGbiu5FXJrZtcEVrJuum
X-Google-Smtp-Source: AGHT+IF4Y5/DjehuGw6TgmuPdI7jhRo2fJSRUYTaWgMCexrsbNh9OcetrWoJBhhxcun4W700Witjdg==
X-Received: by 2002:a17:907:2cc8:b0:9ad:7c48:3239 with SMTP id hg8-20020a1709072cc800b009ad7c483239mr2719000ejc.51.1694629282213;
        Wed, 13 Sep 2023 11:21:22 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id z19-20020a170906715300b009a2202bfce5sm8718813ejj.118.2023.09.13.11.21.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 11:21:21 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-402c80b71ecso11615e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:21:21 -0700 (PDT)
X-Received: by 2002:a05:600c:1c24:b0:401:a494:2bbb with SMTP id
 j36-20020a05600c1c2400b00401a4942bbbmr160360wms.5.1694629281276; Wed, 13 Sep
 2023 11:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230901234202.566951-1-dianders@chromium.org> <20230901164111.RFT.3.Iea742f06d8bec41598aa40378fc625fbd7e8a3d6@changeid>
In-Reply-To: <20230901164111.RFT.3.Iea742f06d8bec41598aa40378fc625fbd7e8a3d6@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 Sep 2023 11:21:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VFQUDP+_MoamvSW71ieGCZD5M9FJpZLgQWd_KZcj3OnA@mail.gmail.com>
Message-ID: <CAD=FV=VFQUDP+_MoamvSW71ieGCZD5M9FJpZLgQWd_KZcj3OnA@mail.gmail.com>
Subject: Re: [RFT PATCH 03/15] drm/ingenic: Call drm_atomic_helper_shutdown()
 at shutdown time
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     airlied@gmail.com, daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, paul@crapouillou.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 1, 2023 at 4:42=E2=80=AFPM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> Based on grepping through the source code this driver appears to be
> missing a call to drm_atomic_helper_shutdown() at system shutdown
> time. Among other things, this means that if a panel is in use that it
> won't be cleanly powered off at system shutdown time.
>
> The fact that we should call drm_atomic_helper_shutdown() in the case
> of OS shutdown/restart comes straight out of the kernel doc "driver
> instance overview" in drm_drv.c.
>
> Since this driver uses the component model and shutdown happens at the
> base driver, we communicate whether we have to call
> drm_atomic_helper_shutdown() by seeing if drvdata is non-NULL.
>
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This commit is only compile-time tested.
>
> NOTE: this patch touches a lot more than other similar patches since
> the bind() function is long and we want to make sure that we unset the
> drvdata if bind() fails.
>
> While making this patch, I noticed that the bind() function of this
> driver is using "devm" and thus assumes it doesn't need to do much
> explicit error handling. That's actually a bug. As per kernel docs [1]
> "the lifetime of the aggregate driver does not align with any of the
> underlying struct device instances. Therefore devm cannot be used and
> all resources acquired or allocated in this callback must be
> explicitly released in the unbind callback". Fixing that is outside
> the scope of this commit.
>
> [1] https://docs.kernel.org/driver-api/component.html
>
>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 66 +++++++++++++++--------
>  1 file changed, 44 insertions(+), 22 deletions(-)

[ ... cut ... ]

> @@ -1612,6 +1633,7 @@ static struct platform_driver ingenic_drm_driver =
=3D {
>         },
>         .probe =3D ingenic_drm_probe,
>         .remove =3D ingenic_drm_remove,
> +       .shutdown =3D ingenic_drm_shutdown,

I resolved the trivial conflict with commit 2b9b0a9fc548
("drm/ingenic: Convert to platform remove callback returning void"),
then pushed to drm-misc-next:

c3ca98396ffa (HEAD -> drm-misc-next) drm/ingenic: Call
drm_atomic_helper_shutdown() at shutdown time

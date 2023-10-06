Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2C47BB03D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 04:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjJFCUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 22:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjJFCUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 22:20:35 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B0CD8;
        Thu,  5 Oct 2023 19:20:33 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-405361bba99so14732525e9.2;
        Thu, 05 Oct 2023 19:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696558832; x=1697163632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7A6svaZ5NLBPCdvLBtrQYDjuifxfenalJYib+EmtrBE=;
        b=PMoIPAQSaPvXLyhyRrSc7Ymkz0KboMwITRzSOZxzm09doaHaeQOWDmKdpbUpW9ZZ9v
         bYxky/qlSBZ1CEn+pIYZrzXqmwIRcJd/UriB/FxkX+aae9q6FlPdZ8BqFh+OBrHR/D25
         OPQMdCYNlHXwuyF4sy4c/WVtCFUgEC+rEzy4gGv8omZtSIW9b83xUAVI4fXbgzmqctVJ
         yQtXJZb9q6Q/8R9GWLegUXhjTlz+mc5y4l57fNsfscJJ7g5m01JSdoAr3jQUjfepl9F7
         U/MRzN2AhESOAoJi9bO2DKMvZQnQPleprTRL4HQ6lNyU6aVhejb/uljEn/f0dC30ZjFL
         A6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696558832; x=1697163632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7A6svaZ5NLBPCdvLBtrQYDjuifxfenalJYib+EmtrBE=;
        b=s/Wlz1xEDvCC86cxSXTcYcbMTTWMTygaa0Kz6KkqfBDiox9RnSsfZmHFUX/YQnzFAX
         yIdmUVdS1Vp4yMT68RJppq5RRGtm/Tdsjy2y1UsWQqJ3VxkjOQIqWhr8dVkEIJ9Nc91S
         eC6tGVBrQE64cKE2qEfj0dyyDUIEbOQg2HwlpQ/KC//kwBQNERvVk8vk08w9Pibfv022
         nRZbfCaCNpw73hv3kKLMjU3SUKjAE5SXsRI4JFFaXKIrf4rXn0655ezDtwwzyFcndmLC
         /72+QfQYuucK9oW2lGm0MALhuk4JgqUUAKTVj3VVy8Tkrf/gaknniz6Zfw5OaluE8USZ
         ZkcA==
X-Gm-Message-State: AOJu0YyRf1t+HhuR0yKiY40u5jTV+uOLEGHgj7Zn1azsLe6NwYlvJlx9
        yG3VCsv/lj9K95kSaOAkB7oyvQMl+W7PZ3lZAitpuZWQuzg=
X-Google-Smtp-Source: AGHT+IEiTyzp02X3Gv5QGee69SJTznrbwBrw/DOEGtGOalihMEdXuCrKaMq/kTK3AF19NS06vrJBgOIphrRfedf5MxU=
X-Received: by 2002:adf:f546:0:b0:323:3421:9a9 with SMTP id
 j6-20020adff546000000b00323342109a9mr6326854wrp.60.1696558831882; Thu, 05 Oct
 2023 19:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230921192749.1542462-1-dianders@chromium.org>
 <CGME20230921194907eucas1p1027c5dfc5c5f77bca3c43673427c89cc@eucas1p1.samsung.com>
 <20230921122641.RFT.v2.9.Iea33274908b6b258955f45a8aaf6f5bba24ad6cd@changeid> <fb9cd62b-6637-7bcc-e23d-37f3806f8460@samsung.com>
In-Reply-To: <fb9cd62b-6637-7bcc-e23d-37f3806f8460@samsung.com>
From:   Inki Dae <daeinki@gmail.com>
Date:   Fri, 6 Oct 2023 11:19:54 +0900
Message-ID: <CAAQKjZNn4RTJ-SHHEugcQoS2U9fzNTOGtUpSLLM0w1V6Pb0amw@mail.gmail.com>
Subject: Re: [RFT PATCH v2 09/12] drm/exynos: Call drm_atomic_helper_shutdown()
 at shutdown/unbind time
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>,
        linux-samsung-soc@vger.kernel.org, alim.akhtar@samsung.com,
        sw0312.kim@samsung.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, kyungmin.park@samsung.com,
        linux-arm-kernel@lists.infradead.org
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

Thanks for testing. :)

Acked-by : Inki Dae <inki.dae@samsung.com>

2023=EB=85=84 9=EC=9B=94 22=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 3:00, M=
arek Szyprowski <m.szyprowski@samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
>
> On 21.09.2023 21:26, Douglas Anderson wrote:
> > Based on grepping through the source code this driver appears to be
> > missing a call to drm_atomic_helper_shutdown() at system shutdown time
> > and at driver unbind time. Among other things, this means that if a
> > panel is in use that it won't be cleanly powered off at system
> > shutdown time.
> >
> > The fact that we should call drm_atomic_helper_shutdown() in the case
> > of OS shutdown/restart and at driver remove (or unbind) time comes
> > straight out of the kernel doc "driver instance overview" in
> > drm_drv.c.
> >
> > A few notes about this fix:
> > - When adding drm_atomic_helper_shutdown() to the unbind path, I added
> >    it after drm_kms_helper_poll_fini() since that's when other drivers
> >    seemed to have it.
> > - Technically with a previous patch, ("drm/atomic-helper:
> >    drm_atomic_helper_shutdown(NULL) should be a noop"), we don't
> >    actually need to check to see if our "drm" pointer is NULL before
> >    calling drm_atomic_helper_shutdown(). We'll leave the "if" test in,
> >    though, so that this patch can land without any dependencies. It
> >    could potentially be removed later.
> > - This patch also makes sure to set the drvdata to NULL in the case of
> >    bind errors to make sure that shutdown can't access freed data.
> >
> > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > Reviewed-by: Maxime Ripard <mripard@kernel.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Seems to be working fine on all my test Exynos-based boards with display.
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> > ---
> > This commit is only compile-time tested.
> >
> > (no changes since v1)
> >
> >   drivers/gpu/drm/exynos/exynos_drm_drv.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/=
exynos/exynos_drm_drv.c
> > index 8399256cb5c9..5380fb6c55ae 100644
> > --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
> > +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
> > @@ -300,6 +300,7 @@ static int exynos_drm_bind(struct device *dev)
> >       drm_mode_config_cleanup(drm);
> >       exynos_drm_cleanup_dma(drm);
> >       kfree(private);
> > +     dev_set_drvdata(dev, NULL);
> >   err_free_drm:
> >       drm_dev_put(drm);
> >
> > @@ -313,6 +314,7 @@ static void exynos_drm_unbind(struct device *dev)
> >       drm_dev_unregister(drm);
> >
> >       drm_kms_helper_poll_fini(drm);
> > +     drm_atomic_helper_shutdown(drm);
> >
> >       component_unbind_all(drm->dev, drm);
> >       drm_mode_config_cleanup(drm);
> > @@ -350,9 +352,18 @@ static int exynos_drm_platform_remove(struct platf=
orm_device *pdev)
> >       return 0;
> >   }
> >
> > +static void exynos_drm_platform_shutdown(struct platform_device *pdev)
> > +{
> > +     struct drm_device *drm =3D platform_get_drvdata(pdev);
> > +
> > +     if (drm)
> > +             drm_atomic_helper_shutdown(drm);
> > +}
> > +
> >   static struct platform_driver exynos_drm_platform_driver =3D {
> >       .probe  =3D exynos_drm_platform_probe,
> >       .remove =3D exynos_drm_platform_remove,
> > +     .shutdown =3D exynos_drm_platform_shutdown,
> >       .driver =3D {
> >               .name   =3D "exynos-drm",
> >               .pm     =3D &exynos_drm_pm_ops,
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>

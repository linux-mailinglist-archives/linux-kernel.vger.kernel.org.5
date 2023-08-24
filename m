Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B8F7869E3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbjHXIVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjHXIUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:20:39 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CFC1710;
        Thu, 24 Aug 2023 01:20:38 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-565439b6b3fso3348208a12.2;
        Thu, 24 Aug 2023 01:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692865237; x=1693470037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zGAuBw4gPHtRJdaOH14piD/nNNygF6IcHXj9bWHwdo=;
        b=sMxR6fZNgXfWTXoyUrfQ6QsnCw0Z46C6iwKKpTEsxiKtRlJRX8qd28LbRaVysRw8Gs
         1UxR8Zqm9KLnvrx3EnrdFRVIYIKineXAaQpayjZ3amWyD7MhFQL4sgD65+x1aQkC+JUG
         0ww3TYIOBKani5h5mfwzqg8C2mvfMBywRbsJlPihyPRdvyR0F3F/RToRvchXLtDlF5Ft
         cJkLE0nuEbSg6hAMgx8Xl+HTyxoJ8C73Ikyk+z/+tYPURXAfMH+wSg2toiIZlGnsjKx2
         cIQ6oSaD8QH+woubJilDCfaW1DSMpVgB0+6BeagE4TAkYD/s7BIU2dW5vI9xZk4oMKKZ
         4fgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692865237; x=1693470037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zGAuBw4gPHtRJdaOH14piD/nNNygF6IcHXj9bWHwdo=;
        b=BB5NuV/rfqVY8EB57SfzqQj57F7Ijiq/ksfMXHIkw/KC3MkjxrdoYs7Qfw1MyXIq8d
         1UVksHvz70pDs90mS9N395bEkq/+7dOeE1OKb9Fcr5Rjo4X0pZ6V9X1mA9fahTo8f+vJ
         7pIfAlSCSYMmD2TPk9AXAeDCTexNh58geSfkqn0twFaCmYOKBtQZuN/utNJ6Lz8Id/X4
         juHo/kuglcj/HxFMZJFNmb/izdxD+WzIEHomvFwCKP/ovOB+Bh5x/UYEDcGvjVwicvUe
         6diN8Yz8K8iaSIIOo3fnQu0skgIgZWP1rM5ItwBnolhLjVhNHQSgiwTBCWeLjT8TFkio
         +e2Q==
X-Gm-Message-State: AOJu0YzQz7dqv1AL6zF+m4hn9rwvWdxJj9iD1h7dmwAXJRIFzFRZYanM
        zV/BYzwP8iMU9vxGiYcD2jVl6R8VwkIbFvMYrro=
X-Google-Smtp-Source: AGHT+IHO5YzRyoB4+yIvpmh8GgGc8xjw1foenCzgCbg3kZnXszrVMNiVTnbEV/o34e2+ssZ9j+QXF4Ki9G3FEjVmOjw=
X-Received: by 2002:a17:90b:1898:b0:26b:56fa:87d3 with SMTP id
 mn24-20020a17090b189800b0026b56fa87d3mr11873307pjb.31.1692865237319; Thu, 24
 Aug 2023 01:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230707092414.866760-1-zyytlz.wz@163.com> <8c8bd3ec-a5a4-32e4-45b5-ee16eeeac246@collabora.com>
In-Reply-To: <8c8bd3ec-a5a4-32e4-45b5-ee16eeeac246@collabora.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Thu, 24 Aug 2023 16:20:26 +0800
Message-ID: <CAJedcCxPG1mKtgB7AcJSwaQB_qvODObwq3gz6eM_1w777b2PfQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, Kyrie.Wu@mediatek.com,
        bin.liu@mediatek.com, mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Irui.Wang@mediatek.com,
        security@kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Osipenko <dmitry.osipenko@collabora.com> =E4=BA=8E2023=E5=B9=B48=E6=
=9C=8823=E6=97=A5=E5=91=A8=E4=B8=89 02:51=E5=86=99=E9=81=93=EF=BC=9A

>
> Hello Zheng,
>
> On 7/7/23 12:24, Zheng Wang wrote:
> > In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
> > mtk_jpeg_job_timeout_work. Then mtk_jpeg_dec_device_run
> > and mtk_jpeg_enc_device_run may be called to start the
> > work.
> > If we remove the module which will call mtk_jpeg_remove
> > to make cleanup, there may be a unfinished work. The
> > possible sequence is as follows, which will cause a
> > typical UAF bug.
> >
> > Fix it by canceling the work before cleanup in the mtk_jpeg_remove
> >
> > CPU0                  CPU1
> >
> >                     |mtk_jpeg_job_timeout_work
> > mtk_jpeg_remove     |
> >   v4l2_m2m_release  |
> >     kfree(m2m_dev); |
> >                     |
> >                     | v4l2_m2m_get_curr_priv
> >                     |   m2m_dev->curr_ctx //use
> > Fixes: b2f0d2724ba4 ("[media] vcodec: mediatek: Add Mediatek JPEG Decod=
er Driver")
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
> > - v2: use cancel_delayed_work_sync instead of cancel_delayed_work sugge=
sted by Kyrie.
> > ---
> >  drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/dri=
vers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > index 0051f372a66c..6069ecf420b0 100644
> > --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > @@ -1816,6 +1816,7 @@ static void mtk_jpeg_remove(struct platform_devic=
e *pdev)
> >  {
> >       struct mtk_jpeg_dev *jpeg =3D platform_get_drvdata(pdev);
> >
> > +     cancel_delayed_work_sync(&jpeg->job_timeout_work);
> >       pm_runtime_disable(&pdev->dev);
> >       video_unregister_device(jpeg->vdev);
> >       v4l2_m2m_release(jpeg->m2m_dev);
>
> AFAICS, there is a fundamental problem here. The job_timeout_work uses
> v4l2_m2m_get_curr_priv() and at the time when driver module is unloaded,
> all the v4l contexts must be closed and released. Hence the
> v4l2_m2m_get_curr_priv() shall return NULL and crash the kernel when
> work is executed before cancel_delayed_work_sync().
>

Hi Dmitry,

Thanks for your reply. I think you're right. As m2m_dev is freed in
v4l2_m2m_release,
the invoking in v4l2_m2m_get_curr_priv might cause either UAF or null
pointer dereference
bug. I am sure that context is closed when we invoke mtk_jpeg_remove.
But I'm not sure if
context is released when mtk_jpegdec_timeout_work running.

> At the time when mtk_jpeg_remove() is invoked, there shall be no
> job_timeout_work running in background because all jobs should be
> completed before context is released. If you'll look at
> v4l2_m2m_cancel_job(), you can see that it waits for the task completion
> before closing context.

Yes, so I think the better way is to put the cancel_delayed_work_sync
invoking into
v4l2_m2m_ctx_release function?

>
> You shouldn't be able to remove driver module while it has active/opened
> v4l contexts. If you can do that, then this is yours bug that needs to
> be fixed.
>
> In addition to this all, the job_timeout_work is initialized only for
> the single-core JPEG device. I'd expect this patch should crash
> multi-core JPEG devices.
>

I think that's true. As I'm not familiar with the code here. Could you
please give me some advice about the patch?

Best regards,
Zheng

> --
> Best regards,
> Dmitry
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37BA78E7C3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243324AbjHaITD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjHaITD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:19:03 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FA4EE;
        Thu, 31 Aug 2023 01:19:00 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2685bcd046eso385482a91.3;
        Thu, 31 Aug 2023 01:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693469939; x=1694074739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79o83Qkg5gPiVXMzByDb0PZBKtFKnERDAxY9w8aR938=;
        b=LFb029jzmRtLrLADBZd4VxX9k96GYlzjeSy4EUmKP4hYlCjK8f6/207ir9glcRKOwN
         bQmkzvn9cbMlESHuXWuQLsdFooKEcl6sWRgbvpq1+Or/FSc3R8mz9mE7djLw53agPlsi
         0ej+it9oUtr8fpO88t9RQqSd1tuwOkdmTGMufNAwCx5pBBUNh+AJiHGT9rea64LoIhx6
         zudKwWKPocVQFu65dNYCnA71DEv9Hi2jD2K5dU2D8U/vUtpTzBDdXZ0xPw61gD+/mnob
         cZsidL/BKL5RonVRNLyn7im9t8qnhShISkiREh9hWag6/uxaI/hIHn+bJa5X4xQWkqhL
         c0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693469939; x=1694074739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79o83Qkg5gPiVXMzByDb0PZBKtFKnERDAxY9w8aR938=;
        b=dVuXLuwBFpNhB8A/mUvdbDW5I9Hrh7VKVhRxVUwxoB84Uv5G5QdFAszAD0McPWMQsz
         tZp3IQSaNz6w0BVLZEYb8p+jko+JuNSItDXWNhpUTc+MmCC3m2hUt8o5ecEzXCcgtdLf
         PpgdbauA/lOwe6jTvs/84wjBC+xGx0+/7cVV9PW4mt81BwZXHF6dp2rsVhyOpvCUf3lD
         qmkT0elboEVv8KERm1AOPgasisiekiB5OOuc8f4x3PdD4PELfVF3L5MZS38Y/68z5pTy
         O/M76m4G7npku+gFai4az1bA5rty3Xdme+W889cbQx0YBp4bAYRJ6wpKDZViRgSvtlf1
         JliQ==
X-Gm-Message-State: AOJu0YyxOiMe6EVpoqy2Xb8vJhpIBVUH23CYhnyav5dg6vFPCON2Aca6
        D89Ssz719LoUdQUiBHL/doWcieIvbimjQ/NYhVU=
X-Google-Smtp-Source: AGHT+IE3edyRU9tiOyRiSNwpAeiDSCfeF0zhwsUo4Ex9wfq+t2eHBbb/B8+Nn1uGN4WCDY+zOXquI4RGYizvqdeJt6A=
X-Received: by 2002:a17:90b:3657:b0:26b:6e98:29ce with SMTP id
 nh23-20020a17090b365700b0026b6e9829cemr3893854pjb.27.1693469939462; Thu, 31
 Aug 2023 01:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230707092414.866760-1-zyytlz.wz@163.com> <8c8bd3ec-a5a4-32e4-45b5-ee16eeeac246@collabora.com>
 <CAJedcCxPG1mKtgB7AcJSwaQB_qvODObwq3gz6eM_1w777b2PfQ@mail.gmail.com> <54b14ebe-b51b-2744-328d-2adcdaaf6d0e@collabora.com>
In-Reply-To: <54b14ebe-b51b-2744-328d-2adcdaaf6d0e@collabora.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Thu, 31 Aug 2023 16:18:47 +0800
Message-ID: <CAJedcCyn+VHxcSXH+HqP3yiXX8L0wjNao+suti5GgyQzYORcYA@mail.gmail.com>
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Osipenko <dmitry.osipenko@collabora.com> =E4=BA=8E2023=E5=B9=B48=E6=
=9C=8828=E6=97=A5=E5=91=A8=E4=B8=80 10:04=E5=86=99=E9=81=93=EF=BC=9A
>
> On 8/24/23 11:20, Zheng Hacker wrote:
> > Dmitry Osipenko <dmitry.osipenko@collabora.com> =E4=BA=8E2023=E5=B9=B48=
=E6=9C=8823=E6=97=A5=E5=91=A8=E4=B8=89 02:51=E5=86=99=E9=81=93=EF=BC=9A
> >
> >>
> >> Hello Zheng,
> >>
> >> On 7/7/23 12:24, Zheng Wang wrote:
> >>> In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
> >>> mtk_jpeg_job_timeout_work. Then mtk_jpeg_dec_device_run
> >>> and mtk_jpeg_enc_device_run may be called to start the
> >>> work.
> >>> If we remove the module which will call mtk_jpeg_remove
> >>> to make cleanup, there may be a unfinished work. The
> >>> possible sequence is as follows, which will cause a
> >>> typical UAF bug.
> >>>
> >>> Fix it by canceling the work before cleanup in the mtk_jpeg_remove
> >>>
> >>> CPU0                  CPU1
> >>>
> >>>                     |mtk_jpeg_job_timeout_work
> >>> mtk_jpeg_remove     |
> >>>   v4l2_m2m_release  |
> >>>     kfree(m2m_dev); |
> >>>                     |
> >>>                     | v4l2_m2m_get_curr_priv
> >>>                     |   m2m_dev->curr_ctx //use
> >>> Fixes: b2f0d2724ba4 ("[media] vcodec: mediatek: Add Mediatek JPEG Dec=
oder Driver")
> >>> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> >>> ---
> >>> - v2: use cancel_delayed_work_sync instead of cancel_delayed_work sug=
gested by Kyrie.
> >>> ---
> >>>  drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/d=
rivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> >>> index 0051f372a66c..6069ecf420b0 100644
> >>> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> >>> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> >>> @@ -1816,6 +1816,7 @@ static void mtk_jpeg_remove(struct platform_dev=
ice *pdev)
> >>>  {
> >>>       struct mtk_jpeg_dev *jpeg =3D platform_get_drvdata(pdev);
> >>>
> >>> +     cancel_delayed_work_sync(&jpeg->job_timeout_work);
> >>>       pm_runtime_disable(&pdev->dev);
> >>>       video_unregister_device(jpeg->vdev);
> >>>       v4l2_m2m_release(jpeg->m2m_dev);
> >>
> >> AFAICS, there is a fundamental problem here. The job_timeout_work uses
> >> v4l2_m2m_get_curr_priv() and at the time when driver module is unloade=
d,
> >> all the v4l contexts must be closed and released. Hence the
> >> v4l2_m2m_get_curr_priv() shall return NULL and crash the kernel when
> >> work is executed before cancel_delayed_work_sync().
> >>
> >
> > Hi Dmitry,
> >
> > Thanks for your reply. I think you're right. As m2m_dev is freed in
> > v4l2_m2m_release,
> > the invoking in v4l2_m2m_get_curr_priv might cause either UAF or null
> > pointer dereference
> > bug. I am sure that context is closed when we invoke mtk_jpeg_remove.
> > But I'm not sure if
> > context is released when mtk_jpegdec_timeout_work running.
> >
> >> At the time when mtk_jpeg_remove() is invoked, there shall be no
> >> job_timeout_work running in background because all jobs should be
> >> completed before context is released. If you'll look at
> >> v4l2_m2m_cancel_job(), you can see that it waits for the task completi=
on
> >> before closing context.
> >
> > Yes, so I think the better way is to put the cancel_delayed_work_sync
> > invoking into
> > v4l2_m2m_ctx_release function?
>
> The v4l2_m2m_ctx_release() already should wait for the job_timeout_work
> completion or for the interrupt fire. Apparently it doesn't work in
> yours case. You'll need to debug why v4l job or job_timeout_work is
> running after v4l2_m2m_ctx_release(), it shouldn't happen.
>

Yes, v4l2_m2m_cancel_job waits for m2m_ctx->job_flags to be  ~TRANS_RUNNING=
,
the mtk_jpeg_job_timeout_work will finally invoke v4l2_m2m_job_finish
to trigger that.

However, this is not the only path to call v4l2_m2m_job_finish. Here
is a invoking chain:
v4l_streamon
  ->v4l2_m2m_ioctl_streamon
    ->v4l2_m2m_streamon
      ->v4l2_m2m_try_schedule
        ->v4l2_m2m_try_run
          ->mtk_jpeg_dec_device_run
            ->schedule_delayed_work(&jpeg->job_timeout_work...
            ->error path goto dec_end
            ->v4l2_m2m_job_finish

In some specific situation, it starts the worker and also calls
v4l2_m2m_job_finish, which might
make v4l2_m2m_cancel_job continues.

> The interrupt handler cancels job_timeout_work, you shouldn't need to
> flush the work.

It will, but as I said, there might be an early invocation chain to
start the work.(Not very sure)

>
> Technically, interrupt handler may race with job_timeout_work, but the
> timeout is set to 1 second and in practice should be difficult to
> trigger the race. The interrupt handler needs to be threaded, it should
> use cancel_delayed_work_sync() and check the return value of this functio=
n.
>

Yes, it's better to use cancel_delayed_work_sync here.

> >>
> >> You shouldn't be able to remove driver module while it has active/open=
ed
> >> v4l contexts. If you can do that, then this is yours bug that needs to
> >> be fixed.
> >>
> >> In addition to this all, the job_timeout_work is initialized only for
> >> the single-core JPEG device. I'd expect this patch should crash
> >> multi-core JPEG devices.
> >>
> >
> > I think that's true. As I'm not familiar with the code here. Could you
> > please give me some advice about the patch?
>
> We'll need to understand why v4l2_m2m_ctx_release() doesn't work as
> expected before thinking about the patch.
>
> --
> Best regards,
> Dmitry
>

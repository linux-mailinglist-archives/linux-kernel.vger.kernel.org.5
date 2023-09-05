Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F5B792B9D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345540AbjIEQ4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347093AbjIEEYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 00:24:54 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6341B6;
        Mon,  4 Sep 2023 21:24:50 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-49334907238so463951e0c.3;
        Mon, 04 Sep 2023 21:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693887889; x=1694492689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnASQxHgo8NIvWcsPfvTXJYjWgu/MakjTu4ln9RX/cg=;
        b=EFpvQuw++BpO08rPt54F+REVVLhmc3VRd4DMHUwZUCkQu4bZML8JAfcdKBf2OaKDBn
         ub/JAam70uEnynMH54z9azfvfvG3PS15e7NTMe9jYx44jKiTboI+JKyBFECyX0o2zapK
         jAA00npwjFVrJtDoHMGuLPRhjDckWRI21FRUzIYqUXviyhJUJFs2KxnBdsPNaJEAdVrn
         B8cEdc+9FWx/YP+c3tbECWQ56Eg0eM1X6o7ywqFTz+1UMeoUK2w4Ofph1U9ghfB8lQLY
         8h+J7yzsxOL1uvQBsFJECFdlq4UBSqVqzUeUmRgjWMOgQwVUOSo4lRzOqRLIh8bA3bSb
         PKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693887889; x=1694492689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnASQxHgo8NIvWcsPfvTXJYjWgu/MakjTu4ln9RX/cg=;
        b=HDsYhyrG8yCEnDYmmf1eEU8ZKwfj3Y7mp93i5ftmTXgRgtjqWDHdC4FhzuE0EBZUrQ
         sOvgeTePScS75BIS08x6bDg+gUwsgfECRQSroPWKwZ6t1Ac2l6fZHV8LQ6B1wfeAXbDh
         fxnSwVAMeBAkk0UIHB60+NfGU+HtAXs52D21jQnclqdK0Y2VMNPzMdwKnoc5hNPe+l0K
         QGbzrTcdy8rKlSqM8VJF3wfEl81gHnDcMi2IwNQKUnd4qvfOXLzPy4EuA3m/33985gGQ
         5Kn2iYwA6GuD8yh0ZfIu6KBfaRskAJtyKj8hAOeilTZp/QAQ5SV6k2/FrIgeuRJc9fw5
         ZlRA==
X-Gm-Message-State: AOJu0YwAir+zMBuGamXEGnx7XehSl4eN6wtO8VasQSPrmqdnSATiPNGA
        fafhSXY4t2uuB3JSN58bYyzd1e0bwDZlBCESQak=
X-Google-Smtp-Source: AGHT+IHo2INpKSBzOEYnrP6Bz5w6d7VidD2XxmUoIivUbkDLhS/QC5QbuGWTzE7Y7AbpOk1oxYg7FerDRPk/NM2c5CA=
X-Received: by 2002:a1f:dac4:0:b0:48f:b24d:21d3 with SMTP id
 r187-20020a1fdac4000000b0048fb24d21d3mr8004461vkg.15.1693887889034; Mon, 04
 Sep 2023 21:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230707092414.866760-1-zyytlz.wz@163.com> <8c8bd3ec-a5a4-32e4-45b5-ee16eeeac246@collabora.com>
 <CAJedcCxPG1mKtgB7AcJSwaQB_qvODObwq3gz6eM_1w777b2PfQ@mail.gmail.com>
 <54b14ebe-b51b-2744-328d-2adcdaaf6d0e@collabora.com> <CAJedcCyn+VHxcSXH+HqP3yiXX8L0wjNao+suti5GgyQzYORcYA@mail.gmail.com>
In-Reply-To: <CAJedcCyn+VHxcSXH+HqP3yiXX8L0wjNao+suti5GgyQzYORcYA@mail.gmail.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Tue, 5 Sep 2023 12:24:36 +0800
Message-ID: <CAJedcCw2A1hJ89g5W1u+XvP26gqaUeVFOYRw_tj7eWYNMPfXBQ@mail.gmail.com>
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

Friendly ping.

Zheng Hacker <hackerzheng666@gmail.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8831=
=E6=97=A5=E5=91=A8=E5=9B=9B 16:18=E5=86=99=E9=81=93=EF=BC=9A
>
> Dmitry Osipenko <dmitry.osipenko@collabora.com> =E4=BA=8E2023=E5=B9=B48=
=E6=9C=8828=E6=97=A5=E5=91=A8=E4=B8=80 10:04=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On 8/24/23 11:20, Zheng Hacker wrote:
> > > Dmitry Osipenko <dmitry.osipenko@collabora.com> =E4=BA=8E2023=E5=B9=
=B48=E6=9C=8823=E6=97=A5=E5=91=A8=E4=B8=89 02:51=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > >>
> > >> Hello Zheng,
> > >>
> > >> On 7/7/23 12:24, Zheng Wang wrote:
> > >>> In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
> > >>> mtk_jpeg_job_timeout_work. Then mtk_jpeg_dec_device_run
> > >>> and mtk_jpeg_enc_device_run may be called to start the
> > >>> work.
> > >>> If we remove the module which will call mtk_jpeg_remove
> > >>> to make cleanup, there may be a unfinished work. The
> > >>> possible sequence is as follows, which will cause a
> > >>> typical UAF bug.
> > >>>
> > >>> Fix it by canceling the work before cleanup in the mtk_jpeg_remove
> > >>>
> > >>> CPU0                  CPU1
> > >>>
> > >>>                     |mtk_jpeg_job_timeout_work
> > >>> mtk_jpeg_remove     |
> > >>>   v4l2_m2m_release  |
> > >>>     kfree(m2m_dev); |
> > >>>                     |
> > >>>                     | v4l2_m2m_get_curr_priv
> > >>>                     |   m2m_dev->curr_ctx //use
> > >>> Fixes: b2f0d2724ba4 ("[media] vcodec: mediatek: Add Mediatek JPEG D=
ecoder Driver")
> > >>> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > >>> ---
> > >>> - v2: use cancel_delayed_work_sync instead of cancel_delayed_work s=
uggested by Kyrie.
> > >>> ---
> > >>>  drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 1 +
> > >>>  1 file changed, 1 insertion(+)
> > >>>
> > >>> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b=
/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > >>> index 0051f372a66c..6069ecf420b0 100644
> > >>> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > >>> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > >>> @@ -1816,6 +1816,7 @@ static void mtk_jpeg_remove(struct platform_d=
evice *pdev)
> > >>>  {
> > >>>       struct mtk_jpeg_dev *jpeg =3D platform_get_drvdata(pdev);
> > >>>
> > >>> +     cancel_delayed_work_sync(&jpeg->job_timeout_work);
> > >>>       pm_runtime_disable(&pdev->dev);
> > >>>       video_unregister_device(jpeg->vdev);
> > >>>       v4l2_m2m_release(jpeg->m2m_dev);
> > >>
> > >> AFAICS, there is a fundamental problem here. The job_timeout_work us=
es
> > >> v4l2_m2m_get_curr_priv() and at the time when driver module is unloa=
ded,
> > >> all the v4l contexts must be closed and released. Hence the
> > >> v4l2_m2m_get_curr_priv() shall return NULL and crash the kernel when
> > >> work is executed before cancel_delayed_work_sync().
> > >>
> > >
> > > Hi Dmitry,
> > >
> > > Thanks for your reply. I think you're right. As m2m_dev is freed in
> > > v4l2_m2m_release,
> > > the invoking in v4l2_m2m_get_curr_priv might cause either UAF or null
> > > pointer dereference
> > > bug. I am sure that context is closed when we invoke mtk_jpeg_remove.
> > > But I'm not sure if
> > > context is released when mtk_jpegdec_timeout_work running.
> > >
> > >> At the time when mtk_jpeg_remove() is invoked, there shall be no
> > >> job_timeout_work running in background because all jobs should be
> > >> completed before context is released. If you'll look at
> > >> v4l2_m2m_cancel_job(), you can see that it waits for the task comple=
tion
> > >> before closing context.
> > >
> > > Yes, so I think the better way is to put the cancel_delayed_work_sync
> > > invoking into
> > > v4l2_m2m_ctx_release function?
> >
> > The v4l2_m2m_ctx_release() already should wait for the job_timeout_work
> > completion or for the interrupt fire. Apparently it doesn't work in
> > yours case. You'll need to debug why v4l job or job_timeout_work is
> > running after v4l2_m2m_ctx_release(), it shouldn't happen.
> >
>
> Yes, v4l2_m2m_cancel_job waits for m2m_ctx->job_flags to be  ~TRANS_RUNNI=
NG,
> the mtk_jpeg_job_timeout_work will finally invoke v4l2_m2m_job_finish
> to trigger that.
>
> However, this is not the only path to call v4l2_m2m_job_finish. Here
> is a invoking chain:
> v4l_streamon
>   ->v4l2_m2m_ioctl_streamon
>     ->v4l2_m2m_streamon
>       ->v4l2_m2m_try_schedule
>         ->v4l2_m2m_try_run
>           ->mtk_jpeg_dec_device_run
>             ->schedule_delayed_work(&jpeg->job_timeout_work...
>             ->error path goto dec_end
>             ->v4l2_m2m_job_finish
>
> In some specific situation, it starts the worker and also calls
> v4l2_m2m_job_finish, which might
> make v4l2_m2m_cancel_job continues.
>
> > The interrupt handler cancels job_timeout_work, you shouldn't need to
> > flush the work.
>
> It will, but as I said, there might be an early invocation chain to
> start the work.(Not very sure)
>
> >
> > Technically, interrupt handler may race with job_timeout_work, but the
> > timeout is set to 1 second and in practice should be difficult to
> > trigger the race. The interrupt handler needs to be threaded, it should
> > use cancel_delayed_work_sync() and check the return value of this funct=
ion.
> >
>
> Yes, it's better to use cancel_delayed_work_sync here.
>
> > >>
> > >> You shouldn't be able to remove driver module while it has active/op=
ened
> > >> v4l contexts. If you can do that, then this is yours bug that needs =
to
> > >> be fixed.
> > >>
> > >> In addition to this all, the job_timeout_work is initialized only fo=
r
> > >> the single-core JPEG device. I'd expect this patch should crash
> > >> multi-core JPEG devices.
> > >>
> > >
> > > I think that's true. As I'm not familiar with the code here. Could yo=
u
> > > please give me some advice about the patch?
> >
> > We'll need to understand why v4l2_m2m_ctx_release() doesn't work as
> > expected before thinking about the patch.
> >
> > --
> > Best regards,
> > Dmitry
> >

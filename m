Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B877D06A3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 04:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346884AbjJTCve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 22:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJTCvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 22:51:32 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223BEBB;
        Thu, 19 Oct 2023 19:51:31 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-27d17f5457fso1160138a91.0;
        Thu, 19 Oct 2023 19:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697770290; x=1698375090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSyEa0sFMcONixA0hlTQkwiw71W8PLZIzABpK7037o4=;
        b=cj0JAihhbTWvn4KjKV1uZuKkc0syI+DECAqHsM1T8g+RIE3GAinP4AolUdxazRoL0V
         /BTQUUOpNkQREIL3Q2r4uHisbSTmlczG61AhwtoemMVn4qyxq4NwKKkr62Nvi9RmppmG
         KfjlLzs9RbdsBSQ8tG0b6uldZ9zuZVP0igqRK2CIDte1dkZdWNjBDgT7vmkI9A7BKyln
         hJ1AAuingIjbfeEf2gXD4KQ3PavTu0sgP0BTKqTW84/7zSSUqlJRWLk/TDzkcRO2qWgW
         sHGjvXdFELUZfZyBgDYkRAuV6MnPeR8yyeA6k3iE5K1QZFIUOTWbM0T9owzS1O7VGalJ
         bLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697770290; x=1698375090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSyEa0sFMcONixA0hlTQkwiw71W8PLZIzABpK7037o4=;
        b=iSLrBNwiNgo4qAgfhcGNL/ymVVPV5PYhAqYuCT8tEpZvwO+U36bUaZlMWZQMbRI56v
         zjjpojZPE8OfrVZMRTYoRaDp1FYnFEAAlUEQOA1J6Vp+FElaPClvnNuVDkKJSYnX8kTG
         BfPrCOxZY7sQv4cR//KeMuZoSWLefliawJMbyC3OrQuSyk3hzsY2na0djFJ7BtCHIN7A
         0xdakCdpiiNPj9LdxDgtFG8gnXqAl52fAKQJjFQUh2mOITq4cAjSRTlPf83V2eYRJss0
         f16ETHvsojYRfG7lyvBcigxwdCXJncB4kqNjiJuttaEnrnUHteR0+wCcvSYOgYX6edSV
         foJA==
X-Gm-Message-State: AOJu0YzOv49FaWRWqbcJTlGxg43MHklNyvAqu0lDxTsxstwWG8sD8W+5
        6jrA6yf8597DJeh76YaZSfRUyO7jQFkab7xruIc=
X-Google-Smtp-Source: AGHT+IFgKKYjVPo3avfMak88k5nKBrBCu//f+U4Ov5lVC9KWNZ8UDrq8/NOeuIhyTHEUTRZt783sy3VGPKpoadjS0SU=
X-Received: by 2002:a17:90b:28ce:b0:27d:df04:d109 with SMTP id
 qj14-20020a17090b28ce00b0027ddf04d109mr795755pjb.2.1697770290289; Thu, 19 Oct
 2023 19:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230707092414.866760-1-zyytlz.wz@163.com> <8c8bd3ec-a5a4-32e4-45b5-ee16eeeac246@collabora.com>
 <CAJedcCxPG1mKtgB7AcJSwaQB_qvODObwq3gz6eM_1w777b2PfQ@mail.gmail.com>
 <54b14ebe-b51b-2744-328d-2adcdaaf6d0e@collabora.com> <CAJedcCyn+VHxcSXH+HqP3yiXX8L0wjNao+suti5GgyQzYORcYA@mail.gmail.com>
 <4d533beb-f416-1b22-6d9d-cee7f3cfdad1@collabora.com> <CAJedcCwDemUSo8Hv1XYLcAkHeo2Y2RU=xX7Fv5aSRz52AixK6g@mail.gmail.com>
 <6a9fda43-9391-eaba-11f6-87d4ff966cb1@collabora.com>
In-Reply-To: <6a9fda43-9391-eaba-11f6-87d4ff966cb1@collabora.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 20 Oct 2023 10:51:17 +0800
Message-ID: <CAJedcCwCOExzsNF_sAX-e6=Vxu3WKOzxUFc82GvinCaV2ASUmQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Zheng Wang <zyytlz.wz@163.com>, Kyrie.Wu@mediatek.com,
        bin.liu@mediatek.com, mchehab@kernel.org, matthias.bgg@gmail.com,
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

Thanks for your patch. I think this should fix the problem. As I have
no experience in reverting, can I submit the patch with your fix as
well as reverting my fix?

Best regards,
Zheng

Dmitry Osipenko <dmitry.osipenko@collabora.com> =E4=BA=8E2023=E5=B9=B410=E6=
=9C=8820=E6=97=A5=E5=91=A8=E4=BA=94 03:56=E5=86=99=E9=81=93=EF=BC=9A
>
> On 10/8/23 12:13, Zheng Hacker wrote:
> > Dmitry Osipenko <dmitry.osipenko@collabora.com> =E4=BA=8E2023=E5=B9=B49=
=E6=9C=8820=E6=97=A5=E5=91=A8=E4=B8=89 02:24=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 8/31/23 11:18, Zheng Hacker wrote:
> >>>> The v4l2_m2m_ctx_release() already should wait for the job_timeout_w=
ork
> >>>> completion or for the interrupt fire. Apparently it doesn't work in
> >>>> yours case. You'll need to debug why v4l job or job_timeout_work is
> >>>> running after v4l2_m2m_ctx_release(), it shouldn't happen.
> >>>>
> >>> Yes, v4l2_m2m_cancel_job waits for m2m_ctx->job_flags to be  ~TRANS_R=
UNNING,
> >>> the mtk_jpeg_job_timeout_work will finally invoke v4l2_m2m_job_finish
> >>> to trigger that.
> >>>
> >>> However, this is not the only path to call v4l2_m2m_job_finish. Here
> >>> is a invoking chain:
> >>> v4l_streamon
> >>>   ->v4l2_m2m_ioctl_streamon
> >>>     ->v4l2_m2m_streamon
> >>>       ->v4l2_m2m_try_schedule
> >>>         ->v4l2_m2m_try_run
> >>>           ->mtk_jpeg_dec_device_run
> >>>             ->schedule_delayed_work(&jpeg->job_timeout_work...
> >>>             ->error path goto dec_end
> >>>             ->v4l2_m2m_job_finish
> >>>
> >>> In some specific situation, it starts the worker and also calls
> >>> v4l2_m2m_job_finish, which might
> >>> make v4l2_m2m_cancel_job continues.
> >>
> >> Then the error path should cancel the job_timeout_work, or better job
> >> needs to be run after the dec/enc has been started and not before.
> >>
> >
> > Hi,
> >
> > Sorry for my late reply for I just went on a long vacation.
> >
> > Get it. I'll write another patch and change the summary to the lack of
> > canceling job in error path.
> >
> >> Looking further at the code, I'm confused by this hunk:
> >>
> >>         mtk_jpeg_dec_start(comp_jpeg[hw_id]->reg_base);
> >>         v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
> >>
> >> The job should be marked as finished when h/w has finished processing
> >> the job and not right after the job has been started. So the job is
> >> always completed and mtk_jpeg_job_timeout_work() doesn't work as
> >> expected, am I missing something?
> >
> > After reading the code I still don't know. I didn't see any function
> > like mtk_jpeg_dec_end. The same thing
> > happens on mtk_jpeg_enc_start. I think I'd better fix the first
> > problem and wait for someone familiar with
> > the second part.
>
> I missed that the code mentioned above is related to the multi-core hw ve=
rsion, while you care about single-core. Nevertheless, the multi-core devic=
e_run() looks incorrect,
>
> So, the error code paths need to be corrected. Please try to revert yours=
 fix and test this change:
>
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drive=
rs/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> index 0051f372a66c..fd3b0587fcad 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> @@ -1254,9 +1254,6 @@ static void mtk_jpegdec_worker(struct work_struct *=
work)
>         v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
>         v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
>
> -       schedule_delayed_work(&comp_jpeg[hw_id]->job_timeout_work,
> -                             msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC))=
;
> -
>         mtk_jpeg_set_dec_src(ctx, &src_buf->vb2_buf, &bs);
>         if (mtk_jpeg_set_dec_dst(ctx,
>                                  &jpeg_src_buf->dec_param,
> @@ -1266,6 +1263,9 @@ static void mtk_jpegdec_worker(struct work_struct *=
work)
>                 goto setdst_end;
>         }
>
> +       schedule_delayed_work(&comp_jpeg[hw_id]->job_timeout_work,
> +                             msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC))=
;
> +
>         spin_lock_irqsave(&comp_jpeg[hw_id]->hw_lock, flags);
>         ctx->total_frame_num++;
>         mtk_jpeg_dec_reset(comp_jpeg[hw_id]->reg_base);
> @@ -1330,13 +1330,13 @@ static void mtk_jpeg_dec_device_run(void *priv)
>         if (ret < 0)
>                 goto dec_end;
>
> -       schedule_delayed_work(&jpeg->job_timeout_work,
> -                             msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC))=
;
> -
>         mtk_jpeg_set_dec_src(ctx, &src_buf->vb2_buf, &bs);
>         if (mtk_jpeg_set_dec_dst(ctx, &jpeg_src_buf->dec_param, &dst_buf-=
>vb2_buf, &fb))
>                 goto dec_end;
>
> +       schedule_delayed_work(&jpeg->job_timeout_work,
> +                             msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC))=
;
> +
>         spin_lock_irqsave(&jpeg->hw_lock, flags);
>         mtk_jpeg_dec_reset(jpeg->reg_base);
>         mtk_jpeg_dec_set_config(jpeg->reg_base,
>
> --
> Best regards,
> Dmitry
>

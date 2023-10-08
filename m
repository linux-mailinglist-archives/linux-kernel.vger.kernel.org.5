Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8823E7BCD6F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 11:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344546AbjJHJNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 05:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjJHJNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 05:13:21 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EAEBA;
        Sun,  8 Oct 2023 02:13:19 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27752a1e184so2864008a91.3;
        Sun, 08 Oct 2023 02:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696756399; x=1697361199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIjUR5wsU/i7XxPuSQP1qfexQee767Fh9n1eSCn2QNU=;
        b=XcSbaeC12UO1WomDeJpBzY3VJwEovsecDI/I2wpLURTYH8HqQQGiqE1FZQakIcyS/4
         FFO3HUbDZBMkRBsnMQnRktPJxYd22NH4kpnzlBcsCPahpVTbBEbmwE83FPOfcFlAqMBy
         j9x0s3AjgMh6zQxlYMGQeaCnqdV1s1xN4NoFeXDrveCeWGqZfkovtZN3B4Ka01wsQR5l
         qw3wRbS9dohKYn6S0h/DNYWHp8fX518pH6waZ1HGjAtHZTPPG2/GsY+2tR/nFtWjPfHm
         bGPFNGE0bOXe/MDlEMgbjVJ8WmZvRp+7cWvw8q9Td747xHIPE6DRTPoiF1fpljdJJj+h
         aR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696756399; x=1697361199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIjUR5wsU/i7XxPuSQP1qfexQee767Fh9n1eSCn2QNU=;
        b=KrCmTxvrC91Pd521FPO12ifVeP1Fy1SeYQD+VJa5asjoro4gjAZnGcubnzJye/a0iY
         vtLOFgBIVCFnM32Ut7md5ltQO76wNTHZRcbERu0gCV2yqi/nd3fA0aCGW+yp5Y/RQJXs
         +1nxw3EfZ5ufN6cKXzMp6xMI8wUus9LPJhI8w9eEJG/dluE5nzf8SG0uC8eONFG0pg0F
         yvp0D4nubw5Fr2OEMgZRuPw4kMfc4ZGypw28DDuZTNgxF8Hx4OTZHcVgUcUiKJqkoWhS
         iN35yNWOQPW1ig3OG0DU3/pCoHOEAufJIMMJypi+uBoamr2pseOAcOAyrNE7F66p2pna
         bRLg==
X-Gm-Message-State: AOJu0YwDxwqw7muexruIvU4Gl11KSj8qPF+oE8ZJVGQ+g9OY/6QCxLxn
        +frBgSvmoSj4jwVfZuwI2ALlNdH08Z79gME6gWH3vr/njgWOaaSi
X-Google-Smtp-Source: AGHT+IFlzAJPF2c72JOttTd8L7USLuoA/igr3cJARYtnvM1yOtRhQrr9zu3gvttgERj4A9EJxSkJuVzwSq9kONltlgc=
X-Received: by 2002:a17:90a:ad87:b0:277:7969:6bf2 with SMTP id
 s7-20020a17090aad8700b0027779696bf2mr11948863pjq.47.1696756398972; Sun, 08
 Oct 2023 02:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230707092414.866760-1-zyytlz.wz@163.com> <8c8bd3ec-a5a4-32e4-45b5-ee16eeeac246@collabora.com>
 <CAJedcCxPG1mKtgB7AcJSwaQB_qvODObwq3gz6eM_1w777b2PfQ@mail.gmail.com>
 <54b14ebe-b51b-2744-328d-2adcdaaf6d0e@collabora.com> <CAJedcCyn+VHxcSXH+HqP3yiXX8L0wjNao+suti5GgyQzYORcYA@mail.gmail.com>
 <4d533beb-f416-1b22-6d9d-cee7f3cfdad1@collabora.com>
In-Reply-To: <4d533beb-f416-1b22-6d9d-cee7f3cfdad1@collabora.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Sun, 8 Oct 2023 17:13:07 +0800
Message-ID: <CAJedcCwDemUSo8Hv1XYLcAkHeo2Y2RU=xX7Fv5aSRz52AixK6g@mail.gmail.com>
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Osipenko <dmitry.osipenko@collabora.com> =E4=BA=8E2023=E5=B9=B49=E6=
=9C=8820=E6=97=A5=E5=91=A8=E4=B8=89 02:24=E5=86=99=E9=81=93=EF=BC=9A
>
> On 8/31/23 11:18, Zheng Hacker wrote:
> >> The v4l2_m2m_ctx_release() already should wait for the job_timeout_wor=
k
> >> completion or for the interrupt fire. Apparently it doesn't work in
> >> yours case. You'll need to debug why v4l job or job_timeout_work is
> >> running after v4l2_m2m_ctx_release(), it shouldn't happen.
> >>
> > Yes, v4l2_m2m_cancel_job waits for m2m_ctx->job_flags to be  ~TRANS_RUN=
NING,
> > the mtk_jpeg_job_timeout_work will finally invoke v4l2_m2m_job_finish
> > to trigger that.
> >
> > However, this is not the only path to call v4l2_m2m_job_finish. Here
> > is a invoking chain:
> > v4l_streamon
> >   ->v4l2_m2m_ioctl_streamon
> >     ->v4l2_m2m_streamon
> >       ->v4l2_m2m_try_schedule
> >         ->v4l2_m2m_try_run
> >           ->mtk_jpeg_dec_device_run
> >             ->schedule_delayed_work(&jpeg->job_timeout_work...
> >             ->error path goto dec_end
> >             ->v4l2_m2m_job_finish
> >
> > In some specific situation, it starts the worker and also calls
> > v4l2_m2m_job_finish, which might
> > make v4l2_m2m_cancel_job continues.
>
> Then the error path should cancel the job_timeout_work, or better job
> needs to be run after the dec/enc has been started and not before.
>

Hi,

Sorry for my late reply for I just went on a long vacation.

Get it. I'll write another patch and change the summary to the lack of
canceling job in error path.

> Looking further at the code, I'm confused by this hunk:
>
>         mtk_jpeg_dec_start(comp_jpeg[hw_id]->reg_base);
>         v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
>
> The job should be marked as finished when h/w has finished processing
> the job and not right after the job has been started. So the job is
> always completed and mtk_jpeg_job_timeout_work() doesn't work as
> expected, am I missing something?

After reading the code I still don't know. I didn't see any function
like mtk_jpeg_dec_end. The same thing
happens on mtk_jpeg_enc_start. I think I'd better fix the first
problem and wait for someone familiar with
the second part.

Best regards,
Zheng

>
> --
> Best regards,
> Dmitry
>

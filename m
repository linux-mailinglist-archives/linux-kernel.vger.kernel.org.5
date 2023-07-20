Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDF475A4B5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 05:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjGTDRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 23:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjGTDR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 23:17:29 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37282112;
        Wed, 19 Jul 2023 20:17:23 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-263374f2f17so139265a91.0;
        Wed, 19 Jul 2023 20:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689823043; x=1690427843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mf/NJQ+u428p5uEFrwZXkvKS5alcwGdh9zkPDo+6gjU=;
        b=mqZbMeUgbHTig981lvv2u/s487KbPpUNB1KQa3TQocGeyoiDB13btddiwbEBXZf9hw
         Ht39uqtw1zYecYIWdzW5wOG2oeseSRZ0h1XN1WsmXk5OOE7WT/LwLyNqgDeNdwiC56JC
         Yp3ihZfZDwVeeFy7amrwhPZm9hIVZZ2ZQ8qbtfM5sYL8QfZxhM447JSBDeFczRCMzNK/
         uhv5ZOElbuymi6mS/PWoS1mtfsXdZlUePBjf8GGcoIk7fTGZR3gek4gbgAC8aV12SzZt
         jSpmX/FRqfQygKoB50a/IoGkSYcyR8bkt1yVpOOpeHhfHvtJSHNMd7tOO84mSqhrDmoU
         fchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689823043; x=1690427843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mf/NJQ+u428p5uEFrwZXkvKS5alcwGdh9zkPDo+6gjU=;
        b=WSPJ5jMY9ly+WNIumDKe7eht1NKsWT4ei3OLp8olL4SVOrx4Mh+NlrTocO+MBDM9eL
         wkmSCyppaxfUpLGlI7rWopKfxAQ2XDTvj1eRFtZ9NIvnWvTOUxjzAvGUG9qsXYGftNeo
         /FQpu8uQdRQuVuVgSNkR8iOkF2a3uS3YgE+n4TqLOjYX/+D33Max3ElfOUK6rofa9xYG
         uwqcvoBeGUtdLmIOY3qBt9t6hucdU2Ve2zZhjJNu9REwzfJJ2170XPYIFeCd+zSQquXD
         5yWTsMJflOpkhZCMBEMLcWFWFy7Si2OsnRMs6xbHkvPw+lTtNUwGGPNC1mGXGcyA/Ij3
         ylog==
X-Gm-Message-State: ABy/qLa+PCkoG7wXj3Dbkes/rMTyXqKDcNlHc100BnBS3Za1RJZG75Vf
        QVhPMBnm+Vf+SEs871Ac4HFi2BsgqhY1eE2ptCY=
X-Google-Smtp-Source: APBJJlEnomW/hvUCj8J28dUJrCNM46A+qa33E74KWzq4Qd2g8zGu1aEvU4zorYv8Gm51p2xGZgTGdl0cuI9m2CPmYQM=
X-Received: by 2002:a17:90a:6907:b0:263:f5f8:beed with SMTP id
 r7-20020a17090a690700b00263f5f8beedmr3024049pjj.19.1689823043095; Wed, 19 Jul
 2023 20:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230707092414.866760-1-zyytlz.wz@163.com> <538096d2-7b24-e1c7-706d-4d4f952d35eb@baylibre.com>
 <CAJedcCzR6DzX_aG1KBgrMHDJ1xh=RTA-FrZ+TJ_4KawWpHyYuA@mail.gmail.com>
 <CAJedcCyKv-hdDhWcogDZrC-kY6qtO-H1fDYqjTXMJvCR19MxYg@mail.gmail.com> <55c336a4-b268-d2d3-47f3-213300e4e623@baylibre.com>
In-Reply-To: <55c336a4-b268-d2d3-47f3-213300e4e623@baylibre.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Thu, 20 Jul 2023 11:17:10 +0800
Message-ID: <CAJedcCw_gLkkAYCDF3NuGqXz7A3CVR2sfcRvW=AhnWQy9Bnvew@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, Kyrie.Wu@mediatek.com,
        bin.liu@mediatek.com, mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Irui.Wang@mediatek.com,
        security@kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks dor your kind reply. I'll try to connect them later.

Best regards,
Zheng

Alexandre Mergnat <amergnat@baylibre.com> =E4=BA=8E2023=E5=B9=B47=E6=9C=881=
9=E6=97=A5=E5=91=A8=E4=B8=89 18:17=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 18/07/2023 05:07, Zheng Hacker wrote:
> > Friendly ping
> >
> > Zheng Hacker <hackerzheng666@gmail.com> =E4=BA=8E2023=E5=B9=B47=E6=9C=
=8816=E6=97=A5=E5=91=A8=E6=97=A5 00:08=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> Hi,
> >>
> >> This issue has not been resolved for a long time. Is there anyone who =
can help?
> >>
> >> Best regards,
> >> Zheng
> >>
> >> Alexandre Mergnat <amergnat@baylibre.com> =E4=BA=8E2023=E5=B9=B47=E6=
=9C=887=E6=97=A5=E5=91=A8=E4=BA=94 22:11=E5=86=99=E9=81=93=EF=BC=9A
> >>>
> >>>
> >>>
> >>> On 07/07/2023 11:24, Zheng Wang wrote:
> >>>> In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
> >>>> mtk_jpeg_job_timeout_work. Then mtk_jpeg_dec_device_run
> >>>> and mtk_jpeg_enc_device_run may be called to start the
> >>>> work.
> >>>> If we remove the module which will call mtk_jpeg_remove
> >>>> to make cleanup, there may be a unfinished work. The
> >>>> possible sequence is as follows, which will cause a
> >>>> typical UAF bug.
> >>>>
> >>>> Fix it by canceling the work before cleanup in the mtk_jpeg_remove
> >>>>
> >>>> CPU0                  CPU1
> >>>>
> >>>>                       |mtk_jpeg_job_timeout_work
> >>>> mtk_jpeg_remove     |
> >>>>     v4l2_m2m_release  |
> >>>>       kfree(m2m_dev); |
> >>>>                       |
> >>>>                       | v4l2_m2m_get_curr_priv
> >>>>                       |   m2m_dev->curr_ctx //use
> >>>
> >>> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
> >>>
> >>> --
> >>> Regards,
> >>> Alexandre
>
> Hi Zheng,
>
> If you asking me to merge patch, sorry but I can't, I'm just a reviewer.
> I invite you to ping the maintainers directly:
>
> Bin Liu <bin.liu@mediatek.com> (supporter:MEDIATEK JPEG DRIVER)
> Mauro Carvalho Chehab <mchehab@kernel.org> (maintainer:MEDIA INPUT
> INFRASTRUCTURE (V4L/DVB))
> Matthias Brugger <matthias.bgg@gmail.com> (maintainer:ARM/Mediatek SoC
> support)
>
> Otherwise, I misunderstood what you asking me. If so, can you rephrase
> your question please?
>
> --
> Regards,
> Alexandre

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F3278A836
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjH1IwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjH1Ivv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:51:51 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0ADBF;
        Mon, 28 Aug 2023 01:51:48 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-649a653479bso16353976d6.0;
        Mon, 28 Aug 2023 01:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693212707; x=1693817507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QlQsqhbMuO0FCtthsUOG1XI6SmEnrXMxQcpEIHQeP4=;
        b=LdZr+dgSjzgr+iamC9Y2A7MI3nBpu/wEkh3x7NyO6aB/PqziDjNZyVzR9y+VZHC/h/
         ee/EtlsCSd7+mSEUQrWm42l+GGRZgfRp6ZKoPvoRh0lGab5DrT1t0ZcbDE21DbE+Xy1B
         CRBcKNYqz1UzUYnXzBML5fSEjPqG2DfivkvRREFCvrnqneGtJnidqsdREAuWLWgmDIyQ
         4Qzd+5Z1hNSSsfODsrWKV3b+aR2CE2zjaWkqlfq7IXHDXItI34FksR+YeNF3lvxh+mkR
         OV1q2Vbll7EE7fryenjc28UP++jQFwCjiUAfb13Eo/fwwhKN+J+uAX5bj1igrp7o2vb2
         grkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693212707; x=1693817507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QlQsqhbMuO0FCtthsUOG1XI6SmEnrXMxQcpEIHQeP4=;
        b=mASCGU8cZ6ro4LHKgIVLSBX0wEH1OYKC2PSdpMAC77Bi3e7QgITAg8rsrZgiaNqfC9
         crxFwE+Mxgv+QOMGZHryDCCccRXPGxC7RPpCdTfNuSK9l7pif+4A9PlIOXuBXuQEuAlR
         nhCK7ViYxxfrqCBx2Irzr6lf+Nq2jh0rmagCNFpP0i1d5v8TxWHbJ79zguRCIv8RDZFV
         VPBlAlojC5Vp6cVwZuNZSFpvDMC4xXLIvw7qJT+BG2jEs/Cm3AaY2xpYt2U7B03CU648
         lFlnK4B27BaS7fxmP7vOCW5U4GO+zJvxb6vCh0IFd3YwCmlNoM459upOiKJM/N/+v0rx
         pg8g==
X-Gm-Message-State: AOJu0Yy65G+s181XewBCDnjy3ZlFjNdRqpFH3+3wOnunvWq7u93S07lo
        AC9hfXmzSqTISU1lI9u63yrrc+1qsgleFIrOtxeY053VQE0=
X-Google-Smtp-Source: AGHT+IGvcGpJ/BkF2tzwfwhnDeHi0Sl7YUGemSsVyjafNd6vWGXzxLfatq2nynP+7qkXioJZBv/dybpjBkJ3VJz1WCg=
X-Received: by 2002:a0c:e392:0:b0:64e:c5da:49e0 with SMTP id
 a18-20020a0ce392000000b0064ec5da49e0mr23572729qvl.13.1693212707398; Mon, 28
 Aug 2023 01:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230823061734.27479-1-wenchao.chen@unisoc.com> <CAPDyKFqbY5yLNwhODDq0XimKtnf0V93rEbmSdG+qZ2FrYWJFsw@mail.gmail.com>
In-Reply-To: <CAPDyKFqbY5yLNwhODDq0XimKtnf0V93rEbmSdG+qZ2FrYWJFsw@mail.gmail.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Mon, 28 Aug 2023 16:51:35 +0800
Message-ID: <CA+Da2qw+JR5oVONzX9C3YtSZfXjTZnDa=3+iUpwvCqN6m1ApLQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] mmc: hsq: Dynamically adjust hsq_depth to improve performance
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Wenchao Chen <wenchao.chen@unisoc.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhenxiong.lai@unisoc.com,
        yuelin.tang@unisoc.com
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

On Thu, Aug 24, 2023 at 6:26=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Wed, 23 Aug 2023 at 08:18, Wenchao Chen <wenchao.chen@unisoc.com> wrot=
e:
> >
> > Change in v2:
> > - Support for dynamic adjustment of hsq_depth.
> >
> > Test
> > =3D=3D=3D=3D=3D
> > I tested 3 times for each case and output a average speed.
> > Ran 'fio' to evaluate the performance:
> > 1.Fixed hsq_depth
> > 1) Sequential write:
> > Speed: 168 164 165
> > Average speed: 165.67MB/S
> >
> > 2) Sequential read:
> > Speed: 326 326 326
> > Average speed: 326MB/S
> >
> > 3) Random write:
> > Speed: 82.6 83 83
> > Average speed: 82.87MB/S
> >
> > 4) Random read:
> > Speed: 48.2 48.3 47.6
> > Average speed: 48.03MB/S
> >
> > 2.Dynamic hsq_depth
> > 1) Sequential write:
> > Speed: 167 166 166
> > Average speed: 166.33MB/S
> >
> > 2) Sequential read:
> > Speed: 327 326 326
> > Average speed: 326.3MB/S
> >
> > 3) Random write:
> > Speed: 86.1 86.2 87.7
> > Average speed: 86.67MB/S
> >
> > 4) Random read:
> > Speed: 48.1 48 48
> > Average speed: 48.03MB/S
> >
> > Based on the above data, dynamic hsq_depth can improve the performance =
of random writes.
> > Random write improved by 4.6%.
>
> Thanks for sharing this, interesting!
>
> >
> > Test cmd
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1)write: fio -filename=3D/dev/mmcblk0p72 -direct=3D1 -rw=3Dwrite -bs=3D=
512K -size=3D512M -group_reporting -name=3Dtest -numjobs=3D8 -thread -iodep=
th=3D64
> > 2)read: fio -filename=3D/dev/mmcblk0p72 -direct=3D1 -rw=3Dread -bs=3D51=
2K -size=3D512M -group_reporting -name=3Dtest -numjobs=3D8 -thread -iodepth=
=3D64
> > 3)randwrite: fio -filename=3D/dev/mmcblk0p72 -direct=3D1 -rw=3Drandwrit=
e -bs=3D4K -size=3D512M -group_reporting -name=3Dtest -numjobs=3D8 -thread =
-iodepth=3D64
> > 4)randread: fio -filename=3D/dev/mmcblk0p72 -direct=3D1 -rw=3Drandread =
-bs=3D4K -size=3D512M -group_reporting -name=3Dtest -numjobs=3D8 -thread -i=
odepth=3D64
> >
>
> The buffer you used for randwrite/randread is 4K blocks. Did you try
> with something bigger too?
>
Hi Uffe
I tried bs=3D8k and bs=3D16k, the random read and random write performance
improvement was not noticeable.

1.Fixed hsq_depth
1) Random write(bs=3D8K):
Speed: 116 114 115
Average speed: 115MB/S

2) Random read(bs=3D8K):
Speed: 83 83 82.5
Average speed: 82.8MB/S

3) Random write(bs=3D16K):
Speed: 141 142 141
Average speed: 141.3MB/S

4) Random read(bs=3D16K):
Speed: 132 132 132
Average speed: 132MB/S

2.Dynamic hsq_depth
1) Random write(bs=3D8K):
Speed: 115 115 115
Average speed: 115MB/S

2) Random read(bs=3D8K):
Speed: 82.7 82.9 82.8
Average speed: 82.8MB/S

3) Random write(bs=3D16K):
Speed: 143 141 141
Average speed: 141.6MB/S

4) Random read(bs=3D16K):
Speed: 132 132 132
Average speed: 132MB/S

> Or maybe we are afraid of introducing a bigger latency if we
> dynamically change the hsq_depth to match something bigger than 4K?
>

Increasing hsq_depth cannot improve 8k and 16k random read/write performanc=
e.
To reduce latency, we dynamically increase hsq_depth only for 4k random wri=
tes.

> >
> > Wenchao Chen (2):
> >   mmc: queue: replace immediate with hsq->depth
> >   mmc: hsq: dynamic adjustment of hsq->depth
> >
> >  drivers/mmc/core/queue.c   |  6 +-----
> >  drivers/mmc/host/mmc_hsq.c | 27 +++++++++++++++++++++++++++
> >  drivers/mmc/host/mmc_hsq.h |  8 ++++++++
> >  include/linux/mmc/host.h   |  1 +
> >  4 files changed, 37 insertions(+), 5 deletions(-)
> >
>
> Kind regards
> Uffe

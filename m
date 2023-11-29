Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46077FD11C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjK2IkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjK2Ij5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:39:57 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D9A26A3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:39:49 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a178e82a445so25696866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701247187; x=1701851987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwR1qGVD5UuieDG2qJJImYrNn7TWBJoCLLLYl7IcSxI=;
        b=ndl7uYYZQrdH08eb6FhzYl/hsSmgKrIAiHpdOixuiFQirtLa3tM39+eEVpQM/TnnKj
         V3zRUHAC7ApmtTfYqfUQTi5DrAnX0hefYPC1JEb1vQATh3cE5sA013OQj1LNtC3GxND9
         cJF6iT+0sY2A2JfjgnjPGKT9KKtCiJPAoB1YQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701247187; x=1701851987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwR1qGVD5UuieDG2qJJImYrNn7TWBJoCLLLYl7IcSxI=;
        b=oXIEUIm60j6ImBk/iNCGsWTN1oF5QfcK1Ew3I4R9ksA11I6CvQhGmpAz8GAxxinwkM
         4tasiWph8IhrONVEAsgt5TS33uyIl6Er7uNbyGJpzolwSjHDaxmooNkaBB4hy3OVN37t
         Itu+A8Uog9Y1Dupec/ZRcYM3dCYByDobNViUGM/+P3shHEzUrXqyI3RZUDyLIx326b08
         vubwIK9EIgra5Miu704GdecgsszFjwjGRULkMGHLrCTyMyH0/RmBjG+PyMaMw3C+0MKS
         gt5BLu33ezMGVDeFEgLxmJY52AucV/qKY41pfhPTWVunS0+jsLic0idHTLc8faVB45Ib
         lqwg==
X-Gm-Message-State: AOJu0YwXX7GejGfgVMKpLpohsJYYhjBZPEW7MUa2+oeErUYyOpOthQPs
        RtPYsE7+cekrfGP0Sl0ZF3jZbVLKzSzfvz51WW+1vtZz
X-Google-Smtp-Source: AGHT+IGgz0kEHraKS+5/gza9MQDqG9LdoDF1zmAWT2I51SUxSxFg/ZrthRZgqHa7y4+6kJkyIwjS5w==
X-Received: by 2002:a17:906:116:b0:9c5:cfa3:d030 with SMTP id 22-20020a170906011600b009c5cfa3d030mr13682367eje.54.1701247186912;
        Wed, 29 Nov 2023 00:39:46 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id r5-20020a170906c28500b00a0b66ef92dfsm5190266ejz.218.2023.11.29.00.39.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 00:39:46 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40b5155e154so5611895e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:39:46 -0800 (PST)
X-Received: by 2002:adf:f88c:0:b0:319:7c0f:d920 with SMTP id
 u12-20020adff88c000000b003197c0fd920mr11878172wrp.57.1701247185816; Wed, 29
 Nov 2023 00:39:45 -0800 (PST)
MIME-Version: 1.0
References: <20231127165454.166373-1-benjamin.gaignard@collabora.com>
 <20231127165454.166373-8-benjamin.gaignard@collabora.com> <20231127170700.GC31314@pendragon.ideasonboard.com>
 <6fa1ec09-3e30-475e-9718-29d23586753e@collabora.com> <CAAFQd5DCVTLpPoKSp_OA6fe_Hqt-oV7=AsCZWSmkJORvLSgUiw@mail.gmail.com>
 <995eb6c2-cc7f-4217-bc37-4ab1a32f36ee@collabora.com> <CAAFQd5Bv5kc9TfNM5CkKowvaoRndTmkmU6+0LyCG8YbOKy=hxQ@mail.gmail.com>
 <b68b3fa5-a152-4b23-9451-61a89530512c@collabora.com>
In-Reply-To: <b68b3fa5-a152-4b23-9451-61a89530512c@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 29 Nov 2023 17:39:25 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DXhDtcfjgds6qu2YZXkkcvJdygkvtFknrHRGRC5oRHkA@mail.gmail.com>
Message-ID: <CAAFQd5DXhDtcfjgds6qu2YZXkkcvJdygkvtFknrHRGRC5oRHkA@mail.gmail.com>
Subject: Re: [PATCH 07/55] media: imx8-isi: Stop abusing of min_buffers_needed field
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        hverkuil@xs4all.nl, mchehab@kernel.org, m.szyprowski@samsung.com,
        matt.ranostay@konsulko.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        kernel@collabora.com, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 5:28=E2=80=AFPM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
>
> Le 29/11/2023 =C3=A0 05:17, Tomasz Figa a =C3=A9crit :
> > On Tue, Nov 28, 2023 at 7:26=E2=80=AFPM Benjamin Gaignard
> > <benjamin.gaignard@collabora.com> wrote:
> >>
> >> Le 28/11/2023 =C3=A0 10:35, Tomasz Figa a =C3=A9crit :
> >>> On Tue, Nov 28, 2023 at 6:31=E2=80=AFPM Benjamin Gaignard
> >>> <benjamin.gaignard@collabora.com> wrote:
> >>>> Le 27/11/2023 =C3=A0 18:07, Laurent Pinchart a =C3=A9crit :
> >>>>> Hi Benjamin,
> >>>>>
> >>>>> Thank you for the patch.
> >>>>>
> >>>>> On Mon, Nov 27, 2023 at 05:54:06PM +0100, Benjamin Gaignard wrote:
> >>>>>> 'min_buffers_needed' is suppose to be used to indicate the number
> >>>>>> of buffers needed by DMA engine to start streaming.
> >>>>>> imx8-isi driver doesn't use DMA engine and just want to specify
> >>>>> What do you mean, "doesn't use DMA engine" ? The ISI surely has DMA
> >>>>> engines :-)
> >>>> I have done assumption on drivers given if they use or dma_* functio=
ns.
> >>> I suspect the use of vb2_dma_sg_plane_desc() and
> >>> vb2_dma_contig_plane_dma_addr() may be more correlated to whether
> >>> there is a DMA involved or not. Usually V4L2 drivers don't really hav=
e
> >>> to deal with the DMA API explicitly, because the vb2 framework handle=
s
> >>> most of the work.
> >> Unfortunately isn't not true either, for example verisilicon driver us=
e
> >> these function but doesn't need DMA engine.
> > That sounds weird. Why would a driver that doesn't have a DMA engine
> > need to obtain a scatterlist or the DMA address of the buffer?
>
> Just because the hardware needs the physical address of the buffer to acc=
ess it.
>

Right, and the part of the hardware that accesses the memory is called
a DMA engine.

> >
> >> I haven't found yet a 100% criteria to decide if driver use or not DMA=
 engine
> >> so I plan to fix case by case given maintainers remarks.
> > Yeah, there probably wouldn't be a way that would give one a 100%
> > certainty, although I'd still insist that the two functions I
> > mentioned should be close to that. Of course a driver can use those
> > functions for some queues, while other queues would be pure software
> > queues, e.g. for some metadata - a simple grep is not enough. Is that
> > perhaps the case for the verisilicon driver?
>
> Verisilicon hardware block doesn't have IOMMU so it needs the physical
> addresses of all the buffers it use (input buffer, reference frame buffer=
s, etc...).
> No DMA engine involved here it is just how the hardware is working.

I think we need to clarify what you mean by DMA engine. If it's
basically a standalone hardware block that does the DMA for another
hardware block, i.e. such as the standalone DMA engines under
drivers/dma, then I'd like to ask what the relation is between using
an external DMA engine and min_buffers_needed.

> Expect functions like dma_release_channel() or being in PCI directory,
> I don't have found any magical way to know if a driver needs a minimum nu=
mber of buffers before start streaming.
> I can only read the code and do assumptions for the other cases.
> I hope maintainers, like Laurent or you, will answer to this question for=
 each driver.
>

In theory that could work too, so hopefully we can achieve that. Some
drivers may not have very active maintainers... And other maintainers
who never worked with such drivers are as suited to read the code and
guess the expected state as you. That said, let's make sure that
everyone involved does their best, without pushing the task around.

Best regards,
Tomasz

> Regards,
> Benjamin
>
> >
> > Best regards,
> > Tomasz
> >
> >> Regards,
> >> Benjamin
> >>
> >>> Best regards,
> >>> Tomasz
> >>>
> >>>> I have considers that all PCI drivers are using DMA engine and
> >>>> I don't know the design for each drivers so I hope to get this infor=
mation
> >>>> from maintainers and fix that in v2.
> >>>> If imx8-isi driver needs a minimum number of buffers before start st=
reaming
> >>>> I will do a v2 and use min_dma_buffers_needed instead.
> >>>>
> >>>> Regards,
> >>>> Benjamin
> >>>>
> >>>>>> the minimum number of buffers to allocate when calling VIDIOC_REQB=
UFS.
> >>>>>> That 'min_reqbufs_allocation' field purpose so use it.
> >>>>>>
> >>>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> >>>>>> CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>>>>> CC: Mauro Carvalho Chehab <mchehab@kernel.org>
> >>>>>> CC: Shawn Guo <shawnguo@kernel.org>
> >>>>>> CC: Sascha Hauer <s.hauer@pengutronix.de>
> >>>>>> CC: Pengutronix Kernel Team <kernel@pengutronix.de>
> >>>>>> CC: Fabio Estevam <festevam@gmail.com>
> >>>>>> CC: NXP Linux Team <linux-imx@nxp.com>
> >>>>>> ---
> >>>>>>     drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c | 2 +-
> >>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c =
b/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
> >>>>>> index 49bca2b01cc6..81673ff9084b 100644
> >>>>>> --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
> >>>>>> +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
> >>>>>> @@ -1453,7 +1453,7 @@ int mxc_isi_video_register(struct mxc_isi_pi=
pe *pipe,
> >>>>>>        q->mem_ops =3D &vb2_dma_contig_memops;
> >>>>>>        q->buf_struct_size =3D sizeof(struct mxc_isi_buffer);
> >>>>>>        q->timestamp_flags =3D V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> >>>>>> -    q->min_buffers_needed =3D 2;
> >>>>>> +    q->min_reqbufs_allocation =3D 2;
> >>>>>>        q->lock =3D &video->lock;
> >>>>>>        q->dev =3D pipe->isi->dev;
> >>>>>>

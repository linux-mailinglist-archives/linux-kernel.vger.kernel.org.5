Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8627E6714
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjKIJsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKIJsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:48:38 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7D4271C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:48:36 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5401bab7525so986828a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 01:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699523314; x=1700128114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DilLKYDfiJHifO/My66ufTYoZBnb4NT+vvrqkX7FBNE=;
        b=HUZ7LK7//OQZcRIixLlVUPSTAJUiKGzIciDJhOkpwgdYhdIvTAPbv0X1FOnSoodnQM
         Of6cdJhMZkYPfxmlF3g4xMGZv6idHxw4KVBkH0meAlJT5IFGgcMLu371ZRmmJpsfuI/Q
         Hk7vwAsT/wxiQkdlTgmCXfFtuhSfOOBhmaXSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699523314; x=1700128114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DilLKYDfiJHifO/My66ufTYoZBnb4NT+vvrqkX7FBNE=;
        b=T3d88ANzksvd8uQO0RPKcBzx4jE4kah//AAQ+wTESLYZD+Zyit4abl0nYH8jX2njjV
         NLhxct3T9YRydw9I0D9Yd2Eznjiw2Zp2p9VaBCUlhi4uNEr5ZdNxHY6XJ5MT0uLslyDe
         NUWY+w4A1YHyhqfd+XeZMRGB5iJPHpPEiJ4m+L1jDx5zGWLdhPONJfsFUOTSSddH/P/g
         bPKOqXhXJSEFVgPzOgoc1rj3L09Y+lTJhB70UWp0G/c32iFoeCAcliCAFMlw+zRxR+Su
         CIM6x+yici8HcJNWAKIxOVnj8XXxEKoxvmlvbFJ+fjaTtC1ygtU7tLTbeM05vFTzb2xF
         jfaA==
X-Gm-Message-State: AOJu0YwM3Vr2anpqQ/XD4hxDlw1zYloKiSSyaAuMKPydr8jUU/h8BwGQ
        noT1AUS7n6lgs7hftplYxuW+ztbIz+yhE+O4IbOhIWqb
X-Google-Smtp-Source: AGHT+IGTd+NnaqOv/IUc+RG6FO9yyE8qUZm5pJ2uEX9Yjqy1ARluvpaqvwtqlFgm4ZQUgEwtoYJymg==
X-Received: by 2002:a50:a404:0:b0:543:caf4:e5bc with SMTP id u4-20020a50a404000000b00543caf4e5bcmr4282894edb.1.1699523313932;
        Thu, 09 Nov 2023 01:48:33 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id t28-20020a508d5c000000b0053e5a1bf77dsm8091260edt.88.2023.11.09.01.48.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 01:48:33 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40906fc54fdso4519375e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 01:48:33 -0800 (PST)
X-Received: by 2002:a5d:64a9:0:b0:32f:7f09:160f with SMTP id
 m9-20020a5d64a9000000b0032f7f09160fmr4230407wrp.12.1699523312965; Thu, 09 Nov
 2023 01:48:32 -0800 (PST)
MIME-Version: 1.0
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
 <20231031163104.112469-57-benjamin.gaignard@collabora.com>
 <20231109094311.yzmmn4vvskmrk4tk@chromium.org> <2f5ad14b-528d-4656-84d8-f85467c5b475@collabora.com>
In-Reply-To: <2f5ad14b-528d-4656-84d8-f85467c5b475@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 9 Nov 2023 18:48:15 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CH=NoDUJArp=6_28WSgkQ3jTMR3SOyx1iYro-7e4c2hA@mail.gmail.com>
Message-ID: <CAAFQd5CH=NoDUJArp=6_28WSgkQ3jTMR3SOyx1iYro-7e4c2hA@mail.gmail.com>
Subject: Re: [PATCH v14 56/56] media: test-drivers: Use helper for DELETE_BUFS ioctl
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, m.szyprowski@samsung.com, ming.qian@nxp.com,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 6:46=E2=80=AFPM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
>
> Le 09/11/2023 =C3=A0 10:43, Tomasz Figa a =C3=A9crit :
> > On Tue, Oct 31, 2023 at 05:31:04PM +0100, Benjamin Gaignard wrote:
> >> Allow test drivers to use DELETE_BUFS by adding vb2_ioctl_delete_bufs(=
) helper.
> >>
> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> >> ---
> >>   drivers/media/test-drivers/vicodec/vicodec-core.c |  2 ++
> >>   drivers/media/test-drivers/vimc/vimc-capture.c    |  2 ++
> >>   drivers/media/test-drivers/visl/visl-video.c      |  2 ++
> >>   drivers/media/test-drivers/vivid/vivid-core.c     | 13 ++++++++++---
> >>   4 files changed, 16 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/media/test-drivers/vicodec/vicodec-core.c b/drive=
rs/media/test-drivers/vicodec/vicodec-core.c
> >> index 69cbe2c094e1..f14a8fd506d0 100644
> >> --- a/drivers/media/test-drivers/vicodec/vicodec-core.c
> >> +++ b/drivers/media/test-drivers/vicodec/vicodec-core.c
> >> @@ -1339,6 +1339,7 @@ static const struct v4l2_ioctl_ops vicodec_ioctl=
_ops =3D {
> >>      .vidioc_prepare_buf     =3D v4l2_m2m_ioctl_prepare_buf,
> >>      .vidioc_create_bufs     =3D v4l2_m2m_ioctl_create_bufs,
> >>      .vidioc_expbuf          =3D v4l2_m2m_ioctl_expbuf,
> >> +    .vidioc_delete_bufs     =3D v4l2_m2m_ioctl_delete_bufs,
> >>
> >>      .vidioc_streamon        =3D v4l2_m2m_ioctl_streamon,
> >>      .vidioc_streamoff       =3D v4l2_m2m_ioctl_streamoff,
> >> @@ -1725,6 +1726,7 @@ static int queue_init(void *priv, struct vb2_que=
ue *src_vq,
> >>      dst_vq->mem_ops =3D &vb2_vmalloc_memops;
> >>      dst_vq->timestamp_flags =3D V4L2_BUF_FLAG_TIMESTAMP_COPY;
> >>      dst_vq->lock =3D src_vq->lock;
> >> +    dst_vq->supports_delete_bufs =3D true;
> > Since we have to explicitly provide the vidioc_delete_bufs callback any=
way,
> > is there any value in having a separate supports_delete_bufs flag? Or w=
e
> > envision that some drivers would support deleting buffers only for some
> > queues?
>
> That exactly the case for Hantro driver, it can support deleting buffers =
on
> capture queue but not on output queue.

Fair enough.

Best regards,
Tomasz

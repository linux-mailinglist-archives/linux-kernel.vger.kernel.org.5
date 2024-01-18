Return-Path: <linux-kernel+bounces-29901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D208314E9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89C5C1F24F6D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E816B1BF21;
	Thu, 18 Jan 2024 08:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5IJyUNo"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02267125B1;
	Thu, 18 Jan 2024 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705567026; cv=none; b=KHDNbtMPPub70E6w1DiBdDaNNAoMxrrs3hvuJrfpPY/V0pGB4AN9TIbSBc4gdbLomz8HporcmFAmcvysHlhGVSK3O4BgpupBkYgIeJJFycMFX2kFMKKqKh1EDXrwW7roEqZpOBqVo3J6rCULs/HIB6jYsRkHArES4tD+kj1KEW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705567026; c=relaxed/simple;
	bh=blT46EeNAT2lvM0XGAEM/w5Qul65WnYYWgsZC3sBwwI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=S1Aj5HSowIGOKHoh5esYXvzGTrbDYsqGXve9nXgEAoa46tVnSAZi4f7TNsfteLDo1NXP4Xt4jxwiHgEag6cBoYuMH6EQm5b7vsxvulzneTyw2kues64ZYXdg6cgnAPMfpMjxnpBQAlpRp0/LWtTEk9ksRUQsqf9k4MLvk0p96d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5IJyUNo; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3619cc9cc65so1541065ab.3;
        Thu, 18 Jan 2024 00:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705567024; x=1706171824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fh9hL8siDGAkPJkrugRo3TBGAwILVgXfs1AnjA1KuoA=;
        b=h5IJyUNoKNu0F4P11I4+ud5a28oHkCMgAWmuLnoQ3eLxJj8sQkVsNddBWLsWrvpyyK
         DKmERDFjq+5wf9QyrMxiVkx9DVmuDrRUoCMDtTrItpoMq67wH5X9f5tX+IcIOcFKerGY
         Y8bU7ztLxX8tWWhGuyPGcVtCNG/yDDnM1xXCDooH80LWNUlE+WRJYRiWd4zmwCO8Mate
         /IBAPUzmVBuLmZm8DJBaVwFfrgaPH13LsQ3lC/grqNkw0OO6EgQHEz7aloq/Vlry1Eae
         5yBEkN+IszohJitEeU6sQjI65pZOHh9iirWNKUbXlN8q3D87dkYUmBFKHEgYcbyvkLIj
         jfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705567024; x=1706171824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fh9hL8siDGAkPJkrugRo3TBGAwILVgXfs1AnjA1KuoA=;
        b=f+M12OqtTWf2PS75DJIiLyHA3iKvLPrDs9MC9q7zVWimGIKpu1TWm6sOZGHYpdx1Ak
         lZu4zqIakL04MFYoecQEDb1753ezv82mS9IvJw9QIgE+lMntBKy5KwWvZnuNV2aIFiAe
         vJfPGHCNST9EWZUZpXoH0pzt6a/h7eKjRj0kZH7GW8Hc+wdy8EXhid7ddugPv10dsJnM
         87oJcvq9GUmUuPDmHU1W6EfFntQ3sM6JXoOHo/j6lvf2nvL3hRsqyAnRAKkab6xSPQoW
         G2MTi+Ll4+qm0qktqY0YrxzPyhyUkQufERfmqAzOBJFMJcS1vEzOPN2EUsenAoyWQj4B
         ZUHg==
X-Gm-Message-State: AOJu0Yxf8DyTCVgVGz4t4s6e159sR+QBNdgZ/7pmoEv3T4wVLKZjOSli
	TaWXG7Eooulp4b/VkzcOTYryExDJxZ9F/wj0T8OIWxQVDrbskU5XrNBwBo26PIRttvR1heMy80E
	xIwerBGG/03jjVqDTu45uBcQRsD4=
X-Google-Smtp-Source: AGHT+IGRS1MB9b/FeahgRnO/sHuiqaEenCNdikBhB5J7hFZDZenBbXYmia0YjqpNtKpaWkHvwxhQEPHs94i62pVA46M=
X-Received: by 2002:a92:d812:0:b0:360:62c9:4209 with SMTP id
 y18-20020a92d812000000b0036062c94209mr582034ilm.0.1705567024010; Thu, 18 Jan
 2024 00:37:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1700637838-6743-1-git-send-email-shengjiu.wang@nxp.com>
 <1700637838-6743-16-git-send-email-shengjiu.wang@nxp.com> <6d96cf56-c534-4abf-8819-03cd32fda3d5@xs4all.nl>
 <CAA+D8ANfkQkuV9YgQQ1ggS2G0GhqvmhZrA6Yn-et0E5z6mPSxQ@mail.gmail.com> <099df0d8-10c8-4a78-827b-7e000f02ca3f@xs4all.nl>
In-Reply-To: <099df0d8-10c8-4a78-827b-7e000f02ca3f@xs4all.nl>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 18 Jan 2024 16:36:53 +0800
Message-ID: <CAA+D8AM-ESJJp8M-gPVm2zvUu_WMXasy0BLjp4uk_ujeQYrkXg@mail.gmail.com>
Subject: Re: [PATCH v11 15/15] media: vim2m-audio: add virtual driver for
 audio memory to memory
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, sakari.ailus@iki.fi, tfiga@chromium.org, 
	m.szyprowski@samsung.com, mchehab@kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 3:56=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.nl> w=
rote:
>
> On 18/01/2024 07:13, Shengjiu Wang wrote:
> > On Wed, Jan 17, 2024 at 6:32=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.n=
l> wrote:
> >>
> >> On 22/11/2023 08:23, Shengjiu Wang wrote:
> >>> Audio memory to memory virtual driver use video memory to memory
> >>> virtual driver vim2m.c as example. The main difference is
> >>> device type is VFL_TYPE_AUDIO and device cap type is V4L2_CAP_AUDIO_M=
2M.
> >>>
> >>> The device_run function is a dummy function, which is simply
> >>> copy the data from input buffer to output buffer.
> >>>
> >>> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> >>> ---
> >>>  drivers/media/test-drivers/Kconfig       |  11 +
> >>>  drivers/media/test-drivers/Makefile      |   1 +
> >>>  drivers/media/test-drivers/vim2m-audio.c | 799 +++++++++++++++++++++=
++
> >>>  3 files changed, 811 insertions(+)
> >>>  create mode 100644 drivers/media/test-drivers/vim2m-audio.c
> >>>
> >>> diff --git a/drivers/media/test-drivers/Kconfig b/drivers/media/test-=
drivers/Kconfig
> >>> index 459b433e9fae..55f8af6ee4e2 100644
> >>> --- a/drivers/media/test-drivers/Kconfig
> >>> +++ b/drivers/media/test-drivers/Kconfig
> >>> @@ -17,6 +17,17 @@ config VIDEO_VIM2M
> >>>         This is a virtual test device for the memory-to-memory driver
> >>>         framework.
> >>>
> >>> +config VIDEO_VIM2M_AUDIO
> >>> +     tristate "Virtual Memory-to-Memory Driver For Audio"
> >>> +     depends on VIDEO_DEV
> >>> +     select VIDEOBUF2_VMALLOC
> >>> +     select V4L2_MEM2MEM_DEV
> >>> +     select MEDIA_CONTROLLER
> >>> +     select MEDIA_CONTROLLER_REQUEST_API
> >>
> >> Drop this. This option has been removed.
> >>
> >>> +     help
> >>> +       This is a virtual audio test device for the memory-to-memory =
driver
> >>> +       framework.
> >>> +
> >>>  source "drivers/media/test-drivers/vicodec/Kconfig"
> >>>  source "drivers/media/test-drivers/vimc/Kconfig"
> >>>  source "drivers/media/test-drivers/vivid/Kconfig"
> >>> diff --git a/drivers/media/test-drivers/Makefile b/drivers/media/test=
-drivers/Makefile
> >>> index 740714a4584d..0c61c9ada3e1 100644
> >>> --- a/drivers/media/test-drivers/Makefile
> >>> +++ b/drivers/media/test-drivers/Makefile
> >>> @@ -10,6 +10,7 @@ obj-$(CONFIG_DVB_VIDTV) +=3D vidtv/
> >>>
> >>>  obj-$(CONFIG_VIDEO_VICODEC) +=3D vicodec/
> >>>  obj-$(CONFIG_VIDEO_VIM2M) +=3D vim2m.o
> >>> +obj-$(CONFIG_VIDEO_VIM2M_AUDIO) +=3D vim2m-audio.o
> >>>  obj-$(CONFIG_VIDEO_VIMC) +=3D vimc/
> >>>  obj-$(CONFIG_VIDEO_VIVID) +=3D vivid/
> >>>  obj-$(CONFIG_VIDEO_VISL) +=3D visl/
> >>> diff --git a/drivers/media/test-drivers/vim2m-audio.c b/drivers/media=
/test-drivers/vim2m-audio.c
> >>> new file mode 100644
> >>> index 000000000000..72806ada8628
> >>> --- /dev/null
> >>> +++ b/drivers/media/test-drivers/vim2m-audio.c
> >>> @@ -0,0 +1,799 @@
> >>> +// SPDX-License-Identifier: GPL-2.0+
> >>> +/*
> >>> + * A virtual v4l2-mem2mem example for audio device.
> >>> + */
> >>> +
> >>> +#include <linux/module.h>
> >>> +#include <linux/delay.h>
> >>> +#include <linux/fs.h>
> >>> +#include <linux/sched.h>
> >>> +#include <linux/slab.h>
> >>> +
> >>> +#include <linux/platform_device.h>
> >>> +#include <media/v4l2-mem2mem.h>
> >>> +#include <media/v4l2-device.h>
> >>> +#include <media/v4l2-ioctl.h>
> >>> +#include <media/v4l2-ctrls.h>
> >>> +#include <media/v4l2-event.h>
> >>> +#include <media/videobuf2-vmalloc.h>
> >>> +#include <sound/dmaengine_pcm.h>
> >>> +
> >>> +MODULE_DESCRIPTION("Virtual device for audio mem2mem testing");
> >>> +MODULE_LICENSE("GPL");
> >>> +
> >>> +static unsigned int debug;
> >>> +module_param(debug, uint, 0644);
> >>> +MODULE_PARM_DESC(debug, "debug level");
> >>> +
> >>> +#define MEM2MEM_NAME "vim2m-audio"
> >>> +
> >>> +#define dprintk(dev, lvl, fmt, arg...) \
> >>> +     v4l2_dbg(lvl, debug, &(dev)->v4l2_dev, "%s: " fmt, __func__, ##=
 arg)
> >>> +
> >>> +#define SAMPLE_NUM 4096
> >>> +
> >>> +static void audm2m_dev_release(struct device *dev)
> >>> +{}
> >>> +
> >>> +static struct platform_device audm2m_pdev =3D {
> >>> +     .name           =3D MEM2MEM_NAME,
> >>> +     .dev.release    =3D audm2m_dev_release,
> >>> +};
> >>> +
> >>> +static u32 formats[] =3D {
> >>> +     V4L2_AUDIO_FMT_S16_LE,
> >>> +};
> >>> +
> >>> +#define NUM_FORMATS ARRAY_SIZE(formats)
> >>> +
> >>> +/* Per-queue, driver-specific private data */
> >>> +struct audm2m_q_data {
> >>> +     unsigned int            rate;
> >>> +     unsigned int            channels;
> >>> +     unsigned int            buffersize;
> >>> +     unsigned int            sequence;
> >>> +     u32                     fourcc;
> >>> +};
> >>> +
> >>> +enum {
> >>> +     V4L2_M2M_SRC =3D 0,
> >>> +     V4L2_M2M_DST =3D 1,
> >>> +};
> >>> +
> >>> +static snd_pcm_format_t find_format(u32 fourcc)
> >>> +{
> >>> +     snd_pcm_format_t fmt;
> >>> +     unsigned int k;
> >>> +
> >>> +     for (k =3D 0; k < NUM_FORMATS; k++) {
> >>> +             if (formats[k] =3D=3D fourcc)
> >>> +                     break;
> >>> +     }
> >>> +
> >>> +     if (k =3D=3D NUM_FORMATS)
> >>> +             return 0;
> >>> +
> >>> +     fmt =3D v4l2_fourcc_to_audfmt(formats[k]);
> >>> +
> >>> +     return fmt;
> >>> +}
> >>> +
> >>> +struct audm2m_dev {
> >>> +     struct v4l2_device      v4l2_dev;
> >>> +     struct video_device     vfd;
> >>> +
> >>> +     struct mutex            dev_mutex;
> >>> +
> >>> +     struct v4l2_m2m_dev     *m2m_dev;
> >>> +#ifdef CONFIG_MEDIA_CONTROLLER
> >>> +     struct media_device     mdev;
> >>> +#endif
> >>> +};
> >>> +
> >>> +struct audm2m_ctx {
> >>> +     struct v4l2_fh          fh;
> >>> +     struct v4l2_ctrl_handler        ctrl_handler;
> >>> +     struct audm2m_dev       *dev;
> >>> +
> >>> +     struct mutex            vb_mutex;
> >>> +
> >>> +     /* Source and destination queue data */
> >>> +     struct audm2m_q_data   q_data[2];
> >>> +};
> >>> +
> >>> +static inline struct audm2m_ctx *file2ctx(struct file *file)
> >>> +{
> >>> +     return container_of(file->private_data, struct audm2m_ctx, fh);
> >>> +}
> >>> +
> >>> +static struct audm2m_q_data *get_q_data(struct audm2m_ctx *ctx,
> >>> +                                     enum v4l2_buf_type type)
> >>> +{
> >>> +     if (type =3D=3D V4L2_BUF_TYPE_AUDIO_OUTPUT)
> >>> +             return &ctx->q_data[V4L2_M2M_SRC];
> >>> +     return &ctx->q_data[V4L2_M2M_DST];
> >>> +}
> >>> +
> >>> +static const char *type_name(enum v4l2_buf_type type)
> >>> +{
> >>> +     if (type =3D=3D V4L2_BUF_TYPE_AUDIO_OUTPUT)
> >>> +             return "Output";
> >>> +     return "Capture";
> >>> +}
> >>> +
> >>> +/*
> >>> + * mem2mem callbacks
> >>> + */
> >>> +
> >>> +/*
> >>> + * device_run() - prepares and starts the device
> >>> + */
> >>> +static void device_run(void *priv)
> >>> +{
> >>> +     struct audm2m_ctx *ctx =3D priv;
> >>> +     struct audm2m_dev *audm2m_dev;
> >>> +     struct vb2_v4l2_buffer *src_buf, *dst_buf;
> >>> +     struct audm2m_q_data *q_data_src, *q_data_dst;
> >>> +     int src_size, dst_size =3D 0;
> >>> +     short *src_addr, *dst_addr;
> >>> +     int i;
> >>> +
> >>> +     audm2m_dev =3D ctx->dev;
> >>> +
> >>> +     q_data_src =3D get_q_data(ctx, V4L2_BUF_TYPE_AUDIO_OUTPUT);
> >>> +     if (!q_data_src)
> >>> +             return;
> >>> +
> >>> +     q_data_dst =3D get_q_data(ctx, V4L2_BUF_TYPE_AUDIO_CAPTURE);
> >>> +     if (!q_data_dst)
> >>> +             return;
> >>> +
> >>> +     src_buf =3D v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
> >>> +     dst_buf =3D v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
> >>> +     src_buf->sequence =3D q_data_src->sequence++;
> >>> +     dst_buf->sequence =3D q_data_dst->sequence++;
> >>> +     v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, false);
> >>> +
> >>> +     /* Process the conversion */
> >>> +     src_size =3D vb2_get_plane_payload(&src_buf->vb2_buf, 0);
> >>> +
> >>> +     src_addr =3D vb2_plane_vaddr(&src_buf->vb2_buf, 0);
> >>> +     dst_addr =3D vb2_plane_vaddr(&dst_buf->vb2_buf, 0);
> >>> +
> >>> +     if (q_data_src->rate =3D=3D q_data_dst->rate) {
> >>> +             memcpy(dst_addr, src_addr, src_size);
> >>> +             dst_size =3D src_size;
> >>> +     } else if (q_data_src->rate =3D=3D 2 * q_data_dst->rate) {
> >>> +             /* 8k to 16k */
> >>> +             for (i =3D 0; i < src_size / 2; i++) {
> >>> +                     *dst_addr++ =3D *src_addr++;
> >>> +                     src_addr++;
> >>> +             }
> >>> +
> >>> +             dst_size =3D src_size / 2;
> >>> +     } else if (q_data_src->rate * 2 =3D=3D q_data_dst->rate) {
> >>> +             /* 16k to 8k */
> >>> +             for (i =3D 0; i < src_size / 2; i++) {
> >>> +                     *dst_addr++ =3D *src_addr;
> >>> +                     *dst_addr++ =3D *src_addr++;
> >>> +             }
> >>> +
> >>> +             dst_size =3D src_size * 2;
> >>> +     }
> >>> +
> >>> +     vb2_set_plane_payload(&dst_buf->vb2_buf, 0, dst_size);
> >>> +
> >>> +     src_buf =3D v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
> >>> +     dst_buf =3D v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
> >>> +
> >>> +     v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_DONE);
> >>> +     v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_DONE);
> >>> +     v4l2_m2m_job_finish(audm2m_dev->m2m_dev, ctx->fh.m2m_ctx);
> >>> +}
> >>> +
> >>> +static int audm2m_querycap(struct file *file, void *priv,
> >>> +                        struct v4l2_capability *cap)
> >>> +{
> >>> +     strscpy(cap->driver, MEM2MEM_NAME, sizeof(cap->driver));
> >>> +     strscpy(cap->card, MEM2MEM_NAME, sizeof(cap->card));
> >>> +     snprintf(cap->bus_info, sizeof(cap->bus_info),
> >>> +              "platform:%s", MEM2MEM_NAME);
> >>
> >> You can drop this bus_info line, it's filled in for you.
> >
> > I see there is a warning from v4l2-compliance test if this line is remo=
ved.
> >
> > warn: v4l2-compliance.cpp(676): media bus_info 'platform:vim2m-audio'
> > differs from V4L2 bus_info 'platform:vim2m-audio.0'
>
> You should also drop the line filling in the bus_info in the media device=
:
>
> <snip>
>
>
> >>> +static int audm2m_probe(struct platform_device *pdev)
> >>> +{
>
> <snip>
>
> >>> +#ifdef CONFIG_MEDIA_CONTROLLER
> >>> +     dev->mdev.dev =3D &pdev->dev;
> >>> +     strscpy(dev->mdev.model, MEM2MEM_NAME, sizeof(dev->mdev.model))=
;
> >>> +     snprintf(dev->mdev.bus_info, sizeof(dev->mdev.bus_info),
> >>> +              "platform:%s", MEM2MEM_NAME);
>
> Drop this line.
>
> >>> +     media_device_init(&dev->mdev);
>
> This function will fill it in automatically as well, and with the same
> name as querycap.
>

Got it. thanks!

Best regards
Shengjiu Wang

> Regards,
>
>         Hans
>
> >>> +     dev->mdev.ops =3D &audm2m_media_ops;
> >>> +     dev->v4l2_dev.mdev =3D &dev->mdev;
> >>> +#endif
> >>> +
> >>> +     ret =3D video_register_device(vfd, VFL_TYPE_AUDIO, 0);
> >>> +     if (ret) {
> >>> +             v4l2_err(&dev->v4l2_dev, "Failed to register video devi=
ce\n");
> >>> +             goto error_m2m;
> >>> +     }
> >>> +
> >>> +#ifdef CONFIG_MEDIA_CONTROLLER
> >>> +     ret =3D v4l2_m2m_register_media_controller(dev->m2m_dev, vfd,
> >>> +                                              MEDIA_ENT_F_PROC_AUDIO=
_RESAMPLER);
> >>> +     if (ret) {
> >>> +             v4l2_err(&dev->v4l2_dev, "Failed to init mem2mem media =
controller\n");
> >>> +             goto error_v4l2;
> >>> +     }
> >>> +
> >>> +     ret =3D media_device_register(&dev->mdev);
> >>> +     if (ret) {
> >>> +             v4l2_err(&dev->v4l2_dev, "Failed to register mem2mem me=
dia device\n");
> >>> +             goto error_m2m_mc;
> >>> +     }
> >>> +#endif
> >>> +
> >>> +     v4l2_info(&dev->v4l2_dev,
> >>> +               "Device registered as /dev/v4l-audio%d\n", vfd->num);
> >>> +
> >>> +     return 0;
> >>> +
> >>> +#ifdef CONFIG_MEDIA_CONTROLLER
> >>> +error_m2m_mc:
> >>> +     v4l2_m2m_unregister_media_controller(dev->m2m_dev);
> >>> +#endif
> >>> +error_v4l2:
> >>> +     video_unregister_device(&dev->vfd);
> >>> +     /* audm2m_device_release called by video_unregister_device to r=
elease various objects */
> >>> +     return ret;
> >>> +error_m2m:
> >>> +     v4l2_m2m_release(dev->m2m_dev);
> >>> +error_dev:
> >>> +     v4l2_device_unregister(&dev->v4l2_dev);
> >>> +error_free:
> >>> +     kfree(dev);
> >>> +
> >>> +     return ret;
> >>> +}
> >>> +
> >>> +static void audm2m_remove(struct platform_device *pdev)
> >>> +{
> >>> +     struct audm2m_dev *dev =3D platform_get_drvdata(pdev);
> >>> +
> >>> +     v4l2_info(&dev->v4l2_dev, "Removing " MEM2MEM_NAME);
> >>> +
> >>> +#ifdef CONFIG_MEDIA_CONTROLLER
> >>> +     media_device_unregister(&dev->mdev);
> >>> +     v4l2_m2m_unregister_media_controller(dev->m2m_dev);
> >>> +#endif
> >>> +     video_unregister_device(&dev->vfd);
> >>> +}
> >>> +
> >>> +static struct platform_driver audm2m_pdrv =3D {
> >>> +     .probe          =3D audm2m_probe,
> >>> +     .remove_new     =3D audm2m_remove,
> >>> +     .driver         =3D {
> >>> +             .name   =3D MEM2MEM_NAME,
> >>> +     },
> >>> +};
> >>> +
> >>> +static void __exit audm2m_exit(void)
> >>> +{
> >>> +     platform_driver_unregister(&audm2m_pdrv);
> >>> +     platform_device_unregister(&audm2m_pdev);
> >>> +}
> >>> +
> >>> +static int __init audm2m_init(void)
> >>> +{
> >>> +     int ret;
> >>> +
> >>> +     ret =3D platform_device_register(&audm2m_pdev);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     ret =3D platform_driver_register(&audm2m_pdrv);
> >>> +     if (ret)
> >>> +             platform_device_unregister(&audm2m_pdev);
> >>> +
> >>> +     return ret;
> >>> +}
> >>> +
> >>> +module_init(audm2m_init);
> >>> +module_exit(audm2m_exit);
> >>
> >> Regards,
> >>
> >>         Hans
>


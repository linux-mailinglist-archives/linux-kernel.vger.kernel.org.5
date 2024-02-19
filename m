Return-Path: <linux-kernel+bounces-71996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A95385AD9C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FAFC1C241EA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D3153E22;
	Mon, 19 Feb 2024 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="YGVPNaM3"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8655482FC
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 21:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708377641; cv=none; b=h6JVuN5boJmUej6xkpxTDAWuLCk2Sl4TbRjBR3nTgvo0nV5sh18fMM+c4TqHAriwfoOrlYRX8iOiMdpY96gNg7PiGfSi2Lf8YGiO8cmZYeYSHoLLXu7ORK8zLDEkqb9bon+sBtg753mX8e79rJymBPeoeRok6Kb8zJCVcVQjKG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708377641; c=relaxed/simple;
	bh=C6b6MMkqikgoBMbsQixv2dSIj33oV3G22FtAtgLA1C4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lDpGt7PWAXctvBkpNkpwo99QQsKVDKjgjuF6WZMDB3jdxwxHIMHme6M6oJgizK0i8DsJpeGEW6JRpFAHWCq16GzB3yfeswJ0tbZozefTzb5AFdn3WHXG+59rdJpebzUZqnhYyDC5K1ednRSd9yVgDdhQyP2EkemFzcJzjCi3wz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=YGVPNaM3; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-785d567fa26so221265885a.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1708377638; x=1708982438; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SRzaMRwlx+gVpnCiIBunTjmrfYVtHigrjdjOkXmnSa8=;
        b=YGVPNaM3f7/iWCv1efaUzYwFEKTIWoVHlrL8eB/aP1+4K15Dn6gXtBp1fwYxQW3MIe
         LIO5GMRSkaV/2AhjkQaN1AsnggYhEEy5mm4XGBNEV0B17R5Cvdwfn7XdsqZoyz8J867G
         9/s5Jku4rHQ278tk++OLglNaS9J/aA7Ju+Q9nn+ogNo8x+GKI2N+aIlQKmzGYla+IBjF
         hWIAtXarJwRJ2WZ/pfN2HPuZKjfQA6pBE/lzrG6zx0DZFDtF0/Om3k3BaJbiImpJjUSZ
         Ug6+kc6y0H/SpC3g8fomnQ4moErzSJuNlWxvcmUH+YYnTsa/C0yhLEBpIesyOCssnToi
         xEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708377638; x=1708982438;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRzaMRwlx+gVpnCiIBunTjmrfYVtHigrjdjOkXmnSa8=;
        b=q3AXyM7l4w8ueFo4BwsMr+8vVqVCVrSPuthN/K3vAnb6x9BL41C3GBIXgPOZZHButL
         atX5CBOyTiGjcyD0BV9nwCIoiGKJnVWHqqELNxGyur70AHq/k5gRcthayy4MG53Scxi4
         lxhbwGEYgxuTHsni7AG7QkAjP0KzuLMNLCHFkbvxLnH7BdlctandA2LoPmUAXnsQosq3
         T2uLzg9Nrzqz9XZeuWlVwwGp7s3U719V794GDhBF0Y2Vp7BAQ3j2qmNaBKdLBmKsDZ/C
         nNZqJRgWptARappYF+ExmcuQkAjzzBfwoitfWfHNojoDKf9pZnOdqDbkiCCDJg78BEJ0
         UCIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAD0ddVPUIbUQE0+bdY/n2l8gOt+TyvIls1gueB/gRt+lb9m70402xKJYyJC5i6vW+Q7v+/nUnFArRecMExTRRAw/RUE3veLVZwq34
X-Gm-Message-State: AOJu0YwvBlKvWXxGW8JVsGWgC1SOtfrdkl8242cXTLHlrjc09WzBkG2A
	XqFJy0hC0vDgfwDDnNvMoZYUI/k5EnO/2aCzguGEio1hzj78NWtff/Y8lkbi4gg=
X-Google-Smtp-Source: AGHT+IG5J6mHzQcG1mjFJTYs7Ac0ReN4iUn2yM7S+rq+pPFWV/Jt689UyOIx3GEsMrL+1uvQf8YeXA==
X-Received: by 2002:ae9:f312:0:b0:783:2a45:8329 with SMTP id p18-20020ae9f312000000b007832a458329mr13774211qkg.76.1708377638598;
        Mon, 19 Feb 2024 13:20:38 -0800 (PST)
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:3354::7a9])
        by smtp.gmail.com with ESMTPSA id c3-20020a05620a11a300b00785d7f634bcsm2803083qkk.8.2024.02.19.13.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 13:20:38 -0800 (PST)
Message-ID: <20489b01f1ac9ab3e434ea4c17b4e0ccd84afa36.camel@ndufresne.ca>
Subject: Re: [RESEND PATCH v0 3/5] wave5 : Support runtime suspend/resume.
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: "jackson.lee" <jackson.lee@chipsnmedia.com>, "mchehab@kernel.org"
	 <mchehab@kernel.org>, "linux-media@vger.kernel.org"
	 <linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, Nas Chung <nas.chung@chipsnmedia.com>
Cc: "lafley.kim" <lafley.kim@chipsnmedia.com>, "b-brnich@ti.com"
	 <b-brnich@ti.com>
Date: Mon, 19 Feb 2024 16:20:37 -0500
In-Reply-To: <SE1P216MB130326E2C4BA7E723A8955C9ED512@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
References: <20240131013046.15687-1-jackson.lee@chipsnmedia.com>
	 <20240131013046.15687-4-jackson.lee@chipsnmedia.com>
	 <efe24b949a60034bf618eb3b8a8ba82e8a5dc99c.camel@ndufresne.ca>
	 <SE1P216MB130326E2C4BA7E723A8955C9ED512@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jackson,

Le lundi 19 f=C3=A9vrier 2024 =C3=A0 04:04 +0000, jackson.lee a =C3=A9crit=
=C2=A0:
> Hi Nicolas
>=20
>=20
> > This seems very unnatural. We do the get() in "start_streaming()", but =
the
> > put() is only done when the device is closed, or when the driver is
> > removed. As this is not balanced, you seem to have to check the suspend=
ed
> > condition all over the place.
> >=20
> > I think we could aim for start_streaming()/stop_streaming() for your
> > get/put placement. At least they will be bound to an entirely balanced =
API.
> > But then, a media player in paused sate will prevent that device from
> > being suspended.
> >=20
> > If the HW is capable of preserving enough state, and From the short doc=
 I
> > have it gives me the impression it can preserve that, I'd suggest to
> > follow what hantro driver is doing. What is does is that it will do get=
()
> > in device_run(), and put() whenever the job completes. This driver has
> > been designed so when there is no job, it means the firmware is current=
ly
> > idle and looking for more work. So it seems like the perfect moment to =
do
> > suspend it.
> >=20
>=20
> Thanks your comment,
>=20
> Currently they are not balanced,=20
> If we puts "the put functon" into the stop_streaming, our hw is stalled u=
ntil doing wake-up command, so our v4l2 device become block.
> so I'd like to update the below instead of calling get at the start_strea=
ming function.
>=20
>=20
> @@ -1867,6 +1868,13 @@ static int wave5_vpu_open_dec(struct file *filp)
>=20
>         wave5_vdi_allocate_sram(inst->dev);
>=20
> +       err =3D pm_runtime_resume_and_get(inst->dev->dev);
> +       if (err) {
> +               dev_err(inst->dev->dev, "decoder runtime resume failed %d=
\n", err);
> +               ret =3D -EINVAL;
> +               goto cleanup_inst;
> +       }
> +
>         return 0;

I guess we need to discuss the power management strategy for this device. I=
f you
do resume_and_get() in open(), and then put in close(), that seems balanced=
 But
in term of power saving, it might not be very strong. If you have a media p=
layer
that is set to pause and then placed in the background, you still keep the =
IP
running. This is extremely common, since application cannot close their dev=
ice
without loosing the reference frames, and thus having to do extra work on r=
esume
to seek back to the previous sync point and drop unneeded frames.

It seems like the whole point of asking the firmware to save the state and
suspend is to be able to do so while there is meaningful sate in the firt p=
lace.
If we are to suspend only when there is no meaningful state, we could just =
free
all resources and power it off completely. (This is just for illustration, =
its
probably to slow to boot the firmware at runtime)


I understand you suffered lockup with a start_streaming() for resume_and_ge=
t(),
and stop_streaming() for put(), this may simply indicate that some hardware
access are needed between these two. Can you write down a power management =
plan
that would effectively save power in common use cases ? We can certainly he=
lp in
refactoring the code to make that happen.

Nicolas

>=20
> > Le mercredi 31 janvier 2024 =C3=A0 10:30 +0900, jackson.lee a =C3=A9cri=
t=C2=A0:
> > > There are two device run-time PM callbacks defined in 'struct
> > dev_pm_ops'
> > > int (*runtime_suspend)(struct device *dev); int
> > > (*runtime_resume)(struct device *dev);
> >=20
> > I wonder how useful is it to teach everyone what the generic 'struct
> > dev_pm_ops'
> > contains. Perhaps you simply wanted that this patch implement both susp=
end
> > and resume ops ?
> >=20
> > >=20
> > > Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
> > > Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> > > ---
> > >  .../platform/chips-media/wave5/wave5-hw.c     |  5 +-
> > >  .../chips-media/wave5/wave5-vpu-dec.c         |  9 +++
> > >  .../chips-media/wave5/wave5-vpu-enc.c         |  9 +++
> > >  .../platform/chips-media/wave5/wave5-vpu.c    | 68 +++++++++++++++++=
++
> > >  .../platform/chips-media/wave5/wave5-vpuapi.c |  7 ++
> > > .../media/platform/chips-media/wave5/wave5.h  |  3 +
> > >  6 files changed, 99 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c
> > > b/drivers/media/platform/chips-media/wave5/wave5-hw.c
> > > index 8ad7f3a28ae1..8aade5a38439 100644
> > > --- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
> > > +++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
> > > @@ -503,6 +503,7 @@ int wave5_vpu_build_up_dec_param(struct vpu_insta=
nce
> > *inst,
> > >  	/* This register must be reset explicitly */
> > >  	vpu_write_reg(inst->dev, W5_CMD_EXT_ADDR, 0);
> > >  	vpu_write_reg(inst->dev, W5_CMD_NUM_CQ_DEPTH_M1,
> > > (COMMAND_QUEUE_DEPTH - 1));
> > > +	vpu_write_reg(inst->dev, W5_CMD_ERR_CONCEAL, 0);
> >=20
> > In some way, the relation between suspend and this register write is no=
t
> > obvious. If its not related, please do this in its own patch. Otherwise
> > you want to explain why you needed this (possibly just in the commit
> > message).
> >=20
> > >=20
> > >  	ret =3D send_firmware_command(inst, W5_CREATE_INSTANCE, true, NULL,
> > NULL);
> > >  	if (ret) {
> > > @@ -1075,8 +1076,8 @@ int wave5_vpu_re_init(struct device *dev, u8 *f=
w,
> > size_t size)
> > >  	return setup_wave5_properties(dev);
> > >  }
> > >=20
> > > -static int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wak=
e,
> > const uint16_t *code,
> > > -				size_t size)
> > > +int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, cons=
t
> > uint16_t *code,
> > > +			 size_t size)
> > >  {
> > >  	u32 reg_val;
> > >  	struct vpu_buf *common_vb;
> > > diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> > > b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> > > index ef227af72348..328a7a8f26c5 100644
> > > --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> > > +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> > > @@ -5,6 +5,7 @@
> > >   * Copyright (C) 2021-2023 CHIPS&MEDIA INC
> > >   */
> > >=20
> > > +#include <linux/pm_runtime.h>
> > >  #include "wave5-helper.h"
> > >=20
> > >  #define VPU_DEC_DEV_NAME "C&M Wave5 VPU decoder"
> > > @@ -1387,9 +1388,17 @@ static int wave5_vpu_dec_start_streaming(struc=
t
> > > vb2_queue *q, unsigned int count
> > >=20
> > >  	if (q->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE && inst->state=
 =3D=3D
> > VPU_INST_STATE_NONE) {
> > >  		struct dec_open_param open_param;
> > > +		int err =3D 0;
> > >=20
> > >  		memset(&open_param, 0, sizeof(struct dec_open_param));
> > >=20
> > > +		err =3D pm_runtime_resume_and_get(inst->dev->dev);
> > > +		if (err) {
> > > +			dev_err(inst->dev->dev, "decoder runtime resume
> > failed %d\n", err);
> > > +			ret =3D -EINVAL;
> > > +			goto return_buffers;
> > > +		}
> > > +
> > >  		ret =3D wave5_vpu_dec_allocate_ring_buffer(inst);
> > >  		if (ret)
> > >  			goto return_buffers;
> > > diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> > > b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> > > index 761775216cd4..ff73d69de41c 100644
> > > --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> > > +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> > > @@ -5,6 +5,7 @@
> > >   * Copyright (C) 2021-2023 CHIPS&MEDIA INC
> > >   */
> > >=20
> > > +#include <linux/pm_runtime.h>
> > >  #include "wave5-helper.h"
> > >=20
> > >  #define VPU_ENC_DEV_NAME "C&M Wave5 VPU encoder"
> > > @@ -1387,9 +1388,17 @@ static int wave5_vpu_enc_start_streaming(struc=
t
> > > vb2_queue *q, unsigned int count
> > >=20
> > >  	if (inst->state =3D=3D VPU_INST_STATE_NONE && q->type =3D=3D
> > V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
> > >  		struct enc_open_param open_param;
> > > +		int err =3D 0;
> > >=20
> > >  		memset(&open_param, 0, sizeof(struct enc_open_param));
> > >=20
> > > +		err =3D pm_runtime_resume_and_get(inst->dev->dev);
> > > +		if (err) {
> > > +			dev_err(inst->dev->dev, "encoder runtime resume
> > failed %d\n", err);
> > > +			ret =3D -EINVAL;
> > > +			goto return_buffers;
> > > +		}
> > > +
> > >  		wave5_set_enc_openparam(&open_param, inst);
> > >=20
> > >  		ret =3D wave5_vpu_enc_open(inst, &open_param); diff --git
> > > a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > > b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > > index 0d90b5820bef..f81409740a56 100644
> > > --- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > > +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > > @@ -10,6 +10,7 @@
> > >  #include <linux/clk.h>
> > >  #include <linux/firmware.h>
> > >  #include <linux/interrupt.h>
> > > +#include <linux/pm_runtime.h>
> > >  #include "wave5-vpu.h"
> > >  #include "wave5-regdefine.h"
> > >  #include "wave5-vpuconfig.h"
> > > @@ -117,6 +118,65 @@ static int wave5_vpu_load_firmware(struct device
> > *dev, const char *fw_name,
> > >  	return 0;
> > >  }
> > >=20
> > > +static __maybe_unused int wave5_pm_suspend(struct device *dev) {
> > > +	struct vpu_device *vpu =3D dev_get_drvdata(dev);
> > > +
> > > +	if (pm_runtime_suspended(dev))
> > > +		return 0;
> > > +
> > > +	wave5_vpu_sleep_wake(dev, true, NULL, 0);
> > > +	clk_bulk_disable_unprepare(vpu->num_clks, vpu->clks);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static __maybe_unused int wave5_pm_resume(struct device *dev) {
> > > +	struct vpu_device *vpu =3D dev_get_drvdata(dev);
> > > +	int ret =3D 0;
> > > +
> > > +	wave5_vpu_sleep_wake(dev, false, NULL, 0);
> > > +	ret =3D clk_bulk_prepare_enable(vpu->num_clks, vpu->clks);
> > > +	if (ret) {
> > > +		dev_err(dev, "Enabling clocks, fail: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static __maybe_unused int wave5_suspend(struct device *dev) {
> > > +	struct vpu_device *vpu =3D dev_get_drvdata(dev);
> > > +	struct vpu_instance *inst;
> > > +
> > > +	list_for_each_entry(inst, &vpu->instances, list)
> > > +		v4l2_m2m_suspend(inst->v4l2_m2m_dev);
> > > +
> > > +	return pm_runtime_force_suspend(dev); }
> > > +
> > > +static __maybe_unused int wave5_resume(struct device *dev) {
> > > +	struct vpu_device *vpu =3D dev_get_drvdata(dev);
> > > +	struct vpu_instance *inst;
> > > +	int ret =3D 0;
> > > +
> > > +	ret =3D pm_runtime_force_resume(dev);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	list_for_each_entry(inst, &vpu->instances, list)
> > > +		v4l2_m2m_resume(inst->v4l2_m2m_dev);
> > > +
> > > +	return ret;
> > > +}
> >=20
> > The functions wave5_suspend() and wave5_resume() are not just
> > "maybe_unsued" but actually never used. What was the intention ?
> > Considering the usage of __maybe_unused has been such a bad friend for
> > this one, could you instead bracket the functions with an explicit ?
> >=20
> > #ifdef CONFIG_PM
> > #endif
> >=20
> > This way the compiler will have a word if you implement something that =
you
> > forgot to actually use.
> >=20
> > > +
> > > +static const struct dev_pm_ops wave5_pm_ops =3D {
> > > +	SET_RUNTIME_PM_OPS(wave5_pm_suspend, wave5_pm_resume, NULL) };
> > > +
> > >  static int wave5_vpu_probe(struct platform_device *pdev)  {
> > >  	int ret;
> > > @@ -232,6 +292,10 @@ static int wave5_vpu_probe(struct platform_devic=
e
> > *pdev)
> > >  		 (match_data->flags & WAVE5_IS_DEC) ? "'DECODE'" : "");
> > >  	dev_info(&pdev->dev, "Product Code:      0x%x\n", dev->product_code=
);
> > >  	dev_info(&pdev->dev, "Firmware Revision: %u\n", fw_revision);
> > > +
> > > +	pm_runtime_enable(&pdev->dev);
> > > +	wave5_vpu_sleep_wake(&pdev->dev, true, NULL, 0);
> > > +
> > >  	return 0;
> > >=20
> > >  err_enc_unreg:
> > > @@ -254,6 +318,9 @@ static int wave5_vpu_remove(struct platform_devic=
e
> > > *pdev)  {
> > >  	struct vpu_device *dev =3D dev_get_drvdata(&pdev->dev);
> > >=20
> > > +	pm_runtime_put_sync(&pdev->dev);
> > > +	pm_runtime_disable(&pdev->dev);
> > > +
> > >  	mutex_destroy(&dev->dev_lock);
> > >  	mutex_destroy(&dev->hw_lock);
> > >  	clk_bulk_disable_unprepare(dev->num_clks, dev->clks); @@ -281,6
> > > +348,7 @@ static struct platform_driver wave5_vpu_driver =3D {
> > >  	.driver =3D {
> > >  		.name =3D VPU_PLATFORM_DEVICE_NAME,
> > >  		.of_match_table =3D of_match_ptr(wave5_dt_ids),
> > > +		.pm =3D &wave5_pm_ops,
> > >  		},
> > >  	.probe =3D wave5_vpu_probe,
> > >  	.remove =3D wave5_vpu_remove,
> > > diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> > > b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> > > index 1a3efb638dde..f1f8e4fc8474 100644
> > > --- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> > > +++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> > > @@ -6,6 +6,7 @@
> > >   */
> > >=20
> > >  #include <linux/bug.h>
> > > +#include <linux/pm_runtime.h>
> > >  #include "wave5-vpuapi.h"
> > >  #include "wave5-regdefine.h"
> > >  #include "wave5.h"
> > > @@ -232,6 +233,9 @@ int wave5_vpu_dec_close(struct vpu_instance *inst=
,
> > > u32 *fail_res)
> > >=20
> > >  	wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_task);
> > >=20
> > > +	if (!pm_runtime_suspended(inst->dev->dev))
> > > +		pm_runtime_put_sync(inst->dev->dev);
> > > +
> > >  unlock_and_return:
> > >  	mutex_unlock(&vpu_dev->hw_lock);
> > >=20
> > > @@ -734,6 +738,9 @@ int wave5_vpu_enc_close(struct vpu_instance *inst=
,
> > > u32 *fail_res)
> > >=20
> > >  	wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_task);
> > >=20
> > > +	if (!pm_runtime_suspended(inst->dev->dev))
> > > +		pm_runtime_put_sync(inst->dev->dev);
> >=20
> > This seems very unnatural. We do the get() in "start_streaming()", but =
the
> > put() is only done when the device is closed, or when the driver is
> > removed. As this is not balanced, you seem to have to check the suspend=
ed
> > condition all over the place.
> >=20
> > I think we could aim for start_streaming()/stop_streaming() for your
> > get/put placement. At least they will be bound to an entirely balanced =
API.
> > But then, a media player in paused sate will prevent that device from
> > being suspended.
> >=20
> > If the HW is capable of preserving enough state, and From the short doc=
 I
> > have it gives me the impression it can preserve that, I'd suggest to
> > follow what hantro driver is doing. What is does is that it will do get=
()
> > in device_run(), and put() whenever the job completes. This driver has
> > been designed so when there is no job, it means the firmware is current=
ly
> > idle and looking for more work. So it seems like the perfect moment to =
do
> > suspend it.
> >=20
> > Nicolas
> >=20
> > > +
> > >  	mutex_unlock(&vpu_dev->hw_lock);
> > >=20
> > >  	return 0;
> > > diff --git a/drivers/media/platform/chips-media/wave5/wave5.h
> > > b/drivers/media/platform/chips-media/wave5/wave5.h
> > > index 063028eccd3b..6125eff938a8 100644
> > > --- a/drivers/media/platform/chips-media/wave5/wave5.h
> > > +++ b/drivers/media/platform/chips-media/wave5/wave5.h
> > > @@ -56,6 +56,9 @@ int wave5_vpu_get_version(struct vpu_device
> > > *vpu_dev, u32 *revision);
> > >=20
> > >  int wave5_vpu_init(struct device *dev, u8 *fw, size_t size);
> > >=20
> > > +int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, cons=
t
> > uint16_t *code,
> > > +			 size_t size);
> > > +
> > >  int wave5_vpu_reset(struct device *dev, enum sw_reset_mode
> > > reset_mode);
> > >=20
> > >  int wave5_vpu_build_up_dec_param(struct vpu_instance *inst, struct
> > > dec_open_param *param);
>=20



Return-Path: <linux-kernel+bounces-90715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DA28703CC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17AD11C213EC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BC13FE2A;
	Mon,  4 Mar 2024 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="S12yT6sd"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EDD3FB14
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709561528; cv=none; b=GNgZYty1E9TdIYzHgOv6eqg6o2P0pLNQcuO7j9otovYbaA5wVqfz7PslQG+6dBLyKB0lKHrZMadFANUcZZafOzmvA1xXk73YDHlUCSyvLZ4Wd8tPBXfVJQXnDECZbelLPugp1aXwNLeE0bEXfwELIB8GnJC6GtaVg5rlws1TufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709561528; c=relaxed/simple;
	bh=UbkA6Oyo7eSxFPrqAADfKAjohp1lh9fw3fb4ueMVVio=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EobreVdLch3yurROyM86fVTN0wlaljOJ8Xo1u8p5vWpBctflLLYuwd+DCDgUZH722gCcl5cW0NJuSL82595f+gAy1SUE6QEGgJ5NTpZl7lF53z1rqdLlewaBCUd/XOgl1a8aSBM8V6UOFkUgdJOx0RByw51kZcpEmiIgqX//7hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=S12yT6sd; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68f51c5f9baso27292136d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 06:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1709561524; x=1710166324; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wTNSCdSo3laiqNBeXKgo/conb+Ojwfba9EIWj94qTFQ=;
        b=S12yT6sd5i9cIreBIfZwfLnH142wW4U01gINo/osLanenhJam36Erk1z7qO4ecJ7z7
         WGuIlPv9nbOfxsRjqiB73zFzuQ6osmffY+iUQuw316GRsJbx94KrKBA9v3WRhNBa69Lb
         tHMVxJUPoqeT8ZV3eDdq1FYXggoT4GqBEOmOXw1bFkPD9oHze+hXOC2daJMEKUHCoQp/
         DymwoS0RxqsYoenia3FhtjLnPmOAJFHAXnveJJ8WRQhPMQM8RFI/blrsHGEj3esgjF4H
         KbRJeJHr4MovDZDLvYNluODIxyJWDvf2gHRVbwx3IQCGRPI/Cw9IWInSCrDL4zZ9ZWLk
         BBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709561524; x=1710166324;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wTNSCdSo3laiqNBeXKgo/conb+Ojwfba9EIWj94qTFQ=;
        b=ZIIti7hISuCoocG1qKfRa3SAwdgOjR2zumgFXn4mUKjOeElw7Jt8YeDW11r0HSi4ZN
         AZFGoIbbKbi3lAEH3bbaKQLtO7ATB1L9KWKP10K7UwX7LjmxJ2erwDALB48JKco0azbT
         btpA3NSg0dKp706+0+EkswvQpCBjuz4vXCqyJKWOA+J0pDgofhkbBeQlaOHTiK42Lr1T
         7XIadtV0MjVPg3mK0f1ufAnPumXK9/n9pLrMzXCR1kxdzQ5MuCXwBiEkXhvZGvE7bWWM
         781j+a8AqoKop+jbbVLyrp/n+wHof/uY2NfLkBpUwByoTULRbz7m6VmaX6b1qveAmLMA
         bBeA==
X-Forwarded-Encrypted: i=1; AJvYcCXQuZaVhLEEMvUlTGnAujArmgVLH0Q8OFh1TllOw03JTxAk7bT0/rSlVoekhr+aSk1iRimIjBZIpm2HIGmJKuNgW5xumVjPTC0LMqvu
X-Gm-Message-State: AOJu0YyXyO2zk6HWL1hzZy0eFaXGmp8ih13nqAc54EJwAZT/V4omC60x
	ti41mOPzDJK0DmhoiSAuSXXtN0xW8NcAx+ua9Txz3h8hc6uwadDfS/SNGFOnifM=
X-Google-Smtp-Source: AGHT+IEOy17ycE7rVaSCt6Wm3jVlxce/LGWb2oBrk1misRmcsQ1FRcjhQRCJoB1WeIUZlLtEmfDwog==
X-Received: by 2002:ad4:4a6f:0:b0:68f:46df:e780 with SMTP id cn15-20020ad44a6f000000b0068f46dfe780mr6365586qvb.57.1709561523444;
        Mon, 04 Mar 2024 06:12:03 -0800 (PST)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:eba4::7a9])
        by smtp.gmail.com with ESMTPSA id c11-20020a056214070b00b0068f8927ac6fsm5060664qvz.66.2024.03.04.06.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 06:12:03 -0800 (PST)
Message-ID: <743fb49259975bc27a11b4a3ef9430311ca0eb9e.camel@ndufresne.ca>
Subject: Re: [RESEND PATCH v0 3/5] wave5 : Support runtime suspend/resume.
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: "jackson.lee" <jackson.lee@chipsnmedia.com>, "mchehab@kernel.org"
	 <mchehab@kernel.org>, "linux-media@vger.kernel.org"
	 <linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, Nas Chung <nas.chung@chipsnmedia.com>
Cc: "lafley.kim" <lafley.kim@chipsnmedia.com>, "b-brnich@ti.com"
	 <b-brnich@ti.com>
Date: Mon, 04 Mar 2024 09:12:02 -0500
In-Reply-To: <SE1P216MB130316FB016E0FC58A7D4DC7ED5A2@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
References: <20240131013046.15687-1-jackson.lee@chipsnmedia.com>
	 <20240131013046.15687-4-jackson.lee@chipsnmedia.com>
	 <efe24b949a60034bf618eb3b8a8ba82e8a5dc99c.camel@ndufresne.ca>
	 <SE1P216MB130326E2C4BA7E723A8955C9ED512@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
	 <20489b01f1ac9ab3e434ea4c17b4e0ccd84afa36.camel@ndufresne.ca>
	 <SE1P216MB1303CEEF6DFAB5FA7C69D645ED502@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
	 <d5546b48ea829316a8dbd2ecc27bbf05e70e8188.camel@ndufresne.ca>
	 <SE1P216MB1303932A0D3FC399179115D9ED572@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
	 <be5ce95b023bcff24f53fdae55763bf4a3f6b1d7.camel@ndufresne.ca>
	 <SE1P216MB13038F3890F8B4597465B394ED562@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
	 <SE1P216MB13035B8E53454881C87059B9ED562@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
	 <d4d43f9e19a9d0ecf54167fd3fc71f1fc03aec2d.camel@ndufresne.ca>
	 <SE1P216MB130316FB016E0FC58A7D4DC7ED5A2@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jackson,

sorry for the the delay, my reply below.

Le lundi 26 f=C3=A9vrier 2024 =C3=A0 01:33 +0000, jackson.lee a =C3=A9crit=
=C2=A0:
> Hello Nicolas
>=20
[...]
>=20
> I have added the autosuspend feature, can you please review the below cod=
e ?
> If there is no problem at your side, I will make a patch for upstream.
>=20
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/driver=
s/media/platform/chips-media/wave5/wave5-hw.c
> index 0b6386f31..2ba9e0f0e 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
> @@ -1102,8 +1102,8 @@ int wave5_vpu_re_init(struct device *dev, u8 *fw, s=
ize_t size)
>  	return setup_wave5_properties(dev);
>  }
> =20
> -static int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, c=
onst uint16_t *code,
> -				size_t size)
> +int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const ui=
nt16_t *code,
> +			 size_t size)
>  {
>  	u32 reg_val;
>  	struct vpu_buf *common_vb;
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> index 8b1417ece..4aea66483 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2021-2023 CHIPS&MEDIA INC
>   */
> =20
> +#include <linux/pm_runtime.h>
>  #include "wave5-helper.h"
> =20
>  #define VPU_DEC_DEV_NAME "C&M Wave5 VPU decoder"
> @@ -518,6 +519,8 @@ static void wave5_vpu_dec_finish_decode(struct vpu_in=
stance *inst)
>  	if (q_status.report_queue_count =3D=3D 0 &&
>  	    (q_status.instance_queue_count =3D=3D 0 || dec_info.sequence_change=
d)) {
>  		dev_dbg(inst->dev->dev, "%s: finishing job.\n", __func__);
> +		pm_runtime_mark_last_busy(inst->dev->dev);
> +		pm_runtime_put_autosuspend(inst->dev->dev);
>  		v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
>  	}
>  }
> @@ -1382,6 +1385,7 @@ static int wave5_vpu_dec_start_streaming(struct vb2=
_queue *q, unsigned int count
>  	int ret =3D 0;
> =20
>  	dev_dbg(inst->dev->dev, "%s: type: %u\n", __func__, q->type);
> +	pm_runtime_resume_and_get(inst->dev->dev);
> =20
>  	v4l2_m2m_update_start_streaming_state(m2m_ctx, q);
> =20
> @@ -1389,7 +1393,6 @@ static int wave5_vpu_dec_start_streaming(struct vb2=
_queue *q, unsigned int count
>  		struct dec_open_param open_param;
> =20
>  		memset(&open_param, 0, sizeof(struct dec_open_param));
> -

I'd refrain from mixing style changes with the function changes. Just leave=
 the
empty line, is it harmless. There is other cases in your RFC.

>  		ret =3D wave5_vpu_dec_allocate_ring_buffer(inst);
>  		if (ret)
>  			goto return_buffers;
> @@ -1425,13 +1428,14 @@ static int wave5_vpu_dec_start_streaming(struct v=
b2_queue *q, unsigned int count
>  			}
>  		}
>  	}
> -

There is a case were userspace may start streaming but never populate the
queues. You should call pm_runtime_put_autosuspend() here for this reason. =
In
most cases it won't suspend as there device_run() get called very shortly a=
fter,
before the timeout expires.

>  	return ret;
> =20
>  free_bitstream_vbuf:
>  	wave5_vdi_free_dma_memory(inst->dev, &inst->bitstream_vbuf);
>  return_buffers:
>  	wave5_return_bufs(q, VB2_BUF_STATE_QUEUED);
> +	pm_runtime_mark_last_busy(inst->dev->dev);

For fast operations or synchronous errors, I believe its fine to skip the
"mark_last_busy()" calls. This is resetting the timeout start time, but if =
the
elapse time is really short, I'm pretty sure there is very little values in
pushing it forward. Removing that call from error case, stream_start/stop s=
hould
make the patch a little lighter.

I think overall your RFC is in the right direction, and this is good materi=
al
for a V2.

regards,
Nicolas

> +	pm_runtime_put_autosuspend(inst->dev->dev);
>  	return ret;
>  }
> =20
> @@ -1517,6 +1521,7 @@ static void wave5_vpu_dec_stop_streaming(struct vb2=
_queue *q)
>  	bool check_cmd =3D TRUE;
> =20
>  	dev_dbg(inst->dev->dev, "%s: type: %u\n", __func__, q->type);
> +	pm_runtime_resume_and_get(inst->dev->dev);
> =20
>  	while (check_cmd) {
>  		struct queue_status_info q_status;
> @@ -1540,6 +1545,9 @@ static void wave5_vpu_dec_stop_streaming(struct vb2=
_queue *q)
>  		streamoff_output(q);
>  	else
>  		streamoff_capture(q);
> +
> +	pm_runtime_mark_last_busy(inst->dev->dev);
> +	pm_runtime_put_autosuspend(inst->dev->dev);
>  }
> =20
>  static const struct vb2_ops wave5_vpu_dec_vb2_ops =3D {
> @@ -1626,7 +1634,7 @@ static void wave5_vpu_dec_device_run(void *priv)
>  	int ret =3D 0;
> =20
>  	dev_dbg(inst->dev->dev, "%s: Fill the ring buffer with new bitstream da=
ta", __func__);
> -
> +	pm_runtime_resume_and_get(inst->dev->dev);
>  	ret =3D fill_ringbuffer(inst);
>  	if (ret) {
>  		dev_warn(inst->dev->dev, "Filling ring buffer failed\n");
> @@ -1709,6 +1717,8 @@ static void wave5_vpu_dec_device_run(void *priv)
> =20
>  finish_job_and_return:
>  	dev_dbg(inst->dev->dev, "%s: leave and finish job", __func__);
> +	pm_runtime_mark_last_busy(inst->dev->dev);
> +	pm_runtime_put_autosuspend(inst->dev->dev);
>  	v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
>  }
> =20
> @@ -1866,7 +1876,6 @@ static int wave5_vpu_open_dec(struct file *filp)
>  	}
> =20
>  	wave5_vdi_allocate_sram(inst->dev);
> -
>  	return 0;
> =20
>  cleanup_inst:
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> index f04baa93a..14fd26204 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2021-2023 CHIPS&MEDIA INC
>   */
> =20
> +#include <linux/pm_runtime.h>
>  #include "wave5-helper.h"
> =20
>  #define VPU_ENC_DEV_NAME "C&M Wave5 VPU encoder"
> @@ -1310,6 +1311,7 @@ static int wave5_vpu_enc_start_streaming(struct vb2=
_queue *q, unsigned int count
>  	struct v4l2_m2m_ctx *m2m_ctx =3D inst->v4l2_fh.m2m_ctx;
>  	int ret =3D 0;
> =20
> +	pm_runtime_resume_and_get(inst->dev->dev);
>  	v4l2_m2m_update_start_streaming_state(m2m_ctx, q);
> =20
>  	if (inst->state =3D=3D VPU_INST_STATE_NONE && q->type =3D=3D V4L2_BUF_T=
YPE_VIDEO_OUTPUT_MPLANE) {
> @@ -1364,9 +1366,13 @@ static int wave5_vpu_enc_start_streaming(struct vb=
2_queue *q, unsigned int count
>  	if (ret)
>  		goto return_buffers;
> =20
> +	pm_runtime_mark_last_busy(inst->dev->dev);
> +	pm_runtime_put_autosuspend(inst->dev->dev);
>  	return 0;
>  return_buffers:
>  	wave5_return_bufs(q, VB2_BUF_STATE_QUEUED);
> +	pm_runtime_mark_last_busy(inst->dev->dev);
> +	pm_runtime_put_autosuspend(inst->dev->dev);
>  	return ret;
>  }
> =20
> @@ -1408,6 +1414,7 @@ static void wave5_vpu_enc_stop_streaming(struct vb2=
_queue *q)
>  	 */
> =20
>  	dev_dbg(inst->dev->dev, "%s: type: %u\n", __func__, q->type);
> +	pm_runtime_resume_and_get(inst->dev->dev);
> =20
>  	if (wave5_vpu_both_queues_are_streaming(inst))
>  		switch_state(inst, VPU_INST_STATE_STOP);
> @@ -1432,6 +1439,9 @@ static void wave5_vpu_enc_stop_streaming(struct vb2=
_queue *q)
>  		streamoff_output(inst, q);
>  	else
>  		streamoff_capture(inst, q);
> +
> +	pm_runtime_mark_last_busy(inst->dev->dev);
> +	pm_runtime_put_autosuspend(inst->dev->dev);
>  }
> =20
>  static const struct vb2_ops wave5_vpu_enc_vb2_ops =3D {
> @@ -1478,6 +1488,7 @@ static void wave5_vpu_enc_device_run(void *priv)
>  	u32 fail_res =3D 0;
>  	int ret =3D 0;
> =20
> +	pm_runtime_resume_and_get(inst->dev->dev);
>  	switch (inst->state) {
>  	case VPU_INST_STATE_PIC_RUN:
>  		ret =3D start_encode(inst, &fail_res);
> @@ -1491,6 +1502,8 @@ static void wave5_vpu_enc_device_run(void *priv)
>  			break;
>  		}
>  		dev_dbg(inst->dev->dev, "%s: leave with active job", __func__);
> +		pm_runtime_mark_last_busy(inst->dev->dev);
> +		pm_runtime_put_autosuspend(inst->dev->dev);
>  		return;
>  	default:
>  		WARN(1, "Execution of a job in state %s is invalid.\n",
> @@ -1498,6 +1511,8 @@ static void wave5_vpu_enc_device_run(void *priv)
>  		break;
>  	}
>  	dev_dbg(inst->dev->dev, "%s: leave and finish job", __func__);
> +	pm_runtime_mark_last_busy(inst->dev->dev);
> +	pm_runtime_put_autosuspend(inst->dev->dev);
>  	v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
>  }
> =20
> @@ -1735,7 +1750,6 @@ static int wave5_vpu_open_enc(struct file *filp)
>  	}
> =20
>  	wave5_vdi_allocate_sram(inst->dev);
> -
>  	return 0;
> =20
>  cleanup_inst:
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drive=
rs/media/platform/chips-media/wave5/wave5-vpu.c
> index 2323dba75..6b4794e0e 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> @@ -10,6 +10,7 @@
>  #include <linux/clk.h>
>  #include <linux/firmware.h>
>  #include <linux/interrupt.h>
> +#include <linux/pm_runtime.h>
>  #include "wave5-vpu.h"
>  #include "wave5-regdefine.h"
>  #include "wave5-vpuconfig.h"
> @@ -117,6 +118,38 @@ static int wave5_vpu_load_firmware(struct device *de=
v, const char *fw_name,
>  	return 0;
>  }
> =20
> +static int wave5_pm_suspend(struct device *dev)
> +{
> +	struct vpu_device *vpu =3D dev_get_drvdata(dev);
> +
> +	if (pm_runtime_suspended(dev))
> +		return 0;
> +
> +	wave5_vpu_sleep_wake(dev, true, NULL, 0);
> +	clk_bulk_disable_unprepare(vpu->num_clks, vpu->clks);
> +
> +	return 0;
> +}
> +
> +static int wave5_pm_resume(struct device *dev)
> +{
> +	struct vpu_device *vpu =3D dev_get_drvdata(dev);
> +	int ret =3D 0;
> +
> +	wave5_vpu_sleep_wake(dev, false, NULL, 0);
> +	ret =3D clk_bulk_prepare_enable(vpu->num_clks, vpu->clks);
> +	if (ret) {
> +		dev_err(dev, "Enabling clocks, fail: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct dev_pm_ops wave5_pm_ops =3D {
> +	SET_RUNTIME_PM_OPS(wave5_pm_suspend, wave5_pm_resume, NULL)
> +};
> +
>  static int wave5_vpu_probe(struct platform_device *pdev)
>  {
>  	int ret;
> @@ -233,6 +266,12 @@ static int wave5_vpu_probe(struct platform_device *p=
dev)
>  		 (match_data->flags & WAVE5_IS_DEC) ? "'DECODE'" : "");
>  	dev_info(&pdev->dev, "Product Code:      0x%x\n", dev->product_code);
>  	dev_info(&pdev->dev, "Firmware Revision: %u\n", fw_revision);
> +
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 5000);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	wave5_vpu_sleep_wake(&pdev->dev, true, NULL, 0);
> +
>  	return 0;
> =20
>  err_enc_unreg:
> @@ -255,6 +294,9 @@ static int wave5_vpu_remove(struct platform_device *p=
dev)
>  {
>  	struct vpu_device *dev =3D dev_get_drvdata(&pdev->dev);
> =20
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +
>  	mutex_destroy(&dev->dev_lock);
>  	mutex_destroy(&dev->hw_lock);
>  	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
> @@ -282,6 +324,7 @@ static struct platform_driver wave5_vpu_driver =3D {
>  	.driver =3D {
>  		.name =3D VPU_PLATFORM_DEVICE_NAME,
>  		.of_match_table =3D of_match_ptr(wave5_dt_ids),
> +		.pm =3D &wave5_pm_ops,
>  		},
>  	.probe =3D wave5_vpu_probe,
>  	.remove =3D wave5_vpu_remove,
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c b/dr=
ivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> index 86b399372..b2357d1b5 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> @@ -6,6 +6,8 @@
>   */
> =20
>  #include <linux/bug.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/delay.h>
>  #include "wave5-vpuapi.h"
>  #include "wave5-regdefine.h"
>  #include "wave5.h"
> @@ -200,6 +202,8 @@ int wave5_vpu_dec_close(struct vpu_instance *inst, u3=
2 *fail_res)
>  	if (!inst->codec_info)
>  		return -EINVAL;
> =20
> +	pm_runtime_resume_and_get(inst->dev->dev);
> +
>  	ret =3D mutex_lock_interruptible(&vpu_dev->hw_lock);
>  	if (ret)
>  		return ret;
> @@ -234,7 +238,7 @@ int wave5_vpu_dec_close(struct vpu_instance *inst, u3=
2 *fail_res)
> =20
>  unlock_and_return:
>  	mutex_unlock(&vpu_dev->hw_lock);
> -
> +	pm_runtime_put_autosuspend(inst->dev->dev);
>  	return ret;
>  }
> =20
> @@ -702,6 +706,8 @@ int wave5_vpu_enc_close(struct vpu_instance *inst, u3=
2 *fail_res)
>  	if (!inst->codec_info)
>  		return -EINVAL;
> =20
> +	pm_runtime_resume_and_get(inst->dev->dev);
> +
>  	ret =3D mutex_lock_interruptible(&vpu_dev->hw_lock);
>  	if (ret)
>  		return ret;
> @@ -733,9 +739,10 @@ int wave5_vpu_enc_close(struct vpu_instance *inst, u=
32 *fail_res)
>  	}
> =20
>  	wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_task);
> -
>  	mutex_unlock(&vpu_dev->hw_lock);
> =20
> +	pm_runtime_put_autosuspend(inst->dev->dev);
> +
>  	return 0;
>  }
> =20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> > >=20
> > >=20
> > > Thanks.
> > > Jackson
> > >=20
> > > >=20
> > > > The delay means a timer, so there is no input for 5 secs, then
> > > > timeout callback is called, And suspend is set, if new activity
> > > > comes, the device is resumed again ?
> > > > My understanding is correct ?
> > > >=20
> > >=20
> > >=20
> > > >=20
> > > >=20
> > > > > Nicolas
> > > > >=20
> > > > > >=20
> > > > > > Thanks.
> > > > > >=20
> > > > > >=20
> > > > > > > There is of course other places where you'll have to make sur=
e
> > > > > > > the hardware is resumed, like on close, as you want to remove
> > > > > > > the
> > > > instance.
> > > > > > > There is also small queries here and there that need to be
> > > > > > > surrounded with resume/put, but with the redesign, most of th=
e
> > > > > > > HW access now take place inside device_run() only.
> > > > > > >=20
> > > > > > > Open/Close is not invalid, but it has a lot of issues, as any
> > > > > > > random application can endup disabling the kernel ability to
> > > > > > > save
> > > > power.
> > > > > > > Personally, I think we should at least give it a try, and
> > > > > > > document valid reason not to do so if we find hardware issues=
.
> > > > > > > Otherwise, this sounds like all we care is ticking the box
> > > > > > > "this driver has runtime PM" without actually caring about
> > effective power saving.
> > > > > > >=20
> > > > > > > Nicolas
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > Thanks.
> > > > > > > >=20
> > > > > > > > > Le lundi 19 f=C3=A9vrier 2024 =C3=A0 04:04 +0000, jackson=
lee a =C3=A9crit=C2=A0:
> > > > > > > > > > Hi Nicolas
> > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > > This seems very unnatural. We do the get() in
> > > > > > > > > > > "start_streaming()", but the
> > > > > > > > > > > put() is only done when the device is closed, or when
> > > > > > > > > > > the driver is removed. As this is not balanced, you
> > > > > > > > > > > seem to have to check the suspended condition all ove=
r
> > the place.
> > > > > > > > > > >=20
> > > > > > > > > > > I think we could aim for
> > > > > > > > > > > start_streaming()/stop_streaming()
> > > > > > > > > > > for your get/put placement. At least they will be
> > > > > > > > > > > bound to an entirely balanced
> > > > > > > > > API.
> > > > > > > > > > > But then, a media player in paused sate will prevent
> > > > > > > > > > > that device from being suspended.
> > > > > > > > > > >=20
> > > > > > > > > > > If the HW is capable of preserving enough state, and
> > > > > > > > > > > From the short doc I have it gives me the impression
> > > > > > > > > > > it can preserve that, I'd suggest to follow what
> > > > > > > > > > > hantro driver is doing. What is does is that it will
> > > > > > > > > > > do get() in device_run(), and put() whenever the job
> > > > > > > > > > > completes. This driver has been designed so when ther=
e
> > > > > > > > > > > is no job, it means the firmware is currently idle an=
d
> > looking for more work.
> > > > > > > > > > > So it seems like the perfect moment to
> > > > > > > do suspend it.
> > > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > Thanks your comment,
> > > > > > > > > >=20
> > > > > > > > > > Currently they are not balanced, If we puts "the put
> > functon"
> > > > > > > > > > into the stop_streaming, our hw is stalled
> > > > > > > > > until doing wake-up command, so our v4l2 device become bl=
ock.
> > > > > > > > > > so I'd like to update the below instead of calling get
> > > > > > > > > > at the
> > > > > > > > > start_streaming function.
> > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > @@ -1867,6 +1868,13 @@ static int
> > > > > > > > > > wave5_vpu_open_dec(struct file
> > > > > > > > > > *filp)
> > > > > > > > > >=20
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wave5_v=
di_allocate_sram(inst->dev);
> > > > > > > > > >=20
> > > > > > > > > > +       err =3D pm_runtime_resume_and_get(inst->dev->de=
v);
> > > > > > > > > > +       if (err) {
> > > > > > > > > > +               dev_err(inst->dev->dev, "decoder runtim=
e
> > > > > > > > > > + resume
> > > > > > > > > failed %d\n", err);
> > > > > > > > > > +               ret =3D -EINVAL;
> > > > > > > > > > +               goto cleanup_inst;
> > > > > > > > > > +       }
> > > > > > > > > > +
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return =
0;
> > > > > > > > >=20
> > > > > > > > > I guess we need to discuss the power management strategy
> > > > > > > > > for this
> > > > > > > device.
> > > > > > > > > If you do resume_and_get() in open(), and then put in
> > > > > > > > > close(), that seems balanced. But in term of power saving=
,
> > > > > > > > > it might not be very strong. If you have a media player
> > > > > > > > > that is set to pause and then placed in the background,
> > > > > > > > > you still keep the IP running. This is extremely common,
> > > > > > > > > since application cannot close their device without
> > > > > > > > > loosing the reference frames, and thus having to do extra
> > > > > > > > > work on resume to seek back to the previous sync point an=
d
> > > > > > > > > drop
> > > > > > > unneeded frames.
> > > > > > > > >=20
> > > > > > > > > It seems like the whole point of asking the firmware to
> > > > > > > > > save the state and suspend is to be able to do so while
> > > > > > > > > there is meaningful sate in the firt place.
> > > > > > > > > If we are to suspend only when there is no meaningful
> > > > > > > > > state, we could just free all resources and power it off
> > completely.
> > > > > > > > > (This is just for illustration, its probably to slow to
> > > > > > > > > boot the firmware at
> > > > > > > > > runtime)
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > I understand you suffered lockup with a start_streaming()
> > > > > > > > > for resume_and_get(), and stop_streaming() for put(), thi=
s
> > > > > > > > > may simply indicate that some hardware access are needed
> > > > > > > > > between these two. Can you write down a power management
> > > > > > > > > plan that would effectively save power in common use case=
s
> > > > > > > > > ? We can certainly help in refactoring the
> > > > > > > code to make that happen.
> > > > > > > > >=20
> > > > > > > > > Nicolas
> > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > > Le mercredi 31 janvier 2024 =C3=A0 10:30 +0900, jacks=
on.lee
> > > > > > > > > > > a
> > > > > =C3=A9crit=C2=A0:
> > > > > > > > > > > > There are two device run-time PM callbacks defined
> > > > > > > > > > > > in 'struct
> > > > > > > > > > > dev_pm_ops'
> > > > > > > > > > > > int (*runtime_suspend)(struct device *dev); int
> > > > > > > > > > > > (*runtime_resume)(struct device *dev);
> > > > > > > > > > >=20
> > > > > > > > > > > I wonder how useful is it to teach everyone what the
> > > > > > > > > > > generic 'struct dev_pm_ops'
> > > > > > > > > > > contains. Perhaps you simply wanted that this patch
> > > > > > > > > > > implement both suspend and resume ops ?
> > > > > > > > > > >=20
> > > > > > > > > > > >=20
> > > > > > > > > > > > Signed-off-by: Jackson Lee
> > > > > > > > > > > > <jackson.lee@chipsnmedia.com>
> > > > > > > > > > > > Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com=
>
> > > > > > > > > > > > ---
> > > > > > > > > > > > =C2=A0.../platform/chips-media/wave5/wave5-hw.c    =
 |  5 +-
> > > > > > > > > > > > =C2=A0.../chips-media/wave5/wave5-vpu-dec.c        =
 |  9 +++
> > > > > > > > > > > > =C2=A0.../chips-media/wave5/wave5-vpu-enc.c        =
 |  9 +++
> > > > > > > > > > > > =C2=A0.../platform/chips-media/wave5/wave5-vpu.c   =
 | 68
> > > > > > > > > +++++++++++++++++++
> > > > > > > > > > > > =C2=A0.../platform/chips-media/wave5/wave5-vpuapi.c=
 |  7
> > > > > > > > > > > > ++ .../media/platform/chips-media/wave5/wave5.h  |
> > > > > > > > > > > > 3 +
> > > > > > > > > > > > =C2=A06 files changed, 99 insertions(+), 2 deletion=
s(-)
> > > > > > > > > > > >=20
> > > > > > > > > > > > diff --git
> > > > > > > > > > > > a/drivers/media/platform/chips-media/wave5/wave5-hw=
.
> > > > > > > > > > > > c
> > > > > > > > > > > > b/drivers/media/platform/chips-media/wave5/wave5-hw=
.
> > > > > > > > > > > > c index 8ad7f3a28ae1..8aade5a38439 100644
> > > > > > > > > > > > ---
> > > > > > > > > > > > a/drivers/media/platform/chips-media/wave5/wave5-hw=
.
> > > > > > > > > > > > c
> > > > > > > > > > > > +++ b/drivers/media/platform/chips-media/wave5/wave=
5-
> > hw.
> > > > > > > > > > > > +++ c
> > > > > > > > > > > > @@ -503,6 +503,7 @@ int
> > > > > > > > > > > > wave5_vpu_build_up_dec_param(struct
> > > > > > > > > > > > vpu_instance
> > > > > > > > > > > *inst,
> > > > > > > > > > > > =C2=A0	/* This register must be reset explicitly */
> > > > > > > > > > > > =C2=A0	vpu_write_reg(inst->dev, W5_CMD_EXT_ADDR, 0)=
;
> > > > > > > > > > > > =C2=A0	vpu_write_reg(inst->dev, W5_CMD_NUM_CQ_DEPTH=
_M1,
> > > > > > > > > > > > (COMMAND_QUEUE_DEPTH - 1));
> > > > > > > > > > > > +	vpu_write_reg(inst->dev, W5_CMD_ERR_CONCEAL, 0);
> > > > > > > > > > >=20
> > > > > > > > > > > In some way, the relation between suspend and this
> > > > > > > > > > > register write is not obvious. If its not related,
> > > > > > > > > > > please do this in its
> > > > > > > own patch.
> > > > > > > > > > > Otherwise you want to explain why you needed this
> > > > > > > > > > > (possibly just in the commit message).
> > > > > > > > > > >=20
> > > > > > > > > > > >=20
> > > > > > > > > > > > =C2=A0	ret =3D send_firmware_command(inst,
> > > > > > > > > > > > W5_CREATE_INSTANCE, true, NULL,
> > > > > > > > > > > NULL);
> > > > > > > > > > > > =C2=A0	if (ret) {
> > > > > > > > > > > > @@ -1075,8 +1076,8 @@ int wave5_vpu_re_init(struct
> > > > > > > > > > > > device *dev, u8 *fw,
> > > > > > > > > > > size_t size)
> > > > > > > > > > > > =C2=A0	return setup_wave5_properties(dev);  }
> > > > > > > > > > > >=20
> > > > > > > > > > > > -static int wave5_vpu_sleep_wake(struct device *dev=
,
> > > > > > > > > > > > bool i_sleep_wake,
> > > > > > > > > > > const uint16_t *code,
> > > > > > > > > > > > -				size_t size)
> > > > > > > > > > > > +int wave5_vpu_sleep_wake(struct device *dev, bool
> > > > > > > > > > > > +i_sleep_wake, const
> > > > > > > > > > > uint16_t *code,
> > > > > > > > > > > > +			 size_t size)
> > > > > > > > > > > > =C2=A0{
> > > > > > > > > > > > =C2=A0	u32 reg_val;
> > > > > > > > > > > > =C2=A0	struct vpu_buf *common_vb; diff --git
> > > > > > > > > > > > a/drivers/media/platform/chips-media/wave5/wave5-vp=
u
> > > > > > > > > > > > -dec
> > > > > > > > > > > > .c
> > > > > > > > > > > > b/drivers/media/platform/chips-media/wave5/wave5-vp=
u
> > > > > > > > > > > > -dec .c index ef227af72348..328a7a8f26c5 100644
> > > > > > > > > > > > ---
> > > > > > > > > > > > a/drivers/media/platform/chips-media/wave5/wave5-vp=
u
> > > > > > > > > > > > -dec
> > > > > > > > > > > > .c
> > > > > > > > > > > > +++ b/drivers/media/platform/chips-media/wave5/wave=
5
> > > > > > > > > > > > +++ -vpu
> > > > > > > > > > > > +++ -d
> > > > > > > > > > > > +++ ec.c
> > > > > > > > > > > > @@ -5,6 +5,7 @@
> > > > > > > > > > > > =C2=A0=C2=A0* Copyright (C) 2021-2023 CHIPS&MEDIA I=
NC
> > > > > > > > > > > > =C2=A0=C2=A0*/
> > > > > > > > > > > >=20
> > > > > > > > > > > > +#include <linux/pm_runtime.h>
> > > > > > > > > > > > =C2=A0#include "wave5-helper.h"
> > > > > > > > > > > >=20
> > > > > > > > > > > > =C2=A0#define VPU_DEC_DEV_NAME "C&M Wave5 VPU decod=
er"
> > > > > > > > > > > > @@ -1387,9 +1388,17 @@ static int
> > > > > > > > > > > > wave5_vpu_dec_start_streaming(struct
> > > > > > > > > > > > vb2_queue *q, unsigned int count
> > > > > > > > > > > >=20
> > > > > > > > > > > > =C2=A0	if (q->type =3D=3D
> > V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE
> > > > > > > > > > > > &&
> > > > > > > > > > > > inst-
> > > > > > > > > > state
> > > > > > > > > > > > =3D=3D
> > > > > > > > > > > VPU_INST_STATE_NONE) {
> > > > > > > > > > > > =C2=A0		struct dec_open_param open_param;
> > > > > > > > > > > > +		int err =3D 0;
> > > > > > > > > > > >=20
> > > > > > > > > > > > =C2=A0		memset(&open_param, 0, sizeof(struct
> > > > > dec_open_param));
> > > > > > > > > > > >=20
> > > > > > > > > > > > +		err =3D pm_runtime_resume_and_get(inst-
> > > dev->dev);
> > > > > > > > > > > > +		if (err) {
> > > > > > > > > > > > +			dev_err(inst->dev->dev, "decoder
> > runtime
> > > > > resume
> > > > > > > > > > > failed %d\n", err);
> > > > > > > > > > > > +			ret =3D -EINVAL;
> > > > > > > > > > > > +			goto return_buffers;
> > > > > > > > > > > > +		}
> > > > > > > > > > > > +
> > > > > > > > > > > > =C2=A0		ret =3D
> > wave5_vpu_dec_allocate_ring_buffer(inst);
> > > > > > > > > > > > =C2=A0		if (ret)
> > > > > > > > > > > > =C2=A0			goto return_buffers; diff --git
> > > > > > > > > > > > a/drivers/media/platform/chips-media/wave5/wave5-vp=
u
> > > > > > > > > > > > -enc
> > > > > > > > > > > > .c
> > > > > > > > > > > > b/drivers/media/platform/chips-media/wave5/wave5-vp=
u
> > > > > > > > > > > > -enc .c index 761775216cd4..ff73d69de41c 100644
> > > > > > > > > > > > ---
> > > > > > > > > > > > a/drivers/media/platform/chips-media/wave5/wave5-vp=
u
> > > > > > > > > > > > -enc
> > > > > > > > > > > > .c
> > > > > > > > > > > > +++ b/drivers/media/platform/chips-media/wave5/wave=
5
> > > > > > > > > > > > +++ -vpu
> > > > > > > > > > > > +++ -e
> > > > > > > > > > > > +++ nc.c
> > > > > > > > > > > > @@ -5,6 +5,7 @@
> > > > > > > > > > > > =C2=A0=C2=A0* Copyright (C) 2021-2023 CHIPS&MEDIA I=
NC
> > > > > > > > > > > > =C2=A0=C2=A0*/
> > > > > > > > > > > >=20
> > > > > > > > > > > > +#include <linux/pm_runtime.h>
> > > > > > > > > > > > =C2=A0#include "wave5-helper.h"
> > > > > > > > > > > >=20
> > > > > > > > > > > > =C2=A0#define VPU_ENC_DEV_NAME "C&M Wave5 VPU encod=
er"
> > > > > > > > > > > > @@ -1387,9 +1388,17 @@ static int
> > > > > > > > > > > > wave5_vpu_enc_start_streaming(struct
> > > > > > > > > > > > vb2_queue *q, unsigned int count
> > > > > > > > > > > >=20
> > > > > > > > > > > > =C2=A0	if (inst->state =3D=3D VPU_INST_STATE_NONE &=
& q-
> > > type
> > > > > > > > > > > > =3D=3D
> > > > > > > > > > > V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
> > > > > > > > > > > > =C2=A0		struct enc_open_param open_param;
> > > > > > > > > > > > +		int err =3D 0;
> > > > > > > > > > > >=20
> > > > > > > > > > > > =C2=A0		memset(&open_param, 0, sizeof(struct
> > > > > enc_open_param));
> > > > > > > > > > > >=20
> > > > > > > > > > > > +		err =3D pm_runtime_resume_and_get(inst-
> > > dev->dev);
> > > > > > > > > > > > +		if (err) {
> > > > > > > > > > > > +			dev_err(inst->dev->dev, "encoder
> > runtime
> > > > > resume
> > > > > > > > > > > failed %d\n", err);
> > > > > > > > > > > > +			ret =3D -EINVAL;
> > > > > > > > > > > > +			goto return_buffers;
> > > > > > > > > > > > +		}
> > > > > > > > > > > > +
> > > > > > > > > > > > =C2=A0		wave5_set_enc_openparam(&open_param,
> > inst);
> > > > > > > > > > > >=20
> > > > > > > > > > > > =C2=A0		ret =3D wave5_vpu_enc_open(inst,
> > &open_param);
> > > > > diff --
> > > > > > > > > git
> > > > > > > > > > > > a/drivers/media/platform/chips-media/wave5/wave5-vp=
u
> > > > > > > > > > > > .c
> > > > > > > > > > > > b/drivers/media/platform/chips-media/wave5/wave5-vp=
u
> > > > > > > > > > > > .c index 0d90b5820bef..f81409740a56 100644
> > > > > > > > > > > > ---
> > > > > > > > > > > > a/drivers/media/platform/chips-media/wave5/wave5-vp=
u
> > > > > > > > > > > > .c
> > > > > > > > > > > > +++ b/drivers/media/platform/chips-media/wave5/wave=
5
> > > > > > > > > > > > +++ -vpu
> > > > > > > > > > > > +++ .c
> > > > > > > > > > > > @@ -10,6 +10,7 @@
> > > > > > > > > > > > =C2=A0#include <linux/clk.h>
> > > > > > > > > > > > =C2=A0#include <linux/firmware.h>  #include
> > > > > > > > > > > > <linux/interrupt.h>
> > > > > > > > > > > > +#include <linux/pm_runtime.h>
> > > > > > > > > > > > =C2=A0#include "wave5-vpu.h"
> > > > > > > > > > > > =C2=A0#include "wave5-regdefine.h"
> > > > > > > > > > > > =C2=A0#include "wave5-vpuconfig.h"
> > > > > > > > > > > > @@ -117,6 +118,65 @@ static int
> > > > > > > > > > > > wave5_vpu_load_firmware(struct device
> > > > > > > > > > > *dev, const char *fw_name,
> > > > > > > > > > > > =C2=A0	return 0;
> > > > > > > > > > > > =C2=A0}
> > > > > > > > > > > >=20
> > > > > > > > > > > > +static __maybe_unused int wave5_pm_suspend(struct
> > > > > > > > > > > > +device
> > > > > > > > > > > > +*dev)
> > > > > > > {
> > > > > > > > > > > > +	struct vpu_device *vpu =3D dev_get_drvdata(dev);
> > > > > > > > > > > > +
> > > > > > > > > > > > +	if (pm_runtime_suspended(dev))
> > > > > > > > > > > > +		return 0;
> > > > > > > > > > > > +
> > > > > > > > > > > > +	wave5_vpu_sleep_wake(dev, true, NULL, 0);
> > > > > > > > > > > > +	clk_bulk_disable_unprepare(vpu->num_clks,
> > > > > > > > > > > > +vpu->clks);
> > > > > > > > > > > > +
> > > > > > > > > > > > +	return 0;
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > > +static __maybe_unused int wave5_pm_resume(struct
> > > > > > > > > > > > +device
> > > > > *dev) {
> > > > > > > > > > > > +	struct vpu_device *vpu =3D dev_get_drvdata(dev);
> > > > > > > > > > > > +	int ret =3D 0;
> > > > > > > > > > > > +
> > > > > > > > > > > > +	wave5_vpu_sleep_wake(dev, false, NULL, 0);
> > > > > > > > > > > > +	ret =3D clk_bulk_prepare_enable(vpu->num_clks,
> > vpu-
> > > > > > clks);
> > > > > > > > > > > > +	if (ret) {
> > > > > > > > > > > > +		dev_err(dev, "Enabling clocks,
> > fail: %d\n",
> > > > > ret);
> > > > > > > > > > > > +		return ret;
> > > > > > > > > > > > +	}
> > > > > > > > > > > > +
> > > > > > > > > > > > +	return ret;
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > > +static __maybe_unused int wave5_suspend(struct
> > > > > > > > > > > > +device
> > > > > > > > > > > > +*dev)
> > > > > {
> > > > > > > > > > > > +	struct vpu_device *vpu =3D dev_get_drvdata(dev);
> > > > > > > > > > > > +	struct vpu_instance *inst;
> > > > > > > > > > > > +
> > > > > > > > > > > > +	list_for_each_entry(inst, &vpu->instances, list)
> > > > > > > > > > > > +		v4l2_m2m_suspend(inst->v4l2_m2m_dev);
> > > > > > > > > > > > +
> > > > > > > > > > > > +	return pm_runtime_force_suspend(dev); }
> > > > > > > > > > > > +
> > > > > > > > > > > > +static __maybe_unused int wave5_resume(struct
> > > > > > > > > > > > +device
> > > > > > > > > > > > +*dev)
> > > > > {
> > > > > > > > > > > > +	struct vpu_device *vpu =3D dev_get_drvdata(dev);
> > > > > > > > > > > > +	struct vpu_instance *inst;
> > > > > > > > > > > > +	int ret =3D 0;
> > > > > > > > > > > > +
> > > > > > > > > > > > +	ret =3D pm_runtime_force_resume(dev);
> > > > > > > > > > > > +	if (ret < 0)
> > > > > > > > > > > > +		return ret;
> > > > > > > > > > > > +
> > > > > > > > > > > > +	list_for_each_entry(inst, &vpu->instances, list)
> > > > > > > > > > > > +		v4l2_m2m_resume(inst->v4l2_m2m_dev);
> > > > > > > > > > > > +
> > > > > > > > > > > > +	return ret;
> > > > > > > > > > > > +}
> > > > > > > > > > >=20
> > > > > > > > > > > The functions wave5_suspend() and wave5_resume() are
> > > > > > > > > > > not just "maybe_unsued" but actually never used. What
> > > > > > > > > > > was the
> > > > > intention ?
> > > > > > > > > > > Considering the usage of __maybe_unused has been such
> > > > > > > > > > > a bad friend for this one, could you instead bracket
> > > > > > > > > > > the functions with an
> > > > > > > > > explicit ?
> > > > > > > > > > >=20
> > > > > > > > > > > #ifdef CONFIG_PM
> > > > > > > > > > > #endif
> > > > > > > > > > >=20
> > > > > > > > > > > This way the compiler will have a word if you
> > > > > > > > > > > implement something that you forgot to actually use.
> > > > > > > > > > >=20
> > > > > > > > > > > > +
> > > > > > > > > > > > +static const struct dev_pm_ops wave5_pm_ops =3D {
> > > > > > > > > > > > +	SET_RUNTIME_PM_OPS(wave5_pm_suspend,
> > > > > > > > > > > > +wave5_pm_resume,
> > > > > > > > > NULL) };
> > > > > > > > > > > > +
> > > > > > > > > > > > =C2=A0static int wave5_vpu_probe(struct platform_de=
vice
> > > > > > > > > > > > *pdev)
> > > > {
> > > > > > > > > > > > =C2=A0	int ret;
> > > > > > > > > > > > @@ -232,6 +292,10 @@ static int
> > > > > > > > > > > > wave5_vpu_probe(struct platform_device
> > > > > > > > > > > *pdev)
> > > > > > > > > > > > =C2=A0		 (match_data->flags & WAVE5_IS_DEC) ?
> > > > > "'DECODE'" : "");
> > > > > > > > > > > > =C2=A0	dev_info(&pdev->dev, "Product Code:      0x%=
x\n",
> > dev-
> > > > > > > > > > product_code);
> > > > > > > > > > > > =C2=A0	dev_info(&pdev->dev, "Firmware Revision: %u\=
n",
> > > > > > > > > > > > fw_revision);
> > > > > > > > > > > > +
> > > > > > > > > > > > +	pm_runtime_enable(&pdev->dev);
> > > > > > > > > > > > +	wave5_vpu_sleep_wake(&pdev->dev, true, NULL, 0);
> > > > > > > > > > > > +
> > > > > > > > > > > > =C2=A0	return 0;
> > > > > > > > > > > >=20
> > > > > > > > > > > > =C2=A0err_enc_unreg:
> > > > > > > > > > > > @@ -254,6 +318,9 @@ static int
> > > > > > > > > > > > wave5_vpu_remove(struct platform_device
> > > > > > > > > > > > *pdev)  {
> > > > > > > > > > > > =C2=A0	struct vpu_device *dev =3D
> > > > > > > > > > > > dev_get_drvdata(&pdev->dev);
> > > > > > > > > > > >=20
> > > > > > > > > > > > +	pm_runtime_put_sync(&pdev->dev);
> > > > > > > > > > > > +	pm_runtime_disable(&pdev->dev);
> > > > > > > > > > > > +
> > > > > > > > > > > > =C2=A0	mutex_destroy(&dev->dev_lock);
> > > > > > > > > > > > =C2=A0	mutex_destroy(&dev->hw_lock);
> > > > > > > > > > > > =C2=A0	clk_bulk_disable_unprepare(dev->num_clks,
> > > > > > > > > > > > dev->clks);
> > > > > @@
> > > > > > > > > > > > -
> > > > > > > > > 281,6
> > > > > > > > > > > > +348,7 @@ static struct platform_driver
> > > > > > > > > > > > +wave5_vpu_driver =3D {
> > > > > > > > > > > > =C2=A0	.driver =3D {
> > > > > > > > > > > > =C2=A0		.name =3D VPU_PLATFORM_DEVICE_NAME,
> > > > > > > > > > > > =C2=A0		.of_match_table =3D
> > of_match_ptr(wave5_dt_ids),
> > > > > > > > > > > > +		.pm =3D &wave5_pm_ops,
> > > > > > > > > > > > =C2=A0		},
> > > > > > > > > > > > =C2=A0	.probe =3D wave5_vpu_probe,
> > > > > > > > > > > > =C2=A0	.remove =3D wave5_vpu_remove, diff --git
> > > > > > > > > > > > a/drivers/media/platform/chips-media/wave5/wave5-
> > vpuapi.
> > > > > > > > > > > > c
> > > > > > > > > > > > b/drivers/media/platform/chips-media/wave5/wave5-
> > vpuapi.
> > > > > > > > > > > > c index 1a3efb638dde..f1f8e4fc8474 100644
> > > > > > > > > > > > ---
> > > > > > > > > > > > a/drivers/media/platform/chips-media/wave5/wave5-
> > vpuapi.
> > > > > > > > > > > > c
> > > > > > > > > > > > +++ b/drivers/media/platform/chips-media/wave5/wave=
5
> > > > > > > > > > > > +++ -vpu
> > > > > > > > > > > > +++ ap
> > > > > > > > > > > > +++ i.c
> > > > > > > > > > > > @@ -6,6 +6,7 @@
> > > > > > > > > > > > =C2=A0=C2=A0*/
> > > > > > > > > > > >=20
> > > > > > > > > > > > =C2=A0#include <linux/bug.h>
> > > > > > > > > > > > +#include <linux/pm_runtime.h>
> > > > > > > > > > > > =C2=A0#include "wave5-vpuapi.h"
> > > > > > > > > > > > =C2=A0#include "wave5-regdefine.h"
> > > > > > > > > > > > =C2=A0#include "wave5.h"
> > > > > > > > > > > > @@ -232,6 +233,9 @@ int wave5_vpu_dec_close(struct
> > > > > > > > > > > > vpu_instance *inst,
> > > > > > > > > > > > u32 *fail_res)
> > > > > > > > > > > >=20
> > > > > > > > > > > > =C2=A0	wave5_vdi_free_dma_memory(vpu_dev,
> > > > > > > > > > > > &p_dec_info->vb_task);
> > > > > > > > > > > >=20
> > > > > > > > > > > > +	if (!pm_runtime_suspended(inst->dev->dev))
> > > > > > > > > > > > +		pm_runtime_put_sync(inst->dev->dev);
> > > > > > > > > > > > +
> > > > > > > > > > > > =C2=A0unlock_and_return:
> > > > > > > > > > > > =C2=A0	mutex_unlock(&vpu_dev->hw_lock);
> > > > > > > > > > > >=20
> > > > > > > > > > > > @@ -734,6 +738,9 @@ int wave5_vpu_enc_close(struct
> > > > > > > > > > > > vpu_instance *inst,
> > > > > > > > > > > > u32 *fail_res)
> > > > > > > > > > > >=20
> > > > > > > > > > > > =C2=A0	wave5_vdi_free_dma_memory(vpu_dev,
> > > > > > > > > > > > &p_enc_info->vb_task);
> > > > > > > > > > > >=20
> > > > > > > > > > > > +	if (!pm_runtime_suspended(inst->dev->dev))
> > > > > > > > > > > > +		pm_runtime_put_sync(inst->dev->dev);
> > > > > > > > > > >=20
> > > > > > > > > > > This seems very unnatural. We do the get() in
> > > > > > > > > > > "start_streaming()", but the
> > > > > > > > > > > put() is only done when the device is closed, or when
> > > > > > > > > > > the driver is removed. As this is not balanced, you
> > > > > > > > > > > seem to have to check the suspended condition all ove=
r
> > the place.
> > > > > > > > > > >=20
> > > > > > > > > > > I think we could aim for
> > > > > > > > > > > start_streaming()/stop_streaming()
> > > > > > > > > > > for your get/put placement. At least they will be
> > > > > > > > > > > bound to an entirely balanced
> > > > > > > > > API.
> > > > > > > > > > > But then, a media player in paused sate will prevent
> > > > > > > > > > > that device from being suspended.
> > > > > > > > > > >=20
> > > > > > > > > > > If the HW is capable of preserving enough state, and
> > > > > > > > > > > From the short doc I have it gives me the impression
> > > > > > > > > > > it can preserve that, I'd suggest to follow what
> > > > > > > > > > > hantro driver is doing. What is does is that it will
> > > > > > > > > > > do get() in device_run(), and put() whenever the job
> > > > > > > > > > > completes. This driver has been designed so when ther=
e
> > > > > > > > > > > is no job, it means the firmware is currently idle an=
d
> > looking for more work.
> > > > > > > > > > > So it seems like the perfect moment to
> > > > > > > do suspend it.
> > > > > > > > > > >=20
> > > > > > > > > > > Nicolas
> > > > > > > > > > >=20
> > > > > > > > > > > > +
> > > > > > > > > > > > =C2=A0	mutex_unlock(&vpu_dev->hw_lock);
> > > > > > > > > > > >=20
> > > > > > > > > > > > =C2=A0	return 0;
> > > > > > > > > > > > diff --git
> > > > > > > > > > > > a/drivers/media/platform/chips-media/wave5/wave5.h
> > > > > > > > > > > > b/drivers/media/platform/chips-media/wave5/wave5.h
> > > > > > > > > > > > index 063028eccd3b..6125eff938a8 100644
> > > > > > > > > > > > ---
> > > > > > > > > > > > a/drivers/media/platform/chips-media/wave5/wave5.h
> > > > > > > > > > > > +++ b/drivers/media/platform/chips-media/wave5/wave=
5
> > > > > > > > > > > > +++ .h
> > > > > > > > > > > > @@ -56,6 +56,9 @@ int wave5_vpu_get_version(struct
> > > > > > > > > > > > vpu_device *vpu_dev, u32 *revision);
> > > > > > > > > > > >=20
> > > > > > > > > > > > =C2=A0int wave5_vpu_init(struct device *dev, u8 *fw=
,
> > > > > > > > > > > > size_t size);
> > > > > > > > > > > >=20
> > > > > > > > > > > > +int wave5_vpu_sleep_wake(struct device *dev, bool
> > > > > > > > > > > > +i_sleep_wake, const
> > > > > > > > > > > uint16_t *code,
> > > > > > > > > > > > +			 size_t size);
> > > > > > > > > > > > +
> > > > > > > > > > > > =C2=A0int wave5_vpu_reset(struct device *dev, enum
> > > > > > > > > > > > sw_reset_mode reset_mode);
> > > > > > > > > > > >=20
> > > > > > > > > > > > =C2=A0int wave5_vpu_build_up_dec_param(struct
> > > > > > > > > > > > vpu_instance *inst, struct dec_open_param *param);
> > > > > > > > > >=20
> > > > > > > >=20
> > > > > >=20
> > >=20
>=20



Return-Path: <linux-kernel+bounces-129518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5FE896C1C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE5E3B2F68A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB469136E1B;
	Wed,  3 Apr 2024 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="euKDnMaH"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DA9137C43
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139249; cv=none; b=cdTLQy4Ni8jsZKVAOjzTttyPWt/J/WGyvuPWOdl2X/2z6tf0ZyZRqmCnFFFbVYS0om2iuIEMmIaNtwIqI26IKxBzWsCG7JHXwoO9jWr7ap60MoAvySyUAw4pPpaUZ9CPK5BW+3Taqlq5W1eZAR8WAD7E73PdzXMw3nW/xjaywZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139249; c=relaxed/simple;
	bh=3crVOf3j6XXd5qfELYtReh1hJW9lY+2vJMFodoivKjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnKaGZOLX39ezM13AflCrt9Y7CKmjYCBuT1ek0xtCzAYSdMn4a8aVtUbuf+gSkzujH+AoqXxauSWA7QG6X5kzrEuxHZ5HWM/L/O+ciQ6WzJIIqQ5hA9zCmjhIjHRFjLcVzdDKfWR146SAWLbXeUuF4xpG5gSTYfF0rRVdzcB94A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=euKDnMaH; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcc71031680so5661584276.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 03:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712139246; x=1712744046; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wKOQs+TmUwBWd9nBZ5bd0FjYKLI0xx+jqXHAXa7eWSs=;
        b=euKDnMaHwcN3zWvvauMzOICwUjY5hSA5y7z93Q/KLnciIaf0T4Y3bkymauS2a3kbQT
         q9piTRrHQCYbe7qDF0DYGJy+fBFhmZ5zVIX8ufxtiDByogG4aOTt8Bps4dQHmsCNGpwQ
         RqUxSz8g5SFcuVmBP5YSDrOBZ6f5vlBKZkn5u8EXDIJyM6pyO3O2mTaq6ReVMOTxfPTN
         vtoGV2cFALP+svMen6kDnXZrCR0D6u5yLBLVtaii7ZF0Z41BunQbJCddSs+lttg2kaOr
         JWSDWyqtwVuJSHSf2BhsqoZsbP3kfwWkaP7c/EmPo3aeuudbUjwlG2x6H8mJTMbFZCxy
         qRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712139246; x=1712744046;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKOQs+TmUwBWd9nBZ5bd0FjYKLI0xx+jqXHAXa7eWSs=;
        b=pCRpBJIMiJ/fD/VKJVvhwFLFnrp0SyqzMwln6NEjyd5frR3UIojDjjTbk/l02wn1ZH
         4IRrhe8o+EXDxji0JfMCRhDsC84P6X3hXApKVuTh0ZmLcp1OS1CJ53QAT2FXf6y0zUHF
         53FuhVdvPteYbk4mdEF+Y8vmbrbi6Ts+Af85VWIPG28+zfdEK037XLDQ6k2Y2JxrD7NF
         4KloKycCAhldEdRlmRLkDNAPywg65uXFqlBR1J/dN8aJUBY7EmYFytpenxGmeCfujzDZ
         tkmnu8UQsnIRpqrCHU2/w7y7zdeoCp3JIJ0CbQLTin+ktfE6ecsr5cvw2xBYe8/H2LO9
         i0uA==
X-Forwarded-Encrypted: i=1; AJvYcCUqreFRi8HIGJ3kogYsL7lDJ7T6xQd00BSvxMF/jMDKipXET5A4k61jGkrcTvVo/OIXGVTcioU6MdTHoThY74RjPZBli0d+UqLq3GUD
X-Gm-Message-State: AOJu0YxnUzRiuIeYGzYc+RP5R8iUZZuoQivFGySQS6WaiRxKxoq9GZ+7
	Hf2dzGCbij2Ioabcjiyq54OGPoMMSisQ/BvyOzB/WX381WI/smZKskYYJsG14EkkO60rwl2Ky61
	xoYL7MOb3WJUvD/8b4/eQWOL7KXdN0qVaHcVNug==
X-Google-Smtp-Source: AGHT+IGzKMz9/iFfBLaO0Exy3dYLERLc70CKCeB/qcA5U78i+AFMpSfiHPfV1+G4P61zpg9KKbLtmi5hXn167JObpzo=
X-Received: by 2002:a25:b195:0:b0:dca:59a7:896b with SMTP id
 h21-20020a25b195000000b00dca59a7896bmr14271207ybj.50.1712139246514; Wed, 03
 Apr 2024 03:14:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403-msm-drm-dsc-dsi-video-upstream-v1-0-db5036443545@linaro.org>
 <20240403-msm-drm-dsc-dsi-video-upstream-v1-3-db5036443545@linaro.org>
In-Reply-To: <20240403-msm-drm-dsc-dsi-video-upstream-v1-3-db5036443545@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 3 Apr 2024 13:13:55 +0300
Message-ID: <CAA8EJpo1YoLWCPz1TXiV_3YOjOxwxV7Jdq6uhX=15LfWHVBmHg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] drm/msm/dsi: set VIDEO_COMPRESSION_MODE_CTRL_WC
 (fix video mode DSC)
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 12:11, Jun Nie <jun.nie@linaro.org> wrote:
>
> From: Jonathan Marek <jonathan@marek.ca>
>
> Video mode DSC won't work if this field is not set correctly. Set it to fix
> video mode DSC (for slice_per_pkt==1 cases at least).
>
> Fixes: 08802f515c3c ("drm/msm/dsi: Add support for DSC configuration")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

You S-o-b is missing

> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 2a0422cad6de..80ea4f1d8274 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -858,6 +858,7 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
>         u32 slice_per_intf, total_bytes_per_intf;
>         u32 pkt_per_line;
>         u32 eol_byte_num;
> +       u32 bytes_per_pkt;
>
>         /* first calculate dsc parameters and then program
>          * compress mode registers
> @@ -865,6 +866,7 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
>         slice_per_intf = msm_dsc_get_slices_per_intf(dsc, hdisplay);
>
>         total_bytes_per_intf = dsc->slice_chunk_size * slice_per_intf;
> +       bytes_per_pkt = dsc->slice_chunk_size; /* * slice_per_pkt; */
>
>         eol_byte_num = total_bytes_per_intf % 3;
>
> @@ -902,6 +904,7 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
>                 dsi_write(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL, reg_ctrl);
>                 dsi_write(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL2, reg_ctrl2);
>         } else {
> +               reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_WC(bytes_per_pkt);
>                 dsi_write(msm_host, REG_DSI_VIDEO_COMPRESSION_MODE_CTRL, reg);
>         }
>  }
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry


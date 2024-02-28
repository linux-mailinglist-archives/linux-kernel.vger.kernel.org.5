Return-Path: <linux-kernel+bounces-84644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EEB86A96F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02832831FB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6915625778;
	Wed, 28 Feb 2024 08:01:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C236825601;
	Wed, 28 Feb 2024 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709107278; cv=none; b=fNjh2tmDGBhPOpOiEcd8IDBISYeBQwm2fzvbFAxQxr4mXmtRVNpN1F6kMLLA6AqU/omLStB9SvGCOhjZ4H68UGnkY2dAwnb9yppdSRCR7VKoRSzTr2/ZnkjX09S4hPelMFDg3WL8mlVSroGz27i6hKoTkRPhP9eDjfic7+cUadY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709107278; c=relaxed/simple;
	bh=fdiWWq7ghuEZ8cPR49kjxrB6ebgbwyYGUGl3rrdnPYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rageCiN1TxUhzr4u8Mk/XCbz2xrV/7gFzKYILPi1QlQzMqcFy6fWHHxwP8E30HS/EHWnUpN/ULxwpl8gMC9ZzDt6wjTFN9c7OaOA/DHetD28talKD/oe2sHdYMXHnKdr7dwg5Qvvm6KBqdMHFLd0998ywTZEtTd5ogTbRE/wQtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F6BC433C7;
	Wed, 28 Feb 2024 08:01:14 +0000 (UTC)
Message-ID: <ab5e7379-8a55-43d1-b784-8d89aae250c3@xs4all.nl>
Date: Wed, 28 Feb 2024 09:01:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] media: usb: pvrusb2: Fix
 Wcast-function-type-strict warnings
Content-Language: en-US, nl
To: Ricardo Ribalda <ribalda@chromium.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Mike Isely <isely@pobox.com>, Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-remoteproc@vger.kernel.org
References: <20240226-fix-clang-warnings-v2-0-fa1bc931d17e@chromium.org>
 <20240226-fix-clang-warnings-v2-2-fa1bc931d17e@chromium.org>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <20240226-fix-clang-warnings-v2-2-fa1bc931d17e@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/02/2024 18:32, Ricardo Ribalda wrote:
> Building with LLVM=1 throws the following warning:
> drivers/media/usb/pvrusb2/pvrusb2-context.c:110:6: warning: cast from 'void (*)(struct pvr2_context *)' to 'void (*)(void *)' converts to incompatible function type [-Wcast-function-type-strict]
> drivers/media/usb/pvrusb2/pvrusb2-v4l2.c:1070:30: warning: cast from 'void (*)(struct pvr2_v4l2_fh *)' to 'pvr2_stream_callback' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict] drivers/media/usb/pvrusb2/pvrusb2-dvb.c:152:6: warning: cast from 'void (*)(struct pvr2_dvb_adapter *)' to 'pvr2_stream_callback' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]

This patch from Arnd has already been merged, superseding your patch:

https://lore.kernel.org/linux-media/20240213100439.457403-1-arnd@kernel.org/

Marking your patch as Obsolete in patchwork.

Regards,

	Hans

> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/pvrusb2/pvrusb2-context.c | 5 +++--
>  drivers/media/usb/pvrusb2/pvrusb2-dvb.c     | 7 ++++---
>  drivers/media/usb/pvrusb2/pvrusb2-v4l2.c    | 7 ++++---
>  3 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/usb/pvrusb2/pvrusb2-context.c b/drivers/media/usb/pvrusb2/pvrusb2-context.c
> index 1764674de98bc..16edabda191c4 100644
> --- a/drivers/media/usb/pvrusb2/pvrusb2-context.c
> +++ b/drivers/media/usb/pvrusb2/pvrusb2-context.c
> @@ -90,8 +90,9 @@ static void pvr2_context_destroy(struct pvr2_context *mp)
>  }
>  
>  
> -static void pvr2_context_notify(struct pvr2_context *mp)
> +static void pvr2_context_notify(void *data)
>  {
> +	struct pvr2_context *mp = data;
>  	pvr2_context_set_notify(mp,!0);
>  }
>  
> @@ -107,7 +108,7 @@ static void pvr2_context_check(struct pvr2_context *mp)
>  			   "pvr2_context %p (initialize)", mp);
>  		/* Finish hardware initialization */
>  		if (pvr2_hdw_initialize(mp->hdw,
> -					(void (*)(void *))pvr2_context_notify,
> +					pvr2_context_notify,
>  					mp)) {
>  			mp->video_stream.stream =
>  				pvr2_hdw_get_video_stream(mp->hdw);
> diff --git a/drivers/media/usb/pvrusb2/pvrusb2-dvb.c b/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
> index 26811efe0fb58..8b9f1a09bd53d 100644
> --- a/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
> +++ b/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
> @@ -88,8 +88,9 @@ static int pvr2_dvb_feed_thread(void *data)
>  	return stat;
>  }
>  
> -static void pvr2_dvb_notify(struct pvr2_dvb_adapter *adap)
> +static void pvr2_dvb_notify(void *data)
>  {
> +	struct pvr2_dvb_adapter *adap = data;
>  	wake_up(&adap->buffer_wait_data);
>  }
>  
> @@ -148,8 +149,8 @@ static int pvr2_dvb_stream_do_start(struct pvr2_dvb_adapter *adap)
>  		if (!(adap->buffer_storage[idx])) return -ENOMEM;
>  	}
>  
> -	pvr2_stream_set_callback(pvr->video_stream.stream,
> -				 (pvr2_stream_callback) pvr2_dvb_notify, adap);
> +	pvr2_stream_set_callback(pvr->video_stream.stream, pvr2_dvb_notify,
> +				 adap);
>  
>  	ret = pvr2_stream_set_buffer_count(stream, PVR2_DVB_BUFFER_COUNT);
>  	if (ret < 0) return ret;
> diff --git a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
> index c04ab7258d645..590f80949bbfc 100644
> --- a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
> +++ b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
> @@ -1032,9 +1032,10 @@ static int pvr2_v4l2_open(struct file *file)
>  	return 0;
>  }
>  
> -
> -static void pvr2_v4l2_notify(struct pvr2_v4l2_fh *fhp)
> +static void pvr2_v4l2_notify(void *data)
>  {
> +	struct pvr2_v4l2_fh *fhp = data;
> +
>  	wake_up(&fhp->wait_data);
>  }
>  
> @@ -1067,7 +1068,7 @@ static int pvr2_v4l2_iosetup(struct pvr2_v4l2_fh *fh)
>  
>  	hdw = fh->channel.mc_head->hdw;
>  	sp = fh->pdi->stream->stream;
> -	pvr2_stream_set_callback(sp,(pvr2_stream_callback)pvr2_v4l2_notify,fh);
> +	pvr2_stream_set_callback(sp, pvr2_v4l2_notify, fh);
>  	pvr2_hdw_set_stream_type(hdw,fh->pdi->config);
>  	if ((ret = pvr2_hdw_set_streaming(hdw,!0)) < 0) return ret;
>  	return pvr2_ioread_set_enabled(fh->rhp,!0);
> 



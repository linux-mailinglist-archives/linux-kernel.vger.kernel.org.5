Return-Path: <linux-kernel+bounces-29318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69088830CBA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1766F1F23A36
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477EA23772;
	Wed, 17 Jan 2024 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0oYnXSL"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B2D23740
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705516173; cv=none; b=KH0gbBMMpxYsRvmtBIZqrNnPPB+eizGESaGMbuWj3NKQWwXOx89/lfoYOgRy0QChsA25KZMvo7GqheB897BXLEqr/yCTEfSSJ69UqmXkQl6bJwMc0a6NiUmwdEV7zqeFknR5fW3dxno6+nw8cjeLIrrtN0OAul/9edTMoqRYOQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705516173; c=relaxed/simple;
	bh=NKJzAGMTjmX6AJ4hIIPadTkV/7o1t5YMO9AXpY/s8os=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=b5T1KtXSF4/BsdkddsAYjXlBq9PSO1I3iPpnCDawZmEkDAowvcNq5VpYnzNGtEm/+6J8PmPnCmA4BnocTeCc6XZRyTnVh4a3MLbUaYWtsoDc2S4OixyUDlZAnyaHZbaXgRAFJew09wsKI7Ko5utnT4/n4xdXpsfsa52+gR2JaRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0oYnXSL; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-337bfdb6f84so341996f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705516170; x=1706120970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QFL3eWOWcPqZNo2s58S+9S3xnanXM1ein8C5AjX/+0=;
        b=l0oYnXSLSkKwkyAPHCCRjmoHIaSthzjTD+t+emDRc0wwhLYqspDnFAjyFUQVlVOxhA
         aDuzY4NnW0jgN32v/FwFszO3XdwJYCg/pC0LXzwAisAjjnzfrBL6jkZfV8MOFmcqb5zK
         xAuxdlSQVcLBjoVxLCu89K+dIq+0VFTM0trVrIvyiNsNcAWGYC8J7yIDM+mLdbENr5RU
         Zq4jWmseN3wi8WLqhqFu64V/g4yiqyAJSq/w1NwQmkScV9A7kiRxqoWW7RYW72F1csRX
         yp/jK2rbBocT1APwRvvngy5oNwnwVf5vPRi5Q/fFyJBAi4oQyax0lHhhau97hk9k5xQx
         WwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705516170; x=1706120970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QFL3eWOWcPqZNo2s58S+9S3xnanXM1ein8C5AjX/+0=;
        b=wBTwA8T4M5OjPg51VWbh8jboT9oE9taOze+1HpCMmyAUi+K7DQANyIBlUZLxeemCDQ
         wZnAg3LYXXSQBdhP5cp+1M0O0umS8VrhRXYcTQyAh6Bdwyeo9DU3ffF7SUoK1NVKLthU
         2WuNScBZfrOvrB9/T8xiRwNyVOrTiXxK2lciiKGoCpnZnZZSHZ4cOTPu/yp12G2fgLas
         wxXJ6e7lUR6p3WM6RsVjT4m6vOT+4WNOheg5sMOqMjdavrNax6l3CW5bQ1GL3/+0imNX
         XBMI7MTAxUtTGr9DyRJp1MjGRCexfkVNoEJ95JZlofWaDMel8VELHXXn/XJyHYsPD5ME
         sc6A==
X-Gm-Message-State: AOJu0YzCVPBIZRFemgPLm2msvli/xzZXJ0ADpIFhHe8fwuREr3VLFqM+
	Wjk7w9DT3f69PRp2LCIGzd4Kd4Ygqs5t3Fm3KRI=
X-Google-Smtp-Source: AGHT+IHNqXM7o/4tSHP3xjfmLSIh27KUOvlRAHgM25oVq7qUlilsjoyTf814/vbyM3nqrWk6rINUoNESV6QUI8xbRfI=
X-Received: by 2002:adf:f0c3:0:b0:337:b74b:76ee with SMTP id
 x3-20020adff0c3000000b00337b74b76eemr153013wro.7.1705516170355; Wed, 17 Jan
 2024 10:29:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117031212.1104034-1-nunes.erico@gmail.com> <20240117031212.1104034-7-nunes.erico@gmail.com>
In-Reply-To: <20240117031212.1104034-7-nunes.erico@gmail.com>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Wed, 17 Jan 2024 10:29:02 -0800
Message-ID: <CA+E=qVccx7XOMUJ04ZVefhNHrNjxCL=-dFHAcmOKMR+aYOJmcQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] drm/lima: improve some pp debug messages
To: Erico Nunes <nunes.erico@gmail.com>
Cc: Qiang Yu <yuq825@gmail.com>, dri-devel@lists.freedesktop.org, 
	lima@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, christian.koenig@amd.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 7:12=E2=80=AFPM Erico Nunes <nunes.erico@gmail.com>=
 wrote:
>
> Make the messages more consistent by showing the pp name.
>
> Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
Reviewed-by: Vasily Khoruzhick <anarsoul@gmail.com>

> ---
>  drivers/gpu/drm/lima/lima_pp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_pp.c b/drivers/gpu/drm/lima/lima_p=
p.c
> index ac097dd75072..d9e178d6645d 100644
> --- a/drivers/gpu/drm/lima/lima_pp.c
> +++ b/drivers/gpu/drm/lima/lima_pp.c
> @@ -197,7 +197,7 @@ static int lima_pp_hard_reset(struct lima_ip *ip)
>         pp_write(LIMA_PP_CTRL, LIMA_PP_CTRL_FORCE_RESET);
>         ret =3D lima_poll_timeout(ip, lima_pp_hard_reset_poll, 10, 100);
>         if (ret) {
> -               dev_err(dev->dev, "pp hard reset timeout\n");
> +               dev_err(dev->dev, "pp %s hard reset timeout\n", lima_ip_n=
ame(ip));
>                 return ret;
>         }
>
> @@ -423,8 +423,8 @@ static void lima_pp_task_error(struct lima_sched_pipe=
 *pipe)
>         for (i =3D 0; i < pipe->num_processor; i++) {
>                 struct lima_ip *ip =3D pipe->processor[i];
>
> -               dev_err(ip->dev->dev, "pp task error %d int_state=3D%x st=
atus=3D%x\n",
> -                       i, pp_read(LIMA_PP_INT_STATUS), pp_read(LIMA_PP_S=
TATUS));
> +               dev_err(ip->dev->dev, "pp %s task error int_state=3D%x st=
atus=3D%x\n",
> +                       lima_ip_name(ip), pp_read(LIMA_PP_INT_STATUS), pp=
_read(LIMA_PP_STATUS));
>
>                 lima_pp_hard_reset(ip);
>         }
> --
> 2.43.0
>


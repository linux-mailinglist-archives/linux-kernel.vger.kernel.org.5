Return-Path: <linux-kernel+bounces-29308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6A6830C85
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308B11F23D01
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9BB22F00;
	Wed, 17 Jan 2024 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vx/vjEiV"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870D522EE8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705515247; cv=none; b=JeB9KxeUcCyNev0g/QLyJ2u/zEKWuq1vIwt6SOSlZ9vgqKnz2Z3Qvs8+vNf7/m69oOYYUWEgeDJGldBkbbesHsgy74wRC39JcW83XqUQc3EpSEqlBpRoneFSH8RnEliKQVQAWm1wudZuE5XaJ+BTtTCvV4CBVMM1gGMZyr4tkGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705515247; c=relaxed/simple;
	bh=UX+zKO+t9KVEVKdLfYBXCezdmF7+OzS1BjFfN5LtsPs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=tiflOvFKYRlqcmMcEez6nnQb4QhO8bGBQ7zp7Pcan2YsXzKIsabrH6PR6MLzQRceLMuTyKOvDzf4FwgGP7FQp9XTA3HtRdC6ZeDuFZZUqY2cZ5+JYf0ojCi+RrcG3GVI3EVS1nQc1v7LJhINpEJ3VqsZJv5Xtke33u5taNH6Q+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vx/vjEiV; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-337bce51c67so347886f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705515245; x=1706120045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ah6G4FuJVDtGXNTGJe0RwSbK/PDR7s+N3OBq9omTPlE=;
        b=Vx/vjEiVp/LPwGSxRqTynS4E8klCzchj8EQoaRCzwHqQcqbKBHj07tPijqvf48qcRw
         fVs4itqocvc0Knlcgl2omn1VN1Ce8M5i4jhXtGOfmKs4o5uyaZVxHQB+HHffSikYk8J3
         pg/b5kgkeUj5CKGX6TKXfwlbQWXIFs4FfWURkyp4QMLvI/P/1U7EkfVaxtwEWNjuMaWo
         RKSWqzsh1wVWN550X+ycAlbq0LBqbypOB8jA1NqjuPof2omG0n9oe/zLSYqEg2J1tpzp
         +FpBmSA9q9+7ctnvj39QglBgVxQTRg9pZFb4tNC5CDCXZDu6ZU8uTGQrIc98ZCvi5Wtj
         K3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705515245; x=1706120045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ah6G4FuJVDtGXNTGJe0RwSbK/PDR7s+N3OBq9omTPlE=;
        b=NBg/HlvuzpuEiQmp1KY5pf1P4qkV/5IlDulSZjdhkTFqJ/cdsL1WNlqDcfOEGAbSho
         1VpsjuIsEPcax6aXPXe25MRL+MWZV7tkUlI2T5okYb5fc9lYVipKN/qud4DdPZwKXg5M
         eg07ehuOG/iroqjjG8U8l2+Q7si3tJFsOwP5xobamulU2wio5i/darPQNO+f8AYrfKis
         hKbYcxwA+v5AhxZMaJ1BqwZOjuBDXtXH2ze696pchRwv2KdLofEcFKsQhHsyQ4ApOIO0
         O54gkVucsV9E8qPLLpF0Rrgeoqx7v6R3sgLwQlycF1+N4aHZ8ZxMhG+1YyeM16F/YHu3
         2udA==
X-Gm-Message-State: AOJu0Yy3Nx6cLRX6ZAuUJe6Hw3WYr9y1w/Y+gvoBzkR4n3IANvV88bn9
	yW1lIsnmQixUGiSqe6wqXxk9IZc5ctyTLIi6e0g=
X-Google-Smtp-Source: AGHT+IHvJb7g3OZLRLqDFnVSe+upbeblv1HtgvAe/9r7raV1xd+t01Wswklkic/eecuwd2GSzJOnnPazUFbrwwEMIbw=
X-Received: by 2002:adf:e906:0:b0:337:bfa2:8d4b with SMTP id
 f6-20020adfe906000000b00337bfa28d4bmr2925346wrm.4.1705515244592; Wed, 17 Jan
 2024 10:14:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117031212.1104034-1-nunes.erico@gmail.com> <20240117031212.1104034-2-nunes.erico@gmail.com>
In-Reply-To: <20240117031212.1104034-2-nunes.erico@gmail.com>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Wed, 17 Jan 2024 10:13:37 -0800
Message-ID: <CA+E=qVcDynxk7E9+TwR6Vu9bhCHU-3WnGVk_170EFbUWn+0Adw@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] drm/lima: fix devfreq refcount imbalance for job timeouts
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
> In case a task manages to complete but it took just long enough to also
> trigger the timeout handler, the current code results in a refcount
> imbalance on lima_pm_idle.
>
> While this can be a rare occurrence, when it happens it may fill user
> logs with stack traces such as:
>
> [10136.669170] WARNING: CPU: 0 PID: 0 at drivers/gpu/drm/lima/lima_devfre=
q.c:205 lima_devfreq_record_idle+0xa0/0xb0
> ...
> [10136.669459] pc : lima_devfreq_record_idle+0xa0/0xb0
> ...
> [10136.669628] Call trace:
> [10136.669634]  lima_devfreq_record_idle+0xa0/0xb0
> [10136.669646]  lima_sched_pipe_task_done+0x5c/0xb0
> [10136.669656]  lima_gp_irq_handler+0xa8/0x120
> [10136.669666]  __handle_irq_event_percpu+0x48/0x160
> [10136.669679]  handle_irq_event+0x4c/0xc0
>
> The imbalance happens because lima_sched_pipe_task_done() already calls
> lima_pm_idle for this case if there was no error.
> Check the error flag in the timeout handler to ensure we can never run
> into this case.
>
> Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
Reviewed-by: Vasily Khoruzhick <anarsoul@gmail.com>

> ---
>  drivers/gpu/drm/lima/lima_sched.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lim=
a_sched.c
> index c3bf8cda8498..66317296d831 100644
> --- a/drivers/gpu/drm/lima/lima_sched.c
> +++ b/drivers/gpu/drm/lima/lima_sched.c
> @@ -427,7 +427,8 @@ static enum drm_gpu_sched_stat lima_sched_timedout_jo=
b(struct drm_sched_job *job
>         pipe->current_vm =3D NULL;
>         pipe->current_task =3D NULL;
>
> -       lima_pm_idle(ldev);
> +       if (pipe->error)
> +               lima_pm_idle(ldev);
>
>         drm_sched_resubmit_jobs(&pipe->base);
>         drm_sched_start(&pipe->base, true);
> --
> 2.43.0
>


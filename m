Return-Path: <linux-kernel+bounces-70015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 501608591C9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B43C2824DF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 18:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FFD7E0E8;
	Sat, 17 Feb 2024 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="uOrJmrNR"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96D16DD1D
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708194956; cv=none; b=Ods3lEMwIwxIMheECJLczt4aYx+JdFciOqoYQivfi9He/qVzLEPTbM7aIYYXfxlZkYS6MSZN8T9MazrIeDB29XYBU+AiPJYQYy7mwVidjdCqxJWo7lzL4U+4H7lr5ZmFcO0Bx43dRTQCRUaBcP+Hd9KrV324bPpt6bE5SwluF7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708194956; c=relaxed/simple;
	bh=1wXUHXHyq2tnpbAbYVAELt55zyGXrlOlKXd2MP2w1h4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLE16j1FrYFXK/jZX3a3MWeYN1MzVSUwwmK+AfZKXuENW5ALTWyXLHF/+8Y/w4ipLw3jz0GJZ7z81ufFLqhmfa96nmrlZDUFsTSKmCD3SlsSrxhMA5PaJJB0EcV1Hti60BQ7PEaDG4xpUJzxPWzqvB1AXVjsbvMsvdwYWS9O5SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=uOrJmrNR; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4704c69a3d9so3380137.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 10:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708194954; x=1708799754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vk9hxovM04MFGDknCtAXhj6QKEuZtEiEa4FrrltAbFk=;
        b=uOrJmrNRqVPEHVxhY0916eSLnrQ8cxhGo6rFu87bXGDnsNLnMaD5cZZbS8pHn7E4OC
         ZHbSc6DUbrxaa5PmlfaJ3UIXQ0TMuqFswS0wESL9f3NIZnCPo8PwgLjbzO6dRX2DTKVO
         Toc6x0pd4n4pGZcQ4BKga7gZeDG9mPbTlYONpjaJrbq3BFzi/eU1UrNWypsiSRIbisI9
         KX8wbj3N8F2qkT55P7f9vJqlXVe2G/DLDtDCeg8uAV7kvSrBdEBY50kEZ7odK7fObfLX
         CBM9QNgYPqPhuaXliSjvUTAWD75ggNiqAHhzMd4kKNreVzHtWw2gk9dOA9h3/4AflDVA
         XuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708194954; x=1708799754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vk9hxovM04MFGDknCtAXhj6QKEuZtEiEa4FrrltAbFk=;
        b=R5nXEwI7hQAx2cEHxkEg3dST2Xk+9/PsOHuzPA27oU8XpE05Dd4I/1Nggl8XEjVvnr
         FNPPl/Ery6dfnveZgnctEv51GyxiEw8YgjeSa0gbT5XUsDpB+uK8NA4RdQhMEu7o1gvf
         L44uSNf2o8xZaMiJpxpsC9fH2Yqc2d+Nk+d9m3hlNpqgScCb4UUhFlGLPIr4dhXByvdf
         VZqSmY7vpGLC61kbR99zENkpiO+YOB07yBBjFCjWaGwpW1L1cOlsETlEETkkxQIH5ifR
         fZfu1/iv6FyffdK60Wikie3iyOIYDuVA9InADNAGne9TnBDp5PyLlkuVNO9yS6nVkTG3
         sQtg==
X-Forwarded-Encrypted: i=1; AJvYcCWgnox7+aNEZt+PLil1Q5yeylolVR7pEN9yeCKEAJXGDkIxxSoQffpsxRPD77GazjfFe5BKHXoE33YYFzYZcI+DHyL2KlKpQa0hamNt
X-Gm-Message-State: AOJu0Yx1EK670sLZhntWWmujVOmYks5hOyIHm0mPQqpT+EOa3ydectmv
	pGgHNtd3raMZmxHP95N+2Xppl8vWdP8wJgp+HF445LjBBtJw22AZ5OxT+BLhvYDfNJty9GGxayC
	1W3MiyHDJiXAtpj4aYxvQZgo30cP5S+UCbdKRMQ==
X-Google-Smtp-Source: AGHT+IEE2e5PqfvrP9qVLvCFjih0+BMjKLKf+gSSzgOk6AJcsbIJqFQIl46fzwx6F8ihh8DAIJvKPD5uyKKwtmptSQA=
X-Received: by 2002:a05:6102:a4f:b0:46d:2956:6b11 with SMTP id
 i15-20020a0561020a4f00b0046d29566b11mr9612132vss.16.1708194953955; Sat, 17
 Feb 2024 10:35:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217135255.1128716-1-xiaolei.wang@windriver.com>
In-Reply-To: <20240217135255.1128716-1-xiaolei.wang@windriver.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 17 Feb 2024 19:35:43 +0100
Message-ID: <CAMRc=MdGhfHSWPB0FCHbK+uA0MAZNFstupgm7-Zkw9dbuTmyVQ@mail.gmail.com>
Subject: Re: [linux-next][PATCH 1/1] gpio: Delete excess allocated label memory
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: linus.walleij@linaro.org, andriy.shevchenko@linux.intel.com, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 2:53=E2=80=AFPM Xiaolei Wang <xiaolei.wang@windrive=
r.com> wrote:
>
> The changes in commit 1f2bcb8c8ccd ("gpio: protect the
> descriptor label with SRCU"), desc_set_label has already
> allocated memory space for the label, so there is no need
> to allocate it again. otherwise memory leaks will be
> introduced.
>

No, we *want* to copy it if it's not in .rodata for the same reason we
introduced SRCU. This may be a valid report but the fix is wrong.

> unreferenced object 0xffff0000c3e4d0c0 (size 32):
>   comm "kworker/u16:4", pid 60, jiffies 4294894555
>   hex dump (first 32 bytes):
>     72 65 67 75 6c 61 74 6f 72 2d 63 61 6e 32 2d 73  regulator-can2-s
>     74 62 79 00 00 00 ff ff ff ff ff ff eb db ff ff  tby.............
>   backtrace (crc 2c3a0350):
>     [<00000000e93c5cf4>] kmemleak_alloc+0x34/0x40
>     [<0000000097a2657f>] __kmalloc_node_track_caller+0x2c4/0x524
>     [<000000000dd1c057>] kstrdup+0x4c/0x98
>     [<00000000b513a96a>] kstrdup_const+0x34/0x40
>     [<000000008a7f0feb>] gpiod_request_commit+0xdc/0x358
>     [<00000000fc71ad64>] gpiod_request+0xd8/0x204
>     [<00000000fa24b091>] gpiod_find_and_request+0x170/0x780
>     [<0000000086ecf92d>] gpiod_get_index+0x70/0xe0
>     [<000000004aef97f9>] gpiod_get_optional+0x18/0x30
>     [<00000000312f1b25>] reg_fixed_voltage_probe+0x58c/0xad8
>     [<00000000e6f47635>] platform_probe+0xc4/0x198
>     [<00000000cf78fbdb>] really_probe+0x204/0x5a8
>     [<00000000e28d05ec>] __driver_probe_device+0x158/0x2c4
>     [<00000000e4fe452b>] driver_probe_device+0x60/0x18c
>     [<00000000479fcf5d>] __device_attach_driver+0x168/0x208
>     [<000000007d389f38>] bus_for_each_drv+0x104/0x190
>

Can you post the full kmemleak report for this, please?

Bart

> Fixes: 1f2bcb8c8ccd ("gpio: protect the descriptor label with SRCU")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
>  drivers/gpio/gpiolib.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 02be0ba1a402..32191547dece 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2250,12 +2250,6 @@ static int gpiod_request_commit(struct gpio_desc *=
desc, const char *label)
>         if (test_and_set_bit(FLAG_REQUESTED, &desc->flags))
>                 return -EBUSY;
>
> -       if (label) {
> -               label =3D kstrdup_const(label, GFP_KERNEL);
> -               if (!label)
> -                       return -ENOMEM;
> -       }
> -
>         /* NOTE:  gpio_request() can be called in early boot,
>          * before IRQs are enabled, for non-sleeping (SOC) GPIOs.
>          */
> --
> 2.25.1
>


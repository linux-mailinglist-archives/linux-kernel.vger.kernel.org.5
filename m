Return-Path: <linux-kernel+bounces-65286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA12854A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458D01C26BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED59454BC4;
	Wed, 14 Feb 2024 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQPLlEvm"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C0153E3C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707917980; cv=none; b=RCiLHlqHab5HR8TQCTDwRx+uaHUQy8z/OcNseChktQB/0aVAP35g2tsIy1+glIB6f2/z52AXlw+CY86uiw9qeptDM5OJxtPCvq0TbsRLGezxZChP0jql0VGRYdMAgCQI7G1J2T7N6bmQAHAGC01abOqa5wXQCH1+H/LIeKB0BrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707917980; c=relaxed/simple;
	bh=0p4gLpow9ODBVhT7rbvMHc32etHvvVKkrTS0A0Bu790=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1qp8f67sGvUAbuuCZOJg2yVrrRAhrpE5ZOcTbPeljvjH4sL9tbMKRoSLBAVF08GrjVEYkoLg9sJcE+1vNv/Pho3Mqrx//2NdTOgOkgE4AfmLOW0r3kToQzL+F4pRVzBtEHvTzT5v0+L4EWfEzcahQz6BZTrrnO+CiueDbxc9jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TQPLlEvm; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7ce55932330so2198997241.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 05:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707917977; x=1708522777; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hxk2QHryF0684oJe0zT3tMOoh3bLl3aVrRy/Vtj394A=;
        b=TQPLlEvmvLJ4ZVScEkhV/RrJSd8/J+iRK/Qqo7IBAZtJwHUU/W7PZlkVTckudlUGed
         IKVGWb0G1OaoxA3PzVHLwXswj/zYLqxZBBM8s/4vLPMRoF240GBx8debyIafgk7eRPUy
         /9AFf2YRoouf/YJgMNEM2NuQjkHbx2JMRtjGZBuT02QEOSuoNvv56NxY5CaSN8ngQmpB
         EPrx6+JaHEu2JI0m+HqvRe4t/LkEXSgI/uCzkgS/UI1e2RCcVbRIpFIJa5xfG4iAq8ue
         SYJVzuF7OINO1iDs60Xn9/9H7OYMedGBkJdH76sGpsDhgMh6NDJyKaHs0C1ovE5Ybaqh
         H6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707917977; x=1708522777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hxk2QHryF0684oJe0zT3tMOoh3bLl3aVrRy/Vtj394A=;
        b=mpev8U6mo12AZcHIeNtCHsFH1Y5NYsVDamxK8hVllrIMj63bb1+UebeJmoW+nxAJLi
         YBsTBKNK9o/CPU+WS1fQi+BYCC9lgXfux/48hP4P10LeLgcZCls0gYYIV06eAEU58jxc
         Tnl+6hijouFM5qn+BRpslMmsL8E4kInAOcKsQIzpuYfe/ltJOxxhHubi4RD0I0ylOx4t
         zDtDU5mvZj3hOPCI11uRfwfkzgWcgl+zbfCYxv/SbKvArPooTUabjbs7IqOVWFcQFoAV
         w2ZK5xH6Bv3FWjsFbEgixTtnse+pfJeDYA9SZZPdMVig0jJGvBBgeCM3EL6aIO99SZIE
         zv3g==
X-Forwarded-Encrypted: i=1; AJvYcCViwRjK8gvvNQaEd+aKu8vBkXXMYTq46wYpyo3MMy6XOwD9+X65ZA78AAOIdZ/X5jSRFTCNdqcs5B4ZK71ytkW9nPWHWz2DwrTXL97k
X-Gm-Message-State: AOJu0Yw+Y0n8Pm4yv7Fknc22jyGpxwk0VSc4YXllQHxmnFP2cytAmYlY
	E3GCxHXHKKdRA5dcOSXm1kbzhm16hVCBn5yJuN/7vmN5a7fCXcFvGTHysXI4IoUVTB10T6o1q7S
	6nY5VSXZ68AAD+u8tW2XTHR+q4MztOyYdNaEuKA==
X-Google-Smtp-Source: AGHT+IF38GYfAcxmAvECepxPLITJnTr14rDak5x45d+K3zUqCIqoFTfoRVF9ex0WatJpgOCn1dMHMNAu/Yu0+3hXpDY=
X-Received: by 2002:a05:6102:2277:b0:46d:6df5:9952 with SMTP id
 v23-20020a056102227700b0046d6df59952mr2350095vsd.19.1707917977591; Wed, 14
 Feb 2024 05:39:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-bus_cleanup-tee-v1-1-77945ae1a172@marliere.net>
In-Reply-To: <20240213-bus_cleanup-tee-v1-1-77945ae1a172@marliere.net>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 14 Feb 2024 19:09:26 +0530
Message-ID: <CAFA6WYPdq+DLxX7-4uVBVt7Xcta_ueHd477dfcnQUKWTvQ=0kg@mail.gmail.com>
Subject: Re: [PATCH] tee: make tee_bus_type const
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, op-tee@lists.trustedfirmware.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Feb 2024 at 20:15, Ricardo B. Marliere <ricardo@marliere.net> wrote:
>
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the tee_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/tee/tee_core.c  | 2 +-
>  include/linux/tee_drv.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 792d6fae4354..e59c20d74b36 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -1226,7 +1226,7 @@ static int tee_client_device_uevent(const struct device *dev,
>         return add_uevent_var(env, "MODALIAS=tee:%pUb", dev_id);
>  }
>
> -struct bus_type tee_bus_type = {
> +const struct bus_type tee_bus_type = {
>         .name           = "tee",
>         .match          = tee_client_device_match,
>         .uevent         = tee_client_device_uevent,
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 911ddf92dcee..71632e3c5f18 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -482,7 +482,7 @@ static inline bool tee_param_is_memref(struct tee_param *param)
>         }
>  }
>
> -extern struct bus_type tee_bus_type;
> +extern const struct bus_type tee_bus_type;
>
>  /**
>   * struct tee_client_device - tee based device
>
> ---
> base-commit: 716f4aaa7b48a55c73d632d0657b35342b1fefd7
> change-id: 20240213-bus_cleanup-tee-c25729bbcd7f
>
> Best regards,
> --
> Ricardo B. Marliere <ricardo@marliere.net>
>


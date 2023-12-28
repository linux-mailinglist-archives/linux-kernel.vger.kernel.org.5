Return-Path: <linux-kernel+bounces-12853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCDA81FB30
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 21:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487F6285A81
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 20:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF5D10794;
	Thu, 28 Dec 2023 20:24:04 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3BE101ED;
	Thu, 28 Dec 2023 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dc003289c9so223436a34.0;
        Thu, 28 Dec 2023 12:24:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703795041; x=1704399841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ugN4oQ3rWS+8GWMKRKVQ5GkIvF2T6X168Tqr2Ab1pk=;
        b=KsyzaJwQQdhg+XuaRAJdb6R//dIrkTGHswq6vdXeKOg+428XU7R6bPXXHo3LhD12rX
         G8NuVBx+ts7SGQRRsOwjKcFr2YUialiCqNhbWAmxRdkrjMxkdYQ5Gyv8kLDUx3pjOVtI
         Ycj8ChE6Iz0gTgg1TIXDQon0FzPUtkwSNGlNIUTc7xrTIEUZkmFrFWD4X4k7ugLmqBCc
         p9nsRP7TzrCudhi6VRcfX6Bu5eazFHH7CgQ8knT9VCLTObrWVIAqRlMVhTqbpFkzq5nT
         YCJBi8zAxd+puUWgFAjxubEqCrcHrhP1Jk0KQ7UNQwTtItsrU9i+Iat5h4WmTPKYQUlq
         UQLg==
X-Gm-Message-State: AOJu0Yz6wHtBselkdhdCPEIFLbjdUbnwC9N3TE8G100VHFtj3NlpniPW
	8dT1odljNSwCmwgO01P++SH5BuQRfK2LZ2XnJPg=
X-Google-Smtp-Source: AGHT+IFoq+zGp044cNWOxdS1M2F0J58NFQ8eSAEUyobjb9nwFf8vup8dJpcYo0nCK2cOerIPzvmT/h6O8wHjbBQJXps=
X-Received: by 2002:a4a:ce87:0:b0:594:ec5f:f697 with SMTP id
 f7-20020a4ace87000000b00594ec5ff697mr3383899oos.0.1703795041246; Thu, 28 Dec
 2023 12:24:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228103921.23839-1-di.shen@unisoc.com>
In-Reply-To: <20231228103921.23839-1-di.shen@unisoc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 28 Dec 2023 21:23:50 +0100
Message-ID: <CAJZ5v0jYX8QJjFzOTSWFf7PnBP+twm3Ww+9MVqwAsJrPx1fycQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: export the governor register related API
To: Di Shen <di.shen@unisoc.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xuewen.yan@unisoc.com, zhanglyra@gmail.com, orsonzhai@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 11:39=E2=80=AFAM Di Shen <di.shen@unisoc.com> wrote=
:
>
> To enable users to register their own thermal governor,

Why would anyone want to do that?

> this patch
> exports thermal_register_governor() and thermal_unregister_governor().
> This change would not affect the registration of the default governor.
>
> Signed-off-by: Di Shen <di.shen@unisoc.com>
> ---
>  drivers/thermal/thermal_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 9c17d35ccbbd..56695988e20f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -167,6 +167,7 @@ int thermal_register_governor(struct thermal_governor=
 *governor)
>
>         return err;
>  }
> +EXPORT_SYMBOL_GPL(thermal_register_governor);
>
>  void thermal_unregister_governor(struct thermal_governor *governor)
>  {
> @@ -193,6 +194,7 @@ void thermal_unregister_governor(struct thermal_gover=
nor *governor)
>  exit:
>         mutex_unlock(&thermal_governor_lock);
>  }
> +EXPORT_SYMBOL_GPL(thermal_unregister_governor);
>
>  int thermal_zone_device_set_policy(struct thermal_zone_device *tz,
>                                    char *policy)
> --
> 2.17.1
>


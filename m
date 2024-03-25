Return-Path: <linux-kernel+bounces-117126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADC688A7A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3463006AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71431422BE;
	Mon, 25 Mar 2024 13:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wp5VY1Wf"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737BB129E6A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372729; cv=none; b=MJKejnre+en7lEF3AWDUvk3KevqET6T05hBQaNxtEoo/Wkjbr7Bh6FyqB6VwtpL/xCc8IHUNn1IxETEZQ4tdELwC8eX7gEU1ux3thmN93JvOxImhP3kZwoeNxesp1SW9QhCg4yuDP9Z66DM9FcBSJA5JsE9scCQcLLfXmPMbpSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372729; c=relaxed/simple;
	bh=/jRdDNHwSEGE3CvNzenljKZrdw33DtVzFmmgraXk5cY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQ0vkVbktIHvMDta5fuhl9ESfEsrRDucQedDDjMXtLNtOO0j/oJC/4Ad9hY+ztaXEAGWlQ1fCTz3n4c5I7X05l66Uzk67F+Z0Uh3ySI5PeT4z/fS99gtb4N1zUIrtyfeqI+CxTrI7DEqVUXVJpie+E3MKvIEEfIu8ByDMyjE0vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wp5VY1Wf; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-611639a0e4eso4886417b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711372726; x=1711977526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NYNXzQvnM81GzIL8Aewj9RD25qOiiYInoW3gilEhTKQ=;
        b=wp5VY1Wfm70k4P17Tw+z04AGasIDMo8le8mXybAqh7q05xF6b43soDEJche7GjyrGk
         ZdVTSLKAdhBfd51jqnssMcnm+YmiMOpF9E0L7M1ub951czdx2t8RepjY8Hl1c1NsL7ut
         kQOW9b2X9J+Luf8uRCqfF96Esywug2hJIrN5lnGqtYVI6nl4fxeOD7gl6uaPAFsSivzZ
         CGahPOSapX95UdRhxHxq7qbRv/rz+nAAgnKeMp/lWkt+Cm+Z1djEt23gyIINv9ihsnO/
         0+TeRZvfqYnf5EeWVAAS27varXrirHOfVkmmY1d6Saahrf6VjxdAydZdhHoV8gbT0qsO
         PSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372726; x=1711977526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYNXzQvnM81GzIL8Aewj9RD25qOiiYInoW3gilEhTKQ=;
        b=C3DCIMt6Rri/xLbUs/FK/ZE8FzZ8DMHmRjlLDV+EPW8Mn00osXn/8aT61THAjLMfF6
         AvTtX4jr8SYX30bnH2GiUxKYCbBT5KLmeSef42DZ3dxz8zt2MWBmGgGUvAfDetMOZC9r
         8cQS1VnJSaNCxTwAqV8+lupEArH51XLd47RrsIgklQ962vetF0in4H5S76otFJ6JMJV/
         AE+WhGVZBjW9/fbi2xbFpCvOwlj+hHfRVIMGGrMpJ6cm2H7mugANZDWVMuPFajq2JTjy
         UqLan4EPQf+ePIs2Fn7vOykMFFjw8ddmbFYKziq730HfaksN3WU0hJjhA2zImnpgov2y
         seIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwy49WwFuhkdOksHAdbGuo8uVRkRsylE8fvW0MqHfKAGzinDnEjre/hM1qiWYfwRycGAzR8P69BqLmmRAGN37lUvbc8JSJ9A8DxGEE
X-Gm-Message-State: AOJu0YyKAZNw7Y8nxu+HY+ZZQqHpUs43wXoUH/5QP9Xepp5AOL7CO664
	EacTs7rKH8/i4yASdYy2P8o+MlDqyRzvOMwmn4BFZmQ9GbAHCGs0xKXYoci0+1uJzuYpb/Pdw4L
	44UJtPisPxgpwTJ09IG1t32Lw8NW77ZsGuoJoKffOefUiya+X
X-Google-Smtp-Source: AGHT+IGozDfzk/PpYVV3Podxdbcg3FDTwqthJMX3zLNj8qanWGweFd7Xrq4deF/MtbEaepC9/bmv1+SARlRLK2BDQog=
X-Received: by 2002:a5b:5c9:0:b0:dc6:ab85:ba89 with SMTP id
 w9-20020a5b05c9000000b00dc6ab85ba89mr2862877ybp.25.1711372726409; Mon, 25 Mar
 2024 06:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307114600.3643948-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240307114600.3643948-1-andriy.shevchenko@linux.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Mar 2024 14:18:10 +0100
Message-ID: <CAPDyKFrKBiR7vnqPj_0iaAcQu9v0hdn0FHdGLgeCS3ZVYPdodg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: core: Remove unused of_gpio.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 12:46, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/host.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 8f8781d6c25e..48bda70145ee 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -13,7 +13,6 @@
>  #include <linux/err.h>
>  #include <linux/idr.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/pagemap.h>
>  #include <linux/pm_wakeup.h>
>  #include <linux/export.h>
> --
> 2.43.0.rc1.1.gbec44491f096
>


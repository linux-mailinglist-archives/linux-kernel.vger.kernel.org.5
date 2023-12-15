Return-Path: <linux-kernel+bounces-1266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94EB814C95
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15A11C2384A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728C33A8D8;
	Fri, 15 Dec 2023 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+q8FDOv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A331D3DBA2
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40c3ca9472dso9101615e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702656665; x=1703261465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oiYfNucyGrJK9+Fismuk7ieCgUCyCPw4k2hNnP6Ge6o=;
        b=Q+q8FDOvOPYDVmfBOa3BqjkZ0Cz1nJjJTIQwB9Z70mqq2un9Gt6kn7RqUiABy2aup7
         4xEDTOigPSXcND5uQMTV5NyHPcLm1McJMdLwOKLKFP8wAGZedWSrau7m7X4w3JXmrMyh
         NvEDTlRtOFAIdJ2E1YzhXsOFOrsPiTaJTcXvdQfZ5b03JgkTnuMXvbQVcjBa6L4mg/zy
         nTZlJk24wBE0DLgtTTOOv4+uvhRoHfsKwfsSQUYquLSoErniUVPp/1Mz76Dgm08XLQ4I
         K5tAOUXty6S83pI5/ikqp8gcDzUQEHQi6JSoVJTe7a5xbWLQvBxxiFr+a9yTZMKp7FDe
         8lRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702656665; x=1703261465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiYfNucyGrJK9+Fismuk7ieCgUCyCPw4k2hNnP6Ge6o=;
        b=ZjjfsiQ7WPiUS/WxM0m1VuDZuCXtpCElQ5R+ug1eIHEJCmPli/fR+/i0qpeNX51Z87
         AsIJD2q5NxZyY4miz7MfaXLBjAaMh10lwanWJMXhsZ+0fPF0LGI+iyhQYWe8rdRq6U2g
         nLZ3gi0JeKvzStXHqo7KY6/1hAcfTSKPsAo4zO0fS9loeIHlNdZ/oZVeVa4d9a8Dk7LL
         pnilS9LwruCI4FfE91wuRl80VVfD4JYjGXLaRUWrvs9/28yT8s4RWiAiRqE8j5O+ddbK
         m8CUBQH8DmLKmEHelOsgqDnXe3mrYUQD8ldqwALljVtXQCOT8O2SIWXxZ9EsPjETzmz0
         PgLw==
X-Gm-Message-State: AOJu0Yx77CxMsIVAayyZDWp0vavakk90keVEdWAuTcuYLHiI46X3DYfR
	rIWgIDktunbvzAryWzAk6ksgGg==
X-Google-Smtp-Source: AGHT+IE9/QpVqN2I8/3tKtSs5UIywuHjtuZECShg0SZTo046hup40+fbNNexXXT5wkPSCrngxFK7eg==
X-Received: by 2002:a1c:6a07:0:b0:40b:5e21:c5ec with SMTP id f7-20020a1c6a07000000b0040b5e21c5ecmr4187384wmc.186.1702656664783;
        Fri, 15 Dec 2023 08:11:04 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b00405c7591b09sm29759819wmo.35.2023.12.15.08.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 08:11:04 -0800 (PST)
Date: Fri, 15 Dec 2023 16:11:02 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Flavio Suligoi <f.suligoi@asem.it>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v1 1/2] backlight: mp3309c: Make use of device properties
Message-ID: <20231215161102.GA662726@aspen.lan>
References: <20231214195158.1335727-1-andriy.shevchenko@linux.intel.com>
 <20231214195158.1335727-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214195158.1335727-2-andriy.shevchenko@linux.intel.com>

On Thu, Dec 14, 2023 at 09:51:13PM +0200, Andy Shevchenko wrote:
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
>
> Add mod_devicetable.h include.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/video/backlight/mp3309c.c | 38 ++++++++++++-------------------
>  1 file changed, 15 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/video/backlight/mp3309c.c b/drivers/video/backlight/mp3309c.c
> index 34d71259fac1..d9b08f191999 100644
> --- a/drivers/video/backlight/mp3309c.c
> +++ b/drivers/video/backlight/mp3309c.c
> @@ -15,6 +15,8 @@
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/property.h>
>  #include <linux/pwm.h>
>  #include <linux/regmap.h>
>
> @@ -202,15 +204,12 @@ static const struct backlight_ops mp3309c_bl_ops = {
>  static int pm3309c_parse_dt_node(struct mp3309c_chip *chip,

Pretty minor... but I wonder if it should be renamed:
mp3309c_parse_fwnode().


Daniel.


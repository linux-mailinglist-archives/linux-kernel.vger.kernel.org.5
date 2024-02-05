Return-Path: <linux-kernel+bounces-53106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFC484A0BE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05551F23F07
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C527045946;
	Mon,  5 Feb 2024 17:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nwxhN6qm"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902C040C0C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154160; cv=none; b=kd2SJpJJVkV3jsob0YQMoUbHvZjamc4M5qwMQTNPo01jhiVxuE8mKem6ps97tQ+BJ6jFbjqpWjJ62nMeCPth96J9dSgpcTwcglOu6UVHnQlIk9x8rypm9ac8MXyXISUXa+vk5wNoyIxNVV5GiPmQqSYsllBFWFmaCmCYq1RtxA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154160; c=relaxed/simple;
	bh=es3DktGPBh05dwkx5i2qdiSJVoOY1idADTS2y6a37gE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HK5VxlvGiiLPTqwhGQSqXfnv3WfXNMm1MDeylXttwri1bXAujZkm/1Vv3y3SxcKFy9WuUq6fCeNrz1tUTetjvf7ctNLXmOnYu2R6CMF/qCbx5FbfuYrtU7XqEZnWjzaEaBFAbMYrrhqxwP2EUEmso0xTlIFcNi1f9B+zPpkMxdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nwxhN6qm; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60412a23225so44158857b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 09:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707154157; x=1707758957; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NinqwOuC4qMofgGjRx8zD+hwpAO/q3k3rjwTwr+rC8E=;
        b=nwxhN6qmGHJZIBTWuKOheB7TBrDLJKo5yvmWT4YrwDo7RZxz5gD7y8YIxLWO2IvJ+y
         XtEmRh77WfWvQofwWf70eQLm3b7oSNvG6Y3bCe4eGzZNl/DCC6Tqgyp/OeewEdP6fCem
         qJua+psTMqrE7DfJIA3AvSaxSHpSzHZDCu9xmEevhEuVk8dplvzh7ph+3l8q0gFJ1ADC
         RiDFFSGdZDC4ZhLEctdPa+LLfzJpeN56xtSv3IOJn0OGLLOoPDK7IuUHiMi5h3pVR3su
         2yRfu735FB61uU2lVKdL5qZ7soMbUH5qFEHeDTD0Fbtm14QOhOWXMJdM6CeqJ0Av5kLi
         ec4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707154157; x=1707758957;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NinqwOuC4qMofgGjRx8zD+hwpAO/q3k3rjwTwr+rC8E=;
        b=GEFCZ+s4TdSPLSwsb774Y0yiOHVG0ivXaIS0c3H/G6ef/Mr9wRSFR1SHnxROHC8YtL
         D6gGeE5J8iHRpfb7Zh87q7T9GIcVnA+rGSrOwgH4UlKXRl8Mj+ZM5qvBw2NyT0qgLE3U
         00i1GQZTIJsYoI/3fDhkcbTzZG/B38kOR87HSfVcmaiT6U991+S0n2puInmdyNGSZLI9
         Y902oPxWZTeJocComgKYgfB6uxyWNzobbsWAdvfxt90aAMFfwn5RcveLUt+MF+kceP9b
         SVRgoxE88AnmZpD66szcNbYJ9vS5F5J0jLfK1RNyKYOmSKCwNUvIwYWxBWpfXtZ//FUo
         44Sg==
X-Gm-Message-State: AOJu0YxwPSfVNmnnF2jt3mBSKisWKSUg6oBovwgmzyGQFrFGo1h8d/aQ
	66cmMoiVKkmxfzESuho5rdlu5dW0KJoyqQxxYqCsG9mHmKMyX0K0ZQ/Fz9X8nwGzqRLgTdbC3li
	f4vo/fMPfECw0c1F9jYeTO3DNrzPrkjtCLDWTwpGb1Tl7PTPD7xw=
X-Google-Smtp-Source: AGHT+IFO9mSeOm3Uy+itY0C+eVUHYH1eSpbF967sxuZKmQRI4cYGC/XH3XcvJFqRFVwgUMTe4eDN+Hg2UXv7cY+7tPM=
X-Received: by 2002:a05:690c:3686:b0:600:3a38:a815 with SMTP id
 fu6-20020a05690c368600b006003a38a815mr274401ywb.35.1707154157600; Mon, 05 Feb
 2024 09:29:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204-bus_cleanup-memstick-v1-1-14809d4405d8@marliere.net>
In-Reply-To: <20240204-bus_cleanup-memstick-v1-1-14809d4405d8@marliere.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 5 Feb 2024 18:28:40 +0100
Message-ID: <CAPDyKFqkJjdc5vNr-wisTPXqf+2ORsBkcOZUS+LyaktpN-cCKA@mail.gmail.com>
Subject: Re: [PATCH] memstick: core: make memstick_bus_type const
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Feb 2024 at 21:05, Ricardo B. Marliere <ricardo@marliere.net> wrote:
>
> Now that the driver core can properly handle constant struct bus_type,
> move the memstick_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/memstick.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
> index bbfaf6536903..23fea51ecbdd 100644
> --- a/drivers/memstick/core/memstick.c
> +++ b/drivers/memstick/core/memstick.c
> @@ -164,7 +164,7 @@ static struct attribute *memstick_dev_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(memstick_dev);
>
> -static struct bus_type memstick_bus_type = {
> +static const struct bus_type memstick_bus_type = {
>         .name           = "memstick",
>         .dev_groups     = memstick_dev_groups,
>         .match          = memstick_bus_match,
>
> ---
> base-commit: 4e99ffb173faaf38f010acb369bff57a20e9e531
> change-id: 20240204-bus_cleanup-memstick-071b3564d808
>
> Best regards,
> --
> Ricardo B. Marliere <ricardo@marliere.net>
>


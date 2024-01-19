Return-Path: <linux-kernel+bounces-31492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29769832EFA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40FD1F255B6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FE93C6BA;
	Fri, 19 Jan 2024 18:34:40 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2840E24A06;
	Fri, 19 Jan 2024 18:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705689280; cv=none; b=s5mczkUF+eI18J5V29SG02LPVNT8l+QlzWTnHhDCcvpvoYfTlr0KmF83oGMeaMBa2yyAtDRfXrP8btPp+FWlfsFwG6syJolGFqY5UNKNcwhKAXpqvNV0oMS2O5l3NPkQmXW+1eWXZn0NVN3pSdr5OaZTUNjVj6Lh7Zm6ZBoZrN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705689280; c=relaxed/simple;
	bh=rk+LPJnGzZtI+d2A314Lteos2Mt1KI0smh+PSzLk4Mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eodv9RnWp5ob4Ht9Ge9nDaDwM6WTSjSB3TPILAZSZojXE2NIpcQ3McVsceGrjtPQga+5Xkq+8t3x+AjPqGq3FzVMJT0du23JWAiuVn/AmzZdmgW5DgoGXvZXqp94pQCWOa5GDQAXcMquqYDP3BVm/tdw/LFjT92Z5vZk81K/kIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bda7446ae1so103129b6e.1;
        Fri, 19 Jan 2024 10:34:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705689278; x=1706294078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SuRMLByUJDJzNvGs0hzmS/vK4cjDAJOtpT88vO8Y5vk=;
        b=kUeDDTVqhUhlBNydpZ0CxPsvq+hrR95vW+34/DyCTEOpvnUFshCMVY5tDRj7iZ4CU+
         xoGt7cJTDFcCwgR5OydMKAAkMFVxw9yTyVNusd+Nd//sJwnYbN182uiahWwI2LXP7trz
         2SxgljovDC3Ie6qIqgKzJZdEns2qNvLTTS8XE4fcsJAl3HgL65Irnq2ZchuZW8AVhppN
         7w+51NYEY2agRzfBHuN5VtB7WIa7yzTYJ/Oam9nZ7j7C26dBg9u10YMR0vqOKkCUVOax
         Ij68gMyi/Eh+SbDeXzrUyesSgXfWDVzTyiG1nyn4x7tCPDDf6bWoU53iAiHySpss1T3t
         ekuQ==
X-Gm-Message-State: AOJu0YyPK2QwzzoyRu7DNaggtq5kxnXpA2zmY8bLjNeuMRPg0fBAYZ3T
	1ykWJsSZlVg01iWsbMpKMIqqy46goNfxPh8wqqKnHCE+ZPzCRZThokK6KebKzuW5ZfU36e/eZwI
	AlsepKKlRjd5NLOYP+Kw8j7i/S9o=
X-Google-Smtp-Source: AGHT+IEWMNb4E4Y4jJLez5nXGbOCVet/XyyJENkFVCKGHWjJj6XQqrNBf2QPKfzCotTuM7tVrGCd3HwU0JxS1+IoSE8=
X-Received: by 2002:a05:6871:5b18:b0:213:4046:769c with SMTP id
 op24-20020a0568715b1800b002134046769cmr316678oac.0.1705689278042; Fri, 19 Jan
 2024 10:34:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119132521.3609945-1-o.rempel@pengutronix.de> <20240119132521.3609945-8-o.rempel@pengutronix.de>
In-Reply-To: <20240119132521.3609945-8-o.rempel@pengutronix.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Jan 2024 19:34:26 +0100
Message-ID: <CAJZ5v0gfOaCvsxX5QFzgcTeEZgWGZvqJ3C9d8_Pu6pSp=78m9Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 7/7] thermal: core: set Power State Change Reason
 before hw_protection_shutdown()
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, kernel@pengutronix.de, 
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	=?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 2:25=E2=80=AFPM Oleksij Rempel <o.rempel@pengutroni=
x.de> wrote:
>
> Store the state change reason to some black box for later investigation.

Seriously?

What black box, where, how this is useful and who is going to use it,
pretty please.

> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/thermal/thermal_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 9c17d35ccbbd..5ee3a59d7a0e 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -16,6 +16,7 @@
>  #include <linux/kdev_t.h>
>  #include <linux/idr.h>
>  #include <linux/thermal.h>
> +#include <linux/pscr.h>
>  #include <linux/reboot.h>
>  #include <linux/string.h>
>  #include <linux/of.h>
> @@ -325,6 +326,7 @@ void thermal_zone_device_critical(struct thermal_zone=
_device *tz)
>         dev_emerg(&tz->device, "%s: critical temperature reached, "
>                   "shutting down\n", tz->type);
>
> +       set_power_state_change_reason(PSCR_OVERTEMPERATURE);
>         hw_protection_shutdown("Temperature too high", poweroff_delay_ms)=
;
>  }
>  EXPORT_SYMBOL(thermal_zone_device_critical);
> --
> 2.39.2
>


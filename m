Return-Path: <linux-kernel+bounces-35860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8487B839785
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09661B26F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C90C823B5;
	Tue, 23 Jan 2024 18:20:16 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C106B81AD5;
	Tue, 23 Jan 2024 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706034016; cv=none; b=NuD7zGBx5oBP+yCRoH7TftLxaos8w71ibpY8BAl99QQK1cZXraVVIv3PYjRZB//top4etLxrV8+l6aotxMLfcRaye9WAgRoq3Xt0Y1vMD7DZim0KOJUoB8pe2DAgOYSp9+/NraZrpvOZdQhBQaePXvF1FbLYRqPGCvUnbejcyFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706034016; c=relaxed/simple;
	bh=DjBxG7P4BZNDoXbPPQ3AAP8/5+IiYOHXQO3HWX5SrYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IixlPNedqbyaD4KElqJxt1A6McOS3oK9K2IOUhPr9qONOOCQLIk9MVA7bNKwq/e8JFXwfwjB0FtfpJ6UaO+EvGD+RppY+uUabFLp55+ZQa08PLtSzkh/yII+R1BvxOFG2q6SdKD4+xJ2PWu9IS9u84b5iTkqbHiKzAawGQArgkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bd4df21f4eso971275b6e.1;
        Tue, 23 Jan 2024 10:20:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706034014; x=1706638814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Zl0o3sQ/xs4orleB37d3h482FB9X5KwzM20ctuXltg=;
        b=h5fbu95zhjq0X2CfSzH+eDR7p5YahB2BS0wjamIAgVl25KdhdZBYfbaaBovoypGSbA
         FolKjwenlDAdIeyE3S3y/5vuFUMOoSTOny43Sw20y50VkRdBypQ5ucMhVkV0RKvWOEbb
         BJbeXGSgJ7Rl6RKpuLHJn2pt7UoOlWVWfu818xPgnku2eqlyOzy8ner18UbB2wPo5b0L
         ICC2+ZhuztprKP381kWXVD2d1DNQavkL1hQETF2uZaE0vVImk6rp6Mchp/xYT/F7I5FO
         jksc0ESyjn2yxKOSHBTQ+XBa7QIIL+mlFOBBW7P4KCyAuvh8I9XfkZPQkZex042Fwumo
         ni+A==
X-Gm-Message-State: AOJu0YwD0KPbYPFju6AN7SfrR6Rm7lbk3YPv01PameFYjRwZu+6zRe0W
	ofUcteYwBsSktR5CjZf1neU9/XK1O6nn9Yb3XuTb6tzmQTzRgUHJ1HLjg4QzVzbdf4DlyYAN54W
	lNgs6nqMkHuxXJ+1qbsoG7iV9CNU=
X-Google-Smtp-Source: AGHT+IGhgSapfprq6NVIcYCrJDnvbl9cZpHCQ6hCgTamtUt7jUgtSWMMLG9xq8Tiv/kMT/LsxSZqCL6ZsZYhgHd826Y=
X-Received: by 2002:a05:6870:7029:b0:210:d66c:7c27 with SMTP id
 u41-20020a056870702900b00210d66c7c27mr163590oae.2.1706034013592; Tue, 23 Jan
 2024 10:20:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123180818.3994-1-mario.limonciello@amd.com>
In-Reply-To: <20240123180818.3994-1-mario.limonciello@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Jan 2024 19:20:01 +0100
Message-ID: <CAJZ5v0gWuYUg55PGezhkzFaPK7S9qFw9xvd=SoetNBHtOzQxEA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: amd: Add IRQF_ONESHOT to the interrupt request
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, 
	"open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Christian Heusel <christian@heusel.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 7:08=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On some systems the interrupt is shared between GPIO controller
> and ACPI SCI. When the interrupt is shared with the ACPI SCI the
> flags need to be identical.
>
> This should fix the GPIO controller failing to work after commit
> 7a36b901a6eb ("ACPI: OSL: Use a threaded interrupt handler for SCI").
> ```
> [    0.417335] genirq: Flags mismatch irq 9. 00000088 (pinctrl_amd) vs. 0=
0002080 (acpi)
> [    0.420073] amd_gpio: probe of AMDI0030:00 failed with error -16
> ```
>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Reported-by: Christian Heusel <christian@heusel.eu>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218407
> Fixes: 7a36b901a6eb ("ACPI: OSL: Use a threaded interrupt handler for SCI=
")
> Link: https://lore.kernel.org/linux-acpi/CAJZ5v0iRqUXeuKmC_+dAJtDBLWQ3x15=
n4gRH48y7MEaLoXF+UA@mail.gmail.com/T/#mc5506014141b61e472b24e095889535a0445=
8083
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/pinctrl/pinctrl-amd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.=
c
> index ca4a247c2cd1..6a33b584976c 100644
> --- a/drivers/pinctrl/pinctrl-amd.c
> +++ b/drivers/pinctrl/pinctrl-amd.c
> @@ -1162,7 +1162,7 @@ static int amd_gpio_probe(struct platform_device *p=
dev)
>         }
>
>         ret =3D devm_request_irq(&pdev->dev, gpio_dev->irq, amd_gpio_irq_=
handler,
> -                              IRQF_SHARED, KBUILD_MODNAME, gpio_dev);
> +                              IRQF_SHARED | IRQF_ONESHOT, KBUILD_MODNAME=
, gpio_dev);

Or if adding IRQF_ONESHOT here is not acceptable, IRQF_PROBE_SHARED
can be used too.

>         if (ret)
>                 goto out2;
>
> --


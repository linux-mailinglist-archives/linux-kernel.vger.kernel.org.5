Return-Path: <linux-kernel+bounces-48712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C26846014
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9F21F2DE2B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7847E112;
	Thu,  1 Feb 2024 18:37:51 +0000 (UTC)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FA25B664;
	Thu,  1 Feb 2024 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812671; cv=none; b=nQVqChmm4ML+5EFsiZ1cqwIXD32e8ikY4XO5Bavql48dUG3Yx/yICExgXnhdVS1dDimRiePntpcfDY3kGHdvHmApciop1B+RncCKPzNyWL/ON3ERVq7xFgwiZKqBVcxTa6tvecplUpDLUByYRhGRhl9/0uRmjBdK7AqxOqev4l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812671; c=relaxed/simple;
	bh=PG41l4Cht9QMEnpC7yAAvPEsFDYt68t8qhJ5rj+J5lQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKSOgkmoBouJByxQksFANSjSa0TAtUbhuZSSU8uMGl+yehbbq+CeQqDXauc5PdyaSYArw7j3CpD2r560X7KDBgyIh0EFXErEgR7luVfNRV78KvX4JGc1gMyOFDpbjA20G7YWZrrHxyooho9R6XzgjiuhHAJhOESg2yC+Yumnj5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-218e7bb0034so124326fac.0;
        Thu, 01 Feb 2024 10:37:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706812669; x=1707417469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmNRHOBZapP/7rlyEo9FipriJMoTfuoLxFmYGEugnDg=;
        b=ggHYpdjNL63zal2odFQ0Sl3WP8jJRpYVlxL5UIrPoft6Fe1W1Td8EU/bDAB1PV9Aol
         0KqVywEwUla978LX1rRJulBFnsmEwOAs67+RQkXbpK3vHH/q0gY9QeuzuQDFMULh1KLS
         KvItSU2//9kr3OxelchArSqxhE0CNlKlRYRh1w+jRdjrtghyw3zdK/0SJFY5aEs+54NQ
         JB8sEK0vfS1O+ms+VQAtkaem31QCrT95Bs4UEfqs0a+PA0mSlZHCx6zw5pxqg4qtxz8K
         OjdUk84eJsYRoumNfJi2FtetUaVvdMdaQRk5uQ6dvgMcAK9sZYVFkjPSwCF0uQPHQvVd
         MFwg==
X-Gm-Message-State: AOJu0YwHp/3yuEzkbMgGKMGRRMv87WM2leC+EglqF1mxlE8++FO5vBF+
	TVCaKcF9jU7NuYfIdtyCUaG9vwzpEcZdjG0h05XJdEAl2f9/IVLup6E/mf9n8rB0LwDkabRpHWb
	2gZigWsvTjzi7L44kksfq7lpy+Xw=
X-Google-Smtp-Source: AGHT+IGT11Dek5DLe5+fNtg19DcOI9+wbHWnsN4O4W0C/8fEck06WCD8naaCcHI2NkB5AtlA22afByl5AGhGeqVtOh4=
X-Received: by 2002:a05:6870:c190:b0:218:e279:cd77 with SMTP id
 h16-20020a056870c19000b00218e279cd77mr3422269oad.2.1706812668653; Thu, 01 Feb
 2024 10:37:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com> <20240130111250.185718-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240130111250.185718-2-angelogioacchino.delregno@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 1 Feb 2024 19:37:37 +0100
Message-ID: <CAJZ5v0hOcS0Fm2-mKWtc1-0ym33XuH=B39GGL9b6MfGSqeERkQ@mail.gmail.com>
Subject: Re: [PATCH v1 01/18] thermal: core: Change governor name to const
 char pointer
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: daniel.lezcano@linaro.org, miquel.raynal@bootlin.com, rafael@kernel.org, 
	rui.zhang@intel.com, lukasz.luba@arm.com, support.opensource@diasemi.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-imx@nxp.com, andersson@kernel.org, 
	konrad.dybcio@linaro.org, amitk@kernel.org, thara.gopinath@gmail.com, 
	niklas.soderlund@ragnatech.se, srinivas.pandruvada@linux.intel.com, 
	baolin.wang@linux.alibaba.com, u.kleine-koenig@pengutronix.de, 
	hayashi.kunihiko@socionext.com, d-gole@ti.com, linus.walleij@linaro.org, 
	DLG-Adam.Ward.opensource@dm.renesas.com, error27@gmail.com, heiko@sntech.de, 
	hdegoede@redhat.com, jernej.skrabec@gmail.com, f.fainelli@gmail.com, 
	bchihi@baylibre.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 12:13=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> All users are already assigning a const char * to the `governor_name`
> member of struct thermal_zone_params and to the `name` member of
> struct thermal_governor.
> Even if users are technically wrong, it just makes more sense to change
> this member to be a const char pointer instead of doing the other way
> around.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

or I can pick it up right away if you want me to do that.

> ---
>  include/linux/thermal.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index b7a3deb372fd..65d8f92a9a0d 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -214,7 +214,7 @@ struct thermal_zone_device {
>   * @governor_list:     node in thermal_governor_list (in thermal_core.c)
>   */
>  struct thermal_governor {
> -       char name[THERMAL_NAME_LENGTH];
> +       const char *name;
>         int (*bind_to_tz)(struct thermal_zone_device *tz);
>         void (*unbind_from_tz)(struct thermal_zone_device *tz);
>         int (*throttle)(struct thermal_zone_device *tz,
> @@ -226,7 +226,7 @@ struct thermal_governor {
>
>  /* Structure to define Thermal Zone parameters */
>  struct thermal_zone_params {
> -       char governor_name[THERMAL_NAME_LENGTH];
> +       const char *governor_name;
>
>         /*
>          * a boolean to indicate if the thermal to hwmon sysfs interface
> --


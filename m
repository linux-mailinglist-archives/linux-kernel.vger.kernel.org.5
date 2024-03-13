Return-Path: <linux-kernel+bounces-102450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E79C087B244
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D33E1F2451B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0424CB35;
	Wed, 13 Mar 2024 19:49:52 +0000 (UTC)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DC350243;
	Wed, 13 Mar 2024 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710359392; cv=none; b=ApG+wKeE5pS0C11yOW7yVx/36sbMiqp9HFx5Vll2yTO3jZOkrUnTeOhBLT9KPiLe1fOswkHkeqNwUjHJEe71KXtUwNwjLIskw8SO5bzgDWdfX2Qm6JSX0WLUcpbJNmwB2Im0N3gBYSJIQC1s1ZoeWfiaaWuN0exlP+cY2ofCTNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710359392; c=relaxed/simple;
	bh=J9t0dvhtaq5ykc0MBVleUBfd953s0rO/2H9+VspMBH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTa/mjyV4ac04wPi15lT5tN4lQsEnA3Wnt0DzuuKyiEv1sKf/tkoEPLLXsR5zAHqatMalDrRSLBlZHXF41yG+iAgjWKkQHWgf/6uNjZ6gUIqHc4hOh37kTqX+gFFC6F6OqPQ0EnAdKaq/Rg1g/21AZC0n30pq5OMi9tQAr9dmnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-221d4c52759so51442fac.1;
        Wed, 13 Mar 2024 12:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710359390; x=1710964190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjGBA/d4OBZ6FVZbofQlr6HlcymtZvvTx/Uzs1a81RI=;
        b=a+X5mjYR7mdrqK0x9mhYyZ6YTletpWT1t75V8Gb1RJ7DzI9fnaMCdaVihW0OOf6wy0
         MSVCOGEQA8H4MwcDAQkaHXzgLQ8qi7a+9m7j6r5Mz+3zBUSJcOXNxeBxCNbfckWjSb6D
         f/CIKkYpSjj0URH0NmzXctIs9NSX//6MQ/2UcpqPK1FrsK5ALD3EGF4x42snWaOjBI5i
         gyXq2mvuys3WZkxmIORynF5Z8mhu4qS46QHU7Ogk7365BATJMgfxKufaRJvWzn2KwmRv
         bCR0Ysz3OXlbuls6cKuVHSVRFIFNqiCyW0ZEMrt2ZezDD0M0AdsOQKybrNUN5FsAo9n1
         88Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUm94Hae+1IuXLrDw9mVUaX63nxUoxM9czxXEhlKRIOjIcmgk+QnwO36ChfT3iikB9zTMv+VRfdc68FmpfKNeDHj9bHwLGWaz0=
X-Gm-Message-State: AOJu0YxZ/MycFL78eD9TMH4BGxcPnmjCg/hXAoRA6SzLTqnbDtKcgxEf
	J1ByI9d25UHnFUkckHOeOcy01XE030AnhpbUIxEjLf99/xRX0uHSJFkUOpwQtF10B4de7c9/HGj
	K5UQUr6lVxEqBrK2lnnI4p/yu2WA=
X-Google-Smtp-Source: AGHT+IEwMtjXjulYgdDRBLTxRdDgps4cI9pevbf8tvNGisNi01lvylI3qvdXLHtqq6bmzo2afAfreOYXQd73ZN2JscM=
X-Received: by 2002:a05:6871:2895:b0:221:3b96:4e84 with SMTP id
 bq21-20020a056871289500b002213b964e84mr5988986oac.5.1710359389709; Wed, 13
 Mar 2024 12:49:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308123203.196644-1-lukasz.luba@arm.com>
In-Reply-To: <20240308123203.196644-1-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Mar 2024 20:49:38 +0100
Message-ID: <CAJZ5v0g_UcJzRy2-16kjOZpOyB=-FsdgH63LJBzmHRhsARYjVA@mail.gmail.com>
Subject: Re: [PATCH] PM: EM: Force device drivers to provide power in uW
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org, 
	poshao.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 1:31=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
> The EM only supports power in uW. Make sure that it is not possible to
> register some downstream driver which doesn't provide power in uW.
> The only exception is artificial EM, but that EM is ignored by the rest o=
f
> kernel frameworks (thermal, powercap, etc).
>
> Reported-by: PoShao Chen <poshao.chen@mediatek.com>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>
> Hi all,
>
> The was an issue reported recently that the EM could be used with
> not aligned drivers which provide milli-Watts. This patch prevents such
> drivers to register EM (although there are no such in upstream).
>
> Regards,
> Lukasz
>
>  kernel/power/energy_model.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index b686ac0345bd9..9e1c9aa399ea9 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -612,6 +612,17 @@ int em_dev_register_perf_domain(struct device *dev, =
unsigned int nr_states,
>         else if (cb->get_cost)
>                 flags |=3D EM_PERF_DOMAIN_ARTIFICIAL;
>
> +       /*
> +        * EM only supports uW (exception is artificial EM).
> +        * Therefore, check and force the drivers to provide
> +        * power in uW.
> +        */
> +       if (!microwatts && !(flags & EM_PERF_DOMAIN_ARTIFICIAL)) {
> +               dev_err(dev, "EM: only supports uW power values\n");
> +               ret =3D -EINVAL;
> +               goto unlock;
> +       }
> +
>         ret =3D em_create_pd(dev, nr_states, cb, cpus, flags);
>         if (ret)
>                 goto unlock;
> --

Applied as 6.9-rc material, thanks!


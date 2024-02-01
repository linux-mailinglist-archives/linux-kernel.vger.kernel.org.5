Return-Path: <linux-kernel+bounces-48781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33052846131
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664BD1C248E8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15678529F;
	Thu,  1 Feb 2024 19:43:06 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7423652;
	Thu,  1 Feb 2024 19:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706816586; cv=none; b=JhXUyki/x7UFwkmX5Yj6pT0IgG494jynHjrod77U7T+u3/XNOM369rgzF5z+KlBIVcdAVJObMc2yVs77JddknB2eyMY1Z5wzXih3Tyv4X5T47B0owk//fi1Fb0VLuBWXThSipY+JS21AOhX9aexrqObuFhQcO+pPvKTnOxbWVoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706816586; c=relaxed/simple;
	bh=EI6Wdf+UwkRuRvguDGNKbFCflnhm+lABsh5itXBFJ0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXVwb77tfE4BBpeNABQuVQTmxsQ/jfDsfWm+nl9YJSGjJs2sT+gLBHxXqRafnAKkzltv48p1x8uztA59lbWZ+mw5ZxoqYXC0GA+hkR1rp12Fx0Os8bl/HK5TTG94c+vRQJX1h9Z2Hk8U3W8LCyu+NtIPVLa0qKOle3vIuFAQ4YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-59a47232667so168837eaf.0;
        Thu, 01 Feb 2024 11:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706816584; x=1707421384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIfIQzx9YZcK7zdFdUNXFqLOVj9oiILciX2Jy5KyqR0=;
        b=qrNI+IlWTVOm13C4PZS1Mxsc8iDSGTr8A/PPAsfx0VJxqi1AsMCCxiccldj4Ymftr5
         Bk2+n1G8zI/ior+6ezFY3Uw3SSr4ANwaciRrvlRX2XRudpic3XNw5TAHox+l5QLbLk6H
         pdovdpcM3QgFZuHdGGIhSWPeum8q5DwnJGR9r8uGwxPHKsM3/YtUAOteZsaUPeH/tOVg
         3Nw0nx4DuVclG4GMjUacUXJJq3e+0dezbHjsmdrR0ohfQlYTLIW+PWUazTzq1WRggelz
         lhrzVaQRSiGvfosbq/0hvQbsfnO0aWjylKKRKWP30EzjhmyJzRHXp2/r4CeWPQH0jmKe
         0w2Q==
X-Forwarded-Encrypted: i=0; AJvYcCWHCP7KHzhWF2+3EGY9jQVybGWJiDM4PwdmQ/0/7bGQNRBsaugfJtQyB12E+BXiqWVY0lzsTmjS5ol6QOB6QGx9z+JH+S8VTfeAm9kMhVbv9cMuaurBke7ByJS6p7yOavfo/Fbi7zIPbG6YUUHJgS1n+y7kEBzGdfCWkrmmfzuuKTMFTA2qxdu8xZcOvvyVF8p4zjZ/Oek3rcDmzMy5GR6uONoSld5d9Sw=
X-Gm-Message-State: AOJu0YwJgfYSa0RQt1Rk0+z0c41mcDTzyNkJz9i3mCaxhjdp2F5EaG67
	gGWE5wl5Z3y+iPHfXHex5vxY/Wrgx6pcj0NcPCmpJR0N6xi7zxHUQ6rCJKYfrLbFc5uveIFtdkH
	OkR5VlrVKRWxR7ci5rgQPVt1bQ78=
X-Google-Smtp-Source: AGHT+IF4d2qVzkyJfWAEFUKt+0yhhszmCH5h7eayyLTyhb+UTNnYVy0aTBkyzcVw4YAyAiHmxAqp4+kRoyY1okMmtGE=
X-Received: by 2002:a05:6870:b6a4:b0:218:d1b7:e8cd with SMTP id
 cy36-20020a056870b6a400b00218d1b7e8cdmr4317354oab.3.1706816583711; Thu, 01
 Feb 2024 11:43:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com> <20240130111250.185718-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240130111250.185718-4-angelogioacchino.delregno@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 1 Feb 2024 20:42:52 +0100
Message-ID: <CAJZ5v0g6YNDAUxaWK9KfM0tt2x4wqaCap4--UjSauwmfYiEgoA@mail.gmail.com>
Subject: Re: [PATCH v1 03/18] thermal: Directly use thermal_zone_platform_params
 for thermal_zone_device
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
> Remove all duplicate members from thermal_zone_device and directly
> use the corresponding ones from struct thermal_zone_platform_params.

I totally disagree with this approach.

It does make sense to store these things in a tz directly.

1. devdata allows the caller of the thermal zone to get to their own
information on it conveniently.  This patch makes it harder.
2. It makes sense to copy type into tz to allow the zone creator to
free the string (should they want to do that).
3. It would make sense to copy the contents of the trips[] table to tz
to allow the zone creator to free their initial table.  This doesn't
happen today, but it is in the works and your patch goes against this.
4. It makes sense to copy num_trips directly to tz, because it is
closely related to trips[].
5. It makes sense to copy ops directly into tz, because this will
allow zone creators to use const ops for zone registration.  Again,
this doesn't happen today, but it is in the works and this patch goes
against this.

As far as I'm concerned, this one is a total no-go.

Thanks!


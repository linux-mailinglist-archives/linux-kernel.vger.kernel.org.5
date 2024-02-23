Return-Path: <linux-kernel+bounces-78340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DF4861226
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD1E2831EC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512A47E59B;
	Fri, 23 Feb 2024 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBCoDNa3"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7F6651A2;
	Fri, 23 Feb 2024 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693246; cv=none; b=daHRQvB50v3x8tnYmmaQWZgKEClU/lUyK2WaO6TIXOqwcZ7tUJ1FMN1vsCYduKaSW+9rLLZQU0CsJhX87h3Yy/wkB9DgVZlbpPjlo3cu4T11si1iPNjYQF6fB0pX2rqHD4OjXFCstuygrTC6DYzB+1xS00wxRiXmYzp0F9mWhc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693246; c=relaxed/simple;
	bh=v6EOiHBno6M8nUZDXDTbep6dCsGMg7HTrmnr42jez00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jd5Hp0yIUaenm2Njm2RbRKRtc64SuoQhtbZQHcEHU/I2O93nWYEaFYUoowFASlZxDSTGHRk2qhx8OblX4wBcV0Glrhz6XrOt/27ONjhS1geYMQ0MmHmDFzMszwreIFzabAFsjxD2qJci7u3AoQbkg84mtW1I1JJBiPCVOSsFvV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBCoDNa3; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5640fef9fa6so990889a12.0;
        Fri, 23 Feb 2024 05:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708693243; x=1709298043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6EOiHBno6M8nUZDXDTbep6dCsGMg7HTrmnr42jez00=;
        b=NBCoDNa3to/QC+87HQzrbeWO/UZspMiugGrKtuZXlOB7eqlUp0NdcnJGjIAacRO1mz
         CwAQ/lvlLAkpuKLwfpjuD/T0SGfKVqISz2hcc7ZYRuA3VRs2gBSm95RbuVsjvAaw9BqW
         vyMWOTch/5RQvfGlU5Hx4HfYTOOkBqdbEuNJ/C0/PBF0bsnhtVsjTPz61Ds8A196Qn3h
         OCatMCiHT+HyCSRu4HEBbmrcu0JDpkNRwjHZR7Ki9rp/G8xZWPZ5MNG+2WbWuOi/XiK4
         dYIINqpaS7umHwYCW5Drtxcc07TVe7w/P0jNBPXY9Bu8j2VhCkW2nWbTX+Db+9dWCLN2
         ljEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708693243; x=1709298043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6EOiHBno6M8nUZDXDTbep6dCsGMg7HTrmnr42jez00=;
        b=LcWaLfWm+2qYBGZ0WhiVgbYe3pOKyxJ0CZ8Fi0HkQE1sUU2+5zEbC3sj7jE8Uu8+Ul
         gibwcOLzcgwJzPSKkjPq89opkEptZVM1EHUfg3g96wb6PEbfbXeM9Rf8SeQ195BNrmpa
         ffcXmdK9JDZ2vK92SI7O2u8IoPgIknZgcvL/gNkSKO1lXoCi7QG4TcXvmdD2LbzLc+LQ
         MseOBKia5ktp6rdCx0ag7yS+oTQdKRw3t1fRxwoFunSQIrcSUofWVToaemxGSGUyQBUs
         P0mkck7//KvjoFpTjXhQCLm23+UL6qMkcjrvmtJPLFaaZgHujc12P9kU8c4c6bR0EX4c
         ExRg==
X-Forwarded-Encrypted: i=1; AJvYcCXSVsIgZNt1UxyjOV+4PwXNGvIAbSEtbdd860AAQ+LgrOad88TYNZXxjQX4AjPl9qjh2bzKPuEHF4DtWZH/+MO3XxNdwGrIRouSLjE6k0eIkQJuGaH2eVihc6EEll3QPby7q+YfOOga
X-Gm-Message-State: AOJu0Yx/Kvv4d9PHCLtmck31/o1NUFWkWkMra1c0A1qmFV8Nu2EVg11j
	wNv3opX8IHgCmpJCyE8JwAeJp/hX0LyFmwMPEfqk6xCIVjf42gkUVBiXvYs7gzr70BttQUFik10
	fLbkDEQLBEbfDzC5izwesBkBRY2U=
X-Google-Smtp-Source: AGHT+IEZTPrTP19ohID9DJOrlNAM4cEMjE1ZVzkL+6RbUHcbz/uUGqRu+3bVXh1Mp2P2R6zv/U2YETV35GWSkGwy/2A=
X-Received: by 2002:a17:906:68d5:b0:a3f:5c5c:33ac with SMTP id
 y21-20020a17090668d500b00a3f5c5c33acmr1258057ejr.62.1708693243510; Fri, 23
 Feb 2024 05:00:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223-saradcv2-chan-mask-v1-0-84b06a0f623a@theobroma-systems.com>
 <20240223-saradcv2-chan-mask-v1-3-84b06a0f623a@theobroma-systems.com>
In-Reply-To: <20240223-saradcv2-chan-mask-v1-3-84b06a0f623a@theobroma-systems.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Feb 2024 15:00:06 +0200
Message-ID: <CAHp75VfVTJsQDwaPoPgGiT6jnymXAR3WpETqaKai8rXAC70iLw@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: adc: rockchip_saradc: replace custom logic with devm_reset_control_get_optional_exclusive
To: Quentin Schulz <foss+kernel@0leil.net>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Heiko Stuebner <heiko@sntech.de>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Shreeya Patel <shreeya.patel@collabora.com>, Simon Xue <xxm@rock-chips.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Quentin Schulz <quentin.schulz@theobroma-systems.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 2:46=E2=80=AFPM Quentin Schulz <foss+kernel@0leil.n=
et> wrote:
>
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> devm_reset_control_get_optional_exclusive does what this driver is

devm_reset_control_get_optional_exclusive()

> trying to do in its probe function, therefore let's switch over to that

do it in

> subsystem function.

> Cc: Quentin Schulz <foss+kernel@0leil.net>

You may use the --cc option to `git send-email` instead of polluting
commit messages, or move this after the '---' cutter line.

--=20
With Best Regards,
Andy Shevchenko


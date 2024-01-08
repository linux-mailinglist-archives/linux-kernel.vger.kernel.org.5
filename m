Return-Path: <linux-kernel+bounces-20007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C954827827
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E510B2263B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CE454F9E;
	Mon,  8 Jan 2024 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EZnI9HMT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B129F1E534
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dbed729a51eso1234467276.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 11:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704740961; x=1705345761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSx7WF62VA2TDHvBjsjKxYkf7FVvX4LrtRjSH9H5QI0=;
        b=EZnI9HMTfj2K2fzfjJjwoCssDnIBtHyVgApCCVbiDr0Bf/pF8vACuJ0O4YK/80VYBW
         KCDCzCaOEKhRWPOvYZWrPJibvkADTzKjmN4H/KsOdSMr3j/nIFMJgj1lIDPdo3wru+7V
         VTfBUChWrghb7v1V0ir40z6VMjeDvrBPJjTgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704740961; x=1705345761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSx7WF62VA2TDHvBjsjKxYkf7FVvX4LrtRjSH9H5QI0=;
        b=k02N+rPE8/lLAT34JokwrBLbiIyq4Yesjkk2jO9EbLlDvaCmKGXpT2c4maFIEmTN0I
         F/lyMU+LG0Z6UggccUo9q/3/1UGoj+5wkS/PSsDqoPFaj/C63aawZMnyzAMlqaIFbmw2
         PU+Z1CH4SULU84fc/X3yPJJwY6oP3QkelvH80oXTTGME2+rnuIHQWTTsVHRafCk/1JOx
         K6rKF/CZF9xP1gpFqt3Tpw99K5v5e9X+Ob0UDyMUM92cjAg41WPLmCu2ylUrnyO7WS43
         kOlDPXJL7ZfPnEs6FVwraa2+wwt0mcXC01gsGuGxDt2Ge5VBAE52TwM+ccRU8hWPOVCa
         NueQ==
X-Gm-Message-State: AOJu0Yx4nMW7xSrM1oePCMKzXWpJsE+HH74WMKnL18LzezeEc3V3/kki
	E5C1xG5dMUoSCSUp8f/PYMNDIqk/+hXFBG+k5CJWWNF82TeN
X-Google-Smtp-Source: AGHT+IHqD4GCxdgk2x8FctvU1sgHPPCCfJuTHeZt1/edCVCqvB461hCPtcZhdSkEMwHFeV3J+ISLaWBimmp9iqxZ7U8=
X-Received: by 2002:a25:ae47:0:b0:dbe:9f6a:a7e8 with SMTP id
 g7-20020a25ae47000000b00dbe9f6aa7e8mr1752009ybe.79.1704740961555; Mon, 08 Jan
 2024 11:09:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102210820.2604667-1-markhas@chromium.org>
 <20240102140734.v4.23.Ife9ebad2bbfbab3a05e90040f344d750aa0aac7e@changeid> <ZZlp_YszbYTUFC1u@smile.fi.intel.com>
In-Reply-To: <ZZlp_YszbYTUFC1u@smile.fi.intel.com>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Mon, 8 Jan 2024 12:09:10 -0700
Message-ID: <CANg-bXA1thAjWDeaJs8aO-SmTkgcjx8Cw0nWUHt+CGyCrB5tLA@mail.gmail.com>
Subject: Re: [PATCH v4 23/24] platform: Modify platform_get_irq_optional() to
 use resource
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Raul Rangel <rrangel@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	David Gow <davidgow@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 6, 2024 at 7:56=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Jan 02, 2024 at 02:07:47PM -0700, Mark Hasemeyer wrote:
> > Unify handling of ACPI, GPIO, devictree, and platform resource
> > interrupts in platform_get_irq_optional(). Each of these subsystems
> > provide their own APIs which provide IRQ information as a struct
> > resource. This simplifies the logic of the function and allows callers
> > to get more information about the IRQ by looking at the resource flags.
> > For example, whether or not an IRQ is wake capable.
>
> ...
>
> > +     ret =3D fwnode_irq_get_resource(fwnode, num, r);
>
> I still prefer this not to return positive value. Since you _require_ @r =
to be
> not NULL, i.e. valid, the returning positive value makes no sense.
>
> > +     ret =3D ret < 0 ? ret : 0;
> > +     if (!ret || ret =3D=3D -EPROBE_DEFER)
> > +             goto out;

I agree. But echoing my response from v3 patch 24:
- The fwnode patch is already reviewed and approved.
- The fwnode patch uses of_irq_to_resource() which already existed and
returns the irq number on success. The error handling translation will
just get pushed to the fwnode subsystem unless of_irq_to_resource() is
also modified which means updating 8 or so drivers that reference it.

I can either:
-Leave it
-Modify the fwnode subsystem to perform the error translation of
of_irq_to_resource()
-Modify the fwnode and OF subsystems and update all driver references

The fwnode and OF patches are already reviewed. I imagine coding
changes would imply dropping any Reviewed-by tags and requesting
another review?
I'd really prefer to not blow up the patch series anymore, but if you
feel strongly, we can come up with a solution.

>
> > +     struct resource *platform_res =3D platform_get_resource(dev, IORE=
SOURCE_IRQ, num);
>
> Same comment, please split definition and assignment.

Will do.


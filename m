Return-Path: <linux-kernel+bounces-107561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5656D87FE23
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA7C1B2210B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD11F81AB5;
	Tue, 19 Mar 2024 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="dIiK6hiS"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7210A81AAB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710853598; cv=none; b=FOdZrmpL3xaNoRzP9225Dzk5aX6tW5EsefefpTGt6cAUFgkynG6hcdixdiY6ftdCGYI7cGeUwT1lKJ91rfRJFC8xfgmwbjMnSsXWG1SUDJs6dRb9mN2MZXrlRg59q6+2ZcOy5Za+kzedwniRUASKOZCbGIpYV8r2HMDjDoD1f8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710853598; c=relaxed/simple;
	bh=iFwpR9R7RZZeceWMUF41RxivvYImNs6l8Lwq8or5egI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kf44aiJwGNp9sJaCmCGr4lniIQidRDpeqm1pqBwZVFysoZbhnEc1iNOpZ+ifLvflimvGv0Jx9V8Zjvhm0x+p2qgkgsaebtgdxFgDActMiPDy6CtRv1A9oXOjIHy5Smwm1dzqcwCdzGvM84HG5F5v/nPUbz9hEgfmI3/QJGzx0s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=dIiK6hiS; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a46ebc0f49so1997281eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1710853595; x=1711458395; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qWQmoFTqSmJhXM5+bL76nUjgEzlqyYQgelxWMRXy8Ng=;
        b=dIiK6hiSnaRhVWOMXh9IgaA4caxDXontuV687CQUa+WN3xyM0Rk3EsD+JJDnM11WQb
         FSLValr/YHzJuOIaHyLmfxW/br2Fc2br/WLs06nnrbx8dI8WcplTF8xuAYJaQFY0ZiR9
         Yo36qWyYJS9D5iQvHNrpI89FACBGtAVSjRYL6VezwIhRtBajsdO7SBO4+v/ynNKzzdTm
         OxGvGCd6c1xBSO7xGPwsheVXHvoOSO4S90GE6Zt9xta2/zLnFh1zQcoCMQLTR4pfInWX
         XFo7KRcmG0EXqKj2hSZPlJ1GY7MJXe0iNAm56Um8cLrp9SZ2TcbEOh341pE5EI0uf+HS
         arbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710853595; x=1711458395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qWQmoFTqSmJhXM5+bL76nUjgEzlqyYQgelxWMRXy8Ng=;
        b=tqfrE5nchUDCMymVdcX1m0oRhYMgGmpPR8gVodJaMo7PVhkIfFweySGXYxMqhaCcb+
         /6EzU4KThib/DfsJGqBwvKrWL3YK8l0XSdLh9yA5ewykeP3im7T0FQmxHkikQWCDSbaQ
         4eKBlXjoa9toai3w++3u4Pr/d46N8o1QlKeEhEnjZ9aZ1T9rei5qsSbl0B+wfuCRhT9f
         6e6eiYeakG8sbj8blYg1OGH4+svlfiIy3wMg7bwXClHpekp59ka8fqXlnSG4Zuvxq9BZ
         LTmvgclFEtuceZr6JwBmnD5WswrHxbsnxuNIr+y6TervnCXGWBFlV6AwxzYl1a+fQ0aj
         ECMg==
X-Forwarded-Encrypted: i=1; AJvYcCW3Ed/6w9yWW+0gcrByXus3/0ce9GPlS16fdt1HIpa6Q6zoO29IL919BfT1RZ9gd0JOgXNVsVB2rH0ItGjNyuEfX+eznzgPl+XyScnI
X-Gm-Message-State: AOJu0Yy7KCJr0LV+52hXU3j7jFRnkQcOb79jKgZdN6yOGcB24G0PyXBr
	9IOgE+LSQPfYbpBf0AnL+xGJFBLZtmcQB4YMrfDb8yVfEImXraQ/3yKy/6QBheCl6G5ql1/Q7ZJ
	XgSStIYOZIaoXM7SrT/QDh1T2fOKQjFOPykXcnA==
X-Google-Smtp-Source: AGHT+IH3b3a+/tMGFlUi3v6nRTbIFl0E8v2mS/C2QE82azOisrsdw64JHJ4uQYcHiIPKJCLl570m8xpxERqaK0CKzQ4=
X-Received: by 2002:a05:6358:5e0d:b0:17e:b64b:e0f6 with SMTP id
 q13-20020a0563585e0d00b0017eb64be0f6mr2588285rwn.30.1710853595605; Tue, 19
 Mar 2024 06:06:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318-rp1-cfe-v1-0-ac6d960ff22d@ideasonboard.com>
 <20240318-rp1-cfe-v1-2-ac6d960ff22d@ideasonboard.com> <eb854c43-1e92-4c19-bfd3-1bde94924319@linaro.org>
 <f97faeb9-8a6b-47c6-9317-daca88257802@ideasonboard.com> <30430e0e-70de-4831-97ad-974e350a2e54@ideasonboard.com>
 <5ca1d005-1beb-47ec-943a-9358ae3c6704@linaro.org> <CAEmqJPp7uGYe993L+ujth2mfRy66s8-S9FNxPY7vwkrboDq9yg@mail.gmail.com>
 <89d459dd-cc8c-4780-a56a-809e24343e69@linaro.org> <CAEmqJPrLP3j37Kcj0mX23x00p=gWuxZPNSUTRGNkcEqsUJ2MjQ@mail.gmail.com>
 <9d238cd6-0e11-4775-bc00-7df50f0a6638@linaro.org>
In-Reply-To: <9d238cd6-0e11-4775-bc00-7df50f0a6638@linaro.org>
From: Naushir Patuck <naush@raspberrypi.com>
Date: Tue, 19 Mar 2024 13:05:59 +0000
Message-ID: <CAEmqJPoVFRUBRnuvRaeWg6vxDaNMzdFzgj2_Gi5bxh5nacdmDw@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: media: Add bindings for raspberrypi,rp1-cfe
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 13:02, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 19/03/2024 13:57, Naushir Patuck wrote:
> >>>>
> >>>> See writing bindings. Compatibles should be SoC specific. In some cases
> >>>> generic fallbacks make sense, in some note. But don't just choose
> >>>> "generic fallback" because you want. Provide rationale.
> >>>
> >>> If the compatible is SoC specific, I suppose "raspberrypi,rp1-cfe"
> >>> would be the correct string.
> >>
> >> Sure, but then please think what if rp1 is on Rpi6, called exactly the
> >> same (rp1), with some minor differences? Could it be?
> >
> > Yes, this is definitely possible.  In such cases, I would expect the
> > hardware to have a version register that would be queried by the
> > driver to adjust for minor differences, and the compatible string
> > remains the same.  Does that seem reasonable?
>
> The "would expect" is concerning. The register(s) must be there already,
> with proper value.
>

A version register already exists in the current hardware, so we will
update it to identify future hardware revisions.

Regards,
Naush


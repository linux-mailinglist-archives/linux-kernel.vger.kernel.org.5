Return-Path: <linux-kernel+bounces-20006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF0B827826
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8CA2846AD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D092754FA5;
	Mon,  8 Jan 2024 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GlG+GYPB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1866454F86
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5e89ba9810aso16140567b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 11:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704740945; x=1705345745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DdFDb54bQ/iPZlWQVp8olWIpdQfHr4McuEO6nhlwfQY=;
        b=GlG+GYPBaC93H4it9eM8pRSdwurFyP2Ql2YuSkEGmab95FTEjZ1k6R6yI37Vm8Ux0o
         Wmi931NCs9UBulRCUo8yNib1/G4lfTfNbsP40owBq85u0UpZ/HPKoiRO50cNR52ziYga
         wOVmUYSZ1ZJqDk4n0q7p6oQg+RqzFJimvrofs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704740945; x=1705345745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DdFDb54bQ/iPZlWQVp8olWIpdQfHr4McuEO6nhlwfQY=;
        b=daTIr0teSes4ziR2/mzanVMy1QaUqLWJWa1Iwv3boxgyhQ0zNLKcJt1M8pltfMYAFn
         VBRDKCGPeZlmm+yCWhSlBuN3CQkR8f5OkA2R82EJqyfp8MHpF2ZfRJIWM64WbfTZQUyc
         Pr1BGy9OaRzfOF2COgEcUyVJTATTAN7t7/WK7JG5iRVtfQuWjjjDhQct1F0bv8bIPNNh
         dosLCvmi20f6rOkiJtQpydL98eNqeUMjvhtJ+pz0+WMskJ1J0RCnYzYdrHW6hnks89c8
         8ySZcL82ymRD6uoOQLGqpDckxbCyLhBf2ziAnUZLbr05Gmhkdm0Ee3jguGcQK8xb6BIj
         rqjw==
X-Gm-Message-State: AOJu0Yy0LcsdbZEmx0E7TA2eyXjmmLc/A4dashtBawxkjfyW0XjlwoRz
	rmVnES58lDtiZPTNqt2wBSWcwJdUNjEVjOCBMNgNNb53qMXT
X-Google-Smtp-Source: AGHT+IFqbTaQBwF5KFHSC80fhApdUGgPLP6zXYivf0vKMqkNEHamGGwAXksyQIg4izP7sJkzpmbX+Xe8BuslOn3+lWc=
X-Received: by 2002:a81:f106:0:b0:5f6:dee2:2b25 with SMTP id
 h6-20020a81f106000000b005f6dee22b25mr2099819ywm.80.1704740945135; Mon, 08 Jan
 2024 11:09:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102210820.2604667-1-markhas@chromium.org>
 <20240102140734.v4.2.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid> <ZZlnNR1-yKLSIWeF@smile.fi.intel.com>
In-Reply-To: <ZZlnNR1-yKLSIWeF@smile.fi.intel.com>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Mon, 8 Jan 2024 12:08:54 -0700
Message-ID: <CANg-bXA+zuPAYHKaYihkPN1W3+78gBx_Edvhb-a6DqD_adJeaA@mail.gmail.com>
Subject: Re: [PATCH v4 02/24] gpiolib: acpi: Modify acpi_dev_irq_wake_get_by()
 to use resource
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Raul Rangel <rrangel@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Len Brown <lenb@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Wolfram Sang <wsa@kernel.org>, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Missing blank line.
> We put a commit message as
>
> $SUMARY
> ...blank line...
> $DESCRIPTION (can contain blank lines)
> ...blank line...
> $TAG block (may not contain blank lines)
>
> > Signed-off-by: Mark Hasemeyer <markhas@chromium.org>

Looks like a nuance of patman I need to iron out.

>
> ...
>
> > +                     unsigned long res_flags;
>
> Why not calling it irq_flags?

irq_flags is already used within the same scope, although it's
declared at the top of the function. I'll move the declaration to the
scope where it's used and rename irq_flags -> irq_type, and irq_res ->
irq_flags.

> > +struct resource;
>
> This...
>
> > +     struct resource r = {};
>
> > +     return ret ?: r.start;
>
> ...does _not_ cover these cases.
>
> Hence ioport.h must be included. Did I miss it?

You're right. It didn't break the build, which means ioport.h must be
included indirectly. I'll add it back.


Return-Path: <linux-kernel+bounces-12243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CB481F1E7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7AC51F213BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 20:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B90F47F60;
	Wed, 27 Dec 2023 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NKDBTjor"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E44A47F53
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5e730eb1770so42549047b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 12:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703709205; x=1704314005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ETOOWny78yShpPj7BKJPNWWuj9UMiMXyyRH60A3S4gA=;
        b=NKDBTjor0HkYpFzNO/JmqK1HuVyO9LfSm+VJ8cYQXCm+ym7TyGGasUy6InHACrSVzX
         FRgQ0PZzykkYCYlnoQAgDVJN8wM9bzcRQsZCadOhkCwkAP5ljpiw4DHMtS9Fjt7+YFtr
         znWc1QfuWCZrM5YwGEoq509of/u0cj2eN/U0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703709205; x=1704314005;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETOOWny78yShpPj7BKJPNWWuj9UMiMXyyRH60A3S4gA=;
        b=XFnm6yBTpROAUh+tAVOKGHvOvQWnCsjrt9jWJSn0R3QeKGIibVXbG70qFBuyZfP/++
         KM0T7oQxlWK+JlxutVRoSSaUgnBW+iFa+2eNjdYA5cxNHfbCao6ksKtQZ+8S7FkFVpje
         hmjkNSgbU+TN/umbQ1EdLnOfhKBno4PeKMLisj5/KsLFOQTqIV7RhOnWlyqfJEr7Pwmp
         VQOczDxFL5TbkQO1jOrNLcCslW74NKRmINlwhrYaBIxa7U3/OHZIjf4YZfX6NfgoQq1e
         7MWSPTSajheF6NilWlPWCHk90VhV3aGZ31oP1Er3Uk66+MSVozmDlDlJVLngPDlpXnTi
         FxNg==
X-Gm-Message-State: AOJu0YwF0X8vFKldVlDx9pkISX+qGLVHNl/mjuSb29VLtZ3EzIdGKyo5
	/88eSOFG6/nQ0QMq8jKDhH73EzmnK8rReVugmoOIHPwWbfWC
X-Google-Smtp-Source: AGHT+IEv2qOcg5BpiL7T8OUF8iPS4gwb9X0z1Zwe6rLoqc5jYun0fr5IQ+IDMe9svnOcE0DbJ+X7Qb6Yqb/t4fuEM8s=
X-Received: by 2002:a0d:dd92:0:b0:5e8:789b:3be6 with SMTP id
 g140-20020a0ddd92000000b005e8789b3be6mr4939328ywe.17.1703709205265; Wed, 27
 Dec 2023 12:33:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226192149.1830592-1-markhas@chromium.org>
 <20231226122113.v3.23.Ife9ebad2bbfbab3a05e90040f344d750aa0aac7e@changeid> <ZYxfLjCzjnocKaTo@smile.fi.intel.com>
In-Reply-To: <ZYxfLjCzjnocKaTo@smile.fi.intel.com>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Wed, 27 Dec 2023 13:33:14 -0700
Message-ID: <CANg-bXAPrhS9iYASSSXFJguYEvejL_NcgMCWCHU=6mvP9AstLA@mail.gmail.com>
Subject: Re: [PATCH v3 23/24] platform: Modify platform_get_irq_optional() to
 use resource
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring <robh@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Raul Rangel <rrangel@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	David Gow <davidgow@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

> > -     struct resource *r;
>         ...
> > +     struct resource *platform_res = platform_get_resource(dev, IORESOURCE_IRQ, num);
>
> This is quite unusual (as far as cleanup.h is not used and there is no place
> for it here).

Sorry, what's unusual? The declaration of a separate 'platform_res'?
If so, I introduced it because I wanted to avoid setting 'r' if
'irq_get_irq_data()' fails below.


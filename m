Return-Path: <linux-kernel+bounces-47019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC89844813
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196F21F26186
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B193E499;
	Wed, 31 Jan 2024 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XvIdksbI"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC7939FF0
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706729720; cv=none; b=RePKigy+EokaQ7zFn20pSQhGhULzI/xrrLAk9EUQ910unmBjtGI+MAFPdUwAQU6UFPRZ6stTdoOW532f0X/wY8YUDS7AeJV8zIkDH9ybIwQIHMwIkVSfduY75afa0YiEZ+p62e4R76T9R2RTiHgSbNJE2taTuz09iXqBVl+ZF1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706729720; c=relaxed/simple;
	bh=UDmCmOtnw8M0P/f5Q0lrehAH3NXDTmEoF/3d+TzNzB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zcj6VbpxuOHvORR2fWHVnRK0SuC8u9KSGNz9R3QQ1LpNU0IBsCQhuU4UmIYOai4CGDlQmsX3gUSW9mS7zjufrJrNcrVqEGctchLu2xihBPzIAWGDVAzAShsx+kzq1FFfXm1Px0Bgq+n7TVq44pxiYts/oBGJTL/tRlfNTpxrqt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XvIdksbI; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5edfcba97e3so1399907b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706729718; x=1707334518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDmCmOtnw8M0P/f5Q0lrehAH3NXDTmEoF/3d+TzNzB4=;
        b=XvIdksbIwvURcsyRbLLtSjazwD2J2t9XYDp/QWdJuVg+AFGMyl3weFYimWDsDZKGQ8
         MxVENR43W0EadA5G+qixVROVVA7ha/E26HqZR+gAoAwKeC+gf9fhDkKzptDljC9Jn2OF
         ZAVYJBYNVIMZFbGOvo46ruafUxLz4BrXXwxwqZNuy9bofdouhzJaEmsBolyK+tVdswb9
         LfS+EVTZKunL4/0inK+q++Ny8T8OlenU8XExHWSCoBy1b6+lBuPSaqBj4zy4imMW1Ifk
         tTRlW84+fR2BCXmMhquxBn1jtRziSibQTSRI04Xm0TNWawsuJzH28Ie3AQ2Kqm0LmrRs
         E/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706729718; x=1707334518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDmCmOtnw8M0P/f5Q0lrehAH3NXDTmEoF/3d+TzNzB4=;
        b=vh4qnhdwIjHhKVlqX0kPdzc+XZ1BkplfxN3TWtrMrtBpZHRk+R92qhZazMG3tWM88V
         WxTqi8G8rsGQ74bjoIhGI6i2Uim/jEkwhGrsHmovFsL7AVq7eAoi8IY6DDzC8vfnSW34
         zSMUiM4Mqx5htZ+YqdavMLjt13FHCaJl6xcXAFdQIeMeVRjG3e0EHl9u+pTYUpebPssq
         s+U/LBS22CUVKwa774Rpfn6xofn1mJtbr24p1RboDpqKCKLn3XTojaqm/MvJotKdAMvi
         HHlQsXBovhWhdvVPCPnf+FTWUJ5t4rUeYhRJzzytnB3nEyQ/9SSdTQ4i+6KU4MbMSaaR
         rDaw==
X-Gm-Message-State: AOJu0YxcB4hyrFmgDBvAht2R2V6ZzCKGz/TjyvAfTDbW+UFPtmVXkt90
	xtuObt1b49IgbL4vl/DInTWWTX5LHF746hu6XdtFD0Pkv6z4+egHinTzG0nk+Y5GjpymO62lswX
	CmPuv7rn9iUSxcBFFB7B6RUfFucm4FSzlZG6FYw==
X-Google-Smtp-Source: AGHT+IHeF7jUdgGl++cSRvx+ErSHPKU5y6456vlmuHRMjFCbeGPWJ9PImNXQcwszPKmGPHWL4IdLlyN1GWxLsnxdVBc=
X-Received: by 2002:a0d:cc12:0:b0:604:2c8:e49f with SMTP id
 o18-20020a0dcc12000000b0060402c8e49fmr2039032ywd.50.1706729717963; Wed, 31
 Jan 2024 11:35:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130124828.14678-1-brgl@bgdev.pl> <20240130124828.14678-7-brgl@bgdev.pl>
In-Reply-To: <20240130124828.14678-7-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 20:35:06 +0100
Message-ID: <CACRpkdYwpPb+Cdzu_75He2YasLYzLaePvKpDLCeBPuATDZ=zNA@mail.gmail.com>
Subject: Re: [PATCH 06/22] gpio: add SRCU infrastructure to struct gpio_desc
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 1:48=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Extend the GPIO descriptor with an SRCU structure in order to serialize
> the access to the label. Initialize and clean it up where applicable.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I don't know the inner transcendental semantics of SRCU but the code
sure looks like it is doing the right thing.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


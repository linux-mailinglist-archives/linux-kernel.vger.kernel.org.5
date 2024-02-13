Return-Path: <linux-kernel+bounces-64335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E590853D37
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5984928DFFC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB806167F;
	Tue, 13 Feb 2024 21:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mk3HhX1S"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F0A61673
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860040; cv=none; b=Dceoaowkly7R65Ci2eh1Ipbec4eYpuLfX3YGUf4J5MttXAY9H4SX4ArYbp7+PsGDvt6Ehmr8OL+l5V2cLbRaCLo6hVrqfWSwEUcaf/QwY3MjHTZH30zLU2OsKV68TX5zHZ9MlkkjDctc2/IADuabwF/ROdRWt0/8VUiAcmobpKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860040; c=relaxed/simple;
	bh=dPrrXtUFDA/aPNkcV7uPwb86n8qu+g5IfAXRcr4JbEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pO+W1QRr6WK/FePSTfbDa1PRrWRyd3lH1w2JV400NM4ftefXxaJ3AcrP1n52lXUQtbN/K7zYq5FF0vIyuBF6EeslLwbPsEQZbU84wzRXaPot4NiYjUB+xxCyEUz5j25rEkL6fkleDNAEIZejISd62sCo7f3UIWgkfmTnzGcfKrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mk3HhX1S; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-db3a09e96daso4065259276.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707860037; x=1708464837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPrrXtUFDA/aPNkcV7uPwb86n8qu+g5IfAXRcr4JbEY=;
        b=Mk3HhX1SOIpYSZbMjz1+YZYfLdoW07ghN51SGBx4RMJDurH4iigF9edLE+S7ltqWPD
         0TWwXR7+110wWVCMHIZzvYP6v7LmcIWlmpiIfuLAZ2qc8TihejnEJAVeG/NBnH7ji1So
         8Ws/LIxcYJfqa/XbUdX2DqrXcLZ2C8ahSyU9rWMNj0tDaRd3g8vFv1c4yv+PkYKq+i+x
         qUsSZopIFSf9Kxw++m/ncioMHBEuuVVGvOhCfFsWcOwArGaQTm2YHrsNOxMxvdejZXx4
         wROjoWiB27j1bdiLV9cufTTZsxG+WPgcIjO9Ylpx75ERmxYNb+Ma1qWwrC7Z25rDrIMA
         v/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707860037; x=1708464837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPrrXtUFDA/aPNkcV7uPwb86n8qu+g5IfAXRcr4JbEY=;
        b=wgrAhOrdoK92DBiQ8YLmWS/kxVMJWy+AR2szgNFXAC1vjEWo23Gkk4ypfu2cGWm0cB
         RmXhTi7YKEAwPM3hrzeSv3P14jCTDgW0Uh1cEH7/30MY+6jnvkHI8xoo1QtXLJHAxK61
         BllQiiWItuhNmCxHSWeUj73Vyw/Rvp4Kmtb56Dz/HBYujzwcVVOWM2QttK3GV4imgmub
         DWbIfqh5M8RfI5V9a4wP1aa9yApatAO1AFKq8WkK0ECmb488BtWuoiT4g4cNq0V8aLur
         dEGa8TPgfhpR9JzOE7Cg6Lgpp3u20DxSpm1uxbrybpnsfkDFM/gO+UDixuDGbpJTp+zW
         jUKA==
X-Forwarded-Encrypted: i=1; AJvYcCVfRHG/k8QDQ1ZKBRAMct+wUPaGeOcoRz6t2Lnw8o+hQZ0va/VMlRtwoLogZ3afOYc++ivm+hrS5FL1qVWI82nmKkWdyUO51+yQBlLe
X-Gm-Message-State: AOJu0YwMf44xzq/4aSAOXKjNuUMBy+JjwhP99RRCgsv0G3WLy/p/bM5D
	uTU8ZTVXemtHa1kRC07ptmmJxkLtW4/Cps+7DYfJX88GFelaLLCcoR554WM79wph4uRMAsC0rrg
	bG+X3DKZei2lrOzzn5ovxH3260tGmqgs4c8WLzg==
X-Google-Smtp-Source: AGHT+IE8VfqsD0uTdG/aeXwz1tBQu3evMyjL6FRuGSeeGZJLNoEkLi0+zH8NDzaWDKXgLBog66EMzE/k98ESnu4pSWk=
X-Received: by 2002:a25:838f:0:b0:dc2:1f53:3a4f with SMTP id
 t15-20020a25838f000000b00dc21f533a4fmr390290ybk.5.1707860037159; Tue, 13 Feb
 2024 13:33:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213093108.13922-1-brgl@bgdev.pl> <20240213093108.13922-3-brgl@bgdev.pl>
In-Reply-To: <20240213093108.13922-3-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 Feb 2024 22:33:46 +0100
Message-ID: <CACRpkdYbfU3LV=+xEiE=+MN4xc-_zc_6WiNOP84_PzqttCsQTA@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: cdev: use correct pointer accessors with SRCU
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 10:31=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We never dereference the chip pointer in character device code so we can
> use the lighter rcu_access_pointer() helper. This also makes lockep
> happier as it no longer complains about suspicious rcu_dereference()
> usage.
>
> Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_devi=
ce with SRCU")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202402122234.d85cca9b-lkp@intel.co=
m
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I had to check what rcu_access_pointer() does and it's clearly the
right thing to do so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


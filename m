Return-Path: <linux-kernel+bounces-127935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8AF8952F8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A7F28445E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763AC77F15;
	Tue,  2 Apr 2024 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mc3r2EQe"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393D91EB37
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061018; cv=none; b=SpYlPdBL8HWX6fy7ddpHSXeg9/YfPVVFF5fm0r4rEYgo4nSV8gDKJVg7p0VTyhKXb7+MphtGTt0Fnh3WEWMwVLy1ilyvHocS64V1id3Be/lpM33UdGcqwqWon7mPU04sEcOvKEkCjPLVgQlqJg2vBRIszR1R5p8wA5d96LuRRW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061018; c=relaxed/simple;
	bh=Zs7RYzJuxbghkdLPqGTx29qLDxS9pI02mK9pwl5L2Vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFyfteqtt+ZIf4BCLZJUSn6FEj27hc2grQEj95VX4DB9Jp7w2iTwf+wX6lGvJnmVgW7mAexWW34B6VI7O54Z1AfibqCzfb9SivRZA7xJgDLdOVbis28foWxTkm/Z3EtKUqKTOi57U5UX8mYwI41H7AMwojvOgW0akpsLSoLCRus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mc3r2EQe; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcc4de7d901so4051371276.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712061016; x=1712665816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIcPIkXXOlhDttAffO2gh5drI+8AQ9cgDL80itbQeww=;
        b=Mc3r2EQef3j/j0PJ/EZzAut1j/h+so5o6H2qGqCvmQ9aDQody/BCsAQjCJhBOnUe6M
         wIDXLuZcHFW4IHuhdHEL5uBbHM3RcvQqd1RGxD1qUwAa+3c2sOHpn713S0D8DwCMhhmK
         nqfVaYTcbW+T3VGDELI/a0BAPdPB7ApZr8m6a6k/Sto7kJvZMh9Uw7Jkm5HVhW4gWZWS
         5OwVvoYdi9/rGZYHT8dIvOIg8/KINo8b8GG54u1tgZvqyzwJEngCRYJKBBxBPLkwcDxp
         Q/N7+2D+PuIMgqmGdnViYq0phkFdTSVkePeFodMIovaYkUc/6jCUmn43nNy8yyIhb8A7
         PWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712061016; x=1712665816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIcPIkXXOlhDttAffO2gh5drI+8AQ9cgDL80itbQeww=;
        b=ibXRgBi6wBO/mGiOA5JtXWSh/lS76KQ6v1grDAQWXw8ilyW2DjQrKFYir8vcTm9+b4
         xg83LIfVoqnGkeg76gVTc5aQNDoLPLzZEZnE6f4SdPHXrJfPbj5MGH9NXFqguUmemQIE
         n/6doNWJ+kShLUXRuQN3tV4GF6wtowdxrT4L3+tIPy4wzpK+9HFEUU7oFcRgGfmNgrqO
         51udVpZOo8YfQG703kIA+gHqs/igA7BfSECzbYX5fDiInxNVmV3NWAPIB5mc0j2KENIX
         P4vjba/ktPEkRdjuaykAJ7f7Ok1Xdn236zz1gFb+9rG8vAsn0uOk6uJdZIMJMN6Ex+QN
         As8w==
X-Forwarded-Encrypted: i=1; AJvYcCWYUWxNL+MemkIrMmppW0OZg6yW54EpwLMtIidBo+vJzEwt9HMKa8JzTUep8Dvl+Gi/ikDqCx43XGb/Sd2t56XYOLZoAC6pANOeSnJw
X-Gm-Message-State: AOJu0YxEneGEqUZxf1HZ7+U33V30nM1j2XJhIa6Pvgi3w0RYPSkvCJhN
	WnjQYT3V02dlm4Gasxb6hs9HMX/PAttqmzqeixwPpPEdXrViuAzHgHjYOztQiPpxW+H+qqcrvNG
	JEJBNchh+7ugFnPxZy6rt2SuHGNzhm5SqaoT2cA==
X-Google-Smtp-Source: AGHT+IErRszW5P64U+kk4mUR3NVbU4m6Fv323kf9eS0aVuwmDLT5AdRvQYEQHF2q6E575YZZsy2hpqyd64ENJXefK/g=
X-Received: by 2002:a25:807:0:b0:dcc:a446:553 with SMTP id 7-20020a250807000000b00dcca4460553mr9476757ybi.57.1712061016321;
 Tue, 02 Apr 2024 05:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-gpiolib-find-by-fwnode-stub-v1-1-05a0ceee2123@kernel.org>
In-Reply-To: <20240322-gpiolib-find-by-fwnode-stub-v1-1-05a0ceee2123@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 2 Apr 2024 14:30:05 +0200
Message-ID: <CACRpkdZn+eZEa62ZjttxS3sgT63t5bRtpueFmrG3fsrqDw=xSQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Add stubs for GPIO lookup functions
To: Mark Brown <broonie@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 5:14=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:

> The gpio_device_find_by_() functions do not have stubs which means that i=
f
> they are referenced from code with an optiona dependency on gpiolib then
> the code will fail to link. Add stubs for lookups via fwnode and label. I
> have not added a stub for plain gpio_device_find() since it seems harder =
to
> see a use case for that which does not depend on gpiolib.
>
> With the addition of the GPIO reset controller (which lacks a gpiolib
> dependency) to the arm64 defconfig this is causing build breaks for arm64
> virtconfig in -next:
>
> aarch64-linux-gnu-ld: drivers/reset/core.o: in function `__reset_add_rese=
t_gpio_lookup':
>  /build/stage/linux/drivers/reset/core.c:861:(.text+0xccc): undefined ref=
erence to `gpio_device_find_by_fwnode'
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Since we have already exposed the innards of gpiolib as much
as we have I guess it's a must:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


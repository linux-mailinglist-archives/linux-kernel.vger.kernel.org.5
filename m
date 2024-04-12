Return-Path: <linux-kernel+bounces-143260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6958A3666
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30BC81F21E6E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A283314F9FA;
	Fri, 12 Apr 2024 19:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EXAg5ydK"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A782D14F9F9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 19:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712950290; cv=none; b=p9CAWFGS3kcX9e7TmyCY5J3NVeESbKwAMQSeRtRuPvgsdGEQwCvKZ9QiuttBzZx3BgJ0+CWTzzcBSRu38sWqF6M4Zzwh+DF0LILkTA0dwXk2j2sLbkz3PckNdfJs7hwghq8PuMMZPvUrBqmp6fSNnVVYs30xellkcc8+Hdf2hvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712950290; c=relaxed/simple;
	bh=+cCQ1ug2Y71PWJDzryrMeJPeup48fb/gLGtRLAjnQNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZ7SucnLFTfu3WJlbPCbsv+/sY61t3PIW+MfnEetqmPVdghzu+EMv7vB6Mrs+ocbLR2dLrNsWCfyuUWOzEvxSirYtVMAkWQQyxu/UUSbsrTzubfpmDuiY5nxfhA7PBmpV3DeC6I4wOGfUe7bFYqMq28erhMAvhQEyi+LGJvhf10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EXAg5ydK; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d8743ecebdso13793791fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712950287; x=1713555087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDtRm38b+9GJbuqV4jT7bN562A01RuEMw7juSo3kmpI=;
        b=EXAg5ydKKlIY8G4JChgE9JXomMs3OhYh99rwjJ9KSAMCneQygnclQZVxtsgmzWJbFz
         06SReXGhlffzjnKnZG3Jv5DVg7WjI3AOHslIEk+oRft6AFGkO7ggadFMR7PkMsIX4gXG
         eMKSEcQjGVm3E28kwUrxyecuNh77R8YdEodcDhn/XG49YCvRYpV4iyvXEnGNO+UrbZMA
         cGQbNt3ETc2EdKkCSL8a7HDrH2hW8KJPlzuWqiafvD7My3G7cZm2nKyRIPnz79dLpXHh
         xn2mlBmzcxNUbZNoaTmEN3jQ7MjT6X3H0s/GHWgrUEwN+B6NPlKrHqjzySIbUmDjB7+J
         BEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712950287; x=1713555087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDtRm38b+9GJbuqV4jT7bN562A01RuEMw7juSo3kmpI=;
        b=KosLW5woZ62LIgbfnEFs9ng5E2s0rnNHvmutLmW+7g65MXIUDUjjdCf0Dw7cEAFb2h
         GpAA9sWlrwYeRePTqkA1MDpLst+P5iNyPLRvSaJXPdNSVAqTqqBMRzPXS/3CcpJbelwW
         OaiktwhfQ6xs1EmVvVHR+C+ns/H8vBpOKaqgElR21LbRs7DIfpmxGmEcl5hQS09r/Vp7
         ZowUJtrbYH+WcJsy6RiOFEFABM9WOUXg7S8FMZcS1E705t9DHnmtTAR17C8NrOrlFflO
         Sr7W1kSvcWggR+Ajs5Rfrv5XhSr0QuUunh9rnie8EHVRe7cfmZv88sMg/qeAU5cY6Ps8
         hrPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyJXLFKlYi/GSwSO/Ng/2Kr4PtuQ+hG36z4yn+7zY2OCoWMuAC2kNdER6NePi1uhWCULyLH6hYR6RqOq7+xZ4uNrrvAR27+nHGFmJB
X-Gm-Message-State: AOJu0Yx+btrBrBuBjy8OkTd7cNjaftw/jX0LC4GrhPC7BNwj95Wy6YFd
	c0q5+WTotPFjRWDJISUghnG2742kcO5r/t9qTRPTUOgrakutygXVumBMQWTETcqsl8BLdIpLX7l
	5Fs8hVeikhfmXmaTuZ+vnwQxY/DDDLS/P7VRLeA==
X-Google-Smtp-Source: AGHT+IGBU6hkZqKeprFG8RmO4hkyhuEE0dUJ2DATz9JQajmHqiOX5KRXixatD0+1pp90KQcM29UUas6bSqfRnknjzBs=
X-Received: by 2002:a2e:9659:0:b0:2d8:2710:c64c with SMTP id
 z25-20020a2e9659000000b002d82710c64cmr2787581ljh.1.1712950286947; Fri, 12 Apr
 2024 12:31:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410170305.248683-1-krzk@kernel.org>
In-Reply-To: <20240410170305.248683-1-krzk@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 12 Apr 2024 21:31:16 +0200
Message-ID: <CAMRc=McN_unXqJyu98=qAjMkp=GdqO7dXtTfO-HmrzDR18Y4Cw@mail.gmail.com>
Subject: Re: [PATCH] gpio: lpc32xx: fix module autoloading
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Vladimir Zapolskiy <vz@mleia.com>, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 7:03=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
> based on the alias from of_device_id table.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/gpio/gpio-lpc32xx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpio-lpc32xx.c b/drivers/gpio/gpio-lpc32xx.c
> index 5ef8af824980..c097e310c9e8 100644
> --- a/drivers/gpio/gpio-lpc32xx.c
> +++ b/drivers/gpio/gpio-lpc32xx.c
> @@ -529,6 +529,7 @@ static const struct of_device_id lpc32xx_gpio_of_matc=
h[] =3D {
>         { .compatible =3D "nxp,lpc3220-gpio", },
>         { },
>  };
> +MODULE_DEVICE_TABLE(of, lpc32xx_gpio_of_match);
>
>  static struct platform_driver lpc32xx_gpio_driver =3D {
>         .driver         =3D {
> --
> 2.34.1
>

Queued for fixes, thanks!

Bart


Return-Path: <linux-kernel+bounces-25576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1A682D2E5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 02:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A8F1F211D8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 01:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F040415BB;
	Mon, 15 Jan 2024 01:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICUEfyU5"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEE8137B;
	Mon, 15 Jan 2024 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-559533e2503so205686a12.1;
        Sun, 14 Jan 2024 17:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705281104; x=1705885904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1rZ/h3cbN1N5NXVmLdpqMA/KIcAJWlHyWzl1o7Zy9M=;
        b=ICUEfyU5ZyebGEpHJk6XSwwGV8RT38NUSDqt0sHTSvEmsLEqRPGc50HTGylvxMxxm8
         23PE0ykJHp4HZKx9yyA81QgkMZ0J9G2WaBc4FdsVJZARt3tH+c4HuckKyiELawhpjzc4
         kTZDXwYOExHXFeEwijUy91EBxmvgNcsZiFg01w9ll6eH2bNdgEwMc02c0jIJEZtGLN44
         ly/NbwW462XMH6iuP8i63FmCtlvXLx5/97hbm6W5qjcsvgl5pnaPr+A+LRFsnjZG8Fum
         fyq8Y6b3EhEMwWj+oK/gaK2DZmnp9VmqifjfymB9TBZA/rvTB6Shd8r0MtaxaKxUXi74
         T5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705281104; x=1705885904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1rZ/h3cbN1N5NXVmLdpqMA/KIcAJWlHyWzl1o7Zy9M=;
        b=iBdx12SXOBnZVeu6Brj8yPH9liTSvbYK7sFZZm64de5111VV19kkpBXKJSvX1PPytr
         wxRlTL3PZMmsYgvV1ps2QVNctHLu13WrxBnsdnL3GvhMqB92bMxcfWzTUsu4CwecCr6J
         oUCxPueBiGH8V6k53ACJMwbq+mtjiqj+IRZm6lWHnUF8XmepM1W7XUh1gL3xIYa3Tn89
         rEdt1A8b/3eeCHjkActHinkE4of6q0xMR2Xr41DBe2HhBO2SVvC2/8M4epdzmP9XTzHT
         CZpzCgYoJji4cr8cs8XYwm509SqDrxSrFUAhUP+apBr7DYtcdyMlupHpHYno8lJMWJJp
         CWCw==
X-Gm-Message-State: AOJu0YyNUMGk2dFwdasyi56pXeET15WRE0810uiHs/7MlfEvyqMJ5SdH
	wZddDvm4ERlXarfXHbXuJqfe/k0WyShzuxsz/0DOAB5cpjRmfw==
X-Google-Smtp-Source: AGHT+IGMzGMmVfbToyYFSO6pXP0C/5IE8vYyXQKoEkr5uVIYZy80btPqqri76tSRyYSertCLltSpl2M2gBRTfFS6+K8=
X-Received: by 2002:a17:907:c284:b0:a2c:b1f0:eb5b with SMTP id
 tk4-20020a170907c28400b00a2cb1f0eb5bmr2252890ejc.43.1705281103803; Sun, 14
 Jan 2024 17:11:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115004847.22369-1-warthog618@gmail.com> <20240115004847.22369-2-warthog618@gmail.com>
In-Reply-To: <20240115004847.22369-2-warthog618@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 15 Jan 2024 03:11:07 +0200
Message-ID: <CAHp75Vc=oZK=VR6vZ+kTapq5WpySgKVjAfuO6mxcPqPfQe6VRg@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] Documentation: gpio: add chardev userspace API documentation
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-doc@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org, 
	andy@kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 2:49=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> Add documentation for the GPIO character device userspace API.
>
> Added to the userspace-api book, but also provide a link from the
> admin-guide book, as historically the GPIO documentation has been
> there.

..

> +.. note::
> +   Do NOT abuse userspace APIs to control hardware that has proper kerne=
l
> +   drivers. There may already be a driver for your use case, and an exis=
ting
> +   kernel driver is sure to provide a superior solution to bitbashing
> +   from userspace.
> +
> +   Read Documentation/driver-api/gpio/drivers-on-gpio.rst to avoid reinv=
enting
> +   kernel wheels in userspace.
> +
> +   Similarly, for multi-function lines there may be other subsystems, su=
ch as
> +   Documentation/spi/index.rst, Documentation/i2c/index.rst,
> +   Documentation/driver-api/pwm.rst, Documentation/w1/index.rst etc, tha=
t
> +   provide suitable drivers and APIs for your hardware.

Very good note and would be nice to convince users to follow it:
https://stackoverflow.com/q/77683532/2511795
(OOH you might be proud it's Rust, OTOH as described above)

--=20
With Best Regards,
Andy Shevchenko


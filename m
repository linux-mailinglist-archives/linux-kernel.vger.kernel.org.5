Return-Path: <linux-kernel+bounces-47057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE128448A7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D01441C22ED4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00D63FB3C;
	Wed, 31 Jan 2024 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y92jwdjN"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6303EA9B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732384; cv=none; b=gCI9UOe0raBZK3iYRxetEVQ44RIk5Ucdz0CG+TPS94A/p1AKZqX3hsX+vlOMXEXWbLesOaOGmNcOMUM1w7wvFcnwVUSmfTmbR+N4D7rsYZcKxrr1n3kaQQjg6ac3nMHwPV2sHxZuSzQ30Pyd4c/JrD9e18TLAMrn+hWagk7RZTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732384; c=relaxed/simple;
	bh=mRETN4tNpgYw0SYp2SiE61n9j1mg46JW7qEzbatwht0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EN7cXyJyOSiXrO9U82R4r/+rNXWhM1Mcxd1mhhUNx1lUw7Sxf1Iu+IH4dlG1dvAwr+bITOUrSuJKRZCNfpOAvdFMDJAMzN/nUeFAOyfzNdv4vN+FNMV+4pc/CRqgY3mKI7241X0OFs7lpv5yNQxqX7pr5Y5cNZdnt9pkFDrscxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y92jwdjN; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-602c714bdbeso1114307b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706732381; x=1707337181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRETN4tNpgYw0SYp2SiE61n9j1mg46JW7qEzbatwht0=;
        b=y92jwdjNxWnlo6X7PIexmFXmE2QH7A9r1rhjWGATunwqnFuYrV0YFon2X4/cB48uhD
         4fJc/BqObsGln/w95o1Vgx67p9qQnad0PapgpNOMG3CX+0oaVqhg3SNXKNRWUjIk5YnJ
         zilovoOI0wUy6LRP1Qr3g3VxrR/g/bzTWMfCCiapfh1c90Y3s1NPv93Tmzp6VQf723eS
         O6M7C6nsB+1V7dJ704zSYeLI/i1fX687R+mOXf8ECwIbZdTGB83jGtS1hY/IVOBtPVIP
         vS7lNrFBxZmC9lL3yxhsrMDOI0mZEk8vH3v8YI4kTuGwsGdxCi0d1HPYpQcxUAbLM9LB
         uF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706732381; x=1707337181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRETN4tNpgYw0SYp2SiE61n9j1mg46JW7qEzbatwht0=;
        b=RcmTnSxe1tdNYIqdeJxvUKmpdwbsQV+y55aoNErIFYw5yk+wTSv6QnLCDquoSf6OMb
         +Nb8NOZXvrf0MRBUp4yalA+4Ovkcu/6x8IRmlEHKotj2Ui5yZx/YBW9evkHnefX6VAUf
         bzzQE5iR70gUDQ949Of0m+q2gv6fiCDUpi7g0TWOfYsaA13XUVpuKqIwICUDQMbA1L40
         kwBv5KzfD+HJ+eUCZNijz6DrUzQCFkRD+0mtwdwpk+I79gBnvon7ibja4PU3jPniWXEA
         o18HzQVLttBNCQ5Qd2zOPlSAAN6zURhAfXR5rZi5KuZtEbVxkzo29NJ3G7P9EMU+w8En
         utOA==
X-Gm-Message-State: AOJu0YwUmhgHrL7YWafpCZh/ezPfY/xVAc2/dJp7Y0s4ollrneeto2Uv
	bX+u/EavrdUrpgfMn2DR+UFGe5LsRcuyNilu7ymcKvlKkwWzuhCd44PFvg5IKQTBj2oCHHMD6FX
	4XssvDWGtvBjmSUqMcVp+StceTMjn8+vp4yz92A==
X-Google-Smtp-Source: AGHT+IGpegJBfIDZT9mA1jSmv3BI7GDep8ArM6hXT7dTDnUAmqNT30PJsr1R6/YpQQXqgZ9fJg61h50uoxhQBUUpSbU=
X-Received: by 2002:a81:af4d:0:b0:604:151d:20d3 with SMTP id
 x13-20020a81af4d000000b00604151d20d3mr1028904ywj.23.1706732381527; Wed, 31
 Jan 2024 12:19:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130124828.14678-1-brgl@bgdev.pl> <20240130124828.14678-17-brgl@bgdev.pl>
 <CACRpkdbCBe+HH5uuh94tx9ezV0xtBO-=DZp22bUBbbYuEtJ3Vw@mail.gmail.com>
In-Reply-To: <CACRpkdbCBe+HH5uuh94tx9ezV0xtBO-=DZp22bUBbbYuEtJ3Vw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 21:19:30 +0100
Message-ID: <CACRpkdaVtzXnX5Ef71UGS8xKyZHF6Pm+DWk9DEGvx9oVOBbUOg@mail.gmail.com>
Subject: Re: [PATCH 16/22] gpio: reduce the functionality of validate_desc()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 9:16=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
org> wrote:
> On Tue, Jan 30, 2024 at 1:48=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Checking desc->gdev->chip for NULL without holding it in place with som=
e
> > serializing mechanism is pointless. Remove this check. Also don't check
> > desc->gdev for NULL as it can never happen.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> I don't know if I agree that it is pointless. It will work on any single-=
CPU
> system and 99.9% of other cases.
>
> On the other hand: what it is supposed to protect against is userspace
> doing calls to a gpio_device through the character device, while the
> backing struct gpio_chip is gone (e.g. a GPIO expander on USB,
> and someone pulled the cable), i.e. it became NULL, and this is why the
> error message says "backing device is gone".
>
> But I want to see where the series is going, maybe you fix this
> problem in the end, so I can come back and ACK this.

Aha, it is fixed in patches 19+20. Maybe mention that we add a new
protection later in the series in the commit message?

Anyway, I get it now!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


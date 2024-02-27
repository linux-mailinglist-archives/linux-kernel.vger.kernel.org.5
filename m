Return-Path: <linux-kernel+bounces-82981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77723868C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323BE282472
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3267137C56;
	Tue, 27 Feb 2024 09:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gkJES54X"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB94137C4D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026896; cv=none; b=TtX2QYKXIvUuI7yB5F7sYIdrZL9r6BXoI7xxN1K/8vO8XqH6LkxqE1Cwq5mvdCqyPPs0OceKfc2nStk9svopxwd3skJ+qc53J4tGGBhlO9H40idU9COtq6l/8D06mW2bkAwzwJND3nmO5lo7gdPe5BgPePHvOhGqhrRbQkPWcUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026896; c=relaxed/simple;
	bh=yHPFRl2mqSgcoxbtbCsPH8G6VO/2zl4zaTGrgQVkBF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fuQ8KRPwnrAhawnusmnLfLnR6YDd4c2MKmzDlag9wdH0Cnj/+U81Ujf3q7WY8m7J7Rnf773lYzyOcmbrMnZat8Z22rutV01/rlQc2axFaYVmloN0l5S1f/xwcfvIcHFwG5nAftgZcKJV3wRIsixOi3IPl0PX44f0hIHi4D/KSQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gkJES54X; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso2002515276.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709026893; x=1709631693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHPFRl2mqSgcoxbtbCsPH8G6VO/2zl4zaTGrgQVkBF8=;
        b=gkJES54X6z2V6FfkRt94mZbhrUhv3HDpu1mp9xSGhDjpD7QsqhEndJFC45VCxMmWhN
         xDxlQ6QAY6k3dK1qyBVYZLaekuHs7uKKqHFWWPyFBRYjBoXVpAiWM35vekbvOYUShyZT
         wp8M0OHdWkqVaLimEN2RXtsnvD3TB/3KpeqiXhETLJtrj/Aw2T6m0sF0cgzut9qZ+/Cf
         jVR55yYGp+xR7PBUing82MEGNrbaSnQquIDrhtu26fNkkdqyQogepxNIWuTWHTn3saRE
         WYW0YItsGIYRxXEYgeWjXt/VZeCIbqmlmY+eVSMrO+M3iCrixaiNX7OLLkzQxLz+P8kK
         sq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709026893; x=1709631693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHPFRl2mqSgcoxbtbCsPH8G6VO/2zl4zaTGrgQVkBF8=;
        b=jC0WlRu+ljsgzuH6NGA9dhB7+uMQG4tIPuKO/kzpfoMNnrKwG5K4sdKxk2TEgvIVVs
         JRbaTqCGNSktBEzrytr23ds/D/4lLloBAUBXUViuc9OaOEpV8vfh9pXycSv63Wpub/9c
         znXU158TdZkFPPfScC8ei7/cL6KUCSRbeXJ/cdOCLOs+EQKkrZSUh49P3b9vP8hk5ijK
         NDnTEh/hneFhn+c9+MaKGmYo+L9Fx3ftXGEm/qYZph/UZa77HhcW/c9D0SmuZVuPIVsg
         Xn7zTLNqym7nf8yuKpmHFfFGV6a2mhPflLg043zZDmCdLJqMu9ycPaKtHf/nd6uzNu1J
         O66Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuAdgMAb9SntYbsSFU5UBQR/7crSs8XgVS9xFlbYgwEv/WmdGqIC5nk0MgBsDwoGeQ+5Dcrn5773uRfckDgVK4WLUAku8y759L1ho2
X-Gm-Message-State: AOJu0YxAa9Ud1N6IVgKzOGSZKqNhnrbCv4aLzRAQQY5vug1dJP/vDQ2o
	SSoDlQpRmZ+f6vDqDtj6U9aXmzxwRVMvcVdtJOq1hblByPAjeoz+1ROXmWKkEwn3/MQguMPTj3l
	arUzxlO6F7HpB+w/5hRXvtFn5IJfxpq2pKv8peg==
X-Google-Smtp-Source: AGHT+IEGeQH9qBNerwILlDn6Yn5rwe8dUF3pjMomroMNj1UeWVIbZ4c4J0dTKPrCGJj9SepP+2/PIWhFlhbc5AL7NCI=
X-Received: by 2002:a25:d60e:0:b0:dcc:3a3:9150 with SMTP id
 n14-20020a25d60e000000b00dcc03a39150mr1769321ybg.22.1709026893169; Tue, 27
 Feb 2024 01:41:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221213208.17914-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240221213208.17914-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Feb 2024 10:41:21 +0100
Message-ID: <CACRpkdY0jooZEZcyug7jKJC9TXnKNPt1u120nXE4dgCWQta-ag@mail.gmail.com>
Subject: Re: [rfc, PATCH v1 1/1] gpiolib: Get rid of never false
 gpio_is_valid() calls
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 10:32=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> In the cases when gpio_is_valid() is called with unsigned parameter
> the result is always true in the GPIO library code, hence the check
> for false won't ever be true. Get rid of such calls.
>
> While at it, move GPIO device base to be unsigned to clearly show
> it won't ever be negative. This requires a new definition for the
> maximum GPIO number in the system.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks right to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I guess it's related to the patch where we dropped <asm/gpio.h>
and ARCH_NR_GPIOS because after that a lot if the semantics
were removed from this function, but it's not quite a fix more of
a cleanup.

Yours,
Linus Walleij


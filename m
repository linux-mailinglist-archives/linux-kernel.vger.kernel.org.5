Return-Path: <linux-kernel+bounces-122594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 806C688FA38
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23CD1C247CA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6879B56776;
	Thu, 28 Mar 2024 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F9RIgOAC"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4807855C07
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615490; cv=none; b=BFYdjTHuIjcONEmqGbl/cVFmdnORxR5QY/xe5FXXXr/8suXsaqTub/mpSNRbja6B4z72qPjan5+6FM6dy7/mq7XGX58/u4QM0yA67I1KNK3Fo6r2LrWSNhXr450efm2uei31BBMUbo6etPITm63ljKicMrjBuXN/db0n3on+jw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615490; c=relaxed/simple;
	bh=Pxg6IUYzsoTznUX7vcw9sN15lB0Uu/xj7gWnXvLPPT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZroIWELYqJBNe77Pbq/qoXkSh5uL+36+xzbb9TTf2zWSgvLdopAmQKJv9Vx0Rt4uJ0Ah05pOnL0Gie6wnl0GhFOw1C2wxP50908sfOl3TlHYx9dqlTMAJXOM43MdByP2ZNOPEKgOqsk4hKvuOlSGbUTvgA+5v+9TtZ5t5lO3Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F9RIgOAC; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dd045349d42so627692276.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711615488; x=1712220288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pxg6IUYzsoTznUX7vcw9sN15lB0Uu/xj7gWnXvLPPT8=;
        b=F9RIgOACtY7Ln9zFuT++EpEfI7ABqSy2aS7LN8+7xvHfdAr9VtxD9FdQJCed9PmnbA
         S2W8NB1ZTxzZ0D81aSDuNWLvqPJ1gcIH1ct8rRjuAhFFbfYTBIbvezwOeVJEltGmX3GJ
         6xWaCNAZDSa7UfuPSkbS753t+D/Xz27NeJc53RSEsIvbeY4+/lvOegEAvLLjatw5APy0
         5MUM8NpcoSXVl3eC64u4j/9uJcoqyOPdT4vp0lvDXxp/ExGOmskdpq2ZGtCTqmHqCpLp
         FxiOdStw5EJcFJhomUHjp6j3EGAwspuO21BKpKXo9DoFmQPQqV0vrnsPzmnsjJgEqG04
         pAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711615488; x=1712220288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pxg6IUYzsoTznUX7vcw9sN15lB0Uu/xj7gWnXvLPPT8=;
        b=R/fwHxhdx3fvxh2xWYSW1mnVJWP0dhhgLlx7KEiW9tkc864XQtju8C9V7bD46EIgjt
         qK5kLLQLfdW9RYBca0zvRaj4ShAi1Uo3oimx+IJZe1Mr931mhU0bpZSY+JKAS4Xk0gca
         U+nDoC9/OLMC3tWi1sq7bR4NsQKZGbG+jnl2SmWsb2h3zRUakRT+5RMDEqTBBHjxn77L
         WuhB7Rn6JRyl6dqouN4b/YFy0CsSBbQ81Evz9jLr2wVOHq6WpshdHRtntX4hve9dufX2
         4iG3DvVCLf5dPyLZJTdnds0BO1kV53vVceWpidMH62mLmZD67KneW7su5mXfn5yOGnDl
         RZ6w==
X-Forwarded-Encrypted: i=1; AJvYcCVpn3Gojq5kz+z+BK85yrwDb2XkotyQiICTWAW/jQHWTyaKO9KKxDJS0H2kQmf8dY605ew0DbOKTfTBajBqcHDfv+a2iCBn7Q6RoOk/
X-Gm-Message-State: AOJu0Yx1y/dkZAtpSDeDBLHFgYaxxtbqPZpOCHoAtvp6STgmX417lZHF
	rsMQI4lv5oQCyopSi+ZdvcACdf4jPVY/hFykWCb0wJ/0lFIPIF4B+L8o51qIUJJZ34buH+cix9r
	te9ELbJrQfswDseeY+fkWIH+B9rkaFmbuAk76HYWQB/ahqgNX/ZA=
X-Google-Smtp-Source: AGHT+IGcAn0RWps9oXY9GZljw77ZRlGO3gv6r4U3YqCqjwkkeOy4XucBWwQWIwNFeapvqv4z7ByXHzgjLqMMVEeXcLQ=
X-Received: by 2002:a25:6a03:0:b0:dc6:a8c6:c9e5 with SMTP id
 f3-20020a256a03000000b00dc6a8c6c9e5mr2140753ybc.26.1711615488453; Thu, 28 Mar
 2024 01:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311142346.1261203-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240311142346.1261203-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Mar 2024 09:44:37 +0100
Message-ID: <CACRpkdZ-FrLBzu=nV-PjwMaS2BL3TDeKB3m9BhUfWJhmkoP7OA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: pxa2xx: Make use of struct pingroup
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 3:23=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Since pin control provides a generic data type for the pin group,
> use it in the driver.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied!

Yours,
Linus Walleij


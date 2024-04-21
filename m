Return-Path: <linux-kernel+bounces-152584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE118AC0C6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 20:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755831F2147C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 18:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507283D0D0;
	Sun, 21 Apr 2024 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FVYxAKZN"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3B810A35
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713724422; cv=none; b=Ow8Am5CAFTC7r77IJZkiI2Px9cRzGmOFqE0IjUzQy9U7ydVFXk6iBfp2Gl/y18IvnlME4s7nmMHoxth5wuumQQN4yAphCe0gfzlozoCQbOyTJEhi88wD8FtQYrMe5GO073ur0PPO3MNdR1jWDl1VPC0iQ0w9V/keqNL048c8xeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713724422; c=relaxed/simple;
	bh=hsd0XsngwlbXYU49bRdK/iSsfg2UjS5QGrVkSmQDT4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMTuNfKepUG5/oGE7hu3+eN1SIFaJY2TSsiy57+INLE/zcYeV+CUMrWXvJg/BFlI63qdtLg7FsnT2+1fZ3oFR+zpKf8EjVKef+iPDEvtR/kJXV+m1HGWheLwchs9oYvxyvKSapDgB0N8AiD99sDzVgCvBxYXOltutGwE7oR/wzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FVYxAKZN; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc742543119so3616649276.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 11:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713724420; x=1714329220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsd0XsngwlbXYU49bRdK/iSsfg2UjS5QGrVkSmQDT4Q=;
        b=FVYxAKZNvxVbI1Pbq7z6uyjuRz2H8wGO22Xzf/79tmrb38tSFBLWJr0ctBt0RTEkj0
         wEkodXUqSxLrWEDakRzq/7tnBn+lHOHuBPb8+SVLlxBrb8HqXviMT6LLRCRkQZ+R1DVS
         yz8HIenw9ZpvmMXUue+h4hmIpsEIVeKJ2rqgtvpOmk9S5yul+sRd3EibGk/hXcexRzHa
         tSb1QFCRMwOdH6KhMlkOSxI1Y7TNqJk8Y395IT+pXKe8q6MSYNZqHpxdHq1OyjTbSAnF
         nCUlWlGDuXaV97r10gy+AxCOK02BpTEjWDIA+OQv59zrEtm+6x4azSiZ5IgudCdLDY5Y
         5saQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713724420; x=1714329220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsd0XsngwlbXYU49bRdK/iSsfg2UjS5QGrVkSmQDT4Q=;
        b=ns1jgymxW1tC+aV+/NK2DPXI6G9CIkAIF5i6a3Xc7YaGB218poYrAMEpuVqMqocIYA
         Fzd96ONYs/eJQauuuDFos5VvESUItf0KXiiU5Qd+9OTBlIzjveoY9J57RN+xJ3+B6Ps9
         /umqIRLYfp6eDcSd3rSpHIHbzdN8HDRyNBsrgct9XMGU/SbIi7cUOjx8Jb/VF0bgqjZD
         s96mF91fB7hd0Ha8K7VRxQl/bZJuKT8HrGlMLg01mp5pzSAlpWW7k5wsFKSA1KJWhBee
         D9eWB0zu7+wV2UaDx5IUJtxXY1TAKCVItfqgPuCzpADvw2XZB8n6aFX8F9zThVWQkYD8
         M5yw==
X-Forwarded-Encrypted: i=1; AJvYcCU6s2yXPh68jU9j2ICKTet6fCvffL7vaswwRnvv7Yw4CrNBtzjaC8OVc/bCT3GubYBXye9NambRumffbj9rQZnhPnRvAtZD2BxCoXbY
X-Gm-Message-State: AOJu0Yw40P1ZgNKhjtcAeX1nJY3ayHJOEFGXagBrNw13fz3SvGNWXTTz
	P1L/l7RDaalmmiMrR01OyzxntxkEI6TpxCySLmIqFB6Ln150We5DFwK1qpxyBZP8OGTZ/mI+nGU
	g4l/Jy+A07B018vusEwK1hdvzv6LBsnldOUl2MQ==
X-Google-Smtp-Source: AGHT+IEBVUribVSY4UKaYpUkmakZRxw/KOBF8S3bALynu/ZOsk+rr2ucErnlvDBowMnVOwVfVqBQlASGwJRKpPIpzuo=
X-Received: by 2002:a25:b222:0:b0:de4:8c46:e7f9 with SMTP id
 i34-20020a25b222000000b00de48c46e7f9mr6363423ybj.31.1713724420140; Sun, 21
 Apr 2024 11:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419080555.97343-1-aapo.vienamo@linux.intel.com>
 <CACRpkdbSB+JTdhGXViWs-SmR3nUnm6dVXt3WzK-d4zFSz63XxQ@mail.gmail.com> <ljyjvdtzhgug7frkiwbrvobbusnzqu5gpn345n5bjsmbuw5gjd@xex3dznz5jov>
In-Reply-To: <ljyjvdtzhgug7frkiwbrvobbusnzqu5gpn345n5bjsmbuw5gjd@xex3dznz5jov>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 21 Apr 2024 20:33:28 +0200
Message-ID: <CACRpkdYKo+HTwrm1BssJ9nm_xsGFsdRoqDkJWJMETTL2fwaP2A@mail.gmail.com>
Subject: Re: [PATCH] gpio: Add Intel Granite Rapids-D vGPIO driver
To: Aapo Vienamo <aapo.vienamo@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 4:43=E2=80=AFPM Aapo Vienamo
<aapo.vienamo@linux.intel.com> wrote:

> > Can you rename this:
> > gnr_gpio_configure_direction()?
>
> I do agree that the pad part of the name maybe isn't the best, though
> this function isn't just for direction control, since it's used for
> setting the pin output state as well in gnr_gpio_set(). The idea is that
> locking and masking of the register accesses is factored out of the gpio
> callbacks and implemented in this function.
>
> Maybe gnr_gpio_configure_pin()?

gnr_gpio_configure_line() in that case, it clearly isn't a pin since it is
virtual and for that reason called *v*GPIO, right? Pins are a very
physical thing. It's that kind of confusion I want to avoid in naming.

Yours,
Linus Walleij


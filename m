Return-Path: <linux-kernel+bounces-17404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E28D824CBC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2961C21B07
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031371FD7;
	Fri,  5 Jan 2024 02:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHAk27qn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14911FBE;
	Fri,  5 Jan 2024 02:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ccb6ddf651so3428211fa.0;
        Thu, 04 Jan 2024 18:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704420686; x=1705025486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmPAokCF8XiRAhvGBrhmqGsgT7mk/J8HnsnCH8uI4Xg=;
        b=AHAk27qnDZng4VBpj9+36AkAbKQqphnfZ1sfmkUaNXTloMRG4ivAYZvc3KDN1NS3lb
         3frEgACaBVkf4pb47MJUqrHN89ZWd4fvFHiSiDw67heUZa9+/6UWUhBzECkXQ0R2f/X1
         lCDl/58QgO5z7/VS/ZFrzZfB/7sL1/VnrLKSlQHmJpOQN1hR2Tfe+NdOPBIiIQD4BUCW
         jhIvxUlBYdLA01lrwILA3URGVkqmGijlhg2dpCAOkiqbZg01cgceCcJ0OfZcrM0hPmCB
         vDUqZfU6M0QXPJt+RWbMABasGXpOYiaiFm02Ke3vG/NEc8UTy8tft0EDXJjI8YcLLaDm
         5pdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704420686; x=1705025486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmPAokCF8XiRAhvGBrhmqGsgT7mk/J8HnsnCH8uI4Xg=;
        b=mH1m3gWu/7iXQrOQKDYUh0uhUgVHpGFixAXms7IpcvM+kJuTdKeFKjLZ1DQU86Hs8j
         NLb0U6H9wo0bQJlK9KdiQ8PyLX8NH5PPKC4iJJ0OdDJ+1aR5N+/xc1RN5jYoq6R9Z0U8
         G/kfNbCpUmYGhWf6wxabpOsNnhs/Ezwm31MbSr3KqyNq3xdXv7f2ObyjNT0AFcuj10gu
         UbSWYddapSXO87B+5HWwcKwB7GGhV5yF+2+1TFf1BBSsb2UzeaqejCdgcYaWSWh9E7E+
         7XWhActc6A/k9pzKSLzSu0ZHQw66e+iszZJs5QhxsRTWaCaxNUWTVZMNHif+rKCRiJpx
         cg4Q==
X-Gm-Message-State: AOJu0YxKOC2wHZ9UhlM4r/iXTGFy4eot5+qsNAkxbdOTnGXGd8Z0X+vS
	0q/6I48UR6XFo+kTLKeFeNX5lSqwwZo+bArMgIA=
X-Google-Smtp-Source: AGHT+IGLRoF1C1V3xSIo5Jv7tmG026oWvTJ29dQh/lwSN8IJv7p3WhV/tRlnTVz4yaIQa2wI1pk4vZgQr5AkCZhRvhE=
X-Received: by 2002:a05:651c:2106:b0:2cc:e995:9db9 with SMTP id
 a6-20020a05651c210600b002cce9959db9mr1623428ljq.5.1704420685526; Thu, 04 Jan
 2024 18:11:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104024244.12163-1-Wenhua.Lin@unisoc.com> <20240104024244.12163-2-Wenhua.Lin@unisoc.com>
 <CAHp75VfdCHnPovC+LJyVsh=SGTLXDoDowd+0z+0J-wDF2_yjCQ@mail.gmail.com>
In-Reply-To: <CAHp75VfdCHnPovC+LJyVsh=SGTLXDoDowd+0z+0J-wDF2_yjCQ@mail.gmail.com>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Fri, 5 Jan 2024 10:11:14 +0800
Message-ID: <CAB9BWhc0WyvMMudKcpuOw3=hqiWrC4e47fri6ywqYojULHnAdQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/4] gpio: eic-sprd: Keep the clock rtc_1k on
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 9:00=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Jan 4, 2024 at 4:43=E2=80=AFAM Wenhua Lin <Wenhua.Lin@unisoc.com>=
 wrote:
> >
> > The eic debounce does not have a clock of rtc_1k in the sleep state,
> > but the eic debounce will be used to wake up the system, therefore the
> > clock of rtc_1k needs to be kept open.
>
> ...
>
> > +#define SPRD_EIC_DBNC_FORCE_CLK                0x8000
>
> BIT(15) ?
>

Yes, writing 1 to bit15 of the register can ensure that the clock of
rtc_1k remains normally on.

> --
> With Best Regards,
> Andy Shevchenko


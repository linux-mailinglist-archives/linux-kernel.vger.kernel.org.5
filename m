Return-Path: <linux-kernel+bounces-12072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4250581EFA0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DA241C2138A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5037345957;
	Wed, 27 Dec 2023 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="cg2mbWk2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873C845945
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7cc6c88fb12so1981524241.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 06:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703689163; x=1704293963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwySJh/J4PGlkxiWlBxpZNUY6nu3Z/pDgnojJZIqxMM=;
        b=cg2mbWk240AAdxIpvAE9wQLiSlh5+1uyU1TmSGbkb5t9LLbBBn+uOUOhdMGYUGLqfs
         9gwJ4BvWhHkI4mPnFO3E8as7/SbSPYfli6Osz4a0kqMBJYz8AQFX6dGy36ARrgz0bk+8
         90rtfDxd7j9DQZn76biI2jAAzqY4kokmm8oz3p6isc89eoI4xJGz/igR+9E+BdNlkVKY
         WMkMepJW3CaQSJxOC13/y2fSAgKXzOdXhZUPYRbfAImHMiAAfEXjbxbRtw2cBNGIoTr/
         ThQggN7LoUh0AGX/rtHmezGJNciqhB6ADMENAwvhWFNBUS8TYHWXNccB7hj0FAfYUEbv
         5dXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703689163; x=1704293963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwySJh/J4PGlkxiWlBxpZNUY6nu3Z/pDgnojJZIqxMM=;
        b=hN0Wf8QZYj6QLJu63TQoYl8kQNQ2WfXderoA55dZxClL6cmlS2i3ZJKqg6nO6aOtyP
         Q/jVJ5vb61wswCZ7a+G8FwR7UdUQn6GIp96ZFK8RRKa7eau4Yjo45vL4I2yfmHscLtQl
         4rCeEuMA1rp5OUbzZoXSnhUgSJcpa8Dx8BfGL185ROdBp/44g4ll3Pk/z1rr3+EaQ8/5
         No9VkxF72DPCPMJL2o6G2Vn40TmJHV2AAlYqwlhecHIBqGVgDheYMzfxUz1N3IpRqNcq
         FydzWLDoltlOy0H/RUI/bHSi6l9cyhJoP5qtkXFsyIKYNfYtCUr5ypdk9/eXB6IZwtl/
         L4Pg==
X-Gm-Message-State: AOJu0YwZFUKq2JUtlYp+GfnJXo7lVlPW54jxgq/PKgdPVKpFc+IM3OR6
	WapT/Rwpx0fGU2cC3V5t6TRU4nHOboyvcoaED+bR80ELAa9eMg==
X-Google-Smtp-Source: AGHT+IEWvgutdHrCNZKp261VtrNGk+PsDQZ2EnbxomLnNrlQYwldRvQHCWXLaSB/r7H8U14ilgmpGiXnpaCA35V3/VU=
X-Received: by 2002:a05:6122:3222:b0:4b7:1f17:55f0 with SMTP id
 ci34-20020a056122322200b004b71f1755f0mr4866948vkb.17.1703689163542; Wed, 27
 Dec 2023 06:59:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219201102.41639-1-brgl@bgdev.pl>
In-Reply-To: <20231219201102.41639-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 27 Dec 2023 15:59:12 +0100
Message-ID: <CAMRc=MeS_eoYmvAcTknBZ-e3op4d+rjC4hBcTPhTPw2JpcyLKw@mail.gmail.com>
Subject: Re: [RFC PATCH] gpiolib: remove extra_checks
To: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 9:11=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> extra_checks is only used in a few places. It also depends on
> a non-standard DEBUG define one needs to add to the source file. The
> overhead of removing it should be minimal (we already use pure
> might_sleep() in the code anyway) so drop it.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Patch applied.

Bart


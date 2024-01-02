Return-Path: <linux-kernel+bounces-14150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FD482186D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751C9282ACB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107675382;
	Tue,  2 Jan 2024 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmcIjbj7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18D146B6;
	Tue,  2 Jan 2024 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5451faa3aa7so1554843a12.0;
        Tue, 02 Jan 2024 00:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704184508; x=1704789308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bs+RzqBf3EtYOScRDWfXPPQOOIsFVUV87Fz7UZN69Gc=;
        b=lmcIjbj7mSQNvx72p2QK4LfzozcTICRwEYJxBgOAqYcwM8wuUsn7kvs3X1No1fuI3T
         3Dz4Bax5+OudmvqKP+Iee5Thu0eWoiaQVkAHyP8SNn7PwWG1fV6/lJQmn4lRZkvp3m+Z
         dNo9vq2mR15Au9G0/tGCLSiOH6J33kfNJTMaC/a4hoQiGpOnshy/wITudngqSZs3/5XA
         578ubJl3QOz8ma0ozEKqmVAmhg/kPnNYMLeOO+8MZizYKPc2I0cq81oGVwPqzvGeFvdB
         0xDm1ZkCmxj0MzVK5UsIaRpPmXqap3GT7xb/l6uAc+NQi7emQ3Phnyepe/utCEKa0UND
         ow1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704184508; x=1704789308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bs+RzqBf3EtYOScRDWfXPPQOOIsFVUV87Fz7UZN69Gc=;
        b=YncVTD0sovPlznryN5nx7z1VJx+Umm6Y77NITk8NOpTc3m49AHd80FLPVwDaHBQkI6
         JIBFoTPq4Z0OV8LoNgJhBeaSYYdwtUXxwvpqaFsVh5xCEMF+dDIVoP8Pa9SLqKRVyqzs
         2vta/gqMeJe1SCbN7Bg06aF/hTLfW+sIyzJ1sy+bwt+Is0k4Y0cNyINusX8LjMXF7UOA
         ud2p3r9abz9myhljs+rD2SzvIpowdatmpGnnmyKK0osK3I8ZNSdJtND8pG59UbE0enym
         FqCpx+UyOGGHuXElSSWkkLYOgXA6DNTmIWCnlyiNGqfZH0JPQemDUpFzTytU53AgbgfY
         SQvQ==
X-Gm-Message-State: AOJu0Yyym7y4hTBYFvqIBfHCpW2deiHfnM7zpzNN2bmQ75o4uf/mVnqr
	WvQebtaG7MJ7PHwWzo8Gl+7NvIw1zmNOunBct3c=
X-Google-Smtp-Source: AGHT+IF4e8DglVWhHc2y2IxCZ3Q0Ze/T2S8SQfR0giGQ71QVzpBTXlRdwcI6/Zcton810xIScU2ZBwK1eWr2JFQ8LP4=
X-Received: by 2002:a17:907:1a55:b0:a26:a4e8:5454 with SMTP id
 mf21-20020a1709071a5500b00a26a4e85454mr10288049ejc.0.1704184506262; Tue, 02
 Jan 2024 00:35:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230921090027.11136-1-Wenhua.Lin@unisoc.com> <20230921090027.11136-2-Wenhua.Lin@unisoc.com>
 <ZQwny/NO8qjPU7AH@smile.fi.intel.com>
In-Reply-To: <ZQwny/NO8qjPU7AH@smile.fi.intel.com>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Tue, 2 Jan 2024 16:34:54 +0800
Message-ID: <CAB9BWheUgc6banjt_eui3SeTb6EkZtkX7dPxFvswQ9_O-a7LrQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] gpio: sprd: In the sleep state, the eic debounce
 clk must be forced open
To: Andy Shevchenko <andy@kernel.org>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 7:25=E2=80=AFPM Andy Shevchenko <andy@kernel.org> w=
rote:
>
> On Thu, Sep 21, 2023 at 05:00:24PM +0800, Wenhua Lin wrote:
> > In the sleep state, Eic debounce has no clock and the clk of
>
> Eic --> The eic
>
> clk --> clock
>
> > debounce needs to be forced open, so that eic can wake up normally.
>
> > Fixes: 2788938b7946 ("gpio: eic-sprd: Make the irqchip immutable")
> >
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
>
> The tag block mustn't have blank lines.
>

Thank you very much for your review.
I will fix this issue in patch v3.

> --
> With Best Regards,
> Andy Shevchenko
>
>


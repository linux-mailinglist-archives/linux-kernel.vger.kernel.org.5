Return-Path: <linux-kernel+bounces-42335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E3583FFC3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8091C20AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2CB52F84;
	Mon, 29 Jan 2024 08:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s/kiLwnB"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652C552F68
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706516059; cv=none; b=qG7Hqleojmro+d4U8DmHXhepIRHp2WlCEwdEr8MTENJNdQk94y0gWGA8ZQeEQNAfyNHxoB312mAZQlY7QbRwtFMvz/CeCHgwsfy+UyL8tk/LjZoVyY2XKrzrA6a00pq2VhL9cjuOVlRFlQJH14+5FMSMQ8zF6j2p5DNS+xWEcWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706516059; c=relaxed/simple;
	bh=GjRJ7N2AN6+nVd0ooC5HSu51Pgqr674PVVlLwNU5juE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DytKSV6MD7xKG29OzXeu+nf7ze9MLQxEhL4r7XMrK9zeXqgTEgzbGDar4HAgT5AD9tU1/f3FT6g321VP6OQVcQNak5OMtxD1jts0uD1bnG8uMluZai+Ig5YM3KBr1QxGC8EPTc0QO8PhwyAeWVwj8R488Oc4n9+0fLJC4dvhRV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s/kiLwnB; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-602b7cef983so29658887b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 00:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706516056; x=1707120856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s2EnDbBMqDGbBhFQtliI/OLJRkwmER6ZZAy6Ip4xfDU=;
        b=s/kiLwnByVZN9S8Cbq9OhGCD7AKthmb/pw9zKvOxp9e/+0X1AWQV/wC3IG4gV2GSID
         IdMYt0CG39yv4T2tkFSsP1aCVnPes7U0CZst09fFUKn+XJMDQCb/tjzbhSn+nN82uTzR
         hHwRkW8ozWRC5yNITP7+52EHVAXXjRC4vPNYYsk2id05MrknuodgiDLUYFiDCbdGwmXV
         PltNnlW8kV0z7lxN6OnpCAUnGYcnbcHwmvTO4fIaxRQSMbQ4X1ApD+sjGZuKvU4dvSGK
         Vxl5OBf10PlH7VxPbk2Q/gWxDa7T7lYpEx+y/3UGTaIt/b87vMYxxepdDOe6P8Wqo5Kq
         IJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706516056; x=1707120856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2EnDbBMqDGbBhFQtliI/OLJRkwmER6ZZAy6Ip4xfDU=;
        b=I8DWIW4Rdz0I4lbzNcNf/lqs+gHCjOWY5r1mwLiY7ZYmUl1DBn3ViEomnUjq+QVIBI
         ztpDk1J3b9qMzEi68sGg5PFbf/AOYInUskXxvHW23FCUwcfcIOfYNLqdrZbrNO7XEzKl
         sJx9Lz5u8d6RTa9iAhF5oy+cynPNmiIUkoYiyeNX59+8kPVvdHKZacMQcnTWLdzqMA5F
         GtX4yDr7crFHGEU7hXGk/htu0rVlf73qIGHosA8smnh+/GUesK9nyh9OA8ZGo3k1u0jH
         DPLUGeQ0qlM304i4dtZtrgIyVHuL7dQ30P/FJmmP+jz/WFPhScWvDozNyv3ttRisxZzh
         +6UQ==
X-Gm-Message-State: AOJu0YyR6kiGyemcPfkirGOzQcZ9Myecrmz4ggoao0AgVvErMcQ/gFNc
	fWUi7QCKbeVhhMDOzd4WWC6caIl9caN2Nb4BtBwmYeL4rwHU/YtRGRtZ6ebx9yb0YXZ+x7LuOlL
	sJDq8WkeEM69ZzLyHywea9Fb8qwNu7J6I47aw2WmRR46LihorqnY=
X-Google-Smtp-Source: AGHT+IHoQ4lHklai6GeRs9anEF15zJtmMSEEoJ71q/uoTgpvBAB/SEG/Cz2GSBtiVZLFQpCVIghkMhjg4twujJwqqio=
X-Received: by 2002:a0d:d495:0:b0:603:e7b6:79a7 with SMTP id
 w143-20020a0dd495000000b00603e7b679a7mr5729ywd.88.1706516056317; Mon, 29 Jan
 2024 00:14:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129122222.6b690c58@canb.auug.org.au>
In-Reply-To: <20240129122222.6b690c58@canb.auug.org.au>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 29 Jan 2024 09:14:05 +0100
Message-ID: <CACMJSeuGJ2-++wrKcT34e_Lrvuz96LynwG-=_HYDoCGUkSi04Q@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the tip tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 02:22, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
>
> In file included from include/linux/compiler_types.h:89,
>                  from <command-line>:
> kernel/irq/irq_sim.c: In function 'irq_domain_create_sim':
> include/linux/compiler_attributes.h:76:41: error: expected expression before '__attribute__'
>    76 | #define __cleanup(func)                 __attribute__((__cleanup__(func)))
>       |                                         ^~~~~~~~~~~~~
> include/linux/cleanup.h:64:25: note: in expansion of macro '__cleanup'
>    64 | #define __free(_name)   __cleanup(__free_##_name)
>       |                         ^~~~~~~~~
> kernel/irq/irq_sim.c:173:19: note: in expansion of macro '__free'
>   173 |         pending = __free(bitmap) = bitmap_zalloc(num_irqs, GFP_KERNEL);
>       |                   ^~~~~~
>
> Caused by commit
>
>   590610d72a79 ("genirq/irq_sim: Shrink code by using cleanup helpers")
>
> I have used the tip tree from next-20240125 for today.
>
> --
> Cheers,
> Stephen Rothwell

For the record: this is not my code. This is what I sent:
https://lore.kernel.org/all/20240122124243.44002-5-brgl@bgdev.pl/

Applying my version will fix the problem.

Thanks,
Bartosz


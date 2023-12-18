Return-Path: <linux-kernel+bounces-3495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA2C816D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67AC1C23120
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A724722324;
	Mon, 18 Dec 2023 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nPdAjqP1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7D61CAA5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-77f42ee9370so254856385a.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 03:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702899793; x=1703504593; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1EqwaEmslBhhHxlW1wAORTsFGl+NuF3xpSKZADJOQ2E=;
        b=nPdAjqP16w01hPjY0e0P7fyz3P9w/3+CsbKFQtZDyh3gt0UwbTp2J4lrummRTTkZei
         0CzpuBy2qqRD8nVcOiwdj0o7liPwUyDefNHYFkMag91ZgEE4bATr755Ybd1IfPwKn+zC
         Okm6Qh5WZ2gdYCTJOLa00lT8t140mM8D3MYtNj0dKh1ZDeIyWxlgXSLyqqdyduzmIpGU
         uXvcxN2XDwXdCUrdZGDbJ/7BHEYyrLcRlB3XuN7HQgtfES0WbQJJ6SXgHv3dodgoMz2X
         s3U3cbxvgiuGt49et89QyBr/T+H7K1UWCj4C3x6ElzjKWofXRMDNX/0/umsLyUxjoOdX
         Tsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702899793; x=1703504593;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1EqwaEmslBhhHxlW1wAORTsFGl+NuF3xpSKZADJOQ2E=;
        b=facttGYMWrupIbcjCvJwrTyrnHbflLhacM+LY5kLd3o6lk2jDEjzzp+k03lIrOnsq8
         omEwszuIcSGVUtsCHsss8ZIXSWBFbVnLPBkPMqCox45LizV9zSR9tAan0KYxeEZn6BRy
         vXyr9AqWVuF7NQrIW1/0/rGehurDQmV9Q0JaR149idGf14bKLlYVoU0a1qnv1w5t5ZGu
         vuC6RnU5YgqOliLqLyDEg42kcBms+zis4cM14W+84pz/kq6N3x3BGwIWzyENZDNWc8DI
         fnUTr6g/k/atosTZT9U7Is+uR5I7foS4TayUmqyXe3slPk9LiMEDWSoJf/y1qLmIbdRl
         W7/w==
X-Gm-Message-State: AOJu0Yzlb6ZYWEpKhLvS80UTEbpA+IFKmCK6yC3+GUGmoqNBTLbfec7Y
	9Bd1tqNYLUk2xYSA+fQG9E+qbpTpB6lUfNjQZmx0oQ==
X-Google-Smtp-Source: AGHT+IHx4teF4EAK7ducmO0cFESxZAj8mbl7agZUhUmqAoCQMozMuYqdPaM4LJ0hoglKLckYQrhQW2rFwezfcVfFXzY=
X-Received: by 2002:a05:6214:40c:b0:67a:a721:f32d with SMTP id
 z12-20020a056214040c00b0067aa721f32dmr22608696qvx.109.1702899793569; Mon, 18
 Dec 2023 03:43:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214110639.2294687-1-glider@google.com> <20231214110639.2294687-5-glider@google.com>
 <ZXtircr4TllpqyeS@yury-ThinkPad> <CAG_fn=WcrNqV4burBRPZZwoBLwgia7kerZ8g2vV5spzWF=houQ@mail.gmail.com>
 <ZXyAXPxlmq11rp2Y@yury-ThinkPad> <ZXyGbhJqzNxbd3ay@yury-ThinkPad>
In-Reply-To: <ZXyGbhJqzNxbd3ay@yury-ThinkPad>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 18 Dec 2023 12:42:32 +0100
Message-ID: <CAG_fn=UXhBYNoiSOO8mAjo4FA0Q3hD8FsPgf8F6Z3cCe7pNkVw@mail.gmail.com>
Subject: Re: [PATCH v10-mte 4/7] arm64: mte: implement CONFIG_ARM64_MTE_COMP
To: Yury Norov <yury.norov@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org, pcc@google.com, 
	andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com, 
	aleksander.lobakin@intel.com, linux@rasmusvillemoes.dk, 
	alexandru.elisei@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, eugenis@google.com, 
	syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"

> > Data and *data have their meaning across scope boundary: a pointer and
> > a content. The &data is pretty much a random number - a pointer to
> > somewhere on a function's stack. Isn't?
>
> OK, I read now. Your 'void *data' is not a pointer, but an actual data.
> Very confusing indeed... Maybe add a comment for that cast?
>
Sure, will do.


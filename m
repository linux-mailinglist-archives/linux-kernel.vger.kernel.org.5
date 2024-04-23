Return-Path: <linux-kernel+bounces-154631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371308ADEA1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6927B1C222A7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E884246447;
	Tue, 23 Apr 2024 07:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qFDotcdy"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F75947F7A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 07:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713858852; cv=none; b=I/ICfRXGpHKseCu0n0amSfKteFIhloeS8dzWQaNls6+2Taec4e4vijLpVzILZStRguAuzK726bHIbM1AF1P7UAaYQPrWKZ2kvX8nrxjEqz66JggfUGmvJLbIKNYzhbEEHbZbHjwvlmIH5cif082203S2YmgD3dvUZ3L/85zjPdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713858852; c=relaxed/simple;
	bh=Bv4VRmVg5nOXDs0B4iKA24dkhwSR5MrL4cXlSX5YltE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ls5aMRX8qlGp7AfyzahPz1o2hVA7Ukelf8zZxuBEllt/OqAXG/cldUeT5f0oRjDZGYWVNcaP5WPrLF/P/MLngJ9vVGrnskLQtfEocoht+2Wn7yyWMTkWmmMfIAUTLxYpC0lqmERuiNTiwvqGoQnAhPDKE5HDRultQTIBP3an8Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qFDotcdy; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so3937800276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 00:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713858849; x=1714463649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ne7SQgNtLYRiRuHgxnjris3mVjBkOuVjWua3h1qnz4=;
        b=qFDotcdyQQS+F9coeFoMSHaUjL/EqLwdwvnxqoMLEjvMEe/KzVB19mlptD4ab9XHwN
         iYPcChlAUlWvmkwDcpFwhDFwSGzYVzGmUn7COOG1dNVP90b0E1m9N2MFJxnyRwiXgiWE
         gMhCs3y4SRxQZEa4d9sM25QjDe+VUt1hwRUch6elEuRYGtdBZE54nUf2q1bNHgbbxjUv
         FkK1V78JUiaaElOWzlVqMWGQjf97R5N6CyraakNNVG/pk+Fe4U1mIAwb9p4SCgLh0bUC
         KpgwTDoqxHTc2QPN9W2TVLqD9lazlsh14dDZdxzUUClR+hLlxcOTFwxCMnPU0L81D9sx
         YwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713858849; x=1714463649;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Ne7SQgNtLYRiRuHgxnjris3mVjBkOuVjWua3h1qnz4=;
        b=okeynG1O4qbkOeD3M/mwMI2UYZuYJYVMId4xu9gwF1rUo0Z/MJo1DDeUEDOu6QPiz9
         5JKaKgEDKCMbUSlCDv3JzOQCiE0EZ171g6FAemVu4ksUDe2vpNpJ1+6EwTI3yAPwXpKf
         Iv8iR95ltgPn8BgLmwEwHWXn4UV8UJXVPmtyF3W9Qw8F5NKS5bzBVLEjcWNP7ETnQ9/c
         cX7duuITu2lPOE0dhyZFJmVf8dM4yENJ8DumOhPl2wTHM28eTdGJjhzsaSgb6vj1moKk
         19z/YfT/t/GCwHkWjPIIVuwjFdsK/z2f6N8BH8bYe87HhPtWSDaqBAeYC33oQS5b1pr7
         iw3A==
X-Forwarded-Encrypted: i=1; AJvYcCUouUPr+aEle0+r9GmY84GIxeYWvYnxOav5nB3w7zvUKT+3D5i0ou6/AuAreljl01NkTAWtkdZ9UivK/FnCNqfzmGIUsGzRzAjVsr8a
X-Gm-Message-State: AOJu0YwimQhb0xo4N3EvonfkpOstWXRt8imlpjV1+brE4jAlK2Jl/HXI
	/A1MeJ8Mpez0biWnQW7t4nGHs6HWdu9XDG7C4lm7ifOFueEg80qrQk/SakZXw3iJGorWFovStSs
	6cWJHnIuPaA4paFb0vgb+jzNw4E66qUbAGh/2tA==
X-Google-Smtp-Source: AGHT+IEL7KRfa1JAVKFRuIecyIm/Y5cjYNThFgxAiGj9BjTgdvZZnAdOh/UlIv9zVyBc8AmnYbwxxJdG74ezwMWJYps=
X-Received: by 2002:a25:9346:0:b0:dcc:2671:7819 with SMTP id
 g6-20020a259346000000b00dcc26717819mr1822061ybo.25.1713858849646; Tue, 23 Apr
 2024 00:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423093354.3d060378@canb.auug.org.au>
In-Reply-To: <20240423093354.3d060378@canb.auug.org.au>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 23 Apr 2024 09:53:58 +0200
Message-ID: <CACMJSeu+fUdYoxue-q=DxFdvtopgshQY+i2kpZMP-RGOTqMu_g@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the gpio-brgl-fixes tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Prathamesh Shete <pshete@nvidia.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Apr 2024 at 01:34, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the gpio-brgl-fixes tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/gpio/gpio-tegra186.c: In function 'tegra186_gpio_is_accessible':
> drivers/gpio/gpio-tegra186.c:189:14: error: 'or' of unmatched not-equal tests is always 1 [-Werror]
>   189 |              (value & TEGRA186_GPIO_WRITE_ACCESS)))
>       |              ^
> drivers/gpio/gpio-tegra186.c:189:14: error: 'or' of unmatched not-equal tests is always 1 [-Werror]
> cc1: all warnings being treated as errors
>
> Caused by commit
>
>   62326f7cefc2 ("gpio: tegra186: Fix tegra186_gpio_is_accessible() check")
>
> I have used the gpio-brgl-fixes tree from next-20240422 for today.
>
> --
> Cheers,
> Stephen Rothwell

I will back this out of my branch, please resend a fixed version.

Bart


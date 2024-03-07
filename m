Return-Path: <linux-kernel+bounces-95745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAD18751FE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F69F1F23227
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB6C1E876;
	Thu,  7 Mar 2024 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mEGWb/ub"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566C91DFF9
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822191; cv=none; b=airpa5siLj0kGhLvumYiAw/uSiX45G3SK/wRvRuRJoWumnX+Z2vN0BQNSX/VT+bK/T99kvVzE+mS+tqw8vThb02pvkTXXOLTBWtKJAGpERib6Pp5k9IChjom/PFbdmC8gRpMf+lxGH76ycfw8VDr/ZsvaH+z4F+QOA579LpvrUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822191; c=relaxed/simple;
	bh=RdZjTpDJtzmsKAMiw+aGwZusF0XSscBClg/ZWlH4myQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+rvhJinLDA0gX3HK9ZFYgeY9vpgpZB/Ibu+QsRbL37oWK7RozIXrfmZ/ReCUTvsbteVt759QOoNMJY57B1RYbMV8S9GElOY7lF0AZ4DtGqqwWfgYwgU05pEPP00iXvcOZC68ycWLCbOwKcacT8VyCc7FxHFwP7XYhz38X6HRKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mEGWb/ub; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc742543119so926216276.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 06:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709822189; x=1710426989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdZjTpDJtzmsKAMiw+aGwZusF0XSscBClg/ZWlH4myQ=;
        b=mEGWb/ubmqCtRL/r8UODsp4t11BN8h4AVwm6nCtiC8J8Pt5QR4D6vtXNCqkCGXykcB
         mz5zeybijYe5GRTGmsYzRtwUmmb+2NepLuAFdkKcDTP+QEhUkPWFxMyxuV+DeCQGDfN5
         2OKnTXLMIETTqxTfSPCc/RdqF9boKKmGzN1uezNLJUDvY138bFi+uSKJlg2XPLmzgQeW
         sEj049jdatsf8lOE51oiwB/BYHdwybWN7F//tVTJC28BIZiENJyHG1LuIwsQCmuPx8kF
         ZvMfjCPGUjrBijBcIj52HKXZ6IpH+lcABBczGFP23kdg3/dOik2Msd0/alzwUGXuWiIN
         x3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709822189; x=1710426989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdZjTpDJtzmsKAMiw+aGwZusF0XSscBClg/ZWlH4myQ=;
        b=mDOT1J9lITUkSlTJYQWr/M4KSLvzaKBEEDSzo/2O7w18BoZVRn7Oi9o59lx5YIYa04
         ebhgiY06W0+onTTevqkwWpnNWx4nny/AZQz+a/Z17gGvj+GFZWYsYPWzieM+7wJvjrdg
         vdnoAUw8USV0uXDur+7JJiSltl5SWpu7m60EEklnXvW7l7dzqhSb8MyUDAbUNeeHt8Mb
         G9hWmt5Y/LxdYZGiNUMZTCXlmqlk0jXTiaB31NzZaaTOXupjN8Zfmvi3VsjgWK8eHH/7
         6Vwntt1aFxyG+hh/aD8ziFOWNjV9GDFFUOJKX9gDLA/IJAmsrOztwsoaoaW7Tb3myTQJ
         R9bg==
X-Forwarded-Encrypted: i=1; AJvYcCWwqrWpifHh3LhVW97HZtw1QEBtKWalu8yQdCMfEqsxIyvMoq8ZAk+PWk2ikVqPupRVfyVNabD0NtXl3Z9Y3S8SZ/gHBQGxxjuLhvjy
X-Gm-Message-State: AOJu0Yyoy1MRwRTJScbDh7gIHjnSxNHaSPW8qQDucx1LM8TfYXmyL0qo
	5eAt/vZUynUw/G0ng+77qorPTMxAXHhY8CE+dS6jL6syRUHXT1FLZ+Mz10MR5h045xaU/Tp2oRD
	g57tBzGCeLIHi2ufMXMAXctvwa5Zi/SBBtH6zOw==
X-Google-Smtp-Source: AGHT+IGhwp9+i1EovMeL7O79DpNpuhC9nVwzgcvvbTtNXf5Mnu+oIU5/6z+8bMnsrA0eesmXP0IAOqR6f2u3zVYn5rw=
X-Received: by 2002:a25:2fc2:0:b0:dcc:a446:551 with SMTP id
 v185-20020a252fc2000000b00dcca4460551mr7674950ybv.52.1709822189305; Thu, 07
 Mar 2024 06:36:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307135109.3778316-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240307135109.3778316-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 7 Mar 2024 15:36:18 +0100
Message-ID: <CACRpkda6bykOFY6gcZqRKLAnprUooZooQ_g7Rj_63da2akbwtA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] gpiolib: Get rid of gpio_free_array()/gpio_request_array()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Hu Haowen <2023002089@link.tyut.edu.cn>, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 2:51=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> There are only two users left of the gpio_free_array()/gpio_request_array=
().
> Convert them to very basic legacy APIs (it requires much less work for
> now) and drop no more used gpio_free_array()/gpio_request_array().

That's reasonable and makes the kernel a better place.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


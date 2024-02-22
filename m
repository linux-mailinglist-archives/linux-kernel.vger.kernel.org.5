Return-Path: <linux-kernel+bounces-76605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F2D85F9E4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F661C23739
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610C21332AC;
	Thu, 22 Feb 2024 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="rn/flrmH"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5861C133405
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608842; cv=none; b=j3NT1y1zVCtqx0PO/MCKjVrQZi6JmtDIICr95ETSNKnXM0D2CGxhBX/JuetUS97IKPmOne0k262t0GREhvmh5kNvuds/J0dJ7yNWQBOngdhlJrd7jzO+5cLHBmQpna0L7d1baJY6AiY0nYBdBRpyR+gJXf5secbd9iYFmObrRf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608842; c=relaxed/simple;
	bh=YvE91gvYv6qDIagl96E3lI3HGdScRSs/uM7SmNgXLV0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BacOu6zO0mSR6dm/6j3iBCIA5PMAkOwx+vWvDxexbC+9o3RMhqlsu/19wc8Pc6bTlj1Q8UUhqnjP7Z0EnPaZ0qLBT5T+RvSno/irO9+6dOAm4kd0ehaGwgcrsOAWVA5ZKKSii6xJXecZCz2DlhSMIyYWI2RvGsNdGqiZ8ZR9Pi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=rn/flrmH; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7d5bddb0f4cso3247675241.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708608840; x=1709213640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/zj7OXfvq60AM9P/IGRFFSAL+NE8UU/57SQxGFsYNAY=;
        b=rn/flrmHaLzPwz1L/XdroqXFOyFVsjs3XGOrMoGE0wSKBivouFwPus8ri0LCr1013Y
         6r5c7IX4+ucyJxj1F7AJ3JAVgBIrbU09BT5lg6PHEJlInVQh7EuEjz53mzHBOn2MSkE8
         lWBXeu+NUTT4ESPgczc+sW9Yq2yXUYz09LlrOmhxHB0ZGv2qm1RDHPJS0gT9lGcZZwLD
         tvl1WcX19ZFBn58RolrYtMmhAFyVT1omanCW1tz7pJJvRvz3PNjK0ruJ8IGmVf2huHM+
         f1MvyjZKhNi6oNh2UEVioJblKcNMwHWvh6VDB+bZ5M9d5FPFwMt1NVXC1k+Ua5b9/pdM
         9GTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708608840; x=1709213640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/zj7OXfvq60AM9P/IGRFFSAL+NE8UU/57SQxGFsYNAY=;
        b=QPNBH90JLkoKweADDuZqEBnOdyMX/ktVS5crHgFiD+t88oSxHnuOQ7kGY3TMly5ERY
         jfotreG8XjBoc0hWYThEiGFEgWhBAOAWagRfatG1MONI46OwXeUJb0L9Y+LyQuMna8e+
         RmB/iHAJSG4/nP0LBqWny3lCgldxofkpS8nadDKpl2lKaZcThmhIgIJszRqiR+94UJmF
         urdRMCU9KXpsJBkkpeEb78GWnRbNmwh9UUXvcfROebH8wtPwcgaZycoMdvyB4bTVvpSH
         2O02oC20R5Cw+f1Syd6b7D5qHUKv4qJx0mHHBd/riw+OlDUkgw8CqzutDTWtHXynxGFa
         yj3A==
X-Forwarded-Encrypted: i=1; AJvYcCXis552bHjKsMLAHqDdPKMtzb+gHfDed3gYNzBb1T7KvKUCFea7vB3p+xtYws0FW6HWZJvBVTEI38Jaq8TWXLs3r8mewsYGVveiYz2U
X-Gm-Message-State: AOJu0YxxHDFJdk31VtM8+SkoNum+aF0pk71iMtmgbC1ga6iGZcl9iXXR
	DtLLa5PbbwvI6jRx0LXC0YbgNC74pbFXNm/9cxDKReoaM+szL8xzQl+rUjCFpRIxJEIT3SDstOg
	/tpX14zQCszqaALz456CU8RQ/q8jxz6XjggQMdw==
X-Google-Smtp-Source: AGHT+IFvP7hSArnEBlmoKUZUs/YEQ/96aK6rKqzGDOIvNYXGA9UTu3vEei8mUt22FQcAyXdRktX8daWrSdMnE4FkbkA=
X-Received: by 2002:a1f:e682:0:b0:4c9:a9c9:4b3b with SMTP id
 d124-20020a1fe682000000b004c9a9c94b3bmr10742832vkh.9.1708608840289; Thu, 22
 Feb 2024 05:34:00 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Feb 2024 05:33:59 -0800
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <ZddLRAqxFr7v3Zqs@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221192846.4156888-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=MdvYdx6x=gSiOZ3SXAdJORnqhsNW79G2c7wABofWARwFw@mail.gmail.com> <ZddLRAqxFr7v3Zqs@smile.fi.intel.com>
Date: Thu, 22 Feb 2024 05:33:59 -0800
Message-ID: <CAMRc=Mdxtx-wh3HGu+SNrCwfSq0PEm3fG7hK_6wPAk2uzk8xpA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Fix the error path order in gpiochip_add_data_with_key()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Feb 2024 14:25:24 +0100, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Thu, Feb 22, 2024 at 10:37:06AM +0100, Bartosz Golaszewski wrote:
>> On Wed, Feb 21, 2024 at 8:28=E2=80=AFPM Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>> >
>> > After shuffling the code, error path wasn't updated correctly.
>> > Fix it here.
>
>> >         gpiochip_irqchip_free_valid_mask(gc);
>> >  err_remove_acpi_chip:
>> >         acpi_gpiochip_remove(gc);
>> > +       gpiochip_remove_pin_ranges(gc);
>> >  err_remove_of_chip:
>> >         gpiochip_free_hogs(gc);
>> >         of_gpiochip_remove(gc);
>>
>> This undoes machine_gpiochip_add() and I think it also needs to be
>> moved before acpi_gpiochip_remove().
>
> You mean it should be like
>
>        gpiochip_irqchip_free_valid_mask(gc);
>        gpiochip_free_hogs(gc);
> err_remove_acpi_chip:
>        acpi_gpiochip_remove(gc);
>        gpiochip_remove_pin_ranges(gc);
> err_remove_of_chip:
>        of_gpiochip_remove(gc);
>
> ?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
>

Yes, because the sequence is:

	ret =3D of_gpiochip_add(gc);
	if (ret)
		goto err_cleanup_desc_srcu;

	ret =3D gpiochip_add_pin_ranges(gc);
	if (ret)
		goto err_remove_of_chip;

	acpi_gpiochip_add(gc);

	machine_gpiochip_add(gc);

	ret =3D gpiochip_irqchip_init_valid_mask(gc);
	if (ret)
		goto err_remove_acpi_chip;

Bartosz


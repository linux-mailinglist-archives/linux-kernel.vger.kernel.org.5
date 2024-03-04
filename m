Return-Path: <linux-kernel+bounces-90941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC720870748
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE821C21270
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A53A4BA94;
	Mon,  4 Mar 2024 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HhNdSJWE"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0D91756D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570081; cv=none; b=ByklI/rDqYx+uaHmBkrw/u600w8wzfO/KNAKvKUXq67jJ/J/+YTuUoSfv/b9Tcjj3z4ta2RbnvhenqQjCN9a3Y/bG5zvQY0Q1SLzeiDzkcJ6O7IfONBf3+wm0rF/FAcU2MCjPYLhxvX3skiH0bX5Xg3+DdHPQuZEHGD3d9ptLCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570081; c=relaxed/simple;
	bh=A2zNd/rgYKnFeMBKCoWUuiwBLWEvwOAkTF2/8zWjdQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxgggMvYvLbPAfQW5rVmyeeRarSIDYOLOi4JuBDXB6udrxmtEuQyQ1KTOl5UqxCTrngFTYPs1D/Z22tDAmpYXmSMC6EFnbyLpih0TRV9+/YmL+/BgtNd4+AoVf6kyYM8okJlJnWyMnjI2b9FFZrCjOLnZSVcTjY3i8W8Vz8dVCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HhNdSJWE; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4d367dadd14so487339e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 08:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709570078; x=1710174878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2zNd/rgYKnFeMBKCoWUuiwBLWEvwOAkTF2/8zWjdQ8=;
        b=HhNdSJWEiWSXAVtMjNkTyTZ+hfgEiI/SlCMEIOIS7ZyG6Rb90n+AN47rKOTUhY1bpj
         qAfLi+Vud2+q5ot1jxSgYE8KXEy08/anE/B/bjdgyYEe6sjOc7SOtt8Ufazek0nw0YY0
         9tPLbYVVT0PlWgOxN4iY+MBTu/+XIJ9AyOiDkSMRFvCCoZziXSkF0rGCFKlTHwFIsveY
         Emjl0MxhMaVM1auwGb0ozQPtp3bgXxCumC+hvD7ISSZOc6SjmyOUewkvmhIyzs1OCXx9
         2ROUNAE7Sk+DnUtAyTF/cX/POagZGnJZ5lQl1pbe7sRzYtBGB5FxpQOeSUqFgzI1lBk1
         yG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709570078; x=1710174878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2zNd/rgYKnFeMBKCoWUuiwBLWEvwOAkTF2/8zWjdQ8=;
        b=FTzJlujG894ESgYWdgg6DPx329qJQr5Gb3ztVQLb3mUcreWtwbktXVOcJtPVzb3RFe
         D81yy99T3bx+dE3FNGc1Cj3on7kOEob/jOCjaK8cbRw2ekmdrqzYm9qMudEn+HBmtMVr
         RuuoYAieg2nr3gcL9Fwe+LUtzOpafjKTbdALn36n8kedHkIGNIZ0ZLURwGpuTDNUnWRM
         P+dcNNFWXzSTo/ydqk2fu3VnrBUX4ZTf9AXKrbOYqYjwyFoCdqVt7TuUyeV8Gk4zjquU
         R7eOFuCarZaI3dLncl2UPUf0ggFyT5zfaNZ9IHkO151W3jHovcJaqBJV+OwQywNPThyx
         302A==
X-Forwarded-Encrypted: i=1; AJvYcCXbWl1lkiK+VlSn7Va68EBj+T8a4MmoX9iMrjiQiNU3y8s6/Yya8i7lCldh4CDCS4PgsMPzZ/Lgufzw6enM3lwjOPyHoRqXUL7oySNm
X-Gm-Message-State: AOJu0YxoLf68wGFzEE1WtU2Iu63puItH+V36W4mt/58kcIVLXBxlEXjV
	vub1KFocD6TFnvcph0s3yxqOabzVnU7W+anTmcZbRuL6VRM3DaVpy2DDLwJaKwrYnZFG9HwomCj
	QC/MA72er4H3rzzq0R9YhC6v1a9T7ivXyZMe0PA==
X-Google-Smtp-Source: AGHT+IH6XCBv1powBU6LBfdOrzCrdX0z2XKGs7EqHW7M1CvYIuEzvlBS2CVQ/zEabk3lty6i91pid2y9iE8oMH4BO5E=
X-Received: by 2002:a05:6122:168f:b0:4d1:3fbc:db6f with SMTP id
 15-20020a056122168f00b004d13fbcdb6fmr6888602vkl.16.1709570078228; Mon, 04 Mar
 2024 08:34:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304160320.1054811-1-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240304160320.1054811-1-ckeepax@opensource.cirrus.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 4 Mar 2024 17:34:27 +0100
Message-ID: <CAMRc=MfAZC8yGXXYrCLeSxonOwozgxRdPC4h=aVgCMSkA7O_dA@mail.gmail.com>
Subject: Re: [PATCH] gpio: swnode: Don't use __free() on result of swnode_get_gpio_device()
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: linus.walleij@linaro.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 5:03=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> swnode_get_gpio_device() can return an error pointer, however
> gpio_device_put() is not able to accept error values. Thus using
> __free() will result in dereferencing an invalid pointer.
>

Can you post the steps to reproduce this? Because it should work[1].

Bart

[1] https://elixir.bootlin.com/linux/latest/source/include/linux/gpio/drive=
r.h#L616


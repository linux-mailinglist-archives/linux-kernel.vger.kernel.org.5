Return-Path: <linux-kernel+bounces-88054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AA786DCBD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F546B265E2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29A769D1E;
	Fri,  1 Mar 2024 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mRZc7NcB"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299D16997D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709280609; cv=none; b=XxyKnoJCw7FdrZK3znNuov0+VYJ17SGZ7zzCXdkuV23pdnUz4YCkyuvuM0N4pI713GTl6qneT8EAVsTeebBZOMVJWx49XBnsIoOPEMIUanMr6T2rvPXJW/JHgAwU8rai5Z5EPYbPhjY6Tk3AkxzPHXQkbnc4DN632GiNJIYvDIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709280609; c=relaxed/simple;
	bh=Gt24m6VgPEoo+PtbPdWbeLDUXQElGt2V9/LMi5WVxt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFFGQ/mu+CnbQC7ZNncSF5bsu70YFi4OI777fepAsE9I0p1DxWo/QwS1NKEqaKLNQZJMa1NR0+AU/z8hFLZ/ZZ+0jlnVHBEiTaiQP2swTzKZ1Q9+ny3cgYN3NOfFJf+oTfAQF37W8VnoabYswxNfUs0cTQzkCkzCFfZ/6agNfKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mRZc7NcB; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4d34abf66deso494554e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 00:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709280606; x=1709885406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wk7y2xtTESbht6nwVgBTMrqKWojYrtrLnTeVVOeEZa0=;
        b=mRZc7NcBp+gOFQ/6/ocXaCzNH+8VJaMjzW2XdKDDbkqql3+vZd4xDxCifXAkegVbs3
         aU1e3upsRci7/KXGB9zyeU0UsAJcVdErE8A0QFnTaBfrGSTuKXe03cHDqqHXFbBvDy9f
         5xP4FgBI23A249QKbnqEIsyA+LjvwnqS4O88EBeqxo2UUTLAr1bMlnrRnn4D4Ke7xR6P
         9RFsaBxznZKQif685LxEG91kL7OnXs64Kuv3mUwKVJXJLaOgUgVznLUDya90xyty7eW4
         R9PhBqQCMF+aeuyZsUsHRyUZZrpFVb3XcQKRkHpF9YWgHIuCZdN559eC0TOZxNmcXPSp
         YWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709280606; x=1709885406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wk7y2xtTESbht6nwVgBTMrqKWojYrtrLnTeVVOeEZa0=;
        b=GpUBJLSb88NTPHC2vwp/xeel4/mgHbbyHLwjb1F3nvBMctn1LRWF3rLAwO/ysT20az
         J3n2FKNdRD+B/Gn/l6IY1dM5ry9/YgbHI7t1XIUNqR6sN6Mj4a61KBxjlDWqjRIz1JYE
         NJrb+QcSrXw51RWm2kbmMTcArotF3ZWdv/3Sm5qd/aba73EHgiXzJJlvYsxk4bZBj+5N
         M2nwvgDZ7QTGiMUwM/OCZhZDqasEAwS3Ubn19eWK0XsdDntSk9nO+ZwwmFmyXtDBnzJJ
         j+MYDem1LmGeZPpkFJumKFlpXyi3d5AYJ7MK4e+Jh1FxHHvhqP7lGkTzAKX5/FVH7iYz
         M7zw==
X-Forwarded-Encrypted: i=1; AJvYcCXkaNT9MGWYlBJ0+wJP5vpgYngmD/HoUoz7lpQUA/ST8146C+fBc4eghN6n2ZcZ0oTbjqtH9vLymL5xunV1KVhZGoneGKWKQ5t9LrDu
X-Gm-Message-State: AOJu0Ywn7+Y8Qp8DiOIFCFXXR2tq/iHvpNBibVXAL1a1z1LeUxcSfI8B
	IofgeKNKoPcJpUrm536+d0jLffJqYb80v/ozAJww+4S/i0md9Dke4tbyw03rPmP/HUZGhwvAMFQ
	de3Tohlyiw61czg8jxKYwAcGPINf9fNsl6lVvoQ==
X-Google-Smtp-Source: AGHT+IH0cpHkNFw5IVYbKUvxASmoajZZoX8JeRxGPbUsjHJdZ3rD/qnh+2jzEY44I3Wi8ydUmSlgeHZVgglRmImhN4U=
X-Received: by 2002:a05:6122:6ae:b0:4c0:1bb6:322 with SMTP id
 r14-20020a05612206ae00b004c01bb60322mr594744vkq.15.1709280606100; Fri, 01 Mar
 2024 00:10:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229145303.3801332-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240229145303.3801332-1-andriy.shevchenko@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 1 Mar 2024 09:09:55 +0100
Message-ID: <CAMRc=MfE_OUTU12s2eKj-d8Q7uD_52SrSOFzx2yq_D+fy0rqPA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] gpiolib: Align prototypes of *gpio_count() APIs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 3:53=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Two out of three GPIO count APIs take device pointer. OF case clearly
> does not need it as it immediately switches to device node inside, and
> ACPI abstracts that to struct acpi_device pointer. Unify all these by
> making them to take struct fwnode_handle pointer. This, in particular,
> will allow to create fwnode_gpio_count() API if needed. The need of that
> was discussed here [1].
>
> Note, no functional changes intended.
>
> Link: https://lore.kernel.org/r/2ad735ed-963c-4e75-b83e-687ea2c0aef5@alli=
edtelesis.co.nz [1]
>
> In v2:
> - fixed typo (Chris)
> - added tag (Linus)
>
> Andy Shevchenko (2):
>   gpiolib-of: Make of_gpio_get_count() take firmware node as a parameter
>   gpiolib-acpi: Make acpi_gpio_count() take firmware node as a parameter
>
>  drivers/gpio/gpiolib-acpi.c | 13 ++++++-------
>  drivers/gpio/gpiolib-acpi.h |  4 ++--
>  drivers/gpio/gpiolib-of.c   | 13 ++++++-------
>  drivers/gpio/gpiolib-of.h   |  5 +++--
>  drivers/gpio/gpiolib.c      |  4 ++--
>  5 files changed, 19 insertions(+), 20 deletions(-)
>
> --
> 2.43.0.rc1.1.gbec44491f096
>

Series applied.

Bart


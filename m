Return-Path: <linux-kernel+bounces-77886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92730860B96
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0838B2478E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D92616428;
	Fri, 23 Feb 2024 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cmlhRdBl"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0FA12E5E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 07:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708674684; cv=none; b=VEg2wcKNraLX1KBPvJKj5qrvdoHl6+TXgvjFbJGVfPuE/9Y3SW0dXZhDcXwnkAgxoeOPhD8AO725P8TxaVjghCHxmbjXk/Xao2ynbtOagvWSWZt1u1Pr+h7j+kuWQv02YidEcZfZHCCK3K1lg1lSnxnBAZS3VRGXWRrr7UBfhMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708674684; c=relaxed/simple;
	bh=7SLujE9p9Nm9Prxjtn8fONPkVvEqrDPAS/csWaCIAzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5GU3g7nqfx6nkzhYJjZD+KWp1NCmAnZg682cGMMPV/eSrBAzMHb2SMeqq8aRrxuMwVpjftK4jTgAytP75MZQnKUSL00EQT66EzGrRrAUnKsyhfMI6f8jhvXi9UYTgGP4wftU8zMjxT48aJ08ZFu28ctzJxEFFaxAHi055CBqsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cmlhRdBl; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso533556276.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 23:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708674682; x=1709279482; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0zwJRKqqvkbB5yeYH6nxcBNukYSHGMyv7mjOlzCXaIE=;
        b=cmlhRdBljn+lU2MLykpe/QlhI2j4gJ0rJDexxq7JsqV/nEL41jjIk5V2jYc/NA2SkG
         kq1IcVx9PqXhnjgkytUHVfspW+q/5qIBLFaOMicrM+geMGDxV6fYz/S0InKfK+ZAbAP1
         aJA5PM0l1fZXTKR4WBigZJT9x2UNdM4OeZNezOSVdhTOHugyrHncAqYVWI/IccKBK4mX
         93SY1fMIcKWImvSk632hxFtML8Yc2AW0EDkFa4/2fmtvAFktbf5YJfsH+297hP5DEVak
         2EZREBxt4gp61TE9NW8g9HmdFmtRvk7PuD5d3Bpkk89qc0ADa3ZGGwpztl9rvgh9owj1
         w9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708674682; x=1709279482;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0zwJRKqqvkbB5yeYH6nxcBNukYSHGMyv7mjOlzCXaIE=;
        b=sp0F28oZnikMhcBH/i/qwaSVRjg9O2E5JdFMKhx9TiXDPdHma4J8YDotLQBZgPWH0D
         AqjzJPN90UC8YAKTmtqE3bYGgUtgvRUNhyUM2bwgdBmPBiCx9CzDiTKJpGB6yeMtNPCd
         nZ6jxTZ0px55Hz0IMkLt6ZlIWe3EpwG1AfZvuZA44zgoVyoxa2Qe0vzmfD5GcjOHQ+lU
         nTha13At4jcldL2FKajNr0T7GeMEqlRm477wi5uOh7UXPif9o1bsNwwsezrXzhpSti/z
         K3ODHKCYYFz/EEFxwelWgJSdBM8rK3y914dvAQfnwM7MtNQhnbbWh61NymvoWUOfPvYz
         HcrA==
X-Forwarded-Encrypted: i=1; AJvYcCV29nTYNG7SikhAzojGCO9FaPYehNxwipDs64Snu1PfYvX4iC9TxbxqE7yWTZr4JPHWeAab430qxnvlY1OskRkST29KL2pbcA3jjPis
X-Gm-Message-State: AOJu0YwF8KIHwx58qyPfcUgWP+rAsPIw/shBIoa8btlP7BZaPBka4u9I
	6XYkir0ovYUaXTQer+3EJosWbgB5zqPyNoAUGy7C5y+oLEVMfROEYhOR+qjVkVaKMI3iepLnjEN
	Y+IpJyCUwLVT3lLsQwXrLIGT3AR39CbJqNynrzeBu2QFRhZ94
X-Google-Smtp-Source: AGHT+IHbNOowKrX8O4/m/+E511Tw0EHE2Y4FoVovhCwVnGeUs+qExDuEJiYiV23qeO9vY5G95qZUDa6MNnGueapTxIE=
X-Received: by 2002:a25:c78c:0:b0:dcd:6a02:c111 with SMTP id
 w134-20020a25c78c000000b00dcd6a02c111mr1405796ybe.11.1708674681755; Thu, 22
 Feb 2024 23:51:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223143309.5ec298ec@canb.auug.org.au>
In-Reply-To: <20240223143309.5ec298ec@canb.auug.org.au>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Fri, 23 Feb 2024 08:51:10 +0100
Message-ID: <CACMJSevZxCiqa8uz+XU36psCa5T_rQGi5tVkMejpZj22Bj1k3Q@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the gpio-brgl tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Feb 2024 at 04:33, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the gpio-brgl tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> x86_64-linux-gnu-ld: vmlinux.o: in function `bgpio_write64':
> gpio-mmio.c:(.text+0x1489427): undefined reference to `iowrite64'
> x86_64-linux-gnu-ld: vmlinux.o: in function `bgpio_read64':
> gpio-mmio.c:(.text+0x14894a0): undefined reference to `ioread64'
> x86_64-linux-gnu-ld: vmlinux.o: in function `bgpio_write64be':
> gpio-mmio.c:(.text+0x1489527): undefined reference to `iowrite64be'
> x86_64-linux-gnu-ld: vmlinux.o: in function `bgpio_read64be':
> gpio-mmio.c:(.text+0x14895a0): undefined reference to `ioread64be'
>
> Caused by commit
>
>   36e44186e0ba ("gpio: mmio: Support 64-bit BE access")
>
> I have used the gpio-brgl from next-20240222 for today.
>
> --
> Cheers,
> Stephen Rothwell

Hi Stephen,

I'm not seeing this issue with allmodconfig on x86_64, could you give
me some more information on the build environment?

Andy: Could it be that the ifdefs you added should depend on
CONFIG_64BIT and not only on the BITS_PER_LONG value?

Bartosz


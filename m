Return-Path: <linux-kernel+bounces-88565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B57386E37C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF2FCB23A11
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A4C38DC3;
	Fri,  1 Mar 2024 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7x8mjPl"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EAE39AC4
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303983; cv=none; b=nFmd+j/Y3Cxy+4lGV76sNoBjrj4uLB50dndhnEVxDJUDKcz1pycN+rZdH01hUJ1aMZnWLtlZpbk9FSKEmj5+YzwfzIzUp1uhz14hipV4A1e7kNlOJ0YzTaeduBQ6ZpQKDqi+ibYAmjQHGXKyeqVUCd0NVlEJ3b1VdP77/MhpPP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303983; c=relaxed/simple;
	bh=hhOiuxD/7I2XtZlyGE+8MWxyIp1mdrvLK5p2WFjNQkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2mNuZR9lqdm8LkfpnuLmZRubAwd5mh9RLfokiXG1Imsnv3xslB/RNUaWngmECBtGES9BwTX0PNb5dVAyAnGi08keu0UWuyIXzsCh3TrJ6bDr9BixNKR6ltPfWvRgqgX/rtMahflRjKRZJPoFbkB4oPVvAbGQx60YLHUZQjtq14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d7x8mjPl; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso2420968276.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 06:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709303980; x=1709908780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhOiuxD/7I2XtZlyGE+8MWxyIp1mdrvLK5p2WFjNQkQ=;
        b=d7x8mjPlL5cqjpENIzqKjoLCfWObvxJ6sKDKgPtdJStsPe0E7i458BfORbHxeKWziA
         N5GrrPgeX+cNllhf5mxit/lqLaG+foNKaD/NOB5Jl+GUWW9dxtlF5XxpvOKjON+bmjg1
         60v57kzlF6UIR5H4m1qlycZu43ISBtkzOhA5OiDFnBowPbzrjFnxA2inE88onpesVEWs
         tdAghWAJAPQsXCCQVSjs2rb0KSeOU9P4ku9ZcQPFrEGy2ZVVJKgmMOI84z4Xbhk9UJH+
         TFUMcumWVMhO71w3uGilZX86RqPU3VDu5KFGxWueXkb3dFKvDxYr8R7Y/WvQLyoGgx2a
         Oe0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709303980; x=1709908780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhOiuxD/7I2XtZlyGE+8MWxyIp1mdrvLK5p2WFjNQkQ=;
        b=VnjXvXfPlauAp4YDxx4s9x0FTFPLmfksjO4/v6pko3WHemmp65tXrx/iysLsK5yWT9
         edHmcjdZxCjcRq1iMTT+6uyu42co5DUZU7ipUKXMer0tHzX/zu3tQj3n15n9m434bMrZ
         pHU1zWOjBE0BSiaysjymXD8pmDKDlESXVX6rt/BXUUcfGnpt1ydEz4LZYB5d1h5Na1/Q
         rr7Vc4CTTywxxv9KhEfi2zbvdQvAoOKjMrfYdwM9hXwf94+XQlEnj5IW3sEcsWfdzrdj
         0MT1HyME9C5WCH0hBc5HYOAfL1JNJU867s/opqcAd8ACeVm++pnhp1EpJE/6vMwFRIme
         ZgKg==
X-Forwarded-Encrypted: i=1; AJvYcCWFtPZbop3tvp29Bcy0EnTeA+Q8dPSFvBt7zvXdrZUAbqbWQx0/jWkCMp0gfbdfkGjavPX5iqB2zKy+jTsNIZeOKpgpbDiinYwPbUwG
X-Gm-Message-State: AOJu0YxVCSo6EnXzf/FoKwa1TbC5PmytfQHahOGqC8K89CJDqbDXxtWj
	hcetXZnO7P5f82kdB54IRN3qfdhj2LHMZ7YWnt97icqh0AGikp7uUQH+dR1d6Ancms96pMWIkqQ
	Vx2iFPq2dc7fEyQ8W3ozkiel1+/66dj+GXRDTKw==
X-Google-Smtp-Source: AGHT+IHk/6HtxsiZdN+Qd0QXXpvSBbg1h2sMTZtFLQ6r2OIGZks/3qDqGmIOb93W+LJfhpd4AHjB5kBTgFcpcAPar8s=
X-Received: by 2002:a25:b94e:0:b0:dcd:2f89:6aac with SMTP id
 s14-20020a25b94e000000b00dcd2f896aacmr1557192ybm.10.1709303980278; Fri, 01
 Mar 2024 06:39:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301-mbly-gpio-kconfig-fix-v1-1-2785cebd475d@bootlin.com>
In-Reply-To: <20240301-mbly-gpio-kconfig-fix-v1-1-2785cebd475d@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 1 Mar 2024 15:39:28 +0100
Message-ID: <CACRpkdaBsBNb7r788V=dNeNuAANfS7MWvyFNHYq=spBk6Qj4MA@mail.gmail.com>
Subject: Re: [PATCH] gpio: nomadik: fix Kconfig dependencies inbetween pinctrl
 & GPIO
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 11:39=E2=80=AFAM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:

> PINCTRL_NOMADIK cannot select GPIO_NOMADIK without first selecting
> GPIOLIB on which GPIO_NOMADIK depends. GPIO_NOMADIK depends on OF_GPIO,
> it is a direct dependency.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202403010917.pnDhdS1Y-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202403011102.v8w2zPOU-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202403011329.1VnABMRz-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202403011546.Hpt8sBTa-lkp@i=
ntel.com/
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> ---
> Test robot usefully reported four related issues; see Closes
> trailers for links. Here is a proposed fix. It applies on
> top of ib-nomadik-gpio [0].

Quick work!

I applied this patch and pushed the branch again!

Yours,
Linus Walleij


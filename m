Return-Path: <linux-kernel+bounces-48571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 091CD845E3A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF741F255AE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FAC15F32C;
	Thu,  1 Feb 2024 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LhDjTc1K"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6C015DBDE
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807596; cv=none; b=MXvISCtijOKtkdZxg5SWjEtlUTs74ycFauQIXapTGShuneav6JF8bBLk6QVt2m7BguKqHP8odb0l6VoBv67M6rW2x7ABNAG1Gxmg0CFwS9DVqmFo8+IIw6f6LpBGZ/3ij9obSW+RByVJ0VgnJDpXF1NxEVVz0KbNLga6iv+sA4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807596; c=relaxed/simple;
	bh=AD3U/lIyPZ4G7xC7sxRmGyVC5e3znXT+N2MuKIIIOR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/GyJvbPkVXkkwrxTicQOGjpWCZjo/Odr22j8gqJ0eX0oxZXdV/pfWTwmQ8q1u4UjszXR/ya/yRF7gCipqpZjIKJ8VWMXMjHX0X/FTrq736foS1wByVBzb8DWzBgjlASmZgA3qjTlVbMq5zHtzmeI6hAUNecfAg7xMC8hwPC5nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LhDjTc1K; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc6df0f9bcdso637275276.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 09:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706807593; x=1707412393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AD3U/lIyPZ4G7xC7sxRmGyVC5e3znXT+N2MuKIIIOR4=;
        b=LhDjTc1KJcWaR4PLsilu7ZtEfElbUGhqoDk13LqKyyO3n4iuvKZ0ItnZhxIEiKZK7+
         9X+U/GFmeMj4kkXAVoBkgqGO5aZriCn8Ar4CKOi//mf3GsnJIB9r/bof+IMVSzdld/kL
         HXUqzWLYJmrr9bUvV+wF/V9oGrbEpytFBsojjGcSi3FVhwswFBK1uACDO+K5fy7OVd86
         xuuNokPiZNJ006PyAmZrhUz672/pqoCLS+cm7svA2aCTJLtqv5faxmj0/J8p1gpkkUO2
         cq+DKsyei2u5qyKsddeC9SYhqH3HRcGrWae1GCDy4ILN/5P3wrXaKY1C+gcJiZZjIgjD
         NtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706807593; x=1707412393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AD3U/lIyPZ4G7xC7sxRmGyVC5e3znXT+N2MuKIIIOR4=;
        b=bgZNAaKI707hP5BoZBBb3YCb86H0aaZUiEPSmao/c+7Yp/CU59ldjaQKtkSQpQ5CZL
         jd5aB47mAr3STB3CeGB0NQPJZWqo9vaHRFDQHp9AgckGDD6d3yLZi2eBxrtoIygYIHVu
         Q2W8cjKfQdnd6gPmHR0h6qlQiFgELAKjFxmokVC4n9s4S37V1qLUEnNyHmutM6HEV1JQ
         uqbYHQhQ+PN7bY9AzMhmcTXkxCRBjF0W6ZRMYwrjkb7OVf+A9+6jsWtuNkjHbWIRSApY
         sROwSDkVAPjTCkAf+AmcI+90d72JrmW6h9p7gB6E9KtSnUuMqJe+jSsL9gti7lUC57nP
         Lgjg==
X-Gm-Message-State: AOJu0YxL17fHjgclgbOga29EVsfSIAVhwJHzkFFb7usmJk+PL/411jPZ
	mRKND2neifCQvsHipaMQonKUtR0fhgrw3HhEnwLx6cgdwI0QMpzt5NJcrd36+ezO+7J9R/wAB3Q
	l/CfklRVxXvnfWlsrWuJtxvggpNz9MTWQICzilg==
X-Google-Smtp-Source: AGHT+IF3bijKL7kgDRK4R8txTgQdk15F+QD9DyIXZVD+JcVabqZGqse1p5DidrBs6catCWCCGQ7OCKK8ujCS3Y9k1dM=
X-Received: by 2002:a81:4318:0:b0:5f7:992:b018 with SMTP id
 q24-20020a814318000000b005f70992b018mr5491584ywa.5.1706807593730; Thu, 01 Feb
 2024 09:13:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
 <ZbuDqwDUaSIaOI2w@smile.fi.intel.com> <874jesuz0h.fsf@kernel.org>
In-Reply-To: <874jesuz0h.fsf@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Feb 2024 18:13:02 +0100
Message-ID: <CACRpkdb2nMMxnurAavG9RFzBBz-+H=CkX6XhwOwftMJwFfKu2w@mail.gmail.com>
Subject: Re: [PATCH 0/6] Convert some wireless drivers to use GPIO descriptors
To: Kalle Valo <kvalo@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Arend van Spriel <aspriel@gmail.com>, Franky Lin <franky.lin@broadcom.com>, 
	Hante Meuleman <hante.meuleman@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, Srinivasan Raju <srini.raju@purelifi.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	brcm80211-dev-list.pdl@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 1:53=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote:

> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>
> > On Wed, Jan 31, 2024 at 11:37:19PM +0100, Linus Walleij wrote:
> >> This converts some Wireless network drivers to use GPIO descriptors,
> >> and some just have unused header inclusions.
> >>
> >> The Intersil PL54 driver is intentionally untouched because Arnd
> >> is cleaning it up fully.
> >
> > Thanks for doing this! We pretty much want to get rid of gpio.h along w=
ith
> > of_gpio.h ASAP, that's why I expect this series to be applied in a fast=
est
> > possible manner.
>
> This is for -next, right?

Yes. The urgency is "in the next few kernel cycles" not "tomorrow".

Yours,
Linus Walleij


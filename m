Return-Path: <linux-kernel+bounces-88084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7573786DD22
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0636BB26989
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B766769E04;
	Fri,  1 Mar 2024 08:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="p5D8AtBE"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3CD47F6A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281867; cv=none; b=WY+3s3Vf8QKbnvQ4uS7iJ2xPvdDPAmP9mJLgPtcT2Y6PEYex63GTHlFwkUVt9LvHSb5BX7R/9kxqlmMw/kypf9e5RPwY/Il2Iavl/YChQlS1gNcmuu5blnmCRMjZUeW1jYdH06wfwDObLzoEOxG8iNoCY2v9f23kMSepPeiDtfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281867; c=relaxed/simple;
	bh=YXBA+GcFuwZgsjp8m2PtmBFhx/is8VEvcplYegn/n/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzIgogqJILRIAWNY1kBvatz4B1fvtMnsXUsTV9+QU7vh8lARFErs54v5WlcTj5rsLt3BXcPMo9mzMD6PLji45HXSTWdIAf9j1FiRNhTH4IHSGuvQ5HNDxR2mSC9eOkr/ctJonRDS4owBcwFRqLx4RE1H6SJA9SM+vvGm3bQ7EAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=p5D8AtBE; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4d35d69f525so136321e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 00:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709281863; x=1709886663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lELYH8h+hxL/iuJtoVrms/GoKsq2XvHNLfFd3ns5F+c=;
        b=p5D8AtBESMzYbNA+xHQ703g2/BUTLgZgX8vDX0IMbS48QFny88uYBxcZLS8Xc95SKi
         Rt1ub2FRO4s4SwDIVss/yqtt38Pztu/5wMvCCLGAr4e0n1O8UZlffJUWQ0NtBq1IzQaB
         Z0+YiVH5HRN9zXyEDPoLEHK3zytfox5gfgmENeTPV2Ng9WXXnRt5mLg3+EFpS9oazVLJ
         2BU1capY8RAsRFmVuV420ZOu3tTOBlbtMfeTm3rNactfmmqdjJjpEc3YQHIIDEAmfeSC
         iAbAcX3ClM1QnotnHXt8tygn7SngzsDdO7dpW0FxTceYgVe8V+qbRfCAIzkrmzvZhQV+
         W65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709281863; x=1709886663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lELYH8h+hxL/iuJtoVrms/GoKsq2XvHNLfFd3ns5F+c=;
        b=jL3cRrVsvfy79ZUIH9/9GZK8D6Q22LJLIh6zJzOawRmR+9vLp/TdPdkIYgIxGlXYGd
         lOYfqsWH+Z//pH/bcuG2RMBy1BN+6f4ToVcebVlheOf+FgaAV6hhnGB6q0FxM4bdI0RY
         1NXZChOUZJLTCH1pAlA5yCrSuTiVx60ktNoZXctvyWP9hkMFO9to77l4HNnDFTPw76O6
         kUGj3zxynqJoi0Eu3MozprR8i0BKMD2W5Xjp7g/mJcBjLHxiLO5Ch416xufBOzwkc02C
         XKaTGnRjdqysHgZRFkZnAm7QxwNrFGL31YLhxhtwLI8EQaPXX027nvxv6cO+iwvNQUJa
         Ddsw==
X-Forwarded-Encrypted: i=1; AJvYcCXPUNcP/QHO5n3jAvrLbpNpPcU9oBvIYIk04cV2oUXwg7xXcwE0mjcDR/3KvJYG6ofoiuCrlNLmvtjN98/z5sNkmyWZSNnh4n3l6NMg
X-Gm-Message-State: AOJu0Yzs6gbZhDnUH3BXqram9pNMo21f0NjrcnWxP96tHzLCjYYQQA0f
	7qdWdjJ/FIpXACjp4Lg1XfQSIA/cQJ+u4foJVfjfeVrnwwYIq1XscLpWhOR7/P28Iw+XAqj5PG7
	oDm6OM6J/gwt1CpPMbXu6HB1GIAKn+HtEju8VyA==
X-Google-Smtp-Source: AGHT+IFRDY3BPCDQD5iWo1yphcqOO9zcOl6psQ3cmTnKIEq8pACvPundsi04NcilWPzsEwn2Eg6zK2739v7iQYQFJi0=
X-Received: by 2002:ac5:ca86:0:b0:4d3:45a2:ae53 with SMTP id
 u6-20020ac5ca86000000b004d345a2ae53mr601563vkk.16.1709281863663; Fri, 01 Mar
 2024 00:31:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229172549.444227-1-brgl@bgdev.pl> <ZeGQk82bOZA7H5kS@hovoldconsulting.com>
In-Reply-To: <ZeGQk82bOZA7H5kS@hovoldconsulting.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 1 Mar 2024 09:30:52 +0100
Message-ID: <CAMRc=MdVzbb1ZxYprwFRDnCz0M=FQgZ1Osq-2nTxo5_AvKwqZQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: fix resource unwinding order in error path
To: Johan Hovold <johan@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 9:23=E2=80=AFAM Johan Hovold <johan@kernel.org> wrot=
e:
>
> On Thu, Feb 29, 2024 at 06:25:49PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Hogs are added *after* ACPI so should be removed *before* in error path=
.
> >
> > Fixes: 6d86750ce623 ("gpio: fix gpio leak in gpiochip_add error path")
>
> This Fixes tag is not correct. Back then hogs were only implemented by
> OF so you need to find another commit to blame here.
>
>         git grep -pW '^int gpiochip_add(' 6d86750ce62391f5a0a7985d5c050c2=
e3c823ab9
>
> Johan

Ah, indeed, looks like it's me who really borked with commit
a411e81e61df ("gpiolib: add hogs support for machine code").

Let me fix that right up.

Bart


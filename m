Return-Path: <linux-kernel+bounces-142241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 920228A296B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C71A285B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B03A38FA3;
	Fri, 12 Apr 2024 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l3XjiX9/"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E4018030
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712910951; cv=none; b=RYXdTiaoo7FHflWVfLV1kQzY0ossoe+n4qnb561lVgKj01z/Kgcyki2eRMnkQOscXuJz7e7vptOLd+/RKZuC6l9yO+xukdShmXza0wkuLGt1C76j0Zwa4moLZmRJ7D+qL1CoEjuZ5Nm7lfht/38RLheQzABUgpS0zECAVRnA7BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712910951; c=relaxed/simple;
	bh=NXQ75a3FjwYxIteev28RRS+HqX7YmAFu1v3daT9bg2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=De0uPrEUPPhekZitKqXI0Cz72uiyyrnsmXCXQyEj83troh8ejdsjPHyaUrBqSo2suQcTJOzQC4w1tsJd9cKOglqX6GEn4rXbgzcAd93xwtUIhnJHwMhMD3gm9NFV8YrVZ9OLRG4txaMRNcLGJIbgXqa05uCn2jGd+1rS5h8pdOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l3XjiX9/; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dbed179f0faso1110392276.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 01:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712910949; x=1713515749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXQ75a3FjwYxIteev28RRS+HqX7YmAFu1v3daT9bg2w=;
        b=l3XjiX9/TaO9E4fxMD7ZXlofpjM6zFi3WbHpp1dtZGu0DM1j13YQaolnK8Xq9rMuyW
         vfwCyrIDEdvjQBifVmF6lQgQEItp/xeg2B0JjyUBfRJAdQclM1drxMwqt3Rn+ufiDGPH
         ESmflo+aTfTMiP5w8V4oEiWyYzLDd1Hu94O6BzlPbVtTCkrgpiLD9/nRQvOTHCf6O8H4
         otqPsNMzXljPqEisDAbgiw4PwfIBDr2iK4SE+3BPN7aHEQPPZWQmIh0RV7RCc85/CnwH
         HTGrW6iTG/aIDpfZQ/RMCmXEFZJ0dtJ4v5qvVFv5YREiR13e+uvGuUDk2oFp0wmSd4lG
         lWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712910949; x=1713515749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXQ75a3FjwYxIteev28RRS+HqX7YmAFu1v3daT9bg2w=;
        b=ZobLWAIGqTp277ZilKKdoVc0St2UpbOP3p2Wm6GZVZVnQWt7D1STKTuSlJZShqXjP6
         Tu857bjII3SUjqRUmn0XwNMsldUqoGj8Yf6jloympUIR+mHPFX8bg0Zl2xtTGIyF7698
         9gs1/hZMiNsME8oMvK/QI9XIi4v4R0ikbiv4eUMlAxHDrcjgPPAGVSdIDsftr1lDRdGd
         ek3kGxlJexUNFTsJ0oRVi7mddmjTaebdcS7/q+Cbxwl4Mz42y5C7YqpmFAKacaxc0qLm
         vWTXvmPqHXdBlVgc/f4Bqdm0JnruVDIiJtOOynENBBwKBXQlTGO9Fy43icZMJf3aS+QN
         OcKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx8l3hDKZcAW8kj7SnMhqjFJe7Z4tOOvMeABAChNZ8pJq1vsUgf6WVEikHL2tPpiNDk4E0RkwzDQ9Dts6O74XMHGwWRAQAKz/LdjfF
X-Gm-Message-State: AOJu0Yxoc4kGKslxjYwYEZEAEO/BpCv8pDExtcY2qNi2Bah2gZrWb78r
	e6IC/PWnz6+bvzAN6991wwEYvm69r97db04RlTrYYkvokaNaPceYUEnPZxpc9v3OiFqqyQmDOUp
	1I1j+m3W2OhaNP6FPRZK9PXt/0FESw4mCWH3/fVai5HPKG0aO
X-Google-Smtp-Source: AGHT+IEQMDPCClORhHrFh1S7GZ4UFVkhjRVOKCR8Ltk1OQIkxte25m2JtIrAmfkvoiUWEk25cgZKOj2DzKEx6IfW534=
X-Received: by 2002:a25:5557:0:b0:dc6:d1d7:c762 with SMTP id
 j84-20020a255557000000b00dc6d1d7c762mr3907022ybb.11.1712910949423; Fri, 12
 Apr 2024 01:35:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410072102.1200869-1-andy.shevchenko@gmail.com>
In-Reply-To: <20240410072102.1200869-1-andy.shevchenko@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 12 Apr 2024 10:35:38 +0200
Message-ID: <CACRpkdbOhxp1z15LE2FS36+zzhoxrqBMELt8PppnK0NXRyeqFA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: sch: Switch to memory mapped IO accessors
To: Andy Shevchenko <andy.shevchenko@gmail.com>, William Breathitt Gray <wbg@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 9:21=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> Convert driver to use memory mapped IO accessors.
>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

If this is the direction we want to go with port-mapped I/O then
I'm in.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

An ACK from William may be in order, he's usually keeping track
of the port-mapped stuff.

Yours,
Linus Walleij


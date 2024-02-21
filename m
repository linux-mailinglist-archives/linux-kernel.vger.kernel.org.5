Return-Path: <linux-kernel+bounces-75617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8145D85EC00
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11737B24017
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070523EA92;
	Wed, 21 Feb 2024 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4BGRkzg"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE9C126F35
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708555823; cv=none; b=lm6OevkgH6FbW1S3aAUotd3dPI8q47CcMRICgUu1I5CURim2u2gDFUsjoHmEXJgNiEt0aoRszCO28xR8GGy98ZRcIauNhE6D0RzRPyDZ4k83y1w+qIToRpQRgYniPEnMMW1l/tJXEvtWwPxZZ0ybIe6QABU0fKx2Tns2WqvQmcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708555823; c=relaxed/simple;
	bh=Pip35SH9+CdhvlajwI853O451jz6n1f18cqP9XQpX2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWSwQy7XYX8ponGAKAs/BwUvFsMZPN/m3L/miOElRAkUXQoR6Qx9CqREE/IPV9RY3lDAFhq+XZGO067LvsmfvNTRgk4u+spJ/dSiwt+mXzDgtaP3Xo40ByfLzgWG79M9lUZo64JvlVy7Ti57OAbS03hi3k1Y+zy870rH0+btPeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T4BGRkzg; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d5bfdd2366so530265241.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708555789; x=1709160589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kIUQjuesaJXPbW05RrE0sIWWykVRMpIc4Kl99N/9cg=;
        b=T4BGRkzgI8/uzDOXKFcPvS12TTjG0+sP3vHbwK803mgCJqqq6xoTEtdZP37LLDDrIQ
         3aXzRcUnrzpedHIcQPJfC9/xZHLXsKK9HdJcEEfSdYT7Fn4tYxQx4rrf2X7GeUXE8i2h
         kEGQW1tRZw+QdjgRJXzgb5l6SQuiSVjrxJumVcbNGHa8+hfDRS+DMsqMGIWtoWNh6NWA
         T6kBjV6pmG1gTMUi6YmvKXFQxfkMiCp4O6eVuro0aWL7DtdUeXUcOc8PqXOBikC40bAU
         eRWJksh3YtYS18X1X/AsXDsG7FWF/65jVUj1fo3zFXfJOjtQgzCDxcZbGWknbo8OZuWF
         Ly5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708555789; x=1709160589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kIUQjuesaJXPbW05RrE0sIWWykVRMpIc4Kl99N/9cg=;
        b=g7++aHd/ES+Gy00URVI6Wbw7loRBycSmByvZau+Xv8fkNeMWoqbNDYyK1Z137I90it
         XTBlcDP12KtUszWU5GDNGfIJid4J/95x7bGAG0xgvUpzEHh+ELcYTn9qFJkP0SeANo1u
         LXukYD3w9yM2IhsWBQM+YI/v0YI8fb0e6WK5FQ7+kqFChn5Xe7+e4/qI3IeS695bj7/b
         IWzlgjDWt239C1OXag56Ep2SPS3KPK6GtFt0edtoFHaB80pcdxom8I1FSeUdNYi/umZd
         peaDNU7GZ6ppT5YLcY/N7r8yGf4J5x19VZm7P0AcUVdN56oUOnAJ4LKKP7/Ig17cLOGF
         V6hA==
X-Forwarded-Encrypted: i=1; AJvYcCWbq0sGLfxRP8Tn0R2OvXUkYSzWQf7oNBfq403Wzmionrrg1xaqs9hbU2xLs7p7Idppg1YTss+qAn+VXpY8vLdWTSsxLQHWGCS7e9Xx
X-Gm-Message-State: AOJu0Yz986br5yAOy2OCm4AoKqK5G52tWA53T/6h0+qjbtZ87peMfSNj
	JvHWxXQQNdXL4bbPm/VFL6lSzqey2S94KBXhFOtE+uC77r7G5rwk2In3uQDF4XqTPThQWMlWlTZ
	fNBSEpChsV4bAiosd92cCVSYNNuAe6vTbnm+zMajWTID+YXPu
X-Google-Smtp-Source: AGHT+IElkiaCXsCJBCsUxDG0AfmMhYZFKXDXyel91r1laTg8k0E10NkHbyD70fwtw6ZHo/kgp8Mz8TgJNiCqtyZiR4E=
X-Received: by 2002:a05:690c:72a:b0:608:8582:8a12 with SMTP id
 bt10-20020a05690c072a00b0060885828a12mr2571986ywb.4.1708555768842; Wed, 21
 Feb 2024 14:49:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220135431.22910-1-brgl@bgdev.pl>
In-Reply-To: <20240220135431.22910-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Feb 2024 23:49:18 +0100
Message-ID: <CACRpkday6DfkxfRNxjh+T+-i2E1=Ty5hSecnK+o_we+nAZ47GQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: sim: delimit the fwnode name with a ":" when
 generating labels
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 2:54=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Typically, whenever a human-readable name is created for objects using
> a software node, its name is delimited with ":" as dashes are often used
> in other parts of the name. Make gpio-sim use the same pattern. This
> results in better looking default names:
>
>   gpio-sim.0:node0
>   gpio-sim.0:node1
>   gpio-sim.1:node0
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

LGTM
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I guess it could affect some tests?

Yours,
Linus Walleij


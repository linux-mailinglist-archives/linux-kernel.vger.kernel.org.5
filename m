Return-Path: <linux-kernel+bounces-86764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A6B86CA6B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9021F21AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959FE86266;
	Thu, 29 Feb 2024 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z9Kqqr9S"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C987E572
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709213924; cv=none; b=XurqZBsHqf68eU/Vk3W9PqEl22Ye/fkM+ixVb2qqC24gsnsYsXN+ipUsUnM4dtgMtFnd6vx1q/CAOKYPWVLEVHc3CUFHsrKw+dqyzoVkWnkB9AwQ74gKs0r6AJNgi5K+sonQjR4PGarj/NNjgllSMRO3wMhZwscQEu5s0tZlGW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709213924; c=relaxed/simple;
	bh=IgTG61UP+6FyhLCLuzFpVqoxtaeq7U//LN38utfZLxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKOu4mY0uVYpt/49EKQ3+d79Boujt6+K1KppUfIqx9Y6NuMFh6fFYlRVs9a/2EsIELbTOwH7Ol3j9F7N/02fOYxrAFvUlB75f/Y3QWO4kTYOLqZPw/CFHb8ueNod3RGGLfrhcvFHQZZ3LXkLn5RA6XzMFqxy7fq+wuTdLDI6tCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z9Kqqr9S; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso1003717276.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 05:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709213922; x=1709818722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgTG61UP+6FyhLCLuzFpVqoxtaeq7U//LN38utfZLxY=;
        b=Z9Kqqr9S/du3pt1DwFfxkty40yun2kbpGuXsls5dArBUx/N5nf0Re8a20KcqiT6fKW
         lJPnCUJNTM8zXDByFbLsjX/fYGj+/ppiHliocmsw3DrOf1iJeMYH6JfrH8O6VQBFRRRF
         exkm7IL+683UWpHoESs3jDULwNysjpRgaD3bF7CZk3KKLx+1eQ3JZI8DG5UjpomFTuAH
         04v38upX79vjFkOi4+uR/k4BkT6PT87/39Wqel3+MxKxbWArEG4Wtu3p8yh8mIu841Z1
         hx7EdqH/FJJLtS/vKp0nWNlIRQpvD58AmGICvJEcpHAhH4MO/KCZtaJYvfUjcv/D3U//
         JIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709213922; x=1709818722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgTG61UP+6FyhLCLuzFpVqoxtaeq7U//LN38utfZLxY=;
        b=xPVjyD7eSgQZxf8DRN18zIg+Keldhr62gIxlEXnk1RDaOCHAve6lJ9+jK51jefbH2w
         iO2o2d2MjE9LLOtg3UtVK1lxcCVHcxmOPW6q/m3kW3kasvkTI13bf/yMHl7Qge/ZoY8r
         VCS2Pp4ALWlE77YzbWWVz3JheZZn/WCLYEMT7YYjPv7mkmTnf7zul0G+Ji/ZJbYDWo2J
         KHsm9Za+rgHLnS+VP72Ec5Ye20upLMnUYVJBND6B5L0Nh6aWfHxm+AtcgvP5jSOTR37+
         7sEkEUOL4lp+smvACgrm68DS6fVFjvViYqd0kVN0w9OsT2rsDCcVu6NwaQKlxEYJxS+U
         ZQLA==
X-Forwarded-Encrypted: i=1; AJvYcCWinuZO7hs3cMMCKOX5L0r7S3hd3eRL1/9rakhPlwahJ4OA6xVSgecJ8kftqw5nIw8mh06kLwdNbe7WVg4V6fEdt5vbZARVX/7B+Vl4
X-Gm-Message-State: AOJu0YyR37zceAfG7r6ZgcowLBN5PouFfCLCCpY/3nCMz0eeD8kv4jmE
	SD5+WIC/E8uOqsUVem3Pu5bKSJoPWYYSaAbFGp9WtdsCWf5KLgCdAdtCbp3hw9aRsN7b7wsn6vs
	0rQzLHqY6uvtoEylC8JadUWNhlhLRZoCaFRK52g==
X-Google-Smtp-Source: AGHT+IHM+r25TrBY9AX9ipefyLXUMLaheRjIdWYWuABgl1FVp0VyIn45HlK3V83H/L/hgt8QY0zg7MnvQFGOqbohVwM=
X-Received: by 2002:a05:6902:2193:b0:dc7:4b0a:589 with SMTP id
 dl19-20020a056902219300b00dc74b0a0589mr2680154ybb.55.1709213922539; Thu, 29
 Feb 2024 05:38:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223162850.3914349-1-colin.i.king@gmail.com>
In-Reply-To: <20240223162850.3914349-1-colin.i.king@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 14:38:31 +0100
Message-ID: <CACRpkdaPxGX249Uu5GsP79+ga2=k40u2+oeGUYpEaXAnh4+F0g@mail.gmail.com>
Subject: Re: [PATCH][next] pinctrl: ocelot: remove redundant assignment to
 variable ret
To: Colin Ian King <colin.i.king@gmail.com>
Cc: linux-gpio@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 5:28=E2=80=AFPM Colin Ian King <colin.i.king@gmail.=
com> wrote:

> The variable ret is being assigned a value that is never read, it
> is being re-assigned a value in every case statement in the following
> switch statement. The assignment is redundant and can be removed.
>
> Cleans up clang scan build warning:
> drivers/pinctrl/pinctrl-ocelot.c:1404:3: warning: Value stored to 'ret'
> is never read [deadcode.DeadStores]
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Patch applied!

Yours,
Linus Walleij


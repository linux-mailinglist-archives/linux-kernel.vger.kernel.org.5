Return-Path: <linux-kernel+bounces-151479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BF98AAF60
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27841F23ADA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9FD12B14A;
	Fri, 19 Apr 2024 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l0zhs5QQ"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08EA12AAF0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713533525; cv=none; b=mKQLmt/XyKg+RvHoC6lKz6CzsjKsbzRn/ZtdRoqwfrS75aj0bNzRzwrIZzKA2wo19Y/slGFMziXBwYHXM/rD+1gxMiwM+0EgDrufHhkjhAf/ma9aZsGdQpKxi4a8BK6k/5uHkygMukvi8vvtHIQTUlWf5u11aQGzW0yOoKnBP6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713533525; c=relaxed/simple;
	bh=fhRZLpFsQ7ybY9l+xJ4w5t3vGVBb7qMjYrDhTzkEaLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYAoyQbmAPHEHBrb3b2/qP1KOhIEnaC/q534FDeqVtZL8uzXYcNJxTZiVLYnN4lfbMyr9LYTqeNy8iJj466MiyQqmp4yNjPMfUpuJb5UDqE1wCFF/kiYHuJE1RdUXczwvHNajW707zp14bamCnPXo00JT8kSSCGV6Q1n2aDTd3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l0zhs5QQ; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de466c64163so1884481276.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713533523; x=1714138323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhRZLpFsQ7ybY9l+xJ4w5t3vGVBb7qMjYrDhTzkEaLs=;
        b=l0zhs5QQ46Yrg9eznLOBmJB40eeR3b3xojDdVlcHzBBBsv4Ici7Zb+aVEp54UG0V3u
         v9pci332u9976NuzrU1Ca6NTqlG0Fz+kYn7ITeCBKY5xEw6SQ53sbH16/oWMKqmIn7Ua
         ErD+7nI59w6NDrqvEOMv5xCh6vqMEpHAYBraxctXaUZXpwSEW44p9c2I+JHKFj9US5NW
         Hiq/L5GtSU3X9fEb7rstVRSOO8S3dQ5QToJdh5+z2g3MkKXARY0I79Iq7PdAbbGNjL56
         lQSTjEyHhTVK9YlgguQxFL71kNlmxcD5Cg+F3CPRmBvpXk5Tbc9SfjmaNEE68+lyFGIS
         fxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713533523; x=1714138323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhRZLpFsQ7ybY9l+xJ4w5t3vGVBb7qMjYrDhTzkEaLs=;
        b=ikTAtZznrX7qnUpmiTDGASP9P2IDzSO2QIJ7YuuafBGrbyyJLR4L/zyJrZ3EkN0AJj
         bnDbfdIFUNj7Jk1N2DwQcqpzKp7amQ9yv8OTlbPT1R9W3G6omslkklnbrqWgD5cxiX8h
         9V+lFsGAVpfnqk6pwtjt03wqjhZxAptBAHXwUhKBkTXu01k7SFNKm09+8hxrhaFvOXNf
         8qXd7TerdzGhW3RwT57j3ACUcDVFuSZXpiAUC9Ke7WJELuhiFv0JE319bJrruCTi9kv0
         ue20lWKUtpzQDxduAV1rHfw95TikJIkCYI5XB/ykYxkD4vOeK85ggq/9/6F2fOqNKoQL
         kFwg==
X-Forwarded-Encrypted: i=1; AJvYcCVFJ4vF2e2hddFOR9OqAwvMSkfduyomGUhCpauq49tVYVDPe6TVkwOWpZpWC6qSBolsypqGMKho6l5EmikBdsZ0YO07l2BLsdqHzKiG
X-Gm-Message-State: AOJu0YwNOZ5iDI/PF+d99Ot/kqSI0qQUdlNM9sUO7Pl+Q+tzr6fSZVLu
	myCSTe4P+31TFMZOCtEZiztdXPAR7HGTPMIZLK6QEO5OeRxWjvYTubzmDiuoK+JVWzfgZFBrqDs
	M3ArnigYhCTV10Lzhqz1WmCT4NyOh56mhzQXWew==
X-Google-Smtp-Source: AGHT+IEou1g+hlEnF+UZTysGeCw64FZcHI0UHv68Ib6xcR70RGN0JzF6vOEoAr0MN7ZeCOnx92d1upOtm7sToLZnVFo=
X-Received: by 2002:a25:dc53:0:b0:dcf:f78f:a570 with SMTP id
 y80-20020a25dc53000000b00dcff78fa570mr2107378ybe.7.1713533522845; Fri, 19 Apr
 2024 06:32:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416161237.2500037-1-knaerzche@gmail.com> <20240416161237.2500037-4-knaerzche@gmail.com>
In-Reply-To: <20240416161237.2500037-4-knaerzche@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 19 Apr 2024 15:31:52 +0200
Message-ID: <CACRpkdbRTOV=t4Y+xKR0P+q=N9XmTWkAWHWptF=-uSrA-9Cq_A@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] pinctrl: rk805: Add rk816 pinctrl support
To: Alex Bee <knaerzche@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Chris Zhong <zyw@rock-chips.com>, 
	Zhang Qing <zhangqing@rock-chips.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 6:12=E2=80=AFPM Alex Bee <knaerzche@gmail.com> wrot=
e:

> This adds support for RK816 to the exising rk805 pinctrl driver
>
> It has a single pin which can be configured as input from a thermistor (f=
or
> instance in an attached battery) or as a gpio.
>
> Signed-off-by: Alex Bee <knaerzche@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Lee: pls apply with the rest to the MFD subsystem when you
are happy with the patches.

Yours,
Linus Walleij


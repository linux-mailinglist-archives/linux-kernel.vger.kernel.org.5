Return-Path: <linux-kernel+bounces-122762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B7188FCC9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005C01F28FDA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE887BB17;
	Thu, 28 Mar 2024 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPa5VPxI"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441D21EA8F;
	Thu, 28 Mar 2024 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621240; cv=none; b=maJXbdRan2qqK4BVrawagdqQ1fTFvdfcj9sKjWMJPexOC+5wv2pOImD3bx2qMEGfa6b5OfmbiGMcT8oi7YJrtdFO0HWOs3HNXi/LoxVJ+eDGXV7S2m3jJ+Y3/GKen2E2Vlc3M7phwzOOmzlYdHmVqmZuICKZ2vjbwbVedxYUXXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621240; c=relaxed/simple;
	bh=dFfbT4R29DplG5nbWguPk4hVE2SH+TwGco0Cl6FKVvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOfytt33MDqR63YcxTiGAmAD5ZR/iSL0YuGQ4wmzERnK+FzVkXIYoT6SD23LJZg7H6dd823C0r6KHIxHUQLcgnb14fubx4dE3QA10VsQhbl+1vBiSrtu1MjU1DrY3zPUXOhvdfqyyHlXltlUN+Cpkvot3YEOrMAvQVuwnEdvXGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPa5VPxI; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-609fc742044so9152767b3.1;
        Thu, 28 Mar 2024 03:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711621238; x=1712226038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFfbT4R29DplG5nbWguPk4hVE2SH+TwGco0Cl6FKVvg=;
        b=RPa5VPxIMo6KzMl7VVNc6fYxpg1W68GUlmVc5vGB6/zTDeAhzGppcS0tzfMVIhJgWd
         l0Lq7hzGsJBLFpuIcPtZ3LhV7QWZv4lL6MSePmfrBg+WQyjBBJLoG7zid6B31MIeBsVo
         5HruhtJHsXL8UYAPSW82Ok/uWVX4p0tqs4P9O8SUrVJgHRfgDh+fikcWb3+8gozplRS5
         q2XqXLjeOT/lVpVQsvgt3pGhTRpzx2j3AeYZ+KYLHnKu8F1QYWOkkv4Auf9mXKihahy4
         MHqQQVIgbSPblF1yBKIcUh81xah5g7zhHLLdRJRr015IqcpRjzlppO1nbIdF7QX638IU
         +RUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711621238; x=1712226038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFfbT4R29DplG5nbWguPk4hVE2SH+TwGco0Cl6FKVvg=;
        b=db4gW9UuICNSkFwKh0pcnIeemsvtSZiD/39fSC5EhNDqmoa+DysAshZ4scy+fMp3rP
         qnieQaoQi/7BvoxRpKe4/dAAL7qQm+wrbFj/44RcSEKPcNmfO/wVVMB+I1LdX7VGoAzV
         ksfS59M+7c8La6pdUgYG3POK1nUDd+qlgnwf4rd3Nxsnxr9AaL0UgFdZ8tRCBAfL9jjo
         oFyB3YnanaM7SW2Om2QHgM1j7XZyOnBNraJwTo3+sbR5vT27quyZBYquGbRl14CK9cVC
         Tl9dUe2tfpokF9/2uHxr91w/IQG1D/61JLYVGUhewx7mYSfa4ZhDutoiLU/rKEbuht8f
         uhNA==
X-Forwarded-Encrypted: i=1; AJvYcCVGxxKVbwTpiF8OLTvpURHTWc0r4TOsnh91QJwiGsU5S1c/XDmtAwg4X5gH8Hy4znAQ4fsiDZo9b7E2GRombux08GNtQIuQJL9sCcZaNr212jj44my9KcAqd9CcP0ABILIIIKATeK09TZ7I6qN0JgY8X3XAUT/M0wAcZS9085U1kA5lNQ==
X-Gm-Message-State: AOJu0Yzlj9GIgLTZrCTD/JnzuUJyxXPhYLPkHOmBPKWO25GbkPFOeC1G
	58TT96bW7lnSAgLcb9Cvhj0xxOkWiozKCtTweq+hB7Mys+0AScFIfA7G9Ov91zzeDYDrp+u2e5x
	Oso7qz+uSwOxBx/aT0UorsJUUg9w=
X-Google-Smtp-Source: AGHT+IFi3DZWKmlRmlJDkasacGqfWkgcDy+WQNzg9p8xoAOHDvfmaJ3gX6Rg4YeK1AS1UxcZIQliUbOdK/3N0aQIv/Q=
X-Received: by 2002:a25:81d1:0:b0:dd1:6fab:81e4 with SMTP id
 n17-20020a2581d1000000b00dd16fab81e4mr2315769ybm.37.1711621238324; Thu, 28
 Mar 2024 03:20:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327220320.15509-1-l.rubusch@gmail.com> <20240327220320.15509-5-l.rubusch@gmail.com>
 <9ab1fc70-fd01-437b-9020-49618924ab30@linaro.org>
In-Reply-To: <9ab1fc70-fd01-437b-9020-49618924ab30@linaro.org>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Thu, 28 Mar 2024 11:20:02 +0100
Message-ID: <CAFXKEHainYo6esvdy5-hMppPk_WNbXWQKA8Np4Vsxh9KPrrwTw@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] dt-bindings: iio: accel: adxl345: Add spi-3wire
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 10:22=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 27/03/2024 23:03, Lothar Rubusch wrote:
> > Add spi-3wire because the device allows to be configured for spi 3-wire
> > communication.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
>
> I don't understand why after my last message you still ignore my
> feedback, but fine. I'll ignore this patchset.
>

I'm sorry. I found it now. Please ignore my last v5. I'll repatch an
adjusted v6.

> Best regards,
> Krzysztof
>


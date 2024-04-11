Return-Path: <linux-kernel+bounces-140648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0518A172B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF4E1F21B94
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4DF14EC4F;
	Thu, 11 Apr 2024 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/uY6WlZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D4F1E516;
	Thu, 11 Apr 2024 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845745; cv=none; b=RNd6hmpHlr7xTEZ9vBC9ee6KZRPq55E0xvp/xXoTKFAdf+CjOz4m86p+15zB0A/9M85OnXzRmY9++dWi1Gz2ZgcmJ5ZVdUQodJKWyUGnmT9DaBkb8ixtzKjKPjoslp0BBuQHbBr3HxrvPzC4mASuNrFuxQ4mh3VJmzv4Roy+WiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845745; c=relaxed/simple;
	bh=/6/pHHNCDaJr4U1eB4i1Ub63noExMP9hU0/7JXz8Tj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nz2mwr/vIrC3kveZ7OWXPyXTLvAvQtgZy+2uyI/IrrTjvvAsNCBMmG/iUpJNCSuyUQ4GXGI6xPw9J+yHiYnr/U2z9QQ20sWbfgMpDKr0udvM41pS60+v5jxV5sR0zOHna/P+SRW3c/hJprZS6bRS9m9cJNGf+ipWA2Rt4fhg90Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/uY6WlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F01FC2BBFC;
	Thu, 11 Apr 2024 14:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712845744;
	bh=/6/pHHNCDaJr4U1eB4i1Ub63noExMP9hU0/7JXz8Tj0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o/uY6WlZ9ZusFx/d0QGV7pqL3nqPlWFth84p3CC2B7Wzi083oQb+y2bzn0vSI1hf4
	 MriX6liSPCjmfhdbi24tl/5vH1yJFj4QcejKXVLzhAsYJlbYUOhVI696/NJq8hcSTP
	 TvenZV1IgBebPQSfK6/cO2whrfyVynwaabqpIdc//9OZab9GH5Pog7bhmBvlUs+14Y
	 lsUuGgDEXeC+pv7pmqxdFed+cvwBc5Q7C+TD0KtQjlwO3W99/rLQwmsX9udkuFFJbS
	 RpGnHAJS4qn3+GswMnRdugYUHNU2ncjvmlVHlQ1GeP0D5KQp81oyx5TnmvqJNkFRzA
	 Gd/84fX+fIK0g==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d89346eb45so56988151fa.0;
        Thu, 11 Apr 2024 07:29:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOy+D7R51C054rYOLE6WpJMFKSlf+YIfRFNCBfZ+SEmTYi2iID1ufH6aJFtZtPKtyPmJAor004YJuQLsY2Tl65TlEcJ1UfgIQBEHVENEwGP/6xFYzUpxoc8JlBIyECuuBPOcDIbIMj9w==
X-Gm-Message-State: AOJu0Yz/yzBsdNo0VdsE3l8EWf1Rg/WWi7rJomVoTjiGgZ25PXHtBS1e
	PWTPJvRMxCB0Tq46VUs6C6DOn4LkGn5e4xf6v3mhf+fqpxbK5Gcx/5ZaK6iJFbyXwLaVVWbQRb1
	M1Pwi9Uh3cYtO1ikVMHnS7+TA7A==
X-Google-Smtp-Source: AGHT+IHkxgk8HKIxXpgItwvxPouHfWy0GKfJySBa0JwtLQxB2FzUk/Bj/CMepI9EU70gf7zgbYKm98yjt5ElfnrOemA=
X-Received: by 2002:a2e:9acb:0:b0:2d8:687d:b22 with SMTP id
 p11-20020a2e9acb000000b002d8687d0b22mr5503851ljj.20.1712845742968; Thu, 11
 Apr 2024 07:29:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402202413.757283-1-robh@kernel.org> <171283980874.2354899.3662943965972729204.b4-ty@kernel.org>
In-Reply-To: <171283980874.2354899.3662943965972729204.b4-ty@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 11 Apr 2024 09:28:49 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL5M0gvjBa7VvRm9B3kRpj8=c6f8k2MnG7LbA-jZstB8A@mail.gmail.com>
Message-ID: <CAL_JsqL5M0gvjBa7VvRm9B3kRpj8=c6f8k2MnG7LbA-jZstB8A@mail.gmail.com>
Subject: Re: (subset) [PATCH] dt-bindings: mfd: syscon: Add missing simple
 syscon compatibles
To: Lee Jones <lee@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 7:50=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> On Tue, 02 Apr 2024 15:24:11 -0500, Rob Herring wrote:
> > Add various "simple" syscon compatibles which were undocumented or
> > still documented with old text bindings.
> >
> > apm,xgene-csw, apm,xgene-efuse, apm,xgene-mcb, apm,xgene-rb,
> > fsl,ls1088a-reset, marvell,armada-3700-cpu-misc,
> > mediatek,mt2712-pctl-a-syscfg, mediatek,mt6397-pctl-pmic-syscfg, and
> > mediatek,mt8173-pctl-a-syscfg were all undocumented, but are in use
> > already. Remove the old text binding docs for the others.
> >
> > [...]
>
> Applied, thanks!

Note that something is going haywire with b4 or you applied a subset
of a single patch... I really wish b4 didn't change the subjects at
all since Gmail is incapable of following standard threading.

>
> [1/1] dt-bindings: mfd: syscon: Add missing simple syscon compatibles
>       commit: 9f43ae67db2a3d85cf2b5eebc3b54c8891200b5c
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
>


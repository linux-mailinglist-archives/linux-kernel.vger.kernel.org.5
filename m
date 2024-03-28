Return-Path: <linux-kernel+bounces-122522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 217ED88F908
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53B51F27B08
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B94B51C43;
	Thu, 28 Mar 2024 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoinFanI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1B71E89C;
	Thu, 28 Mar 2024 07:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611866; cv=none; b=CW0lhf0Yn7S38YmyHfngdzhVysWjSwjBZgFw3gyBqvWXzlIXTKsD6jX1DWlrDZ/m87GnIxYjVxL3VFV2nzlfS3/x2iaCqM6mty7C2Swz/9OLxv5ia1D431qaEA/LRhaoeyOXFh39py10N5PWIeA5jQRRsp3raWIloZ1HyPJQvRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611866; c=relaxed/simple;
	bh=rsW713L6NZekmOoVcJVtU8yCHsKQyzRJjtC7motQbGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6MknlHfmG2hkdMwBTZ2lSFMYwCAVutWnl+XCHRSnhiuQsw7UtMLPhtsLiPUVAIf3BqxujdI5czrNO+eDmXQphBGLBiXuQ7boO22woADpZ6BsWc79fDSJ3NZNtZlh3VUxd+KJLyYfNi6nzF+HuNDMtOWMnbZWSkdG4rzLa1pvzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoinFanI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B66FC433B2;
	Thu, 28 Mar 2024 07:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711611866;
	bh=rsW713L6NZekmOoVcJVtU8yCHsKQyzRJjtC7motQbGo=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=BoinFanISIerriuVlF6xTZ/QbfkQ4l4UCuna99cZDP4iKmpRCCIQVbJ6vgIKG1D3F
	 84zwpm7whTp+yHJtSgWY8tJAFyWK6CsN3bbRAL5wEhOQgkr6IRp0xTMn48w9BqbX9n
	 nthaQ4QX/yY6yF8kPuQmd26yrcK6bv91vi+zWxV8FyQmgLJEmQ8qRjag8Kq4AODQVx
	 dEvm33p1nehz7lY9eR669ZN72oXLAuJG5COwAXnYwMPNC2OdOcFJIAZdyzIeCe0MZ2
	 Du9edWxDOnBDosezes/WaKhd5NlTVgFNJU4qh/3fr/B5qCnOEGtr1olR4rpBbWtgpq
	 ipZDPvxUkqdDQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d6c9678cbdso7219351fa.2;
        Thu, 28 Mar 2024 00:44:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbThNifRUoPXb3zTfMqrteyOaav9IseBwl2d47tmj5SX7owC58KopmYClgkgrJnkTo5cSsrV63NSDWpva2qdTPTe1sh4++WOgIBYu78MOg5KJ/WEKuPceZl/vhOE9WPS+0lo079y1M/w==
X-Gm-Message-State: AOJu0YzorNxu86IxrWc60UfYglp7EZKSYI7cD+Zs+pP4B3VKj32RL7dW
	uLxbFVqFG61b/tmSVLT+E2s8OzXpQ6vCgwJUelDGqcnAFvpIAffNPN256/7cQXVsVxfgeUUJhwY
	sQCpgwJrub7B83Culcrh/HjeuYJo=
X-Google-Smtp-Source: AGHT+IH/ggOEZcR73/h+xKMWYkVaJmvS45/mU9XSwGPJV0h7bFkb82lRzycfbQybpn9n+ArZ6qPfk2jpJSl4YQ4WRNM=
X-Received: by 2002:a2e:99d3:0:b0:2d6:f127:f5e7 with SMTP id
 l19-20020a2e99d3000000b002d6f127f5e7mr1550018ljj.21.1711611864681; Thu, 28
 Mar 2024 00:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327192641.14220-1-dev@folker-schwesinger.de>
 <20240327192641.14220-2-dev@folker-schwesinger.de> <CAGb2v64cF2fuW7vKq_=AhY+ciAp8t=fxT23AFJWB1qOv1xWuNw@mail.gmail.com>
 <D05701GE187C.3VLOERXP8B3NR@folker-schwesinger.de>
In-Reply-To: <D05701GE187C.3VLOERXP8B3NR@folker-schwesinger.de>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 28 Mar 2024 15:44:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v65M5Zv73UKwEtmK=-MgDuubjKFA=R-bxceh+uL3iPuG6Q@mail.gmail.com>
Message-ID: <CAGb2v65M5Zv73UKwEtmK=-MgDuubjKFA=R-bxceh+uL3iPuG6Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: Add enable-strobe-pulldown to
 emmc phy on ROCK Pi 4
To: Folker Schwesinger <dev@folker-schwesinger.de>
Cc: Vinod Koul <vkoul@kernel.org>, Yogesh Hegde <yogi.kernel@gmail.com>, 
	Heiko Stuebner <heiko@sntech.de>, Chris Ruehl <chris.ruehl@gtsys.com.hk>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dragan Simic <dsimic@manjaro.org>, 
	Christopher Obbard <chris.obbard@collabora.com>, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 3:09=E2=80=AFPM Folker Schwesinger
<dev@folker-schwesinger.de> wrote:
>
> On Thu Mar 28, 2024 at 6:39 AM CET, Chen-Yu Tsai wrote:
> > > @@ -648,7 +649,8 @@ &saradc {
> > >  &sdhci {
> > >         max-frequency  <150000000>;
> > >         bus-width  <8>;
> > > -       mmc-hs200-1_8v;
> >
> > Shouldn't this be kept around? The node should list all supported modes=
,
> > not just the highest one. Same for the other patch.
> >
>
> This is not necessary, mmc-hs400-1_8v implicitly activates the
> corresponding HS200 capability, see drivers/mmc/core/host.c:
>
> if (device_property_read_bool(dev, "mmc-hs200-1_8v"))
>         host->caps2 | MMC_CAP2_HS200_1_8V_SDR;
> /* ... */
> if (device_property_read_bool(dev, "mmc-hs400-1_8v"))
>         host->caps2 | MMC_CAP2_HS400_1_8V | MMC_CAP2_HS200_1_8V_SDR;

Looking at the initial commit for adding the hs400 properties,
it was also mentioned that hs400 support implies hs200 support.
It just wasn't explicitly spelled out in the bindings.

In that case, I think we're good here for this particular case.

> Kind regards
>
> Folker
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


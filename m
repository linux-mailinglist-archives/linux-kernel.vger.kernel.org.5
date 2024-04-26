Return-Path: <linux-kernel+bounces-160000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7118A8B377F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26D21C224E5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3966146A7C;
	Fri, 26 Apr 2024 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uo+FlEzK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E632213E88A;
	Fri, 26 Apr 2024 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714135917; cv=none; b=VM/7n+lti8erbVmuTAuVQtR2ha5xd29I4nI0/N77RcMwcoXatGLHVOd+Lllt+XzUefTszgidsCE7Ldp1eNDDO+r+Z3Ia9eWdYqnE2vmRbFDrHOoTafl90+dTvLEX/fOTESCDhgmlXJE1Ln4BWz2dW/vK0uqLT2lQSXAiNgW96oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714135917; c=relaxed/simple;
	bh=C7edbZ7NMwTLg39d0mj+uf5rqp23pLUcF27EjZiqoOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uw6Xqgi41sMufpPnUH8nAsbt5ihUr4d0VURN96iZA3pFMjB7VU583tBQbyRe000y8BcwUoXuBataHv/VK2I3yxSjm6GVyqEuTdzNDU9CwrBTRa0uj2b+WbcJICc/Y8vaiSufOooz8Blwe3LM8u8xw79lGwYptJoaKSSfMEsxxrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uo+FlEzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B200C113CD;
	Fri, 26 Apr 2024 12:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714135916;
	bh=C7edbZ7NMwTLg39d0mj+uf5rqp23pLUcF27EjZiqoOw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uo+FlEzKuyJ+Dk4AFWz7hPEpdj2h80DNRmcM2eLlbvNHrQeNHWNbL3X05aLtBOHoi
	 U2EYj8QjTRPdzmWCX2JUjcYRoeH3AjrS1v02ND6lY/zruUaglTt4zKXFChriaK4n2N
	 8JMgydGQ9tWxrYV8+A4QYo4PtuI10Ae0YwldXYkf1kCgTxNd+ggqh2s/CQVStaWuCY
	 ANAfjYvtRsIpXbqVgn+GahpWfJbfC2GU4ScgJ8MLIjguPxaB7dU1wcWaKPS18oIDjm
	 sCZPVnkETN5iAAn1tGhHh4ajPuCSNf6LAQw+SAa9K4u4QOPiaM7y1NzO6sA4BGYvBU
	 FrXwH1QYczXhA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2de232989aaso23670841fa.1;
        Fri, 26 Apr 2024 05:51:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/nhnPmvOH+E1SnF/AGBO3zvfNhxnQMyjz99EtupxeonQt+jyoInjC/NliATN/7si4mhS+j/9ZAGANr36E/zZtScvffGuHWpm/9pMmD/ujMuA39h3Gj8DY96GhpvB+YRie0jCWGyq/Tg==
X-Gm-Message-State: AOJu0YyK8LOyrA8OpMtUjJ0fEBgSLqLXacnTjTtWjH/EWdlFjs3b3S2O
	ptIe0q2pHnOu9DiAS4cEwK8p0Xn0JuHkK5kqgV/EEUeMyJa9CQ2nvouSvMUaHdI7CyZG60rbO+W
	jstKuqnMUcFfy4JXdP9+8eFSydg==
X-Google-Smtp-Source: AGHT+IFSFyINrv8wT7arwvyPBnjADNddyOF8lWGUSuwveMOJGkmAYUl4rJj/SaMFmQ+EQyF49+4RKr1pX1bDOgTZScI=
X-Received: by 2002:a05:651c:210b:b0:2d8:4637:4062 with SMTP id
 a11-20020a05651c210b00b002d846374062mr1933367ljq.28.1714135914731; Fri, 26
 Apr 2024 05:51:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425074835.760134-1-patrick.delaunay@foss.st.com>
 <20240425163035.GA2783061-robh@kernel.org> <28aeb8b1-72f1-4dd9-b433-f5b693150475@foss.st.com>
In-Reply-To: <28aeb8b1-72f1-4dd9-b433-f5b693150475@foss.st.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 26 Apr 2024 07:51:40 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+KGd2tumATzhJu0aZDZ0C1k9VGm5_xxTiE1RE2KHs0hA@mail.gmail.com>
Message-ID: <CAL_Jsq+KGd2tumATzhJu0aZDZ0C1k9VGm5_xxTiE1RE2KHs0hA@mail.gmail.com>
Subject: Re: [PATCH 0/3] ARM: st: use a correct pwr compatible for stm32mp15
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
Cc: Alexandre TORGUE <alexandre.torgue@foss.st.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, 
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, Pascal Paillet <p.paillet@foss.st.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 6:42=E2=80=AFAM Patrick DELAUNAY
<patrick.delaunay@foss.st.com> wrote:
>
> Hi,
>
> On 4/25/24 18:30, Rob Herring wrote:
> > On Thu, Apr 25, 2024 at 09:48:31AM +0200, Patrick Delaunay wrote:
> >> This patchset removes the unexpected comma in the PWR compatible
> >> "st,stm32mp1,pwr-reg" and uses a new compatible "st,stm32mp1-pwr-reg"
> >> in STM3MP15 device trees.
> > Why? I don't see any warnings from this. Yes, we wouldn't new cases
> > following this pattern, but I don't think it is worth maintaining
> > support for both strings. We're stuck with it. And the only way to
> > maintain forward compatibility is:
>
>
> Yes, no warning because the compatible string are not yet checked by tool=
s.

What do you mean? There's a schema for it, so it is checked. I ran the
tools and there's no warning. If there was a warning, I'd fix the
tools in this case.

> I propose this patch to avoid the usage of this compatible for other SoC
> in STM32MP1 family.
>
>
> I see the invalid compatible string when I reviewed the U-Boot patch to
> add the PWR node for STM32MP13 family:
>
> https://patchwork.ozlabs.org/project/uboot/patch/20240319024534.103299-1-=
marex@denx.de/
>

Perhaps you should add SoC specific compatible string instead.

> So I prefer change the PWR binding before to have the same patch applied
> on Linux device tree
>
> > compatible =3D "st,stm32mp1-pwr-reg", "st,stm32mp1,pwr-reg";
>
>
> Yes, I will update the SoC patch with you proposal.

NO! We don't want to support that.

We have *tons* of examples in DT which don't follow recommended
patterns and we're stuck with them. This is no different. We can get
away with changing node names, but that's about it.

Rob


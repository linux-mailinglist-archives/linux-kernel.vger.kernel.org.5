Return-Path: <linux-kernel+bounces-164558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E678B7F47
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F111B20F82
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3209C18131F;
	Tue, 30 Apr 2024 17:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbJL+TLN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7379A175560;
	Tue, 30 Apr 2024 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499601; cv=none; b=gb9wT1dMzeu5FeYkna2pHA3wDhl6IIonrPJcU5cxV6OZqvlDnTrrcdpzhIKXiwqDejT47dmV1eSmXMYTHbjrYZ1fU3QQ8OHEYUWFUtzRJVp6h70w+Y660ot+F6bB+o8WQkth9ruTayLBbJa9E60b1xGyKae59bTMKgNkXChyR3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499601; c=relaxed/simple;
	bh=EjgsmtsYJ56z9zdyIVeG7EAt+Nnc2Q7ee4yCJg7gxtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5Fygi3gRzhT6WzgsFUmC/O3DN2xQZZgnqNkATGO4cMCSD4p8bRPokf1yAyFUuvRfBeih8/hO6OY3kE1bwlC8WqeItzhuVJZ9hQgsTtfYsirjsh4rLtXbtgqdVW0TnH1voIlV6FPG4j+VDVgiKqlQu6PN0AKNjJXb3sd5T4OeK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbJL+TLN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133BEC4AF14;
	Tue, 30 Apr 2024 17:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714499601;
	bh=EjgsmtsYJ56z9zdyIVeG7EAt+Nnc2Q7ee4yCJg7gxtE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TbJL+TLNx5ggbzSIRs6m6PIwCnkrs1323wBdL9YcBGlU92Luox0mSFYBh+6CgR9Hk
	 CYL/qUukm7uqBi8KxTNNM17lNkPSDufZ1RJ4hGEAYKrH53qq+MEKQqE5NUzYFzgxJg
	 RgN2Qkg3pGfGLYgi20TPAAgWdau3RksYz/SgMeVGWbiwVV75zYHZ+4mO4sSGdMJMy3
	 DefExk1RboXKh2DRvzjy8OynbAnJYMU9GVrv7uoqgnW9inFxCPkhVy0z2FqC5n8OiK
	 cajoX4L5pXw1NvgP8qhCZe5gTdnHw8/m6Cxn9KOxkrLCEsOSvXYnVObPH37uXzX0GW
	 qj1HiPsfJnJBg==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e0a2870bceso30560261fa.2;
        Tue, 30 Apr 2024 10:53:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURGWKgkEe7TaCOC3SP7fEp7hchmg4b1PTb3Oq7Bt6xEdRQDNGUgfOmyEWOQSuTm36doxFol9ilDYrcaqlPCD9V5VzjVTZhcoB8N1pLbm4EEDxMGlujdt5sW2qy09DHOaKRgAijzRrvJw==
X-Gm-Message-State: AOJu0YzAcZx/h1gBpSpzGPJhiGLKkYdK8SC+o9OLj1ZfxUmJU3zKRPm2
	ShZCzjuq8vRwJ+0s4U7YbLykEP/W8A3Dp/cgnhADZeYCTy7PKTZ6veurl7aDR8J7ZAgqmCMlcUC
	z5M+bj4QCcxMFwXdsSEBaFvnn9g==
X-Google-Smtp-Source: AGHT+IFhHkqLhgpvwGTt4C10o31XkNU0ZIZ09Wxl2M1R7Je27A5LHpVnsz5LsILEGDumPiTE9QiwPy0FsDiPk08bc1A=
X-Received: by 2002:ac2:530a:0:b0:51b:abde:b18e with SMTP id
 c10-20020ac2530a000000b0051babdeb18emr111387lfh.61.1714499599323; Tue, 30 Apr
 2024 10:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426195438.2771968-1-robh@kernel.org> <20240430-unsnap-eskimo-444052f98b7d@spud>
In-Reply-To: <20240430-unsnap-eskimo-444052f98b7d@spud>
From: Rob Herring <robh@kernel.org>
Date: Tue, 30 Apr 2024 12:53:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJLEku=NT-JPE7cijdhPFEQm+i+cghOt6e4+LNOGP8oPg@mail.gmail.com>
Message-ID: <CAL_JsqJLEku=NT-JPE7cijdhPFEQm+i+cghOt6e4+LNOGP8oPg@mail.gmail.com>
Subject: Re: [PATCH] yamllint: Drop excluding quoted values with ',' from checks
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 12:40=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Fri, Apr 26, 2024 at 02:54:37PM -0500, Rob Herring (Arm) wrote:
> > From: Rob Herring <robh@kernel.org>
> >
> > Strings with commas were excluded from checks because yamllint had fals=
e
> > positives for flow style maps and sequences which need quotes when
> > values contain commas. This issue has been fixed as of the 1.34 release=
,
> > so drop the work-around.
>
> Hmm, is this a bit aggressive of an upgrade? I only checked Debian since
> it is what this machine uses, and it only seems to be shipping 1.33 in
> testing & unstable.

Humm, yeah and that's what the bot is running...

It's only required if you don't want warnings. The issue for me is if
we don't enable this, we get new cases we have to go fix. I could
enable it only on the bot (with some work), but then I get 'I ran the
checks and didn't see this'.

There is also a new check for quoted keys that I want to enable. I
haven't done that because then 1.34 is really required as yamllint
will error out on unknown (to older versions) checks. That's what
really drives the minimum version.

I'll hold off on this at least until it lands in debian.

Rob


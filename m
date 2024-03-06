Return-Path: <linux-kernel+bounces-94483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A961D874070
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C1D1C20C23
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2733914036A;
	Wed,  6 Mar 2024 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sI3xyIiw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C5F133425;
	Wed,  6 Mar 2024 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709753643; cv=none; b=Xw2QoVrSL4tufs5S5r0ewdBgu9iRLNzJ1uf+z4lQx0VsDznXJ01uVcMSywhid8sZzhupo4LF7r7+GSUIXZW6wzcJnlO6U8CIrJmmfv34k6eGTrj6fm9iK/rbCWMP6wfg9TYEZMLh2C1p+rrWR6mSgSgcS1VFDB4KB4mS4TU3yCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709753643; c=relaxed/simple;
	bh=NxG7c84KCIRvUyNiatI7Fs+XWdHJoJzx+ZoNblQinjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lk9Gfe+xdmOVnCGrDeNGF6Rpcw6FO0U7ZhUD3dUCnTch5IKGGOnoeWbasQWlaoptjo1LVSY46KT4Q0/cKl1iiMZZdSCJzfM4eY9ljyyoKukdtb4X5ZS1i2DJpyXNExiX2tOmztMmTAkaqwSeXpFjpPhHvBUdhmtL8Ddd4OO8G3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sI3xyIiw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC36C433C7;
	Wed,  6 Mar 2024 19:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709753643;
	bh=NxG7c84KCIRvUyNiatI7Fs+XWdHJoJzx+ZoNblQinjQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sI3xyIiwHTEy5SBgnTMY3TrPlZwq9SmhjZDA3o3XuyBYW6Ilz5GycQ3cmEqXLHlqb
	 NtMW704FzJsUsA5tMJJlR8ng51LeB8vk3tykzHfdfzrMCaERjqZD92Vl/sMD8oGrwy
	 0+CA9HU38I3B7kDacb4PJaWoTDYw+TcPVCrBwPFTihACxEPT/bDXf3T72wf0+o4wlC
	 OGR8wjzzorHyMjrpV818+W6oZ6OJ6OOczVeUg8K3DNrHfdrMYVPcaBm0DXfDacjZOI
	 lKhNQ5F/kgjPK/+Cz3zRP9jWgy5vCbtKaBiB3HajvvwbOH9c67Hx19jBmfnaXmbEZX
	 anPiZjZmDxEWw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d269dc3575so1364151fa.1;
        Wed, 06 Mar 2024 11:34:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6cEj2mTN20e5HeznoFbGBj9+QBt6+UmhHcIBkwqHJLfmKjig2DD9d1Jhw/324ZMPiUlFXwXAEhopvmIvMsMFVLR0HLhhqGtDcHfgR7pAScL9zPk4f5me9AcwbiYNpZbXZO0wQl9BX0A==
X-Gm-Message-State: AOJu0YzLfRC07RWxPCyeC2bRG2vdMB4Lq3tTeNu426cL4k3PEiEzJvfw
	r5oVog1AsaQEJ6IGMXiThwI+OjcYtaT1RNO1l3qfgCixyFX9A0vWuxSTzvVEFXTh8elc64uqqpi
	pQGnzoHIM1V+ImtyOreIYqJbIrQ==
X-Google-Smtp-Source: AGHT+IHj9T9ZxSSjSJWnklZdCep5i77b8MXKdD7YCbGnK8tHFKVNotvbvwUZ2BkWqiY/N+w8gM9JaHjktQblhXimjRM=
X-Received: by 2002:a05:651c:b06:b0:2d2:b5cb:cc3f with SMTP id
 b6-20020a05651c0b0600b002d2b5cbcc3fmr2465655ljr.2.1709753641108; Wed, 06 Mar
 2024 11:34:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240303104853.31511-1-brgl@bgdev.pl> <CAMuHMdXWdKZjjZc39iXfa6Nohtn+Xm9YvcF+YoRpNzCgeWD8tA@mail.gmail.com>
 <CAL_JsqJjo1SBcf=ZLi=iunaHiX6Mt5H6wkoPcecnZmiAcAyihw@mail.gmail.com> <CAMRc=McBf8Fbacnxozr+=-7AFQ0EOXbaG+zUhkNEb9g1mihmMw@mail.gmail.com>
In-Reply-To: <CAMRc=McBf8Fbacnxozr+=-7AFQ0EOXbaG+zUhkNEb9g1mihmMw@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 6 Mar 2024 13:33:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJaJciL5UT5f9y_omVj6OHCSoM6rHhVTVGfVTPtcqed4Q@mail.gmail.com>
Message-ID: <CAL_JsqJaJciL5UT5f9y_omVj6OHCSoM6rHhVTVGfVTPtcqed4Q@mail.gmail.com>
Subject: Re: [PATCH] of: make for_each_property_of_node() available to to !OF
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 12:46=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Tue, 5 Mar 2024 18:56:04 +0100, Rob Herring <robh+dt@kernel.org> said:
> >
> > Long term, I want to make struct device_node opaque. So if we really
> > want to fix this, I think we'd want to convert this to use an iterator
> > function. Though I guess any user would be mucking with struct
> > property too, so the whole loop would need to be reworked. So in
> > conclusion, don't use for_each_property_of_node(). :) Shrug.
> >
>
> I basically just need to get the list of all properties of a node. Even j=
ust
> names. I'm working on a testing driver that needs to request all GPIOs as=
signed
> to it over DT so it must find all `foo-gpios` properties.
>
> How about:
>
> int of_node_for_each_property(struct device_node *dn, int
> (*func)(struct property *, void *), void *data)
>
> as the iterator?

Why would we make the caller provide the iterator? We just need a
function call like the other iterators rather than directly
dereferencing the pointers: of_next_property_iter(node, last_prop)

> You didn't say if you want to make struct property opaque as
> well but even then it can be used with provided interfaces.

Yes, I'd like to make struct property opaque as well. That's probably
the first step.

Rob


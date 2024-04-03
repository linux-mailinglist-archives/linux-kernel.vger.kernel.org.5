Return-Path: <linux-kernel+bounces-129985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B028972E0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA8728A01D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89A7149017;
	Wed,  3 Apr 2024 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvwnX9H0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F7A3EA73;
	Wed,  3 Apr 2024 14:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155281; cv=none; b=SGMf+UCSMD7sPYydrjeSkdNIwIAb69Knx/T9PzwmX4vuv2/doV0FccvfPK70q+yp4ibxM6AjBzqHa1TCIZA1mVitQb0cwF49c3Y8C0j5UNxgARuE8OmxvRs0q62Hj4ILbRrWRFqmpc38rc9zglVbuWUEvjvoEaG36CpBgpc6B3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155281; c=relaxed/simple;
	bh=AApG/seUAig56ASAD5cr6mRzB8zJFOi+bmt9vVhtVIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=seEJHHu8NPJhow+YLljk6/5bh6ja64qn+xA3mR9SlV7fHK0nf6zDVUxmSDHxhdFckO7p/kE9G68gyfXl2H3xw66rLZaVD9yDROOuFRgd7XLqFiZK7xHbxknxFDTz4RBDQr6Gwb4Dq3gaelGHxypz+kV1Dh8klPtjVje8s7bJK1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvwnX9H0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5CAC433C7;
	Wed,  3 Apr 2024 14:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712155280;
	bh=AApG/seUAig56ASAD5cr6mRzB8zJFOi+bmt9vVhtVIE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TvwnX9H0sgdbGFDd1FqAggEK95+GxXalvNFt7a3Fe+wGEbhHAnDr3SPR1WAyrRfiN
	 7pytP/QOG32/1EuxsGyJa3+nWwPUvtZZwYCJ49EGlxtvNlIKcr19wwx/qsoYC8HfaO
	 ta3Jp0aDt4rLBqT6QeE/1SvbROIKKif6hb+WDx868tNqfv3xXwP74i9KuQMiKUl8ZO
	 z0maGbXTN+lBQK553MWLJ9tjDZuAkVlU6nsmt8C2YLyHSUBrygXA80FqxKiU3jErLa
	 jEPRlqR01F78OzOhMMkVKNcu51CZk0FFLim+8W/LFGFFTGP94AoDR5fdGERHGO7egu
	 mN7Z15/3k0i1g==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-22a95603b47so651220fac.1;
        Wed, 03 Apr 2024 07:41:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwvB6ha7KpJo0EIjhdEPP3M/RKPKXYDB7It78mgyvn+Jr8F+WRLjlmJv3kWesEJW3q1CXVQDMTQrlZ1yFrNyIY2aMPCLxZN8IF623ZbFanV7BJof/EQTjMgYbBmggt4XH54GaEun8=
X-Gm-Message-State: AOJu0YxXz9L9xHrf8CuaJTH5Ca2ybTVuK9mI4WIQbndUd/MCMJo5bYKu
	R+vbTKmuqgrbVdBkx26pRnXC55lPNHN/i1IvQkBsdldR3AU6xf602wr7O5Q/SnXODLu0e4m5V39
	TS/FhFAq4x3imxskQ/qV4AqMZOo4=
X-Google-Smtp-Source: AGHT+IFQ+TNpZK3+oWrupPv+nYAI4X/tLzaL9nPkmet3hZtkPp7zhSwfBZw+MFc+sQSTMkQaqZ3OTqDkXVGJcC6KlOo=
X-Received: by 2002:a05:6870:797:b0:22e:77b6:4f9d with SMTP id
 en23-20020a056870079700b0022e77b64f9dmr4407572oab.3.1712155279953; Wed, 03
 Apr 2024 07:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403-gpa-no-cooling-devs-v2-0-79bdd8439449@trvn.ru>
 <20240403-gpa-no-cooling-devs-v2-1-79bdd8439449@trvn.ru> <d048f863-05d1-4aeb-8904-4c09ecbe55d9@arm.com>
In-Reply-To: <d048f863-05d1-4aeb-8904-4c09ecbe55d9@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Apr 2024 16:41:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gU+a60EvKKnGsgS32YoaQE8RffwPSrbbV2APSFKgn+UA@mail.gmail.com>
Message-ID: <CAJZ5v0gU+a60EvKKnGsgS32YoaQE8RffwPSrbbV2APSFKgn+UA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] thermal: gov_power_allocator: Allow binding
 without cooling devices
To: Lukasz Luba <lukasz.luba@arm.com>, Nikita Travkin <nikitos.tr@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 2:44=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
>
>
> On 4/3/24 12:31, Nikita Travkin via B4 Relay wrote:
> > From: Nikita Travkin <nikita@trvn.ru>
> >
> > IPA was recently refactored to split out memory allocation into a
> > separate funciton. That funciton was made to return -EINVAL if there is
> > zero power_actors and thus no memory to allocate. This causes IPA to
> > fail probing when the thermal zone has no attached cooling devices.
> >
> > Since cooling devices can attach after the thermal zone is created and
> > the governer is attached to it, failing probe due to the lack of coolin=
g
> > devices is incorrect.
> >
> > Change the allocate_actors_buffer() to return success when there is no
> > cooling devices present.
> >
> > Fixes: 912e97c67cc3 ("thermal: gov_power_allocator: Move memory allocat=
ion out of throttle()")
> > Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> > ---
> >   drivers/thermal/gov_power_allocator.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/go=
v_power_allocator.c
> > index 1b17dc4c219c..ec637071ef1f 100644
> > --- a/drivers/thermal/gov_power_allocator.c
> > +++ b/drivers/thermal/gov_power_allocator.c
> > @@ -606,7 +606,7 @@ static int allocate_actors_buffer(struct power_allo=
cator_params *params,
> >
> >       /* There might be no cooling devices yet. */
> >       if (!num_actors) {
> > -             ret =3D -EINVAL;
> > +             ret =3D 0;
> >               goto clean_state;
> >       }
> >
> >
>
> LGTM
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Applied as 6.9-rc material along with the [2/3], thanks!


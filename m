Return-Path: <linux-kernel+bounces-164629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CC88B805A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11CA62834DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A487194C96;
	Tue, 30 Apr 2024 19:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYB2dw47"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2917710B;
	Tue, 30 Apr 2024 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714504532; cv=none; b=FwfHBF6mYr1uMuW8tPczF31aWpC3er9bnsHFTffQAyKD/+QLJ1PvXvdDAnGXP8oHesWeeEsHpQU/O1LWNAv27QH7MEdIqbMQBCFvpJP3HaaFufTl0D2g8QlVuy4XRzpTjKweTUQoLPVpyO3osTkHEdizZh8hUCBj2akMCoHDBBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714504532; c=relaxed/simple;
	bh=dGjQSoO+B2DcvT6mQ7tQvhywqRXSXU8yl8DwROOYZzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAYyP4MPrhqkW2ARULxjPR4MmgrsUcdHUAAk/JUmMGcK7yDQZqzTKq1wugR5+WjkloTcS5tJxDNxOOWg23HIPhdyJgzaGrt77iBzdR81Vs5WbUqK53PPMp2qEvvT6rU7EubmtTHMK/BWpvdY0Z1uGpcuB8flyZvWhAuu3qeRqfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYB2dw47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB88C4AF18;
	Tue, 30 Apr 2024 19:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714504532;
	bh=dGjQSoO+B2DcvT6mQ7tQvhywqRXSXU8yl8DwROOYZzg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LYB2dw47Z6z+DNdsCZe9Q4ol5Y5hfys6cbvJiseLCcgrKpwHgBISM+knyEeRV4u6F
	 q79XTTHbNO3L+7e9OEBwkwFwxy5GGqnSTcuSOlusBJp2DGSpUBwYGuDDCbKUZRCGit
	 srQSgk8sQfMzC4lWL6HEVDQstW/Ee9Gdo3KCu3BXX01EovcZwgF56UJdO8UYA3gxhk
	 sYxA1OT5P41oz0MbmOZpk3x5YGmnm8JftS6d/fARrgyyyOS/5jMOWF6PyMfOUIcdVc
	 MLN6ABhTY77F9L/fwWz0ZNarjwj3mUk5amldrpTo/Q1Rvl6xOp6QwjmIqMdUrQkm+t
	 lPYyzTcfB3jqQ==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ea0a6856d7so907253a34.1;
        Tue, 30 Apr 2024 12:15:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWH0o/zx/w3RvtrrpxL8jDv7ZDJ3EuvspNjeQp743QLdPoPuV78ieDikeO0o6TYnNbcUQ62ec7S/1FgIQNQGpx4MBgwqwt4rw7W0eb6dzumhYQOAf8Estu90iaDb057cSqfN6N11mQ=
X-Gm-Message-State: AOJu0Yy+st7r83i1BX3OBeN2WITFYhGvu6tSAMxMKBEoj9KVQmKUfPZU
	kLDyjcvGxHK2SZc+diFErMLpg4oDCWGPD15/uRVSKy86TkHzZ6X5TWEAB95BYQM3rT3/Npfnh4m
	P/lm9BAYZlSsK86QYiw0RNW/AT4E=
X-Google-Smtp-Source: AGHT+IGh9GDZ+//6eqn81t1W0cNbEdLGmIisMif9bPP40q3g3EaXI1QEchdNBinCN465g5NcNMoNqU4oMgcap8Ahc0U=
X-Received: by 2002:a05:6820:1007:b0:5aa:14ff:4128 with SMTP id
 v7-20020a056820100700b005aa14ff4128mr374073oor.1.1714504531133; Tue, 30 Apr
 2024 12:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5790995.DvuYhMxLoT@kreacher> <bb351bd3-931f-4acc-831e-2866a535bd9a@arm.com>
In-Reply-To: <bb351bd3-931f-4acc-831e-2866a535bd9a@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Apr 2024 21:15:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j5j4N0hF+S91Cp-vFP-Hr7wW+oNuf_TaesZonkpQkd4Q@mail.gmail.com>
Message-ID: <CAJZ5v0j5j4N0hF+S91Cp-vFP-Hr7wW+oNuf_TaesZonkpQkd4Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] thermal: core: Fix thermal zone initialization and
 move passive polling management to the core
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 8:32=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
>
>
> On 4/30/24 16:44, Rafael J. Wysocki wrote:
> > Hi Everyone,
> >
> > This a v2 of the patch at
> >
> > https://lore.kernel.org/linux-pm/5938055.MhkbZ0Pkbq@kreacher/
> >
> > with one fix patch added and a couple of changes more in the main patch=
.
> >
> > Patch [1/2] fixes the thermal zone initialization in the cases when get=
ting the
> > first zone temperature from the sensor is delayed and patch [2/2] is an=
 update
> > of the patch above.
> >
> > Thanks!
> >
> >
> >
>
> I have also tested the IPA and Step-wise - they work.
>
> Tested-by: Lukasz Luba <lukasz.luba@arm.com>

Thank you!


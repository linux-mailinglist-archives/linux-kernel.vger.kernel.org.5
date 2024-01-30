Return-Path: <linux-kernel+bounces-45306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8401842E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E01287D97
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDC571B5C;
	Tue, 30 Jan 2024 20:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlMvxfOE"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B0471B48;
	Tue, 30 Jan 2024 20:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706648372; cv=none; b=gYpfUUlPmxTkR4G+wWOXpQNYWHlOR5N8usPmySxwcdcurkp0ncVszb8WLSZ11GWB0c/Hy8DnzTdU722Bw6FKeVC9WR+OFiTcv9mhr5CN2t/PSHPZz9abjwZoNRVyF6RVNLouNVLTYKq5Nu4qU+7w03taKihd+cnxvNT3qna0lXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706648372; c=relaxed/simple;
	bh=hKNIC3ubOL8awV14Yi8/zq+d4Qi6blzxIbGvY3Cd85U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqzEP2TH8NsuZvDHvc4WkL/KfbyTerktbCTdvLN/I6WMtTZWvjQzkr9yr8S7qcKw/Bo82KaOPJJsQHrKUSP+1ELI84wpKHM4P0UVoWFKRK++h+BgPsdkiIr8xvs0uQgNDryZYMeudTtZR1OoLCGLgv8TnH8P2tkhrtaiJhbX17o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlMvxfOE; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d03fde0bd9so39056051fa.0;
        Tue, 30 Jan 2024 12:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706648369; x=1707253169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKNIC3ubOL8awV14Yi8/zq+d4Qi6blzxIbGvY3Cd85U=;
        b=XlMvxfOEBYZIj+NUMrAY0TZE46tI4N0Q2/OKR4H1G/R3t0PgGa/5NBa2RZ93N/7ren
         0eLibyf16XvkHB2ZVdGzfVi5w9fJye8HKY65UrLMrZLeGu8d5VK98jFlDw4EqQgpgFkG
         jKNiPJHOkAwHBq0djSMDj/kzj3VJx+dEepW9yTHnGeZwZ61FcrHDRLOuL9w5xZBl6gvt
         8IMCx1Pba9MnD/JBoBCvSZEjqRpZPrhlaNRDksUjXTLjBRaEjaPweyQcVD6w6uFkTCWY
         Pfrxs90mrVNEu9c3586rIgS/Dz3cAJOIGQ5yj7Y43f+8x/vMGqB3KP0EQpK2xKMgpVN9
         xFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706648369; x=1707253169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKNIC3ubOL8awV14Yi8/zq+d4Qi6blzxIbGvY3Cd85U=;
        b=Y7zMivW5j8acvfuPyyQkdY7fUOWR+RwiC8JpuOIH48KZIeNckfU5FwgxH+lu8fISTJ
         pXcAvwsODxVHNJ8YTtJKKtR38s6SBHyfQLovTCsOxUUaGfdhB3MPvaOlMpta3GtlG6y8
         0fzjTyypn26wCtMvv05CdNJm7mSJs4nK33KDLfxBLK50Acb28cUXZp0PML7RNSSDCdu8
         K9Mengs8MJPsqK+utDSvOqSrHo/fsWDNhew1NH3XPtSrthk2z+T5+Vgp1AbUd3yhs6ey
         EssORyZWxa6lr6v4Wjg2VpQGAFRoD6bWTZnLcTVK26sJq32XTVOkpKiycJLbqA3O8kyz
         DgRQ==
X-Gm-Message-State: AOJu0YzEITKvANQyMrVCa2OqVP1VzUd8CAs0/zj1fq3c8STzuPk540Yo
	6xP/JUp7+PA3Kz465EwzoJQfsAjmvvwYE//9qyDyrMIX6+CCOeMTc4YB+hSJ6nlYilSumDgrXnt
	og/fl2EeM28DADnp2IIYr0P9WLRg=
X-Google-Smtp-Source: AGHT+IHnCZxPwY8EE1gl5dA94a/VcMqHZxdwN3MKKOsXVfbb/PXf0EQY0HKq5VesrGEzb4Ge/LB4AqMXlQlSAjC3mkI=
X-Received: by 2002:a2e:b550:0:b0:2d0:5435:7b11 with SMTP id
 a16-20020a2eb550000000b002d054357b11mr2815357ljn.52.1706648368382; Tue, 30
 Jan 2024 12:59:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115144538.12018-1-max@enpas.org> <20240115144538.12018-3-max@enpas.org>
 <CAEc3jaD9qXp=F6Xfg8bdeC1Hv5pHiKA16SBd=-ac74ibE1ELyw@mail.gmail.com> <cb8290a0-1937-4937-ace5-e2a22a1f6e41@enpas.org>
In-Reply-To: <cb8290a0-1937-4937-ace5-e2a22a1f6e41@enpas.org>
From: Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Tue, 30 Jan 2024 12:59:16 -0800
Message-ID: <CAEc3jaDp-GRoZs9Pp0XxCeARfPx0xFq5SdNkignGeCu0P2+Fdw@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] HID: playstation: DS4: Don't fail on MAC address request
To: Max Staudt <max@enpas.org>
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2024 at 12:51=E2=80=AFAM Max Staudt <max@enpas.org> wrote:
>
> On 1/25/24 09:39, Roderick Colenbrander wrote:
> > On Mon, Jan 15, 2024 at 6:58=E2=80=AFAM Max Staudt <max@enpas.org> wrot=
e:
> >>
> >> Some third-party controllers can't report their MAC address.
> >>
> > For what type of devices is this not working? This one example of this
> > request which is very foundational for a controller working on even
> > the game console. Are this perhaps USB-only devices? If the case maybe
> > some kind of error is only needed for USB connections.
>
> IIRC I've only seen this quirk with the oddball VID/PID 7545:0104 that my=
 patch 7/7 adds. It is indeed a USB-only controller. I have not tried this =
device (or any, really) with an actual console, my focus is just on Linux. =
Admittedly, I'd also like to know what happens on a real PS4 :)
>
> My intention was to keep the error message and the solution as universal =
as possible, in case a controller comes along that has both this quirk *and=
* Bluetooth. It's a bit of an ugly workaround though - if you (or anyone el=
se) have an idea for a nicer solution, I'd be really glad.
>
>
> Max
>

I remember on the console side that we support a number of controllers
including our official model and some licensed controllers. I recall
them taking some different codepaths and HID reports differently. It
has been a while, so I don't recall the details. If I remember it
could be that all of the licensed ones were USB-only (of course there
are some Bluetooth capable clones).

For this reason I think not all DS4-compatible devices have a MAC
address or handle this request. (We made some fixes in hid-playstation
relative to hid-sony, where hid-sony used another less known HID
report for the MAC address. Now we use the more commonly known one and
that helped other clone devices).

I'm not sure about the best way to handle this. I have kind of been
leaning towards doing a vid/pid like check for this case even though I
really hate it. It could be within dualshock4_get_mac_address as we do
some other special handling there too (although having the caller of
dualshock4_get_mac_address do it is an option too, but I think within
get_mac_address is slightly nicer for now).

Thanks,
Roderick


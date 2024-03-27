Return-Path: <linux-kernel+bounces-121550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6DA88EB86
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02665B3941E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46451131BD1;
	Wed, 27 Mar 2024 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmPtwFae"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84518136E10;
	Wed, 27 Mar 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554094; cv=none; b=fS6N9IRIoqDS9dOjLkx9+fF+PKdulO1ci89rzMYR2ZC7dYALLl7w+pQ1NXDMUlt/3B3+rDMwjhITzFqA3zranS0glyOu/UArS4T/X8byUHfDyiGkILw4uISe0VsxQLZ3lnGIN5GvS1ZjiTWCBCzhq2q45Rm3BYObkilmiM/WxS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554094; c=relaxed/simple;
	bh=LMPJEN0Q1kL6wjZR1BkihkNe0y6p24fFsF8WeVGlrIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T56lUKAgHOHFTw+qBWHGxiIc0/o9js8QRXzbIBpGgFmM7mnSNJYXP/aZkiaekS3Sf0k7gpAkZnb92Vma0aYlce7fdA4B3wd4NKCBWED2xjMEBzoCYAjHOVJv1YfZ9RsrYPJWJ4oKsRPBGEpe3nfMU7dJmSkiZ9dO1bfExz9UzlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmPtwFae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2438AC43390;
	Wed, 27 Mar 2024 15:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711554094;
	bh=LMPJEN0Q1kL6wjZR1BkihkNe0y6p24fFsF8WeVGlrIk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EmPtwFaeaWH723l5SGWUHrp/psYuY5+YTcOTDloFhpTsyQ3UtGJyfL36Xw6gGbhz7
	 M1kCRRJy8laFSHW6sS9/Q5TRwuboL/5+Gmxw5uwoYULVdI+yXtzSsjImqgBaeYXIJa
	 s1cLagNzzoclapAHQzsSyGi5XIf23OFKZUUeXwcj8yrIhR30GKZY0agHuULqYFV00d
	 SqPCXfQFBqbDApyntBX/5WHubleBY/Wpu5GpbL4dBeTdUFf8bHqJ3LNl53GZi+S50V
	 sm1FcIqhpZdklN9X3ACfU49pcp2mtnF5pHV8UYTTvP8OpwwWRqG0WOAYd/hKM/HFmJ
	 ZqHX4TNNPGvnA==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a536642635so604395eaf.0;
        Wed, 27 Mar 2024 08:41:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVCRYFUzrMfK6p2H+7Tc3b/OqAZEcn3PUD3Nu6hOeQvxuHVL9rNXPvc/RV8PjvIGimeNgZkX9DG8+tyZH+jAX2i5LufgpcR+sv7f55w9/GUU11GYvTwtE24QTNYwAJCoDDfNUObcuzpQ==
X-Gm-Message-State: AOJu0Ywi3gU82viPnhkOct2vGSncqZKqfgCcDsVcWepcKgim5c0bzD4f
	+L61uzU/FH+GQkxcFlROV2XItOFlr3PE/2f+InqKbGYI5oZIsABcLF0jJCyp4DPOcaeu7QBG373
	EyFSGQgKOcZBGO8cHttDtxHnPQMM=
X-Google-Smtp-Source: AGHT+IHW1/QvDGhLasTLBEzBrf8gKgjH+n1OTLtNGlnZvaDmzs9gTyGz4vmxb2pMwa+y9j4jGilJTLuqCrUIXlp6v2Q=
X-Received: by 2002:a05:6870:6715:b0:229:e46d:763a with SMTP id
 gb21-20020a056870671500b00229e46d763amr53100oab.0.1711554093467; Wed, 27 Mar
 2024 08:41:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240309201310.7548-1-W_Armin@gmx.de> <CAJZ5v0hKwThcAO4jMOzi7ySqSv_jHvs_+paBB212qVsaf7LZng@mail.gmail.com>
 <2e8100b0-d87c-413e-bcb1-b91c3ce41633@gmx.de>
In-Reply-To: <2e8100b0-d87c-413e-bcb1-b91c3ce41633@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Mar 2024 16:41:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0idAkoiuXgfGYX-a9ZoNeWxw8CjOnTKCU-00BgcpCwisQ@mail.gmail.com>
Message-ID: <CAJZ5v0idAkoiuXgfGYX-a9ZoNeWxw8CjOnTKCU-00BgcpCwisQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] ACPI: bus: _OSC fixes
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 11:29=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 12.03.24 um 21:10 schrieb Rafael J. Wysocki:
>
> > On Sat, Mar 9, 2024 at 9:13=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrot=
e:
> >> This patch series fixes the handling of various ACPI features bits
> >> when evaluating _OSC.
> >>
> >> The first three patches fix the reporting of various features supporte=
d
> >> by the kernel, while the fourth patch corrects the feature bit used to
> >> indicate support for the "Generic Initiator Affinity" in SRAT.
> >>
> >> The last patch fixes the reporting of IRQ ResourceSource support. Unli=
ke
> >> the other feature bits, the ACPI specification states that this featur=
e
> >> bit might be used by the ACPI firmware to indicate whether or not it
> >> supports the usage of IRQ ResourceSource:
> >>
> >>          "If not set, the OS may choose to ignore the ResourceSource
> >>           parameter in the extended interrupt descriptor."
> >>
> >> Since the code responsible for parsing IRQ ResourceSource already chec=
ks
> >> if ResourceSource is present, i assumed that we can omit taking this
> >> into account.
> >>
> >> All patches where tested on a Asus Prime B650-Plus and a Dell Inspiron
> >> 3505.
> >>
> >> Armin Wolf (5):
> >>    ACPI: bus: Indicate support for _TFP thru _OSC
> >>    ACPI: bus: Indicate support for more than 16 p-states thru _OSC
> >>    ACPI: bus: Indicate support for the Generic Event Device thru _OSC
> >>    ACPI: Fix Generic Initiator Affinity _OSC bit
> >>    ACPI: bus: Indicate support for IRQ ResourceSource thru _OSC
> >>
> >>   drivers/acpi/bus.c   | 5 +++++
> >>   include/linux/acpi.h | 6 +++++-
> >>   2 files changed, 10 insertions(+), 1 deletion(-)
> >>
> >> --
> > All of that looks reasonable to me, but do you know about systems in
> > the field where any of these patches actually fix functionality?
> >
> > If not, I'd prefer to queue them up for 6.10 as they are likely to
> > change behavior, at least in corner cases.
> >
> > Thanks!
>
> Hi,
>
> i know no system which even queries those feature bits, so i am fine with
> this landing in 6.10.

Now applied as 6.10 material, thanks!


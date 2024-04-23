Return-Path: <linux-kernel+bounces-155816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 199F08AF786
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57841F2353F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6D4142649;
	Tue, 23 Apr 2024 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKvUxRob"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704431422D6;
	Tue, 23 Apr 2024 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713901656; cv=none; b=NVGJLdZPw8oPmRYCSckbVHl9AEhU2kv1RYLhJpfYVvO2wq0s5IzaoZrUiwRLpcwHi83RNyppYkUmNSRZVPfm2wvjLXvaxHorTNh0/yfz6UG3Eg3aNiQuEx1xQEGaRUcVJC17LiCOkO6GE6G0LCP0NsAjdRTrMTgtiZpE5hLajGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713901656; c=relaxed/simple;
	bh=saI9GzUhqVjVXCi51emHPDBunUoY5yCib9xM+0Ws/Go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjxbF0T2KLFV/5qNYbiBNNMZBhsCyqj8/AJCes0BAPyj1ry4vOG5C/JeUuH1imcCCh5tItNCN0nRvLNX7ZldIgcEDsFbZ+ISbAOV5EjpNpkokDiiu1QHt9LdXiL/v0nbzLJzA5O6huF0gNdst/pvusGiRaWI1j/cueViSKIRLmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKvUxRob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BFEC2BD11;
	Tue, 23 Apr 2024 19:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713901655;
	bh=saI9GzUhqVjVXCi51emHPDBunUoY5yCib9xM+0Ws/Go=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GKvUxRobjib3fyshdePsisUnPPo/WugTUgZ2ln6/CkCUc4zw5GqA3HFXD5UwvCqRL
	 ZlbIkpC+AsC12Wcemn6uXRu2523Z9F9PKO/nQcbYvQl+t7YRFJs8jEBdZH7MwuKUu/
	 dEz/OEX8JRJcUnl4faTZCUDjMvrWf6iqzKKkmyPzEb87g9lXnjN835ViMPgug2JTRS
	 veFnXEOzaviaTfOoCXbWl1Lu6GrMVzpKAL7e8jR7kpiFMm5McNcgvoGh3L5n5aJUD7
	 QPGMuG0Dm/ssOfCO1OyuNfkq8RjN8K6+lMLnBa55JtwTGALzHajbH7+SHbZgzuRTgO
	 uKx2uWHcXRrlg==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c6febc1506so48134b6e.1;
        Tue, 23 Apr 2024 12:47:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV7SFMQq/O6ah8WQzsZ0xdrwQUU1xMQNwdGQfFzA9tnh7nWeLBHm/L4TCxVX/Rmbf9psvdSC8RgEHWvrhD1W93PWE9XDU1uHKG1VqTiHyPFgPeySOijslrAqhh8zyzOXdbYEkAPgQt9ccM5bXkslNeFQ+h2r6AdFa8pGL+ifwQuwqO4
X-Gm-Message-State: AOJu0YzR9xzP4zEHk7NjKvp/gd3qnwHFRfFepiYY1A0v+XsIpA3X/D9v
	IgN/d8xKWzccoR1CdCOWs7Aozxl26K4K+M1iSg9N1DdXNIO3mfG3Nht6iA//75ywG4sLeuyurqv
	Yw2VnWs6rHkseB3O6DVD3cLeMRps=
X-Google-Smtp-Source: AGHT+IH7Wrlyd+Y82QbcwueitBcPqZ/mni6EKwZzULoRWRQMzvASWatWaV1+kyEtzGJybzyYn5twRn5LfiT/HL7COaU=
X-Received: by 2002:a05:6820:2c8c:b0:5a7:db56:915c with SMTP id
 dx12-20020a0568202c8c00b005a7db56915cmr315843oob.1.1713901655182; Tue, 23 Apr
 2024 12:47:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12427214.O9o76ZdvQC@kreacher> <08742373-ca86-47e5-ab6c-e2e3189eb9fe@amd.com>
In-Reply-To: <08742373-ca86-47e5-ab6c-e2e3189eb9fe@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Apr 2024 21:47:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iKuemDmHCfL67cFyv6gA7Q8cfiNj+nXWqJt2_b_vrhkA@mail.gmail.com>
Message-ID: <CAJZ5v0iKuemDmHCfL67cFyv6gA7Q8cfiNj+nXWqJt2_b_vrhkA@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: PM: s2idle: Evaluate all Low-Power S0 Idle _DSM functions
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Mark Pearson <mpearson@lenovo.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 9:40=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 4/23/2024 14:19, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 073237281a50 ("ACPI: PM: s2idle: Enable Low-Power S0 Idle MSFT
> > UUID for non-AMD systems") attempted to avoid evaluating the same Low-
> > Power S0 Idle _DSM functions for different UUIDs, but that turns out to
> > be a mistake, because some systems in the field are adversely affected
> > by it.
> >
> > Address this by allowing  all Low-Power S0 Idle _DSM functions to be
> > evaluated, but still print the message regarding duplication of Low-
> > Power S0 Idle _DSM function sets for different UUIDs.
> >
> > Fixes: 073237281a50 ("ACPI: PM: s2idle: Enable Low-Power S0 Idle MSFT U=
UID for non-AMD systems")
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218750
> > Reported-and-tested-by: Mark Pearson <mpearson@lenovo.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Ah glad to hear that my idea worked.

We've arrived at the same solution independently, I've only looked at
the BZ when the patch was ready to send.

> FWIW we saw the same type of issue
> on some AMD systems when we first introduced the MSFT UUID.
>
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>

But sure.

> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks!

> > ---
> >   drivers/acpi/x86/s2idle.c |    8 +++-----
> >   1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/x86/s2idle.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/acpi/x86/s2idle.c
> > +++ linux-pm/drivers/acpi/x86/s2idle.c
> > @@ -492,16 +492,14 @@ static int lps0_device_attach(struct acp
> >                       unsigned int func_mask;
> >
> >                       /*
> > -                      * Avoid evaluating the same _DSM function for tw=
o
> > -                      * different UUIDs and prioritize the MSFT one.
> > +                      * Log a message if the _DSM function sets for tw=
o
> > +                      * different UUIDs overlap.
> >                        */
> >                       func_mask =3D lps0_dsm_func_mask & lps0_dsm_func_=
mask_microsoft;
> > -                     if (func_mask) {
> > +                     if (func_mask)
> >                               acpi_handle_info(adev->handle,
> >                                                "Duplicate LPS0 _DSM fun=
ctions (mask: 0x%x)\n",
> >                                                func_mask);
> > -                             lps0_dsm_func_mask &=3D ~func_mask;
> > -                     }
> >               }
> >       }
> >
> >
> >
> >
>


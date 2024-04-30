Return-Path: <linux-kernel+bounces-163777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BEB8B6FC0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94671C21F46
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5E812C46B;
	Tue, 30 Apr 2024 10:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuSywXzn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF0317727;
	Tue, 30 Apr 2024 10:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473364; cv=none; b=p34jYMHBL5pgXI2fgBCRa943XpE5IkAwzKjBq0XU9NYkeJ17XZuNm4xB0TkNA+MyaK0AiiLCT9+ud51D4RPWVA/aKP7nvrv7pCc/KDv/2pRBrGU/MupfMMbZ8eD5HIA+K8OpioA2x3tAY8Y9l8tHIhJaXn252xUVXvrcxkri1P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473364; c=relaxed/simple;
	bh=dxEYVJ1G2GubDWzrfRvAEde9L0bxzSpTVsMJOzG2ixA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzHoJVA82ntkET+UZizDDnQlEgQkPRJ0/17LfIm5v39ONLiADDtqoNDFByuqqojdeviMMuFkv42ZQvH2+zrZeBl2UxnoI6UNIAASPrDERQcq8GjJJw5yRjRZ/AzXGXW2y0zzxm2iWgZohk8bDyD0Ts+gebkMzN5tMo+G1wXX974=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuSywXzn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB09C4AF14;
	Tue, 30 Apr 2024 10:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714473364;
	bh=dxEYVJ1G2GubDWzrfRvAEde9L0bxzSpTVsMJOzG2ixA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UuSywXznCsDTIqFQmOEx7qSXhXLPzwTaOQYF7RQnF8vHYQlXz3urwReSWw3Be7qjD
	 bClq24aBePj/m/pvuPOEIaxLaB8R1gHMomyamHpn5S3upklUwNBhS0EIL078yl5SGG
	 I7W7vF2iSRFgFAp1rXxbbQcIIxrImfmXhSXsgJoo2Ko5PuS4HoTyHjn01dT33PxW/I
	 QwbXM88InurnQyvbWW7512c9vz6Hs+SPQrtQYYvZsq9/6axc2GtLkfltxV5qWyDzFV
	 G9AbDpg0Hb3/XSWFoOHhHiee1y3rLNtYK2dDMo+CMGQaBn8RJAvbfrEXRK7w0QyVNN
	 X3Zmi5ACHUzeg==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c70418ef53so441297b6e.1;
        Tue, 30 Apr 2024 03:36:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRrEUjMtCH8kdbTAyR2wfY2K7DLgePb4vint2dr7GQyzzkJos8dBQkOtMYWP213iNhEs8/TkzzpdXRPqhH1Nu7Rw5oy4kzZrTePis/6X4ycizPCBI/YjTlQAArvnHeEhLvM5gnGN8=
X-Gm-Message-State: AOJu0YxMwvrOq5yxZ6Zhf5cUujowA5tFK9qsGt3RFsnuVKgRW7/3EAGt
	wv3/fSI4l6B5+h1mte63XYrnzuZTGw2s3SWR0R13vLZWBhiSQxz1HTSCkwTflwKcuSRSerWrDld
	7J1P+HgWWYQ4sL7r/1uX/ZbIhFHs=
X-Google-Smtp-Source: AGHT+IFKSNEDHgxMiS9UPx1bYRCjsvOPN1pRKkeX2zU36pfxhcwNL4+l5qIW5sCiyeruv8oekZ1S562kte7GTQTQR/I=
X-Received: by 2002:a4a:a7cb:0:b0:5a4:7790:61b4 with SMTP id
 n11-20020a4aa7cb000000b005a4779061b4mr15189159oom.0.1714473363224; Tue, 30
 Apr 2024 03:36:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429113356.1708284-1-ray.huang@amd.com> <efd9226b-84b4-47e9-bbb9-68bd0194a8ef@amd.com>
In-Reply-To: <efd9226b-84b4-47e9-bbb9-68bd0194a8ef@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Apr 2024 12:35:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hUwKHbpWXfjArujB8FJ9wDc9_Cv5O1Y_DcyWAPHG-v_w@mail.gmail.com>
Message-ID: <CAJZ5v0hUwKHbpWXfjArujB8FJ9wDc9_Cv5O1Y_DcyWAPHG-v_w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: cpufreq: amd-pstate: Add co-maintainers and reviewer
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meng Li <li.meng@amd.com>, 
	Xiaojian Du <Xiaojian.Du@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	Ananth Narayan <ananth.narayan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 4:02=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 4/29/2024 06:33, Huang Rui wrote:
> > I'm happy to add Gautham and Mario as the co-maintainers, Perry as the
> > reviewer for amd-pstate driver.
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > Cc: Gautham R. Shenoy <gautham.shenoy@amd.com>
> > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > Cc: Perry Yuan <perry.yuan@amd.com>
> > Cc: Ananth Narayan <ananth.narayan@amd.com>
> > ---
>
> Thanks Ray!  We of course talked about this offline and I'm happy to
> step in.  Having coverage of two people is also good for any OOO
> situation in the future to make sure patches can be reviewed in a timely
> fashion.
>
> Acked-by: Mario Limonciello <mario.limonciello@amd.com>
>
> >
> > Hi Rafael,
> >
> > Recently, I was assigned other task of virtio-gpu support for Xen, so
> > apology not to review the patches timely. After discussing with our AMD
> > colleagues, we want to add Gautham and Mario as co-maintainers of this
> > driver from server and client side. If one of the maintainers ack the
> > amd-pstate patch, then this patch is good to be accepted from AMD
> > perspective. And also add Perry as reviewer, he is actively contributin=
g
> > the patches on this driver for a long time.
> >
> > We will try to keep the patches reviewed on time in future.

Thank you all, patch applied for 6.10.

BTW, patch series "AMD Pstate Driver Core Performance Boost" doesn't
seem to be ready and given that -rc7 is due this week, I'd rather
postpone until the 6.11 cycle.


Return-Path: <linux-kernel+bounces-17451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE25824D6C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 04:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9E31C21BA0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C134C81;
	Fri,  5 Jan 2024 03:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Txf6ELmB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7175D442C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 03:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9FB603F5A6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 03:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704425167;
	bh=GN6N8A+PcCFQ4gruSHSLuqFko2lttyDNbK76ZrmbaBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Txf6ELmBs0SA0owxfOZuAPDP6K+r4xjz4x8CSz5VcG+Y3C4PEU8lYnba9m+kKPFpC
	 duG1WITC/+SgaE2M08KgGJCPd3CHdTPDQ5QUkiVOHTiXdw5TJErDSrfo+6daHvBftl
	 qlfWZw3Qy9GzfL7BNqfR7tdSmiIC9NSWf/NwYqtiwflyFg1CgkRP60iVtjMjA8sZof
	 i8ovnSTMkNttSF1E6QRSs2lgf/cs2wmx4NVI4zdErmCb2yrt3yr9xwE1diN5jnJoGT
	 GHvUdNAQSk6kUuFjvWiHfXLXhEGZPNwkPNbDN7GPRVJHTmNQCUz6Mk6Q+1RCGoRsqt
	 rQ5OMvMQD+IQA==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-28cb109eb73so857436a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 19:26:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704425166; x=1705029966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GN6N8A+PcCFQ4gruSHSLuqFko2lttyDNbK76ZrmbaBs=;
        b=tZVZugdEjmOaFOGODd8J+EkikSgRv5FtaaNq0VrpwyYgUXZ4p9S8Vs13D61FIkbQup
         FVa9iVspxfktnGmeCcySISYKdsivb41W2b4SlyBIznJ5ehHcyQ56zNxFA5cUx/r0gJTy
         xfz/3j2MpKxcQfXofUv2cJ4evYzuTDmN6PYaGQHggZ8VFvF1A+L/8Us1fLHlulv7BnCr
         JknKX4Tj9Vt9k2S8mDzLN71VZYcaECE6qKYt6hj84u3VEU23TuJUXct/LBKrmpZI1Ma/
         wocB6VjjikCNdMeV2MVG6yVNdOfbGdGmku9ri8hJ+3lldJgdW7j3YmxNO/hI24zlWO6y
         sCBw==
X-Gm-Message-State: AOJu0YyzJYFChWv+vMeLwhX65rHyG56x7uEf64zPDOSDPQwFIdqLTMdr
	BgquGwY6CJ4Kv1vUK+e4lGXs4cKbPt2MhWype9fdQeoD5BqJPRs2bqn7D3TjLSJV5IoysJ1jGBv
	lwlL9EKWBC7xCEbQJMbm1dWF7w82zFKrQYHtjyJDeDwONvxpeXRhCGlHR6RRv70Ng
X-Received: by 2002:a17:90a:5382:b0:28c:d9e:9ebc with SMTP id y2-20020a17090a538200b0028c0d9e9ebcmr1193790pjh.18.1704425165724;
        Thu, 04 Jan 2024 19:26:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFveZCVBc3ykGU6aUZhM4R5VHmYP/Ze5TNB+dab7cXwNbuwx51STS6phndJ2RyUgLXEO+SKIkCkjUxuaPqdVkQ=
X-Received: by 2002:a17:90a:5382:b0:28c:d9e:9ebc with SMTP id
 y2-20020a17090a538200b0028c0d9e9ebcmr1193786pjh.18.1704425165397; Thu, 04 Jan
 2024 19:26:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240101181348.GA1684058@bhelgaas> <0f121140-e5dc-4c1a-b510-a9d791004a27@5challer.de>
In-Reply-To: <0f121140-e5dc-4c1a-b510-a9d791004a27@5challer.de>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri, 5 Jan 2024 11:25:53 +0800
Message-ID: <CAAd53p69oLBGYEc2A4PNBP9KVmQkH=EaNh2_zuFDbwWJNLmtXg@mail.gmail.com>
Subject: Re: [Regression] [PCI/ASPM] [ASUS PN51] Reboot on resume attempt
 (bisect done; commit found)
To: Michael Schaller <michael@5challer.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, macro@orcam.me.uk, 
	ajayagarwal@google.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	gregkh@linuxfoundation.org, hkallweit1@gmail.com, 
	michael.a.bottini@linux.intel.com, johan+linaro@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Tue, Jan 2, 2024 at 2:57=E2=80=AFAM Michael Schaller <michael@5challer.d=
e> wrote:
>
> On 01.01.24 19:13, Bjorn Helgaas wrote:
> > On Mon, Dec 25, 2023 at 07:29:02PM +0100, Michael Schaller wrote:
> >> Issue:
> >> On resume from suspend to RAM there is no output for about 12 seconds,=
 then
> >> shortly a blinking cursor is visible in the upper left corner on an
> >> otherwise black screen which is followed by a reboot.
> >>
> >> Setup:
> >> * Machine: ASUS mini PC PN51-BB757MDE1 (DMI model: MINIPC PN51-E1)
> >> * Firmware: 0508 (latest; also tested previous 0505)
> >> * OS: Ubuntu 23.10 (except kernel)
> >> * Kernel: 6.6.8 (also tested 6.7-rc7; config attached)
> >>
> >> Debugging summary:
> >> * Kernel 5.10.205 isn=E2=80=99t affected.
> >> * Bisect identified commit 08d0cc5f34265d1a1e3031f319f594bd1970976c as
> >> cause.
> >> * PCI device 0000:03:00.0 (Intel 8265 Wifi) causes resume issues as lo=
ng as
> >> ASPM is enabled (default).
> >> * The commit message indicates that a quirk could be written to mitiga=
te the
> >> issue but I don=E2=80=99t know how to write such a quirk.
> >>
> >> Confirmed workarounds:
> >> * Connect a USB flash drive (no clue why; maybe this causes a delay th=
at
> >> lets the resume succeed)
> >> * Revert commit 08d0cc5f34265d1a1e3031f319f594bd1970976c (commit seeme=
d
> >> intentional; a quirk seems to be the preferred solution)
> >> * pcie_aspm=3Doff
> >> * pcie_aspm.policy=3Dperformance
> >> * echo 0 | sudo tee /sys/bus/pci/devices/0000:03:00.0/link/l1_aspm
> >>
> >> Debugging details:
> >> * The resume trigger (power button, keyboard, mouse) doesn=E2=80=99t s=
eem to make
> >> any difference.
> >> * Double checked that the kernel is configured to *not* reboot on pani=
c.
> >> * Double checked that there still isn't any kernel output without quie=
t and
> >> splash.
> >> * The issue doesn=E2=80=99t happen if a USB flash drive is connected. =
The content of
> >> the flash drive doesn=E2=80=99t appear to matter. The USB port doesn=
=E2=80=99t appear to
> >> matter.
> >> * No information in any logs after the reboot. I suspect the resume fr=
om
> >> suspend to RAM isn=E2=80=99t getting far enough as that logs could be =
written.
> >> * Kernel 5.10.205 isn=E2=80=99t affected. Kernel 5.15.145, 6.6.8 and 6=
.7-rc7 are
> >> affected.
> >> * A kernel bisect has revealed the following commit as cause:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commi=
t/?id=3D08d0cc5f34265d1a1e3031f319f594bd1970976c
> >> * The commit was part of kernel 5.20 and has been backported to 5.15.
> >> * The commit mentions that a device-specific quirk could be added in c=
ase of
> >> new issues.
> >> * According to sysfs and lspci only device 0000:03:00.0 (Intel 8265 Wi=
fi)
> >> has ASPM enabled by default.
> >> * Disabling ASPM for device 0000:03:00.0 lets the resume from suspend =
to RAM
> >> succeed.
> >> * Enabling ASPM for all devices except 0000:03:00.0 lets the resume fr=
om
> >> suspend to RAM succeed.
> >> * This would indicate that a quirk is missing for the device 0000:03:0=
0.0
> >> (Intel 8265 Wifi) but I have no clue how to write such a quirk or how =
to get
> >> the specifics for such a quirk.
> >> * I still have no clue how a USB flash drive plays into all this. Mayb=
e some
> >> kind of a timing issue where the connected USB flash drive delays some=
thing
> >> long enough so that the resume succeeds. Maybe the code removed by com=
mit
> >> 08d0cc5f34265d1a1e3031f319f594bd1970976c caused a similar delay. =C2=
=AF\_(=E3=83=84)_/=C2=AF
> >
> > Hmmm.  08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()")
> > appeared in v6.0, released Oct 2, 2022, so it's been there a while.
> >
> > But I think the best option is to revert it until this issue is
> > resolved.  Per the commit log, 08d0cc5f3426 solved two problems:
> >
> >    1) ASPM config changes done via sysfs are lost if the device power
> >       state is changed, e.g., typically set to D3hot in .suspend() and
> >       D0 in .resume().
> >
> >    2) If L1SS is restored during system resume, that restored state
> >       would be overwritten.
> >
> > Problem 2) relates to a patch that is currently reverted (a7152be79b62
> > ("Revert "PCI/ASPM: Save L1 PM Substates Capability for
> > suspend/resume""), so I don't think reverting 08d0cc5f3426 will make
> > this problem worse.
> >
> > Reverting 08d0cc5f3426 will make 1) a problem again.  But my guess is
> > ASPM changes via sysfs are fairly unusual and the device probably
> > remains functional even though it may use more power because the ASPM
> > configuration was lost.
> >
> > So unless somebody has a counter-argument, I plan to queue a revert of
> > 08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()") for
> > v6.7.
> >
> > Bjorn
>
> If it helps I could also try if a partial revert of 08d0cc5f3426 would
> be sufficient. This might also narrow down the issue and give more
> insight where the issue originates from.
>
> Let me know what you think.

Just wondering, does `echo 0 > /sys/power/pm_asysnc` help?

Kai-Heng

>
> Michael


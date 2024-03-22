Return-Path: <linux-kernel+bounces-111473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D80886CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FF6AB24E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29B24643A;
	Fri, 22 Mar 2024 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkvEbZJm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24FC45BED;
	Fri, 22 Mar 2024 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711113785; cv=none; b=ARLlIcfO1AP6icJhYC1hImsZhdEO3ERggbZAVzUQX6YLT6QEiuIixCUpR/05beY0L7WKGY9DRolMvW50z3C3N+C4iKujDd/O31HtXtlNIcwKhfTzHXOj0osa0O2V2GWRms+uY7OdbJotjm3oAux4ljgZTloRXsUPRr0LrYhREiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711113785; c=relaxed/simple;
	bh=NuYAmabxa/yWXcfo3iLE1DlzpL+At+H+5WTtA6hN4Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUSEqF2rpNXnZECrkfa8oBwuJJpOT2bM+/GviTOgBZu/lWuv59qprtImwlNysdH4p5Pa9nh/uMX43vc7BHjTZvDw+hhNENok9XsdN0/bpBbGWptAR6ZHuDg1o2Vwk0Tvet3nJcOEjIqZOHR9CPyQ71bYT+WBjd0/lO5PUOiRSpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkvEbZJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23A2C43394;
	Fri, 22 Mar 2024 13:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711113784;
	bh=NuYAmabxa/yWXcfo3iLE1DlzpL+At+H+5WTtA6hN4Dk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BkvEbZJmtRbe8zFHBjVrFInPy52I6aGhzKaXqFHlrKAUWsMsi+D8KL9DKYbufNcv6
	 ocF1bYVIBxkJeHx1+SmNh7vBWvoF6L1Tiqym+WheRPJQVwM/DNZdiWZaV+BaHhc0ur
	 +N2+bsZ59xDKALfaahSZTsRHHUMbSU/YiZ3oZLxmRUf6eTnN5G/ACGB5oU/7Vgsh6g
	 tJXr+0v0nY6xBsROKd/zewO3wwRJAm7CBhxME39jIHwipAbUVBfsiQXDBEm5ZqZr9Q
	 ZOa2vQQtAhUkiLm1CpxFnnnsFRzoh1K6+k8xMwoD0iOtifC6WxSqpNxOyKfSkU7UJP
	 pTHiSXC1h5JJw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513edc88d3cso2193740e87.0;
        Fri, 22 Mar 2024 06:23:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVveiIzMD4dEnX+fQR+TLrCp27B/m3ZSwF3RjgOFNclM+gU/RAswLAPwx2XsLFc80xYCAgz74LmZNqbH+mPOi+WaaHYtPx0nEe23Qj3j7nBVwJLMotVuwJ0wK/RZb141NF0kyLZ1lWsHA==
X-Gm-Message-State: AOJu0YyynY9B/QOo41XOZ6SB2cWB3LnhbRn69AqiUKeMGrYow5apRFwu
	Udc4S04wpfife991xN5SZZg7gt2sF/2UJCOFkMQOlTY8GGIvR77KnVBxl1Iom4aSmsnZf2VHOF3
	2aJ/WfTaJplL0BXSrG6wSxSJaAA==
X-Google-Smtp-Source: AGHT+IHyFZczWhGC6ve0i/5WXp/HVFxoVNnBJ4Urb8ygFY8b8o6uu8DSGBiXVedOzqpoWkoV6iKw2/m0pOvxfFx/aEY=
X-Received: by 2002:a19:741a:0:b0:513:dac5:ee1a with SMTP id
 v26-20020a19741a000000b00513dac5ee1amr1552133lfe.25.1711113783071; Fri, 22
 Mar 2024 06:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319143253.22317-1-sudanl@amazon.com> <23692c07-98bd-477d-b244-bba14c50352c@linaro.org>
 <38aad6c0e698c8e804694276d1762d61f2068ce8.camel@infradead.org>
 <20240320161531.GA1810860-robh@kernel.org> <60404403932a984d1f75d111ff53b9053af03579.camel@infradead.org>
 <20240321133250.GA1600070-robh@kernel.org> <db5a1027-93b7-4630-b679-8a654905dc48@amazon.co.uk>
 <17611183-f288-47fe-a5e1-91ee16168db0@linaro.org> <ee688cca986d95148a55e32fee48ceed8567f128.camel@infradead.org>
In-Reply-To: <ee688cca986d95148a55e32fee48ceed8567f128.camel@infradead.org>
From: Rob Herring <robh@kernel.org>
Date: Fri, 22 Mar 2024 08:22:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJOn9yU_YC0+q=4DX9_=0+z8yTact0HAvOKbrUpcXHxkQ@mail.gmail.com>
Message-ID: <CAL_JsqJOn9yU_YC0+q=4DX9_=0+z8yTact0HAvOKbrUpcXHxkQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] virt: vmgenid: Add devicetree bindings support
To: David Woodhouse <dwmw2@infradead.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "Landge, Sudan" <sudanl@amazon.co.uk>, 
	Sudan Landge <sudanl@amazon.com>, tytso@mit.edu, Jason@zx2c4.com, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	sathyanarayanan.kuppuswamy@linux.intel.com, thomas.lendacky@amd.com, 
	dan.j.williams@intel.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, graf@amazon.de, bchalios@amazon.es, 
	xmarcalx@amazon.co.uk, ardb@kernel.org, benh <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 3:21=E2=80=AFAM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> On Fri, 2024-03-22 at 06:40 +0100, Krzysztof Kozlowski wrote:
> > On 21/03/2024 18:39, Landge, Sudan wrote:
> > >
> > >
> > > On 21/03/2024 13:32, Rob Herring wrote:
> > > > CAUTION: This email originated from outside of the organization. Do=
 not click links or open attachments unless you can confirm the sender and =
know the content is safe.
> > > >
> > > >
> > > >
> > > > On Wed, Mar 20, 2024 at 04:55:45PM +0000, David Woodhouse wrote:
> > > > > On Wed, 2024-03-20 at 11:15 -0500, Rob Herring wrote:
> > > > > > On Wed, Mar 20, 2024 at 01:50:43PM +0000, David Woodhouse wrote=
:
> > > > > > > On Tue, 2024-03-19 at 16:24 +0100, Krzysztof Kozlowski wrote:
> > > > > > > > On 19/03/2024 15:32, Sudan Landge wrote:
> > > > > > > > > This small series of patches aims to add devicetree bindi=
ngs support for
> > > > > > > > > the Virtual Machine Generation ID (vmgenid) driver.
> > > > > > > > >
> > > > > > > > > Virtual Machine Generation ID driver was introduced in co=
mmit af6b54e2b5ba
> > > > > > > > > ("virt: vmgenid: notify RNG of VM fork and supply generat=
ion ID") as an
> > > > > > > > > ACPI only device.
> > > > > > > > > We would like to extend vmgenid to support devicetree bin=
dings because:
> > > > > > > > > 1. A device should not be defined as an ACPI or DT only d=
evice.
> > > > > >
> > > > > > This (and the binding patch) tells me nothing about what "Virtu=
al
> > > > > > Machine Generation ID driver" is and isn't really justification=
 for
> > > > > > "why".
> > > > >
> > > > > It's a reference to a memory area which the OS can use to tell wh=
ether
> > > > > it's been snapshotted and restored (or 'forked'). A future submis=
sion
> > > > > should have a reference to something like
> > > > > https://www.qemu.org/docs/master/specs/vmgenid.html or the Micros=
oft
> > > > > doc which is linked from there.
> > > >
> > > > That doc mentions fw_cfg for which we already have a binding. Why c=
an't
> > > > it be used/extended here?
> > > QEMU has support for vmgenid but even they do not pass vmgenid direct=
ly
> > > to the guest kernel using fw_cfg. QEMU passes the vmgenid/UUID via
> > > fw_cfg to an intermediate UEFI firmware. This UEFI firmware, running =
as
> > > a guest in QEMU, reads the UUID from fw_cfg and creates ACPI tables f=
or
> > > it. The UEFI firmware then passes the UUID information to the guest
> > > kernel via ACPI.
> > > This approach requires yet another intermediary which is UEFI firmwar=
e
> > > and adds more complexity than ACPI for minimalist hypervisors that do
> > > not have an intermediate bootloader today.
> >
> > What stops you from passing fw_cfg not to UEFI FW? BTW, no actual VM
> > name was used in your posting, but now suddenly it is a talk about QEMU=
.
>
> That would be possible. But not ideal.

Why not ideal?

To rephrase the question, why is it fine for UEFI to read the vmgenid
from fw_cfg, but the kernel can't use the same mechanism? The response
that you'd have to use UEFI to use fw_cfg makes no sense to me. The
only reason I can think of is just being lazy and wanting to have
minimal changes to some existing driver. It looks to me like you could
implement this entirely in userspace already with zero kernel or
binding changes. From a quick look, we already have a fw_cfg driver
exposing UUID (that's the same thing as vmgenid AIUI) to userspace,
and you can feed that back into the random pool.

I am concerned that we already have a mechanism and you want to add a
second way. When do we ever think that's a good idea? What happens on
the next piece of fw_cfg data? We add yet another binding?

> Just as exposing it via PCI
> would be possible, but not ideal. Or forcing ACPI onto the guests in
> question, and various other less efficient options.
>
> If what we're really looking at here is a hostile takeover of the DT
> bindings repository, with a blanket "No, DT is dead. Go use something
> else, preferably ACPI", than all those other options are possible. We
> *never* have to add a new binding to DT ever again. Let's just set the
> existing bindings in stone and move on.

I'll refrain from all my snarky replies to this that aren't helpful to
the discussion.

Rob


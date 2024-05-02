Return-Path: <linux-kernel+bounces-165921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A594D8B9375
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0B57B22AC7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F1F18054;
	Thu,  2 May 2024 02:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ON/eFIWL"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA22E182DB
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 02:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714617894; cv=none; b=h9VcgShw84toi5ZatuyDsaCLSKqPZ16C+LVl0PJ1AYIF7RfFjZhij5G/P4Koe0J/166/IJyxjTzs7NLeFHQEjxiqlrG1ILo65hbAGDFXz0BXNykyJ+exS6/NIM3u+pmxHSUGWVyZ/n7NMvj476h8uFwIVK9de8BfuRM/shyVf7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714617894; c=relaxed/simple;
	bh=dIIj8NHXj4tGdX5U9z/gY2AkWy/vmpwC5sAKtTAzxTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PtviYmW1BaOoB269LbnDM/1UDWhXVGXxsnsAuGRarWhJgvNB/NmXkszu+aJp+LoXpQ31zbuDvPtAXuI9Cohl2SZA10o9zupbcjSW9+Q6YYCWAwMQLu9greBXyWgMEs1+HlfdHMOmhK5SxbCTcC9Vfs3NOE/l1UhHChOs+mFQZRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ON/eFIWL; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-618a2b12dbbso345165a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 19:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714617892; x=1715222692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euZIhWXjQEYe0bWn32p2A4SfGVqdxpff17R6zQ8P7PI=;
        b=ON/eFIWL7KhvOtKXrUomtsAjYQKJp9CyqMr6yL6zqbO/JDjFEfA3MAtcHk5XQ5qT4i
         Uu5zaxDxijEb28xzhWON/237GLTZYdKTQW/gxbNuHZy+g99x5YUSqui1gzactO+QuDd3
         QG+1wLA1fPD68ZKm0pK9xiMwrBsSvfj59K3SbXRbDQyCRD4GuT5CBNBTnfoDU3zSVtaq
         roEYt6bSFTf0BxS7boAGCns8xbn5I7qKpN6rb7IclE2zKgMcu9GS4JrQ1wVVu0WZFX6z
         BbF6qdaPonAnwEqg0TVKfLri2YZSWa6vpvRQZYwaI40gpZgGpBygL/quCo9EEStLhgFM
         qmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714617892; x=1715222692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euZIhWXjQEYe0bWn32p2A4SfGVqdxpff17R6zQ8P7PI=;
        b=Z9ySsLNeByoQlbPn9E/zEFLyECcTkzXvW0+bVxopRDuxGu7E8M2XuIIBzFznxD94lp
         fCd6Fc79HvilInhiUK8GeHrirfp6SagQPjMX5UbuLrST3FaA/fvRthvRPMl5IEINHN4p
         SBQA6VP0iKi981ZKPrgEia6hT1oJgeQ0Z1lfusrFT/oXPrUGQEDjJDA7LIz80rRfeRjf
         oL34aCobG+/tgbT/VK8pXm7cPr68P/fTaZ/qI2NZ4ZCEfR0xb4ug+FL7MJmmf5OStq70
         45vMGbwD0q0tZRymtSNt3jBBapYRfcaNrszRsXZy23o21Gh1ScMsBchdIOqhIsbKM3wJ
         9nAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVATIrVm+/iwBopgt3W0mWMizXSk7nRS37y/hfLgNubntqtjAxbzL0U78PlM1NSi59sDjCuA11Kjx0T7ZiGcLdv05/ioy9vTmcfS60h
X-Gm-Message-State: AOJu0YyKFIPEmmbHP0FScMNwvlDmOKlqv6uObACoBfa50bVj5QqZdHH7
	0iittuth2JPUNV2FTszgctnj7FfJF8gLPrOAisKsrU69DgFcMTH1UdmCkKOUP7skUXmJ3ogGZKG
	oWIGQ/X0fuunEUnJx54uP1fgmAcKEEwJp/Wc0bw==
X-Google-Smtp-Source: AGHT+IGwSe/xIz3BgUNwPr5sTo42FMHmya+TRXIF+ZH8Uh1IRa75Xl3IrkakU97XG8tf79d3YtP+8s8443YiwDnf8WE=
X-Received: by 2002:a17:90a:e2c6:b0:2b2:8b6f:c00d with SMTP id
 fr6-20020a17090ae2c600b002b28b6fc00dmr2161008pjb.10.1714617892115; Wed, 01
 May 2024 19:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714494653.git.tjeznach@rivosinc.com> <aa5592da66fe72acd4d4730f544882042e7b5293.1714494653.git.tjeznach@rivosinc.com>
 <6b4a4dc0-ac9e-43cd-bd84-447df2370dde@linux.intel.com> <20240501142037.GC1723318@ziepe.ca>
 <3972c041-d5dd-4b02-9a0d-4541f7adc6d0@linux.intel.com>
In-Reply-To: <3972c041-d5dd-4b02-9a0d-4541f7adc6d0@linux.intel.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Wed, 1 May 2024 19:44:41 -0700
Message-ID: <CAH2o1u4yNM+zq3c92WV_GCP-y0ev+f6eVa2C28-yiNQrB2HY9Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] iommu/riscv: Add RISC-V IOMMU platform device driver
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 7:25=E2=80=AFPM Baolu Lu <baolu.lu@linux.intel.com> =
wrote:
>
> On 5/1/24 10:20 PM, Jason Gunthorpe wrote:
> > On Wed, May 01, 2024 at 06:26:20PM +0800, Baolu Lu wrote:
> >> On 2024/5/1 4:01, Tomasz Jeznach wrote:
> >>> +static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
> >>> +{
> >>> +   u64 ddtp;
> >>> +
> >>> +   /*
> >>> +    * Make sure the IOMMU is switched off or in pass-through mode du=
ring regular
> >>> +    * boot flow and disable translation when we boot into a kexec ke=
rnel and the
> >>> +    * previous kernel left them enabled.
> >>> +    */
> >>> +   ddtp =3D riscv_iommu_readq(iommu, RISCV_IOMMU_REG_DDTP);
> >>> +   if (ddtp & RISCV_IOMMU_DDTP_BUSY)
> >>> +           return -EBUSY;
> >>> +
> >>> +   if (FIELD_GET(RISCV_IOMMU_DDTP_MODE, ddtp) > RISCV_IOMMU_DDTP_MOD=
E_BARE) {
> >>> +           if (!is_kdump_kernel())
> >> Is kdump supported for RISC-V architectures?  If so, the documentation
> >> in Documentation/admin-guide/kdump/kdump.rst might need an update.
> >>
> >> There is a possibility of ongoing DMAs during the boot process of the
> >> kdump capture kernel because there's a small chance of legacy DMA setu=
ps
> >> targeting any memory location. Kdump typically allows these ongoing DM=
A
> >> transfers to complete, assuming they were intended for valid memory
> >> regions.
> >>
> >> The IOMMU subsystem implements a default domain deferred attachment
> >> mechanism for this. In the kdump capture kernel, the whole device
> >> context tables are copied from the original kernel and will be
> >> overridden once the device driver calls the kernel DMA interface for t=
he
> >> first time. This assumes that all old DMA transfers are completed afte=
r
> >> the driver's takeover.
> >>
> >> Will you consider this for RISC-V architecture as well?
> > It seems we decided not to do that mess in ARM..
> >
> > New architectures doing kdump should put the iommu in a full blocking
> > state before handing over the next kernel, and this implies that
> > devices drivers need to cleanly suspend their DMAs before going into
> > the next kernel.
>
> Glad to hear that. :-)
>
> With the above consideration, the driver should consider it an error
> case where the iommu is not in the blocking state, and it's in the kdump
> kernel, right?
>
> If so, probably the iommu driver should always return failure when the
> iommu is not in the blocking state. However, the RISC-V's logic is:
>
>   - if this is a kdump kernel, just disable iommu;
>   - otherwise, failure case.
>
> This logic seems problematic.
>

Initial implementation recognize this as an error and failed to
initialize IOMMU was in non-default state (disabled or pass-through).
Ideally we should have proper shutdown sequence for kdump case, and
quiesce IOMMU before kdump kernel runs. However, this path is
problematic enough that I'd prefer not to add any other complications
to this patch set. Definitely setting IOMMU in a full blocking state
before handling over to kdump kernel. Will get back to that at some
point.

Dropping all IOMMU config in kdump path is IMHO the compromise we can
accept,  leaving kdump kernel an option to reconfigure IOMMU in later
stages of the IOMMU initialization.

> Best regards,
> baolu

Best,
- Tomasz


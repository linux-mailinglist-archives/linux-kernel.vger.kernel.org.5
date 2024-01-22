Return-Path: <linux-kernel+bounces-32465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F24E835BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2260F2881C9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36811B268;
	Mon, 22 Jan 2024 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GklNBeoR"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A4618C38
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909786; cv=none; b=HNJ8KS1NU2i2KNvE7cWa2mQU3mLeb0YuNKHZcSzQx2HU9VyBqF/EdWOjo61Os0HnX1EId92yVXjeGuZ5eVTrsiqD/sP+fEtknscel4T2xujhsn1G+fImrx/dn8yxaNaGSXIe6Dis2PLv9yQ4sh14DjrKRdnJlmfyokEEUL/khKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909786; c=relaxed/simple;
	bh=FYvDsKE1JvqgxvfwMgaEH8211SP4UgNPlNssQq6riTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTmvFCdM74bkVnPyt+4l7GwQLSYCGHeP/1xUqeLXZUqH2eIbsRuBEFvnfEVIeHplDGq3F7fc+/SeHDWdpNg2fDyIU+v14zdpOviyG48dEwIr9ejuZzvDyZRe3E4QuG6vBTJ5tPLaom3UXeyI91evjssWevjH6J2ao+TI3giHaw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GklNBeoR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e880121efso32083665e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 23:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705909782; x=1706514582; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rpCyjxE9iUjcyOl2ouKZdE0yNctxzfib4K99jcAYjY4=;
        b=GklNBeoRpI4v8bP+9p/yi07FDOx1O2K1CYf6lArGy5IYuyEUtyD5WzLugkbiFDO6NG
         BLUmyEscO/39FOj/WhgUtWpA4bwFwoTF7dlfV6RPqpZWYTCtFuNVyIMVrfvfb033gAff
         lF4xuBhfQLxlaUM2pG1DgssKIQuXCPKSzn+LEnUUSiKwswkK5aop8djvLSyq8HdWaTKx
         WvgOI0fMqBeJ+ARLkQ08a8yS6ZG+uEmZxaYc2gVfp/tyv22l1nUV6QULOOYoM0oot0RI
         KlscohEJmn/g9MT12YvV5uvFvo8cUDErtea0Gi1V7D5xmYMXBz2qvZOQ0MJ2R6aYBPDz
         zAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705909782; x=1706514582;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpCyjxE9iUjcyOl2ouKZdE0yNctxzfib4K99jcAYjY4=;
        b=CDJ2ENH9jIgMwTtcvhfi0GL8jr1NpcNGuPrENtql07fyQjuVkqAx94hXVZcSamqLTz
         JUtieZgfCHMDF/kmqFSclw3NS56bn6QOyvWxRS2L87AFpplQ3NdmF38cMrqLp3ew1p2F
         ehSKRYZh707gDjrrs3cmLdblfFYIDGyr3uTyiZ+ot/6tgiqiPWGg/6bagqCLEtx604Q+
         47Dis4mU0SadWJxbDhJqFWHWQnJNQCO/uKQL7eRzftt+79W1uuPUDsyYhKow9WsG5oIr
         Ll95+vfcdalc4TLNoM95Zlahsae63wOqltbmWNU4MSrYNGbhuJt85QHGjXNhBd/bup7a
         rOEA==
X-Gm-Message-State: AOJu0YzTaQyFOgGeLTMpp4HB5IKBL0HUciCZAVyeAZ8sRVqMerBfoBo/
	+tG7vM/nYMuCzAoKj0DJF+ZXxAGTjrXmJ3W3CFEmx+Bvmr3QQ1m42PTRz7EHbYc=
X-Google-Smtp-Source: AGHT+IEsJ+OwM3QJ8jqVyNmJzXSJ3P3dNBViNQm08mdfH1LGWrpTLM9ddZcpUQ5FMF0Gs7XzgnLwjA==
X-Received: by 2002:a05:600c:1d95:b0:40e:addd:8567 with SMTP id p21-20020a05600c1d9500b0040eaddd8567mr454394wms.124.1705909782500;
        Sun, 21 Jan 2024 23:49:42 -0800 (PST)
Received: from vermeer (lfbn-mon-1-1176-165.w90-113.abo.wanadoo.fr. [90.113.119.165])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c1c0500b0040e9f7dadc6sm10412167wms.25.2024.01.21.23.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 23:49:42 -0800 (PST)
Date: Mon, 22 Jan 2024 08:49:10 +0100
From: Samuel Ortiz <sameo@rivosinc.com>
To: "Yao, Jiewen" <jiewen.yao@intel.com>
Cc: Qinkun Bao <qinkun@google.com>, "Lu, Ken" <ken.lu@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 3/4] tsm: Allow for mapping RTMRs to TCG TPM PCRs
Message-ID: <Za4d9iS/lpEOEzpl@vermeer>
References: <20240114223532.290550-1-sameo@rivosinc.com>
 <20240114223532.290550-4-sameo@rivosinc.com>
 <1bbf8d3e-aa94-48c7-a1e4-76f9eefc4af7@linux.intel.com>
 <65a72c305291f_3b8e29484@dwillia2-xfh.jf.intel.com.notmuch>
 <5539c533-37b2-4b12-a5c5-056881cf8e3c@linux.intel.com>
 <Za1G9I+tYuIL9ser@vermeer>
 <CF3D8DE1-AD47-4A77-B8BD-8A12A6F7E9DB@google.com>
 <MW4PR11MB5872F46A2089C8C2D8EF7A008C752@MW4PR11MB5872.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MW4PR11MB5872F46A2089C8C2D8EF7A008C752@MW4PR11MB5872.namprd11.prod.outlook.com>

Hi Jiewen,

On Mon, Jan 22, 2024 at 02:23:02AM +0000, Yao, Jiewen wrote:
> Comment below:
> 
> > -----Original Message-----
> > From: Qinkun Bao <qinkun@google.com>
> > Sent: Monday, January 22, 2024 10:13 AM
> > To: Samuel Ortiz <sameo@rivosinc.com>; Yao, Jiewen <jiewen.yao@intel.com>;
> > Lu, Ken <ken.lu@intel.com>
> > Cc: Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com>; Williams, Dan J
> > <dan.j.williams@intel.com>; linux-coco@lists.linux.dev; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [RFC PATCH v1 3/4] tsm: Allow for mapping RTMRs to TCG TPM PCRs
> > 
> > 
> > 
> > > On Jan 21, 2024, at 8:31 AM, Samuel Ortiz <sameo@rivosinc.com> wrote:
> > >
> > > On Tue, Jan 16, 2024 at 07:35:30PM -0800, Kuppuswamy Sathyanarayanan
> > wrote:
> > >>
> > >> On 1/16/24 5:24 PM, Dan Williams wrote:
> > >>> Kuppuswamy Sathyanarayanan wrote:
> > >>>> On 1/14/24 2:35 PM, Samuel Ortiz wrote:
> > >>>>> Many user space and internal kernel subsystems (e.g. the Linux IMA)
> > >>>>> expect a Root of Trust for Storage (RTS) that allows for extending
> > >>>>> and reading measurement registers that are compatible with the TCG TPM
> > >>>>> PCRs layout, e.g. a TPM. In order to allow those components to
> > >>>>> alternatively use a platform TSM as their RTS, a TVM could map the
> > >>>>> available RTMRs to one or more TCG TPM PCRs. Once configured, those
> > PCR
> > >>>>> to RTMR mappings give the kernel TSM layer all the necessary information
> > >>>>> to be a RTS for e.g. the Linux IMA or any other components that expects
> > >>>>> a TCG compliant TPM PCRs layout.
> > >>>>>
> > >>>>> TPM PCR mappings are configured through configfs:
> > >>>>>
> > >>>>> // Create and configure 2 RTMRs
> > >>>>> mkdir /sys/kernel/config/tsm/rtmrs/rtmr0
> > >>>>> mkdir /sys/kernel/config/tsm/rtmrs/rtmr1
> > >>>>> echo 0 > /sys/kernel/config/tsm/rtmrs/rtmr0/index
> > >>>>> echo 1 > /sys/kernel/config/tsm/rtmrs/rtmr1/index
> > >>>>>
> > >>>>> // Map RTMR 0 to PCRs 4, 5, 6, 7 and 8
> > >>>>> echo 4-8 > /sys/kernel/config/tsm/rtmrs/rtmr0/tcg_map
> > >>>>>
> > >>>>> // Map RTMR 1 to PCRs 16, 17 and 18
> > >>>>> echo 16-18 > /sys/kernel/config/tsm/rtmrs/rtmr1/tcg_map
> > >>>> Any information on how this mapping will be used by TPM or IMA ?
> > >>>>
> > >>>> RTMR to PCR mapping is fixed by design, right? If yes, why allow
> > >>>> user to configure it. We can let vendor drivers to configure it, right?
> > >>> I assume the "vendor driver", that publishes the RTMR to the tsm-core,
> > >>> has no idea whether they will be used for PCR emulation, or not. The TPM
> > >>> proxy layer sitting on top of this would know the mapping of which RTMRs
> > >>> are recording a transcript of which PCR extend events.
> > >>
> > >> My thinking is, since this mapping is ARCH-specific information
> > >> and fixed by design, it makes more sense to hide this detail in the
> > >> vendor driver than letting userspace configure it. If we allow users to
> > >> configure it, there is a chance for incorrect mapping.
> > >
> > > I think I agree with the fact that letting users configure that mapping
> > > may be error prone. But I'm not sure this is an architecture specific
> > > mapping, but rather a platform specific one. I'd expect the guest firmware
> > > to provide it through e.g. the MapPcrToMrIndex EFI CC protocol.
> > >
> > > So I agree I should remove the user interface for setting that mapping,
> > > and pass it from the provider capabilities instead. It is then up to the
> > > provider to choose how it'd build that information (hard coded, from
> > > EFI, etc).
> > 
> > The UEFI specification has defined the mapping relationship between the
> > TDX RTMR and TPM PCRs (See
> > https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#intel-trust-
> > domain-extension). The current RTMR implementation in the boot loader
> > is “hooked” in the implementation for the TPM.
> > 
> > When the bootloader needs to extend the PCR value, it calls
> > `map_pcr_to_mr_index`  to retrieve the corresponding RTMR index and
> > then extends the RTMR. Considering this behavior, I don’t think we should
> > allow users to configure the mappings between the PCR and RTMR. (See
> > https://github.com/rhboot/shim/pull/485/files).
> > 
> > Add Jiewen (owner of the RTMR changes in the firmware) and Ken (
> > owner of the RTMR changes in the boot loader) for the visibility.
> 
> I think the mapping should be static and determined by the hardware architecture.
> 
> Allowing user to configure the mapping just adds complexity and confusing. For example, the user must understand clearly on what is Intel-TDX/AMD-SEV/ARM-CCA/RISCV-CoVE, how many registers they have, what is the best way to map it.
> 
> It also adds complexity to the verifier. For example, the verifier must understand how a user configure the mapping, then get the expected measurement register value.
> 
> I believe that hiding detail is a better way to avoid those complexity, and make it easy to use.

I agree.

> Do we have some real use cases that a user MUST configure the mapping?

Not that I know of, and I will remove that userspace interface in v2 of this patchset.

Cheers,
Samuel.


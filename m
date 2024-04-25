Return-Path: <linux-kernel+bounces-158612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7388B22F5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58291C2148B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3790A149C70;
	Thu, 25 Apr 2024 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GzpBQzle"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FD584FC9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714052400; cv=none; b=lV5J1UA3Cmym847H7lBA/GUnw25IIOs5KAJUTdNjjBc786RpZs4Z/ExZDikIvlqCnDVbbFcwthuCdP6M01PRqB8/zL4R0PoeZxJKTMq+BPz6CWvYA1YEA/shM5dY+oRXN8zrVMRzgNZ30qCcfWgqO2OLEWGYl7hS49xhbFgIXIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714052400; c=relaxed/simple;
	bh=bXoyo74idfaeP23Csyi+9QlLYhTnXr+jINGhM2Cr4qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8XTEw62PdZSFCJMz8r+X+PV2ONPMvwB4tGhNxvfaO2hjX4EjOSrvG1Zzo0JUPLlH5lk1f94u15OvBqOX5zN+ERgC3MueLW+Hkx2H6GHJKmssdPB4/W1bIvrTXdgYbSPdHJZKl+pYO+NhNq12JPKgJSrUPqRjyKsEI/8cJxARAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GzpBQzle; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ddc2ea2091so9309991fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 06:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714052397; x=1714657197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OBB6iHa1DFexaylbLPu7OCjWw+zETYmnkR2w2e4JHJI=;
        b=GzpBQzleH+e/gWKZd3KvFvsdwIJapoClMYjLvcPjVmZI5Phbpb3DhKj3//kbw4Jr2M
         aX/kPGgp9BVrRAxCZXnrP+Z/IIFBuWYltdw9RCv5GROR/fKaSC7MOXjOmJK4oyTCrSSQ
         V++QCBYo1XzddAWuSxE2KEzfN/mdA7pKe++sE895fMjOnZKNz8wNGXfAQ2S9tRKK3Bkr
         LP93+/NMI+lGpm6CsNKOWQ3atieZiwdZQ6eoEeThLCeuhKQ8//qPtFMDjiMxU5sW7jTj
         eUyVScJ3sCIGlds7hvr40mzxQqrnSAZaTbj1iE4XFEVQy2eT+SdZpPYnoK9w+ZUZEoQ1
         7ulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714052397; x=1714657197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBB6iHa1DFexaylbLPu7OCjWw+zETYmnkR2w2e4JHJI=;
        b=BEznierLzXjwJkYMC+//B7Rteb/RjA8kGFRxfgpgVktt6qn+S+o36l3gyDnTbX6RwW
         VcD14FGgC51jjmssYOENLrVSokLzBoKkVI4d4n9VoZjj882rs2+TrY9bjibWvFt7jr5x
         tm2FitGEk6wRUM237JeJfZYhZTlp7TbK38hyTRuNr7H+7LRgOR7/AJ3YDCI8coqsVHkq
         d+bT1N8fnh1vPVRXi0aCJ4oChwg5eluQ0F6GGrr3ydcMBHae3dB4/2hWSdGuG1FKjDR6
         zl+sX7tsRm5ry6YVRw/ah5OUoZbT+v+CxIMxTiqVqhFSJwiE9mbf8nDvu25CoVJoO4bU
         GFiw==
X-Forwarded-Encrypted: i=1; AJvYcCW5vmd8eZ8qlidoBzyJlU4uuy7dh9Ak6BHN8Wb+rCElchdVgO/utyiONQTM2cUTkBeoTNDBOGFwX//nZZdlQtYLRi1knsjlpPoPzuPM
X-Gm-Message-State: AOJu0YzRoNOBLjSrPfsQp30yjI0OahEBC+1iUy2Nzp3WUY5HR1Y1PLnP
	qOok/KAI3ldMK6BkLVgislpb2xXcLJwOLlakwdZ9vW3Ou//V0680HkuYEfV26ZW+iuh5oj+WgMM
	ztAc=
X-Google-Smtp-Source: AGHT+IEe16Rze/3sVtNCctfPqiBPhBCY4b2DEVF9qDW99i+vUiMrvHIdNsJ9h5ZdCJcGKAYmyZ0+SA==
X-Received: by 2002:a2e:9184:0:b0:2d9:eb66:6d39 with SMTP id f4-20020a2e9184000000b002d9eb666d39mr3740353ljg.19.1714052397101;
        Thu, 25 Apr 2024 06:39:57 -0700 (PDT)
Received: from nuoska (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id u5-20020a2e9f05000000b002dd7b339bdesm1289452ljk.1.2024.04.25.06.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 06:39:56 -0700 (PDT)
Date: Thu, 25 Apr 2024 16:39:54 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH] efi: expose TPM event log to userspace via sysfs
Message-ID: <ZipdKjsnoq_cSCGv@nuoska>
References: <6e751959b9056884c1b9d3ba23e303d1737d8763.camel@HansenPartnership.com>
 <ZiZhSfgeAdrbnaVL@nuoska>
 <CAC_iWjKA-xRH=3FK+=woXsB8AW4+_mVhJhUQnL8iFKxGzOwKiA@mail.gmail.com>
 <e3038141413e25350f0e53496f7a7af1bf8419cf.camel@HansenPartnership.com>
 <CAC_iWj+zbs2tq_nMASDX6pgCAP23+PpctJFiu9=mgOVDz8Trzw@mail.gmail.com>
 <e1da76ca4c7fe9319aaac5f8ff6eb46db433ec60.camel@HansenPartnership.com>
 <CAC_iWjLH=SDoTw_Pgr2hOKHkjEp_dKqwpUe9j6a=_WNW9UcxKw@mail.gmail.com>
 <CAMj1kXGHT2wULF2zwNM_QxD29dRW_dtFX2sOvsLahPiRVB61qg@mail.gmail.com>
 <ZiopXE6-AucAB9NM@gardel-login>
 <f6259f0a28b80db78d28475105ae7f37655a58ee.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6259f0a28b80db78d28475105ae7f37655a58ee.camel@HansenPartnership.com>

Hi,

On Thu, Apr 25, 2024 at 09:24:48AM -0400, James Bottomley wrote:
> On Thu, 2024-04-25 at 11:58 +0200, Lennart Poettering wrote:
> [...]
> > General purpose distros typically don't build all TPM drivers into
> > the kernel, but ship some in the initrd instead. Then, udev is
> > responsible for iterating all buses/devices and auto-loading the
> > necessary drivers. Each loaded bus driver might make more devices
> > available for which more drivers then need to be loaded, and so on.
> > Some of the busses are "slow" in the sense that we don't really know
> > a precise time when we know that all devices have now shown up, there
> > might always be slow devices that haven't popped up yet. Iterating
> > through the entire tree of devices in sysfs is often quite slow in
> > itself too, it's one of the most time consuming parts of the boot in
> > fact. This all is done asynchronously hence: we
> > enumerate/trigger/kmod all devices as quickly as we can, but we
> > continue doing other stuff at the same time.
> 
> So let me make a suggestion that you can use now.  Since all you
> currently care about is the EFI/ACPI device, there is always a single
> sysfs entry that corresponds to that (so you shouldn't need the log
> entry as an indicator):
> 
> /sys/bus/acpi/devices/MSFT0101\:00
> 
> That link (or a kobject uevent if you prefer to look for that) will
> always appear regardless of whether a driver has attached or not.  When
> the driver actually attaches, a driver/ directory will appear where the
> link points.
> 
> The device link is added when the acpi scan is initiated as a
> subsys_initcall, which is before all the filesystem initcalls, so it
> should run before the initrd is mounted.
> 
> Is this enough for now and we can think about a more generic indicator
> that all drivers have been probed later?

This covers EFI ACPI devices but not devices without ACPI.

Some boards have the TPM device data in devicetree.

Some boards have a firmware TPM which is not listed in devicetree
but is detected at runtime once optee drivers, tee-supplicant, etc have
loaded.

Based on the comments here, I could propose a v2 with TPMFinalLog based
sysfs file which is empty but existence of the file shows to systemd that
EFI firmware used a TPM device and that can queue in the normal ACPI,
devicetree or other mechanisms of detecting the real TPM device, loading drivers
and possibly needed userspace components like tee-supplicant for optee and fTPM.

I don't know how non-EFI firmware could be supported, unless they show the ACPI TPM
entry.

Cheers,

-Mikko


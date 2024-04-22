Return-Path: <linux-kernel+bounces-153413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5532C8ACDD5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C115284FF7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D778214F119;
	Mon, 22 Apr 2024 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fZyyWBcM"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72305145342
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791311; cv=none; b=d/fMDIuCslXoTR6tNpIKiVjUhNknL9a90cJwAELaBtRet62t8avXqKDhlqBQb7CLQZOF8pug2jODYbY+TcR2aPS845VvghUuSLvpeJ/QEQv7YunLx35gC0+lrqtvBpPOLjpSGYspS21Ri1GJH6gvzwlA8gIa6nHOIsfsbi37C6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791311; c=relaxed/simple;
	bh=MLDK5mdhMB4sJMi+5RN7HGMWKzojgaQcPwURTut7yj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKwQUjrCuUE8y+3M+wM5s9X19wHek4MNyir/9V8bFYoQAuOCxx/5gvq7uC/ztunQoQcovcZoKPW9OFPtvde3IIR7jtf7ROBCdRnV+KZIZTspVsxVj4eVI+ZYQnE7Ls7hJPZjg7XT4CyZ6Iza67m7kat1rfoXU2qjmC9mhJziexs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fZyyWBcM; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d8863d8a6eso62289551fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713791308; x=1714396108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yRKip543FrF4UEvqEx/9DwHkl53BY/O/l6I8FCkMAYs=;
        b=fZyyWBcM/3LFSD11dr9eAxHYh9t1JSI+Ydw3Pf+1poIVdDiqA1goLUFB7vl4Dymq9N
         8tuvcqJliiuP438qttUh2L+ZllsYBtOZ2bci0g2bNlgh9UcVw5XyDkgvvUYM1wY8CqDu
         TCmAzgXy/rITthcL72j/MichC5Tkynn+dKU97D2+iGBqrmG1eHAVXLJ/vpPVpuvxu2Xp
         P5EAEN9Bu2noU9azipl3Tm65VMjMzY0ksN3vVosXjfd4rZ+C7T67+fe3pr+x21r37L68
         JteZGXfk9q7YDyIFlRO8OzHWjx5+A5WvNtaK8Q5WgZ7Ccr9wZUHTAlnZjml+r1DvT34a
         ozLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713791308; x=1714396108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRKip543FrF4UEvqEx/9DwHkl53BY/O/l6I8FCkMAYs=;
        b=KjMHdWfCmIWbfmyrtFQ3B6eXmeWUo+r4xokzLQ0W8InMPBV3SDKYQEsuinj30IV1fC
         Y/94eoAoEfheTBRItM4wtLNswAtZRAb1RhcgxqXro8GjAoQJl/D9Uh24CXDihS0/z3Lt
         vwf+BNJeDw9eSphyYUzS+v9DAPtnhZNidG/vQCCFFhBfz8fKxWH0OPFOn8zzPAOIN7hm
         abmR6MaBiT6Oih76QTZ3wwvagNtHPwE/rYUfq9w8YsnaRWRy5jo6Q7uWl+ZPs46AYKVs
         CFhggEfieVCY6tXm97bWDG03HbmMEGVwExaEgev7AwR12pSAtU2gZVQf4+E0SUClyKNX
         FX9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqq9PVl7D4ZH3mqxmLCXQ1O6ZRRT3T8vKDU4nAQ9JjV227j92FQo+E/j3Fq2y4TpkvgE9lgbkRvI6HbAp9Y0uAvDPa04wnuS0N8bXk
X-Gm-Message-State: AOJu0YwYax+2sjPbt4nTQE7NBMEdDSV4dXqkofla41j2svBZDiOZvS1F
	qZwufdVHo/wjPuxRIiJcBJTybtoT96aUXuQF1zJTXzK/KMJFTQ1Tq82rsiBq0BE=
X-Google-Smtp-Source: AGHT+IGfbIh1aymCn1a8cxPCKU3Gukp5u1kMs48P4u5R02PY6GLaX92V2LUKrpAw0ihFOW0HcDKgHQ==
X-Received: by 2002:a05:651c:201d:b0:2d8:49e2:d279 with SMTP id s29-20020a05651c201d00b002d849e2d279mr6548049ljo.26.1713791307624;
        Mon, 22 Apr 2024 06:08:27 -0700 (PDT)
Received: from nuoska (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id v18-20020a2e9f52000000b002d9ed7ce8c9sm1441770ljk.74.2024.04.22.06.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 06:08:27 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:08:25 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH] efi: expose TPM event log to userspace via sysfs
Message-ID: <ZiZhSfgeAdrbnaVL@nuoska>
References: <20240422112711.362779-1-mikko.rapeli@linaro.org>
 <6e751959b9056884c1b9d3ba23e303d1737d8763.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e751959b9056884c1b9d3ba23e303d1737d8763.camel@HansenPartnership.com>

Hi,

On Mon, Apr 22, 2024 at 08:42:41AM -0400, James Bottomley wrote:
> On Mon, 2024-04-22 at 14:27 +0300, Mikko Rapeli wrote:
> > Userspace needs to know if TPM kernel drivers need to be loaded
> > and related services started early in the boot if TPM device
> > is used and available.
> 
> This says what but not why.  We already have module autoloading that
> works correctly for TPM devices, so why is this needed?
> 
> We do have a chicken and egg problem with IMA in that the TPM driver
> needs to be present *before* any filesystem, including the one the TPM
> modules would be on, is mounted so executions can be measured into IMA
> (meaning that if you use IMA the TPM drivers must be built in) but this
> sounds to be something different. However, because of the IMA problem,
> most distributions don't end up compiling TPM drivers as modules
> anyway.
> 
> Is what you want simply that tpm modules be loaded earlier?

Yes, ealier is the problem. In my specific testing case the machine is
qemu arm64 with swtpm with EFI firmware for secure boot and TPM support.

Firmware uses TPM and does measurements and thus TPM event log is available
on this machine and a bunch of other arm64 boards. Visible in early boot
dmesg as TPMEventLog lines like:

[    0.000000] efi: ESRT=0xf0ea5040 TPMFinalLog=0xf0ea9040 RTPROP=0xf0ea7040 SMBIOS=0xf0ea3000 TPMEventLog=0xeb3b3040 INITRD=0xeb3b2040 RNG=0xe5c0f040 MEMRESERVE=0xe5c0e040

Different boards use different TPM HW and drivers so compiling all these in is
possible but a bit ugly. systemd recently gained support for a specific
tpm2.target which makes TPM support modular and also works with kernel modules for some
TPM use cases but not rootfs encryption.

In my test case we have a kernel+initramfs uki binary which is loaded by EFI firmware
as a secure boot binary. TPM support on various boards is visible in devicetree but
not as ACPI table entries. systemd currently detect TPM2 support either via ACPI table
/sys/firmware/acpi/tables/TPM2 or TPM entry or via firmware measurement via
/sys/kernel/security/tpm0/binary_bios_measurements . If either one of these exist,
then systemd evaluates ConditionSecurity=measured-uki in services correctly and
rolls out TPM services, cryptsetup etc. But the ACPI table entry for TPM isn't mandatory
and many boards don't support it. Then latter requies TPM kernel driver to be loaded
before systemd evaluates ConditionSecurity=measured-uki the first time, or basically
the driver needs to be compiled into the kernel.

In my case the uki initramfs is also based on systemd and does things like
creating a TPM encrypted rootfs and this should work on a number of boards
automatically, and none of the boards have ACPI table entries for TPM2, but
all of them with real, swtpm or fTPM based TPM devices provide the TPM Event Log
to the kernel. Thus systemd could use this as an indicator for TPM support in addition
to the server grade HW standard ACPI table entry. And once this is in place
TPM drivers and module loading work and initramfs can create a TPM backed rootfs
on first boot. The catch is to install needed kernel modules to the initramfs but
after that, all things work nicely.

Hope this clarifies this change a bit more.

Cheers,

-Mikko


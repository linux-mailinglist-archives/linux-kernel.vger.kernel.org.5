Return-Path: <linux-kernel+bounces-153459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6148ACE56
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EAFF1C2143B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015871514C9;
	Mon, 22 Apr 2024 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdTm2LVB"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6722114F9EA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792803; cv=none; b=cm5kb1I7FeYTp9KNIKd6LM0AnVq2dcJPl5JlcBDvUd/45LITR7E7+jyO2a12uSg+5f44CYYSwo1ybW12Whyp4LgwMn2xjTm7xnVFNArCaani6owT2b2wlP+VDLpCxxvvJsrgBxsz/Qv+2AO3Jz42o2DLcJOHnFDgyfJlksEBqBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792803; c=relaxed/simple;
	bh=cUik/XF4WicAOpO3Eaf38j1OJaTwK4HQ23A3jNVArdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFlOsIxOumGb1zbZWn+gfBziGFbSBFbw/kjQJOPrrbdL8DnYz3Tmro263SE0C96ENpgqIr4EkczD6ihNbnX+aHiDkeey+TgIP/4wF6PrAGiQciqs3VITGo8pupp1h6ULDQGIEDe6oKXAfo96mBQFgfgRIacEdHtIah8dS9ShvMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RdTm2LVB; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so5228428a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713792800; x=1714397600; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LwZc+ZBbmXu3G214pCU0lzqpNX0oYZU+cn+mUyu9Nmg=;
        b=RdTm2LVBMZZJKIDWaJFf0v+osiyC+uAyzogYVJS0QnaIPIwy/7FvxHgfP8A9vII2fg
         6PWGk294v5mcdz6u0gA9z7RgeVx/QiiMP5BGvOEyBFPC8b6qllGOEgsh09f0MVS+9XQr
         bZVfbZEDMJPmAulBGKPRJhbdT1DYql1paPZ8onPiOabtkJiMqP5oYAc0Y2ATfvnwZY43
         47+LeLpiwlMV3NsRp/dkmEdQqviH/JjikcE+Ti3/zGSS/A1Lue0V6xJai/7Qw7pi/Tvo
         e4zhFN6P89JpGXXdX0L4oLbjbX3VpsReyLsAIjWrSumiygQ5yS5B1TNo5dpdjvH1MoGB
         uw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713792800; x=1714397600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwZc+ZBbmXu3G214pCU0lzqpNX0oYZU+cn+mUyu9Nmg=;
        b=PgdsTgjndzuylHiK43nvauNb/p4uudeDBz3lC1YL/bPp5Rls2DfHcD6Cy5KBIwkg6R
         zdMPyy+Dx63x4rO2Tf8GEPVuiz/17pd45xB0TxoOWOp8pQNSkZc2uFbDXu0v00zypDED
         zyPTLO5r5JhKuHQ/l1ac+0iClCRQoqMIR4yoyXnw5H7+oseUIWUgNPr9Cv+bEr2tYEXA
         vlEzHcrOdYvZKhAD9SywkalAKmmgStljYUPKEPx7vOL1OjmwxBUSeCtD73vDKUOdrIpk
         MtUSKB6Tkdgu1/pF+BZhtQRg9pQot8ys91pYXlyxaPV7NrugtlCa3dFs/SddzD0j4rEh
         pL/A==
X-Forwarded-Encrypted: i=1; AJvYcCX4THnILAM2Jm4ESvxACnrGMp0M1I3SbT5BpHpY3A7GX+tZATUAXH4edScrTipCSHVT7CTq8UsT3QUnmi9OmoZcw+RafQAa3LLTEEKx
X-Gm-Message-State: AOJu0YyyOlIc4BbuUKoMutzKtkPBTwnaDsgg6zQDPqJMtbvZE8fUkeyP
	AyjRJxqrLRHU85ZjOp67v75Ai3ex8qYGRkfvyqfgdfQzOoTm4/faRmDrfPrW9o5ok2JG71aGlD0
	OVwUCJ85Y/YuF1/JsbwDovUlolKcCV9dys5VsKA==
X-Google-Smtp-Source: AGHT+IFfa5I8uWCyTOd8o7O7qiE3AgHBvfTCTUQ+++NWs2D/Vx2u1bA4fLgcCTpeCddH7HAbZdY1qTSY4Fs49oNO/qA=
X-Received: by 2002:a17:906:5857:b0:a52:2772:b9cb with SMTP id
 h23-20020a170906585700b00a522772b9cbmr6375318ejs.24.1713792799626; Mon, 22
 Apr 2024 06:33:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422112711.362779-1-mikko.rapeli@linaro.org>
 <6e751959b9056884c1b9d3ba23e303d1737d8763.camel@HansenPartnership.com> <ZiZhSfgeAdrbnaVL@nuoska>
In-Reply-To: <ZiZhSfgeAdrbnaVL@nuoska>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 22 Apr 2024 16:32:43 +0300
Message-ID: <CAC_iWjKA-xRH=3FK+=woXsB8AW4+_mVhJhUQnL8iFKxGzOwKiA@mail.gmail.com>
Subject: Re: [PATCH] efi: expose TPM event log to userspace via sysfs
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Ard Biesheuvel <ardb@kernel.org>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"

Hi all,

On Mon, 22 Apr 2024 at 16:08, Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
>
> Hi,
>
> On Mon, Apr 22, 2024 at 08:42:41AM -0400, James Bottomley wrote:
> > On Mon, 2024-04-22 at 14:27 +0300, Mikko Rapeli wrote:
> > > Userspace needs to know if TPM kernel drivers need to be loaded
> > > and related services started early in the boot if TPM device
> > > is used and available.
> >
> > This says what but not why.  We already have module autoloading that
> > works correctly for TPM devices, so why is this needed?
> >
> > We do have a chicken and egg problem with IMA in that the TPM driver
> > needs to be present *before* any filesystem, including the one the TPM
> > modules would be on, is mounted so executions can be measured into IMA
> > (meaning that if you use IMA the TPM drivers must be built in) but this
> > sounds to be something different. However, because of the IMA problem,
> > most distributions don't end up compiling TPM drivers as modules
> > anyway.
> >
> > Is what you want simply that tpm modules be loaded earlier?
>
> Yes, ealier is the problem. In my specific testing case the machine is
> qemu arm64 with swtpm with EFI firmware for secure boot and TPM support.
>
> Firmware uses TPM and does measurements and thus TPM event log is available
> on this machine and a bunch of other arm64 boards. Visible in early boot
> dmesg as TPMEventLog lines like:
>
> [    0.000000] efi: ESRT=0xf0ea5040 TPMFinalLog=0xf0ea9040 RTPROP=0xf0ea7040 SMBIOS=0xf0ea3000 TPMEventLog=0xeb3b3040 INITRD=0xeb3b2040 RNG=0xe5c0f040 MEMRESERVE=0xe5c0e040
>
> Different boards use different TPM HW and drivers so compiling all these in is
> possible but a bit ugly. systemd recently gained support for a specific
> tpm2.target which makes TPM support modular and also works with kernel modules for some
> TPM use cases but not rootfs encryption.
>
> In my test case we have a kernel+initramfs uki binary which is loaded by EFI firmware
> as a secure boot binary. TPM support on various boards is visible in devicetree but
> not as ACPI table entries. systemd currently detect TPM2 support either via ACPI table
> /sys/firmware/acpi/tables/TPM2 or TPM entry or via firmware measurement via
> /sys/kernel/security/tpm0/binary_bios_measurements .

One corner case worth noting here is that scanning the device tree
won't always work for non-ACPI systems... The reason is that a
firmware TPM (running in OP-TEE) might or might not have a DT entry,
since OP-TEE can discover the device dynamically and doesn't always
rely on a DT entry.

I don't particularly love the idea that an EventLog existence
automatically means a TPM will be there, but it seems that systemd
already relies on that and it does solve the problem we have.

/Ilias


> If either one of these exist,
> then systemd evaluates ConditionSecurity=measured-uki in services correctly and
> rolls out TPM services, cryptsetup etc. But the ACPI table entry for TPM isn't mandatory
> and many boards don't support it. Then latter requies TPM kernel driver to be loaded
> before systemd evaluates ConditionSecurity=measured-uki the first time, or basically
> the driver needs to be compiled into the kernel.
>
> In my case the uki initramfs is also based on systemd and does things like
> creating a TPM encrypted rootfs and this should work on a number of boards
> automatically, and none of the boards have ACPI table entries for TPM2, but
> all of them with real, swtpm or fTPM based TPM devices provide the TPM Event Log
> to the kernel. Thus systemd could use this as an indicator for TPM support in addition
> to the server grade HW standard ACPI table entry. And once this is in place
> TPM drivers and module loading work and initramfs can create a TPM backed rootfs
> on first boot. The catch is to install needed kernel modules to the initramfs but
> after that, all things work nicely.
>
> Hope this clarifies this change a bit more.
>
> Cheers,
>
> -Mikko


Return-Path: <linux-kernel+bounces-158475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F548B20A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110F01C25065
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBC712AAE5;
	Thu, 25 Apr 2024 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="onNKEIi2"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FAC12AAD1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714045670; cv=none; b=ZiE4bVKQhMAgSCbHu+NHVdcYc2225d1+ot0JxkMAcP0ssTuquBS/0PF4nHu1PQF/JAmldDiZ9RqNqOTUUOwYLvQAAOia4mdsrB38TMuVjwgsUenRCQjXZkLORKPFrV9RwseNtcIzJiZNxrMnL2aB8pCUjtjqT00vv87wT/SEdU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714045670; c=relaxed/simple;
	bh=RHNTIS3g2CJKJDZCRpS3u7vQxKmYqqYAO/4oGSKSXIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRmzcK6ChIzffRLzEuD+OsH0HvflZDBJo8UPj2T8cBgAyI6ARK1wmEpgehtSf1izU/PdjvG3hVa/6o7JyyofhlXnE7W+qL11RSB+qQssFPc9BZMpmlyLVMxS7TyD+9cEknPQpHi2uI6qlEySh9zLmoDanbkpEgEU0cf8FQSxnPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=onNKEIi2; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a55b2f49206so345877266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 04:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714045667; x=1714650467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHNTIS3g2CJKJDZCRpS3u7vQxKmYqqYAO/4oGSKSXIg=;
        b=onNKEIi2U5YgkbuSO1Wpu3aXa8GHXaJ7JmIRv/E9dZ5b1bFoO8oWutwkeEvHWLHBfl
         G0gO1B4YeXOuD5zGDu/szlfe5mhJhnFkK9RMKf5L1lxqEah2KV+ubNM90/jzmAibrU8o
         3jeFiwgCyGjnYtOsf7yHVLC0dmFm3uxSj/S+j0i8MGIzvXbfwHI8txNC+aTlfDlg9k69
         oy6xC307Ks9rXefDbGc6po6HCR0ca1GvC/+2+B9Ca9jy3O7Lvdh/kl6rrwFtNZAPUDai
         l0gdhWC8y6+yC/dNXcaEduH53NOc2LDmWt5ue07g//9AvfDMLK/4CDkh46u+L0+QEV4z
         kXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714045667; x=1714650467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RHNTIS3g2CJKJDZCRpS3u7vQxKmYqqYAO/4oGSKSXIg=;
        b=GyMzaE220rTbaRaJzDhMg3DwAe2m296NlHBelwXxaVucKBl6KX7lhDE6Sc3uvPpcVJ
         oOnYfm5/ISHQxYI+mOThDgsq9fLG1kMb77rtV75WEm5csE/9cRMDzHsiLMyrnWgPCaDG
         mLUM6eX9CbFk5XztU5id0rLx5OfcnTqTxV7uWRJZa4I0h0Wo7OL6dW2w/zxzY2SK517Z
         ncAdzsZDHvctZHJp7+kg/F8STwAq0qSKNteCShckWl+4h4xCFOKmWhBRpZ7qHBqj86NC
         GOZyK/zXYRzr8SxfJ1vMhFGC/eH+Ye6hgD7eKTF1XlFJiBlNF0fXw2LVEMfLai56Phcp
         JYOg==
X-Forwarded-Encrypted: i=1; AJvYcCUEOc78cHgD+CX+rijXEmXAtWjyHlB8WsMO9Mb4plUsz9LAc1RMclXdYmOUxmVsSLnsBgYmlwFmWuBkHaoJ9z5MPftO2155wcozi7Eq
X-Gm-Message-State: AOJu0YyQjiZ/ecEeheXhvs9/pkMoQbk2/QY0H3q857ZBgUd5Ce8Nydl1
	1XhARIXt7kUSAl6TBCLycLXt1r+eIs0D1DP1RNSq6JsHmVQIBU6HxvoozEdavS5N7YVlAf2AhFZ
	o2h7gbV09jGVOUQGWug/sFijlBwytJj2JX38y1w==
X-Google-Smtp-Source: AGHT+IE3ji8iTO06xLdWB8yL93NCmKcLgZr8yjyWFIgOSgjEAa2USrrDLaK8WiYbpAUGewZgsFmsU18MAMpB7iLGPq0=
X-Received: by 2002:a17:906:3289:b0:a58:8227:a2a with SMTP id
 9-20020a170906328900b00a5882270a2amr2455723ejw.25.1714045666913; Thu, 25 Apr
 2024 04:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6e751959b9056884c1b9d3ba23e303d1737d8763.camel@HansenPartnership.com>
 <ZiZhSfgeAdrbnaVL@nuoska> <CAC_iWjKA-xRH=3FK+=woXsB8AW4+_mVhJhUQnL8iFKxGzOwKiA@mail.gmail.com>
 <e3038141413e25350f0e53496f7a7af1bf8419cf.camel@HansenPartnership.com>
 <CAC_iWj+zbs2tq_nMASDX6pgCAP23+PpctJFiu9=mgOVDz8Trzw@mail.gmail.com>
 <e1da76ca4c7fe9319aaac5f8ff6eb46db433ec60.camel@HansenPartnership.com>
 <CAC_iWjLH=SDoTw_Pgr2hOKHkjEp_dKqwpUe9j6a=_WNW9UcxKw@mail.gmail.com>
 <CAMj1kXGHT2wULF2zwNM_QxD29dRW_dtFX2sOvsLahPiRVB61qg@mail.gmail.com>
 <ZiopXE6-AucAB9NM@gardel-login> <CAMj1kXETZ3L2QEZjD8=zr9FY11FGkf5KktXoSixjpGxWS4h8sA@mail.gmail.com>
 <Zio6xeRbld_tzH0B@gardel-login>
In-Reply-To: <Zio6xeRbld_tzH0B@gardel-login>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 25 Apr 2024 14:47:10 +0300
Message-ID: <CAC_iWjK7s9ERvNhf6-ER1epHa3j0bBmz0Jw4v_VBbE_kwMnG7g@mail.gmail.com>
Subject: Re: [PATCH] efi: expose TPM event log to userspace via sysfs
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Mikko Rapeli <mikko.rapeli@linaro.org>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all

On Thu, 25 Apr 2024 at 14:13, Lennart Poettering <mzxreary@0pointer.de> wro=
te:
>
> On Do, 25.04.24 12:36, Ard Biesheuvel (ardb@kernel.org) wrote:
>
> > > systemd these days makes use of the TPM =E2=80=94 if available =E2=80=
=94 for various
> > > purposes, such as disk encryption, measuring boot phases and system
> > > identity and various other things. Now, for the purpose of disk
> > > encryption, we need to wait for two things: the hard drive, and the
> > > TPM to be probed/driver loaded/accessible. /etc/fstab tells us pretty
> > > explicitly what bloock device to wait for, hence it's easy. But
> > > waiting for a TPM is harder: we might need it for disk encryption, bu=
t
> > > we don't know right-away if there actually *is* a TPM device to show
> > > up, and hence don't know whether to wait for it or not.
> > >
> >
> > I take it this means that the LUKS metadata lacks a 'this key is
> > sealed into the TPM' bit?
>
> Well, it does carry that info. But this is of no relevance
> really. typically luks has multiple keys enrolled, and which slot(s) to
> use is really up to the moment of invocation, depending on what is availa=
ble.
>
> moreover, i used disk encryption as one example, but we have more
> users of TPM. for example we measure early in the initrd that we are
> now in the initd, and when we leave the initrd we measure that we are
> now gone. we also have a tool that sets up the TPM SRK. All that stuff
> is supposed to be run if a TPM is available, but delayed just enough
> until the TPM actually shows up, but no more. So for all of that stuff
> we must have a way to delay tings correctly.
>
> > So exposing the physical address of the TPM event log is probably not
> > what we want here.
> >
> > Note that the TPM event log table is a Linux/efistub construct,
> > whereas the TPM final log table actually comes from the firmware
> > directly. So the former only exists if the EFI stub executed first,
> > and managed to invoke the TCG protocol etc. OTOH, the TPM final log is
> > TPM2 only, so it doesn't exist on TPM 1.2
>
> (side note: in systemd we do not care about tpm 1.2 anymore, we only
> support tpm2, and treat systems with just tpm 1.2 like systems that
> have no tpm).
>
> > Another thing we need to consider is TDX, which exposes a pseudo-TPM
> > which does not support sealing, along with a CC protocol similar to
> > the TCG2 protocol. This code will use the event log infrastructure as
> > well: there are discussions going on at the moment whether we can
> > improve the way these protocols are combined.
>
> The way the delay for a tpm device is actually implemented in systemd
> is somewhat generic: there's a target unit called
> "tpm2.target". Typically we just delay its activation until a
> /dev/tpmrm0 device shows up, if the firmware check suggested that. But
> you could also stuff all kinds of other stuff before that. For exampe,
> we could also delay it until some userspace service is running that
> turns the local security tech into a "fake" tpm device or similar. So
> from our side it's entirely pluggable already, and supports other ways
> to synchronize properly on a TPM being available, people can plug in
> whatever they need there for the synchronization.
>
> However, our primary focus is to cover nicely the typical/generic
> systems that have a discrete TPM or ftpm that just needs some generic
> driver probing/loading to be available.
>
> Or in other words: i am fully aware that a tpm-like device can be
> provided by various means. For now, with this firmware flag file thing
> we primarily care about the simple case where it's just driver loading
> that we need to do.
>
> > So we should define a scope here:
> > - do we need TPM1.2 support?
>
> For our systemd usecase, that's a clear no.
>
> > - do we need non-EFI boot support?
>
> My own focus is EFI. systemd supports non-EFI of course. If people
> care about non-EFI I am sure they'd be thankful if we could provide a
> similar automatism
>
> > - do we need to do anything in particular for FDE on TDX, which has a
> > TPM event log but no TPM is likely to appear.
>
> I'd ignore that for now. And if they provide a software tpm-like device
> eventually they just have to plug in the service that provides it
> before tpm2.target and be done with it. I think we have an acceptable
> approach for that already.
>
> > I am fine with adding a sysfs node under /sys/firmware/efi that
> > exposes some of this information, e.g.,
> > linux_efi_tpm_eventlog::version, but not the physical address of the
> > table.
>
> Yeah, the physical address is of no interest to us. We just need to
> know the existance, and that independently of any actualy tpm device
> having shown up. i.e. existance of
> /sys/kernel/security/tpm0/binary_bios_measurements would be good
> enough for is if it was available without "tpm0" actually being
> around...

IIRC 'binary_bios_measurements' is only created after the TPM drivers
probe the device, so that wouldn't work.
Ard is right though the TPMEventLog is an EFI stub construct, so
exposing this is Linux-specific (and stub-specific).
The TPMFinalLog OTOH is described by the TCG spec so exposing that
even using the address address would work for systemd

Regards
/Ilias


>
> Lennart
>
> --
> Lennart Poettering, Berlin


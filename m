Return-Path: <linux-kernel+bounces-117155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D61E188A7F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD4F343066
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464EE12A178;
	Mon, 25 Mar 2024 13:36:38 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAE254747;
	Mon, 25 Mar 2024 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711373797; cv=none; b=bRCvUtENBqP8+5KXE9gJRJ12j244mMJIUG1A4JZ77IP5ZkochRQs8JCJGpopwSP3Pr8omKhqGOErAP1X4q9AeRfMJAqo8LDfbVRnSSsNIr3ACBG8weOh5Owq06hLBRS3w5cqeuDqXm0UefOWhm8WoFy1mXSgbsYnDtpV9+jG5/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711373797; c=relaxed/simple;
	bh=g57uFNVm1XsrkAgZ3q+epX8d4Jw3I4hrxZp2HoXRzjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcyXCVvXtRz9eKUkpdh8Yxi6hz108ZdGRhiYiFwQ7cufnFYFdECWpgUAhsUGvGL7QAo4VzTfanRDE78aPy1whLCxNTeDduogMbXPSuMlBZQRtbSfVkV5w/2DY3BHpv6ETYCutn1ueE5zxHYLXiRkCAzukeRPD77Tnf2nYln8AL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a47680a806so1086903eaf.0;
        Mon, 25 Mar 2024 06:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711373795; x=1711978595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNsJKMWcP5BKzAVOxwmbCiotTpuQe+ofoUlN5WR6A/Y=;
        b=JDh5uin7Hj6oQ7T6PXqWB/TpQz/mlzgDtWi52XFYtuA8fgiCeloV4nKhoEEiyuiOGF
         YIfJ4/rA3xcU0nzbjavs0GZuqW9Aty8mqb0rpPPoOm9f8QvDzRIWApm3ySJxyoHDNGKy
         Sb0hGUkiF3sfZPjNhZ01XgwOpeiIGDS3NNw/ow1kJaUzwk1hzKrHERKG7wZbsynnvGuw
         0MgoGwekUCc4XWo6nqYYywOQXbCxm3ghNPsOTIS4N/LpN7YFlni3JEOxx8yHDUp/jvlU
         Yz6/wsZgeqJyJWaektQkP+9qtePYiMb86I7zJ8UPYVgLigTpg0THokkymocLx64P7517
         tgTg==
X-Forwarded-Encrypted: i=1; AJvYcCXre5D0xFsS8FSpKXbnNTLh4iUSOO9iiqgY0vwlX0eW2L0PFZVC+Hbt0HSDJdGLdF4SAyVLBXZFf8iDobbqUboZ7Z0OszFXIkBQ35ZDCLylJU8rPb/TNKa7GAXo0jq244iWADajnk6H8A==
X-Gm-Message-State: AOJu0YyAWxIzqy1uGosYoVuPLRBuAeRdrC2eRjhBbiI9/4AOSoEhkNV1
	1S8Hu0WM9Egpgn3Bmd6IrxUBlJIOYLTyJEDNdb6atrokvJ0GVhyBxA5spf1siAb1f+/r60SWfbp
	b2Bz27BPxtdZgpjxPtBeLCQGoFDQ=
X-Google-Smtp-Source: AGHT+IEffQ0IRPFNBHlwYpeLrynLljQmOAKIl5tAWRNrx36NI5VhvMxnnDrYCl44S2gDPIuEHy6QZMCdTQkZwyGFR8Y=
X-Received: by 2002:a05:6808:1588:b0:3c3:cd59:8bca with SMTP id
 t8-20020a056808158800b003c3cd598bcamr3555907oiw.1.1711373795280; Mon, 25 Mar
 2024 06:36:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12417336.O9o76ZdvQC@kreacher> <CACRpkdayWiVskunN-YeYzS7dd6ZGHmqiTbCyWQKvOG91S04Dzw@mail.gmail.com>
In-Reply-To: <CACRpkdayWiVskunN-YeYzS7dd6ZGHmqiTbCyWQKvOG91S04Dzw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Mar 2024 14:36:23 +0100
Message-ID: <CAJZ5v0j5qFR-8iLUh+o+k6rTF3xEAXu0iBdcRK6p-64=w2wchA@mail.gmail.com>
Subject: Re: [PATCH v1] irq: Introduce IRQF_COND_ONESHOT and use it in pinctrl-amd
To: Linus Walleij <linus.walleij@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, 
	Francisco Ayala Le Brun <francisco@videowindow.eu>, Mario Limonciello <mario.limonciello@amd.com>, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 2:32=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
org> wrote:
>
> On Mon, Mar 25, 2024 at 1:58=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.=
net> wrote:
>
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > There is a problem when a driver requests a shared IRQ line to run
> > a threaded handler on it without IRQF_ONESHOT set if that flag has
> > been set already for the IRQ in question by somebody else.  Namely,
> > the request fails which usually leads to a probe failure even though
> > the driver might have worked just fine with IRQF_ONESHOT, but it does
> > not want to use it by default.  Currently, the only way to handle this
> > is to try to request the IRQ without IRQF_ONESHOT, but with
> > IRQF_PROBE_SHARED set and if this fails, try again with IRQF_ONESHOT
> > set.  However, this is a bit cumbersome and not very clean.
> >
> > When commit 7a36b901a6eb ("ACPI: OSL: Use a threaded interrupt handler
> > for SCI") switched over the ACPI subsystem to using a threaded interrup=
t
> > handler for the SCI, it had to use IRQF_ONESHOT for it because that's
> > required due to the way the SCI handler works (it needs to walk all of
> > the enabled GPEs before IRQ line can be unmasked).  The SCI IRQ line is
> > not shared with other users very often due to the SCI handling overhead=
,
> > but on sone systems it is shared and when the other user of it attempts
> > to install a threaded handler, a flags mismatch related to IRQF_ONESHOT
> > may occur.  As it turned out, that happened to the pinctrl-amd driver
> > and so commit 4451e8e8415e ("pinctrl: amd: Add IRQF_ONESHOT to the
> > interrupt request") attempted to address the issue by adding
> > IRQF_ONESHOT to the interrupt flags in that driver, but this is now
> > causing an IRQF_ONESHOT-related mismatch to occur on another system
> > which cannot boot as a result of it.
> >
> > Clearly, pinctrl-amd can work with IRQF_ONESHOT if need be, but it
> > should not set that flag by default, so it needs a way to indicate that
> > to the IRQ subsystem.
> >
> > To that end, introdcuce a new interrupt flag, IRQF_COND_ONESHOT, which
> > will only have effect when the IRQ line is shared and IRQF_ONESHOT has
> > been set for it already, in which case it will be promoted to the
> > latter.
> >
> > This is sufficient for drivers sharing the IRQ line with the SCI as it
> > is requested by the ACPI subsystem before any drivers are probed, so
> > they will always see IRQF_ONESHOT set for the IRQ in question.
> >
> > Closes: https://lore.kernel.org/lkml/CAN-StX1HqWqi+YW=3Dt+V52-38Mfp5fAz=
7YHx4aH-CQjgyNiKx3g@mail.gmail.com/
> > Fixes: 4451e8e8415e ("pinctrl: amd: Add IRQF_ONESHOT to the interrupt r=
equest")
> > Cc: 6.8+ <stable@vger.kernel.org> # 6.8+
> > Reported-by: Francisco Ayala Le Brun <francisco@videowindow.eu>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> > -#if !defined(CONFIG_GENERIC_IRQ_PROBE)
> > +#if !defined(CONFIG_GENERIC_IRQ_PROBE)
>
> Is that some whitespace fix? Not that it matters to me, so:

Well, incidental, but yes (trailing whitespace).  I actually forgot to
remove this change from the patch before sending it.

> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> I expect that Thomas want to apply this one.

Thank you!


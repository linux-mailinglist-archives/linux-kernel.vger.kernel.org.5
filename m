Return-Path: <linux-kernel+bounces-96013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 854E6875619
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5900283BC6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9645133401;
	Thu,  7 Mar 2024 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3HHOofO"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B912C180;
	Thu,  7 Mar 2024 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709836149; cv=none; b=VhnpsSF2CA3Wl3C3bQNE0UpbZplvg0fmw+lk0vbh2ssa0fiOkYkDkqBasVtJH8SuaoqWCk8VtM156Fb/I3YolUlga88hPhPap6n6H6jVj2Ox0678kKS7Gxi0mGYMdiDl9JEFV9Pbd+xrv/O1CTbWCObwgXDogeo0FDBeEg7+F2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709836149; c=relaxed/simple;
	bh=eBSebctmO6Ythh8P9I3Tu0FhUlKA5IX3lUZ879cQR8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7s51NLqLJXF/IZPxLA3Un6r6qESE4zcXpDj1OVjRHB3Cs4uYMOMvzu/eICobPQpJ8+KZ30pA3+mdrl5jzEnbxrb887xzlBT9i/c1F0X9w38uq4n4coT1uTv8iCY0DuQ++mSDsOSMtWI6hBfJp2SFFG2Avgt9MlghRJA0RDgWuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3HHOofO; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso957020a12.3;
        Thu, 07 Mar 2024 10:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709836147; x=1710440947; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZNpOPY6J6NoDjcYUmT22gL0RoTRGL1EqV0mF/U5iDE0=;
        b=l3HHOofOCkuPZcUgo/1dXDVs9fhjs5/z+rwBc0AVyEJxr1EBhemoFNRcxE+nn+MhjQ
         BNNp32tcF29xWJqN5rUw92ue+wWT6KI+jrOSrSbCiCYDII7KpArNyo/5LGYSy0EAJjg0
         0fgitrFkq5A5FE7XCsqFKcYuZ33/RnnQKCX4Yauih3SV+UMGWleCoAu0gEB/Xel0heZS
         sj9b8jldPblsUpKUspNILkaM2UxyJsgBtMyDw2fRo9BE5vCkKFtTcXR2E1F+dWBHkXse
         ewYi1admE+oATpdRGrlA4amqkIzNyiA7/zX/oaE+hiNtYLsqG5MhwymRxh2RGwE+lPGV
         jOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709836147; x=1710440947;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNpOPY6J6NoDjcYUmT22gL0RoTRGL1EqV0mF/U5iDE0=;
        b=ILeRJuR+x5foYDKKfwVw63qhFkBH4CynVPvQEJY8Su2JnFQKCX3nk7015BNDL9b1Oj
         DNrUjLKiRGP3KTlgakMZLkM6cg94L55hILX/MqdqrXx21MLUNrwXpzUov3Qyf9a5n4Xh
         VkOwfqu5RoGx6IJcHwnj7edJBaasJGaRZzyYPoF9L5UWNNcoSFpS/FqsG3fKhAZtCSFS
         jZ9UbJ5jNRqZbEDYyQ9ataE1aCe+HeKfY1LjrJsChHA40vzmjoaPTVkakjTTgEE9tbc7
         zb7GkDkpDGdGFOtb4BwnE4gMGFH9ycK13c+BjRmiK7tHHYejUgxCvhvRclb42YaWWxsI
         fKBA==
X-Forwarded-Encrypted: i=1; AJvYcCWkq4r2p7fbmHSdEbHjXwUKzsMCcmckD9v0no3nnoYnzbyNbZZ374pKDXk8lLX2rS4nDw8rj0XZuWUvOmjQIyJ1xIb6UiQXXG9Um+BhYhnCciriyFzPePyOP6HzzfoEpQnuJSEqtg7XW9ONbCleZz1R
X-Gm-Message-State: AOJu0Yzken+fQUc7mxM7ivWXVfYXOQP37ZGRgKZF7nTw8ZgwYzGAnbgR
	Cmist5qQJeSRwl4J8tx8p2i+YzAd+68fAa4jOkhfNvw/yFCdetpNkPbOpOku
X-Google-Smtp-Source: AGHT+IFoqGRAc7bA+Jb5qPn3fbeVju8JdprzvuqhlMjyIn+5aoLqHrodeP54M0NUofB2BTKLM3iynw==
X-Received: by 2002:a05:6a20:3d27:b0:1a1:6f2c:ceb7 with SMTP id y39-20020a056a203d2700b001a16f2cceb7mr3808492pzi.8.1709836146949;
        Thu, 07 Mar 2024 10:29:06 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:7cdb:7132:a03e:7749])
        by smtp.gmail.com with ESMTPSA id c11-20020aa781cb000000b006e4362d0d8csm12935384pfn.36.2024.03.07.10.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 10:29:06 -0800 (PST)
Date: Thu, 7 Mar 2024 10:29:04 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Denose <jdenose@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, jefferymiller@google.com,
	Jonathan Denose <jdenose@google.com>,
	Raul Rangel <rrangel@chromium.org>, linux-input@vger.kernel.org,
	Ike Panhc <ike.pan@canonical.com>,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] Input: psmouse - add resync_on_resume dmi check
Message-ID: <ZeoHcH59Qsiv90b-@google.com>
References: <20231102075243.1.Idb37ff8043a29f607beab6440c32b9ae52525825@changeid>
 <ZcKs589qYxviC1J4@google.com>
 <CALNJtpV0KsOusPQeGv8bQ3jKy2sUj+k=mPHc172f+vMaTDYPfg@mail.gmail.com>
 <ZcZ2oG1Rls-oR593@google.com>
 <CALNJtpWNbSZdpxky9hTiSRsaGgLDUnM66QGEy213d3Lhra0hsw@mail.gmail.com>
 <ZeDLq9gPs5InBmdK@google.com>
 <CALNJtpWwhen2H9OT1-rZ4bt+huwXPOPz6qVDJ5g+emE1wRSLsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALNJtpWwhen2H9OT1-rZ4bt+huwXPOPz6qVDJ5g+emE1wRSLsw@mail.gmail.com>

On Mon, Mar 04, 2024 at 11:17:31AM -0600, Jonathan Denose wrote:
> I disabled the ideapad driver by rebuilding the kernel without the
> ideapad_laptop module. That does fix the suspend/resume issue!
> 
> Attached are the logs. Is there a way to make this permanent?
> 
> On Thu, Feb 29, 2024 at 12:23 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Mon, Feb 12, 2024 at 02:57:08PM -0600, Jonathan Denose wrote:
> > ...
> > > [   50.241235] ideapad_acpi VPC2004:00: PM: calling acpi_subsys_resume+0x0/0x5d @ 4492, parent: PNP0C09:00
> > > [   50.242055] snd_hda_intel 0000:00:0e.0: PM: pci_pm_resume+0x0/0xed returned 0 after 13511 usecs
> > > [   50.242120] snd_hda_codec_realtek hdaudioC0D0: PM: calling hda_codec_pm_resume+0x0/0x19 [snd_hda_codec] @ 4518, parent: 0000:00:0e.0
> > > [   50.247406] i8042: [49434] a8 -> i8042 (command)
> > > [   50.247468] ideapad_acpi VPC2004:00: PM: acpi_subsys_resume+0x0/0x5d returned 0 after 6220 usecs
> > ...
> > > [   50.247883] i8042 kbd 00:01: PM: calling pnp_bus_resume+0x0/0x9d @ 4492, parent: pnp0
> > > [   50.247894] i8042 kbd 00:01: PM: pnp_bus_resume+0x0/0x9d returned 0 after 0 usecs
> > > [   50.247906] i8042 aux 00:02: PM: calling pnp_bus_resume+0x0/0x9d @ 4492, parent: pnp0
> > > [   50.247916] i8042 aux 00:02: PM: pnp_bus_resume+0x0/0x9d returned 0 after 0 usecs
> > ...
> > > [   50.248301] i8042 i8042: PM: calling platform_pm_resume+0x0/0x41 @ 4492, parent: platform
> > > [   50.248377] i8042: [49434] 55 <- i8042 (flush, kbd)
> > > [   50.248407] i8042: [49435] aa -> i8042 (command)
> > > [   50.248601] i8042: [49435] 00 <- i8042 (return)
> > > [   50.248604] i8042: [49435] i8042 controller selftest: 0x0 != 0x55
> >
> > So here I see the ideapad-laptop driver trying to access i8042 before it
> > even starts resuming. I wonder, does it help if you disable
> > (temporarily) the ideapad driver?

OK, so I tried to cook up a patch that would allow ideapad-laptop driver
to establish device link with i8042 so that the resume will be processed
after i8042 resumes, but the longer I think about it, the more I think
that ideapad driver should not be messing with the touchpad state
directly. The disable event may come up in a middle of the touchpad
resume transition, or when we decide to change touchpad mode for one
reason or another. It also does not respect inhibit/uninhibit controls
for input devices. I think that the proper way for ideapad driver to
handle this is to only send KEY_TOUCHPAD_OFF/KEY_TOUCHPAD_ON to
userspace and let userspace deal with toggling touchpad input (via
inhibit or by other means).

CC-ing ideapad maintainers for their thoughts.

Thanks.

-- 
Dmitry


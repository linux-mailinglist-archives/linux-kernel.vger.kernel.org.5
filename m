Return-Path: <linux-kernel+bounces-87277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D5C86D212
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC1C287661
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C157B3E9;
	Thu, 29 Feb 2024 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnVuMV4m"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA6478270;
	Thu, 29 Feb 2024 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231024; cv=none; b=q2L84Y1B35S3Goce0yMUhPJkrzghcmdH+6natq14WKtORfiXayrCDVV3aeLFZp/vZ3b9zxwXe+OcHPeSd+qfsfRT6+gMXwEtMWLv9SfXuziWz1jOuY/gUlVNGPjborLJWavr88lPOW2oqUCRZJSLXM6fxN4dilDBP+UUZ8VwQ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231024; c=relaxed/simple;
	bh=5jqso/svpH6RJgz80zOv2/ISg2eV2Gq5Sp0Ypt8qi5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akMUs15oFD5OtXSGDbpr4PNNYCVOj4N0VMVfZCd2JGfojEyc9CE7A3b5xvIxtcjZy2+fvkdAOT7UA5TAFYEmc0a02+35BXtPReAi/SNUmOkxODa/wCVoyG7G/YDOoWIEHwRp5WgaVg68VCU8PcyTTRS7dXO3CuukBEPmsAJohpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnVuMV4m; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e558a67f70so1209986b3a.0;
        Thu, 29 Feb 2024 10:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709231023; x=1709835823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oxDoMRVa20IuyjJXcaw3kzEI/O2UphhqTGKzQSQuVLg=;
        b=QnVuMV4mqZxXGL18W7GN/ZVwtTPZGqQhqyIiiSkpuD8x3f3D/B2NVc4MAVfaWFA6yM
         CYv7chD4Ta1OvGYFbzlKc1LK0dTRBcmJuUCZj2UlY3wE+qgleo30clq1+cJfjevZLlbO
         NM7UXURsPTh7a3y9hgVz9PjXCOgwCxTyrcsQjSI8flNoHq3tcionWH5cJDexzs+seDhp
         97tvpMRp4EGYFwu3WoZMyH3hxYQUGFYOy2TWU8K+w4I6LPFGw0IyGAj6NWHxI9KTwriI
         kR7Xho34szppRs+aY72P1kEj5Om8jIHuRigjABg8BV9YHSsY9FSeSamQKSRhGc1iGTzA
         TFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709231023; x=1709835823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxDoMRVa20IuyjJXcaw3kzEI/O2UphhqTGKzQSQuVLg=;
        b=rSoa24YAi6kwljS7ZLkW4AsXoM2BkPlVB3nVtu0d8DmdBJCy2815Lp9mwcqf/XaH2V
         SdH7iY8vCM80s2/t0zSVbDRPYoEimlZhqRT8ImS/chdjMjuDAy5HVlhuPIPb63wCwL3J
         N44DES2DG+9cyR/4JJZal4iutLmuQ2+4W5J2KI+qC0FsfvQi54rILedJ8E/9gkLPCpnA
         p//QqFNYMrtWqZCS+P2+Qhs8YpGpQEOtdiXYwFFPS1xCP6I/7kuaxS4AiyZTaCy1K8S2
         LtdnZin/vaHddFmwhaqbfkYRLZbmGJ2PBnw/3Pr00/n6neZhUSWX05MmrS5VoeX3uxY4
         oNDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfEc1lo+6onRbF+pHjqzyKLwkPVS5P1Wc7ZEXGdKyOYlSQeKa+1qgiLUcSX51thIAB/tkBYAnwdC6h8VTFWWC/DljNJp0nJgV+KOE=
X-Gm-Message-State: AOJu0Yz23tRZm1UMFR2mNdwPno6U3BsEPGsBFfIP1Ei9a3DTWmT9GwSj
	lOwb/nYXVeoJihHJZfll7JkZJmXBAgUIh7JvwtcH5oAZRMHve+LR
X-Google-Smtp-Source: AGHT+IHkqlVqyDo+KQuoVkjYQujzZcaxmfHofCO2mnYHEm8bP4IaQTnoB3zFeIsc3gLtYw1hwgLl/A==
X-Received: by 2002:aa7:9e88:0:b0:6e5:3e08:cbf1 with SMTP id p8-20020aa79e88000000b006e53e08cbf1mr2980024pfq.23.1709231022224;
        Thu, 29 Feb 2024 10:23:42 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:157c:61d4:480a:864b])
        by smtp.gmail.com with ESMTPSA id g8-20020aa79dc8000000b006e4d8687f44sm1558151pfq.102.2024.02.29.10.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:23:41 -0800 (PST)
Date: Thu, 29 Feb 2024 10:23:39 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Denose <jdenose@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, jefferymiller@google.com,
	Jonathan Denose <jdenose@google.com>,
	Raul Rangel <rrangel@chromium.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: psmouse - add resync_on_resume dmi check
Message-ID: <ZeDLq9gPs5InBmdK@google.com>
References: <20231102075243.1.Idb37ff8043a29f607beab6440c32b9ae52525825@changeid>
 <ZcKs589qYxviC1J4@google.com>
 <CALNJtpV0KsOusPQeGv8bQ3jKy2sUj+k=mPHc172f+vMaTDYPfg@mail.gmail.com>
 <ZcZ2oG1Rls-oR593@google.com>
 <CALNJtpWNbSZdpxky9hTiSRsaGgLDUnM66QGEy213d3Lhra0hsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALNJtpWNbSZdpxky9hTiSRsaGgLDUnM66QGEy213d3Lhra0hsw@mail.gmail.com>

On Mon, Feb 12, 2024 at 02:57:08PM -0600, Jonathan Denose wrote:
..
> [   50.241235] ideapad_acpi VPC2004:00: PM: calling acpi_subsys_resume+0x0/0x5d @ 4492, parent: PNP0C09:00
> [   50.242055] snd_hda_intel 0000:00:0e.0: PM: pci_pm_resume+0x0/0xed returned 0 after 13511 usecs
> [   50.242120] snd_hda_codec_realtek hdaudioC0D0: PM: calling hda_codec_pm_resume+0x0/0x19 [snd_hda_codec] @ 4518, parent: 0000:00:0e.0
> [   50.247406] i8042: [49434] a8 -> i8042 (command)
> [   50.247468] ideapad_acpi VPC2004:00: PM: acpi_subsys_resume+0x0/0x5d returned 0 after 6220 usecs
..
> [   50.247883] i8042 kbd 00:01: PM: calling pnp_bus_resume+0x0/0x9d @ 4492, parent: pnp0
> [   50.247894] i8042 kbd 00:01: PM: pnp_bus_resume+0x0/0x9d returned 0 after 0 usecs
> [   50.247906] i8042 aux 00:02: PM: calling pnp_bus_resume+0x0/0x9d @ 4492, parent: pnp0
> [   50.247916] i8042 aux 00:02: PM: pnp_bus_resume+0x0/0x9d returned 0 after 0 usecs
..
> [   50.248301] i8042 i8042: PM: calling platform_pm_resume+0x0/0x41 @ 4492, parent: platform
> [   50.248377] i8042: [49434] 55 <- i8042 (flush, kbd)
> [   50.248407] i8042: [49435] aa -> i8042 (command)
> [   50.248601] i8042: [49435] 00 <- i8042 (return)
> [   50.248604] i8042: [49435] i8042 controller selftest: 0x0 != 0x55

So here I see the ideapad-laptop driver trying to access i8042 before it
even starts resuming. I wonder, does it help if you disable
(temporarily) the ideapad driver?

Thanks.

-- 
Dmitry


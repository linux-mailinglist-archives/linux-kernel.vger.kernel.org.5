Return-Path: <linux-kernel+bounces-51015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95814848511
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 10:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B111C221EB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 09:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9BC5D726;
	Sat,  3 Feb 2024 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GGikTWdu"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C615D47E;
	Sat,  3 Feb 2024 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706953413; cv=none; b=GWJUrfDrYe6iWNx+4zOLBV6gIWmPQzwLXc53gVu4nQHZJnrXfcG2F6+gcmlFXdm01kI0hZ/uYCd9XIKYTDqYu7LKRQtVmD/I8KHqwWemh83QwTLuJTP4N65X92vCBohgheo/amcSd2/Yrk47zqs98/PUIl8M5uBswDngUTUT+lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706953413; c=relaxed/simple;
	bh=Vp48SAQNct4tT6bSE92UtHgVKXjC05Qo+Yzxqp94SGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfVT3aKxA+rEZWJvblA+gyq8lklucp64mMvTWNdmbpc00JhKpZuSSpkSoGt7UkHME8T9WwF4CGChD45cLfe4UZMOE9VsWlyGVCgotnGaCPuuqEdKnyc+KN4GG9X/707RlHNDasLHYkh1XmH4w3fY5sw3jtbAKr09d1nspaXRTmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GGikTWdu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4497240E016C;
	Sat,  3 Feb 2024 09:43:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id coJ00F2PtT_b; Sat,  3 Feb 2024 09:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706953407; bh=mgZAg3GpwXZthnw1a16qEM2E56aABkLqL8sx7VGeWyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGikTWduUt14Id46rEGfYg2pfXHyGPp8xlv4N14UyuPD8YNDf6UOgMAjTsTUyYyjK
	 MOLPiLT318Z9DFMA1aTRb6SJBy+7fDEWR5f6MhMzPmF2GuylCrHQL2GmOtWTK9qIMs
	 d+6YH+AwHAB7ErsrN2j1dcaeyuxnWT/I2LQnTw9lI5JHAdgJFWzHoGkSGTTUNIQLi6
	 HeUP7mdhZeAIWLEn5K8Nvl4MhFZO2G2gLX4ss8GO25g5jei5zz0MZS8E008Npe8DSq
	 0ItDlBHY/abMUbde34QFbxPMe8BwEdNql319dPe8RxQy9uXe7X3ZbAMXEdYpoNqc1h
	 MIXjc+eBEaWx//LfzjaDpiGPs4Ic/zyh/B6BuwNwgaqLSntMYP32cLOH06DpQ6SUPc
	 U9Ez/cd/82Lldoqioyh361CAh6kGHUR9YN9clrJptf16ohjSAAT0uJ2cuUFkRTT2Ap
	 qgyWlrUI1N4f4IGuxQ3QGmnLD6VYkgruUA5KdcoU8MJF4jRd0xd0CcGSJ+HrdKyq6V
	 7V8b3vE7hvI7Zl23Xn9G6zVTNwvrF4V50QcDlTR70dkJL1REommUg3BkxPrEjFdKSA
	 hK+yPzdu+s0WKduoSJu8HR1lQgyruuSdaQ8pRrSepjSzbWJTCPs79t4gzaegWlHQvu
	 SoOlGpgprGToG3Pjzn1YegDg=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E13F340E0081;
	Sat,  3 Feb 2024 09:43:10 +0000 (UTC)
Date: Sat, 3 Feb 2024 10:43:09 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: "Luck, Tony" <tony.luck@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v4 2/3] x86/mce: rename MCE_IN_KERNEL_COPYIN to
 MCE_IN_KERNEL_COPY_MC
Message-ID: <20240203094309.GDZb4KrS2GWa5XtGeZ@fat_crate.local>
References: <3009aadd-69d6-c797-20b4-95cf926b6dd9@huawei.com>
 <20240201142016.GFZbuooG9CRoK90U2C@fat_crate.local>
 <39c1e4d2-b1d0-91ae-595e-1add4698dd7f@huawei.com>
 <20240202133911.GBZbzwf-M37M-J3EJX@fat_crate.local>
 <SJ1PR11MB6083A60DE19FBFB1B0CA6B3DFC422@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240202194257.GFZb1FwcPPO8WXF86H@fat_crate.local>
 <SJ1PR11MB6083BDC3A0596FA87BC25259FC422@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240202222220.GIZb1rHG3NiZKmdRXu@fat_crate.local>
 <SJ1PR11MB6083FDC9D4661A9D94E26ABDFC422@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <4d974c1e-b3a8-8b21-88f4-e5f20b2fb654@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d974c1e-b3a8-8b21-88f4-e5f20b2fb654@huawei.com>

On Sat, Feb 03, 2024 at 03:56:04PM +0800, Tong Tiangen wrote:
> The goal of this patch:
>   When #MC is triggered by copy_mc_user_highpage(), #MC is directly
> processed in the synchronously triggered do_machine_check() ->
> kill_me_never() -> memory_failure().
> 
> And the current handling is to call memory_failure_queue() ->
> schedule_work_on() in the execution context, I think that's what
> "scheduling someone else to handle it at some future point is risky."

Ok, now take everything that was discussed on the thread and use it to
rewrite all your commit messages to explain *why* you're doing this, not
*what* you're doing - that is visible from the diff.

A possible way to structure them is:

1. Prepare the context for the explanation briefly.

2. Explain the problem at hand.

3. "It happens because of <...>"

4. "Fix it by doing X"

5. "(Potentially do Y)."

And some of those above are optional depending on the issue being
explained.

For more detailed info, see
Documentation/process/submitting-patches.rst,
Section "2) Describe your changes".

Also, to the tone, from Documentation/process/submitting-patches.rst:

 "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour."

Also, do not talk about what your patch does - that should (hopefully) be
visible from the diff itself. Rather, talk about *why* you're doing what
you're doing.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


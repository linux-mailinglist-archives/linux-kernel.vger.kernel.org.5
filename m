Return-Path: <linux-kernel+bounces-141541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA898A1F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108301F29036
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246FF1755A;
	Thu, 11 Apr 2024 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RaPvBAkF"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D78417559;
	Thu, 11 Apr 2024 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712864145; cv=none; b=HQExBJoWoRY5eRuBKM12FPutgKlMWHSz/GoVdpEFC4HyIMduNWtwx1qxdlWcDzl6Kv3PnVtWo8XVcHn/x99VgYkrmngJcqPgzwyJChkTh5MTbPBqUVe3y3Jirs0D0fpdrorUAsJ59047JYZa/X268pwmrLqbFv8MXmABSMGlUn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712864145; c=relaxed/simple;
	bh=hCrHI3N1KKEbZ9Ju9XCvyw4U1X4GrngN7equ1CZR5RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBYadDCbOrpHX64Alr+pAKCsndwYr4iB+HbG5WWTyw5HnbDgXFgTKnCrN92uUfJezFqjZaHYK08rpvwez/w5exDMDZfHYPWoo4w4uKB4UryphE3mOh4rpWvUiO6TX7iF2FbgiX5DjnT1Ts+1f462/TCkJfDqAU1BzSd3+aAE4Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=RaPvBAkF; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fZ3fmdT9oUgO2wmrYEOWhcDcwgmf7m8Sawtw85kAd7M=; b=RaPvBAkFj96SS8PNgIcab5bNln
	3MSQA3IrTG4mjLcalN1p4H35xpSgRoOH8L3SuVARRMo9Q003N7Mib3bUjFLFEcwYXSti+ZhXsbU96
	MVNJ4chMCGpxKX57ohtCn6HvvvHaZnn5mHAdauSGAJMVDUNciWMBXKr0OZH4/IqTNTV6S6wri8aZq
	FsHSb5lxoaV0gtog+4ARjnfeEgD12MOWIyqo9RAS634XncuQCIdxWUDGfW7/C/mTo3Zag10UnUaWD
	YmNliruWvoTA2d9kXnCXM8DpWeIoclQqaaS9nkDsNeersLgA0I0+uYPKAVBvS6N1HfBqHsRQsO29t
	6aK39wcQ==;
Received: from [189.111.43.233] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1ruzqC-003fQg-MV; Thu, 11 Apr 2024 21:12:08 +0200
Message-ID: <3391c693-cf54-526b-79a8-d565e7140947@igalia.com>
Date: Thu, 11 Apr 2024 16:11:55 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [POC][RFC][PATCH 0/2] pstore/mm/x86: Add wildcard memmap to map
 pstore consistently
To: "Luck, Tony" <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, Joel Fernandes <joel@joelfernandes.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, Ross Zwisler <zwisler@google.com>,
 "wklin@google.com" <wklin@google.com>,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 Suleiman Souhlal <suleiman@google.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20240409210254.660888920@goodmis.org>
 <20240409172358.34ea19f0@gandalf.local.home> <202404091519.B7B2221@keescook>
 <SJ1PR11MB608317E066B6B3390F55FCB1FC072@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <SJ1PR11MB608317E066B6B3390F55FCB1FC072@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/04/2024 19:25, Luck, Tony wrote:
>>> I forgot to mention that this makes it trivial for any machine that doesn't
>>> clear memory on soft-reboot, to enable console ramoops (to have access to
>>> the last boot dmesg without needing serial).
>>>
>>> I tested this on a couple of my test boxes and on QEMU, and it works rather
>>> well.
>>
>> I've long wanted a "stable for this machine and kernel" memory region
>> like this for pstore. It would make testing much easier.
> 
> Which systems does this work on? I'd assume that servers (and anything
> else with ECC memory) would nuke contents while resetting ECC to clean
> state.
> 
> -Tony

Thanks Steve! Like Kees, I've been wanting a consistent way of mapping
some RAM for pstore for a while, without resorting to platform drivers
like Chromebooks do...

The idea seems very interesting and helpful, I'll test it here. My only
concern / "complain" is that it's currently only implemented for builtin
ramoops, which is not the default in many distros (like Arch, Ubuntu,
Debian). I read patch 2 (and discussion), so I think would be good to
have that builtin helper implemented upfront to allow modular usage of
ramoops.

Now, responding to Tony: Steam Deck also uses pstore/ram to store logs,
and I've tested in my AMD desktop, it does work. Seems disabling memory
retraining in BIOS (to speedup boot?) is somewhat common, not sure for
servers though. As Joel mentioned as well, quite common to use
pstore/ram in ARM embedded world.

Cheers,


Guilherme


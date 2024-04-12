Return-Path: <linux-kernel+bounces-142634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4435F8A2E16
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00DE12849F3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2FE56444;
	Fri, 12 Apr 2024 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NtAt7AQI"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCDF5028B;
	Fri, 12 Apr 2024 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712924275; cv=none; b=nVPSu5s5uKnaas+vl5aYZn/MQe3yBQ6EeEJV/7auRuO83G3mnlKmfuijxB2bF5bFN3+NpkuW91tfyi6DcivZv9lwayQF66wyEU7Uxo5kH7jMlngsyeCluOmUFbbb2Jfv3f6jp1ub08qu6NLXXo2SiaLbLVoJHpFGBRwXRgA4V/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712924275; c=relaxed/simple;
	bh=+U1LtVXjMahjN6b1v2hm6FPO3zfnpU3872uUOrfXgew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NPu7Kr9xqcbQmroxkiPXJoO8czU+p9nTsP+2VdxofFHPa/Uf2LpvS0Pql+ycfOqF4sgut+FC3j++98pe2qWB/Bitnk60RotYgAQNdKA+9Mll3BSy5QmyBJLp1MHkxzxFlMLb1X+7PMbbpTdpjRrEKH/FD7FAYuYzQkCiod4HQ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=NtAt7AQI; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fK3CUsnE2KS17+ZVqrhoIng6qc6MzqyQJVHWjI4HNs0=; b=NtAt7AQID+2XDIlh/uCByo3tkv
	Gw1oyQ24Jr526Oylb4rmcmdCH0y5lMolTcl0LRahNZmn+YmwQZNwjfCUoAAxo7YhUd190xzj9lDFv
	rAjnxSHc3FIlFwUcnX30R3EEd7xPkUG6fpkbLBiSxeG4RMHwb3IrJy5vqUG18396hMWPwgbO8uitq
	hR6XyKq1AoNiH1KpJq1TdtshoH4MvU2qa08F/XVD/servFRIORylGeaMniTz2VGgKgsii/Igdv5oJ
	hNNuMXvYJUAm6O6wccu9MUw28vxK1AJr1OgrQLZm5/okG7XClgj4mun66yg5l0V+uoWrGWKN6HsYf
	vn/DYpcw==;
Received: from [189.111.43.233] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rvFqT-003tEf-Pd; Fri, 12 Apr 2024 14:17:30 +0200
Message-ID: <fa5fa4c6-2b02-f47e-b9ba-65cfd85f57f8@igalia.com>
Date: Fri, 12 Apr 2024 09:17:18 -0300
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
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
 <3391c693-cf54-526b-79a8-d565e7140947@igalia.com>
 <20240411154007.5bdf8d95@gandalf.local.home>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20240411154007.5bdf8d95@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/04/2024 16:40, Steven Rostedt wrote:
> [...]
> What I think I could do is to have a check after memory is allocated to
> copy the table mapping (in the heap) if it is filled. The reason I did it
> this way was because it was the easiest way to save the label to address
> memory before memory is initialized. I use a __initdata array (why waste
> memory if it's hardly ever used).
> 
> But, after memory is initialized, we can check if the table has content,
> and if so allocate a copy and store it there and use that table instead.
> That would give modules a way to find the address as well.
> 
> -- Steve
> 

Thanks Steve, seems a good idea. With that, I could test on kdumpst (the
tool used on Steam Deck), since it relies on modular pstore/ram.

Cheers!


Return-Path: <linux-kernel+bounces-39997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5155183D849
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51AC1F272DD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC4612B84;
	Fri, 26 Jan 2024 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="F9q0Htxa"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C667D29B;
	Fri, 26 Jan 2024 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706264861; cv=none; b=fVXAKAkpZn2qBn63XTmvQrAITDuTBB+cngFN9ORLBpGy1GjGrTmD4QWnh18d56Vbf4Ijd34CQF0q/bE6590BIWQheBHFevUnAYjStYslgU/n7cuRyzUEsTkmOt7FFlZUKFo0uzGWJLE1lBpe/l4QWMQRiriUds4i9fiCH5SZmK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706264861; c=relaxed/simple;
	bh=0+6uW3E01gOEBOfdgAhQnU2+BnQHo5v7B+NFl20erek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BC3ELhhpdfQ7JHlP/XcZ/sF9wb+MdhBmchrrEsfxIIVd+Fy558KdRbdRiG4ANRWr4JDC7mU5PcZUp3RjN3lKCfMfUsbYf0aNyM1ItpClAgX4hzmhwSP3XJgg18r2zCb2fOlvYgvY/y9vVoZDc3ggvLJ/adzlTKjtVAKml9ywsh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=F9q0Htxa; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E42AF40E00C5;
	Fri, 26 Jan 2024 10:27:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4A_KLoSY1ucI; Fri, 26 Jan 2024 10:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706264855; bh=Lo3Jle6hGyaTjT1aYU4eDQLUEKWUsBykcFqCUCF7Z8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F9q0HtxaswEQEysDV0vPUznLmVX0B6R78VAI2jY7aEbBeB8WwHXi5Hq/x47zkZeYd
	 ENt6ZibVLG+5jaUzCzUAn+8nX2xOX02NEcQ5KzafkTaWpjZAncvum3zCSNLjDdwKSN
	 /H1MtphPC6GG1JyiwW4O3xaHiF21QQk7jDJiEa9WD/NDPyyS1GxBQgtBvK9An7RUI+
	 ZcPCUDcyRJOpX7ASwRXvKkLMSBLwehP8Y31dI635D/94bi8Q4R/tqC59HcYJxWwCS4
	 jzA0Zf9usxf53Gn6R5mSMJ59gVw0/B/4CcF6SrP+NL0AvDpZ3V3vpuXRLySZ1bXtrW
	 CSMCXzr4mDafLCq536E0UEF/t/NQaXMDrtlbZdJfYHttG/4Pu7gT80AIf8UJldr1+L
	 vx7BZiqPeuBJi/ap0Uc0SgyUvjWXH+w4PCYSHFWul8rJKD81gXW9yhKDu38VcHx4Ry
	 liL4RS5e0faCQEgX7yNdA7YRAmeFoGs1pusT6gZsUW2yydZ3pbdD+INnZJla0NxW9L
	 wPV0kTCOcz2yCiAGxKkMv9z+chgA+AeFb1taVeexyDNP2JdgZ5Vzyeme9+MkVuyt3P
	 PGLKn5sRmfkXP6+bcepgQIH7Eh97fDlLijZb4XLw0vqxsobx4AumAk/wOvOGAipJri
	 auOFQ3gvB3pqYB/DPt7hy92M=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CF33F40E0196;
	Fri, 26 Jan 2024 10:27:25 +0000 (UTC)
Date: Fri, 26 Jan 2024 11:27:21 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Avadhut Naik <avadhut.naik@amd.com>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
	"avadnaik@amd.com" <avadnaik@amd.com>
Subject: Re: [PATCH v2 0/2] Update mce_record tracepoint
Message-ID: <20240126102721.GCZbOJCTqTVmvgOEuM@fat_crate.local>
References: <20240125184857.851355-1-avadhut.naik@amd.com>
 <20240125185821.GDZbKvTW93APAiY1LP@fat_crate.local>
 <SJ1PR11MB6083DAA7A6EDBBDAF5987A80FC7A2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083DAA7A6EDBBDAF5987A80FC7A2@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Thu, Jan 25, 2024 at 07:19:22PM +0000, Luck, Tony wrote:
> 8 bytes for PPIN, 4 more for microcode.

I know, nothing leads to bloat like 0.01% here, 0.001% there...

> Number of recoverable machine checks per system .... I hope the
> monthly rate should be countable on my fingers...

That's not the point. Rather, when you look at MCE reports, you pretty
much almost always go and collect additional information from the target
machine because you want to figure out what exactly is going on.

So what's stopping you from collecting all that static information
instead of parrotting it through the tracepoint with each error?

> PPIN is useful when talking to the CPU vendor about patterns of
> similar errors seen across a cluster.

I guess that is perhaps the only thing of the two that makes some sense
at least - the identifier uniquely describes which CPU the error comes
from...

> MICROCODE - gives a fast path to root cause problems that have already
> been fixed in a microcode update.

But that, nah. See above.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


Return-Path: <linux-kernel+bounces-93668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FD4873310
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C84284F21
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D37B5EE70;
	Wed,  6 Mar 2024 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WWfmFupb"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6875D8F6;
	Wed,  6 Mar 2024 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718749; cv=none; b=b5uQJ2w3SMUTD/4HJ1LHh71JZdcymzRs9YfCLdDW0ehk901kAVmIO6ypAMzeUpcC1KzkqjjfLzHNj1jTwy6vQPtp6wy0ozCTELbZYy9NbeUSJq1ep/Cfc48NqhqPNvBuMX5Cm5qkIpk4RWfrt7bTFOgm5m41qEz4u7z9ahy3i2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718749; c=relaxed/simple;
	bh=7JYD9tHQqkKyAOpDYz8v9QbcUBvbZmg5L8nFtmnhjKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Avuc7dTZM/ad8p3RUHFqynko/95DGpmg8TMBeYtL/g90PE7/fDFjubIEMQIjjmV15PvbA4MGVCcnJGlh3QpE9UuULxULd6345TGGCzgOsDMvcHmY2KrrMkLRHoFhd/kYdX8b3ghI3lRIbewqy029qy3VBG4vvlXvm3trplS6tzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WWfmFupb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+UHTxiMOCWmnYGbzdr3xdIdiyFhD3trL1IlYn9sx2Ik=; b=WWfmFupbS1FWFYcVIBHqaTAfFo
	JT81TSIj80enOhfKIvYWxZw2DEVGtf4L9tMGSmq37QOCWbTSsD8kIrIUvSTE9rWsdUOqXl0V6BGWU
	TJ2WCLM+C8qogGo1lg7ZCilq7+J90LxSkB5Edb57G/utb42hdwtLn8ODtjpuTt6vrYiX+uaixttSq
	ghFAnCsyprG0PesBYJK3+disNSjK5IECAHw/kA3E82iLCy9xQR2dH/gh8oVQ3ZmQtZSyMxctVu9w1
	dnzTrvFqipnX7KbNMpsBLt+s25yM35D5l8kg7nTWo9cuzc4Nkxi+joj6DaPglnJJltC6Sk0yIGL46
	HmeZKelQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37134)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rhnwU-00089f-0i;
	Wed, 06 Mar 2024 09:52:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rhnwQ-0006GG-1M; Wed, 06 Mar 2024 09:52:02 +0000
Date: Wed, 6 Mar 2024 09:52:01 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Jiangfeng Xiao <xiaojiangfeng@huawei.com>,
	Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
	gustavoars@kernel.org, akpm@linux-foundation.org,
	peterz@infradead.org, dave.hansen@linux.intel.com,
	kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	nixiaoming@huawei.com, kepler.chenxin@huawei.com,
	wangbing6@huawei.com, wangfangpeng1@huawei.com,
	douzhaolei@huawei.com, linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] usercopy: delete __noreturn from usercopy_abort
Message-ID: <Zeg8wRYFemMjcCxG@shell.armlinux.org.uk>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <CAG48ez1h9X7Qv-5OR6hAhwnSOng6_PSXBaR6cT7xrk2Wzu39Yg@mail.gmail.com>
 <202403040938.D770633@keescook>
 <77bb0d81-f496-7726-9495-57088a4c0bfc@huawei.com>
 <202403050129.5B72ACAA0D@keescook>
 <b274b545-9439-7ff8-e3ed-604a9ac81f65@huawei.com>
 <20240305175846.qnyiru7uaa7itqba@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305175846.qnyiru7uaa7itqba@treble>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 05, 2024 at 09:58:46AM -0800, Josh Poimboeuf wrote:
> This is an off-by-one bug which is common in unwinders, due to the fact
> that the address on the stack points to the return address rather than
> the call address.
> 
> So, for example, when the last instruction of a function is a function
> call (e.g., to a noreturn function), it can cause the unwinder to
> incorrectly try to unwind from the function *after* the callee.

I suppose this can only happen in __noreturn functions because that
can be:

foo:
..
	bl	bar
.. end of function and thus next function ...

which results in LR pointing into the next function.

Would it make better sense to lookup the LR value winding it back by
one instruction like ORC on x86 does (as you mention) rather than
the patch you proposed which looks rather large and complicated?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


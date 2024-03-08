Return-Path: <linux-kernel+bounces-96613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBC2875EED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DE81F21B92
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0444F608;
	Fri,  8 Mar 2024 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TsVqNNY2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DEB4F5FC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709884730; cv=none; b=l5H0jXzx+miomGjRLsI+fOZOdgrmTd7ubPLZXvZPm5PNvzpkb6C8zBDVry2SrJdxb4beehf7O41kRTJ69MWj4VgkbhnXGCwZr7NJFnjhnO9Id6XsoHLA1jSM/ccJKzNmLWu9AF0AnWOhQY9qK+Kq23eOXn50XuRqONL2/6fvKZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709884730; c=relaxed/simple;
	bh=mPqwDzZR1mbSy2GJUvX1WjpUGbu98MrNXTq0E2C3bWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3AuH0tGkWhoq6cXavvHQvvp7JxW/m86Zm9pDjZeI0wX6IaPYdQqd0wFYwJsru/Avsc0iCJyeVXv88WGFSh4NYruCJfdqR348I3Tx5mo5K2ZCzDv+5mZIHVNzfkIcRimKphs71+WIfG8wvbvdXr0DuXQiCYspGDIxG5b6VAeyHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TsVqNNY2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E595540E0185;
	Fri,  8 Mar 2024 07:58:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ju0MZu6CsHgd; Fri,  8 Mar 2024 07:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709884721; bh=nKhcv7FveFX6Vu+YlDQrid2ZodAGgZyK6pa9YPbkzFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TsVqNNY2XS/L8EL89smxfC1Fetf/Q2Ai6WodavDiW9RXn0ZmxrNfcZC7FXG5iaGo0
	 8xQ8+YrSDv7rH7nJMd6Y+ObTPFxFNcE0GWqhZR6AUEtpNQBK75imPT+NMUHdxbxAD0
	 P0R+zj8/klmMUIOtfVcgxTJ+FYzXH0nGdQuLmyPdQDvpGCjQWf6qKevJ7JjxVx1PN1
	 sx/m28lBJWRGNQe22zNnAjasf+4R5GJCH3cMzGD3jj4pG4yBYAx3bSlc9JzTv6HVMa
	 vsHeDgNqwFNPSFQHgB1MayIbb8fvyumuOQg3s/HYnrGIgOIiKRBr9pC9S3eguHeQ7P
	 VXo+PQmKJTCHrYGznvvf+6Prf477P0rVv8e/TcU8coy+ulR/65k6YLvASiffAMQ3dx
	 tVUJaccZh/3enZDtGREHbq6nU9953j3ypKkYJ7QZDftcJMSKYML0aqy914K8TRUr3j
	 A128tZ9vXQy9FJ8R4TQyTjx3PJbMRg1R3ore1m7J64DIkWd6DR474jzEYezbeFWCsa
	 FnjDS3mshzXVzo6nAPAXC2gEnL+E8LDiS71EXUMiWgIOQee55I+BgBbvHx8Sc3s3DQ
	 WW9SmV1KO0c79cOzGjqhPRsRfdHzqM2GuOvLgAMYHipioOFf1tHvT/3+7V0HtwtaFG
	 PxsDTpeaeVZC2I9c90QPrdUo=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 57AC840E0173;
	Fri,  8 Mar 2024 07:58:29 +0000 (UTC)
Date: Fri, 8 Mar 2024 08:58:23 +0100
From: Borislav Petkov <bp@alien8.de>
To: Changbin Du <changbin.du@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH] x86: kmsan: fix boot failure due to instrumentation
Message-ID: <20240308075823.GCZerFH9Q-vl3FgY-l@fat_crate.local>
References: <20240308044401.1120395-1-changbin.du@huawei.com>
 <20240308054532.GAZeql_HPGb5lAU-jx@fat_crate.local>
 <20240308061054.54zxik32u4w2bynd@M910t>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240308061054.54zxik32u4w2bynd@M910t>

On Fri, Mar 08, 2024 at 02:10:54PM +0800, Changbin Du wrote:
> find_cc_blob() has instrumentation enabled and panic when accessing shadow
> memory.

Thanks, I was able to reproduce. With KMSAN enabled, a 5sec guest turns
into a 2 minute snooze fest. :-)

Oh well.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


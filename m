Return-Path: <linux-kernel+bounces-39213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3EE83CCDA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CDE61C213CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AE413541E;
	Thu, 25 Jan 2024 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="QAlnpq/N"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3611350C4;
	Thu, 25 Jan 2024 19:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212272; cv=none; b=DV9S0AugKG3FEDvm42+rBZ8fuz+udZ3XEHeAi6R3eLOKsgXXLkUFZ1fvN6A5lzHKSlTY4O0xYM2jo9gboyHB6s349LJT6M6y+YwfYFMy8mcJ4sJb/OvehKExhEp9HrSJpTpDrcpgUmIVV63AlhtwPooIzdr4PNTzrbw46uusYxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212272; c=relaxed/simple;
	bh=ATh9djxK8HKkbtQtKnOvJeZFbjCB0Hd0xJCBahyuK8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PL6Ml6XezrjIcowy/2Z+r61sxnh3Vbi+6gmx3JHGnUcmD2Ydip4UQKzJ4FUYi2KzTV0CqYYf57Bnz8QPCGpUDzCRwI9hy7v54e5Ep6A4GbNaPjLZ3RYjJD0vAgnmyJ0W3aJxY8f4tw/QhV0UPSxrVMwoAGZS8+CXEaLRaHHALl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=QAlnpq/N; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id ABAE37AD8;
	Thu, 25 Jan 2024 19:50:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net ABAE37AD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1706212256; bh=h6wrtDhBp2PxOh+85FqYyRhRJ+IO8/uIkDsZRDnJsdA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QAlnpq/NegvD5sYvEpbdG/BSmUQzeF/LbzH7nW4gPJbBpuy4T5rsK1WMuPohC3kXD
	 3H8V3k3ywCFhN+KUhTpt6kmDTJhkEDSzaCiYNsIPLJW/sPMsBnXFEUw3fh6s/xXjzs
	 uMcGfAN+NLWSv3QrRcVqRi0qMO9hBQLnVuXRSRV3BrSoUgGsAt1plxHuLwppVw4+z7
	 NMtOiWj6xrH5rMMDZi4iRoJq1Z/21QH60Q3XfofgeV0KjNtmsxNsRay8WjgdpRgZif
	 GmO/L6IWS6Xbxyn+xPDjIQC3dUmd2AfXa6MvzOmtjLZAh12ThSaA20SCmaaHfHGHhv
	 kzoQ9dAKJm0Cg==
From: Jonathan Corbet <corbet@lwn.net>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, Randy Dunlap
 <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Clemens Ladisch
 <clemens@ladisch.de>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 6/8] Documentation: Create a new folder for all timer
 internals
In-Reply-To: <87zfwtbbjd.fsf@somnus>
References: <20240123164702.55612-1-anna-maria@linutronix.de>
 <20240123164702.55612-7-anna-maria@linutronix.de>
 <8eac7bf0-86c5-43ef-99e0-0896c994184a@infradead.org>
 <87o7d9d7dd.fsf@somnus> <87plxpbgpz.fsf@meer.lwn.net>
 <87zfwtbbjd.fsf@somnus>
Date: Thu, 25 Jan 2024 12:50:55 -0700
Message-ID: <87r0i59ops.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Anna-Maria Behnsen <anna-maria@linutronix.de> writes:

>> I've thought for a while that we should have a standard warning or two
>> along these lines, like Wikipedia does, but of course haven't done
>> anything about it.
>>
>
> Sure, if we could standardize it, I would definitely prefere it! For me
> as a not sphinx/rst/... expert, it would be great if only something like
>
> .. might_be_outdated:: <optional additional text>
>
> needs to be added to the code. And then the default lines would appear
> together with the optional additional text.
>
> Is this what you have been thinking about?

You've already put more thought into it than I have :)

I was just thinking in terms of some relatively standard text.  I'd
rather not create an extension just for this, but Jani's idea of using
the todo extension could work, or just a convention like:

  .. include crufty-stuff-note.rst

might be good enough and not require an extension at all.

Thanks,

jon


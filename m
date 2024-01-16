Return-Path: <linux-kernel+bounces-27250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E7682ECC3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC3B1C22E05
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F6E134DE;
	Tue, 16 Jan 2024 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="E3gS2bMN"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B982F2F;
	Tue, 16 Jan 2024 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6913040E0196;
	Tue, 16 Jan 2024 10:30:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mj4K5dcD8jS1; Tue, 16 Jan 2024 10:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1705401047; bh=E4Ez32ndQTP3Vu6Vg2u9DClM5PdtbuOB5NaSMYbc0Ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E3gS2bMNSZzTXwC/sKZG2cRVK3AnhfVFfGeF6hoScXEQJoz2ExcFUY+C+KzgsVthd
	 b+WgEeAz/qoZCl/jSb4Tyvjr9B//Ynx12f5Wkn9q6jslbRzSx8OB3Hqhm43nelQbn3
	 H+Jdmu6cGK/DEsRqW4PnMIMDD1lPRi7M3TWsxeQfMytZSkNvYgevREUh/dmYEmItkx
	 Y8oXdH4vV/Es6KklLmAoSlav7zjH6jEpiPVBcuPRtAnIaUyEt1svSeI7rrqBpupx1e
	 Twq9TWl7Qopz8lm5HRWdoG0PnHsLs9q0udBfa4rhlgJmSvRzWISr01oSLoLxS6SW+g
	 QIbWQwUyYslGsV3UAc+wStNkpRN0pjizs1HqVJCkOo3pEyaLq6kwv3SIsztTiALzhZ
	 87AJ4sXPz4ko+RavjRApqNDJS7bQVovEkeZYY4VsW27W/fEt7kiamGmQF9vGPfn5ip
	 ODB/KJyL+kxpN5R7i1n71P6NVbcqEqQuEwk+Ha9EFjjxbWBvUztMQqimiLwfo4Evyt
	 U+Irb5yxIJcNQtdudi3CyUWFDP9Rz0uv/kX8wng3w8h2/CY2iX7SWQMQ9G/QdrvR/2
	 hISCa9Vl5T/xNJH8TfhAxbjmTGhOVBLiRE0Z3XUMLeAHYOozKICejWc7VV+Xdo8Iq1
	 5jJpNmtyGFySzwSiYgAYRs6c=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB89D40E01A9;
	Tue, 16 Jan 2024 10:30:30 +0000 (UTC)
Date: Tue, 16 Jan 2024 11:30:24 +0100
From: Borislav Petkov <bp@alien8.de>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Tong Tiangen <tongtiangen@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-mm@kvack.org, Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v4 0/3] minor improvements for x86 mce processing
Message-ID: <20240116103024.GAZaZawAABcEBAWFus@fat_crate.local>
References: <20240111135548.3207437-1-tongtiangen@huawei.com>
 <e453b190-d387-4b74-bb2c-fbbd2a5c488d@huawei.com>
 <20240115133354.GFZaU0Qk2lYmMSkwM9@fat_crate.local>
 <f431fa49-ebdd-4116-95d6-001b1c714109@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f431fa49-ebdd-4116-95d6-001b1c714109@huawei.com>

On Tue, Jan 16, 2024 at 09:14:56AM +0800, Kefeng Wang wrote:
> Oh, sure, we could resend after -rc1, thanks.

No, no need to resend after -rc1.

What you should do, instead, is take the time to read the text I pasted
more carefully and get acquainted with the development process:

https://kernel.org/doc/html/latest/process/development-process.html

and especially this:

https://kernel.org/doc/html/latest/process/submitting-patches.html#don-t-get-discouraged-or-impatient

In those pages is a wealth of useful information.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


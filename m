Return-Path: <linux-kernel+bounces-143688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 261F28A3C4B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 12:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4241F21C51
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66EE522A;
	Sat, 13 Apr 2024 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pxpgdLKO"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8432208B6
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713005369; cv=none; b=NBKbCq4P3bzBV0vQIE9yYfjDuFg1buyOF47YmCb4eloELG5DBJTuNT0WIHYTW4UzwHl9olR+q991vcv6KRopaueLZxgQYWbTHln0Ed3SDyoRyF6CK846zP7tvAEynzS/65K7ebOCELNlfGjyU9n2M5s2GbVeRWaoDY8ybUdX4QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713005369; c=relaxed/simple;
	bh=8ikedhSJn26YGGIQUYARbenr5fQ6p+qp34A7xNOjONo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CEEljWQQXPo5sJcGzDY/e9NmPpR5wUCcLIcXhDnfQWkNw5PiP+V2ASr2/htnxw1AHmWY0ICztz89hsld17q9e7HCSeOVVtsKhYiWLEkFS+pW7tUmC0DU5WP0YzD4pTqa+NfJQR7XU+6Akt/9jZtw8ajSvvGNCVik8fiiyfrYHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=pxpgdLKO; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4VGqtk0Ylmz9sTJ;
	Sat, 13 Apr 2024 12:49:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1713005358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wRGrx20qaxTfTav8oY1WT1NLMhax9e4c1ieS3RFQnwU=;
	b=pxpgdLKOYYVsr4/b3ezC7BU4ALFnYptXwo5EnikVmvVRywnQJUJXsNsj/sQ3BFM2ggg9Fc
	zpp6ls4XvbqvIUtPc+Pqtro8P67Nm6o3Yeo3KdXFMy2jf1QZt0QZWuU5rJUp9rjwiiGRj+
	02Y1zV/ANmRK+mtDH/OtSNMFxAD1N7z6D9cO3s0AEVzmYjRK4o3suI76065mEMXWr2qHQr
	VuTkTUERVCG+GqMi+RKYnuF4hv+orhitWDHpE8EuosXSCTjqrYpkef3c+dat+HFIWrC4sP
	QXMn0P0/1VQXjKMKtTk23fB3wbWBVf7KXgiugJjhk2FTv5lNpB3e7cdizpkOvw==
Date: Sat, 13 Apr 2024 12:49:01 +0200
From: Erhard Furtner <erhard_f@mailbox.org>
To: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Bagas
 Sanjaya <bagasdotme@gmail.com>, x86@kernel.org, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, jpoimboe@kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Breno Leitao <leitao@debian.org>
Subject: Re: [bisected] Kernel v6.9-rc3 fails to boot on a Thinkpad T60 with
 MITIGATION_RETHUNK=y (regression from v6.8.5)
Message-ID: <20240413124901.7f1a8e51@yea>
In-Reply-To: <68e3503c-5573-4d82-8fb0-5b955c212d67@leemhuis.info>
References: <20240413024956.488d474e@yea>
	<ZhpOIeVq1KQXzjBp@archie.me>
	<68e3503c-5573-4d82-8fb0-5b955c212d67@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: k3ssgyup1b4oybo1zmrkgh8m4j9pf3bb
X-MBO-RS-ID: e16be028c3858998bcc

On Sat, 13 Apr 2024 11:46:09 +0200
"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info> wrote:

> On 13.04.24 11:19, Bagas Sanjaya wrote:
> 
> There was an earlier report about this here:
> https://lore.kernel.org/all/78e0d19c-b77a-4169-a80f-2eef91f4a1d6@gmail.com/
> 
> Boris there suggested: "perhaps we should make
> CONFIG_MITIGATION_RETHUNK depend on !X86_32":
> https://lore.kernel.org/all/20240403173059.GJZg2SUwS8MXw7CdwF@fat_crate.local/
> 
> But that did not happen afaics. Would it be wise to go down that path?
> 
> Ciao, Thorsten

Ah I see. Well in my case it's no old P4 heater but a not that ancient T2400 Intel Core Duo with 31W TDP. ;)

But good to hear I would not need CONFIG_MITIGATION_RETHUNK anyhow? If that's the case depending on !X86_32 would make sense. Don't know whether the 32bit Intel Atoms (the only 'recent' X86_32 CPU left besides the Core Duo) would need this mitigation.

Regards,
Erhard


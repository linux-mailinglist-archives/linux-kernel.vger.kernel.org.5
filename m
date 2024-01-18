Return-Path: <linux-kernel+bounces-30358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FA6831DB5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88119B24DE5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD712C1A2;
	Thu, 18 Jan 2024 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aXW1HrGT"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4443424202;
	Thu, 18 Jan 2024 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705596082; cv=none; b=cC/klr3Zxdws/IDBXSSOxXEW4YFgR6/PGDf2BiDKZJrdtW6Wsy3fd0kdT/xC+MhG58H+peaDgevbwtifzk8tOoYFXVrhRMwu/PfPCw2P69lNn6R24SEZr8KDM4ElPgQVVUEPaqH7JLtmtYVeIzpEGddmYUfYydlWrttQYauH2jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705596082; c=relaxed/simple;
	bh=P1MeR1zFOZw1B/OR+J0If6ovz3/5tWaRhOuUFOQAhFU=;
	h=Received:X-Virus-Scanned:Received:DKIM-Signature:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qJs73KZWTCWVA9F223q42lvMGleUW09Yz1g0vewDP+nyqzHpQsS5P09/6wIj9Ya3+csO5ld5C8zdsuPHeeryGsN7IMVF+m1bhUapNn4prlX6K6oUbbU5Qof2cY0Wfhx9YSjWrvlkXlNs7g0mf5sV8ZBodjLqxhA5ZtGIEwy+/fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aXW1HrGT; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D319240E01B2;
	Thu, 18 Jan 2024 16:41:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dByASFGmiBxo; Thu, 18 Jan 2024 16:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1705596075; bh=ciR9F994n9Q/PzxRRfbN8xsWLVQEiqRt05MkXbtgAAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aXW1HrGTtqSlJiNn5eGJ01DHJa8sQWJqMhIqv9jSAJMF5RJF/6TL0SxctSNC6FP+b
	 yvdIIns3rxC+ERstAoh6lnknTr542L02xLtt9KVoFZaPpDVLWZ/mnX6wQMxTavaigZ
	 +F20yp8QHGMRFJ3cRK7Mie5GFYGkdN9iXi9pdxkxCo8UNkqzmLV0Gl35hzBi6EduhK
	 x4egfZ78RidHuQ+PM75V3IkgAfdZeQHkssV33EJN5ikTaIfyvBeToPAQdVc5Sw8Vi6
	 xGUvgZc/EpBkV6xEdfm3SqTGgTxAjxNn9fn2Pr2IY+1Q4rYJXU5SNUQZU0uM6g3KVH
	 5Tgb31igCiG2gFhoQG53nat2B37ONpaDYoR2A19McKeCH9HCL9woiBSc9OXIMexE/2
	 G0Fu1jaaN5//MUS91hLN6ESBda0m5ETF+L7zPESrRWAJneiCnfixIphXz2qjkLb+QD
	 vlxS6SI+JNBLwuzXipia0K8wDU1RI5MBoG+O39atV9k2ZEcKHLwQLHZZPwQazA79O9
	 q5wqqn/jn0Nwo5h9ApvmHEL6guCf1GRxFr/uP40p9xz8auzt6L9QwSWQ3BhqRdT3d8
	 RMwsIHW1WNxpS06BOzBcUFQ67H5sSYbPbRbRa9PPVUcRdsDgpXoyulAlUkHxpM0QBP
	 mMaJz42/Z3xgrtwL36f3vvtc=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E250F40E0196;
	Thu, 18 Jan 2024 16:41:08 +0000 (UTC)
Date: Thu, 18 Jan 2024 17:41:08 +0100
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Nikolay Borisov <nik.borisov@suse.com>, tglx@linutronix.de,
	x86@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Remove reference to syscall trampoline in PTI
Message-ID: <20240118164108.GIZalUpEnj2HT-9ix6@fat_crate.local>
References: <20231102130204.41043-1-nik.borisov@suse.com>
 <dd0e864d-295a-4edc-bfd7-ad5de88d7a0c@suse.com>
 <87edee1v0i.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87edee1v0i.fsf@meer.lwn.net>

On Thu, Jan 18, 2024 at 09:11:41AM -0700, Jonathan Corbet wrote:
> > Ping
> 
> Hmm...this has indeed languished for a while.  I was waiting for an ack
> from x86land, but I guess I'll just apply it unless somebody screams.

https://lore.kernel.org/all/170238995160.398.1051285467012003027.tip-bot2@tip-bot2

Jon wasn't CCed but Nik was.

Nik, you missed that tip-bot2 mail or you don't have it?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


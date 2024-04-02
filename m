Return-Path: <linux-kernel+bounces-128422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC62D895A9E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622121F22419
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17B6159910;
	Tue,  2 Apr 2024 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=otheo.eu header.i=@otheo.eu header.b="hOHZ4Y6x"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F12B15A4B4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 17:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078619; cv=none; b=Wm3Kj0aso/5M5FlT5pgy+P13GsILU2ojgQrg5dZrMKTpkZGd9mnmHq7gE12y6GC4ViJOGGyIuifb6cU1aS2G/ixQf8Zh/DzTfDV15/IO/EfceN9ci5W1nHsVzcMIVNU4Skoc1YyaHS2+QRHqtJZ0FKHoyFrTZWXAmN1PsYxpWjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078619; c=relaxed/simple;
	bh=fchfaQZYP2MJZUfO4FFw+8TUYa2A2P2dXgwtaEPnfjU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kgZI2eLUFdjgJZPIMw2PCMCRvlKHHW+ocydnam912hnzHZa+yew5+R7VhBv3AJe/00mKa8bL1VugRMGEZaFqM2BkAGUJr0whoGHGoa4Xsjt3XlBXVx/fsaTzZHLaxMvJBjqRQTK9MFORKkIy5wOyPgIWEh8Yr6ronLaghTfIyDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=otheo.eu; spf=pass smtp.mailfrom=otheo.eu; dkim=pass (2048-bit key) header.d=otheo.eu header.i=@otheo.eu header.b=hOHZ4Y6x; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=otheo.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=otheo.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3514D60002;
	Tue,  2 Apr 2024 17:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=otheo.eu; s=gm1;
	t=1712078609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zfYqrxZbMv6oz3XcY9yhpNbTQRSmFCP8VNd2l+T90+I=;
	b=hOHZ4Y6x+IyW4QeuzmuMgXRD9pwrTFPdQee1yAls05QWKL4mNmyRtCEhgqam1d/0/n5i0U
	MMg06WQYyUsRQH8FBEC1ZBznUAhEkoVvkWIAhDs/QCO8YIPmtpk//Qo1koL2kQWLSFL4uh
	jIpq6qnkK882Hf3CFLK05gHtWu4qA4Df2QxSE03mvpsjNlqI4YML2jUz9oxc9uaiE4oY9D
	KkoL7B3p8YqTv6w/frgCKX+LqHZlmsO4e0iy62JYnNCaYCMGTsP5ouTzRTkvcve348YJbZ
	LqVl5uJBl6DqL2nJeWkuomwMd2rGXIwgLy9EiBZIYjh8Wufmmhz/+T254U6ilQ==
Date: Tue, 2 Apr 2024 19:23:14 +0200
From: Javier Pello <devel@otheo.eu>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
 <hpa@zytor.com>
Subject: Re: [PATCH 1/1] x86/mm/pae: Align up pteval_t, pmdval_t and
 pudval_t to avoid split locks
Message-Id: <20240402192314.a9b4e05637444314f47557e4@otheo.eu>
In-Reply-To: <8ee463af-fdbf-4514-bb6e-bf2fd61fbc06@intel.com>
References: <20240401185451.6897208962d3fc47a12ffb5a@otheo.eu>
	<20240401185712.a80deeb2fddeded0ad42cc04@otheo.eu>
	<8ee463af-fdbf-4514-bb6e-bf2fd61fbc06@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; i686-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: #01#@otheo.eu

On Mon, 1 Apr 2024 10:56:14 -0700 Dave Hansen wrote:

> First of all, how is it that you're running a PAE kernel on new,
> 64-bit hardware?  That's rather odd.

I got this motherboard and cpu fairly recently to replace old
hardware, and I just plugged my old hard disk and went along with
it, because I did not feel like bootstrapping a 64-bit system.

> The case that you're hitting is actually an on-stack pmd_t.  The
> fun part is that it's not shared and doesn't even _need_ atomics.
> I think it's just using pmd_populate() because it's convenient.

I see. So just annotating the variable on the stack with
__aligned(8) should do it? But the code is under mm/, so it should
be arch-agnostic, right? What would the correct fix be, then? I take
from your message that using atomics through pmd_populate() here is
not needed, but what accessors should be used instead? I am not
familiar at all with this part of the kernel.

> I'd honestly much rather just disable split lock support in 32-bit
> builds than mess with this stuff.  You really shouldn't be running
> 32-but kernels on this hardware.

Why? Is it unsupported? The hardware runs fine, it is just a choice
made by the kernel to crash a task if a split lock is detected in
kernel mode, but I do not see any technical reason not to fix the
split lock. Disabling split lock detection would not make the split
locks go away, they would just go unnoticed instead.

Regards,
Javier


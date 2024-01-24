Return-Path: <linux-kernel+bounces-37597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3A183B253
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F721F244CE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD56132C26;
	Wed, 24 Jan 2024 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0J7DdVlj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="58F68lhJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDBA132C20;
	Wed, 24 Jan 2024 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706124855; cv=none; b=bNgNtQmlC8NH61F6KULXbTmJX5ySsmUnJxN9aB6Z2n5jCWktJN1oXM3drTwi+hyFzJ9yYtjofupGboONCDyv50H6zEOUzili9Ks8va0RIHl6CFAnBk48gKjkx821kSaarFnBTSIedM77eZVI6Eq1fesPM4yb8lm3Uio5gQcuIH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706124855; c=relaxed/simple;
	bh=GYJFXfXsIOPeYbximf1oUJWFqHQl+GwEjV9Ni5wP+aI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dreadp43JZc57WBVTqDUKPyRn6+h/Uoh/h78RJotFdxPJHiaAnx2LioujTTnThGtF/lX7/Hu6qBXdFCm9Vck8ILlTpHCa0SF6tSczXhrj5EA/7LuHe2npSwnMoj3sL8pdEx9rjPig0vu8wxDCOavqygfborik2Sx8G8upvUCizI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0J7DdVlj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=58F68lhJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706124852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FAg534iwdS91fkdcXs5EMfhsi34lrsD1PSWyXPhB5Ok=;
	b=0J7DdVljP8JzWt5Vt3UVPXhNxvShFJTnmQ+om8AydJjMB1tBLUj5foOh9xkkOjWVUnnRk0
	HAGF0VndthdlWYK3fYrehQhRpGC9gCF+g4PPbsx0cGMHrRK9mPfvlP763tf86ZYqM9wmaY
	fFMivweskdhGOFmlrASRLLhc2XEv7DCGl9xBse+GyGPc4yXXPkttctqjAm7GcnH06Pzszf
	cNCqGAPnXcS/nZI35xTK+zFiioFXZiDwamSOfoSyQOub6GPEZgjnkA13vllMdmKIwJ6D+e
	9tDfRJ3610hqVmE78wRZRa1ZS6QbDvCsoIMQTd4He0JbNqw7LJxuugQ9yHBvEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706124852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FAg534iwdS91fkdcXs5EMfhsi34lrsD1PSWyXPhB5Ok=;
	b=58F68lhJ9TrKiArwgXOJMl6V5qF2nE+HAOpa9PicsDQDPZiMMfTSX2bUtRXbIIAADOMM8v
	PFQnYw/vtKQnjWCA==
To: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 75/82] timekeeping: Refactor intentional wrap-around test
In-Reply-To: <20240123002814.1396804-75-keescook@chromium.org>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-75-keescook@chromium.org>
Date: Wed, 24 Jan 2024 20:34:11 +0100
Message-ID: <87sf2mjzkc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jan 22 2024 at 16:27, Kees Cook wrote:

> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
>
> 	VAR + value < VAR
>
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
>
> Refactor open-coded wrap-around addition test to use add_would_overflow().
> This paves the way to enabling the wrap-around sanitizers in the future.
>
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: John Stultz <jstultz@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>


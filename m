Return-Path: <linux-kernel+bounces-72744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 777D285B83C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FAB8B291DB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD6B657B8;
	Tue, 20 Feb 2024 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IjsUhLVg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nPZxbWcN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057226166E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422652; cv=none; b=TM0Ya3wU352WjTkn0IOuVcfSW2Y2S0RknnAGSJQL7R9NVciQn75TZGFnUS6CSPli07anFNMe15YfGA2YQ0rtr1SapcOTtc/L71g9CWJBfCEYROMajCismfRgw4N+yutGehTLHPxQpUVhZx2diDkzbEuEAZ6nam9Cha9Mx0rxmE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422652; c=relaxed/simple;
	bh=6uL3PtxMqVgWbjldzCkLF9nagygKfjjFl81KBs8RfWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h5z8rVTEIL3az78gcXfI+oVF1tmZgacGB8lkhJBGhCdG/SmrnGBD04uOmM21ERTVZqOf3Axh6ATwHvcYBnCh0qAY0ddQCao67Po5YrYSdFAbft3tUrdFwfXs8gV0NBeeW5h3UqDU/Qmb/J2+veSCnnXbodysmOa8buMfg5+2AoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IjsUhLVg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nPZxbWcN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708422649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ce2PU+R+JYCOoRGSJQxTM3NSkVh6mPPXni2mzU33aI=;
	b=IjsUhLVghFuZEVYQ1zE07oVcuQONTsQYuhHdLprETrNxABJURW2p4p4LaLbJBBPB+mbiBP
	sez8E4G78+c9Tq6NADHU5RnNJzwidEtTLku2QlfzEC8eXoE11FSUwVOKR7OefY5NINpXQE
	A9zSzysxsb/SjqCxCTf7nziPVBdn8nclivP5g423OEPEKaHYnXDum+HtiPdsJow+CdGBKO
	Ki8Mr3nwIXWEBEmsmZhGbMFs756qUuVvFwtaFiNR64yPqQyMkyK8AsnP31JwTSHwQg6Vxl
	3aW/wUJWLauyZTXYFUYL4pepFFOYaif29KeiAFsnh0A8Glrbl+mnALjO9DSQuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708422649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ce2PU+R+JYCOoRGSJQxTM3NSkVh6mPPXni2mzU33aI=;
	b=nPZxbWcN7lQapNrhnn8vWhnqUdcWPeY274NdfjYtV3cYsjaCxuR24F/ZkUy4MjyWl64uU3
	6BwEJ4k6bRb3M2DA==
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>
Subject: Re: [PATCH 00/10] vdso: Misc cleanups and prevent code duplication
In-Reply-To: <202402191625.BAD1F3CE6@keescook>
References: <20240219153939.75719-1-anna-maria@linutronix.de>
 <202402191625.BAD1F3CE6@keescook>
Date: Tue, 20 Feb 2024 10:50:48 +0100
Message-ID: <87bk8b5urr.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kees Cook <keescook@chromium.org> writes:

> On Mon, Feb 19, 2024 at 04:39:29PM +0100, Anna-Maria Behnsen wrote:
>> Hi,
>> 
>> the vdso related cleanup queue contains two parts:
>> 
>> - Patch 1-3: Misc cleanups related to a comment, a superfluous header
>> 	     include and ifdeffery
>> 
>> - Patch 4-10: The union vdso_data_store is defined in seven
>>   	      architectures. Make this union available in a generic vdso
>>   	      header file to prevent code duplication and fix the
>>   	      architectures one by one to use the generic vdso_data_store.
>> 
>> Thanks,
>> 
>> 	Anna-Maria
>
> I do love a good clean-up! Thanks for this, I looked through all the
> patches and they seem correct to me;

Thank you! I had a mistake in there and already posted a new version for
this single patch - I forgot to update this patch before posting...

> removed definitions are all
> identical, and __page_aligned_data is kept where needed.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> -Kees

Thanks,

	Anna-Maria



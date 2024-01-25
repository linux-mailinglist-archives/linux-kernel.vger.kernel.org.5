Return-Path: <linux-kernel+bounces-38575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA9B83C270
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C10290BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F52545BF4;
	Thu, 25 Jan 2024 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZTecDcXn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4g/Gm7EO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6614A36B10;
	Thu, 25 Jan 2024 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706185262; cv=none; b=bObCPG4fGgwvNK6+a9FbrV5iOMXS27Xp3aEEoUZhWuNHmceTuDb000YIzu0LFSosIa/OaVyQh4q98xc4uvcLE58NCvGtt5cTm+CnbUaeVUbmd6XBNZ0oLJNQDUvS583dvbPlBd6Upd/eM4jEwBMCPLQJcfnm9aEdYwmrhwxTw3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706185262; c=relaxed/simple;
	bh=9hK3wbpzvoGpXxkg63yw+an8DBrzwNCWA2v8juGch3w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P7zYIWs7umorKGwVT9EbRJ7rHoSwS9cr2ZVkRT1N3jtSFdVujlCQxepVFXGdZTal4bQX3yyiH7s3CL3DZzWVR23BaHMjZeNdwRz9TDqFYNmiTdZMpbKlveDIC/OWce7jYGssIoyDJfvLd3+HvRl8fJrpTgPt4G85Qm/6ZDYed2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZTecDcXn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4g/Gm7EO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706185259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bqg+mquOinJ4OKCmburGkNL+d8LFRf+39AvL3I+HFbE=;
	b=ZTecDcXnkpjUJQDnAUhCLvwoIDKfhZjVituNSeEyH2tgpXiJMCmX61k2aHHWdRPNXcm7mc
	vQGvwB33+nck0Ghty9ZxzXdz+QBhmQuk21lNfNE9VyLqGnZ8BtBEYU2I33dbZAFS+2bRdQ
	4Do1jSSgUrVx0KtVOtbMDzsDlv0L2qUYtp9EKgXWHFCH+TYVEDfMiCHM8evq5poyU52lg4
	Nhm61UR+dwiy9TZzYyeq+lOvuljAxwdzQ9EWr1vbbDQAsvrTUe87nyXrJXCH47+PRnT2IJ
	zrRD2z3qH5OgM24Rs7WRpHTL652Y+8+s48cuzlIwEfbKgt6hdHl6WaNF6vt0zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706185259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bqg+mquOinJ4OKCmburGkNL+d8LFRf+39AvL3I+HFbE=;
	b=4g/Gm7EOchq4t21bamlUoxE1QxJYdrdK4fkAYJiLriVkwNABnIOh2k1Bf+ITSHCj4nmzrC
	hQyK0mM4Pom23JAw==
To: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, John Stultz <jstultz@google.com>, Stephen Boyd
 <sboyd@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Clemens Ladisch
 <clemens@ladisch.de>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/8] include/hrtimers: Move hrtimer base related
 definitions into hrtimer_defs
In-Reply-To: <87plxpkesh.ffs@tglx>
References: <20240123164702.55612-1-anna-maria@linutronix.de>
 <20240123164702.55612-2-anna-maria@linutronix.de> <87plxpkesh.ffs@tglx>
Date: Thu, 25 Jan 2024 13:20:58 +0100
Message-ID: <87h6j1d2ol.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, Jan 23 2024 at 17:46, Anna-Maria Behnsen wrote:
>> hrtimer base related struct definitions are part of hrtimers.h as it is
>> required there. With this, also the struct documentation which is for core
>> code internal use, is exposed into the general api. To prevent this, all
>> core internal definitions and the related includes are moved into
>> hrtimer_defs header file.
>
> Shouldn't this simply move to kernel/time/... ? Nothing outside of it
> needs hrtimer_base

hrtimer_expires_remaining() which is defined in include/hrtimer.h
dereferences hrtimer_clock_base; hrtimer_is_hres_active() also defined
in include/hrtimer.h needs hrtimer_base.

Thanks,

	Anna-Maria



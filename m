Return-Path: <linux-kernel+bounces-36916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFCB83A8A2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2D71F249A2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B10B60DF9;
	Wed, 24 Jan 2024 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rABzFyZf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eDXqHNek";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rABzFyZf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eDXqHNek"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C6560DE6;
	Wed, 24 Jan 2024 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097598; cv=none; b=PwrEk+Cvoo0h8zfgpx1R97m014CLJ/CvXM6t4zSPGJbd9KXKJX/6Cu21pHPGl6cDmJitvaAVTw+BXn5bnTJXgVmJnqsp8bGWSBC7qtLvoZl0n2SVJUICjF3Xi6xAEiYMKzrQQYZgjniLp2LqJvhR1YGbS5wWbbeW/fAztjGoHMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097598; c=relaxed/simple;
	bh=JvuIjypDvkkdN9ibt0BBKV8d8snZJ5FLk81yKrdEgSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dUofORVlBQVK3t8pJ+tbzNguJhowbq9wDrg3hyE943he3LJ7obZ8vEGhtB4Ct8FpWofvSmQDBCf5IqXu7Ab4/KUV6eusr0RrjpPiPnVBDMHnZXetKDljxJuUWqf5QWE4ihnwearsd0qAAUiQ92cLaH84ouK7LDsXfwQHI3IJ7VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rABzFyZf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eDXqHNek; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rABzFyZf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eDXqHNek; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
	by smtp-out1.suse.de (Postfix) with ESMTP id 0F7CC222F1;
	Wed, 24 Jan 2024 11:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706097595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZVqt4zJTdAbKIcvjcw57N6juLTvcK2zWsqCYdTEkzE=;
	b=rABzFyZfdgfGTIN6EqHqjzCwkFbrZGeYaR23huV2qj1Y1POshzhbj2fcHtpQiUOa3eEzwK
	DFb1i4OKJBR2vBJeiGOBztSPd+CpmsP9Duf8DCYe2acUDT89VCLKzA2odd8Cm0eGjYOwf3
	8etjhPdCq56aTIeWCJmvV0pnAsGV5g8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706097595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZVqt4zJTdAbKIcvjcw57N6juLTvcK2zWsqCYdTEkzE=;
	b=eDXqHNek1XSv/H1vmu8SrDWDhmtIaJ4kuylg7jvmq0lh8t75j3VboHCzSfgG6yC2Kg8/TF
	6CgGhucIQjkbrICQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706097595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZVqt4zJTdAbKIcvjcw57N6juLTvcK2zWsqCYdTEkzE=;
	b=rABzFyZfdgfGTIN6EqHqjzCwkFbrZGeYaR23huV2qj1Y1POshzhbj2fcHtpQiUOa3eEzwK
	DFb1i4OKJBR2vBJeiGOBztSPd+CpmsP9Duf8DCYe2acUDT89VCLKzA2odd8Cm0eGjYOwf3
	8etjhPdCq56aTIeWCJmvV0pnAsGV5g8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706097595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZVqt4zJTdAbKIcvjcw57N6juLTvcK2zWsqCYdTEkzE=;
	b=eDXqHNek1XSv/H1vmu8SrDWDhmtIaJ4kuylg7jvmq0lh8t75j3VboHCzSfgG6yC2Kg8/TF
	6CgGhucIQjkbrICQ==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id E7C9E4A04B3; Wed, 24 Jan 2024 12:59:54 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Xi Ruoyao <xry111@xry111.site>
Cc: linux-mips@vger.kernel.org,  linux-kernel@vger.kernel.org,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>,  libc-alpha@sourceware.org
Subject: Re: Strange EFAULT on mips64el returned by syscall when another
 thread is forking
In-Reply-To: <75e9fd7b08562ad9b456a5bdaacb7cc220311cc9.camel@xry111.site> (Xi
	Ruoyao's message of "Wed, 24 Jan 2024 18:42:30 +0800")
References: <75e9fd7b08562ad9b456a5bdaacb7cc220311cc9.camel@xry111.site>
X-Yow: ...It's REAL ROUND..  And it's got a POINTY PART right in the MIDDLE!!
 The shape is SMOOTH..  ..And COLD.. It feels very COMFORTABLE on my
 CHEEK..  I'm getting EMOTIONAL..
Date: Wed, 24 Jan 2024 12:59:54 +0100
Message-ID: <mvmplxraqmd.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.42
X-Spamd-Result: default: False [-1.42 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.01)[-0.038];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.31)[75.41%]
X-Spam-Flag: NO

On Jan 24 2024, Xi Ruoyao wrote:

> Now I'm suspecting this might be a kernel bug.  Any pointer to further
> triage?

Is this a regression?

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."


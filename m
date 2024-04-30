Return-Path: <linux-kernel+bounces-163973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 257A88B76B9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFDDA1F23045
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D32917166A;
	Tue, 30 Apr 2024 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OIL2DXpZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oexfdXF7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OIL2DXpZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oexfdXF7"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E7D171652;
	Tue, 30 Apr 2024 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714482951; cv=none; b=ggDynkErimkRhL/VYTwXFkN5FmdvUKSjgV9GlXl4nlJKWhGRfxj2G8KkBb5AXrCUJTAk4VsabRMarALCFMOXpS1xMThni5h88btE6vY1HKK20kN5d2e9VAEb91eLnilPxCu/7Cv/Cq45l8KnBl6r6ZYnL6/DwdxznK63oM7yNq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714482951; c=relaxed/simple;
	bh=NHFBbVYd6TqTEjk1e1f5A0cfaZCmIdAdIEDCn7WWWAo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ca1LgeroFt06ADejHXbnjU5m/4qh9BI3nEjSgXLMen3CxTYqHSysvNqkl30kLEUw7FCOaU7Ec3/5O4NWMzZzeYlqGLlKF45lXoIgLH3zBtHXGHPjJBC6JdATVf0pL5L9dLwVkqLSTdmiIUOeu+cT8tDW1SEMNWZuLWZmyRI0OV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OIL2DXpZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oexfdXF7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OIL2DXpZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oexfdXF7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from knuth.suse.de (unknown [10.168.5.16])
	by smtp-out2.suse.de (Postfix) with ESMTP id 076FA1F7E0;
	Tue, 30 Apr 2024 13:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714482948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlpGECdT+c9Qy7blIqpDlDNH0IDa2wwkY1+icJBCQMk=;
	b=OIL2DXpZNEEr94TEdAEsTW+iMBzmiTO9VnD6nOFODgHkwRxxoHq24SfX6kL0qLP7vlgftN
	wAjIUajMIn7FeGki1yYE4869OcpjvHFb5DhAsycun9cdCrLRtbkJgnY1BRSUV9wNv3NhpV
	i5VWL01zMFDJSRreMkpELzYrKr9myRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714482948;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlpGECdT+c9Qy7blIqpDlDNH0IDa2wwkY1+icJBCQMk=;
	b=oexfdXF7vxm3RzDmBdVyDlQ8D/V34MIirTD8A51WKZ6+GUod+mTvf3j2u9UWF42DDLhxsW
	v2lFFNNwUqXhiyCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714482948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlpGECdT+c9Qy7blIqpDlDNH0IDa2wwkY1+icJBCQMk=;
	b=OIL2DXpZNEEr94TEdAEsTW+iMBzmiTO9VnD6nOFODgHkwRxxoHq24SfX6kL0qLP7vlgftN
	wAjIUajMIn7FeGki1yYE4869OcpjvHFb5DhAsycun9cdCrLRtbkJgnY1BRSUV9wNv3NhpV
	i5VWL01zMFDJSRreMkpELzYrKr9myRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714482948;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlpGECdT+c9Qy7blIqpDlDNH0IDa2wwkY1+icJBCQMk=;
	b=oexfdXF7vxm3RzDmBdVyDlQ8D/V34MIirTD8A51WKZ6+GUod+mTvf3j2u9UWF42DDLhxsW
	v2lFFNNwUqXhiyCw==
Received: by knuth.suse.de (Postfix, from userid 10510)
	id EC48A3506FA; Tue, 30 Apr 2024 15:15:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by knuth.suse.de (Postfix) with ESMTP id DCD2C3506F9;
	Tue, 30 Apr 2024 15:15:47 +0200 (CEST)
Date: Tue, 30 Apr 2024 15:15:47 +0200 (CEST)
From: Michael Matz <matz@suse.de>
To: Jiri Slaby <jirislaby@kernel.org>
cc: Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb+git@google.com>, 
    linux-kernel@vger.kernel.org, x86@kernel.org, 
    Ard Biesheuvel <ardb@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
    Nick Desaulniers <ndesaulniers@google.com>, 
    Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
    Song Liu <song@kernel.org>, Ricardo Ribalda <ribalda@kernel.org>, 
    Fangrui Song <maskray@google.com>, Arthur Eubanks <aeubanks@google.com>, 
    stable@vger.kernel.org
Subject: Re: [PATCH] x86/purgatory: Switch to the position-independent small
 code model
In-Reply-To: <4ce6cf96-685d-4792-b2fd-949c07eff707@kernel.org>
Message-ID: <5199b4f0-b4c7-5ef4-e8b7-0ade7c533edd@suse.de>
References: <20240418201705.3673200-2-ardb+git@google.com> <3f23b551-4815-4a06-9217-ff5beeb80df2@kernel.org> <20240420131717.GAZiPAXY9EAYnHajaw@fat_crate.local> <836c267f-a028-acce-8b19-180162a5febc@suse.de>
 <4ce6cf96-685d-4792-b2fd-949c07eff707@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.81 / 50.00];
	BAYES_HAM(-2.61)[98.29%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.989];
	RCVD_NO_TLS_LAST(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TAGGED_RCPT(0.00)[git];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Spam-Score: -3.81
X-Spam-Flag: NO

Hello,

On Tue, 30 Apr 2024, Jiri Slaby wrote:

> >> Interesting. I thought gcc doesn't have problems here yet and was
> >> talking to Matz on Thu about it and it seems he's forgotten about his
> >> statement too that "you should simply stop using -mcmodel=large.  Noone
> >> should use it." :-)
> > 
> > It may be so ingrained in my brain that I'm not _always_ saying it when
> > talking about the large code model over a beer.  And indeed I know of no
> > particular problems with it vis GCC,
> 
> Of course you do :).

:-P

> That bsc#1211853 I linked earlier. I.e. gcc-13 +
> -fstrict-flex-arrays=3 + -mcmodel=large + some asm() expecting __FILE__ to be
> constant (not true with the large model).

"asm() expecting $whatever" - clearly a user problem, not a GCC problem 
;-)


Ciao,
Michael.


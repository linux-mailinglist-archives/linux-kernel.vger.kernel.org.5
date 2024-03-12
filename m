Return-Path: <linux-kernel+bounces-100062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A486687914D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8C81F23100
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9AD7A153;
	Tue, 12 Mar 2024 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Wq2U1NiO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Wq2U1NiO"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC047A138
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236741; cv=none; b=U2vBJkt4vQctkt7hIczDqngkGKWTQBpEaMDSVJc/9S4UAEqCI5Yq5PE6j+MoDr5L51vO3yBXhu6+wiXsP7wxxmh7tyN0twjSYA8lUZyqo8LWOKiQF0WaYmRyf8Vsjxtw6EVBuyrHkP9ApiolFKNiiUJ2ssNkuVCu5vv/pHE+Czw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236741; c=relaxed/simple;
	bh=8syJj9O3IpoC/00hQgPB37CF1da+xjbZE3+OEUvf2pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSSH0OJD1dqhD77Mm769aE7Weq6/w3YaXxvM5XYIN35eBijnewmEAJL5zbSzGCdmiOU6Kdpc++S2eoc16Yyj9G45zoM4I847BQsWtNdmwQvNWFmC08QFwZwfhXvfIjlHLQiPgsv8dCBBpKWXWa36Cs2o4cRCuxKPMDghY5rEcKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Wq2U1NiO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Wq2U1NiO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 52DE0374F3;
	Tue, 12 Mar 2024 09:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710236737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6BvqYAABenQtEOY6SUistWw/deEtLBmFUFhvqQvD7vc=;
	b=Wq2U1NiOGJeMVXZMbbp8FJsHP/ULlZ5UtN2xnwLHB58knMX8lFgVdzBylRe0qWNa3U0p4K
	lzOhcZTZHgK1W1ot9/jm0jq1fI0yc0b8Ep1Bw03HTMLRGAJfYNG2lG60Tt4S+JyBLKdRPZ
	YLNaMZC+rwaA1DoLXhzokQL3U7mATL4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710236737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6BvqYAABenQtEOY6SUistWw/deEtLBmFUFhvqQvD7vc=;
	b=Wq2U1NiOGJeMVXZMbbp8FJsHP/ULlZ5UtN2xnwLHB58knMX8lFgVdzBylRe0qWNa3U0p4K
	lzOhcZTZHgK1W1ot9/jm0jq1fI0yc0b8Ep1Bw03HTMLRGAJfYNG2lG60Tt4S+JyBLKdRPZ
	YLNaMZC+rwaA1DoLXhzokQL3U7mATL4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 386631379A;
	Tue, 12 Mar 2024 09:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B4c3CkEk8GXFPAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 12 Mar 2024 09:45:37 +0000
Date: Tue, 12 Mar 2024 10:45:28 +0100
From: Michal Hocko <mhocko@suse.com>
To: Lee Jones <lee@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, cve@kernel.org,
	linux-kernel@vger.kernel.org,
	Joel Granados <j.granados@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2023-52596: sysctl: Fix out of bounds access for empty
 sysctl registers
Message-ID: <ZfAkOFAV15BDMU7F@tiehlicka>
References: <2024030645-CVE-2023-52596-b98e@gregkh>
 <Ze68r7_aTn6Vjbpj@tiehlicka>
 <Ze9-Xmn8v4P_wppv@bombadil.infradead.org>
 <20240312091730.GU86322@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312091730.GU86322@google.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Wq2U1NiO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_SHORT(-0.19)[-0.953];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.10)[95.61%]
X-Spam-Score: -5.10
X-Rspamd-Queue-Id: 52DE0374F3
X-Spam-Flag: NO

On Tue 12-03-24 09:17:30, Lee Jones wrote:
[...]
> > Backporting this is fine, but wouldn't fix an issue unless an external
> > module had empty sysctls. And exploiting this is not possible unless
> > you purposely build an external module which could end up with empty
> > sysctls.

Thanks for the clarification Luis!

> Thanks for the amazing explanation Luis.
> 
> If I'm reading this correctly, an issue does exist, but an attacker
> would have to lay some foundations before it could be triggered.  Sounds
> like loading of a malicious or naive module would be enough.

If the bar is set as high as a kernel module to create and empty sysctl
directory then I think it is safe to say that the security aspect is
mostly moot. There are much simpler ways to attack the system if you are
able to load a kernel module.

> We know from conducting postmortems on previous exploits that successful
> attacks often consist of leveraging a chain of smaller, seemingly
> implausible or innocuous looking bugs rather than in isolation.
> 
> With that in mind, it is still my belief that this could be used by an
> attacker in such a chain.  Unless I have this totally wrong or any of
> the maintainers have strong feelings to the contrary, I would like to
> keep the CVE number associated with this fix.

No, no real strong feelings but I have to say that I find a CVE more
than a stretch. Kernel modules could do much more harm than just abuse
this particular bug.
-- 
Michal Hocko
SUSE Labs


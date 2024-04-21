Return-Path: <linux-kernel+bounces-152512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156B78ABF96
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 16:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6519281792
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 14:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83B717C98;
	Sun, 21 Apr 2024 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pOFcRuuY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6Rhc+mKD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pOFcRuuY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6Rhc+mKD"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A861759F;
	Sun, 21 Apr 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713709634; cv=none; b=AJ37XfYJTXeJQ5rU+NDXlmjZ0k9peypTv6qeXzo1MRt0ovFjuvWxVHVY0wDiNwZY2XIxA/fy8aqcKs7hYuABZaEaKZ57/8g//N4S3naWKXIH819jYStkKoRwvKVyVOLfQ98arqlBeSgTShRwHNM0KYHsMk4GNZQReCpsUVqXYlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713709634; c=relaxed/simple;
	bh=aqbS0vEl6bLGOGfGGg/hrhlfxJwAKBY6mekA+zZFyu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iV0pH45F/mWhq9AChxl5oMXTt6QlUpzfC0hnM5xYZXrDv6rhNVCw6+H1UCPL4/ngFjP5fezGjQrKf9gRCxBckJOhBpoNYrqj84blklb+OwE0h9NHzfsD/g8yYqRzWPNwrMxJ+PdQjq4j4mkAFSPlLPyrM7stN3/61BqRQUqW/zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pOFcRuuY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6Rhc+mKD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pOFcRuuY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6Rhc+mKD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 752C733FA3;
	Sun, 21 Apr 2024 14:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713709624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=agFFagNCBR8vevRnpCC3TUjBPZuVAYsvS5pMWBbe2D0=;
	b=pOFcRuuYRhCgB5S3kNgXRAupliBmJ8li3NbbytjvLStPn42oaDteYpALhfLZYzvJz0OuSb
	5ZS5bdXrD9WFrKi2fUi/3dSyc5JqYL/H51MKLqUXmbD5Az38gAi3rUg+5W5pt5w/x2iTCt
	xABoBUuCC4zcA7DIfjJe124ATr4vVzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713709624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=agFFagNCBR8vevRnpCC3TUjBPZuVAYsvS5pMWBbe2D0=;
	b=6Rhc+mKDtMttLBgyNVpGvZUa+yys848SgC83jo0AESUujnkEBv8KAqLDSnuU6cVgI0sGnw
	bUkx872CYEGDoQBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pOFcRuuY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6Rhc+mKD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713709624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=agFFagNCBR8vevRnpCC3TUjBPZuVAYsvS5pMWBbe2D0=;
	b=pOFcRuuYRhCgB5S3kNgXRAupliBmJ8li3NbbytjvLStPn42oaDteYpALhfLZYzvJz0OuSb
	5ZS5bdXrD9WFrKi2fUi/3dSyc5JqYL/H51MKLqUXmbD5Az38gAi3rUg+5W5pt5w/x2iTCt
	xABoBUuCC4zcA7DIfjJe124ATr4vVzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713709624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=agFFagNCBR8vevRnpCC3TUjBPZuVAYsvS5pMWBbe2D0=;
	b=6Rhc+mKDtMttLBgyNVpGvZUa+yys848SgC83jo0AESUujnkEBv8KAqLDSnuU6cVgI0sGnw
	bUkx872CYEGDoQBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 514BD13687;
	Sun, 21 Apr 2024 14:27:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4zmzETgiJWZoYgAAD6G6ig
	(envelope-from <iluceno@suse.de>); Sun, 21 Apr 2024 14:27:04 +0000
Date: Sun, 21 Apr 2024 16:26:59 +0200
From: Ismael Luceno <iluceno@suse.de>
To: Julian Anastasov <ja@ssi.bg>
Cc: linux-kernel@vger.kernel.org, Firo Yang <firo.yang@suse.com>,
	Andreas Taschner <andreas.taschner@suse.com>,
	Michal =?utf-8?Q?Kube=C4=8Dek?= <mkubecek@suse.com>,
	Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH] ipvs: Fix checksumming on GSO of SCTP packets
Message-ID: <ZiUiM1tlM3smXSsR@pirotess>
References: <20240418144434.16407-1-iluceno@suse.de>
 <fd234180-4d6f-313a-0edd-13c821bd4423@ssi.bg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd234180-4d6f-313a-0edd-13c821bd4423@ssi.bg>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.08 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.07)[62.34%];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 752C733FA3
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.08

On 21/Apr/2024 14:01, Julian Anastasov wrote:
<...>
> 	Thanks for the fix, I'll accept this but skb_is_gso_sctp()
> has comment for pre-condition: skb_is_gso(skb). Can you send v2
> with it?

Thanks; sent!

> 	I'm guessing what should be the Fixes line, may be?:
> 
> Fixes: 90017accff61 ("sctp: Add GSO support")

This seems like the right one.

> 	because SCTP GSO was added after the IPVS code? Or the
> more recent commit d02f51cbcf12 which adds skb_is_gso_sctp ?

That doesn't seem related at all.

Do we need to check .gso_type in cases like this?


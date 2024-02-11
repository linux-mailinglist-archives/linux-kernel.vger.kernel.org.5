Return-Path: <linux-kernel+bounces-60950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7FB850B7B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC641C21A47
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597F75DF03;
	Sun, 11 Feb 2024 20:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MyXTaJiR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J7a71SOP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MyXTaJiR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J7a71SOP"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F35915F
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 20:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707684089; cv=none; b=UKrLUxKNwasV4VQ97NJJD1gO4yYk6tEcJcDt0Xr9/HX4n0iO7u2PXHRQZ26/xmuy8Dknjaks96kp4C2IgNSVsb4XrozCFDBehjoosazdAp8mESGeRrc5/rnUMbdAkm5JkSib5uXfk5uBVRL3RGhLVT1GOXy1Mi7WQevBNwjahCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707684089; c=relaxed/simple;
	bh=KeeJC2cmwuE1J/AWaVxDn8o/BCU/xBQsmqmcsSzDR7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbWWJlhobcfnovL6fhKJ9Nppt0zbkwjbhmBC78OolIi9LAv0HrkgJAjalWKJCYX9TWUVunA/XIcdU1V6EP7mzHYhZstZo2nG3nR8MNid1j3LQn9ydRxojtcoNcHI9Vz83lYDVXKZttRgBAjViKixGEGnzi6xb4+azFA1pwJdFu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MyXTaJiR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J7a71SOP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MyXTaJiR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J7a71SOP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 91288210F5;
	Sun, 11 Feb 2024 20:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707684085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WcBULlLtnxtGKkTdBEx595CYX4r6oCzp34j9F9t8PSI=;
	b=MyXTaJiRalkoTp+bf2JxHPLrBfP+1XwD2SH3prRHwpdfV85NcIemiGwR0kGjvn/ASCKU13
	+D2A82g10t2f/1vQg13JRozSsix2lru7XfugMSrTcfAmZISuFoeVUCeE77cBU2l+czmtHk
	RSXzQyqzLGy76dabmlruUjeBk9orNsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707684085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WcBULlLtnxtGKkTdBEx595CYX4r6oCzp34j9F9t8PSI=;
	b=J7a71SOPBbU5a015CX+2Ux6ut3dh/FRXuGG88uKovPInErFi3bWcHrUj6fHtSMIbvRHBMj
	hcXz/beBwt8QzXDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707684085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WcBULlLtnxtGKkTdBEx595CYX4r6oCzp34j9F9t8PSI=;
	b=MyXTaJiRalkoTp+bf2JxHPLrBfP+1XwD2SH3prRHwpdfV85NcIemiGwR0kGjvn/ASCKU13
	+D2A82g10t2f/1vQg13JRozSsix2lru7XfugMSrTcfAmZISuFoeVUCeE77cBU2l+czmtHk
	RSXzQyqzLGy76dabmlruUjeBk9orNsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707684085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WcBULlLtnxtGKkTdBEx595CYX4r6oCzp34j9F9t8PSI=;
	b=J7a71SOPBbU5a015CX+2Ux6ut3dh/FRXuGG88uKovPInErFi3bWcHrUj6fHtSMIbvRHBMj
	hcXz/beBwt8QzXDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 172E213985;
	Sun, 11 Feb 2024 20:41:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +t/iAvUwyWXnUAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Sun, 11 Feb 2024 20:41:25 +0000
Date: Sun, 11 Feb 2024 21:42:33 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v7 2/4] mm,page_owner: Implement the tracking of the
 stacks count
Message-ID: <ZckxObNXJnuKeExG@localhost.localdomain>
References: <20240208234539.19113-1-osalvador@suse.de>
 <20240208234539.19113-3-osalvador@suse.de>
 <CANpmjNOoYC93dt5hNmWsC2N8-7GuSp2L6Lb7mNOKxTGhreceUg@mail.gmail.com>
 <ZcabeMCHCkl3Bf6q@localhost.localdomain>
 <CANpmjNPM4aKMWAmxWEMQ-Antq0jDFauOya2XHHX5RhnONucgrg@mail.gmail.com>
 <CANpmjNP4H+FL-Jwq6Bpf1W0Rz2ZSn-ZquWf7tz4n57r1Jq6m_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP4H+FL-Jwq6Bpf1W0Rz2ZSn-ZquWf7tz4n57r1Jq6m_g@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MyXTaJiR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=J7a71SOP
X-Spamd-Result: default: False [-4.44 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,suse.cz,gmail.com,google.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.13)[95.83%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 91288210F5
X-Spam-Level: 
X-Spam-Score: -4.44
X-Spam-Flag: NO

On Fri, Feb 09, 2024 at 10:44:23PM +0100, Marco Elver wrote:
> > >                   * set a refcount of 1 ourselves.
> > >                   */
> > >                  if (refcount_read(&stack->count) == REFCOUNT_SATURATED)
> > >                          refcount_set(&stack->count, 1);
> 
> Do you need to inc the first allocation? Should there be an "else"
> here instead of always doing refcount_inc()?

Yes, I need to inc in the first allocation, otherwise on the first free
op, refcount goes to 0, and when the next allocation comes around,
I will get a warning because of going from refcount 0 to 1.


-- 
Oscar Salvador
SUSE Labs


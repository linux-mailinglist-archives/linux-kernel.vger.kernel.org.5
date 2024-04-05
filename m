Return-Path: <linux-kernel+bounces-132373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 369008993BD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523B81C2252B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A4419BA3;
	Fri,  5 Apr 2024 03:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZTXTCTXJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cVHpIw3J";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZTXTCTXJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cVHpIw3J"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D83215E9B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 03:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712287339; cv=none; b=G1i4vfYDUsw+2RcsIQDZXBsP0GbuD+4TzFKDazJMtVF8LojpCn85BFYn7koTQjX/T5xi99oNm6Tr3DjYZyZmM89bkGOoHCxRY5FsQWqjDc5bezvBVLYcYiTA++QKg1loHi8C3G06cwRqGWgAmq/e6z+4gISOvy/JiirWOvNWbDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712287339; c=relaxed/simple;
	bh=8GGmPCwTYZZ46IcWHTyVP1u1MlUe46zXkKoyQoyoLlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePYQTx/W/XVLeCm8Sn3MisYRNg5GtUZkZcnjRUNuS/mjcMW+XENSH61E3V/E2Y9Q0Mk5TOXA0ggh/wJWRzdzlm2BwpU8c3N2V09JqBWiLSX9Bly7IEAaaJIovEg0APAUSPKWJQR5+p0KYuSnOHz8Obk6mzYnTkXe8kdWgMXMG6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZTXTCTXJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cVHpIw3J; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZTXTCTXJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cVHpIw3J; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7C27E219FE;
	Fri,  5 Apr 2024 03:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712287335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bk0QEmVb4f1vKjQAZiyiyCp+0dlzrHmnKU+o76nG/Rw=;
	b=ZTXTCTXJHkV5L2weiLQfGIi65BJP+jesilOXdH+NvJ14EtfNSXTTupHTq64XJvSAkXczG/
	RV7NqQLLPSk27OZ4JB9NOC1GLTHbwSFchpyeDqp2igBkohVCZ6h35b7IoXOt8INeLI6XQ8
	4F8lnpl20qVXRM1Xt0PQ0HFiaCnGQJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712287335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bk0QEmVb4f1vKjQAZiyiyCp+0dlzrHmnKU+o76nG/Rw=;
	b=cVHpIw3J4tKLV8ACRkgprcsRV6onQV2rxLDCEg3vRA5d5Zv3Te6ReQ0KGjeeeqBGdUCqge
	qbafQz1YSpWHTmCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712287335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bk0QEmVb4f1vKjQAZiyiyCp+0dlzrHmnKU+o76nG/Rw=;
	b=ZTXTCTXJHkV5L2weiLQfGIi65BJP+jesilOXdH+NvJ14EtfNSXTTupHTq64XJvSAkXczG/
	RV7NqQLLPSk27OZ4JB9NOC1GLTHbwSFchpyeDqp2igBkohVCZ6h35b7IoXOt8INeLI6XQ8
	4F8lnpl20qVXRM1Xt0PQ0HFiaCnGQJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712287335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bk0QEmVb4f1vKjQAZiyiyCp+0dlzrHmnKU+o76nG/Rw=;
	b=cVHpIw3J4tKLV8ACRkgprcsRV6onQV2rxLDCEg3vRA5d5Zv3Te6ReQ0KGjeeeqBGdUCqge
	qbafQz1YSpWHTmCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C16113357;
	Fri,  5 Apr 2024 03:22:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4Dm4A2duD2ZxaAAAn2gu4w
	(envelope-from <osalvador@suse.de>); Fri, 05 Apr 2024 03:22:15 +0000
Date: Fri, 5 Apr 2024 05:23:43 +0200
From: Oscar Salvador <osalvador@suse.de>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, muchun.song@linux.dev,
	willy@infradead.org
Subject: Re: [PATCH v2 3/3] hugetlb: Convert hugetlb_wp() to use struct
 vm_fault
Message-ID: <Zg9uv8fs7sD0rg-2@localhost.localdomain>
References: <20240401202651.31440-1-vishal.moola@gmail.com>
 <20240401202651.31440-4-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401202651.31440-4-vishal.moola@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]

On Mon, Apr 01, 2024 at 01:26:51PM -0700, Vishal Moola (Oracle) wrote:
> hugetlb_wp() can use the struct vm_fault passed in from hugetlb_fault().
> This alleviates the stack by consolidating 5 variables into a single
> struct.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs


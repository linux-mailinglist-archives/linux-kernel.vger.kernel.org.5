Return-Path: <linux-kernel+bounces-127523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A392894D18
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9EF1C21AE4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C2C3D544;
	Tue,  2 Apr 2024 08:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xbxCM2x/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X3Q3/owZ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79A23D3A5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 07:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712044801; cv=none; b=r+cFWsAURoJm+0xsU7yBOsGx2Z5I63wZoKKck7EfkFR4sU16jKm5+YnGPCNPkXyMAxnl5XAlBek4Xsw9uaCKKMOloVxJJEnktBM6jhstfAo2lrsK5NBmtw5/PJItZaPevXKRia13VIL04asF7JI/K8sirNmn1aDMGcr6T+bn+0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712044801; c=relaxed/simple;
	bh=LtT0e9h0lXVwDIP6I5Un017mzXnY6egsLRSS147sOPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAovdLQEm6j5vNMZCUnX3hDJFIwBzuSwxRU5azXJW7olFp55HELCQGnbXEOi+Da/MIYBS+vMs9U3eYsYkyrlphoS/hfpmbG/+Gt+mACvLDFyguON+TTEgwwVS3UNtoloyx5FQcjS6aLsX6M4Gz7X6RBxM7XqfRbb//KuvR5C9jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xbxCM2x/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X3Q3/owZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A72DC34425;
	Tue,  2 Apr 2024 07:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712044797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RP9RLjMVbq6a75Dz/QpdRnh/IGmkM/3rb1FTFURpAMo=;
	b=xbxCM2x/bJD4HdWoiZb1cKC8CAA9RQNPT8nVdiN8EfX+4JSQNpjWyVnlB50FLRwQPraGOq
	LH7i7LdfyNmTnCSxxXnk47cnjsAHmUEBTTpw4/VNeP1NlzJNs+1P5ujPp+dvdxwg8Zy3Gg
	6q8y3Tkx3pivB8i5U9/CQfMJkXV4M7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712044797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RP9RLjMVbq6a75Dz/QpdRnh/IGmkM/3rb1FTFURpAMo=;
	b=X3Q3/owZH0O5AM0hWchtsbxVchJJno1eRfpFd6zLInlSx987+9m8H7gfyqM1R1Wqwy9ARg
	igIWi+3SP3yL5eDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1609613A90;
	Tue,  2 Apr 2024 07:59:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id mQGoAv26C2YiWwAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 02 Apr 2024 07:59:57 +0000
Date: Tue, 2 Apr 2024 10:01:22 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Peter Collingbourne <pcc@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH] stackdepot: Rename pool_index to pool_index_plus_1
Message-ID: <Zgu7UoJt1Vi5gH0v@localhost.localdomain>
References: <20240402001500.53533-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402001500.53533-1-pcc@google.com>
X-Rspamd-Queue-Id: A72DC34425
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_SHORT(-0.19)[-0.968];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,fb.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo,suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO

On Mon, Apr 01, 2024 at 05:14:58PM -0700, Peter Collingbourne wrote:
> Commit 3ee34eabac2a ("lib/stackdepot: fix first entry having a
> 0-handle") changed the meaning of the pool_index field to mean "the
> pool index plus 1". This made the code accessing this field less
> self-documenting, as well as causing debuggers such as drgn to not
> be able to easily remain compatible with both old and new kernels,
> because they typically do that by testing for presence of the new
> field. Because stackdepot is a debugging tool, we should make sure
> that it is debugger friendly. Therefore, give the field a different
> name to improve readability as well as enabling debugger backwards
> compatibility.
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/Ib3e70c36c1d230dd0a118dc22649b33e768b9f88

Acked-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs


Return-Path: <linux-kernel+bounces-63271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B899852D19
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97C48B27A02
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F073225DE;
	Tue, 13 Feb 2024 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lCzzBvhu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GTw1+siX"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52C7225D9
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817982; cv=none; b=dM5XcrOQPrzGmyL7B+LNDjDwvFOX8ChqOrnaGm4Kkdxnt+vJXaWLyHUbkEh9/JuOW8HWVSVyg6ORfVRbVZRPEIaoeUJMTBLKXehR+dFiL/srealb0AeukuYXIeVPZ5I5ax+273Xc9YOs/G4BODywBRBvJeXNno5fWBWNFRYbNq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817982; c=relaxed/simple;
	bh=jzPRKNTd3wSLGZSoklskyum2VBJEE5dR6znqH0Wig5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+jxuO8c/DFsG3JAmrNR0IgsKqPK72c2O5WdIgbXNzE+DRpssR+E08tY7cyPutUu/Lp3DOUAtD/TZBbrwYTjok+uXk3UUrJVQagi9SD4bJCfxJz3DLqOGZz5FNhKUm6WC1zWfCP4squwKXS7AV/wE5VZa5DuwCiN2R2F0LOAUNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lCzzBvhu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GTw1+siX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3498B1FC31;
	Tue, 13 Feb 2024 09:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707817973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uWRBYrmHPV+rQWKnyw6uQ5jKePWNy4EYeGvU95ElExk=;
	b=lCzzBvhuSR0BNN8x/qcU0Isxya+aUEjuphgBOsr+0Aa2sIcS0WRK50XWNkEgzPdRn6VXi7
	wSrMt5wQKV34YlkWZHUwIEX6koJfPhYekovodVAcmkHc68pHvB3pk2bBoGMWCgytLYnL5h
	QQDLOsuKtRVnbkM+5RgQznkharPIeio=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707817972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uWRBYrmHPV+rQWKnyw6uQ5jKePWNy4EYeGvU95ElExk=;
	b=GTw1+siXPr0mxh/bBZ9HQdzkywdXp69EO1xc+nF1dmE/7bpKR9sNhqCRcJouPn1b9necrs
	SBZSKrn7KiTTUe7xrTWQ3uivC3Kfm8nNS/hdO98nYToaLLgBOYiM+HHN8VPWXr1VwJNIvm
	sg4MfLsVqmisDdaGTe2Bp4Vwf0XseiQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 161571370C;
	Tue, 13 Feb 2024 09:52:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k6pvAvQ7y2XxXwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 13 Feb 2024 09:52:52 +0000
Date: Tue, 13 Feb 2024 10:52:47 +0100
From: Michal Hocko <mhocko@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@techsingularity.net>,
	Matthew Wilcox <willy@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] mm: document memalloc_noreclaim_save() and
 memalloc_pin_save()
Message-ID: <Zcs77_L1U12eG37V@tiehlicka>
References: <20240212182950.32730-2-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212182950.32730-2-vbabka@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.00)[29.04%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,kvack.org,vger.kernel.org,techsingularity.net,infradead.org,gmail.com,soleen.com,linux.ibm.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.10

On Mon 12-02-24 19:29:51, Vlastimil Babka wrote:
> The memalloc_noreclaim_save() function currently has no documentation
> comment, so the implications of its usage are not obvious. Namely that
> it not only prevents entering reclaim (as the name suggests), but also
> allows using all memory reserves and thus should be only used in
> contexts that are allocating memory to free memory. This may lead to new
> improper usages being added.
> 
> Thus add a documenting comment, based on the description of
> __GFP_MEMALLOC. While at it, also document memalloc_pin_save() so that
> all the memalloc_ scopes are documented. In the comments describing the
> relevant PF_MEMALLOC flags, refer to their scope setting functions.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

-- 
Michal Hocko
SUSE Labs


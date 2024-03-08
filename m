Return-Path: <linux-kernel+bounces-97026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB6A876488
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C957C1F22CC0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2771E17BDC;
	Fri,  8 Mar 2024 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fDFSmilU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fDFSmilU"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B912B1D52B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709902236; cv=none; b=it588ONJMMkxy0Z3rIZl3KK8WSNGwY6WGTPuIt+sYyaqvAB1Wywf4cBJM2MEpn7g5n9Q1eBGs0vcRgK364OicZqbp89Yo2fquEG8XbTv7D38lYgxdr9+uFIPkOHwEvc0TWk6uakkWLxwLFVNk9ZRvXb8rb+djD8KFR8Pxlafs2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709902236; c=relaxed/simple;
	bh=X8r0myWAP+ZNabX9jq2ofWmOakXvjG5XDtC/EIB+ZPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6ap6qiQz7/1neyEbXHyBtRbWm9NLzMwlsWcxlh0NE/7L82JwtX1I48Lxw/knXK3ZfmPIdq29kIqqA5jT3O9Yn6IWYwKSaOa0/GCkdmSmnv7EW/7JQnVZRbYs323NB/cRfZ6TRXaKGi1HNNTT0hf9x1Orv1viqWrACD+OoQ+H0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fDFSmilU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fDFSmilU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0FF813FAB3;
	Fri,  8 Mar 2024 09:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709891964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qt3Lk6ghcLdCV0nzg8fVJQXKNWubDuUtSSj7mwILKNs=;
	b=fDFSmilUwzvR1zEqdhGdTp+tvd+Mu8agF2UbCQIBJPOWJXIztx1BgBaOClbbLIALaaeXQQ
	w5gC+DQM6Fk5qBfWBsKlIIFyHjTRZNEHEf8zQe3RFUi4a9gUE8pbVrsH0EJNZL2D8nAt3Q
	MsJavlBCeBjQgMAqywvozHu/nBxak7A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709891964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qt3Lk6ghcLdCV0nzg8fVJQXKNWubDuUtSSj7mwILKNs=;
	b=fDFSmilUwzvR1zEqdhGdTp+tvd+Mu8agF2UbCQIBJPOWJXIztx1BgBaOClbbLIALaaeXQQ
	w5gC+DQM6Fk5qBfWBsKlIIFyHjTRZNEHEf8zQe3RFUi4a9gUE8pbVrsH0EJNZL2D8nAt3Q
	MsJavlBCeBjQgMAqywvozHu/nBxak7A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAC9913310;
	Fri,  8 Mar 2024 09:59:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rETxNnvh6mU+ZwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 08 Mar 2024 09:59:23 +0000
Date: Fri, 8 Mar 2024 10:59:23 +0100
From: Michal Hocko <mhocko@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: CVE-2024-26628: drm/amdkfd: Fix lock dependency warning
Message-ID: <Zerheyn-4rB5kySt@tiehlicka>
References: <2024030649-CVE-2024-26628-f6ce@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024030649-CVE-2024-26628-f6ce@gregkh>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.40
X-Spamd-Result: default: False [-1.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.60)[81.72%]
X-Spam-Flag: NO

On Wed 06-03-24 06:46:11, Greg KH wrote:
[...]
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&svms->lock);
>                                lock(&mm->mmap_lock);
>                                lock(&svms->lock);
>   lock((work_completion)(&svm_bo->eviction_work));
> 
> I believe this cannot really lead to a deadlock in practice, because
> svm_range_evict_svm_bo_worker only takes the mmap_read_lock if the BO
> refcount is non-0. That means it's impossible that svm_range_bo_release
> is running concurrently. However, there is no good way to annotate this.

OK, so is this even a bug (not to mention a security/weakness)?
-- 
Michal Hocko
SUSE Labs


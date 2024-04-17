Return-Path: <linux-kernel+bounces-148419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F7C8A8249
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED6A1C22E22
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A4813CABA;
	Wed, 17 Apr 2024 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z9ho0rhk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4y3dr6v+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z9ho0rhk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4y3dr6v+"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA525680;
	Wed, 17 Apr 2024 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354213; cv=none; b=E/fBbF5UHbaZ5xAZjWvMIobrK9W2C8DxniCSZ8WDLwZJs5H0qgZB34R7/EsFsMNGXhCTpmUNaPfmsyX1hnclkgdn+R5HJBp7V7uHZUQuAnLqhY/w6FzvnR4Ine2ymgBdCA3ZS/eJjUYBLiShg263aZBwTEaSUWPb0ahJT6JnIdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354213; c=relaxed/simple;
	bh=PEB6drbglnsklaB5W7IH+U0FJxOt4QfpV8UOKufOExE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtL/YNIAMlU/8iGCyp3NJ5SjjJIa7WGSwk8Sll1bfq2FgzgjO5M6GPExKFajWAdCZ5ynQyU4T9HAEyLNZ74uyPHcf2gOudCZiEf6Tnr18dlMpUcvOq1CT68t8dbDwFTVNECHn00V06GYbfkeVb6Y4cUKmZeh7qQHF7EaG/7TFUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z9ho0rhk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4y3dr6v+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z9ho0rhk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4y3dr6v+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62BE9220A0;
	Wed, 17 Apr 2024 11:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713354209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cIJq+mR3OBQMgwXQfkk/bTf76VYvfmQoEauVaCY2b5Q=;
	b=z9ho0rhkskAoivStTmL+lyrss34CV0V51qAEdrDt27NqiYyW4Qsn1EgjaCNNjOw5c7Zh2F
	R65Kv/JznvsnQZsZ0D5ebO/01j+A5yUyobEg/ooCpcwdJUwBvf9ItUcDmieHjQPIarImaG
	49oT7538JIXZGG+SHURDv/pxmgIWxKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713354209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cIJq+mR3OBQMgwXQfkk/bTf76VYvfmQoEauVaCY2b5Q=;
	b=4y3dr6v+2bm2pcd/V4d6hYFlYI6utZV0wXXVqV/3nY1pBrAusPvYQbo7ZlTFikA1i+KO/g
	twOrCqT39IiZTeDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=z9ho0rhk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4y3dr6v+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713354209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cIJq+mR3OBQMgwXQfkk/bTf76VYvfmQoEauVaCY2b5Q=;
	b=z9ho0rhkskAoivStTmL+lyrss34CV0V51qAEdrDt27NqiYyW4Qsn1EgjaCNNjOw5c7Zh2F
	R65Kv/JznvsnQZsZ0D5ebO/01j+A5yUyobEg/ooCpcwdJUwBvf9ItUcDmieHjQPIarImaG
	49oT7538JIXZGG+SHURDv/pxmgIWxKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713354209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cIJq+mR3OBQMgwXQfkk/bTf76VYvfmQoEauVaCY2b5Q=;
	b=4y3dr6v+2bm2pcd/V4d6hYFlYI6utZV0wXXVqV/3nY1pBrAusPvYQbo7ZlTFikA1i+KO/g
	twOrCqT39IiZTeDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F8A013957;
	Wed, 17 Apr 2024 11:43:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +UFqE+G1H2bqDAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Apr 2024 11:43:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 01876A082E; Wed, 17 Apr 2024 13:43:24 +0200 (CEST)
Date: Wed, 17 Apr 2024 13:43:24 +0200
From: Jan Kara <jack@suse.cz>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2024-26774: ext4: avoid dividing by 0 in
 mb_update_avg_fragment_size() when block bitmap corrupt
Message-ID: <20240417114324.c77wuw5hvjbm6ok5@quack3>
References: <2024040308-CVE-2024-26774-52d9@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024040308-CVE-2024-26774-52d9@gregkh>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 62BE9220A0
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]

Hello!

On Wed 03-04-24 19:31:41, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> ext4: avoid dividing by 0 in mb_update_avg_fragment_size() when block bitmap corrupt
> 
> Determine if bb_fragments is 0 instead of determining bb_free to eliminate
> the risk of dividing by zero when the block bitmap is corrupted.
> 
> The Linux kernel CVE team has assigned CVE-2024-26774 to this issue.

I'd like to understand what is the imagined security threat fixed by this
patch (as multiple patches of similar nature got assigned a CVE). The patch
fixes a bug that if a corrupted filesystem is read-write mounted, we can do
division-by-zero. Now if you can make the system mount a corrupted
filesystem, you can do many interesting things to the system other than
create a division by zero... So what is the presumed threat model here?

								Honza

> Affected and fixed versions
> ===========================
> 
> 	Fixed in 5.15.150 with commit 687061cfaa2a
> 	Fixed in 6.1.80 with commit 8b40eb2e716b
> 	Fixed in 6.6.19 with commit f32d2a745b02
> 	Fixed in 6.7.7 with commit 8cf9cc602cfb
> 	Fixed in 6.8 with commit 993bf0f4c393
> 
> Please see https://www.kernel.org for a full list of currently supported
> kernel versions by the kernel community.
> 
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2024-26774
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
> 
> 
> Affected files
> ==============
> 
> The file(s) affected by this issue are:
> 	fs/ext4/mballoc.c
> 
> 
> Mitigation
> ==========
> 
> The Linux kernel CVE team recommends that you update to the latest
> stable kernel version for this, and many other bugfixes.  Individual
> changes are never tested alone, but rather are part of a larger kernel
> release.  Cherry-picking individual commits is not recommended or
> supported by the Linux kernel community at all.  If however, updating to
> the latest release is impossible, the individual changes to resolve this
> issue can be found at these commits:
> 	https://git.kernel.org/stable/c/687061cfaa2ac3095170e136dd9c29a4974f41d4
> 	https://git.kernel.org/stable/c/8b40eb2e716b503f7a4e1090815a17b1341b2150
> 	https://git.kernel.org/stable/c/f32d2a745b02123258026e105a008f474f896d6a
> 	https://git.kernel.org/stable/c/8cf9cc602cfb40085967c0d140e32691c8b71cf3
> 	https://git.kernel.org/stable/c/993bf0f4c393b3667830918f9247438a8f6fdb5b
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


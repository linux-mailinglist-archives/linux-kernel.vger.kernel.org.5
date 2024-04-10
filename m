Return-Path: <linux-kernel+bounces-138380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1BF89F05D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32434282457
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F95B159592;
	Wed, 10 Apr 2024 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rMz+Nx2d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OLFLGQSk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rMz+Nx2d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OLFLGQSk"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D1815956F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712747386; cv=none; b=PtOa3Ii/AInUz2PEk4Dg5PczJQEDIiD3sYwfFJjYvhXLvY294dMtMbuNNiROWqPNECcmlT73Um/igtKw00Bm52zQuhnsrR4a+xjSggSPeuDfIJD3fm+0/ZxtYyjpwP/ZY0h0oRca4YH/+AocxdA/9+o0BXp2TxSh3yLeKNP9GoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712747386; c=relaxed/simple;
	bh=EBRzfpsTMoU5u4mx8hV0Q9i8zHHzckn7JlMVdDGdbgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prwvJ5EndUFPt0ZA+dWuFCzBFVwRozRjz+q7ZdNPOhASl7pob9w67MIBmHc/1FM9wJOR6qu3D6Giar9wIkvWQ3Z6nAFmJKhzHh9PSxUNWcJISfot1ZYdg4dY8OpdsFypUx50jJr6JaHHT66paWIAZZMTKRyTczQ00Ej9fsuZbF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rMz+Nx2d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OLFLGQSk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rMz+Nx2d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OLFLGQSk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B257834F87;
	Wed, 10 Apr 2024 11:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712747382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dtxyhgYBMQ1AvTvgnetMyGOR6PFkKNyRXOKDIbhBpA8=;
	b=rMz+Nx2d3fxOQMiMD+Wvv57eE6ddk9ddHX/oSDeqislpf6XG6n4jIqxvvOWQrL90ZVZxjv
	+zl3mSlIUMf9pdZ3NYsNtSCsStSI78m1vRWuH+ecb2xbZHIjtImQnLukVcfPHfcm4MuoAT
	5oFofqG6M3Tp1G7asPv3PVZaEJCYZR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712747382;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dtxyhgYBMQ1AvTvgnetMyGOR6PFkKNyRXOKDIbhBpA8=;
	b=OLFLGQSkHcY8R6Cm08UWNfxbpfmgBDXOGo4J8dKfp+IPzRZw+SLjNumN/SPoCEjK7aukD1
	aAOZDPSMoPBf83BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712747382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dtxyhgYBMQ1AvTvgnetMyGOR6PFkKNyRXOKDIbhBpA8=;
	b=rMz+Nx2d3fxOQMiMD+Wvv57eE6ddk9ddHX/oSDeqislpf6XG6n4jIqxvvOWQrL90ZVZxjv
	+zl3mSlIUMf9pdZ3NYsNtSCsStSI78m1vRWuH+ecb2xbZHIjtImQnLukVcfPHfcm4MuoAT
	5oFofqG6M3Tp1G7asPv3PVZaEJCYZR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712747382;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dtxyhgYBMQ1AvTvgnetMyGOR6PFkKNyRXOKDIbhBpA8=;
	b=OLFLGQSkHcY8R6Cm08UWNfxbpfmgBDXOGo4J8dKfp+IPzRZw+SLjNumN/SPoCEjK7aukD1
	aAOZDPSMoPBf83BA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A84C01390D;
	Wed, 10 Apr 2024 11:09:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id oIkTKXZzFmZydgAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 10 Apr 2024 11:09:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5D013A06D8; Wed, 10 Apr 2024 13:09:42 +0200 (CEST)
Date: Wed, 10 Apr 2024 13:09:42 +0200
From: Jan Kara <jack@suse.cz>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
	Sergey Shtylyov <s.shtylyov@omp.ru>, lvc-project@linuxtesting.org,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] udf: udftime: prevent overflow in
 udf_disk_stamp_to_time()
Message-ID: <20240410110942.ajj6i3eup4ycvhml@quack3>
References: <20240327132755.13945-1-r.smirnov@omp.ru>
 <20240410110406.ax4mpguev7jiszyh@quack3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410110406.ax4mpguev7jiszyh@quack3>
X-Spam-Level: 
X-Spamd-Result: default: False [-7.69 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-2.89)[99.54%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]
X-Spam-Score: -7.69
X-Spam-Flag: NO

On Wed 10-04-24 13:04:06, Jan Kara wrote:
> On Wed 27-03-24 16:27:55, Roman Smirnov wrote:
> > An overflow can occur in a situation where src.centiseconds
> > takes the value of 255. This situation is unlikely, but there
> > is no validation check anywere in the code.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with Svace.
> > 
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
> 
> Thanks! I've added the patch to my tree.

Actually, there's a small typo that needed fixing up. Corrected on commit.

> > diff --git a/fs/udf/udftime.c b/fs/udf/udftime.c
> > index 758163af39c2..3113785af3cf 100644
> > --- a/fs/udf/udftime.c
> > +++ b/fs/udf/udftime.c
> > @@ -46,13 +46,18 @@ udf_disk_stamp_to_time(struct timespec64 *dest, struct timestamp src)
> >  	dest->tv_sec = mktime64(year, src.month, src.day, src.hour, src.minute,
> >  			src.second);
> >  	dest->tv_sec -= offset * 60;
> > -	dest->tv_nsec = 1000 * (src.centiseconds * 10000 +
> > -			src.hundredsOfMicroseconds * 100 + src.microseconds);
> > +
> >  	/*
> >  	 * Sanitize nanosecond field since reportedly some filesystems are
> >  	 * recorded with bogus sub-second values.
> >  	 */
> > -	dest->tv_nsec %= NSEC_PER_SEC;
> > +	if (src.centiseconds < 100 && src.hundredsOfMicroseconds < 100 &&
> > +	    src.microseconds < 100) {
> > +		dest->tv_nsec = 1000 * (src.centiseconds * 10000 +
> > +			src.hundredsOfMicroseconds * 100 + src.microseconds);
> > +	} else {
> > +		desk->tv_nsec = 0;
		^^^^ Here

> > +	}
> >  }

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


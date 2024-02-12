Return-Path: <linux-kernel+bounces-61263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CA7851017
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59F0A1F23BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D880E17C66;
	Mon, 12 Feb 2024 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UtTjwY9y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="M2CnSysU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RI2oHVs3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eNEsrdT2"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12405680;
	Mon, 12 Feb 2024 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731722; cv=none; b=AbnyYQYW9sWjKp7/LNeLtEnWbMKMQcHX5ab4dmV4WjV8I1fy/mNAnAuB9crODQd/L7wPs4J0IWU8y+BT5d9XakMOfJ0xS4xwQeUR0IoAqKFSRGVS1B7lQvhOwCaqEnJeLorZDmtFGoXh+xy9gVDRu1g6Hyqi8RhT9ac20RI3J+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731722; c=relaxed/simple;
	bh=t4WvYxU51ydBpw383RUz2vrJCztI+BCrun0XRdgVmKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYS4KcGpX/JFvkuKJ0RH/u8PXvioY3/4t9h2SZ6qduEsyNoErR1tBA03MCEZaPxNrtGAX6xPjjpG+e+BKrHHAIRnb2pzVFoYH/OdnxProc26+cOs656qRCZDJ+kh+JppBlDaP10Op841T22+92uCDiTDd23x0AqoGpDv4LBRY2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UtTjwY9y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=M2CnSysU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RI2oHVs3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eNEsrdT2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D98021C55;
	Mon, 12 Feb 2024 09:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707731716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TcOt8F/vPFobphbJxqs2m3ZJ2DqTEZsfenrec8cS0dc=;
	b=UtTjwY9yyodJDceWP/WkqF2y+A1kALxjOIl57ksBltuIiw/wnTU4YH0sll5WHp13+K2NtU
	K+gZeMkVhS9ade2ALrbpaqJWQA25mcPFZG2GKgKO3NEWjrAV4D+fzLqCuQ8Fvo4LK7j+d8
	dqFh1MRucIebxZVX77SOlZRUtMragRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707731716;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TcOt8F/vPFobphbJxqs2m3ZJ2DqTEZsfenrec8cS0dc=;
	b=M2CnSysUHtdXn9kwBLsqBR5gUyHtkBsnJtQ+ag46LwN1eGfcOPN/P6IeBfnrfWHlp2t2fH
	UZDbTySVVF8BV9Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707731714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TcOt8F/vPFobphbJxqs2m3ZJ2DqTEZsfenrec8cS0dc=;
	b=RI2oHVs3KSB3UJrXCyqeWJLdVfkA30EgSO/rXf+AioGez8Xz5xCuaMK8Fwf6uuKFO9JXVx
	qZwkz/+HIn17FhAMVQAuB3CaJWzkjqedJnv+ujQrE90xil7ynPSNdZTovI0dX3EO9QVSrO
	gWHWr8TJb43rLuMPeJY3xL02mI5iVDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707731714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TcOt8F/vPFobphbJxqs2m3ZJ2DqTEZsfenrec8cS0dc=;
	b=eNEsrdT2dKXIw/yRW0fLu018iWrhcqMvCjURM6YjrMi6mRX8tEAbQ31ngiwG5aNOLeweF0
	Ql22q2eJIUGroICw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 44C2313A0E;
	Mon, 12 Feb 2024 09:55:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id hmFQDwLryWUwAQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 12 Feb 2024 09:55:14 +0000
Date: Mon, 12 Feb 2024 10:55:13 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: James Smart <james.smart@broadcom.com>, 
	Ram Vegesna <ram.vegesna@broadcom.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexey Khoroshilov <khoroshilov@ispras.ru>, lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] scsi: elx: efct: adjust error handling inside
 efct_hw_setup_io
Message-ID: <fbz7l6ekiqqhi47cv6r2ots7siztdydfcspwr2jt56ldsyxjep@rwd5zx2oezl4>
References: <2ik7x74hq6exam5ab4v2moauy4lfvqe3r626bxxettseat2nmv@q4gykxnezkff>
 <20240210110833.27723-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210110833.27723-1-pchelkin@ispras.ru>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RI2oHVs3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eNEsrdT2
X-Spamd-Result: default: False [-1.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,linuxtesting.org:url,ispras.ru:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[38.62%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5D98021C55
X-Spam-Level: 
X-Spam-Score: -1.81
X-Spam-Flag: NO

On Sat, Feb 10, 2024 at 02:08:33PM +0300, Fedor Pchelkin wrote:
> IO and WQE buffers are allocated once per HW and can be reused later. If
> WQE buffers allocation fails then the whole allocation is marked as failed
> but already created IO array internal objects are not freed. hw->io is
> freed but not nullified in that specific case - it may become a problem
> later as efct_hw_setup_io() is supposed to be reusable for the same HW.
> 
> Also rollback if HW IO objects initialization loop fails due to memory
> allocation error.
> 
> While at it, use kcalloc instead of kmalloc_array/memset-zero combination
> and get rid of some needless NULL assignments: nullifying hw->io[i]
> elements just before freeing hw->io is not really useful.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 4df84e846624 ("scsi: elx: efct: Driver initialization routines")
> Cc: stable@vger.kernel.org
> Suggested-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
> v2: per Daniel Wagner's notice, handle the other possible memory
>     allocation errors inside the function.

Looks good to me! Thanks!

Reviewed-by: Daniel Wagner <dwagner@suse.de>


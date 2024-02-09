Return-Path: <linux-kernel+bounces-59040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C692784F039
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD261C220E9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE5E57329;
	Fri,  9 Feb 2024 06:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lPwB5hIf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PADFRAJP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lPwB5hIf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PADFRAJP"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36EF57310;
	Fri,  9 Feb 2024 06:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707459860; cv=none; b=QfyJopc5zJbgmyG9WzHdA8ndIswud+D7Jf9tG5f3quH3gvXTdccv8HbccQQajctZTxk+0jNPv2Eed+wmY7gsEgE/V5Gpi37fMbRiQ+fjGXMwBLb6m1GbmLuiUSzd467xJ7u+oOlo9GbKnw3hsoxnX5qu6uIWf88KI5oZrwKbMwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707459860; c=relaxed/simple;
	bh=89RlaZiW2zFWOUG3IqWYiZXQPTee7Dmk8dUcq3QXIrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2UxGf+QMWhCuq4WGLVHE5yco5mVfQXJKEwRGGIBZe6dUYp82pdCyR9QHktPkXQOdQr1Ih2sPPmSfayBRfu2gvhBq7mkxskvZzb+ml1hqp4hN/GHfv+WsFSiu1/rWydHo2EeJpY4LLD/8jKiT4vNW0+GhVkCL+yEKM1YIf4JNWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lPwB5hIf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PADFRAJP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lPwB5hIf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PADFRAJP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A9E611F7DE;
	Fri,  9 Feb 2024 06:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707459855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RLtqCnLoHDcowrIyQ34cuvnOLg2AS9p8XbafIJGUDZs=;
	b=lPwB5hIf6hZWKniOlXq/i4koRAVGs8RtjFJqe47F5TQRfHJ5cEuZdIVdvCLR3DcEvhxJg6
	7bl44qQlWxqIC1/n6xY+q+I66ppgehFHifnGG7QGrYuY1uIEIAo8q4cEx0KZluyqhk3BPd
	0n5lhhOtrJkUGde10/gSVzJNkMHEq4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707459855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RLtqCnLoHDcowrIyQ34cuvnOLg2AS9p8XbafIJGUDZs=;
	b=PADFRAJP8mnYZ5ZwUwvsrGbb7iJ0bnu2NSLzjomU9kHvvjFsHpkaex8RkN7k+Njhe2NpGD
	e4UDERtDwR63j2AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707459855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RLtqCnLoHDcowrIyQ34cuvnOLg2AS9p8XbafIJGUDZs=;
	b=lPwB5hIf6hZWKniOlXq/i4koRAVGs8RtjFJqe47F5TQRfHJ5cEuZdIVdvCLR3DcEvhxJg6
	7bl44qQlWxqIC1/n6xY+q+I66ppgehFHifnGG7QGrYuY1uIEIAo8q4cEx0KZluyqhk3BPd
	0n5lhhOtrJkUGde10/gSVzJNkMHEq4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707459855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RLtqCnLoHDcowrIyQ34cuvnOLg2AS9p8XbafIJGUDZs=;
	b=PADFRAJP8mnYZ5ZwUwvsrGbb7iJ0bnu2NSLzjomU9kHvvjFsHpkaex8RkN7k+Njhe2NpGD
	e4UDERtDwR63j2AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B14A1326D;
	Fri,  9 Feb 2024 06:24:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +kvPGQ/FxWVDXAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 09 Feb 2024 06:24:15 +0000
Date: Fri, 9 Feb 2024 07:24:13 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: James Smart <james.smart@broadcom.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Ram Vegesna <ram.vegesna@broadcom.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexey Khoroshilov <khoroshilov@ispras.ru>, lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH] scsi: elx: efct: adjust error handling inside
 efct_hw_setup_io
Message-ID: <2ik7x74hq6exam5ab4v2moauy4lfvqe3r626bxxettseat2nmv@q4gykxnezkff>
References: <20240208093657.19617-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208093657.19617-1-pchelkin@ispras.ru>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lPwB5hIf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PADFRAJP
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[39.25%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.01
X-Rspamd-Queue-Id: A9E611F7DE
X-Spam-Flag: NO

On Thu, Feb 08, 2024 at 12:36:57PM +0300, Fedor Pchelkin wrote:
> IO and WQE buffers are allocated once per HW and can be reused later. If
> WQE buffers allocation fails then the whole allocation is marked as failed
> but already created IO array internal objects are not freed. hw->io is
> freed but not nullified in that specific case - it may become a problem
> later as efct_hw_setup_io() is supposed to be reusable for the same HW.
> 
> While at it, use kcalloc instead of kmalloc_array/memset-zero combination
> and get rid of some needless NULL assignments: nullifying hw->io[i]
> elements just before freeing hw->io is not really useful.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 4df84e846624 ("scsi: elx: efct: Driver initialization routines")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

The patch looks okay. Though I think this funktion leaks all over the
place memory as soon we take the error path. Could you also prepare
a fix for these path while you are at it?

Thanks!
Daniel


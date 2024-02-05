Return-Path: <linux-kernel+bounces-52136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771AA84947C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331B4286FE6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132DD101CE;
	Mon,  5 Feb 2024 07:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CuzPOd4Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wYJQrgn/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CuzPOd4Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wYJQrgn/"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673F410A0F;
	Mon,  5 Feb 2024 07:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707117982; cv=none; b=gv6FLhzK37UKgVSVA9BJ7xLxz0bE5K+2uSY6ZYw4VDMfvADA7uj2XCMy+WRDWx2Gfhqk/dVXQ0QwxyZSu82t2E3gzIPbGAmDKo4Q7T8k9phMjy22T132RhJWtD1Dr62i6oikRPC+NW93QXfzysexPZl+GfryriAAWqHcXzAcZbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707117982; c=relaxed/simple;
	bh=FKzo+iDb4GSIYbAuvyhQyvsbKcySjX23LRYwxAQVApE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MSdovNcW7m95NeVSAedfjtm7VKuuniCPo54WM3uAOGeAjuoHJ0sH/VAMEvafCc9TfcCPUiT+fJFy9xN5edbHim9UE5vEK+JU/RW/BZruCNBdUPMMGPOMndRk3hLp3Xco0jbiNNNCPRCSEjCnwMl5SE18yGQY43F9h4nzwTEy/3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CuzPOd4Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wYJQrgn/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CuzPOd4Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wYJQrgn/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 75DB221F18;
	Mon,  5 Feb 2024 07:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707117977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=au0mlfS5y3gIEFvklIKhtZf/nyYZ3PkgsCXwnAl+Z1A=;
	b=CuzPOd4Q6kLZO1MITou6ZPb5oW08eLEG+OwqPfK1z/NNCpUykg6YPDBR5B2Dr6B7KQyYj4
	vjuxyAqMlAs/vJ61Mo8f0hdJM9hkZ1AULNjy/QMjNW/tS9gVWjxxj0nkQ6YcAbd3LLx9Ey
	eSYDQ52HGcqfWdA8zGWZHwSsW1w+0Yk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707117977;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=au0mlfS5y3gIEFvklIKhtZf/nyYZ3PkgsCXwnAl+Z1A=;
	b=wYJQrgn/KF5dUKjODE/yPMig+QWqIN7E7q0xG5vSFW51p16zXyZ0m9zfJWfqR3+YQ0nJrM
	U5Xm0+rgpqqO8lDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707117977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=au0mlfS5y3gIEFvklIKhtZf/nyYZ3PkgsCXwnAl+Z1A=;
	b=CuzPOd4Q6kLZO1MITou6ZPb5oW08eLEG+OwqPfK1z/NNCpUykg6YPDBR5B2Dr6B7KQyYj4
	vjuxyAqMlAs/vJ61Mo8f0hdJM9hkZ1AULNjy/QMjNW/tS9gVWjxxj0nkQ6YcAbd3LLx9Ey
	eSYDQ52HGcqfWdA8zGWZHwSsW1w+0Yk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707117977;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=au0mlfS5y3gIEFvklIKhtZf/nyYZ3PkgsCXwnAl+Z1A=;
	b=wYJQrgn/KF5dUKjODE/yPMig+QWqIN7E7q0xG5vSFW51p16zXyZ0m9zfJWfqR3+YQ0nJrM
	U5Xm0+rgpqqO8lDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FEF4136F5;
	Mon,  5 Feb 2024 07:26:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qCqJDZmNwGVefgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 05 Feb 2024 07:26:17 +0000
Date: Mon, 05 Feb 2024 08:26:16 +0100
Message-ID: <87r0hr9xt3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: bo liu <bo.liu@senarytech.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] ALSA: hda/conexant: Add quirk for SWS JS201D
In-Reply-To: <20240205013802.51907-1-bo.liu@senarytech.com>
References: <20240205013802.51907-1-bo.liu@senarytech.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CuzPOd4Q;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="wYJQrgn/"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.23 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.72)[98.76%]
X-Spam-Score: -5.23
X-Rspamd-Queue-Id: 75DB221F18
X-Spam-Flag: NO

On Mon, 05 Feb 2024 02:38:02 +0100,
bo liu wrote:
> 
> The SWS JS201D need a different pinconfig from windows driver.
> Add a quirk to use a specific pinconfig to SWS JS201D.
> 
> Signed-off-by: bo liu <bo.liu@senarytech.com>

Thanks, applied now.


Takashi


Return-Path: <linux-kernel+bounces-54148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1A584AB85
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01EA5287AFA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020B0186F;
	Tue,  6 Feb 2024 01:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j2uWgFRB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BLB9xptA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j2uWgFRB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BLB9xptA"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF871367;
	Tue,  6 Feb 2024 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707182632; cv=none; b=PSPqtbjappFA9Tt9nGv8Xk+lE9xH/TmTuaARTOBpXNnIjTgczLPCoaKW6EB3y+OSFg3LxkEVU//eqYI+Qd9ymsGdYauBLenMvop+25CbdHTAy+45NjdE8Qx6BssZPyOaOKnVISmUJdULKtuAOWcxz4FRoArB89gseA211bShoRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707182632; c=relaxed/simple;
	bh=1ubqfGFiV9WTKil/Wx37SVzwQ8BHKrAzW1eSpYyA7B8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDoIvLIWwFeDghf28sk0SQc8cbS/a+WZQ9vBOO3zE5qmn4eNhhFoNbGnULP+sZMB+Gt+Z00lKPfX8TjIYDmeHn8V4ZMfoHCAACb4K3jhb9Zw70Vi2egLGUxt9cJDHakUdi6XfmjwbVuqhRkMnBNFG/Tdgg+JzY3ipgyvIyW/l5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j2uWgFRB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BLB9xptA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j2uWgFRB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BLB9xptA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8EEE01FB58;
	Tue,  6 Feb 2024 01:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707182627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6rW0G9gt7ir2VvM0GiL0nnA+OWvb2ivQWWi+qfcZ2P4=;
	b=j2uWgFRB4DbaOB5hpl15zCuvPRIVqSp+SUV+P9mwGh0WMsitJkWton6rRnH0v3ggBn+SRa
	/8bwwmdl4qO6q38Lu6Rf54+FCepsgwBnFzFi53Q4Lnwile1dxgJpcztz+RayhukWYzHLvo
	UOPgfrtY6fMkPVGFim2x5TEUx0Ngnjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707182627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6rW0G9gt7ir2VvM0GiL0nnA+OWvb2ivQWWi+qfcZ2P4=;
	b=BLB9xptAhDourhZr65Yzo7WCNS83d2fCmDYxrjfs4E81IjRq+ixBVv9i+91Am+shOzxRVj
	UpFmebI05hWw7qBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707182627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6rW0G9gt7ir2VvM0GiL0nnA+OWvb2ivQWWi+qfcZ2P4=;
	b=j2uWgFRB4DbaOB5hpl15zCuvPRIVqSp+SUV+P9mwGh0WMsitJkWton6rRnH0v3ggBn+SRa
	/8bwwmdl4qO6q38Lu6Rf54+FCepsgwBnFzFi53Q4Lnwile1dxgJpcztz+RayhukWYzHLvo
	UOPgfrtY6fMkPVGFim2x5TEUx0Ngnjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707182627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6rW0G9gt7ir2VvM0GiL0nnA+OWvb2ivQWWi+qfcZ2P4=;
	b=BLB9xptAhDourhZr65Yzo7WCNS83d2fCmDYxrjfs4E81IjRq+ixBVv9i+91Am+shOzxRVj
	UpFmebI05hWw7qBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2839C132DD;
	Tue,  6 Feb 2024 01:23:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9yloNSGKwWWpBAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 06 Feb 2024 01:23:45 +0000
Message-ID: <ad231c28-c451-4b1d-9d96-c0245d77da28@suse.de>
Date: Tue, 6 Feb 2024 10:23:43 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fnic: move fnic_fnic_flush_tx() to a work queue
Content-Language: en-US
To: Lee Duncan <leeman.duncan@gmail.com>, linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Lee Duncan <lduncan@suse.com>
References: <cover.1706632031.git.lduncan@suse.com>
 <9c51ef07a04413fb2f2bd20f1534f96e004e4e59.1706632031.git.lduncan@suse.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <9c51ef07a04413fb2f2bd20f1534f96e004e4e59.1706632031.git.lduncan@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_DN_SOME(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 1/31/24 00:42, Lee Duncan wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Rather than call 'fnic_flush_tx()' from interrupt context we should
> be moving it onto a work queue to avoid any locking issues.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Lee Duncan <lduncan@suse.com>
> ---
>   drivers/scsi/fnic/fnic.h      | 3 ++-
>   drivers/scsi/fnic/fnic_fcs.c  | 3 ++-
>   drivers/scsi/fnic/fnic_main.c | 1 +
>   drivers/scsi/fnic/fnic_scsi.c | 4 ++--
>   4 files changed, 7 insertions(+), 4 deletions(-)
> 
Can you please add the 'fixes' tag to this one, too?
Just the first patch doesn't fix anything, one really would
need to apply both to get the issue fixed.

And, of course, fix the kbuild robot warning :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich



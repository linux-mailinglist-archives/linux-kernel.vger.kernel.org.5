Return-Path: <linux-kernel+bounces-75119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F69385E37A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8851EB23104
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDCF8062A;
	Wed, 21 Feb 2024 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="liGWQtuX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WCrNkXME";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ySjyfA4K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NcXkLAsf"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E56579DAE
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533445; cv=none; b=lv7frJTpN/zH0Cl4a7S36vhAKhJ8q4JK+dFCpwqYfRHstPtZhM711tIihSpPALWqRc2pVyWZCPpQueISJxRJ08VjU/JTjiVk4OR4+icXlrXh4HU9H/pPmEkCXaBW3/1Peb4sBwUXBJhcsvoimJncndBy4V0U411M/hgdGsHrSAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533445; c=relaxed/simple;
	bh=vjN6ENOefd1y/6+wOzqQ8MYRdpz/P4xA1v2I0T86C4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4X1UhE6gbEMNMyTGh+fEqVC6+5LrAb/bvPSxzGm7m9mrEnagDznbkt2SGl70BE/+mnhF0E0RsoijW5YcG1jfKfqBHQHEH6LekFpT9+771uioCG7t/l7/hn8svHZH3IODusbvaAHtvCVYRpHs6ebPIPqmO+9udiUwB3skE40SXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=liGWQtuX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WCrNkXME; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ySjyfA4K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NcXkLAsf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 339921F385;
	Wed, 21 Feb 2024 16:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708533442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSrgyzhrgoj3J1Jz96Fbq8RIb5QyNeDIaHMGnX2VQaI=;
	b=liGWQtuXZJPv7A+jBkq/WX+XRLCPGZYfe1MbDQV1dSNULqRJLsSB/FiLXSgq6LsiRkqbpj
	UuQuXoywQpuaFBVswpW4TFzVM+sGqgs+WA/iGaMwelyafnps7EWGeVnEx8MYMGScbxSV/J
	FprnRurv2mcgWzjHHtyoDepJdmlQT4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708533442;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSrgyzhrgoj3J1Jz96Fbq8RIb5QyNeDIaHMGnX2VQaI=;
	b=WCrNkXMELaMqI3nLAgcjgoRdKoPqqZDY00z/BYJbdn+ZvZU6zk/yMideo+q5ONMWUfzkwz
	6mkRbWBci5LTIeAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708533441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSrgyzhrgoj3J1Jz96Fbq8RIb5QyNeDIaHMGnX2VQaI=;
	b=ySjyfA4K3Iuubxrj7IU4ouJ+ZyXbaKAkuDUPOsSTFG6i2/KxqlkRCTgH19oSvVqFGtobWa
	KwddicJFWhYjTTaNq3SQC5FQbKGxbZPRO8L2Zii+KC5WmnI3zkU1Hr8+0uuIMYfC/JMiMM
	9JfMrxV4jjlXFajZcMMmErA53noaRss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708533441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSrgyzhrgoj3J1Jz96Fbq8RIb5QyNeDIaHMGnX2VQaI=;
	b=NcXkLAsfECxbqPIfK/iOjA+/bZ+xh+KEh5F62y1HI7YOWNXqFKCZ5rv9M0sIKkSzsZGizg
	uyXlBXvOu6C9hfAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A154139D1;
	Wed, 21 Feb 2024 16:37:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id NqXaBMEm1mVcaAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 21 Feb 2024 16:37:21 +0000
Date: Wed, 21 Feb 2024 17:37:20 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: James Smart <james.smart@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2 2/5] nvme-fc: do not retry when auth fails or
 connection is refused
Message-ID: <sqmla42yoidail73xukhxb6uoyayo66pxpdlrhns3v533wm7wy@ppyr7t5gk3u3>
References: <20240221132404.6311-1-dwagner@suse.de>
 <20240221132404.6311-3-dwagner@suse.de>
 <d5b3d5b2-ec27-4057-aa76-63fe17066cfc@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5b3d5b2-ec27-4057-aa76-63fe17066cfc@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.61 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[49.31%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.61

On Wed, Feb 21, 2024 at 04:53:44PM +0100, Hannes Reinecke wrote:
> On 2/21/24 14:24, Daniel Wagner wrote:
> > There is no point in retrying to connect if the authentication fails.
> > 
> > Connection refused is also issued from the authentication path, thus
> > also do not retry.
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> >   drivers/nvme/host/fc.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> > index a5b29e9ad342..b81046c9f171 100644
> > --- a/drivers/nvme/host/fc.c
> > +++ b/drivers/nvme/host/fc.c
> > @@ -3312,6 +3312,8 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
> >   			ctrl->cnum, status);
> >   		if (status > 0 && (status & NVME_SC_DNR))
> >   			recon = false;
> > +		if (status == NVME_SC_AUTH_REQUIRED || status == -ECONNREFUSED)
> > +			recon = false;
> >   	} else if (time_after_eq(jiffies, rport->dev_loss_end))
> >   		recon = false;
> Is this still required after the patchset to retry authentication errors?

Do you mean

  48dae46676d1 ("nvme: enable retries for authentication commands")

?

In this case yes, I've tested on top of this patch. This breaks the loop
where the provided key is invalid or is missing. The loop would happy
retry until reaching max of retries.


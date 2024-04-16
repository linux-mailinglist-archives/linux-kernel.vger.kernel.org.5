Return-Path: <linux-kernel+bounces-146372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EE28A6468
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F131C21817
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46636F076;
	Tue, 16 Apr 2024 06:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vj4EW+4t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dpkAv4KP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vj4EW+4t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dpkAv4KP"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0A61118E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713250631; cv=none; b=SuwztWOHNB+fa1bON8jAzG4bEkfNlJdDIqaAtEKkswaMNp7rcBCpkWZe3/SAEkOsfrxWJkrtfsYHCJOVWASvOuTWHnwLEQuoR9/bD4R/ZjIkWh4JBHB+xHdwenpC0uxaX7xw9kQ6PbLG2ajTNrHNjV84vprx2PrQy+U0tpdBKfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713250631; c=relaxed/simple;
	bh=WKHtuH8Gx7kUl4FQtUMN8fBPl3cJQszGY5vYAKUkzPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tk/ovWuXL30wH9PgGm+5aUbFU9uM9uKl1lEJ3/3j2nU6TRzfIinhmasoU3rVjWvoDm0Dxt2r3dt4ajjJTp/dvXBdZJ9JtmaE185AzzwxnlhEeqxLIZ2K7hPCRh2K218DhpENZIPnTkALdTMP+rhBZIvGUTMTvaC01vuk2EzaaCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vj4EW+4t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dpkAv4KP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vj4EW+4t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dpkAv4KP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4540637903;
	Tue, 16 Apr 2024 06:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713250622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tO6YKqvR1Orl0Jyn0aSJ7A85sVhbE34JsSsizeJW7qY=;
	b=Vj4EW+4tSFjfDqc+RvANS6DYpNtTdAXdIK7O1g5MF//WY+Rf+HzYMC3oUtIePdw1ZPmw93
	RLUAZGITwpzYLBZtEdguI197S/4tsSBSV/TnEAtsooHU9F6QoSBARLpMTm38eVH60mzdz1
	CfU/A4zZ6z/A3N5S7d6WzZuHwLNAjaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713250622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tO6YKqvR1Orl0Jyn0aSJ7A85sVhbE34JsSsizeJW7qY=;
	b=dpkAv4KPIgwZ57QQEkDBGR+06uqkjsX1dPp6kzqD2KZSlfOlKbDZRcPBqXd+XtqtFh4ivN
	PvRz0jTsGsJzoABw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713250622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tO6YKqvR1Orl0Jyn0aSJ7A85sVhbE34JsSsizeJW7qY=;
	b=Vj4EW+4tSFjfDqc+RvANS6DYpNtTdAXdIK7O1g5MF//WY+Rf+HzYMC3oUtIePdw1ZPmw93
	RLUAZGITwpzYLBZtEdguI197S/4tsSBSV/TnEAtsooHU9F6QoSBARLpMTm38eVH60mzdz1
	CfU/A4zZ6z/A3N5S7d6WzZuHwLNAjaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713250622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tO6YKqvR1Orl0Jyn0aSJ7A85sVhbE34JsSsizeJW7qY=;
	b=dpkAv4KPIgwZ57QQEkDBGR+06uqkjsX1dPp6kzqD2KZSlfOlKbDZRcPBqXd+XtqtFh4ivN
	PvRz0jTsGsJzoABw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E92013931;
	Tue, 16 Apr 2024 06:57:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R47nCT4hHmYgSgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 16 Apr 2024 06:57:02 +0000
Date: Tue, 16 Apr 2024 08:57:01 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/5] nvme-fabrics: handle transient auth failures
Message-ID: <qn4grwiboyzfoeqnow2decvvnq7wpymsc6yt5o6kxmmllrdlpj@6ymom3pxgsj6>
References: <20240415124220.5433-1-dwagner@suse.de>
 <20240415124220.5433-6-dwagner@suse.de>
 <51fc1a3f-7166-49cf-9652-a95bdc5d2119@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51fc1a3f-7166-49cf-9652-a95bdc5d2119@grimberg.me>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[]

On Mon, Apr 15, 2024 at 11:51:19PM +0300, Sagi Grimberg wrote:
 > -	if (status < 0)
> > +	if (status < 0) {
> > +		/*
> > +		 * authentication errors can be transient, thus retry a couple
> > +		 * of times before giving up.
> > +		 */
> > +		if (status == -EKEYREJECTED &&
> > +		    ++ctrl->nr_auth_retries < 3)
> > +			return true;
> 
> I did not suggest nr_auth_retries.

Correct. I explained why I didn't want to use nr_reconnect counter here.

> Where is the 3 coming from? The controller already
> has a number of reconnects before it gives up, no reason to add
> another one.

Sure, but seem to you consider all EKEYREJECTED errors are transient.
But this is just not correct. There is also the case where the key is
not correct on the first connect attempt for example, or the ctrl key
gets updated but not the host key.

> Just don't return false based on the status if it is a transient
> authentication error.

Not all authentication errors are transient.

> The patch just needs to be modified from
>     if (status < 0)
> to
>     if (status < 0 && status != -EKEYREJECTED Plus a comment that explains
> it.

This is not correct. This patch is not following the specification
already and I don't think we should bend the rules too much. Hence why I
limited the reconnect attempt on auth errors to 3 attempts.


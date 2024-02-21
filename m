Return-Path: <linux-kernel+bounces-74758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B425E85D8E6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E41E282928
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A57C3EA71;
	Wed, 21 Feb 2024 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g/GtBXNk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+XYzAtzE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="prrG8c77";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iFuUtGVp"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFE369973
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521116; cv=none; b=QxrJ6lCKdjBjtHbY/u/yWOuQ/XN6u9QyGtI0bAkQqKCj3EXURCE2AP/STgXifWIXEB2Mz9ntw2qQOF+39a2EZXVZbBmB0nVNhpsm8T8tg0OzM1u/bWENzekZhjPhQFaMYvZxf1un2K5lk+fNH+/ahvEpjqZ+CgLGooEwjPVW+KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521116; c=relaxed/simple;
	bh=xMA29PDFG2r2/VIFEVCyCdFC9LE7vNJZ4G5Uz3jhE6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/xIA9M6jzBaD6AVC2fiKpEWoiklAeKwd0TdA2CNmJv+uK4Xy+YquqHWB6GxUQPKLLBwhgzaJW/QD3DPgxbSaM2C9DB3VcRditpud23cgPbg/4QUy4mJFK2bkWLGtwPe2V2UW/pJ7W4OeFE/uJGySR4nVK8Al8KvaAe8CjXcp9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g/GtBXNk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+XYzAtzE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=prrG8c77; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iFuUtGVp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA40D1FB61;
	Wed, 21 Feb 2024 13:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708521113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yvVVrhvjHY4YuhOA+lFM2mTu+paFlyivAKigptrpqHU=;
	b=g/GtBXNkKWP5JrW7cv9laXx5edqXaQQVc48kGrVmc+oKgKb/FOD1ME75+FZf0T3qJFB0m9
	aeRxpO22ax9vIJS+cmqL3/JjP4dWCWmTHg1iMXVP0P0rNqr+zgKTXLLFzvJFB5vN3lohzk
	J1SJwRI0gt4KyXrqnOq5kRzWvMCYkS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708521113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yvVVrhvjHY4YuhOA+lFM2mTu+paFlyivAKigptrpqHU=;
	b=+XYzAtzEB6TecJShy6AA4PgOG0qGC++CpIICYBBAOadcAMcHcVguaJN+bm7rWLAQKeloiw
	L4EPw3JeJAOk8eBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708521112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yvVVrhvjHY4YuhOA+lFM2mTu+paFlyivAKigptrpqHU=;
	b=prrG8c77QgQvuZlRsBK9Lap62Z5RYC0HEenOAOTscDU2ZkMirsBXK5i5f2v398BSY4ucDT
	hD9+jQL5OOBy04bgCrN8qS0Dv6o6ZpGJBOOnTSpDp608N8TgErNHEcUSM3XhkuRh2kqwoN
	rVgCqGFdiQfQRgzHaQKyyQ6iL6wEp+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708521112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yvVVrhvjHY4YuhOA+lFM2mTu+paFlyivAKigptrpqHU=;
	b=iFuUtGVp8jTIMrqcERYrWQR1yhziFCqCAi9pcDC+GGaLYElAlXvtytMx5A8uicsMEpg/iM
	CH4ssaTE3XMc7FCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D729B13A25;
	Wed, 21 Feb 2024 13:11:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id oRwXM5j21WVSOgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 21 Feb 2024 13:11:52 +0000
Date: Wed, 21 Feb 2024 14:11:51 +0100
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-fc: move RCU read lock to nvmet_fc_assoc_exists
Message-ID: <xe7nvn5qnwolv5fnhmjxkmbh7uk7pckqsa66ndmqakqk7kbt4v@zxuwbppfq6io>
References: <20240212102940.11137-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212102940.11137-1-dwagner@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.23 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.63)[92.67%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.23

On Mon, Feb 12, 2024 at 11:29:40AM +0100, Daniel Wagner wrote:
> The RCU lock is only needed for the lookup loop and not for
> list_ad_tail_rcu call. Thus move it down the call chain into
> nvmet_fc_assoc_exists.
> 
> While at it also fix the name typo of the function.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

ping


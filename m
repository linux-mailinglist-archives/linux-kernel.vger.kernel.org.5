Return-Path: <linux-kernel+bounces-95775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A43875260
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657A61C23082
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D519912CDB6;
	Thu,  7 Mar 2024 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ttccUmx1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pqxNk3pz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ttccUmx1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pqxNk3pz"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618992B9A5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823211; cv=none; b=A75ksOrqBuPprBeS8GOJYWCIatkCTWAvzXWpK88rWvDqkv9ecoH1L1bzjmkyhL6T/TCw1V2A7qkZkrXCQEPeyUvbULsjRVEL6ZdDgmmETxX/lH6/JbNGiaMIMuIejajPS00yBkc25bb7N5NjjEYJ8sWGjmBatvkkjJuVO27mZeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823211; c=relaxed/simple;
	bh=GNSxQPg6Y6Kc97whzJ98RTS1q0QGeuTcWWwXCEa7ZCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nq5nV3hcUgog8YCGNdwgClrdzZ6lGV8biwZ8H6hWPkoclzmXFJ6Ii5kpcA2hYEdo6Y9TbaGlBRE7qbLZ3mEyZG8OCVeQ+0CMhtThDMw2MmRw3Vd6hQeQcoGWCut+yOMCBdpw4btNZXGrqNF/5TGUhFt0x60Q+4kw2i47UU9Vayw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ttccUmx1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pqxNk3pz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ttccUmx1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pqxNk3pz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 906A925B68;
	Thu,  7 Mar 2024 12:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709815415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xFSrhPAhdeU+042oYvavyOjg/sVd7TdbAFR+fQA1Bpc=;
	b=ttccUmx1QeU+BppR9JgrXCg9E9b7S7d/IVMycDyD0IYMF/srVgCssFrEyZKN+rEwkpmD2O
	CYugHIodpUJYPr4jQGjf+0kGfvaQxs+FQEQGLumK0g5A9Xt9cKAp+IQH4UonxuVZfYDmuN
	ms8BGU6kmjBl8D17nVD8TP5D9YZYPNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709815415;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xFSrhPAhdeU+042oYvavyOjg/sVd7TdbAFR+fQA1Bpc=;
	b=pqxNk3pzkXGBijZ0OTzkrXQGf/dILR6pSr8Q0sAfGmWzSN/YtK399b/p1hksivbcSMtFHo
	8pzU8CtDYHZ9eVDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709815415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xFSrhPAhdeU+042oYvavyOjg/sVd7TdbAFR+fQA1Bpc=;
	b=ttccUmx1QeU+BppR9JgrXCg9E9b7S7d/IVMycDyD0IYMF/srVgCssFrEyZKN+rEwkpmD2O
	CYugHIodpUJYPr4jQGjf+0kGfvaQxs+FQEQGLumK0g5A9Xt9cKAp+IQH4UonxuVZfYDmuN
	ms8BGU6kmjBl8D17nVD8TP5D9YZYPNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709815415;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xFSrhPAhdeU+042oYvavyOjg/sVd7TdbAFR+fQA1Bpc=;
	b=pqxNk3pzkXGBijZ0OTzkrXQGf/dILR6pSr8Q0sAfGmWzSN/YtK399b/p1hksivbcSMtFHo
	8pzU8CtDYHZ9eVDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E86B13997;
	Thu,  7 Mar 2024 12:43:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id i7HVHXa26WXGRwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 07 Mar 2024 12:43:34 +0000
Date: Thu, 7 Mar 2024 13:43:33 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, James Smart <james.smart@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] nvme-fc: do not retry when auth fails or
 connection is refused
Message-ID: <qbzzr6waj23q6rxrueevwoteg5i4ogr7hr45ckseu7ekdcc7sb@xgyvtkp27w5i>
References: <20240221132404.6311-1-dwagner@suse.de>
 <20240221132404.6311-3-dwagner@suse.de>
 <d5b3d5b2-ec27-4057-aa76-63fe17066cfc@suse.de>
 <sqmla42yoidail73xukhxb6uoyayo66pxpdlrhns3v533wm7wy@ppyr7t5gk3u3>
 <609e0031-e97c-466b-8cbd-47755374b117@suse.de>
 <3xhhdconprn3vvkky4yj4iazku4eiqxl6l6rw6z5tivvdjwaby@ts7satqbih7w>
 <hxr2hztb64dank3jvbnrlciaebo4k2qkkrg3brhrppizeyelpo@ewupxurl7iqm>
 <5d67a55e-e979-4c3c-8dcc-597cb13c7c9d@suse.de>
 <83bca01f-fc34-405b-9f2e-8079130400ce@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83bca01f-fc34-405b-9f2e-8079130400ce@grimberg.me>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ttccUmx1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pqxNk3pz
X-Spamd-Result: default: False [-4.42 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 URIBL_BLOCKED(0.00)[suse.de:dkim];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.11)[88.35%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Score: -4.42
X-Rspamd-Queue-Id: 906A925B68
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu, Mar 07, 2024 at 12:25:16PM +0200, Sagi Grimberg wrote:
 > > Is this what you had in mind?
> > 
> > Which, incidentally, is basically the patch I just posted.
> 
> Reading this, the patchset from Hannes now is clearer.
> Isn't the main issue is that nvme-fc tries to periodicly reconnect
> when failing the first connect? This is exactly what the test expects
> it to do right?

Yes, the test expects that the initial connect attempt fails. nvme-fc is
using one connect path and doesn't distinguish between the initial
connect attempt and a reconnect.

All fabric transport share the same problem when the connection has been
established and later one a connection drop happens and a reconnnect is
executed. The blktest nvme/048 case extension I've posted tests the
reconnect attempt after the controller key has changed. In this
scenario, nvme-tcp, nvme-rdma will also do a reconnect attempt although
DNR is set.


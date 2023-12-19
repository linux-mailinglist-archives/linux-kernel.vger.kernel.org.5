Return-Path: <linux-kernel+bounces-5315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D10DC818955
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7137BB24342
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0BC1C29F;
	Tue, 19 Dec 2023 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2X57Y3fw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8Pk5sz7z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2X57Y3fw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8Pk5sz7z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669181C2A6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B29F1F7C9;
	Tue, 19 Dec 2023 14:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702994795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oAjLQT6gn05Z9roydajMT4zSvFciQsK05XyxNtJgkcA=;
	b=2X57Y3fw1TdNtGI1/031xX2325PpBjBvpeaPpx/CgimyWnR+wopnuEEv699UmDWdLcImst
	SdfyVEKeFvDo3DISK5TKqur/miLSmd0gt1oPhPCZDsYN7cohaMNXIxPh9eDvrjvG3YM9m1
	NcTCOVbVnU9Sbo4KcCoe5lZfAf20z9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702994795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oAjLQT6gn05Z9roydajMT4zSvFciQsK05XyxNtJgkcA=;
	b=8Pk5sz7zMLWcvaQcHcYGfpYTjdpYSeEtMiEOxEXdreQzv2GDMDs6jLvtVKmwxB0f6Sm+RC
	B0SwEZ3saZjGNrBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702994795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oAjLQT6gn05Z9roydajMT4zSvFciQsK05XyxNtJgkcA=;
	b=2X57Y3fw1TdNtGI1/031xX2325PpBjBvpeaPpx/CgimyWnR+wopnuEEv699UmDWdLcImst
	SdfyVEKeFvDo3DISK5TKqur/miLSmd0gt1oPhPCZDsYN7cohaMNXIxPh9eDvrjvG3YM9m1
	NcTCOVbVnU9Sbo4KcCoe5lZfAf20z9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702994795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oAjLQT6gn05Z9roydajMT4zSvFciQsK05XyxNtJgkcA=;
	b=8Pk5sz7zMLWcvaQcHcYGfpYTjdpYSeEtMiEOxEXdreQzv2GDMDs6jLvtVKmwxB0f6Sm+RC
	B0SwEZ3saZjGNrBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FAF813BF1;
	Tue, 19 Dec 2023 14:06:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id iixpAWujgWXAcQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 19 Dec 2023 14:06:35 +0000
Date: Tue, 19 Dec 2023 15:06:30 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH v3 17/17] nvmet-fc: add extensive debug logging
Message-ID: <f6hnsoxuzpul3lkplkgcl4ceem6pf5dwdjgjav6auc4yjfvj3z@hefpryyoue4i>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-18-dwagner@suse.de>
 <c40a4b0e-fb0e-40fa-985c-92c6895eb831@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c40a4b0e-fb0e-40fa-985c-92c6895eb831@suse.de>
X-Spam-Level: *
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.28 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.47)[97.61%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2X57Y3fw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8Pk5sz7z
X-Spam-Score: -2.28
X-Rspamd-Queue-Id: 2B29F1F7C9

On Tue, Dec 19, 2023 at 12:54:12PM +0100, Hannes Reinecke wrote:
> On 12/18/23 16:31, Daniel Wagner wrote:
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> 
> Well ... all previous patches had 'XX/16', only this has '17/17'.
> Late addendum?
> But in either case, please ensure correct counting (and spelling!)
> on the next submission.

Sorry, this patch was not meant to go out. It's just debuggin code for
me.


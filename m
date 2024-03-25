Return-Path: <linux-kernel+bounces-117717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 062D988AEC3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687DA305E80
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9734954905;
	Mon, 25 Mar 2024 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dojTplWF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="phLqAdzQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dojTplWF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="phLqAdzQ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54F03FE37;
	Mon, 25 Mar 2024 18:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391605; cv=none; b=Eq407QjVt4VNumtJ5MUS/dRoJL4dNt8ue6zroN09tIGDYQhTNitccLIkj3zWWydNFb3bh9ZNm3w+GS/LveIxtEXcf1rcyaQBUbGjb+mvB99GPqJ+mlJLcYJbtCq+tTT+HezKNYsPgK961oHhszUzEfS0HQ3HEbcMamAJodJFeh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391605; c=relaxed/simple;
	bh=Yxk4m8d7LalfSXRRRG03wdvuw+sqOeO1OkoHBbeW0AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOjrse/AxBs0Bqcda2uk13HQpbOXuumhJeBIvH6vogDX42oFtCj/tk1QtNeJSVvdJucTN4RWVNCd1eBBYQ+8VO3QIslQbF88E8aca1f11XqF2UcgU/me8H+wxlGcq5c3C+TkiaCwtm4hw5e9ADvZp6l9ycxqenNOUzFsjbgLndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dojTplWF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=phLqAdzQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dojTplWF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=phLqAdzQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C8AB224D7;
	Mon, 25 Mar 2024 18:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711391598;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Of8gQ3uWJx2XPDmOVf+BHc8HVH3ZTHXn91pmh2Ulgok=;
	b=dojTplWFbBvoLH7kOKwYnCRFTRAxAR0cFLxtolz87OZcY/em4P3kRMLRISyRiRoS5vxnGb
	93v2z7oFMpW0NToz9Lu0ZMaHE4VfDxIgNdsdwEqtVB07RebNp8jUPdwyx+iaVD2W2U4Y4y
	mv5wCEAQ5EPNCUxMuGmIbziIcWD8jdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711391598;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Of8gQ3uWJx2XPDmOVf+BHc8HVH3ZTHXn91pmh2Ulgok=;
	b=phLqAdzQwb/yMrwO8xUj5nhhD6NfgFzm3jLYruL6DMAlvew5EfHHWXmkmlYa908cI11vnX
	W7WuSIV88/rGB6Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711391598;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Of8gQ3uWJx2XPDmOVf+BHc8HVH3ZTHXn91pmh2Ulgok=;
	b=dojTplWFbBvoLH7kOKwYnCRFTRAxAR0cFLxtolz87OZcY/em4P3kRMLRISyRiRoS5vxnGb
	93v2z7oFMpW0NToz9Lu0ZMaHE4VfDxIgNdsdwEqtVB07RebNp8jUPdwyx+iaVD2W2U4Y4y
	mv5wCEAQ5EPNCUxMuGmIbziIcWD8jdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711391598;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Of8gQ3uWJx2XPDmOVf+BHc8HVH3ZTHXn91pmh2Ulgok=;
	b=phLqAdzQwb/yMrwO8xUj5nhhD6NfgFzm3jLYruL6DMAlvew5EfHHWXmkmlYa908cI11vnX
	W7WuSIV88/rGB6Bg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 19F2013A2E;
	Mon, 25 Mar 2024 18:33:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id xmctBm7DAWa4XwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 25 Mar 2024 18:33:18 +0000
Date: Mon, 25 Mar 2024 19:25:56 +0100
From: David Sterba <dsterba@suse.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>, Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 5.15 005/317] btrfs: add and use helper to check if block
 group is used
Message-ID: <20240325182556.GN14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240324233458.1352854-1-sashal@kernel.org>
 <20240324233458.1352854-6-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324233458.1352854-6-sashal@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dojTplWF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=phLqAdzQ
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.59)[92.40%]
X-Spam-Score: -2.80
X-Rspamd-Queue-Id: 2C8AB224D7
X-Spam-Flag: NO

On Sun, Mar 24, 2024 at 07:29:45PM -0400, Sasha Levin wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> [ Upstream commit 1693d5442c458ae8d5b0d58463b873cd879569ed ]
> 
> Add a helper function to determine if a block group is being used and make
> use of it at btrfs_delete_unused_bgs(). This helper will also be used in
> future code changes.
> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Please drop this patch from all stable branches unless it's a
prerequisite for some other patch. This is clearly a cleanup.


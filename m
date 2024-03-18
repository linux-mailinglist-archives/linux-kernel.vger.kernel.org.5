Return-Path: <linux-kernel+bounces-106544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 714A787F024
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4CA283CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E912556466;
	Mon, 18 Mar 2024 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3bmfbIhp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wBDMufWN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3bmfbIhp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wBDMufWN"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6222E55C14;
	Mon, 18 Mar 2024 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710788753; cv=none; b=oL5nvm6hHp/8ekBl1yvLen+ZMI+SIGajFL0E7hLErVr1yXS+3wPH/5qhZ6Ch+A3X9vjFYiLIf33++4Ka7zW6AhjATrpKuDLqx2gvdwpKVYPD98b67/NPEkbtYgeN95fjmrKyNi+/fB6l92VK/oUUSSIHRfR9j8hRMgouFNXbWII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710788753; c=relaxed/simple;
	bh=Mht4IjPTPbiVxklqtYVZxHMsoaQVQkLBmLv8VDC5ro4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puWxLO7ArtbBSch3GLunWuugsIRcKKvFGbacsuxfhTBFnZfOW8rPu1I/788el8va4gZG6C4Tp9o0v/T2jb/HW7kLMc7W1IXcf3TPxjQ0gM9IIr03kDN9lA3kBcV/tJqaFN64Wa2/ANgmeFibNVpa2mD1O6QHHYk3/KzO+d5XPvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3bmfbIhp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wBDMufWN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3bmfbIhp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wBDMufWN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0DCF34E11;
	Mon, 18 Mar 2024 19:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710788749;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6mzBoP4Rx2h04+Ob6weFKLFhQYf79XaB88sBTL4zNKg=;
	b=3bmfbIhp2LoNb5NSB75nHf2wS4bfGrf2gIF/io/nYXjN44dKxV9B2Ut+edHuIR+4n6UFbJ
	jz+8k5KW/wDjWQOjcR9DGCBIpEHelmlfHNNgpov47fsu30fagptDjb45aohUbfommL4xlV
	ttDdjzeLDDXqHIt0/umM/+umP+uyIwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710788749;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6mzBoP4Rx2h04+Ob6weFKLFhQYf79XaB88sBTL4zNKg=;
	b=wBDMufWN94l+fjjU8hpHOErbXK6BQ95le6/bl59iB6oKyQqilrKMeHyVOJdzdbKmaCTw3h
	n5rnf6TaYdYN8NBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710788749;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6mzBoP4Rx2h04+Ob6weFKLFhQYf79XaB88sBTL4zNKg=;
	b=3bmfbIhp2LoNb5NSB75nHf2wS4bfGrf2gIF/io/nYXjN44dKxV9B2Ut+edHuIR+4n6UFbJ
	jz+8k5KW/wDjWQOjcR9DGCBIpEHelmlfHNNgpov47fsu30fagptDjb45aohUbfommL4xlV
	ttDdjzeLDDXqHIt0/umM/+umP+uyIwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710788749;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6mzBoP4Rx2h04+Ob6weFKLFhQYf79XaB88sBTL4zNKg=;
	b=wBDMufWN94l+fjjU8hpHOErbXK6BQ95le6/bl59iB6oKyQqilrKMeHyVOJdzdbKmaCTw3h
	n5rnf6TaYdYN8NBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86CE2136A5;
	Mon, 18 Mar 2024 19:05:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kvizII2Q+GXDGgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 18 Mar 2024 19:05:49 +0000
Date: Mon, 18 Mar 2024 19:58:36 +0100
From: David Sterba <dsterba@suse.cz>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: linux-next: build failure after merge of the btrfs-fixes tree
Message-ID: <20240318185836.GG16737@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240318091755.1d0f696f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318091755.1d0f696f@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.01
X-Spamd-Result: default: False [-1.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.01)[50.84%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-0.99)[-0.995];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 TO_DN_ALL(0.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On Mon, Mar 18, 2024 at 09:17:55AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the btrfs-fixes tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> fs/btrfs/volumes.c: In function 'btrfs_scan_one_device':
> fs/btrfs/volumes.c:1413:55: error: 'bdev_handle' undeclared (first use in this function)
>  1413 |         if (btrfs_skip_registration(disk_super, path, bdev_handle->bdev->bd_dev,
>       |                                                       ^~~~~~~~~~~
> fs/btrfs/volumes.c:1413:55: note: each undeclared identifier is reported only once for each function it appears in

I've updated the for-next snapshot so it contains the updated version
that is based on top of the required changes. The same patch will be
also sent for merge.


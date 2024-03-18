Return-Path: <linux-kernel+bounces-106469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F177A87EF0E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 686FAB21537
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440355579D;
	Mon, 18 Mar 2024 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r5acfYKb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pzb5Dzut";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r5acfYKb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pzb5Dzut"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC27C374CB;
	Mon, 18 Mar 2024 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783499; cv=none; b=ph0KET8jHG659+raJGszuvtDGOLVRn+liDS8uc3g8fA7B4OgqTPgCsDGyEBj/O5p3uhbpKIk0iXsxmJyA2UufxNGswbw+itpAC5YkiqyBvBSXE8Samu7tzuEfM+wOie9molkM12V2SlBNREyEfGRFHbmjz80nlqUJYN62yi7bnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783499; c=relaxed/simple;
	bh=brMabtGVAVPTn4BOLl5qxz9oAua4OXqtQFzWar13NBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbVvzWQFHpFXnVzY38ivJyMbRCsIabmJ/8lvZuqIvldmkXWcEeV5lrZ9YnYH9g+T5C55Vx+wUdG0UctNg2XCLerYyknf6K72UjI2etlq6O5z22GAsZ6Ta/8Da/4cP4Cywy5zRhF7QC4s+CUn7Akx9F7uf9rP+7LWroq4n3QK8BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r5acfYKb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pzb5Dzut; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r5acfYKb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pzb5Dzut; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E0A9D5C80D;
	Mon, 18 Mar 2024 17:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710783493;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i9KtxmJe4u+gXhi6vxQQsvto+Xk9+LnXPNm2ix/8clI=;
	b=r5acfYKb4IWgXoOnLqtBmnj+akX3lExnpM5JVeWN2Yn+eC2qcM8hhL+rI3iE40oTB9HV07
	UDFETcVfEvij7DR0FtsHciCeIRhUJxBG0pgFLSrG+cTmU54azQj1gLs9/KWmZIBKtIa0fX
	DHNMHsUcbxkb2rdp7V4Uwkxd/C2PEbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710783493;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i9KtxmJe4u+gXhi6vxQQsvto+Xk9+LnXPNm2ix/8clI=;
	b=Pzb5DzutVR/j+TIQ+roiNWGp1acJT8IGhDssUNb9pEF+z8fvDQRw6VjIA7gy/rIDeTQC/n
	SRp90gNK7Vii41Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710783493;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i9KtxmJe4u+gXhi6vxQQsvto+Xk9+LnXPNm2ix/8clI=;
	b=r5acfYKb4IWgXoOnLqtBmnj+akX3lExnpM5JVeWN2Yn+eC2qcM8hhL+rI3iE40oTB9HV07
	UDFETcVfEvij7DR0FtsHciCeIRhUJxBG0pgFLSrG+cTmU54azQj1gLs9/KWmZIBKtIa0fX
	DHNMHsUcbxkb2rdp7V4Uwkxd/C2PEbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710783493;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i9KtxmJe4u+gXhi6vxQQsvto+Xk9+LnXPNm2ix/8clI=;
	b=Pzb5DzutVR/j+TIQ+roiNWGp1acJT8IGhDssUNb9pEF+z8fvDQRw6VjIA7gy/rIDeTQC/n
	SRp90gNK7Vii41Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C382E1349D;
	Mon, 18 Mar 2024 17:38:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aWKULwV8+GUGfgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 18 Mar 2024 17:38:13 +0000
Date: Mon, 18 Mar 2024 18:31:00 +0100
From: David Sterba <dsterba@suse.cz>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
	Christian Brauner <brauner@kernel.org>
Cc: Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: linux-next: build failure after merge of the btrfs-fixes tree
Message-ID: <20240318173100.GD16737@suse.cz>
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
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=r5acfYKb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Pzb5Dzut
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.00)[37.35%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 TO_DN_ALL(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -1.21
X-Rspamd-Queue-Id: E0A9D5C80D
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
> 
> Caused by commit
> 
>   cc019bc0d55b ("btrfs: do not skip re-registration for the mounted device")
> 
> I have used the btrfs-fixes tree from next-20240315 for today.
> 
> This is actually caused by an interaction with commit
> 
>   9ae061cf2a46 ("btrfs: port device access to file")
> 
> which has been in Linus' tree since March 12 (and linux-next since Feb 26).

I would really appreciate if all infrastructure changes to btrfs code
have CC:linux-btrfs@, the whole series "Open block devices as files" has
never been CCed so the build breakage is noticed only by accident. Also
I wonder why I have to repeatedly ask for that and why people think that
doing broad changes to code maintained by somebody else is ok.

There are 26 patches in linux-next intersecting fs/btrfs most of which I
see for the first time now. I don't have time to read fsdevel@ regularly
and act rather on events (i.e. CC or mails).

VFS is in the center of many other subsystems I understand that adding
the CC: manually is not feasible but scripting "if $path add CC:$subsys"
should be doable, namely when it's not just one-time job. Please try to
find some middle ground between efforts and patch workflow sanity.
Thanks for understanding.


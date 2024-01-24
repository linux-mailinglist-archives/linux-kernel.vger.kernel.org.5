Return-Path: <linux-kernel+bounces-37695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D3E83B3F4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB37286B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4EB1353F3;
	Wed, 24 Jan 2024 21:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DwDxmHgr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I01wXHBd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DwDxmHgr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I01wXHBd"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8091353E3;
	Wed, 24 Jan 2024 21:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131957; cv=none; b=cW0AlpbLgokoqys2XJJVN6X/5oi2wWfXFKoTlo3zOZgBrXA3KaV1Nj1tnauOlHl9EswIKDEv3wjRjTeMPsZoQ/zNsaImnCtuDoOUtXF2asTAJg64hRoNrVWKUzL4WZ7KnvMANAvveh+L9ow7mXdIWvs+lCsOp6B+4BR2pJhsUYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131957; c=relaxed/simple;
	bh=IKAPTbygAg3N66rq9PTfeiB3VaRzSNIRAilIMr1UjIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BferAVhX4mY25HVjP7MP4uBIcQ/VpH488zZ8KSLyqEGCI8jIvDe2jUum9hd0ghUfsASTOthikjmDjqmcH4XOma56bEZ4Na/USstkph7Mje0+Z46+skCQV+xE4MBUTJoAcNC91Gk+MIWUDF1bNnC54+d+VKnLNiSOxWrEVn2w5GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DwDxmHgr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I01wXHBd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DwDxmHgr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I01wXHBd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 24A472208A;
	Wed, 24 Jan 2024 21:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706131954;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IKAPTbygAg3N66rq9PTfeiB3VaRzSNIRAilIMr1UjIc=;
	b=DwDxmHgrskxmoyDo0V7FXj7CIU9DDWL/WLSkUS2otWICxEwyDvtj3/OA8qgaOdEjOJtNkw
	JJXn/fkfXPuKzvpL9uhvORTlK8TuIj7p/zU2Ues+5raZqffLtTrj94Xj+dAiti0sZvb+fu
	jkHBhTsQj8eM70HsPtvrwq9c9B+MkHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706131954;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IKAPTbygAg3N66rq9PTfeiB3VaRzSNIRAilIMr1UjIc=;
	b=I01wXHBdssrZauT//zqhCjZ5yuFuy0j5uK4rbGqFWRUQ8ko6U+K5Qp/W0G298Qpfd0xkXX
	K5LF/4iZcrB4YOAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706131954;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IKAPTbygAg3N66rq9PTfeiB3VaRzSNIRAilIMr1UjIc=;
	b=DwDxmHgrskxmoyDo0V7FXj7CIU9DDWL/WLSkUS2otWICxEwyDvtj3/OA8qgaOdEjOJtNkw
	JJXn/fkfXPuKzvpL9uhvORTlK8TuIj7p/zU2Ues+5raZqffLtTrj94Xj+dAiti0sZvb+fu
	jkHBhTsQj8eM70HsPtvrwq9c9B+MkHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706131954;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IKAPTbygAg3N66rq9PTfeiB3VaRzSNIRAilIMr1UjIc=;
	b=I01wXHBdssrZauT//zqhCjZ5yuFuy0j5uK4rbGqFWRUQ8ko6U+K5Qp/W0G298Qpfd0xkXX
	K5LF/4iZcrB4YOAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C48F113786;
	Wed, 24 Jan 2024 21:32:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WDIVLvGBsWVZewAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 24 Jan 2024 21:32:33 +0000
Date: Wed, 24 Jan 2024 22:32:32 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Thomas Bertschinger <tahbertschinger@gmail.com>,
	Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org, ltp@lists.linux.it
Subject: Re: bcachefs fails to mount loop device on kernel
Message-ID: <20240124213232.GA356523@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240124200032.GA343522@pevik>
 <20240124205149.GA268968@fedora-laptop>
 <20240124210738.GA352616@pevik>
 <5ykyohhnlc7nkbz7usc5sqmluyl7wgyhc6frqmbo5kk4vhuu3c@kgzze4c35gsv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ykyohhnlc7nkbz7usc5sqmluyl7wgyhc6frqmbo5kk4vhuu3c@kgzze4c35gsv>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org,lists.linux.it];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.00)[87.21%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.30

> On Wed, Jan 24, 2024 at 10:07:38PM +0100, Petr Vorel wrote:
> > > On Wed, Jan 24, 2024 at 09:00:32PM +0100, Petr Vorel wrote:
> > > > Hi all,

> > > > bcachefs fails to mount loop device on kernel on both 6.7 and 6.8.0-rc1.
> > > > Is mounting loop even supported?

> > > > [...]

> > > > bcachefs mount /dev/loop0 /mnt
> > > > => Unknown command mount

> > > What version of the bcachefs CLI tool are you using? Is it distribution
> > > provided or did you build it yourself?

> > Official openSUSE Tumbleweed package:

> > $ rpm -qf $(which bcachefs)
> > bcachefs-tools-1.4.0-1.1.x86_64

> Sounds like Suse isn't building with our Rust code - but, that's about
> to become mandatory...

Indeed NO_RUST=1. Thank you both for a quick info!

Kind regards,
Petr


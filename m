Return-Path: <linux-kernel+bounces-52447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27DA849855
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EBD8B26C74
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B170018638;
	Mon,  5 Feb 2024 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BDC4N4tL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lHSJ5A72";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BDC4N4tL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lHSJ5A72"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528F21862B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131071; cv=none; b=up3xecHOHag7ZlYOREV9oBPjogouuDMhrWmPUFWhp4JoA+oQ33fxRyjFwvqpdriiXD0FT4dmRd4WdYwB+qmtnWUc1O5VbwS4UaT9JgfpY4J/w/BTJl+sFFlJ0pkCYpkIdJE6u964G/cSdPBlQ8DGMhlVl7aQ72qtWuwxezhU1+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131071; c=relaxed/simple;
	bh=GJc/HD3I91CSWrhG1VaX5rx7KU7vffyvnTXbDyE7oOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEd1mbASl55vwHqPIx1jMGjhUMeAomI6HyK8LTbUJQB0JIXCgrLyTByV59TKHygegHzovuNx640jiRJyr9NuSzY2iz7a8tcpIWGvAoxI3si9yA3DNwaUfEoDtAAeEbxccmBw70wa2dg3xtOB/qOEjY12b3hUAB5WCKlSplh/5Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BDC4N4tL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lHSJ5A72; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BDC4N4tL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lHSJ5A72; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9119C22105;
	Mon,  5 Feb 2024 11:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707131067;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GJc/HD3I91CSWrhG1VaX5rx7KU7vffyvnTXbDyE7oOU=;
	b=BDC4N4tL77M7wzLYLPAISimsvrYlWFbo0F7ZUEt3zmNdUQ/taqEKloVf6lkhyp8AgBrVfJ
	j00Q3Y2Rgbo+2or830GQOkfRs8XnbvJAolYJFSEq3yGuCmTBBd7GtHMKevxtcNRRpO/FNV
	br2OnbT489xEsuow/Vjp+2ndtR8z5fU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707131067;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GJc/HD3I91CSWrhG1VaX5rx7KU7vffyvnTXbDyE7oOU=;
	b=lHSJ5A72SdjNmwxr4mkb52PY4X2R8H7kQ+vLPvjtkWjsdww1giYMfT/6envWDBX0X1a3/i
	TbN3Lb4ddAdZ/1AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707131067;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GJc/HD3I91CSWrhG1VaX5rx7KU7vffyvnTXbDyE7oOU=;
	b=BDC4N4tL77M7wzLYLPAISimsvrYlWFbo0F7ZUEt3zmNdUQ/taqEKloVf6lkhyp8AgBrVfJ
	j00Q3Y2Rgbo+2or830GQOkfRs8XnbvJAolYJFSEq3yGuCmTBBd7GtHMKevxtcNRRpO/FNV
	br2OnbT489xEsuow/Vjp+2ndtR8z5fU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707131067;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GJc/HD3I91CSWrhG1VaX5rx7KU7vffyvnTXbDyE7oOU=;
	b=lHSJ5A72SdjNmwxr4mkb52PY4X2R8H7kQ+vLPvjtkWjsdww1giYMfT/6envWDBX0X1a3/i
	TbN3Lb4ddAdZ/1AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1561D132DD;
	Mon,  5 Feb 2024 11:04:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C5KCOrrAwGU8OgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 05 Feb 2024 11:04:26 +0000
Date: Mon, 5 Feb 2024 12:04:25 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
	linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
	lwn@lwn.net, automated-testing@lists.yoctoproject.org
Cc: Andrea Cervesato <andrea.cervesato@suse.de>
Subject: Re: [LTP] [ANNOUNCE] The Linux Test Project has been released for
 JANUARY 2024
Message-ID: <20240205110425.GB201808@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <ZbjZxy4vbxoXUJ-i@yuki>
 <20240203235708.GA164636@pevik>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203235708.GA164636@pevik>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.62 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.08)[63.23%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.62

Hi all,

> Hi all,

> > Good news everyone,

> > the Linux Test Project test suite stable release for *January 2024* has been
> > released.

> > Since the last release 315 patches by 34 authors were merged.

> > Patch review is what most of the projects struggle with and LTP is no
> > different. If you can spare some effort helping with the patch review is more
> > than welcomed.

> > NOTABLE CHANGES
> > ===============

> FYI, there is missing removal of runtest/connectors [1], which can break some
> tooling.

And we removed also runtest/fsx [2] in this release.

Kind regards,
Petr

> Kind regards,
> Petr

> [1] https://github.com/linux-test-project/ltp/commit/9b642d89c0bcf5885b051c2d5768fa94b61d86cb
[2] https://github.com/linux-test-project/ltp/commit/fb2b6a0b3c840aa80229acf4360b7bdc3ced5edb
..


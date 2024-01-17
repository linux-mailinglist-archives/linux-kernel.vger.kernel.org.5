Return-Path: <linux-kernel+bounces-29441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E94830E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808B1283DCB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DC025543;
	Wed, 17 Jan 2024 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sIIp90rM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wrEptCGb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sIIp90rM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wrEptCGb"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7785E250F7;
	Wed, 17 Jan 2024 20:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705524891; cv=none; b=brSopAF5K/e2IKiFBby7bPVfYJSOGRxQYQ3Y7qzi0vaP4pyLFKfmqFtgbou/k/oPvQBoCbFqNmBL0JtgNnsGN5gkQH+Wi6ETF88jMNsE11JuVTjlvOv+oluCr3legDtxlrB7YO8B8uRoJ9ru9WaM7hYnlrOKiPX+dMbjLyCa4jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705524891; c=relaxed/simple;
	bh=rbg+A44ujg+zI3+b+2yS9FSAkzS5pu5O1NUvXux1hnI=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spamd-Result:X-Spam-Level:
	 X-Spam-Flag:X-Spam-Score; b=acDECHirYUwNUknJL0IUYAA0EFt+HPKj8fMUpW6zHK8uvPfBOL+C6z7g4roE1qWQqA8Br8UDnCkH/luZZKTVihHS8bma4ciz6Pm2TtgvBJruYR/T0TLgCw2aLSveZvhJNMtOhT0R5cle1nMZLS0gt5xHzbS+H1/WOpgBRZwGId8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sIIp90rM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wrEptCGb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sIIp90rM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wrEptCGb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 97EA41F394;
	Wed, 17 Jan 2024 20:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705524887;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vBdrM0ktWZjFjYmSlHT3ogI8TwiqogCBpUXXtCJpsR4=;
	b=sIIp90rMwsY6OpVLGyKn+N3Kp+N4dh463ePZho4WiGghpWi/NUxunVM2OSp4KUFgkYXKVh
	tYe0yeY3dQejZm4fE/Kp25LJBc8pkOjD1s1EGxyWQRCG3rbPBCBwn04vDDhKpouvs+9gwT
	v1PJU2EVLvoBlDlTupB5F6Oiw5HrHyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705524887;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vBdrM0ktWZjFjYmSlHT3ogI8TwiqogCBpUXXtCJpsR4=;
	b=wrEptCGb4W3EF+AfjMw9XAn7pmzEpI55FZUu3FkG3T15V3a1PGvpr2rdi8CKjrOO+UpoOV
	LzkkGTLoeJT6fHAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705524887;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vBdrM0ktWZjFjYmSlHT3ogI8TwiqogCBpUXXtCJpsR4=;
	b=sIIp90rMwsY6OpVLGyKn+N3Kp+N4dh463ePZho4WiGghpWi/NUxunVM2OSp4KUFgkYXKVh
	tYe0yeY3dQejZm4fE/Kp25LJBc8pkOjD1s1EGxyWQRCG3rbPBCBwn04vDDhKpouvs+9gwT
	v1PJU2EVLvoBlDlTupB5F6Oiw5HrHyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705524887;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vBdrM0ktWZjFjYmSlHT3ogI8TwiqogCBpUXXtCJpsR4=;
	b=wrEptCGb4W3EF+AfjMw9XAn7pmzEpI55FZUu3FkG3T15V3a1PGvpr2rdi8CKjrOO+UpoOV
	LzkkGTLoeJT6fHAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60DC413751;
	Wed, 17 Jan 2024 20:54:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kUI2Fpc+qGU7ewAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 17 Jan 2024 20:54:47 +0000
Date: Wed, 17 Jan 2024 21:54:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-man@vger.kernel.org
Subject: Re: [PATCH v2alx] MAINTAINERS: Add man-pages git trees
Message-ID: <20240117205445.GC2723246@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <ZafC1MkKDAK2s6n1@debian>
 <20240117122315.15698-1-alx@kernel.org>
 <20240117130705.GB2711070@pevik>
 <ZafXNac8p8CKk1_U@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZafXNac8p8CKk1_U@debian>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.14 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.84)[85.34%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.14

> Hi,

> On Wed, Jan 17, 2024 at 02:07:05PM +0100, Petr Vorel wrote:
> > Hi,

> > > As the man-pages README documents:

> > > $ sed -n '/^Versions/,/^[^ ]/p' README | head -n-1;
> > > Versions
> > >    Distribution
> > >        <https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/>
> > nit: Shouldn't this be kernel.org instead of mirrors.edge.kernel.org?

> I actually don't know.  Was wondering, because kernel.org redirects
> there, but didn't know which subdomain I should document.  If it should
> have no subdomain, would you mind sending a patch?  Thanks!

Sure, I'll do.

Kind regards,
Petr

> > >        <https://www.alejandro-colomar.es/share/dist/man-pages/>

> > >    Git
> > >        <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/>
> > >        <https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/>

> > >    Online man-pages
> > >        PDF
> > >              <https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/book/>
> > >              <https://www.alejandro-colomar.es/share/dist/man-pages/>
> > >        HTML
> > >              <https://man7.org/linux/man-pages/index.html>

> > > Suggested-by: Petr Vorel <pvorel@suse.cz>
> > > Signed-off-by: Alejandro Colomar <alx@kernel.org>

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Thanks!

> Have a lovely day,
> Alex


> > @Andrew: whoever is going to mere, please take this commit
> > instead of mine.


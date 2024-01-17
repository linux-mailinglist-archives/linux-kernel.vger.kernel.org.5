Return-Path: <linux-kernel+bounces-29004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AFE830699
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F19D1F23690
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18CA1EB36;
	Wed, 17 Jan 2024 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AzjYBTOZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ckceKCiT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AzjYBTOZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ckceKCiT"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922251EB2B;
	Wed, 17 Jan 2024 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496832; cv=none; b=kVbevBieTNxJAftKk9C0y/TDBLrp67bZU5kyhXdBumJyTDY7Z3O1pdCO8z/9ZH2nyq0HX8+etrZwPOVrs9s9yRBlqz8fqXr/HR6tQPFwCemJptWS5/tguIslocm84Hu+cDxPO7xejQoCMlIGqSYhtwNhJpHYDT5IfRyGeV1858g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496832; c=relaxed/simple;
	bh=SkuncACiR3s6vdS0cHOnRyK9pUTxAfsgZ7RNWTI2eDI=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Level:X-Spamd-Bar:
	 X-Rspamd-Server:X-Spamd-Result:X-Spam-Score:X-Rspamd-Queue-Id:
	 X-Spam-Flag; b=SQZu+0ksHNzLK39zgPXgh6Y1zKaA/Llu+Ewb3qoA1//OEzGUgPgFQyrNlFx8MvN/Cmnuims54PiFIAsWngPd+vxiAj5cjzFd+IVe4vHKiHITJbI3o5JLpeIEJNzgMNlEyx4Phl98/5fKxzqAE1QQ7mfeqkX1VYkbAn9ISesfoN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AzjYBTOZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ckceKCiT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AzjYBTOZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ckceKCiT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C1C6E1FC0C;
	Wed, 17 Jan 2024 13:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705496827;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A/5DMlFdAM4OP41mGYYm4e4L3yUtV/ECQdQHiMSwJEU=;
	b=AzjYBTOZZY+gnZ92HN1BY37iMoTFa6XjI7uryfnoTUsy+uMmJgGsSRxZHS8YzSVI4/3tPp
	ZRWqvPwyLq8Mpvcmbyq9Wqm8bqOwpRTnSEfUhWiesm+OdpJCBJ+Icj6f1NFetf3ZqEvePH
	4ZXinVcdKLqFNmuXA3xuyvTQ+unD2Pk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705496827;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A/5DMlFdAM4OP41mGYYm4e4L3yUtV/ECQdQHiMSwJEU=;
	b=ckceKCiTVNRjHPKNOwHfzgaaOUu5naxFYmbs1CjtfhDzfe/A07rNhupG5A6NMP+94r8Ioe
	3PktXpVP8NcsJhDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705496827;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A/5DMlFdAM4OP41mGYYm4e4L3yUtV/ECQdQHiMSwJEU=;
	b=AzjYBTOZZY+gnZ92HN1BY37iMoTFa6XjI7uryfnoTUsy+uMmJgGsSRxZHS8YzSVI4/3tPp
	ZRWqvPwyLq8Mpvcmbyq9Wqm8bqOwpRTnSEfUhWiesm+OdpJCBJ+Icj6f1NFetf3ZqEvePH
	4ZXinVcdKLqFNmuXA3xuyvTQ+unD2Pk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705496827;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A/5DMlFdAM4OP41mGYYm4e4L3yUtV/ECQdQHiMSwJEU=;
	b=ckceKCiTVNRjHPKNOwHfzgaaOUu5naxFYmbs1CjtfhDzfe/A07rNhupG5A6NMP+94r8Ioe
	3PktXpVP8NcsJhDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87F3713800;
	Wed, 17 Jan 2024 13:07:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VKMcH/vQp2W6ZgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 17 Jan 2024 13:07:07 +0000
Date: Wed, 17 Jan 2024 14:07:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-man@vger.kernel.org
Subject: Re: [PATCH v2alx] MAINTAINERS: Add man-pages git trees
Message-ID: <20240117130705.GB2711070@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <ZafC1MkKDAK2s6n1@debian>
 <20240117122315.15698-1-alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117122315.15698-1-alx@kernel.org>
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AzjYBTOZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ckceKCiT
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.71 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[44.42%]
X-Spam-Score: -0.71
X-Rspamd-Queue-Id: C1C6E1FC0C
X-Spam-Flag: NO

Hi,

> As the man-pages README documents:

> $ sed -n '/^Versions/,/^[^ ]/p' README | head -n-1;
> Versions
>    Distribution
>        <https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/>
nit: Shouldn't this be kernel.org instead of mirrors.edge.kernel.org?

>        <https://www.alejandro-colomar.es/share/dist/man-pages/>

>    Git
>        <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/>
>        <https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/>

>    Online man-pages
>        PDF
>              <https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/book/>
>              <https://www.alejandro-colomar.es/share/dist/man-pages/>
>        HTML
>              <https://man7.org/linux/man-pages/index.html>

> Suggested-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Alejandro Colomar <alx@kernel.org>

Reviewed-by: Petr Vorel <pvorel@suse.cz>

@Andrew: whoever is going to mere, please take this commit
instead of mine.

Kind regards,
Petr
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)

> diff --git a/MAINTAINERS b/MAINTAINERS
> index a59214c48e52..e5d90cd0ed8c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12749,6 +12749,8 @@ M:	Alejandro Colomar <alx@kernel.org>
>  L:	linux-man@vger.kernel.org
>  S:	Maintained
>  W:	http://www.kernel.org/doc/man-pages
> +T:	git git://git.kernel.org/pub/scm/docs/man-pages/man-pages.git
> +T:	git git://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git

>  MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP)
>  M:	Jeremy Kerr <jk@codeconstruct.com.au>


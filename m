Return-Path: <linux-kernel+bounces-143870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C38A8A3E89
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 22:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA8F1F21792
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 20:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72815467B;
	Sat, 13 Apr 2024 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lI+AREYZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Mt/UF+94";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lI+AREYZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Mt/UF+94"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910221CABA;
	Sat, 13 Apr 2024 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713040751; cv=none; b=E4jxwAhbYy416SQiSFnoi2qKFHKNdT3koQpmzmftWcfdBAly/QzKF6lnHZKn9iieWKEVm4CFEr34mQlMZHCpR1hyi2DHGAjtsloA4Xwp5JAvQhkJyxieqwmCtXxSW5QFIt++vFht9Wcu08LPPcGkWl74yJZ0KYCSqXEXY9iBrf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713040751; c=relaxed/simple;
	bh=K7TkiYMgUYlPmXv8ilMJAp1j+yeVcR9ZeHT9tFmsuSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJUlZ85vPHyrsHZWGkwy6mEwv4bJhVACqroFDmTdEYHl3po1w7aWyO3ZjdmDGZjIooxv1m50nFEZZJybJ+8l1CLXFmKLVfsQlDKptVmYBRAtD1xdcZW4yc+iIkRcTNicDkUDNWnz4lUB1Leg9n0jrtXec7d/SLOqLA0azmknwl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lI+AREYZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Mt/UF+94; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lI+AREYZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Mt/UF+94; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 41E0034120;
	Sat, 13 Apr 2024 20:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713040742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+Z/h/6l/30nYC5Gp5Ck6rYrSVsMIV8/9sXq2H2vdqQ=;
	b=lI+AREYZXVLvMMXrvyGx2fgXl0PddZLuF3gzkL3I+XtEVxSzAgPzKGd7mY1/KLsAU/RIo9
	9C5OI+vbCZ3NrM0PQ63IpgGbm63vgqPkCuILo491Gp/ZzUZHMY9C7HJADozRWEfXacYT+H
	70RXioFjIWZZ+T+JXUHX9EO9iWkQTgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713040742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+Z/h/6l/30nYC5Gp5Ck6rYrSVsMIV8/9sXq2H2vdqQ=;
	b=Mt/UF+94SRxRZH5u3huivNtUQNKIzOb/GtKdogmCQuipQR1OS1ccioe6OXEUR9bA6h/JEP
	EttGif6DQIy2qvCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713040742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+Z/h/6l/30nYC5Gp5Ck6rYrSVsMIV8/9sXq2H2vdqQ=;
	b=lI+AREYZXVLvMMXrvyGx2fgXl0PddZLuF3gzkL3I+XtEVxSzAgPzKGd7mY1/KLsAU/RIo9
	9C5OI+vbCZ3NrM0PQ63IpgGbm63vgqPkCuILo491Gp/ZzUZHMY9C7HJADozRWEfXacYT+H
	70RXioFjIWZZ+T+JXUHX9EO9iWkQTgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713040742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+Z/h/6l/30nYC5Gp5Ck6rYrSVsMIV8/9sXq2H2vdqQ=;
	b=Mt/UF+94SRxRZH5u3huivNtUQNKIzOb/GtKdogmCQuipQR1OS1ccioe6OXEUR9bA6h/JEP
	EttGif6DQIy2qvCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 641FA138A7;
	Sat, 13 Apr 2024 20:39:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e3NPEWTtGmZ7KgAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Sat, 13 Apr 2024 20:39:00 +0000
Date: Sat, 13 Apr 2024 22:38:57 +0200
From: Jean Delvare <jdelvare@suse.de>
To: "Arnd Bergmann" <arnd@arndb.de>, "Stephen Rothwell"
 <sfr@canb.auug.org.au>
Cc: "Arnd Bergmann" <arnd@kernel.org>, linux-kbuild@vger.kernel.org,
 "Masahiro Yamada" <masahiroy@kernel.org>, "Nathan Chancellor"
 <nathan@kernel.org>, "Greg Kroah-Hartman" <gregkh@suse.de>, "Nicolas
 Schier" <nicolas@fjasle.eu>, "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt"
 <justinstitt@google.com>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [PATCH 05/12] firmware: dmi-id: add a release callback function
Message-ID: <20240413223857.7c01985f@endymion.delvare>
In-Reply-To: <28ba40ea-7f48-41b0-ae57-99a870e68fb8@app.fastmail.com>
References: <20240326144741.3094687-1-arnd@kernel.org>
	<20240326145140.3257163-4-arnd@kernel.org>
	<20240329134917.579c3557@endymion.delvare>
	<63909b0a-7d76-418d-a54c-1061bd3b6e11@app.fastmail.com>
	<20240408095943.48e6c0cc@endymion.delvare>
	<28ba40ea-7f48-41b0-ae57-99a870e68fb8@app.fastmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Fri, 12 Apr 2024 11:42:03 +0200, Arnd Bergmann wrote:
> On Mon, Apr 8, 2024, at 09:59, Jean Delvare wrote:
> > On Thu, 04 Apr 2024 16:07:55 +0200, Arnd Bergmann wrote:  
> >> On Fri, Mar 29, 2024, at 13:49, Jean Delvare wrote:  
> >> > Will you get this upstream, or do you expect me to take it in my
> >> > dmi/for-next branch?    
> >> 
> >> It would help me if you can apply it to your tree directly.  
> >
> > OK, it's in my dmi-for-next branch now:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git/log/?h=dmi-for-next  
> 
> I see it's in your tree, but I don't see your tree in linux-next.
>
> As all the other fixes from my series got merged, I would like to
> merge the patches that turn the warnings on, but that still
> causes a build-time regression.
> 
> Is there a reason for the dmi-next tree not being part of
> linux-next, or should we ask Stephen (added to Cc) to add it?

Hmm, Stephen cleaned up the list of trees he pulls from 2 months ago.
Back then, I objected that I may use my tree again in the future, and I
thought he had added it back to the list, but maybe I misunderstood.

Stephen, can you check if you still pull from tree above, and if not,
add it back to the list? Thanks in advance.

-- 
Jean Delvare
SUSE L3 Support


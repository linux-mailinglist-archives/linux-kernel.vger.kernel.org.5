Return-Path: <linux-kernel+bounces-80015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C94CC8629BF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 09:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A90C1F21BCF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 08:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3DAEADD;
	Sun, 25 Feb 2024 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k1PYwpu1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NYTbIS6R";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ksRXk5YP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P7auLrYg"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BA2DF46;
	Sun, 25 Feb 2024 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708850425; cv=none; b=Gsf7jtgMnwTXk35jsu3oKVvz00OsVJj4gKti1h5yJwrdIyiISmWwy2lX8g9HM960ZCzHOVCCF9lRvNDOu3+fsVIrx4+Z1EOSQOBYiHObt3j5XDfdvOq5hLksmSQ16fVtl7FcGegWLy4vpg9wZSqPohYT2GHhfJMe8/FiF1ADqgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708850425; c=relaxed/simple;
	bh=ketke7tFLj0W8MMVEzVgtUROAbel8yTey4ilIGnwHrU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNdhgR3GlOSJqOxqJBv6P2ajLfZ5cT/QUi55Cyq6Qoi2OTxrw8S6Y8JqF9rqkH0Erlv5z5G/DaYhGwwfyvtpsNcsp3AKxOe4EfOKutPSYxnB+Znm3vf5WXtH3Ttdc+seYpy9RCF4F78JmYJVErByITHFZr1FDqQlAMcUmkrKDVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k1PYwpu1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NYTbIS6R; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ksRXk5YP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P7auLrYg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0951222F4;
	Sun, 25 Feb 2024 08:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708849830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WDxev0PzOXwqIR40xYrI8UNdhC0AQO6nDkCM+OfJivk=;
	b=k1PYwpu1b7NJaS+JByRbY3PK482Mq4ex0XgaLxYHL8zDG6w8md7Hcb3fE2QdnsUI3Whrep
	7J//GcFCY8Mb69IvhmGf08LZ+01akiNF9CGpbEyFQS9fzxuFsk6accg1PoknJYRd4yINxZ
	nwdwxeeE28e5g0qcuAbHPjuO6FJa6jQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708849830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WDxev0PzOXwqIR40xYrI8UNdhC0AQO6nDkCM+OfJivk=;
	b=NYTbIS6RDdj0mwR+M2V4qNjN4z7fa+Wx9AjRc9i0t+j770jyPnwmDiqd1b4gwA53ZlzAlm
	HChCV9SIB9rRLhDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708849828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WDxev0PzOXwqIR40xYrI8UNdhC0AQO6nDkCM+OfJivk=;
	b=ksRXk5YPcn1hazrhtyUby9e8MzsOIdBjnfVA4DIrBTW4OL1t9CGm/mQiLRdAtLF9Vw56Vf
	7v+L5jozHmi/M1d3hHS1CcT915QoIa+5FBO3y1TjapdhAJUmSYLPc9jLl4esSLI0cwGjwm
	YEUGPja0hlcMCJaK7kwMsSjlLqn06ys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708849828;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WDxev0PzOXwqIR40xYrI8UNdhC0AQO6nDkCM+OfJivk=;
	b=P7auLrYgY4e3P8wEmCINY5ybv9rtJsO6qKIRvrksvS4PFO4QfVGmIC01iZE+r+Yd85TzYQ
	bjtYIrwHvdlgXiAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85DC313A5B;
	Sun, 25 Feb 2024 08:30:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IRbeHqT62mUkdQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 25 Feb 2024 08:30:28 +0000
Date: Sun, 25 Feb 2024 09:30:28 +0100
Message-ID: <87frxh0wuz.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Willian Wang <git@willian.wang>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] ALSA: hda/realtek: Add special fixup for Lenovo 14IRP8
In-Reply-To: <170879111795.8.6687687359006700715.273812184@willian.wang>
References: <170879111795.8.6687687359006700715.273812184@willian.wang>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.06 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[willian.wang:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.96)[99.83%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.06

On Sat, 24 Feb 2024 17:11:49 +0100,
Willian Wang wrote:
> 
> Lenovo Slim/Yoga Pro 9 14IRP8 requires a special fixup because there is
> a collision of its PCI SSID (17aa:3802) with Lenovo Yoga DuetITL 2021
> codec SSID.
> 
> Fixes: 3babae915f4c ("ALSA: hda/tas2781: Add tas2781 HDA driver")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=208555
> Link: https://lore.kernel.org/all/d5b42e483566a3815d229270abd668131a0d9f3a.camel@irl.hu
> Cc: stable@vger.kernel.org
> Signed-off-by: Willian Wang <git@willian.wang>

Applied now.  Thanks.


Takashi


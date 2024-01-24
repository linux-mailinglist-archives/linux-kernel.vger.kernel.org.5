Return-Path: <linux-kernel+bounces-37075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D987083AB17
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6B0290647
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4B377F26;
	Wed, 24 Jan 2024 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P2OicQ8p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RCi9SLJT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WNFwW3T4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LdfouFrw"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB04C77F14;
	Wed, 24 Jan 2024 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706103831; cv=none; b=JuI/83479zC3uEFS2n3k3gxCHGQlblIL2b9XEyNHju/XyGRkHjf+pbpc66K0e0OagOLxMMP5D3K4ek04xnRhGXs75mc5hDTPCWSyNsCJDP/NKeuUUSuOsXssHd9IkB5UqHRg9YASH5EiTTR+qwqu0AzChppia3EnOg4rWQVku8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706103831; c=relaxed/simple;
	bh=vMtRdSXgt7L8bMsRDxC0blHzjN8Dvs+MLmFOLF3aUE8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLf6jiV8rymMiIFjKhczJjkxgcezH589XITwwq8i80Y8NKR4lG8xZ0uncwikmYsBEUaPJ299+6mifQN+fGEEtdAIoph6Lye0mwVoAOugl/SocOJsPSyt7WrfJxNWORNj1DIp01xW37/vxQvppmay7tC2KIi37cy9m00vBFYTO6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=P2OicQ8p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RCi9SLJT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WNFwW3T4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LdfouFrw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D92B01FD64;
	Wed, 24 Jan 2024 13:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706103828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ws3ePQym3fkrskSLqJwcWIdMaVWU/CiRF9N+1vjYBSo=;
	b=P2OicQ8pGSacpqLm7iUQG2B5vy3P1/l/MrDvKZcJRNY37GObzFmMJNaX/WzlafZGKMWfG+
	yKj8JYkOvdF1qehGfymALMWn1oJIQIHxJafby9kt0YQp5r/Skfp2Sh/H1yF6SWQz1UnOg6
	wwNKiZ+8srHeBQzFZ+4qZ/RuwzXolBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706103828;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ws3ePQym3fkrskSLqJwcWIdMaVWU/CiRF9N+1vjYBSo=;
	b=RCi9SLJTxFtGi5sXX7JpxOq4DwrH/icBnW5ZhSEPWWQ/m0wX4UQKb2LpdP/16LRuH+kN85
	Fqc/WdPAdE1X2nCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706103827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ws3ePQym3fkrskSLqJwcWIdMaVWU/CiRF9N+1vjYBSo=;
	b=WNFwW3T4Erffs21hWG/t4hUxa+X71N58pWGz77On+c9oVDe4tFNsL7fREuxt0JO+Hl4p2U
	WoeNsO+6ua1IbNWAq2SnsL7/VMjpTanGyvY5UWLPoEK2uYJ1s67++Z7TyTzeQ3q9fSyur2
	nEVK8kk4loaoZpouqVM+MDnkTIaspbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706103827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ws3ePQym3fkrskSLqJwcWIdMaVWU/CiRF9N+1vjYBSo=;
	b=LdfouFrwy/9nZX25I4wD7TEfabsZc/sJ0wNTGck81gSokJZUOiGmFW62VMg4s6oY+kO1lo
	YYyUe7vC0GRU0yCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8190E13786;
	Wed, 24 Jan 2024 13:43:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id INk1HhMUsWVJSwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 24 Jan 2024 13:43:47 +0000
Date: Wed, 24 Jan 2024 14:43:47 +0100
Message-ID: <87plxqlucs.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<soyer@irl.hu>,
	<shenghao-ding@ti.com>,
	<perex@perex.cz>,
	<linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH 0/2] ALSA: hda: Move component binding support into separate library
In-Reply-To: <20240124112607.77614-1-rf@opensource.cirrus.com>
References: <20240124112607.77614-1-rf@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WNFwW3T4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LdfouFrw
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.89)[94.41%]
X-Spam-Score: -4.40
X-Rspamd-Queue-Id: D92B01FD64
X-Spam-Flag: NO

On Wed, 24 Jan 2024 12:26:05 +0100,
Richard Fitzgerald wrote:
> 
> The Cirrus Logic amplifiers are currently paired with Realtek HDA codecs.
> But they could be used with other codecs. To prepare for this, these two
> patches move the manager side of the component binding out of the Realtek
> driver into a library module.
> 
> The first patch tweaks the CS35L41 code so that it is not hardcoded to
> CS35L41, and changes the TAS2781 handling so that it re-uses that code
> instead of having a near-identical copy of it.
> 
> Can someone please test that these two patches don't break TAS2781?
> I have checked that they should work in theory but I don't have hardware
> to test on.
> 
> Richard Fitzgerald (2):
>   ALSA: hda: realtek: Re-work CS35L41 fixups to re-use for other amps
>   ALSA: hda: realtek: Move hda_component implementation to module

Through a quick glance, it looks good.
I'll wait for the verification for TAS codec for a while.


thanks,

Takashi


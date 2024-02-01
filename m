Return-Path: <linux-kernel+bounces-48183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421C084585F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63FB51C23B91
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE7686657;
	Thu,  1 Feb 2024 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ek3OiIZq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JSK7qn6W";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ek3OiIZq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JSK7qn6W"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54E58663A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792540; cv=none; b=XVTLqT6kdP7mm0QOKbPLvwm5x9lYlhcJLkCglUsXAvvebJe3ocJIYSJuIxrk4LQx92HcD+y6AFjRwHs7VM22YZ8E6VexrIjPT1VzIEzJwaDQUMzoCbpioYEJyBjQf6eeEJVaLbMQupFQMC5DMicIBLzJTq+gIkI7dvGP++blh2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792540; c=relaxed/simple;
	bh=LKjJBBd8SBZq1TlSMNPebvfGKgt0GBCGwuyqPIntk68=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g16Q4xAuzokI40iC0wbaBfF0qHzf/TmhoKooH5AgPPy/Glqt3oFeW69YfH2HZK6i7H2RD79RdSec+ERTk/XIfULzmtkkuL8QkKn5BDHb+OMb2zF6lX08CZkeB/Wd1ea2Qfcl+HoNYMKiLMNoggRrJSPXH1PZRAT4xFRCAKouJ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ek3OiIZq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JSK7qn6W; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ek3OiIZq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JSK7qn6W; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0660E21EC7;
	Thu,  1 Feb 2024 13:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706792537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ENmQXtGmZZRRih/heSUqRc9W6vtYC89xYf/keE9bwxc=;
	b=Ek3OiIZqYC4iLIYCWk/wLi1Cq2lFLS2CQ8GzvVIgUaHtyeiYAWo7/PbOhB8poGagpz8Ku4
	Hzrya7WB3qIDcgoWPA6v3dP4VAi7BJQmUdoK5vkomeRusu08mBoCXHLqKEAcScLZmq8PpB
	FTrMSlw3nIqJRZGL0Gqr8QedKPi5aAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706792537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ENmQXtGmZZRRih/heSUqRc9W6vtYC89xYf/keE9bwxc=;
	b=JSK7qn6Wydw/r4maaUjwF06TVZP55+X8TgcOPrcNFfJgvYLQto2OWMEsIOXMrzQNpsfrUf
	TteNYxGoiACqwuBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706792537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ENmQXtGmZZRRih/heSUqRc9W6vtYC89xYf/keE9bwxc=;
	b=Ek3OiIZqYC4iLIYCWk/wLi1Cq2lFLS2CQ8GzvVIgUaHtyeiYAWo7/PbOhB8poGagpz8Ku4
	Hzrya7WB3qIDcgoWPA6v3dP4VAi7BJQmUdoK5vkomeRusu08mBoCXHLqKEAcScLZmq8PpB
	FTrMSlw3nIqJRZGL0Gqr8QedKPi5aAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706792537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ENmQXtGmZZRRih/heSUqRc9W6vtYC89xYf/keE9bwxc=;
	b=JSK7qn6Wydw/r4maaUjwF06TVZP55+X8TgcOPrcNFfJgvYLQto2OWMEsIOXMrzQNpsfrUf
	TteNYxGoiACqwuBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE992139B1;
	Thu,  1 Feb 2024 13:02:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pPirLFiWu2XPPgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 01 Feb 2024 13:02:16 +0000
Date: Thu, 01 Feb 2024 14:02:16 +0100
Message-ID: <87frycz6av.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Alexander Tsoy <alexander@tsoy.me>
Cc: vincenttew <vincenttew@google.com>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: usb-audio: retry clock validate when it takes some times
In-Reply-To: <6872e9ea993633dff4e248f01cafd1ac32651355.camel@tsoy.me>
References: <20240201070641.401684-1-vincenttew@google.com>
	<6872e9ea993633dff4e248f01cafd1ac32651355.camel@tsoy.me>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00];
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
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[22.88%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.90

On Thu, 01 Feb 2024 11:36:11 +0100,
Alexander Tsoy wrote:
> 
> В Чт, 01/02/2024 в 15:06 +0800, vincenttew пишет:
> > Behringer UMC202HD and UMC404HD take some times to validate the clock
> > source. To prevent more DAC have the same delay which return the
> > false
> > in the first time, remove the USB id check to have a chance to retry
> > the
> > clock validate.
> > 
> > Signed-off-by: vincenttew <vincenttew@google.com>
> 
> Thank you for the patch! My thought about this change:
> - Retrying clock source validation probably make sense only in the case
> of Internal clock. But I'm not sure.

It's an interesting point.

> - If we want to make this a standard driver behaviour, then the code
> needs to be moved out of the quirk function IMO.

I'm a bit afraid of applying this unconditionally to all cases.  At
first, we can start with the vendor matching (e.g. MOTU and Behringer)
to apply it...


thanks,

Takashi


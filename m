Return-Path: <linux-kernel+bounces-51524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FF6848C2A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7761C225FF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5BD13FF5;
	Sun,  4 Feb 2024 08:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ERpNI16O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VMFGa6vv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ERpNI16O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VMFGa6vv"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7EC134C8;
	Sun,  4 Feb 2024 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707035424; cv=none; b=ZrUHHb+/1aKozTewz7okFW+VbCZyeJZHdcRJdzTo4lXvd6ntVPDcLRGwZ1QBKCx7vZx/oys3aOrqwpoXFdS9yhACO3/CvoWxTkt4qLFY1h81ORCO6NqsQ517L4sMw/06qK8PuVZmHsaIsh2iHaf4Ih2KjuamUXWvcxCiTFgZxeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707035424; c=relaxed/simple;
	bh=9N/yJ7y8H6y1WqEagbxcNeH/yIVeDjm6wuvCcT+jqJs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WsG3f8/Q9gy61Di0vtRQcGAWH5QyAPE/xELHawvFoikpOougBKD53NSRGGmJg687sw45ZByDb4UhNNaVQEyE596AYb/TsyN3jYtll+FIbm8cNYZjm3HZhecpRC3R8OA48qCYtunlVYQT7pcMv2xe7Mt0qF4dkBMffW88zTPfeUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ERpNI16O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VMFGa6vv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ERpNI16O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VMFGa6vv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A653B21E24;
	Sun,  4 Feb 2024 08:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707035419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SUWpvVlbtmQV6vlPcjlI3MUn/yKN5SBWzWr1t051fJw=;
	b=ERpNI16O1j4T8rc4JVXOORjMTM0KzR35yqytDPmmUBXdkDnEK8j4j4pqqNODEXXHT1UO+v
	95qlFDXY6hG6TcgYVkn3O4J6WCEkDFh1vr+iDFfvNaqx9nCkikMP27V/u+oFQlJcyC6EnL
	G21hMyWdecNKSFfdvIAXoDJ4nL2qK9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707035419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SUWpvVlbtmQV6vlPcjlI3MUn/yKN5SBWzWr1t051fJw=;
	b=VMFGa6vvVpxApVvrlxsVnHQLy/lursItxcFDLW3iHijaPyBaXpjSau0BPzPuSvaAUdTomv
	t4B3Rpvq20oRQoBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707035419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SUWpvVlbtmQV6vlPcjlI3MUn/yKN5SBWzWr1t051fJw=;
	b=ERpNI16O1j4T8rc4JVXOORjMTM0KzR35yqytDPmmUBXdkDnEK8j4j4pqqNODEXXHT1UO+v
	95qlFDXY6hG6TcgYVkn3O4J6WCEkDFh1vr+iDFfvNaqx9nCkikMP27V/u+oFQlJcyC6EnL
	G21hMyWdecNKSFfdvIAXoDJ4nL2qK9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707035419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SUWpvVlbtmQV6vlPcjlI3MUn/yKN5SBWzWr1t051fJw=;
	b=VMFGa6vvVpxApVvrlxsVnHQLy/lursItxcFDLW3iHijaPyBaXpjSau0BPzPuSvaAUdTomv
	t4B3Rpvq20oRQoBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68EFC132DD;
	Sun,  4 Feb 2024 08:30:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mx76FxtLv2UpeAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 04 Feb 2024 08:30:19 +0000
Date: Sun, 04 Feb 2024 09:30:19 +0100
Message-ID: <87h6iobpic.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	<alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH v2] ALSA: hda/realtek: Remove two HP Laptops using CS35L41
In-Reply-To: <20240202170842.321818-1-sbinding@opensource.cirrus.com>
References: <20240202170842.321818-1-sbinding@opensource.cirrus.com>
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
X-Spamd-Result: default: False [0.47 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.43)[78.54%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.47

On Fri, 02 Feb 2024 18:08:42 +0100,
Stefan Binding wrote:
> 
> The SKUs, and associated SSIDs, are no longer going to include the
> CS35L41. They may come back, but will need a different quirk.
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>

Thanks, applied with Fixes tag now.


Takashi


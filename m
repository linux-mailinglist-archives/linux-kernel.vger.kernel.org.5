Return-Path: <linux-kernel+bounces-122954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1752D890031
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9807CB2250A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7C480027;
	Thu, 28 Mar 2024 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xu+H7T4S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X3NrlaCY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xu+H7T4S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X3NrlaCY"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CC6224D0;
	Thu, 28 Mar 2024 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632475; cv=none; b=FZXDFk6+69P8e4F7ziEhQ/0C4Rrg+pLWWkSM2M8Qo0AN54xD11Y8FEN5CfoXUAhhbqt7Tx3HnTE21gxXtnu7n6Ggb8uTX4vZnRTiBDHaC67jDlQm0Oj3OgnTdddmBk8Z7nbLGvFORSA3AuYp3gLasQQprU+VkiV3TkBDPWPv2q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632475; c=relaxed/simple;
	bh=g3tbt5A5BMQBDg79luNWj/TFKk1HHVRlABZgpMrFlOM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vf7QIBUZFn16Rs7rBWFImeQR578gvpsQ64PdT+I51bivspiFeCt31yvtaSgoJGxXN8iJ6FrHMV1MuXleZSPQp8b6O1TQTYFNcKYb+WEFn3c0xh6bPcTTogZBvaexFBRhQ3Slb7a/EjACWmb8TyROWJOwKAoLNHK4iN+7cv9sg5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xu+H7T4S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X3NrlaCY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xu+H7T4S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X3NrlaCY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 531B122108;
	Thu, 28 Mar 2024 13:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711632472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D/5NMzBy++zM/SOjj+TwZy9DepUE4sr8/nvthOqPAGs=;
	b=xu+H7T4Sioipv/D3TthJI14A0IFPe2Pm+ctqciosloGTkKLIzYjgBzSy97BRVtE5+easc/
	3mdVQdfCk07eCMl2ogy3aH8PSYsCAY1hfpeHoAi9YmfrJIYRzM2ZTF/CSPftFgekVHYU6h
	WzuSoSxZedpd06ayhHS8/2Nyobrv3Po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711632472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D/5NMzBy++zM/SOjj+TwZy9DepUE4sr8/nvthOqPAGs=;
	b=X3NrlaCYLLAy4mgaqCn56VISB4nW4Kj/f4yxBAzZU62O3fCdmPEmPC8wkkFMk3NQoZ9/Cb
	aN0w/kEmP6L3jNBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711632472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D/5NMzBy++zM/SOjj+TwZy9DepUE4sr8/nvthOqPAGs=;
	b=xu+H7T4Sioipv/D3TthJI14A0IFPe2Pm+ctqciosloGTkKLIzYjgBzSy97BRVtE5+easc/
	3mdVQdfCk07eCMl2ogy3aH8PSYsCAY1hfpeHoAi9YmfrJIYRzM2ZTF/CSPftFgekVHYU6h
	WzuSoSxZedpd06ayhHS8/2Nyobrv3Po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711632472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D/5NMzBy++zM/SOjj+TwZy9DepUE4sr8/nvthOqPAGs=;
	b=X3NrlaCYLLAy4mgaqCn56VISB4nW4Kj/f4yxBAzZU62O3fCdmPEmPC8wkkFMk3NQoZ9/Cb
	aN0w/kEmP6L3jNBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3988F13AB3;
	Thu, 28 Mar 2024 13:27:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 9qBrDVhwBWbVPgAAn2gu4w
	(envelope-from <tiwai@suse.de>); Thu, 28 Mar 2024 13:27:52 +0000
Date: Thu, 28 Mar 2024 14:27:54 +0100
Message-ID: <87h6gqa3l1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: hda: cs35l56: Add ACPI device match tables
In-Reply-To: <20240328121355.18972-1-simont@opensource.cirrus.com>
References: <20240328121355.18972-1-simont@opensource.cirrus.com>
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
X-Spamd-Result: default: False [0.83 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.07)[61.99%];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: 0.83
X-Spam-Level: 
X-Spam-Flag: NO

On Thu, 28 Mar 2024 13:13:55 +0100,
Simon Trimmer wrote:
> 
> Adding the ACPI HIDs to the match table triggers the cs35l56-hda modules
> to be loaded on boot so that Serial Multi Instantiate can add the
> devices to the bus and begin the driver init sequence.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> Fixes: 73cfbfa9caea ("ALSA: hda/cs35l56: Add driver for Cirrus Logic CS35L56 amplifier")

Thanks, applied now.


Takashi


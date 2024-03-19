Return-Path: <linux-kernel+bounces-107688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CDF880036
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54AA128333C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C34651B2;
	Tue, 19 Mar 2024 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1cUP0qT7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m1WiMwch";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Tkos6GbM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eoyL9jBZ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD13651A1;
	Tue, 19 Mar 2024 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860675; cv=none; b=gyYcIQ7m70v+R+ZpihtGdycSbUwAECQpS/OHVwqAHfCwiNud+Hfh/v0NDWOYaWLnxJVR4hvhJrLtBdvc4Vi3Sn9H6zZGH7J4viN8C/P/2Sk81+39e3rQXbDIdLyDhu/iDJ0NwY2WolA1CYk0KqwqHSyXDhQFghO9AagEC+wN05k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860675; c=relaxed/simple;
	bh=CnHmYvOTVQqBWBgMglsKo/wCflgRyvMO93LZJA5CdcY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=caRE4EZQr78+88G3VkL0gApw0HIHeWXfIeCdYR4PAQ1hOiTjJNBoxu+LY9LXy9Af6l9baquZqooCi6zLBs1AEGG/+1koHWL3BSh0H5mk15oLtgYVYjN5U98v2cuNN94ldsY1u71I1c+ghS7VgFFO6RXI86YlFxNBp/vLQml66L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1cUP0qT7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m1WiMwch; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Tkos6GbM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eoyL9jBZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C4FD337AD6;
	Tue, 19 Mar 2024 15:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710860669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hgs5ti1DnziuiAxm1mEUG/mPvMMRg1EHnit+SH7Gajs=;
	b=1cUP0qT7dFm+RPX0pkU8ONVERgOFrBU14AFGZ0DszkGLET2NgZ2eLRyR0QFWyH7ygbggpf
	uAubnTxDrjJR1OCDmEOYRq3TJvl8/WhsrNbh1KI+QcAFwk789kCC6wLHrnVpy1h2khMwVD
	HgMPtS7kehbHmtSen0ULca62IpsvOg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710860669;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hgs5ti1DnziuiAxm1mEUG/mPvMMRg1EHnit+SH7Gajs=;
	b=m1WiMwchA4+7sFpj9cAVv+UvIj8/S6hA4Ulp0FlFZcYh5oIe7l9dXb+RhyWskXgDymtb8O
	P6DC2k1I32CDK6Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710860667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hgs5ti1DnziuiAxm1mEUG/mPvMMRg1EHnit+SH7Gajs=;
	b=Tkos6GbMNNQDI2DwRKGcZ1G4dzUSHMNCUGb/SCLUf96FDfo74ahh0LTmQpkvQECQa5Sw61
	f/wxl6SArOIMfnNFF2FXSkMNUYLSvTe3lJ9ZtSPuSxNXOEhhrwYwXwv5h8dnQTXOhfTOYV
	xFI6WvX8asYq/vtlBrCKgc7CfJDj+ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710860667;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hgs5ti1DnziuiAxm1mEUG/mPvMMRg1EHnit+SH7Gajs=;
	b=eoyL9jBZUCwQff80gzG1o6qEB6Zb7SQnC21bJh3fK0gg2AnpBxBossH60ymhXqXuArcYha
	9j4HSlzhMc6KpiAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91AC8136A5;
	Tue, 19 Mar 2024 15:04:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z1YJInup+WXNCAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 19 Mar 2024 15:04:27 +0000
Date: Tue, 19 Mar 2024 16:04:27 +0100
Message-ID: <87frwmuutg.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Anthony I Gilea <i@cpp.in>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda/realtek: Add quirk for HP Spectre x360 14 eu0000
In-Reply-To: <e2a7aaed-e9d7-4d36-8abf-b71dfd32a0ff@cpp.in>
References: <e2a7aaed-e9d7-4d36-8abf-b71dfd32a0ff@cpp.in>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -2.03
X-Spamd-Result: default: False [-2.03 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[cpp.in:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.73)[93.35%]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

On Mon, 18 Mar 2024 14:17:48 +0100,
Anthony I Gilea wrote:
> 
> My original patch was based on an old branch, sorry for that.
> I've re-done it against master and tested if everything works properly.
> 
> Cirrus amps support for this laptop was added in patch:
> 33e5e648e631 ("ALSA: hda: cs35l41: Support additional HP Envy Models")
> 
> This patch adds fixes for wrong pincfgs, wrong DAC selection and mute/micmute LEDs.
> 
> Signed-off-by: Anthony I Gilea <i@cpp.in>

Applied now.  Thanks.


Takashi


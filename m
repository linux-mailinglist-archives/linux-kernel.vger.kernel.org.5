Return-Path: <linux-kernel+bounces-125619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0EE8929B7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C578B214FE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 08:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC1B881F;
	Sat, 30 Mar 2024 08:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H6MV2wRl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LDvizGuC"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6975D8F56;
	Sat, 30 Mar 2024 08:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711787835; cv=none; b=tZ8cugPDsOyQLlfMI0aN3ZSKPcCH8UtdDtVIcKmHLpc4rjZc69BPVjmGcTdb+B7ysZ98lr/0VG0VpXrPLnOwvNrOC7LPAhV9IRyfCfBRvXsvBtK4AbBiewNnpGRFKwmFC0xJkyd/wIPwEz5YxWlh+ZzKW/T9WFXCUQ/DkMYWZSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711787835; c=relaxed/simple;
	bh=qv4hyVsIvmt5Bq6NA2R6FwrpbOOVexFZzPalmbJNY0E=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdIsUSepiJji3mJWH1UpoosEACFu8v5eiqLxIwdPSdA52mWSrYYA9o0KmPHTeyP5REFWlqumwI7KpeYMdk8qzyOlRILOwxfovCIxrk8iaOmC2q6agGS5ql50BT4kN62Tl+qSrlDT2Dv8F6SK4MxHh//xa+YPn5tt278k6hnjhsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H6MV2wRl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LDvizGuC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 66FDC5D2D4;
	Sat, 30 Mar 2024 08:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711787831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R0U17UcQkJPXOJuESkycL6rC9ilcoFaU7jMNRPVmuYE=;
	b=H6MV2wRlVelbTNLqOQu0pQydoWQ/o+Wh/PwMZhSWF1zBdJ4v1l61K7Tb+mLolkyWEzrOm0
	XsuXvilH5p+EX6LRD66aKBi1isJBCnlli3FxbTNb3spXj3Ta9WAtz32hO/b01AmWZjMSYd
	KqRIoquxSKtFz1k9s4hvz30MK/9O6yA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711787831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R0U17UcQkJPXOJuESkycL6rC9ilcoFaU7jMNRPVmuYE=;
	b=LDvizGuCuyIraCn6HRQuYHzcNTPLdQtkmUOwjKUI7iph47c3uWv5wvrrlZkNe0zTphDlXv
	Z3LLnfg3+oDqNMAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 20C2E13A90;
	Sat, 30 Mar 2024 08:37:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id p3VzBjfPB2Y5bgAAn2gu4w
	(envelope-from <tiwai@suse.de>); Sat, 30 Mar 2024 08:37:11 +0000
Date: Sat, 30 Mar 2024 09:37:13 +0100
Message-ID: <87plvcnmiu.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirks for ASUS Laptops using CS35L56
In-Reply-To: <20240329112803.23897-1-simont@opensource.cirrus.com>
References: <20240329112803.23897-1-simont@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: 5.50
X-Spam-Flag: NO
X-Spamd-Bar: +++++
X-Spamd-Result: default: False [5.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.996];
	 MID_CONTAINS_FROM(1.00)[];
	 NEURAL_SPAM_LONG(2.80)[0.800];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.19)[70.96%]
X-Spam-Level: *****
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 66FDC5D2D4

On Fri, 29 Mar 2024 12:28:03 +0100,
Simon Trimmer wrote:
> 
> These ASUS laptops use the Realtek HDA codec combined with a number of
> CS35L56 amplifiers.
> 
> The SSID of the GA403U matches a previous ASUS laptop - we can tell them
> apart because they use different codecs.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>

Thanks, applied now.


Takashi


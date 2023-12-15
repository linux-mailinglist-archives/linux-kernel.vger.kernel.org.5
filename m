Return-Path: <linux-kernel+bounces-510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BABA814237
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0085B2831DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434CAD2E2;
	Fri, 15 Dec 2023 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Fz+Pks9I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ioHalKIn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Fz+Pks9I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ioHalKIn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377E0D27E;
	Fri, 15 Dec 2023 07:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6F464224E1;
	Fri, 15 Dec 2023 07:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702624537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+cLLJz7WJavLlYuui8aFEf5IXUkSs1/Hp1FTBnSIBs=;
	b=Fz+Pks9IaGRlld9bD5ONLT8YV84Wya+KDDPmZ1K/hVarENi1slXTnILoJAwXuVy8AtpTw2
	/QAo0TCo/LARj89CUcRXJS5vHmPL37zbcR2Pa16feUX8U3YZtHxrd45ooljBik8xKsLQEq
	KvmpG8vvN2DicRKA093RDwRoDI8udXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702624537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+cLLJz7WJavLlYuui8aFEf5IXUkSs1/Hp1FTBnSIBs=;
	b=ioHalKInDZqlKaembbbuP0UBldkGPXEBuy6GwpFleVqGZyXA3jv8C/qcNyzqBDvnSFYC3v
	dkZHjaH/MVN5t6Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702624537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+cLLJz7WJavLlYuui8aFEf5IXUkSs1/Hp1FTBnSIBs=;
	b=Fz+Pks9IaGRlld9bD5ONLT8YV84Wya+KDDPmZ1K/hVarENi1slXTnILoJAwXuVy8AtpTw2
	/QAo0TCo/LARj89CUcRXJS5vHmPL37zbcR2Pa16feUX8U3YZtHxrd45ooljBik8xKsLQEq
	KvmpG8vvN2DicRKA093RDwRoDI8udXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702624537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+cLLJz7WJavLlYuui8aFEf5IXUkSs1/Hp1FTBnSIBs=;
	b=ioHalKInDZqlKaembbbuP0UBldkGPXEBuy6GwpFleVqGZyXA3jv8C/qcNyzqBDvnSFYC3v
	dkZHjaH/MVN5t6Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FAB613726;
	Fri, 15 Dec 2023 07:15:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hIHqDRn9e2UEKgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 15 Dec 2023 07:15:37 +0000
Date: Fri, 15 Dec 2023 08:15:36 +0100
Message-ID: <878r5wos13.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound: pci: au88x0: fixed spelling mistakes in au88x0_core.c
In-Reply-To: <20231215031144.521359-1-ghanshyam1898@gmail.com>
References: <20231215031144.521359-1-ghanshyam1898@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Score: -1.50
X-Spam-Flag: NO
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.25
X-Spamd-Result: default: False [-1.25 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 NEURAL_SPAM_LONG(0.45)[0.130];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.41)[97.28%]
X-Spam-Flag: NO

On Fri, 15 Dec 2023 04:11:44 +0100,
Ghanshyam Agrawal wrote:
> 
> Multiple spelling mistakes were reported by codespell.
> They were fixed.
> 
> Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>

Thanks, applied.


Takashi


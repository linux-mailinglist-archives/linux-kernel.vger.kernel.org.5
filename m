Return-Path: <linux-kernel+bounces-34847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1ED838842
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EEA81F218A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8ED53E2E;
	Tue, 23 Jan 2024 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HlQOCBJh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jZcjz8pE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HlQOCBJh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jZcjz8pE"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED2352F77;
	Tue, 23 Jan 2024 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705996266; cv=none; b=XwV/BsruBFNka/iz5hq4WML+zcSITM6qnxitCvbuIb3Ygkc0NgOgoD46NS16fFLxwOjFxSn9nlLCtuoVGs6EEhSNbI8R1hZhzcXCvR0QOpJ2I3bfkQG1o35Z6R3VnHWtRHB6xluK1Hw7rehYbyVRPifBZ8euEr2khRWZB6cHgsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705996266; c=relaxed/simple;
	bh=+FQ2dXwSPK4lKzUb9x6+Wx7xiSG9UCJSvsRF2UHO+Rc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQu93m1xt1D50G54OOL824Gr/LQWEIPhaLxX+69SP0vql7Kc8MOfR8qgdZ1dMmEviigkVbMuSLnW4L5n0Twv1Pf+thwXKZmQLPsHTTl1wMrOVic5dVXiRIzrcNs/DqUL8uVy2J8p0c/iK2FCTDKnoYAeO5OTkOIBshDwet1SMJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HlQOCBJh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jZcjz8pE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HlQOCBJh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jZcjz8pE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA85221F23;
	Tue, 23 Jan 2024 07:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705996261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+flJAd6H8oP/VR9Ty1oReEk9oo5tXSBeY0zG3mnicQ=;
	b=HlQOCBJhCnHT+WCvO+jY2rIdyFVcFpI3bD06lU6FZWzwVRqRHJIvI9GfbAiBUvb/13QrB+
	vPfCYw0DKdkQzHEDLBnLEjejy9yr1MIaXSXetvaWsZl6LC7GELUeb5eSZXoKafrH6AaXth
	EZnb40fb38Po4UBXVv6mbVxtU4n/j9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705996261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+flJAd6H8oP/VR9Ty1oReEk9oo5tXSBeY0zG3mnicQ=;
	b=jZcjz8pEfVWzb8lwN/VLw7RNFOl7xBV2UGZ9qPmOOQ5PnpfJ9NIXmJfL9Lz7O3jlX3WhiO
	4GFrD2+EPORF7rDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705996261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+flJAd6H8oP/VR9Ty1oReEk9oo5tXSBeY0zG3mnicQ=;
	b=HlQOCBJhCnHT+WCvO+jY2rIdyFVcFpI3bD06lU6FZWzwVRqRHJIvI9GfbAiBUvb/13QrB+
	vPfCYw0DKdkQzHEDLBnLEjejy9yr1MIaXSXetvaWsZl6LC7GELUeb5eSZXoKafrH6AaXth
	EZnb40fb38Po4UBXVv6mbVxtU4n/j9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705996261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+flJAd6H8oP/VR9Ty1oReEk9oo5tXSBeY0zG3mnicQ=;
	b=jZcjz8pEfVWzb8lwN/VLw7RNFOl7xBV2UGZ9qPmOOQ5PnpfJ9NIXmJfL9Lz7O3jlX3WhiO
	4GFrD2+EPORF7rDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A89E2136A4;
	Tue, 23 Jan 2024 07:51:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9S6qJ+Vvr2WiZQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 23 Jan 2024 07:51:01 +0000
Date: Tue, 23 Jan 2024 08:51:01 +0100
Message-ID: <87y1cgmqsa.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Rui Salvaterra <rsalvaterra@gmail.com>
Cc: amadeuszx.slawinski@linux.intel.com,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ALSA: hda: Replace numeric device IDs with constant values
In-Reply-To: <20240122114512.55808-2-rsalvaterra@gmail.com>
References: <20240122114512.55808-2-rsalvaterra@gmail.com>
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
X-Spam-Level: 
X-Spam-Score: -2.71
X-Spamd-Result: default: False [-2.71 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.41)[97.29%]
X-Spam-Flag: NO

On Mon, 22 Jan 2024 12:45:12 +0100,
Rui Salvaterra wrote:
> 
> We have self-explanatory constants for Intel HDA devices, let's use them instead
> of magic numbers and code comments.
> 
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>

Applied both patches now.  Thanks.


Takashi


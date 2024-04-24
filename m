Return-Path: <linux-kernel+bounces-156551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 062C08B046C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ABBD1F25B54
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3028158A06;
	Wed, 24 Apr 2024 08:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z+fi5877";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6DyW8cLV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z+fi5877";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6DyW8cLV"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31001E4A9;
	Wed, 24 Apr 2024 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947719; cv=none; b=P22+wxV0Z2W85QlpXVuuGFrExtdq75A1R/n1yMxG1AE3jFBwgyA7nVk0jOnQ6gaWCox6b5CwJapZ3nAVeIfGdW3ObWz9sj7OwkkWnxaP/Zr38Da6Wp4SM9/UpMNMAGbfMO1DX8nlH3Rnm9t5ACSDaF52JYqxShNv3Q73hdcX9lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947719; c=relaxed/simple;
	bh=Diwxh7oYymnJcN+8qW/fo95XYZ0IL5WSPMdte6hs+Ds=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTQpyGYbrJIxr8FDIqENcf6gKlFShIq6HqDfbGYSaSBvdtD2+5qAACETQCl5mLBf5EO0522whJ561K7GoU0lFdmVswKburXk68TaSHL/ioOTQTrAhUbvw4cX2Y3yrSWNA2KASOEIgBeVIsBUqr+PfU0hd0SjNFQo+0GztEo0e8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z+fi5877; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6DyW8cLV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z+fi5877; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6DyW8cLV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B3F2A611F1;
	Wed, 24 Apr 2024 08:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713947713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=elRg1WfuYIh3UN/+CGdWJcbo9zKqZDeKyAmj66ffYL0=;
	b=Z+fi5877P1yRb5OnHCTwGKdKWopshyLSofJgIRzvxIrzDqmJ9mTx1p2ynY2q8zSYxEiryl
	Wg0nTecO0P3olrNTwRs4B2yTxhpr4vU/0kQhYWid4JIpwbdHqCXFmgcJfB3QaqHl1o4Lha
	lu1Rw0qz7uonv7zhqwJyB6p0grTdBCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713947713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=elRg1WfuYIh3UN/+CGdWJcbo9zKqZDeKyAmj66ffYL0=;
	b=6DyW8cLVMVbUb/MEmadxQ/VFqiQ6Z0besAc/QjIxj9cAx6C82avzUQrBfNhvuEItFiyEcC
	eF43mJWiaUkbs7Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713947713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=elRg1WfuYIh3UN/+CGdWJcbo9zKqZDeKyAmj66ffYL0=;
	b=Z+fi5877P1yRb5OnHCTwGKdKWopshyLSofJgIRzvxIrzDqmJ9mTx1p2ynY2q8zSYxEiryl
	Wg0nTecO0P3olrNTwRs4B2yTxhpr4vU/0kQhYWid4JIpwbdHqCXFmgcJfB3QaqHl1o4Lha
	lu1Rw0qz7uonv7zhqwJyB6p0grTdBCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713947713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=elRg1WfuYIh3UN/+CGdWJcbo9zKqZDeKyAmj66ffYL0=;
	b=6DyW8cLVMVbUb/MEmadxQ/VFqiQ6Z0besAc/QjIxj9cAx6C82avzUQrBfNhvuEItFiyEcC
	eF43mJWiaUkbs7Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 847C71393C;
	Wed, 24 Apr 2024 08:35:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wZmgH0HEKGaIKQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 24 Apr 2024 08:35:13 +0000
Date: Wed, 24 Apr 2024 10:35:23 +0200
Message-ID: <87cyqfdupg.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	<alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH v1 0/2] Add support for Lenovo Thinkbook 13X
In-Reply-To: <20240423162303.638211-1-sbinding@opensource.cirrus.com>
References: <20240423162303.638211-1-sbinding@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-1.45 / 50.00];
	BAYES_HAM(-1.15)[88.70%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -1.45
X-Spam-Flag: NO

On Tue, 23 Apr 2024 18:23:01 +0200,
Stefan Binding wrote:
> 
> This laptop does not contain _DSD required to support CS35L41 HDA.
> To workaround this, add support for this laptop into the configuration
> table in cs35l41_hda_property.c.
> Also add the required entry into patch_realtek for this SSID.
> 
> Stefan Binding (2):
>   ALSA: hda: cs35l41: Support Lenovo 13X laptop without _DSD
>   ALSA: hda/realtek: Add quirks for Lenovo 13X

Applied both patches now to for-next branch.


thanks,

Takashi


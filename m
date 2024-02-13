Return-Path: <linux-kernel+bounces-63255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95091852CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5D9283EB4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F395E4F610;
	Tue, 13 Feb 2024 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R5AyAvv4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sf5YPaxl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R5AyAvv4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sf5YPaxl"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6B348795
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817351; cv=none; b=D13nPPdGlYIegWtf0AS4GoE7v6vJMkqvCLpjWnc1x5Llel0bru40jd4Ggz7R35t7JaLf/ORw6Hp8r8cPNH/LGBXVC9jQ2d2xEerKHLtq58kEvWyZ5TL5bp/V1/YBL7XKFkYWWJt8FePvJncZAqTfyfTbbLEeMGoRyIeWAoLbHYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817351; c=relaxed/simple;
	bh=rXimP4nDvNqHFT2twZNZ18Rr3AqFRzvwEhxiHdnnpGY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7+6M0Zg0RKe54Yz5frZxZbsKSmWRiCiPBFDHqj6YlmPtFHkd9yqohIxoiSwFOiX8Ntg7ENkFHY4pAOnknlcW5WkI4VJidRknzXqwknE6uNre4dKkRB7K3CuyLXED1GugikOtCegbPls+aiTd+xv7U6W+8ITjx9ejLdTbDwjnIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R5AyAvv4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sf5YPaxl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R5AyAvv4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sf5YPaxl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A930D1FC31;
	Tue, 13 Feb 2024 09:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707817347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CHR+1FK75Z10rkFlZFkahLAXLVcDrP2VELt6AP2FjvI=;
	b=R5AyAvv4fxRWYJ3hF+ZP6VZflLmX2nvtzWuULqlH7lgp6M6GL+KB07vKPT7pehbFgx3S05
	Sr3hU7FO0XuE9Bd4MX/Esdq3cNUcpOmeu55zFVy1LvOzgtNxqfNmwNb991LL8oJqU/DFZb
	AeNVnRB3hwXyaoXBKtHVlkFnmB8CEAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707817347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CHR+1FK75Z10rkFlZFkahLAXLVcDrP2VELt6AP2FjvI=;
	b=sf5YPaxle8U8X2UoeTPZMWk5GSmXfZUZRxFqnDb0WALPt3FopF46fu+sUPUaVoM2vbWjve
	l83uzGhMJuur/1Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707817347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CHR+1FK75Z10rkFlZFkahLAXLVcDrP2VELt6AP2FjvI=;
	b=R5AyAvv4fxRWYJ3hF+ZP6VZflLmX2nvtzWuULqlH7lgp6M6GL+KB07vKPT7pehbFgx3S05
	Sr3hU7FO0XuE9Bd4MX/Esdq3cNUcpOmeu55zFVy1LvOzgtNxqfNmwNb991LL8oJqU/DFZb
	AeNVnRB3hwXyaoXBKtHVlkFnmB8CEAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707817347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CHR+1FK75Z10rkFlZFkahLAXLVcDrP2VELt6AP2FjvI=;
	b=sf5YPaxle8U8X2UoeTPZMWk5GSmXfZUZRxFqnDb0WALPt3FopF46fu+sUPUaVoM2vbWjve
	l83uzGhMJuur/1Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 515F61370C;
	Tue, 13 Feb 2024 09:42:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oKJgEoM5y2ULXQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Feb 2024 09:42:27 +0000
Date: Tue, 13 Feb 2024 10:42:26 +0100
Message-ID: <871q9gk8e5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>,
	jasowang@redhat.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.oasis-open.org,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	coverity-bot <keescook+coverity-bot@chromium.org>
Subject: Re: [PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op(): Uninitialized variables" warning.
In-Reply-To: <20240213040658-mutt-send-email-mst@kernel.org>
References: <20240213085131.503569-1-aiswarya.cyriac@opensynergy.com>
	<875xyska8v.wl-tiwai@suse.de>
	<20240213040658-mutt-send-email-mst@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.52
X-Spamd-Result: default: False [-1.52 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-2.72)[98.79%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TAGGED_RCPT(0.00)[coverity-bot];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Tue, 13 Feb 2024 10:07:35 +0100,
Michael S. Tsirkin wrote:
> 
> On Tue, Feb 13, 2024 at 10:02:24AM +0100, Takashi Iwai wrote:
> > On Tue, 13 Feb 2024 09:51:30 +0100,
> > Aiswarya Cyriac wrote:
> > > 
> > > Fix the following warning when building virtio_snd driver.
> > > 
> > > "
> > > *** CID 1583619:  Uninitialized variables  (UNINIT)
> > > sound/virtio/virtio_kctl.c:294 in virtsnd_kctl_tlv_op()
> > > 288
> > > 289         break;
> > > 290       }
> > > 291
> > > 292       kfree(tlv);
> > > 293
> > > vvv     CID 1583619:  Uninitialized variables  (UNINIT)
> > > vvv     Using uninitialized value "rc".
> > > 294       return rc;
> > > 295     }
> > > 296
> > > 297     /**
> > > 298      * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
> > > 299      * @snd: VirtIO sound device.
> > > "
> > > 
> > > Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> > > Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
> > > Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> > > Addresses-Coverity-ID: 1583619 ("Uninitialized variables")
> > > Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")
> > 
> > Thanks, applied.
> > 
> > 
> > Takashi
> 
> Why did you apply it directly? The patch isn't great IMHO.
> Why not give people a couple of days to review?

Sure, we can wait.  I applied it quickly just since it's an obvious
fix and you haven't responded to the original patch over a month.


thanks,

Takashi


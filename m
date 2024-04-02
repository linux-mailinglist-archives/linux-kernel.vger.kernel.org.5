Return-Path: <linux-kernel+bounces-127424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3EF894B25
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C043A1C21276
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A231A5AC;
	Tue,  2 Apr 2024 06:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tKbasdCg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/g1qMMXR"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EC7175A9;
	Tue,  2 Apr 2024 06:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712038435; cv=none; b=oxrAp8fcQjZ+IFJ1EzGIOvExXE7G4hnBi9P/XUXQU1V/B4ltiQuJLh8DHmitP7P/NCdI6HxYE+FxveNZMvsdW0oeHK++WNL8RmLWhL+kyrPcwLUQGB6vsHu93SE9LPkAALmyceI37xVUWnF56ufuRF1k1xxDS1CDUUf3UZ1O8BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712038435; c=relaxed/simple;
	bh=44ajMa6ip820bdujnM/3HdMb6uWjK0gqCV+v3GKvT2o=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkjp04Wt8KoPXXOoI5bSJf7UlBld+8oPZG5BzKlXAEXvSMDITjksChRPu6mTql6qzoMzoUwBTH4OOoSAX3jR1YxKv8DtAo4ciu7Zj4rC+1K0OWwsqYvt8bvHbuXjbjs8pcVOIXGmNRQ1GuYj5uIOz0T3dPxZsmYpVU4/oJUT/lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tKbasdCg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/g1qMMXR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A272F33A5D;
	Tue,  2 Apr 2024 06:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712038430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iv/fyWF76aNzLXkXj5zg/VBmnOb58Pp9Fu3oxtVHIm4=;
	b=tKbasdCgwlRZSTm6TxA+igjJDysJI/GUokirb8LkTaS6SVgNOSOLfWdLQ1hlpoTjE73dIf
	cRXB+bzDSyDi6WuMkgsoDOXk+2Ovz5vtE2LcC2YmVQbIE69EGjk7xPddc6x7WMbdwGhiU5
	vs3gNVTEYX0NLHJpd3MK2LA3FlHY4CM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712038430;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iv/fyWF76aNzLXkXj5zg/VBmnOb58Pp9Fu3oxtVHIm4=;
	b=/g1qMMXRLCb5m5gJyb0yaDUk51EtX0abpDdRPnFuNiDZ3fnhl5Uuh0GFdcQJTuFDKnyvz8
	risxnqwZVcFjKyBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DA8713A90;
	Tue,  2 Apr 2024 06:13:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id LPp5FR6iC2bcNgAAn2gu4w
	(envelope-from <tiwai@suse.de>); Tue, 02 Apr 2024 06:13:50 +0000
Date: Tue, 02 Apr 2024 08:13:54 +0200
Message-ID: <871q7othp9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: dberlin@dberlin.org
Cc: James Schulman <james.schulman@cirrus.com>,
    David Rhodes <david.rhodes@cirrus.com>,
    Richard Fitzgerald <rf@opensource.cirrus.com>,
    Jaroslav Kysela <perex@perex.cz>,
    alsa-devel@alsa-project.org,
    patches@opensource.cirrus.com,
    linux-sound@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add support for 2024 ROG Strix G634JZR
In-Reply-To: <874jckti4o.wl-tiwai@suse.de>
References: <20240401-add-rog-strix-16-g634jzr-v1-1-ac396095409e@dberlin.org>
	<874jckti4o.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: 1.23
X-Spam-Flag: NO
X-Spamd-Bar: +
X-Spamd-Result: default: False [1.23 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-0.999];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[dberlin.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.66)[82.82%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: *
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A272F33A5D

On Tue, 02 Apr 2024 08:04:39 +0200,
Takashi Iwai wrote:
> 
> On Mon, 01 Apr 2024 16:31:30 +0200,
> Daniel Berlin via B4 Relay wrote:
> > 
> > From: Daniel Berlin <dberlin@dberlin.org>
> > 
> > The windows driver inf says it uses the exact same tunings and setup as the
> > older G634, and then reuses the data for ID 1043:1CAF.
> > 
> > We do the same here.
> > Tested on an actual laptop, sound works fine with this patch plus
> > default fallback firmware.
> > 
> > Signed-off-by: Daniel Berlin <dberlin@dberlin.org>
> 
> Applied now.  Thanks.

.. and now I see that Luke has another patch that modified the entry
in patch_realtek.c, and I took his version instead.
  https://lore.kernel.org/r/20240402015126.21115-1-luke@ljones.dev

Let me know if this causes problem for you.


thanks,

Takashi


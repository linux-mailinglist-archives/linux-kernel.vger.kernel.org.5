Return-Path: <linux-kernel+bounces-50203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1168475BA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A30288569
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3952814AD23;
	Fri,  2 Feb 2024 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gTZvNztB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rFJQ1ubs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gTZvNztB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rFJQ1ubs"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA811420B3;
	Fri,  2 Feb 2024 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893597; cv=none; b=FGQDUQukmuYKIsnpMNaXOp0NfQtIxX8NBXkX/aRScteS4oAJYksR9Ze4d4IUyBf0wffEq1QL1xzdZY6SucXqNB0AXtEcnI6m759D4JKwrmYbfpzb34Gqy59yRlTGds4vK6Ko4e7qRs8E9zW+FoQOCiKXRhbaqEqgftRITvzagfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893597; c=relaxed/simple;
	bh=BpK08wDTcgdXavtNX448erqRPqnfLK+o8n6BTGSGMyE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYLFxi/G7IX2Gt2viJwNL6EdXjvOPCMbQAKF5sbZRlekPiKuM056aLnynhU8ptBrpCsfNz5FmB6OQjTX7GTPnUG6AoxVNXiuTIh5MmJsUMsYb9FrOdOF7qcFrG/KnHQFRZ4DSOL2+h8JPuXvoQu6sATVaDAJLion47mS+a3fIEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gTZvNztB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rFJQ1ubs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gTZvNztB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rFJQ1ubs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF76521F6B;
	Fri,  2 Feb 2024 17:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706893593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ucgZQctdh62JeDhECOYgc2GaF1+IHkTyWVsFmEYdamI=;
	b=gTZvNztB0rZBW487G2QczNcvV/R8jahxRBhPnCG5MJ3Y0JUpX/6Z0jWPd4bJ33I7G3XipV
	CBdi95Wkt3HQ/J2/xW5Ofg/mjzGmaPjrBxTiENzfaiVs2pJKRWXB+OC3Q7plziAvky1qxo
	CWjMDJk6cZPsKMC3Wcjy2CBgGY8Vmkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706893593;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ucgZQctdh62JeDhECOYgc2GaF1+IHkTyWVsFmEYdamI=;
	b=rFJQ1ubsRiLgO+GD5ZEu8xL4K74BI0EOl24TjqalmrN6+UFelDSe3sFDPxr7igSaDUUUZL
	CwXew/YrkfxZPXCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706893593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ucgZQctdh62JeDhECOYgc2GaF1+IHkTyWVsFmEYdamI=;
	b=gTZvNztB0rZBW487G2QczNcvV/R8jahxRBhPnCG5MJ3Y0JUpX/6Z0jWPd4bJ33I7G3XipV
	CBdi95Wkt3HQ/J2/xW5Ofg/mjzGmaPjrBxTiENzfaiVs2pJKRWXB+OC3Q7plziAvky1qxo
	CWjMDJk6cZPsKMC3Wcjy2CBgGY8Vmkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706893593;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ucgZQctdh62JeDhECOYgc2GaF1+IHkTyWVsFmEYdamI=;
	b=rFJQ1ubsRiLgO+GD5ZEu8xL4K74BI0EOl24TjqalmrN6+UFelDSe3sFDPxr7igSaDUUUZL
	CwXew/YrkfxZPXCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FA11139AB;
	Fri,  2 Feb 2024 17:06:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ha6uIRkhvWWvSQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 02 Feb 2024 17:06:33 +0000
Date: Fri, 02 Feb 2024 18:06:33 +0100
Message-ID: <87r0hubxt2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	<alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH v1] ALSA: hda/realtek: Remove two HP Laptops using CS35L41
In-Reply-To: <5792f9bc-b77d-4a90-be61-a09797295a8b@opensource.cirrus.com>
References: <20240202161727.321373-1-sbinding@opensource.cirrus.com>
	<87v876bz6b.wl-tiwai@suse.de>
	<5792f9bc-b77d-4a90-be61-a09797295a8b@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gTZvNztB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rFJQ1ubs
X-Spamd-Result: default: False [-2.37 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.06)[87.81%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CF76521F6B
X-Spam-Level: 
X-Spam-Score: -2.37
X-Spam-Flag: NO

On Fri, 02 Feb 2024 17:49:06 +0100,
Stefan Binding wrote:
> 
> Hi Takashi,
> 
> On 02/02/2024 16:37, Takashi Iwai wrote:
> > On Fri, 02 Feb 2024 17:17:27 +0100,
> > Stefan Binding wrote:
> >> These two HP laptops are changing configurations.
> > What exactly does this mean?  The PCI SSIDs are no longer valid, or
> > the quirk became wrong, or what?
> > 
> > 
> > thanks,
> > 
> > Takashi
> 
> The SKUs, and associated SSIDs, are no longer going to include the CS35L41.
> They may come back, but will need a different quirk.Sorry for the churn.

OK, care to resubmit with those explanations?


thanks,

Takashi


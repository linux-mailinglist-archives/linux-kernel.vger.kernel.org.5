Return-Path: <linux-kernel+bounces-8155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A478B81B2C4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60856282313
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F81859B5C;
	Thu, 21 Dec 2023 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SrTer4no";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ywr/+jLd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SrTer4no";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ywr/+jLd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A0A51008;
	Thu, 21 Dec 2023 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 06671219C7;
	Thu, 21 Dec 2023 09:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703151406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jpyugYPGDfPA4iIibcSdhT+W1y7H878ZPzo94O2QO9Y=;
	b=SrTer4noz9f3Vv5AJNW7fbhZz6IpSKxYmIOZhaRbqF3wZcZofHc2rlu7DRc4Twt1h+46mN
	BJavC4ZTehvQo11uYePVz6X50O6kxMfzB6GggA1LdCq8hanYUAXyAFDbIAnNkBM06Iqb/X
	vvVrFoZpewZuHOnFAx/DyB0sV+M4V0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703151406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jpyugYPGDfPA4iIibcSdhT+W1y7H878ZPzo94O2QO9Y=;
	b=ywr/+jLdUvdcx/DsHk66OtrAzI5xtR4IqrRoFeCbY28FnFw3/wmxUM1TA9IO6UB3+zUYJ0
	8oU65GJxZ8o2oNDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703151406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jpyugYPGDfPA4iIibcSdhT+W1y7H878ZPzo94O2QO9Y=;
	b=SrTer4noz9f3Vv5AJNW7fbhZz6IpSKxYmIOZhaRbqF3wZcZofHc2rlu7DRc4Twt1h+46mN
	BJavC4ZTehvQo11uYePVz6X50O6kxMfzB6GggA1LdCq8hanYUAXyAFDbIAnNkBM06Iqb/X
	vvVrFoZpewZuHOnFAx/DyB0sV+M4V0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703151406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jpyugYPGDfPA4iIibcSdhT+W1y7H878ZPzo94O2QO9Y=;
	b=ywr/+jLdUvdcx/DsHk66OtrAzI5xtR4IqrRoFeCbY28FnFw3/wmxUM1TA9IO6UB3+zUYJ0
	8oU65GJxZ8o2oNDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5A3513725;
	Thu, 21 Dec 2023 09:36:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XcWkNy0HhGVDNAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 21 Dec 2023 09:36:45 +0000
Date: Thu, 21 Dec 2023 10:36:41 +0100
Message-ID: <s5hzfy3ucba.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	<alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH v1 0/3] Support Dell models without _DSD
In-Reply-To: <20231220165829.160711-1-sbinding@opensource.cirrus.com>
References: <20231220165829.160711-1-sbinding@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: ****
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.75 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.44)[97.45%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SrTer4no;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="ywr/+jLd"
X-Spam-Score: -1.75
X-Rspamd-Queue-Id: 06671219C7

On Wed, 20 Dec 2023 17:58:26 +0100,
Stefan Binding wrote:
> 
> Add Quirks and driver properties for Dell models.
> Driver properties are required since these models do not have _DSD.
> Additionally, some laptops, including some of these, have an issue
> with their BIOS which causes the SPI speed to be set too slow.
> To ensure a decent performance for laptops with this slow speed,
> disable firmware loading. Running without firmware results in lower
> volume.
> 
> Stefan Binding (3):
>   ALSA: hda: cs35l41: Support additional Dell models without _DSD
>   ALSA: hda: cs35l41: Prevent firmware load if SPI speed too low
>   ALSA: hda/realtek: Add quirks for Dell models

The series doesn't seem applied cleanly.
Could you rebase to my for-linus branch and resubmit?

Though, I feel that it's a bit too much for 6.7 at this very late
stage.  So, I'll likely skip this series and apply to 6.8.


thanks,

Takashi


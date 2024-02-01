Return-Path: <linux-kernel+bounces-48189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4189084586D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D32287793
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6127C53377;
	Thu,  1 Feb 2024 13:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1UhEmtmr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9d2aY+3I";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1UhEmtmr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9d2aY+3I"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153D18663C;
	Thu,  1 Feb 2024 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792772; cv=none; b=A2TLJyg1prF3cVjjH0Vco46FGffNMje+6XILhHmhUjZ/uZg0TxBec+asHq8yUgs/8yOgVQa7rOucZyVrkFQWOjnrr3DhRdK+PA+WjaZn74hlHfVsjxgPbDq+H8S1T5GiQC2xk3gFc7NjYopSii+00XHVm9cvYzxq9SPsYEyIfSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792772; c=relaxed/simple;
	bh=hsoe/Z4J25lXye7WlG8sGQcucQXWWItI1nAXHLCk2P4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OiOb2/z4kiiHMu93H3sxT/NzAEwdGjQo/2owgqYMaCEBwWAa9ZQBW5keDouNauaTjwVkJSVHDoEoK4rBdSCX+ftfrsNQJEU623xujfePmUiBCyRQFxKoqIxcRTXuBy9/7Th5l9TgCa0ydPBuU7uxBSoEtGro/w4vfiD67wK65aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1UhEmtmr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9d2aY+3I; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1UhEmtmr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9d2aY+3I; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 304EB1FB83;
	Thu,  1 Feb 2024 13:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706792768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5BcI9j+KifUqRLeIKwD1M77ZWAWlE1k65vlJ/BBSYIM=;
	b=1UhEmtmrwvjhKEVrfhAut7Qb34St1CFDx8fheSsZ0lqiFwXD3gKKmuPVft7peHHCoXnsHT
	Jym4IWBsa98743XU2LyIheIjYTaRd1zGeAQwf9pgAUeKnscJmxDw3JeEolayvJn8Ri6H9n
	By2HmbXP+f+fwTQOa6AsjfCwi8PDKTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706792768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5BcI9j+KifUqRLeIKwD1M77ZWAWlE1k65vlJ/BBSYIM=;
	b=9d2aY+3IrEyW10TxVbRh7fFwioSeosXDhJyAok1WdbTACS5D1lBJJEfMduGCsT5iYn6wtl
	VHGAowd8x904XrDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706792768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5BcI9j+KifUqRLeIKwD1M77ZWAWlE1k65vlJ/BBSYIM=;
	b=1UhEmtmrwvjhKEVrfhAut7Qb34St1CFDx8fheSsZ0lqiFwXD3gKKmuPVft7peHHCoXnsHT
	Jym4IWBsa98743XU2LyIheIjYTaRd1zGeAQwf9pgAUeKnscJmxDw3JeEolayvJn8Ri6H9n
	By2HmbXP+f+fwTQOa6AsjfCwi8PDKTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706792768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5BcI9j+KifUqRLeIKwD1M77ZWAWlE1k65vlJ/BBSYIM=;
	b=9d2aY+3IrEyW10TxVbRh7fFwioSeosXDhJyAok1WdbTACS5D1lBJJEfMduGCsT5iYn6wtl
	VHGAowd8x904XrDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCA51139B1;
	Thu,  1 Feb 2024 13:06:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lLkhLD+Xu2WwPwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 01 Feb 2024 13:06:07 +0000
Date: Thu, 01 Feb 2024 14:06:07 +0100
Message-ID: <87cytgz64g.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
Cc: tiwai@suse.com,
	perex@perex.cz,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	luke@ljones.dev,
	andy.chi@canonical.com,
	shenghao-ding@ti.com,
	ruinairas1992@gmail.com,
	vitalyr@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Enable headset mic on Vaio VJFE-ADL
In-Reply-To: <20240201122114.30080-1-edson.drosdeck@gmail.com>
References: <20240201122114.30080-1-edson.drosdeck@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.24 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-2.64)[98.42%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[suse.com,perex.cz,opensource.cirrus.com,realtek.com,ljones.dev,canonical.com,ti.com,gmail.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.24

On Thu, 01 Feb 2024 13:21:14 +0100,
Edson Juliano Drosdeck wrote:
> 
> Vaio VJFE-ADL is equipped with ALC269VC, and it needs
> ALC298_FIXUP_SPK_VOLUME quirk to make its headset mic work.
> 
> Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>

Thanks, applied now.


Takashi


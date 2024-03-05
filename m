Return-Path: <linux-kernel+bounces-91949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B540A8718DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A921C20A67
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A7F535AB;
	Tue,  5 Mar 2024 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rFY6U2XJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zxBLtahA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OYszGT7z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PN//C9Ke"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDA74F613;
	Tue,  5 Mar 2024 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629295; cv=none; b=WsZJ81Mjw3G4WzSIIs+Wl+mDTh2A5UQnGPO2yahyyxZLCvVuuKISNhdGRjOZrNbFiNWAEo6qL03MgaWRdU9ZHVISwN+mqk+L7c36OKs8ZUS9m1oTtEq3YcJpm2bxqHKcNomQY5RCXj9Gusb4EfmfeT091TCxXVTHCvZQjww+zag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629295; c=relaxed/simple;
	bh=vkI64GLmKlfIGWk74eTIVv0TjSG6tAd0ZRbuwbNZFAA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oFnbfKlsMtqmYxv67Be/1ApG1ooO9cszzOnOwtpgLCwAUPDu4FzddK9GlddfXXpyfuq+FlfxRulv4CidFriuhU8RLbe5mvmzyXVygjwR6y6TZmRtYlHNb7kgZFRPID9WNYz9BBL7lOzwxIRG78GEIsEBRoIG4uSS/niuuzFiq84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rFY6U2XJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zxBLtahA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OYszGT7z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PN//C9Ke; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD33C764F9;
	Tue,  5 Mar 2024 09:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709629292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nsKCgq6uahdDBWBHtWl9fx10stWQXxPxQrnA8/ge5u8=;
	b=rFY6U2XJ9ORy5xpSQC3bSuxF6QdcLeblwSrKt21B9y8miZYSZv+mkYS59ZL8x9TtUz5c+I
	0fgEj0sMxSg/fr+E9hA+Jqh9U/zECxOfAUeqOsXm8bkbnxybPa2TD5KihPdLBtJpCk2sC0
	IjWqgUpLANaKKt5Jkj403RxRcOF1nbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709629292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nsKCgq6uahdDBWBHtWl9fx10stWQXxPxQrnA8/ge5u8=;
	b=zxBLtahA+huC1TFQcwXXLmXPIr5EjIR4tHFKRYkQkEqI3C2XSn0I6J1QG6ZWySY+YJVR8z
	kXCwyA6YkDmTZGBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709629291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nsKCgq6uahdDBWBHtWl9fx10stWQXxPxQrnA8/ge5u8=;
	b=OYszGT7zkUYiyAzDYu5GdgHkaFHo+x9x8wDkl4IzyzFTfrz3yDqJ/8KW8oU5fQNjiegsZx
	POCoR6WMe9IwG5V7I2WxflPz9J5hENV2XGli3HekqVqZrqlRoqi/1RvVw96JjDqf/vpsVL
	sAh5YE/bXl4iu6gPC4ZYR1ywCx7dR7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709629291;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nsKCgq6uahdDBWBHtWl9fx10stWQXxPxQrnA8/ge5u8=;
	b=PN//C9KeIAr8o75caO4WxZ0xCkH4c/1vhXcaud3OhtWO8JWTkKK9aqg6Z/on0uMiAzBg7i
	YVRj6L3A3G4PThCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AFB313A5B;
	Tue,  5 Mar 2024 09:01:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Spl2IGvf5mUuAQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 05 Mar 2024 09:01:31 +0000
Date: Tue, 05 Mar 2024 10:01:31 +0100
Message-ID: <87y1axgihg.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Andy Chi <andy.chi@canonical.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Kailang Yang <kailang@realtek.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Matthew Anderson <ruinairas1992@gmail.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs for HP EliteBook
In-Reply-To: <20240304134033.773348-1-andy.chi@canonical.com>
References: <20240304134033.773348-1-andy.chi@canonical.com>
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
X-Spam-Level: 
X-Spam-Score: -1.93
X-Spamd-Result: default: False [-1.93 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[perex.cz,suse.com,opensource.cirrus.com,realtek.com,ljones.dev,ti.com,gmail.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.63)[92.68%]
X-Spam-Flag: NO

On Mon, 04 Mar 2024 14:40:32 +0100,
Andy Chi wrote:
> 
> The HP EliteBook using ALC236 codec which using 0x02 to
> control mute LED and 0x01 to control micmute LED.
> Therefore, add a quirk to make it works.
> 
> Signed-off-by: Andy Chi <andy.chi@canonical.com>

Thanks, applied now.


Takashi


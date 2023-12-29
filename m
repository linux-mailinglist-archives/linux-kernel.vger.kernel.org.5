Return-Path: <linux-kernel+bounces-13084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8CB81FF7D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0422B21B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847D6111A4;
	Fri, 29 Dec 2023 12:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c0K6bqrK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qec/+vnn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c0K6bqrK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qec/+vnn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8546211700;
	Fri, 29 Dec 2023 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1F9EF1F7A9;
	Fri, 29 Dec 2023 12:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703853980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DrfgzpQFNY6S02Kc9q4U3G892up+XPMx6Jx7zcjS9aI=;
	b=c0K6bqrKFgbSd2sx5A0/v8DUDyIYdmzAhQuZrPIUxrs1EW2G5OHEz1WoNKx2P6ERfdxVsh
	Av7EzPAs/MHvxXtRtYHzfIQsil2E1Pnf4SGHlX5fKgnskBx0S0OyGvHOxE+++cz+yIw9+1
	HSy41BMzWubXLpeCVtX/tZSNNp0fAYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703853980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DrfgzpQFNY6S02Kc9q4U3G892up+XPMx6Jx7zcjS9aI=;
	b=Qec/+vnnPIlHWbWk23hbqWGaLrxW3tHt5/1Fx4dWNmrr8eFLEOcLqYx3dVPzXwab9VO4F5
	dDujQtHu7BT3k/Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703853980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DrfgzpQFNY6S02Kc9q4U3G892up+XPMx6Jx7zcjS9aI=;
	b=c0K6bqrKFgbSd2sx5A0/v8DUDyIYdmzAhQuZrPIUxrs1EW2G5OHEz1WoNKx2P6ERfdxVsh
	Av7EzPAs/MHvxXtRtYHzfIQsil2E1Pnf4SGHlX5fKgnskBx0S0OyGvHOxE+++cz+yIw9+1
	HSy41BMzWubXLpeCVtX/tZSNNp0fAYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703853980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DrfgzpQFNY6S02Kc9q4U3G892up+XPMx6Jx7zcjS9aI=;
	b=Qec/+vnnPIlHWbWk23hbqWGaLrxW3tHt5/1Fx4dWNmrr8eFLEOcLqYx3dVPzXwab9VO4F5
	dDujQtHu7BT3k/Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5D5E133E5;
	Fri, 29 Dec 2023 12:46:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o1LhKpu/jmV2aAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 29 Dec 2023 12:46:19 +0000
Date: Fri, 29 Dec 2023 13:46:19 +0100
Message-ID: <87v88hxjl0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] ALSA: hda/tas2781: move set_drv_data outside tasdevice_init
In-Reply-To: <1398bd8bf3e935b1595a99128320e4a1913e210a.1703204848.git.soyer@irl.hu>
References: <1398bd8bf3e935b1595a99128320e4a1913e210a.1703204848.git.soyer@irl.hu>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [-2.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[ti.com,perex.cz,suse.com,gmail.com,kernel.org,vger.kernel.org,alsa-project.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[99.98%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -2.10
X-Spam-Flag: NO

On Fri, 22 Dec 2023 01:34:47 +0100,
Gergo Koteles wrote:
> 
> allow driver specific driver data in tas2781-hda-i2c and tas2781-i2c
> 
> Fixes: ef3bcde75d06 ("ASoC: tas2781: Add tas2781 driver")
> CC: stable@vger.kernel.org
> Signed-off-by: Gergo Koteles <soyer@irl.hu>

Both patches applied to for-linus branch now.  Thanks.


Takashi


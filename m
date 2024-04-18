Return-Path: <linux-kernel+bounces-149598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 225EB8A9348
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF88282231
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EA7282F4;
	Thu, 18 Apr 2024 06:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YJXG2QHC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5wbPw0WV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="igUgPFJG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ER/RxnMo"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3496F28DDE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422542; cv=none; b=Fc2ofDyMXEcQ8P4ACMu+k2EgI+9mhdP/nxSVLD3UJ+e0QZtkgr3J/XiAm/FIsN8qRRfljS6mwSzc4w39/aJoNcJNVGbNeM2k/kD7/h6wnBSguDnFGAM/RfjE9eVtw3Q26BOfBqqukO0j8KVauv6dKECYaSeLk4bXMkCJMj0EiU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422542; c=relaxed/simple;
	bh=uBpaZXZ//+wXoMiuJq7TUiP5CU/5ciB016fjPPA4UKI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7x9jS0TvhcnMzr7hfty1nSuR3/QUX8v7wsYNePVBwZ4pEO9Njjta+bSxttSAUwAHJIjo8Acg08YJo35HsHk0pYc0xuJ8jWp1pd99p5AZ4CHwE2Y8PSsxtAbOmxMTaFplmW12PFomin9XaLDFac6VN83cZGHxUaUj+b27kc2r4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YJXG2QHC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5wbPw0WV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=igUgPFJG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ER/RxnMo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B75234A58;
	Thu, 18 Apr 2024 06:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713422539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GCC2ifPdYJijtvyIoC+2l6z43cA42cTEO8PRZ+VUXG4=;
	b=YJXG2QHCmYMVJDxLoYLYi/HzPZTT6bhKKnzFAHPzxDZGPVXv7N8qYzEcoTRyL2XYfVDw2A
	Xof7oAlddueIN0a8qhgsxE8MLCXjyEfzTnLdW1eF80GwmKfgtbAZ2s99vHc98SCjHzGmVF
	Z0lg6bCzVrYDiiGQD4N4VIstIW22tSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713422539;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GCC2ifPdYJijtvyIoC+2l6z43cA42cTEO8PRZ+VUXG4=;
	b=5wbPw0WVq6xh+omxhE34k77Pq1ZczjeD0rcvui9rgW7GIVr93YXxPliCmnKwFJ4WzblGH2
	chNGp4FkN9IpTgCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713422538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GCC2ifPdYJijtvyIoC+2l6z43cA42cTEO8PRZ+VUXG4=;
	b=igUgPFJGTg2hV9ds2L3Y5DNPEVuICXtQSA7R5CYoT0GVJjdS481O0W7lMioLZRzoaybY/W
	lr5uslL4cud8e57pi9zGjMZis+zJ1kChAeRFqpVK1oshisxBh81qd64a8gd7h3QtYg9o8f
	sLci7+R76FdIt6SOAMHju7G58nJrBZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713422538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GCC2ifPdYJijtvyIoC+2l6z43cA42cTEO8PRZ+VUXG4=;
	b=ER/RxnMoW4ULBR99bDF3u9ufHG0jKo7tBR1EB6Ru1r7Ip+HmPzTAgB0gDclX9BHLDgUXcc
	n08hWzpoERIFPrAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B435413687;
	Thu, 18 Apr 2024 06:42:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 82hMKsnAIGbadwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 18 Apr 2024 06:42:17 +0000
Date: Thu, 18 Apr 2024 08:42:26 +0200
Message-ID: <87jzkvxjcd.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<lgirdwood@gmail.com>,
	<perex@perex.cz>,
	<pierre-louis.bossart@linux.intel.com>,
	<13916275206@139.com>,
	<mimperial@lenovo.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<liam.r.girdwood@intel.com>,
	<bard.liao@intel.com>,
	<yung-chuan.liao@linux.intel.com>,
	<kevin-lu@ti.com>,
	<robinchen@ti.com>,
	<baojun.xu@ti.com>,
	<soyer@irl.hu>,
	<Baojun.Xu@fpt.com>,
	<navada@ti.com>,
	<v-po@ti.com>
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Add new vendor_id and subsystem_id to support ThinkPad ICE-1
In-Reply-To: <20240411091823.1644-1-shenghao-ding@ti.com>
References: <20240411091823.1644-1-shenghao-ding@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-2.62 / 50.00];
	BAYES_HAM(-2.32)[96.83%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,gmail.com,perex.cz,139.com,lenovo.com,alsa-project.org,vger.kernel.org,intel.com,ti.com,irl.hu,fpt.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -2.62
X-Spam-Flag: NO

On Thu, 11 Apr 2024 11:18:22 +0200,
Shenghao Ding wrote:
> 
> Add new vendor_id and subsystem_id to support new Lenovo laptop
> ThinkPad ICE-1
> 
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

Applied now.  Thanks.


Takashi


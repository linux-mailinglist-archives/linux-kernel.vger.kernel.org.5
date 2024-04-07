Return-Path: <linux-kernel+bounces-134196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880EB89AEDF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C152827DA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 06:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3944A79D1;
	Sun,  7 Apr 2024 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0GXlGPDE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zw8AOD7i";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0GXlGPDE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zw8AOD7i"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D4F7460
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 06:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712471562; cv=none; b=tDh6OJmUaLAzWVIUXCUGEkMZpVFJTygdbVlvQVAJcVzsh2vN0Rq+YZmaZY7Lc52Ywqa5Mr+M7bj6AeEp/hXBwFX4JY9bGsV8KW7B8GnvATZlBDQ8yY/KvkTgFla3H53/AChssjvS+PIfd/D4dlXGF/rCaEy7SoP/ZYpA7hrYQwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712471562; c=relaxed/simple;
	bh=dtzkXXw1WPphQqzUuV/MqVgSpOCEuSc3ZAp0BPFkcsk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHyAB23GGOLVzJqmBXUS7jSyvj5vxaTIZs4eYPc5TErWcarQUIUpUwUkJTtkdxJjsfyQIGWLC864NdKs3xrI+J7QpstxY83bCiJ2ZZmbCjN+wfO05Zsk3/Leo3zQsKgu8p+/NrnZEbHEpkUzKCUPlTziteZ8BmJMH9zyiDG2Y0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0GXlGPDE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zw8AOD7i; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0GXlGPDE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zw8AOD7i; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1969A21B53;
	Sun,  7 Apr 2024 06:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712471559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5zPYp1v7N9gIDbxuNsJSGdPlOA4AVe2g1TO/eF8V0IA=;
	b=0GXlGPDERwXwhNh90uVAP6Kf5929aSUyunoEmrqbyVOzjLGJNh/vcDMz/PXaL5ZEVCJbO7
	cRHNKttM+R8i2ijC8N43qkCoPFo641+cisDJEkOnOwTW0TR93GYpWjPoHTOA1iQK43QCe6
	HYbCVkgj4nuiTexGfdwV7rToOroPa84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712471559;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5zPYp1v7N9gIDbxuNsJSGdPlOA4AVe2g1TO/eF8V0IA=;
	b=zw8AOD7i4eyB0ElNmz1VK8yh6f2vU32JNq7U81enPVQ61jEpwOPsPfJe8PxfgHbL4s1WRy
	bYhx4tLyW6hTE6CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712471559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5zPYp1v7N9gIDbxuNsJSGdPlOA4AVe2g1TO/eF8V0IA=;
	b=0GXlGPDERwXwhNh90uVAP6Kf5929aSUyunoEmrqbyVOzjLGJNh/vcDMz/PXaL5ZEVCJbO7
	cRHNKttM+R8i2ijC8N43qkCoPFo641+cisDJEkOnOwTW0TR93GYpWjPoHTOA1iQK43QCe6
	HYbCVkgj4nuiTexGfdwV7rToOroPa84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712471559;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5zPYp1v7N9gIDbxuNsJSGdPlOA4AVe2g1TO/eF8V0IA=;
	b=zw8AOD7i4eyB0ElNmz1VK8yh6f2vU32JNq7U81enPVQ61jEpwOPsPfJe8PxfgHbL4s1WRy
	bYhx4tLyW6hTE6CA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E80713586;
	Sun,  7 Apr 2024 06:32:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id aYdAHQY+EmaKJwAAn2gu4w
	(envelope-from <tiwai@suse.de>); Sun, 07 Apr 2024 06:32:38 +0000
Date: Sun, 07 Apr 2024 08:32:44 +0200
Message-ID: <87le5plm2b.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<lgirdwood@gmail.com>,
	<perex@perex.cz>,
	<pierre-louis.bossart@linux.intel.com>,
	<13916275206@139.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<liam.r.girdwood@intel.com>,
	<bard.liao@intel.com>,
	<yung-chuan.liao@linux.intel.com>,
	<kevin-lu@ti.com>,
	<baojun.xu@ti.com>,
	<soyer@irl.hu>,
	<Baojun.Xu@fpt.com>,
	<navada@ti.com>,
	<v-po@ti.com>
Subject: Re: [PATCH v3] ALSA: hda/tas2781: correct the register for pow calibrated data
In-Reply-To: <20240406132010.341-1-shenghao-ding@ti.com>
References: <20240406132010.341-1-shenghao-ding@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -2.55
X-Spam-Level: 
X-Spamd-Result: default: False [-2.55 / 50.00];
	BAYES_HAM(-2.25)[96.48%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,gmail.com,perex.cz,139.com,alsa-project.org,vger.kernel.org,intel.com,ti.com,irl.hu,fpt.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]

On Sat, 06 Apr 2024 15:20:09 +0200,
Shenghao Ding wrote:
> 
> Calibrated data was written into an incorrect register, which cause
> speaker protection sometimes malfuctions
> 
> Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

Thanks, applied now.


Takashi


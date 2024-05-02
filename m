Return-Path: <linux-kernel+bounces-166432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAE78B9A9E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20E3285A18
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA1A7E766;
	Thu,  2 May 2024 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D3Y6t+9+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fDPMI9GC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0YK7zLTA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HXDJcb2K"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAB659B4B;
	Thu,  2 May 2024 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714652303; cv=none; b=XZ1OnEKvTIIIdiu/ElB1+UeEvPORtal7sdXXHouT+tT5ooga6MrnUeO6MJLStW/6t0x7yy0HcriSCXrNdJv46yr8Go8TbFZ7hQehPYCXw2YsLYAfHpu6hAHEtlDFKv4WSHA9/+Qqoy3gGYfir9p+PdSyVhX8H2JSo7BsXjoX41Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714652303; c=relaxed/simple;
	bh=P4JGGIr7TuEdQzF3H361JB9JPnuVF+tZjUULrjnjSxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/tUL9Iwlb25v+mv3/CUgZl3/YAyAzjRymfVfmfVIPmKoTsz+YE/8aNQPgzLXXnjaAV9019I05lz7xNpQvc+AoV22iphXkckZ795Yp+ny7XcUasvcm3XsOdBoXz540rsKa9O4fX0WmCh5R9DhcxujyRbbECuAxe4eTfkPI08YJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D3Y6t+9+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fDPMI9GC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0YK7zLTA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HXDJcb2K; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 546B81FC06;
	Thu,  2 May 2024 12:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714652299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pFFJhcTyPcagnclRdFj35f2A5OQ1A/ixbySpoxnlmrg=;
	b=D3Y6t+9+6T8CM/UkVLmJFo3Fqo6EQZzoDcSThWeovDdGMEyaf2OEB9jiWWcRng1G9sXV4L
	dP1dsNcLFyLPCsrRi930Mgz8YWBCwe04Ntc7450i/0bDYpv+5gfFgxD4E9fPg8TqA5qVbI
	brejUzJs8ZZxsPtetwuakwcbo8TF83Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714652299;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pFFJhcTyPcagnclRdFj35f2A5OQ1A/ixbySpoxnlmrg=;
	b=fDPMI9GC8Szmc72eC2Sa15WFTUYUC861b4lMsxBTBTcNHEr+ujCVsh8DsXI8oEKgCOkMhu
	FcJWn35HZTORRwDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0YK7zLTA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HXDJcb2K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714652298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pFFJhcTyPcagnclRdFj35f2A5OQ1A/ixbySpoxnlmrg=;
	b=0YK7zLTAcoz+GDnOXLlfUa/avD0Rb0/lmGO8U/+CV5M0/OGPeKSE6GDqOA0dCp91yOZO7m
	mhMloiueVmbTf6snuuPq1w1RLRrfY/gjQ3vqYJZHWyIvwXKvwCtR/4ZQ6q3mdyfR2sMQbm
	n0Z+0uN+RDiwzkN5YCDfxYdJBjWqa3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714652298;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pFFJhcTyPcagnclRdFj35f2A5OQ1A/ixbySpoxnlmrg=;
	b=HXDJcb2KXoqx7fUOZ/ASPsjaPHHy4JDxp2ictXesxUBMgcjqEYVjuGQKCE7k5s5fbIMCqw
	6QezDhPru6ztlhAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC41113957;
	Thu,  2 May 2024 12:18:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a9S2MImEM2beNgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 02 May 2024 12:18:17 +0000
Message-ID: <d520ea1b-e399-4c3d-8546-87c68e480cbc@suse.de>
Date: Thu, 2 May 2024 14:18:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] drm: Fix dma_resv deadlock at drm object pin time
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Qiang Yu <yuq825@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Steven Price <steven.price@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Koenig= <christian.koenig@amd.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Zack Rusin <zack.rusin@broadcom.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20240501065650.2809530-1-adrian.larumbe@collabora.com>
 <84a5f7b6-d20a-4c69-83a8-d8394fea2b68@suse.de>
 <20240502135941.136ad639@collabora.com>
 <20240502140012.68e88831@collabora.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20240502140012.68e88831@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 546B81FC06
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[19];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[collabora.com,gmail.com,linux.intel.com,kernel.org,ffwll.ch,arm.com,linaro.org,amd.com,broadcom.com,lists.freedesktop.org,vger.kernel.org,lists.linaro.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email]

Hi

Am 02.05.24 um 14:00 schrieb Boris Brezillon:
> On Thu, 2 May 2024 13:59:41 +0200
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
>
>> Hi Thomas,
>>
>> On Thu, 2 May 2024 13:51:16 +0200
>> Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>
>>> Hi,
>>>
>>> ignoring my r-b on patch 1, I'd like to rethink the current patches in
>>> general.
>>>
>>> I think drm_gem_shmem_pin() should become the locked version of _pin(),
>>> so that drm_gem_shmem_object_pin() can call it directly. The existing
>>> _pin_unlocked() would not be needed any longer. Same for the _unpin()
>>> functions. This change would also fix the consistency with the semantics
>>> of the shmem _vmap() functions, which never take reservation locks.
>>>
>>> There are only two external callers of drm_gem_shmem_pin(): the test
>>> case and panthor. These assume that drm_gem_shmem_pin() acquires the
>>> reservation lock. The test case should likely call drm_gem_pin()
>>> instead. That would acquire the reservation lock and the test would
>>> validate that shmem's pin helper integrates well into the overall GEM
>>> framework. The way panthor uses drm_gem_shmem_pin() looks wrong to me.
>>> For now, it could receive a wrapper that takes the lock and that's it.
>> I do agree that the current inconsistencies in the naming is
>> troublesome (sometimes _unlocked, sometimes _locked, with the version
>> without any suffix meaning either _locked or _unlocked depending on
>> what the suffixed version does), and that's the very reason I asked
>> Dmitry to address that in his shrinker series [1]. So, ideally I'd
>> prefer if patches from Dmitry's series were applied instead of
>> trying to fix that here (IIRC, we had an ack from Maxime).
> With the link this time :-).
>
> [1]https://lore.kernel.org/lkml/20240105184624.508603-1-dmitry.osipenko@collabora.com/T/

Thanks. I remember these patches. Somehow I thought they would have been 
merged already. I wasn't super happy about the naming changes in patch 
5, because the names of the GEM object callbacks do no longer correspond 
with their implementations. But anyway.

If we go that direction, we should here simply push drm_gem_shmem_pin() 
and drm_gem_shmem_unpin() into panthor and update the shmem tests with 
drm_gem_pin(). Panfrost and lima would call drm_gem_shmem_pin_locked(). 
IMHO we should not promote the use of drm_gem_shmem_object_*() 
functions, as they are meant to be callbacks for struct 
drm_gem_object_funcs. (Auto-generating them would be nice.)

Best regards
Thomas


>
>> Regards,
>>
>> Boris

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



Return-Path: <linux-kernel+bounces-64868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5271C85440B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7737C1C21F51
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8B864D;
	Wed, 14 Feb 2024 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="16DQXGgG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pku/4Rlm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="16DQXGgG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pku/4Rlm"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378E9125A2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707899403; cv=none; b=n1MQLvWIIDFJB/3gjv8cCg+nAuXC1XNIyEIw7awLQjnePDu6ZdYmSpXRZitKorOUUXX3ZHQtjrDedWf12AMEazN8JgiLmGkc1fTxiyUmxGdcsNuBTRAEL+a/wv18dJZACTmJBKnB/UaQr9HcQIQEumgRfYGfBwVV8jgApSODJXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707899403; c=relaxed/simple;
	bh=v1JIUIf7v5uqhnnqrbOEEppse8H0kiX//tX3ozldB3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZUz6tIfsLntk5tXzq3jsWb27IiMmMBdneRAyzw7zlTEza3hzjO9UG4yfkNYZqRloDphuLMbEPH/65OzjqY8sNixkhzkqQ9cNZk5VUte2201QgYYENK47z+RN3+EVIEC+rtKksvbfqPhBxPw8FNQkCte3yOSXG8NSNziLVBlkfvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=16DQXGgG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pku/4Rlm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=16DQXGgG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pku/4Rlm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 56C2C1F7E4;
	Wed, 14 Feb 2024 08:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707899399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GJSxBIYcHJIBRoBZfWESWwW2I+KJCpqrOcI5jh5XEkI=;
	b=16DQXGgGw3nGfhnl2wVN1aXvAVe6XnpCszid801pPtpsm7PycNb/SwUQOKAkVUP7OCtH73
	N7DX1Exg//SQu03eqbINQDrZeiQulaYF4NbuChgBkSVOupUCLlS7Exl4BXPF3Xzuk8ZQBS
	E8DuAL6CVm4bFKotI2e30cMeh18muvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707899399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GJSxBIYcHJIBRoBZfWESWwW2I+KJCpqrOcI5jh5XEkI=;
	b=pku/4RlmuvSXd9tTkTwcRAFmIWMeME40pvhPx0ptmpbcjEkc/c5z7EezighyJjxYZwPzZA
	LQpshOOgUxw//GBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707899399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GJSxBIYcHJIBRoBZfWESWwW2I+KJCpqrOcI5jh5XEkI=;
	b=16DQXGgGw3nGfhnl2wVN1aXvAVe6XnpCszid801pPtpsm7PycNb/SwUQOKAkVUP7OCtH73
	N7DX1Exg//SQu03eqbINQDrZeiQulaYF4NbuChgBkSVOupUCLlS7Exl4BXPF3Xzuk8ZQBS
	E8DuAL6CVm4bFKotI2e30cMeh18muvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707899399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GJSxBIYcHJIBRoBZfWESWwW2I+KJCpqrOcI5jh5XEkI=;
	b=pku/4RlmuvSXd9tTkTwcRAFmIWMeME40pvhPx0ptmpbcjEkc/c5z7EezighyJjxYZwPzZA
	LQpshOOgUxw//GBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BA3D13A0B;
	Wed, 14 Feb 2024 08:29:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id wO2gBAd6zGUZOgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 14 Feb 2024 08:29:59 +0000
Message-ID: <b8b106e9-a984-4b6d-988e-7b3edd1d9dd4@suse.de>
Date: Wed, 14 Feb 2024 09:29:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm: drm_crtc: correct some comments
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Alex Deucher <alexdeucher@gmail.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>
References: <20240213061733.8068-1-rdunlap@infradead.org>
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
In-Reply-To: <20240213061733.8068-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=16DQXGgG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="pku/4Rlm"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-8.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,intel.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,lists.freedesktop.org,linux.intel.com,kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Score: -8.00
X-Rspamd-Queue-Id: 56C2C1F7E4
X-Spam-Flag: NO



Am 13.02.24 um 07:17 schrieb Randy Dunlap:
> Fix some typos and punctuation.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Alex Deucher <alexdeucher@gmail.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
> v2: s/instances/instance/ (Alex)
> v3: rebase and resend;
>      add more Cc:s
>
>   drivers/gpu/drm/drm_crtc.c |    8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff -- a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> --- a/drivers/gpu/drm/drm_crtc.c
> +++ b/drivers/gpu/drm/drm_crtc.c
> @@ -61,13 +61,13 @@
>    * to one or more &drm_encoder, which are then each connected to one
>    * &drm_connector.
>    *
> - * To create a CRTC, a KMS drivers allocates and zeroes an instances of
> + * To create a CRTC, a KMS driver allocates and zeroes an instance of
>    * &struct drm_crtc (possibly as part of a larger structure) and registers it
>    * with a call to drm_crtc_init_with_planes().
>    *
> - * The CRTC is also the entry point for legacy modeset operations, see
> - * &drm_crtc_funcs.set_config, legacy plane operations, see
> - * &drm_crtc_funcs.page_flip and &drm_crtc_funcs.cursor_set2, and other legacy
> + * The CRTC is also the entry point for legacy modeset operations (see
> + * &drm_crtc_funcs.set_config), legacy plane operations (see
> + * &drm_crtc_funcs.page_flip and &drm_crtc_funcs.cursor_set2), and other legacy
>    * operations like &drm_crtc_funcs.gamma_set. For atomic drivers all these
>    * features are controlled through &drm_property and
>    * &drm_mode_config_funcs.atomic_check.

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



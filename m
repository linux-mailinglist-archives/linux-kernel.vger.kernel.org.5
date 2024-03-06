Return-Path: <linux-kernel+bounces-93869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C0287360E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC0E1C23E80
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53737FBC7;
	Wed,  6 Mar 2024 12:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tTUeGG8V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fjax02Ws";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lpVBm/Jg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="msdowrf6"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222DB1426B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 12:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709726828; cv=none; b=jFtuAhSC4XLAo6TMkpNa+P1/yciU7vOTY/cNj+5UMUlAlcKmG9Y/wUWAYu3dhsNKjxI+o28BEC+K/9UP2KcDUdtoYDQAPhqMHo4vcjTJBOZ6QnzG9NKn4ukK0QDb9V+1ZT8oJ9tvObBIW2juXKxTuLvECfAeLbPQFoP0JxYo1MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709726828; c=relaxed/simple;
	bh=5q6spnDDpamI5/yLFHc8sn/sUBXfsV87QBUl0XF8GaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2Pw4To1kQdPhqXc4FAXxbTvp8sk0Cz4j+B4XgIA5TeizDJ404TP0wG1VxcgMM7KYRrjksr6hgs7jUaK/XvW6nvhHpkgsrI7WI6t0/tE72+WgWMi036rPjAmF23Tz5f/Fzuu5QKq5QGvS3IIPJFDJZnVH/6dmCNIbYL0u3HyCxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tTUeGG8V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fjax02Ws; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lpVBm/Jg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=msdowrf6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 262F0769D9;
	Wed,  6 Mar 2024 12:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709726824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SRkZVI18S6bgk9ZbLKMEURbAB0iGiWwMfy857f4aJ2I=;
	b=tTUeGG8VSCig4nlz9sMFPkCBwfUWLESJ8AfxBaXmywpzVJVZPV6RIoebnKYdtyhm/WUoYu
	k3zwwTPXz7KteQYvUBWKAmLDrHphc+EjeFIJ2uXTPv0NTVhukb2pj0gj+GWChrkdzVJBi1
	ODSKmiJqY04flsXQj4L3q9+Nv2BroxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709726824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SRkZVI18S6bgk9ZbLKMEURbAB0iGiWwMfy857f4aJ2I=;
	b=fjax02WsEjLvNsfbo1FYYXek+lcvcb4nQQ04MRKA3y4nqiQZEHf8XVoX+j5wdBumm/B/6w
	I4E3KveMiwWcaDBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709726823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SRkZVI18S6bgk9ZbLKMEURbAB0iGiWwMfy857f4aJ2I=;
	b=lpVBm/Jg7YaI51RogA9hEws2WO1onCGxdSRluKaRbSMBdp2uF3YqE7kS8b7DRPBpIObOvf
	4bQhS0EQ53TAap++grsVdZgBOq748vgFb7x2BNv9mYTCE/aiUR8zK6q4hAlXKsjNFMZCai
	lN/t47eygSkoDXdw3/iw0MpKxfPGzjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709726823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SRkZVI18S6bgk9ZbLKMEURbAB0iGiWwMfy857f4aJ2I=;
	b=msdowrf6E1MBRJ/3qG2CLP5JFAQhIbG3tUHykSBCg9I53ShBIR0dIisL6ITKwSAZcbZsFX
	9LI3g4Yw7uaUUHDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B7D5D13A79;
	Wed,  6 Mar 2024 12:07:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id asQNK2Zc6GVeSQAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 06 Mar 2024 12:07:02 +0000
Message-ID: <60dc7697-d7a0-4bf4-a22e-32f1bbb792c2@suse.de>
Date: Wed, 6 Mar 2024 13:07:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/udl: Add ARGB8888 as a format
To: Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org
Cc: Rob Clark <robdclark@chromium.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>,
 David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Sean Paul <sean@poorly.run>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 linux-kernel@vger.kernel.org
References: <20240227141928.1.I24ac8d51544e4624b7e9d438d95880c4283e611b@changeid>
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
In-Reply-To: <20240227141928.1.I24ac8d51544e4624b7e9d438d95880c4283e611b@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-0.01)[45.24%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[chromium.org,redhat.com,ffwll.ch,gmail.com,linux.intel.com,kernel.org,igalia.com,poorly.run,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

Hi,

sorry that I did not see the patch before.

Am 27.02.24 um 23:19 schrieb Douglas Anderson:
> Even though the UDL driver converts to RGB565 internally (see
> pixel32_to_be16() in udl_transfer.c), it advertises XRGB8888 for
> compatibility. Let's add ARGB8888 to that list.

We had a heated discussion about the emulation of color formats. It was 
decided that XRGB8888 is the only format to support; and that's only 
because legacy userspace sometimes expects it. Adding other formats to 
the list should not be done easily.

>
> This makes UDL devices work on ChromeOS again after commit
> c91acda3a380 ("drm/gem: Check for valid formats"). Prior to that
> commit things were "working" because we'd silently treat the ARGB8888
> that ChromeOS wanted as XRGB8888.

This problem has been caused by userspace. Why can it not be fixed there?

And udl is just one driver. Any other driver without ARGB8888, such as 
simpledrm or ofdrm, would be affected. Do these work?

Best regards
Thomas

>
> Fixes: c91acda3a380 ("drm/gem: Check for valid formats")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>   drivers/gpu/drm/udl/udl_modeset.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
> index 7702359c90c2..0f8d3678770e 100644
> --- a/drivers/gpu/drm/udl/udl_modeset.c
> +++ b/drivers/gpu/drm/udl/udl_modeset.c
> @@ -253,6 +253,7 @@ static int udl_handle_damage(struct drm_framebuffer *fb,
>   static const uint32_t udl_primary_plane_formats[] = {
>   	DRM_FORMAT_RGB565,
>   	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_ARGB8888,
>   };
>   
>   static const uint64_t udl_primary_plane_fmtmods[] = {

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



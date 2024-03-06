Return-Path: <linux-kernel+bounces-94073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F7987396C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 293A9B23193
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3729E133994;
	Wed,  6 Mar 2024 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H6dl0dd9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SyQZLNkc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A7T7YMyN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V5LBUh65"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCAC5B03B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736037; cv=none; b=MBsKs3VK6pG2XSM5UJUjjbq+9GB5ERl2tQZoopTNBFVvutv4RTkvteDBrOxybRaeaGup05pgZcPY5iDEhPwyofOCurWCWUG6jiAu+81UhHp9Y0lxkd1sFGB/In/l52Iic/kLrAB7y0eQC38cll2FmCOHDq5R8ipKu6BfbmpLW54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736037; c=relaxed/simple;
	bh=z9dKotxyZRN34XmvQKSDZvVCC4Y9zfdfgM8ubgGBY54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N//xJuX0VW0n7HVdzP3/MVC69ELO9MnTVjI55E36CrGzNvnVscyAUZzSKGbVnohRNwETc0mgT29hWZVsmXsELjaRRU7RdPmpdY3d+ne/bH3YYjHHDoTsAmasB9IVrcnACH6jtpSTRXnv8fQX/FhNZRwNTbcLvBIuMahcdN2e2sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H6dl0dd9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SyQZLNkc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A7T7YMyN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V5LBUh65; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 861E776E83;
	Wed,  6 Mar 2024 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709736031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tJRcNznF0WFolBe9rhOfGnhQuHEA0FiGEAjy9RTdcUc=;
	b=H6dl0dd9x/dou1Jgw/00qur5TRfFNM8xxm59HFxpTr8ToghxFXT2UdldzyXMRm2fd7OPXA
	VlqpxKBkuC0slViqyBo3e3VVH1cMsqAF6uq1G4UoxUtAQKb09WRUkrtQH3h/4VJQnh8fsN
	ktnLf+p0Zjoh2EqXUJRYkc51Hjy3hS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709736031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tJRcNznF0WFolBe9rhOfGnhQuHEA0FiGEAjy9RTdcUc=;
	b=SyQZLNkcfRXKFnXz5guIwJiF5r/lN+e//XERz/nTSGzadHdT7JMP0TKfXpc0w1AHQYasZb
	E6/IXZdLYmeF+tBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709736029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tJRcNznF0WFolBe9rhOfGnhQuHEA0FiGEAjy9RTdcUc=;
	b=A7T7YMyNPMlMfgI9L5/u6IbEHZkZ695FLYer/gSePGfCjCHgzsc9pDRllUq5RpByTOjVhD
	54Sl7NuLCq3s3/Ea8PEc0/tFk3eJ0JFV5O0/rDr0v6W3udVk5SOw9AdmesNIOfHeB5mLsf
	Xlj5RiKl6AVqrUgKzG8PaaP6H8e5Nfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709736029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tJRcNznF0WFolBe9rhOfGnhQuHEA0FiGEAjy9RTdcUc=;
	b=V5LBUh651p30mMrNGv2Y0ne6GZdNesyDf1Q+Bow5fXYcH8+FBSUphuVqaAOs8HcP9DDxC2
	Sz3RwzDQkgg+8cDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DA7C1377D;
	Wed,  6 Mar 2024 14:40:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id f4a8DV2A6GVtbgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 06 Mar 2024 14:40:29 +0000
Message-ID: <99b23b3e-03d5-4942-a9c4-bcbc16bbcdd4@suse.de>
Date: Wed, 6 Mar 2024 15:40:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/udl: Add ARGB8888 as a format"
Content-Language: en-US
To: Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org
Cc: Maxime Ripard <mripard@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Dave Airlie <airlied@redhat.com>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org
References: <20240306063721.1.I4a32475190334e1fa4eef4700ecd2787a43c94b5@changeid>
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
In-Reply-To: <20240306063721.1.I4a32475190334e1fa4eef4700ecd2787a43c94b5@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=A7T7YMyN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=V5LBUh65
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.97 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.47)[79.40%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,chromium.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[kernel.org,ffwll.ch,redhat.com,gmail.com,linux.intel.com,poorly.run,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -3.97
X-Rspamd-Queue-Id: 861E776E83
X-Spam-Flag: NO



Am 06.03.24 um 15:37 schrieb Douglas Anderson:
> This reverts commit 95bf25bb9ed5dedb7fb39f76489f7d6843ab0475.
>
> Apparently there was a previous discussion about emulation of formats
> and it was decided XRGB8888 was the only format to support for legacy
> userspace [1]. Remove ARGB8888. Userspace needs to be fixed to accept
> XRGB8888.
>
> [1] https://lore.kernel.org/r/60dc7697-d7a0-4bf4-a22e-32f1bbb792c2@suse.de
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>
>   drivers/gpu/drm/udl/udl_modeset.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
> index 0f8d3678770e..7702359c90c2 100644
> --- a/drivers/gpu/drm/udl/udl_modeset.c
> +++ b/drivers/gpu/drm/udl/udl_modeset.c
> @@ -253,7 +253,6 @@ static int udl_handle_damage(struct drm_framebuffer *fb,
>   static const uint32_t udl_primary_plane_formats[] = {
>   	DRM_FORMAT_RGB565,
>   	DRM_FORMAT_XRGB8888,
> -	DRM_FORMAT_ARGB8888,
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



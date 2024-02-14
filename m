Return-Path: <linux-kernel+bounces-64863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCBC8543F2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B257C1C220EA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05940125AD;
	Wed, 14 Feb 2024 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N4HEVpZA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tf4VzyG5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N4HEVpZA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tf4VzyG5"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F200125A2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707898788; cv=none; b=eZuUk6JuK+FSFmxQevtR6a/mZ9eKe+IjzQRQ01z38Fi9do67LTYnQ6Cxb8+xAFX8/0m/JqVDRypF6sHAdejVj794H35q3WNBSSiT0LpCia2/WyCRJKFrXr1GFH6Kai5OIqYTLYOyAlspq9LmkmM0+JlBBc0AREMoJhrlhjlL3d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707898788; c=relaxed/simple;
	bh=kim4oXXDFQgeMb6+elDw89X6zv9m/NmjMHNMZHlDFPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lq9YZwD7ZdYR4P3DwIWQmQ9XYoP6D8WpDzFWC6h+KV6eU7x7CJCI+3fpsPKwz0hsjUkQ2qVQOBEoToxwDnYuKmbshRUhz0213imT1Rd88DhcXqtaNusC4fACJXBxZUmFoERMfWm5LNkSZ2WsUdOVBnH4itH0Lexps9bWjESG9so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N4HEVpZA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tf4VzyG5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N4HEVpZA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tf4VzyG5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 606331F7E6;
	Wed, 14 Feb 2024 08:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707898784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aA5f7ggNHWMTJ6KErm2u4TZReewmf5jev0AIcYNDBPw=;
	b=N4HEVpZA2Nvs/8/vStSVwzYRVDcMyhJLyBb5fQvSlhu0ejHc0Yd/xLzcHJPTI8Nprs/JY/
	tF7m5BYGSGIGq2uXmqU0KMtEB/yPeSmZEkSXokgb9tsWlTRWCjs84VAUmDaAcE5x/TMRn/
	Fo+tRMSIC5gTQPG4BOvCFufdw4OnNQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707898784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aA5f7ggNHWMTJ6KErm2u4TZReewmf5jev0AIcYNDBPw=;
	b=Tf4VzyG5GMr1z8vhCJGW9UHBsjuzbN3C413EjPXO+Zeix/wjdEnoyLtsBDwtk9456S+NRK
	WOBs9kdd8GF3BrBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707898784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aA5f7ggNHWMTJ6KErm2u4TZReewmf5jev0AIcYNDBPw=;
	b=N4HEVpZA2Nvs/8/vStSVwzYRVDcMyhJLyBb5fQvSlhu0ejHc0Yd/xLzcHJPTI8Nprs/JY/
	tF7m5BYGSGIGq2uXmqU0KMtEB/yPeSmZEkSXokgb9tsWlTRWCjs84VAUmDaAcE5x/TMRn/
	Fo+tRMSIC5gTQPG4BOvCFufdw4OnNQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707898784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aA5f7ggNHWMTJ6KErm2u4TZReewmf5jev0AIcYNDBPw=;
	b=Tf4VzyG5GMr1z8vhCJGW9UHBsjuzbN3C413EjPXO+Zeix/wjdEnoyLtsBDwtk9456S+NRK
	WOBs9kdd8GF3BrBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 437A913A0B;
	Wed, 14 Feb 2024 08:19:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id oVQND6B3zGX6NwAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 14 Feb 2024 08:19:44 +0000
Message-ID: <c8e0fbab-5d20-4d28-ba52-73cd7fa46473@suse.de>
Date: Wed, 14 Feb 2024 09:19:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iosys-map: fix typo
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
References: <20240213224219.10644-1-rdunlap@infradead.org>
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
In-Reply-To: <20240213224219.10644-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.97 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-1.88)[94.30%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.97



Am 13.02.24 um 23:42 schrieb Randy Dunlap:
> Correct a spello/typo in comments.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: dri-devel@lists.freedesktop.org

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks. I'll add the patch to our tree.

> ---
> v2: don't change "set up" to "setup" (Thomas)
>
>   include/linux/iosys-map.h |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -- a/include/linux/iosys-map.h b/include/linux/iosys-map.h
> --- a/include/linux/iosys-map.h
> +++ b/include/linux/iosys-map.h
> @@ -34,7 +34,7 @@
>    * the same driver for allocation, read and write operations.
>    *
>    * Open-coding access to :c:type:`struct iosys_map <iosys_map>` is considered
> - * bad style. Rather then accessing its fields directly, use one of the provided
> + * bad style. Rather than accessing its fields directly, use one of the provided
>    * helper functions, or implement your own. For example, instances of
>    * :c:type:`struct iosys_map <iosys_map>` can be initialized statically with
>    * IOSYS_MAP_INIT_VADDR(), or at runtime with iosys_map_set_vaddr(). These

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



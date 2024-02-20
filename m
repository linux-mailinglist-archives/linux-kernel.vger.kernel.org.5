Return-Path: <linux-kernel+bounces-72667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B310585B6E8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E6C281E53
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CAB6350F;
	Tue, 20 Feb 2024 09:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LgthCB5A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V5CqyRa8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LgthCB5A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V5CqyRa8"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF09C627FF;
	Tue, 20 Feb 2024 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420216; cv=none; b=D5msM/sX+P/vxL7NjdZcRDkTkacPtXgXkgieLO/j0PYhCY68hWRsJJ4Oev39OXoWJKKE27GHBKD3d9sdRKgnY+cjnbENy3/VIHE46l8GMGkNfT1iV5ZwZM0wJ3ZzGtk9MZTz2JJu82yHSNQBDRULI4+t/uR0pFpiiGHeOA7hR+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420216; c=relaxed/simple;
	bh=L2f7mmDjQ55CMiT4j+EvhgL2QDdg7W+zVB6CmKBTVMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VgpvvIAZIR7pob32s09DPKdpp1cGoSh/qXIt9Rj5GWqUbsv7nRUDu9KwwKFYAU17R0Sgja5FjK/ozcJAvqQWXaPQS/IBpBDdis9y7zg539QFARnKiqbDjkBBRlz/PBJpBP16wR3j0mDu7gDWukcztAopJ6MsBRVe4DYbsiiZnmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LgthCB5A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V5CqyRa8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LgthCB5A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V5CqyRa8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DDE461FD7D;
	Tue, 20 Feb 2024 09:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708420210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kPdL6CVcTlIemwxkK73Uuqptr350RyQ/02hpnd+rggQ=;
	b=LgthCB5A/eYLygBGFmWlYirXnF6g3/JoEcFLc8peWYz4y6ISH9+b1/bUtZMdppwkXBKBF8
	OrqRpi/8IXnUlqFrsh7Xu/uHlwV53fGrpipNTGLhjGNL8NfqFA99ez3MbEX8IydUKkhQLM
	0GvG9RUBMZG4koVoRslRnQ6nTtW+HgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708420210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kPdL6CVcTlIemwxkK73Uuqptr350RyQ/02hpnd+rggQ=;
	b=V5CqyRa8BjP726Kq5SZ1R08eKjnSST1FmlpRHrKBJ7YOSK63ONw0NCnBgG8CDwDrMkuu9I
	hqBNDQihI5qAzjAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708420210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kPdL6CVcTlIemwxkK73Uuqptr350RyQ/02hpnd+rggQ=;
	b=LgthCB5A/eYLygBGFmWlYirXnF6g3/JoEcFLc8peWYz4y6ISH9+b1/bUtZMdppwkXBKBF8
	OrqRpi/8IXnUlqFrsh7Xu/uHlwV53fGrpipNTGLhjGNL8NfqFA99ez3MbEX8IydUKkhQLM
	0GvG9RUBMZG4koVoRslRnQ6nTtW+HgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708420210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kPdL6CVcTlIemwxkK73Uuqptr350RyQ/02hpnd+rggQ=;
	b=V5CqyRa8BjP726Kq5SZ1R08eKjnSST1FmlpRHrKBJ7YOSK63ONw0NCnBgG8CDwDrMkuu9I
	hqBNDQihI5qAzjAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 69D09139EF;
	Tue, 20 Feb 2024 09:10:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id QAVhGHJs1GX7YgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Tue, 20 Feb 2024 09:10:10 +0000
Message-ID: <929a159f-f6dd-49d3-b6b5-70ab7450ab19@suse.de>
Date: Tue, 20 Feb 2024 10:10:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc: Fix undefined reference to fb_is_primary_device
Content-Language: en-US
To: Javier Martinez Canillas <javierm@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
 Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
 "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>,
 sparclinux@vger.kernel.org
References: <20240220003433.3316148-1-javierm@redhat.com>
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
In-Reply-To: <20240220003433.3316148-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LgthCB5A;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=V5CqyRa8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.50 / 50.00];
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
	 BAYES_HAM(-3.00)[100.00%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,intel.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[intel.com,lists.linux.dev,gaisler.com,arndb.de,davemloft.net,gmx.de,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.50
X-Rspamd-Queue-Id: DDE461FD7D
X-Spam-Flag: NO

Hi

Am 20.02.24 um 01:34 schrieb Javier Martinez Canillas:
> Commit 55bffc8170bb ("fbdev: Split frame buffer support in FB and FB_CORE
> symbols") added a new FB_CORE Kconfig symbol, that can be enabled to only
> have fbcon/VT and DRM fbdev emulation, but without support for any legacy
> fbdev driver.
>
> Unfortunately, it missed to change a CONFIG_FB in arch/sparc/Makefile and
> that leads to the following linking error in some sparc64 configurations:
>
>     sparc64-linux-ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_fb_registered':
>>> fbcon.c:(.text+0x4f60): undefined reference to `fb_is_primary_device'
> Fixes: 55bffc8170bb ("fbdev: Split frame buffer support in FB and FB_CORE symbols")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202401290306.IV8rhJ02-lkp@intel.com/
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>
> I don't have a sparc64 toolchain to test this patch, but I'm pretty sure
> that this is the correct fix for the linking error reported by the robot.
>
>   arch/sparc/video/Makefile | 2 +-

I think you also have to fix arch/sparc/Makefile.

Best regards
Thomas

>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/sparc/video/Makefile b/arch/sparc/video/Makefile
> index 6baddbd58e4d..d4d83f1702c6 100644
> --- a/arch/sparc/video/Makefile
> +++ b/arch/sparc/video/Makefile
> @@ -1,3 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   
> -obj-$(CONFIG_FB) += fbdev.o
> +obj-$(CONFIG_FB_CORE) += fbdev.o

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



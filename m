Return-Path: <linux-kernel+bounces-144623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA498A487B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92A81F21A96
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991C0208C3;
	Mon, 15 Apr 2024 06:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CwP7y0NJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MK+ewrVZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CwP7y0NJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MK+ewrVZ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D517200BF;
	Mon, 15 Apr 2024 06:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713164203; cv=none; b=gY08r6WuRymqRxTG4n/m0tOEozsX/vEME8bM3w6foGGOeZBXTGedM+RgCLFNOR8TAALzQz7uE5DkJ3Pnxde8H/svjg7+b1Wib6CKMCC1lA3+jD1xHeue/3Ct5dt7/FKVDIWWPJeJ9Kauq9Wi12vIXUpsGmMH6ChOq1yyci/S/6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713164203; c=relaxed/simple;
	bh=duW+8BbuFjm+gR6nar48iQgihNHtVUYE9gO/STS64Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJL8Qt0YTFoAwQjjZal4T9FH8narFXqDWN6x15YSsLb5uXYfn3m7C8yv9+0nJWfD97w6PKp2X3Px+hJm3FtFNLs9boXFyEn+nd5XKey49ZTBCTcbJmY1QEHIj+X3Pg2Z0+j6fk8rS1De8HiyNpNDThlFjOfuYeFzSG5gy6k5Xyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CwP7y0NJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MK+ewrVZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CwP7y0NJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MK+ewrVZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2D93334543;
	Mon, 15 Apr 2024 06:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713164193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QVONDjkvCUBoX9Fi9jRqnNKspLMCrAX5ZdlsaW1EyQc=;
	b=CwP7y0NJCGtTzmdGQMM48un+Pq214ylZ53B0EqUTPHxivOx8FonhItNaB5ahUmYnbPSgyi
	w2fE+T0eNgZThdNAY5w47hndGzBvIUblazR8XmKF/Ys7RytDUa4aYO09X5Qh/uQjjSLoLR
	WWPP6qTOw8FX69YLUhd2KJwWbwzxhao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713164193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QVONDjkvCUBoX9Fi9jRqnNKspLMCrAX5ZdlsaW1EyQc=;
	b=MK+ewrVZg4BTrrwIqw2DWIFZd6g3IZYnaCc/Z0Y696FZ5kFVc8yaRVLj+/ThGhLE6JiXzE
	DieBfEzi0MJdOJBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713164193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QVONDjkvCUBoX9Fi9jRqnNKspLMCrAX5ZdlsaW1EyQc=;
	b=CwP7y0NJCGtTzmdGQMM48un+Pq214ylZ53B0EqUTPHxivOx8FonhItNaB5ahUmYnbPSgyi
	w2fE+T0eNgZThdNAY5w47hndGzBvIUblazR8XmKF/Ys7RytDUa4aYO09X5Qh/uQjjSLoLR
	WWPP6qTOw8FX69YLUhd2KJwWbwzxhao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713164193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QVONDjkvCUBoX9Fi9jRqnNKspLMCrAX5ZdlsaW1EyQc=;
	b=MK+ewrVZg4BTrrwIqw2DWIFZd6g3IZYnaCc/Z0Y696FZ5kFVc8yaRVLj+/ThGhLE6JiXzE
	DieBfEzi0MJdOJBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2C6C1368B;
	Mon, 15 Apr 2024 06:56:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DrrkJaDPHGZKBwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 15 Apr 2024 06:56:32 +0000
Message-ID: <b4cafdd1-c1b0-4abd-a849-8132c19d1525@suse.de>
Date: Mon, 15 Apr 2024 08:56:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] backlight: Constify lcd_ops
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Alexander Shiyan <shc_work@mail.ru>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-omap@vger.kernel.org
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
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
In-Reply-To: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,linux-vserver.org,mail.ru,pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de,mail.ru];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -4.29
X-Spam-Flag: NO

Hi

for patches 16, 17 and 18:

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Best regards
Thomas

Am 14.04.24 um 18:35 schrieb Krzysztof Kozlowski:
> Hi,
>
> Dependencies
> ============
> All further patches depend on the first patch.  Therefore everything
> could go via backlight tree (please ack) or via cross-tree pulls. Or
> whatever maintainer choose, just coordinate this with backlight.
>
> Best regards,
> Krzysztof
>
> ---
> Krzysztof Kozlowski (18):
>        backlight: Constify lcd_ops
>        backlight: ams369fg06: Constify lcd_ops
>        backlight: corgi_lcd: Constify lcd_ops
>        backlight: hx8357: Constify lcd_ops
>        backlight: ili922x: Constify lcd_ops
>        backlight: ili9320: Constify lcd_ops
>        backlight: jornada720_lcd: Constify lcd_ops
>        backlight: l4f00242t03: Constify lcd_ops
>        backlight: lms283gf05: Constify lcd_ops
>        backlight: lms501kf03: Constify lcd_ops
>        backlight: ltv350qv: Constify lcd_ops
>        backlight: otm3225a: Constify lcd_ops
>        backlight: platform_lcd: Constify lcd_ops
>        backlight: tdo24m: Constify lcd_ops
>        HID: picoLCD: Constify lcd_ops
>        fbdev: clps711x: Constify lcd_ops
>        fbdev: imx: Constify lcd_ops
>        fbdev: omap: lcd_ams_delta: Constify lcd_ops
>
>   drivers/hid/hid-picolcd_lcd.c            | 2 +-
>   drivers/video/backlight/ams369fg06.c     | 2 +-
>   drivers/video/backlight/corgi_lcd.c      | 2 +-
>   drivers/video/backlight/hx8357.c         | 2 +-
>   drivers/video/backlight/ili922x.c        | 2 +-
>   drivers/video/backlight/ili9320.c        | 2 +-
>   drivers/video/backlight/jornada720_lcd.c | 2 +-
>   drivers/video/backlight/l4f00242t03.c    | 2 +-
>   drivers/video/backlight/lcd.c            | 4 ++--
>   drivers/video/backlight/lms283gf05.c     | 2 +-
>   drivers/video/backlight/lms501kf03.c     | 2 +-
>   drivers/video/backlight/ltv350qv.c       | 2 +-
>   drivers/video/backlight/otm3225a.c       | 2 +-
>   drivers/video/backlight/platform_lcd.c   | 2 +-
>   drivers/video/backlight/tdo24m.c         | 2 +-
>   drivers/video/fbdev/clps711x-fb.c        | 2 +-
>   drivers/video/fbdev/imxfb.c              | 2 +-
>   drivers/video/fbdev/omap/lcd_ams_delta.c | 2 +-
>   include/linux/lcd.h                      | 6 +++---
>   19 files changed, 22 insertions(+), 22 deletions(-)
> ---
> base-commit: 9ed46da14b9b9b2ad4edb3b0c545b6dbe5c00d39
> change-id: 20240414-video-backlight-lcd-ops-276d8439ffb8
>
> Best regards,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



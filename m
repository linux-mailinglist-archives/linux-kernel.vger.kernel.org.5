Return-Path: <linux-kernel+bounces-95175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FA3874A42
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 199AF1C221E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95EA82D91;
	Thu,  7 Mar 2024 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VvQogetT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qmb0ocOp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VvQogetT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qmb0ocOp"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA291C2A3;
	Thu,  7 Mar 2024 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709801986; cv=none; b=kHojo4cI7fw/FC3KXzVp1aj0zskeLAkdd/YPzimwun7X6CyIjzBkB9OGCT7lYtccLwqhkLBh/w4cSBbR+lOO7fgwHNFLES3lPOSZJoX59FfEsJXxwF2rwuHo7nlKfoBl+Z20h81W5qXvZh3X7U4cEPjKOtrRQM/gkyMIgtIMIWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709801986; c=relaxed/simple;
	bh=ZDsYXwiTTgifrM7aKCBBIntVddtFklS2hnxDsSUEIx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cRHC8I1Sv/2tzyN7ShlSIyYJ5XzJmAPBlF0AYIbUTkjnaGbyP3owQLj27gva2URckwCAPYtADJ+6x/XEM3eAyyU3c+Ys9uIqsbch9R3HJD/1W/YpJYQ/kTQNOrcvzEp//4rKOsbnko2zqXTAohl8+bexozrnAq7zlKbYeibtgok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VvQogetT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qmb0ocOp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VvQogetT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qmb0ocOp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5E8EC38949;
	Thu,  7 Mar 2024 08:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709801982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Zr1vglmdaTVF4Y5C+JCtluV3UMYKqQ7gx5fxIkqkoVw=;
	b=VvQogetTf/95bbo74xOfRkUqpGRuCqV9YNka3pz/Zykuze2ZUAaUNpq0zEYSmeg0X5fjZc
	8lXmLoHrJxzonV1kp7l4kApYKMYwIL1XhKjZxtSY7iAqhsQ0j2pC2j474z3eoWNWziX+xF
	2ySMB7eNyX6wdrVLiFrW0U47LyomLeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709801982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Zr1vglmdaTVF4Y5C+JCtluV3UMYKqQ7gx5fxIkqkoVw=;
	b=qmb0ocOpIGTIw5ApzfJWBCPw7A+4Qx5qBRNg+/IikDhX+q3h6wUBU/NyGbwRQje2tgWsu4
	OZngehUOQKu3GPBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709801982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Zr1vglmdaTVF4Y5C+JCtluV3UMYKqQ7gx5fxIkqkoVw=;
	b=VvQogetTf/95bbo74xOfRkUqpGRuCqV9YNka3pz/Zykuze2ZUAaUNpq0zEYSmeg0X5fjZc
	8lXmLoHrJxzonV1kp7l4kApYKMYwIL1XhKjZxtSY7iAqhsQ0j2pC2j474z3eoWNWziX+xF
	2ySMB7eNyX6wdrVLiFrW0U47LyomLeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709801982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Zr1vglmdaTVF4Y5C+JCtluV3UMYKqQ7gx5fxIkqkoVw=;
	b=qmb0ocOpIGTIw5ApzfJWBCPw7A+4Qx5qBRNg+/IikDhX+q3h6wUBU/NyGbwRQje2tgWsu4
	OZngehUOQKu3GPBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id F209813997;
	Thu,  7 Mar 2024 08:59:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id EV+QOf2B6WW7FAAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Thu, 07 Mar 2024 08:59:41 +0000
Message-ID: <2c8ef49b-f20b-47f7-ad4e-2adcfd370024@suse.de>
Date: Thu, 7 Mar 2024 09:59:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] arch/powerpc: Resolve backlight include
 dependencies
Content-Language: en-US
To: mpe@ellerman.id.au, jani.nikula@intel.com, naresh.kamboju@linaro.org,
 deller@gmx.de, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 lkft-triage@lists.linaro.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20240306122935.10626-1-tzimmermann@suse.de>
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
In-Reply-To: <20240306122935.10626-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 FREEMAIL_TO(0.00)[ellerman.id.au,intel.com,linaro.org,gmx.de,gmail.com,csgroup.eu,kernel.org,linux.ibm.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -3.09
X-Spam-Flag: NO

If there are no further comments, I'm going to merge this patchset in 
time for today's PR of drm-misc-next-fixes.

Am 06.03.24 um 13:28 schrieb Thomas Zimmermann:
> After cleaning up <linux/fb.h> in commit 11b4eedfc87d ("fbdev: Do
> not include <linux/backlight.h> in header"), building with
> CONFIG_PMAC_BACKLIGHT=y returns errors about missing declarations.
> Patches 1 and 2 resolve the errors. Patch 1 has been reviewed at [1].
> Patch 3 removes another dependency between backlight and fbdev code.
>
> Compile tested with ppc6xx_defconfig.
>
> v3:
> 	* add Fixes tag and fix typos in patch 3
> v2:
> 	* via-pmu-backlight: fix build errors
> 	* powerpc: resolve dependency between fbdev and backlight
>
> [1] https://patchwork.freedesktop.org/series/130661/
>
> Thomas Zimmermann (3):
>    fbdev/chipsfb: Include <linux/backlight.h>
>    macintosh/via-pmu-backlight: Include <linux/backlight.h>
>    arch/powerpc: Remove <linux/fb.h> from backlight code
>
>   arch/powerpc/include/asm/backlight.h        |  5 ++--
>   arch/powerpc/platforms/powermac/backlight.c | 26 ---------------------
>   drivers/macintosh/via-pmu-backlight.c       |  1 +
>   drivers/video/fbdev/chipsfb.c               |  1 +
>   4 files changed, 4 insertions(+), 29 deletions(-)
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



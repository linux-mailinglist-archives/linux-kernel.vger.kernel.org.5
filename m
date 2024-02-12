Return-Path: <linux-kernel+bounces-61991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7C98519B2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24231C21D90
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFAC46535;
	Mon, 12 Feb 2024 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iaI1O+Xx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LIL+EIdb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WwrZb4e7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z6+jGAtu"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC1D45C18
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755624; cv=none; b=CQzv7Sbi6exLwjqyp6ZgHy+2lhIriptYVbSDm1fBn0FCZARgbHbanQcP4V7c+3lbMMjzNCVHkbF5ACtvWe1SmFSTfXSf+IWjMz2PmixmaC5+5z7HkPWF2Dc3Fax84mdKQcHI65mSaPezhWtuM6VnU2JjNAtc2cnITz6eSXC51J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755624; c=relaxed/simple;
	bh=sIT48zWYaq211h0D/pInLVAtCRz/L/niDco5bJU/Lfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZNZEsLyPnJynXOnudoQsDA07AnW5+KVfIr5tX8158MRA3h3EXyiz3Y4B1B+gH7ECIE0Pe8zRviwhQ1XiyjLy/uqKKIvrYUKamWgNLBhDRGor59E7g3v+2P3vBGNr8/jeLhAzcAik6dKNHHudIJDWF83DMnyYrIXO7MIiDqsTF5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iaI1O+Xx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LIL+EIdb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WwrZb4e7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z6+jGAtu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 074EB220EB;
	Mon, 12 Feb 2024 16:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707755621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q0910e8b8VAnN+OakgS1cjNJXhIY2CWuAZHL3URjUXs=;
	b=iaI1O+Xx6blTx1a0gRXFgIYagiVFiotI1XqBljmmftstcY4MxkcYoJnOv0A+MBcfsF+J1U
	buyI3SqNY+Sup9j1DQ7XRCkvUAneSI5m1TeE+17Tc6L1lh9oBy91bpmmM2CUYvDrJP1XBz
	zCrbuaJ9CCZ9OQK7JuPLMC+UZo5QJkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707755621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q0910e8b8VAnN+OakgS1cjNJXhIY2CWuAZHL3URjUXs=;
	b=LIL+EIdb7JBsReBRr/sV0B3qpidniBR85Z+BYZWUWRA7xTROncyPGp6hdBETNK6qm/wktx
	p0RF+FJxi+BMlFCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707755620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q0910e8b8VAnN+OakgS1cjNJXhIY2CWuAZHL3URjUXs=;
	b=WwrZb4e7IOI1Kj2r903IbeX/BA1oWRndDiPEo5rTafOfdNV9aV6dxtjWlNE8GPTERU73O2
	5PWogY+E2pWWYSLDjtTtBcpSNI8/XLsw3AX1PL65utkmwlmhN1pN50bOG27nQgOB64oF+M
	bJcn0ziaNwiZV7is33Q0f6HxqWhHnrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707755620;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q0910e8b8VAnN+OakgS1cjNJXhIY2CWuAZHL3URjUXs=;
	b=z6+jGAtuOpW1wbi4AidB13OpFadERrXglFaZLjfWN7aROyUrL5IRqedMsArK6CXcuL4K2I
	eDvj3MHqPChMSbBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C87CB13A0E;
	Mon, 12 Feb 2024 16:33:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id suANL2NIymWsYAAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 12 Feb 2024 16:33:39 +0000
Message-ID: <9c7df0e5-31a9-4c86-b996-4cba82c4ea2f@suse.de>
Date: Mon, 12 Feb 2024 17:33:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] auxdisplay: Take over maintainership, but in Odd
 Fixes mode
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-kernel@vger.kernel.org, Javier Martinez Canillas <javierm@redhat.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
 <20240212132515.2660837-3-andriy.shevchenko@linux.intel.com>
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
In-Reply-To: <20240212132515.2660837-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.15 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.06)[61.78%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linux-m68k.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.15

(cc'ing Javier Martinez Canillas)

Hi

Am 12.02.24 um 14:23 schrieb Andy Shevchenko:
> I have no time for this, but since it looks like I'm the main
> contributor for the last few years to the subsystem, I'll take
> it for now. Geert agreed to help me with as a designated reviwer.
> Let's see how it will go...

A few days ago, I talked to Javier about how auxdisplay is a hotchpodge 
of various drivers that seem to belong into other subsystems. Could we 
attempt to move all drivers into other places and then remove the 
auxdisplay subsystem?

Best regards
Thomas

>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   MAINTAINERS | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 75cf018922a4..e2a804e22c3b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3406,8 +3406,10 @@ F:	drivers/base/auxiliary.c
>   F:	include/linux/auxiliary_bus.h
>   
>   AUXILIARY DISPLAY DRIVERS
> -M:	Miguel Ojeda <ojeda@kernel.org>
> -S:	Maintained
> +M:	Andy Shevchenko <andy@kernel.org>
> +R:	Geert Uytterhoeven <geert@linux-m68k.org>
> +S:	Odd Fixes
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-auxdisplay.git
>   F:	Documentation/devicetree/bindings/auxdisplay/
>   F:	drivers/auxdisplay/
>   F:	include/linux/cfag12864b.h

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



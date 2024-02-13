Return-Path: <linux-kernel+bounces-63122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFA8852B31
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171EC1F23445
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF3B18654;
	Tue, 13 Feb 2024 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E0B36xOn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ErtOxfT6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E0B36xOn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ErtOxfT6"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44305182A1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812920; cv=none; b=T1+L1MLSK5WpZxA+Ap8tbhRAVkag5GW8xzpU6MyEBJepZq/Y8Hz2UDZdRAzDPtd3zy+Xc8FhmeptrG1pjqMMZZeOmmYU1rYjZX0F29jNgxcd9RH+0JkN1UXoMuVvvi3NqZmrbYab8QCMNSP+LQM2nRO7gXuNZtNboAhMvl1xsQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812920; c=relaxed/simple;
	bh=E3JQDMn2sFTf5an3TnAg5LT2inVnY6no7dbHKjs0p3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jfd12BvnFgKZswJlcq7ElJBtqmqZ7K4eLBbfvqSUtFW8EbERD1m0dF/bBHyLaFqDjCpZvOFiMUSg8uXTWI/qEIaCumLnTrJwkV1otn6IMtwROAJShAo33YloO3gwI4wxM8RO93FdoTEuTm+KfB57apTTnx78RV0RXASIs0qgxeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E0B36xOn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ErtOxfT6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E0B36xOn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ErtOxfT6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 588A61FC26;
	Tue, 13 Feb 2024 08:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707812916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FV5Ur3ab9dx+OG5FnXA9loVyz+svXC5P9gSuUizdnzs=;
	b=E0B36xOnenWbJldd9gdU+5aPY4kkzrC4QPemsJzTWe6puBb5BJYnnb26br1u3NJiANocNr
	6sl978Td+cWxTuNFCmBGT6y3NPAfLlp5LpTxOb4Rzk8ltMFiVuIgz0axZrPpAWjfoEzuVv
	Ge8FbOaUISE7bp/3E6GcreHy9df89h0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707812916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FV5Ur3ab9dx+OG5FnXA9loVyz+svXC5P9gSuUizdnzs=;
	b=ErtOxfT6p+aVn4eD8FZn/adqqE9izMqcYsbTTmgHinFJwmzIpJSkQrrH1XhMRmZaGSZKaj
	Nro5m5ujsUiUXfCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707812916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FV5Ur3ab9dx+OG5FnXA9loVyz+svXC5P9gSuUizdnzs=;
	b=E0B36xOnenWbJldd9gdU+5aPY4kkzrC4QPemsJzTWe6puBb5BJYnnb26br1u3NJiANocNr
	6sl978Td+cWxTuNFCmBGT6y3NPAfLlp5LpTxOb4Rzk8ltMFiVuIgz0axZrPpAWjfoEzuVv
	Ge8FbOaUISE7bp/3E6GcreHy9df89h0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707812916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FV5Ur3ab9dx+OG5FnXA9loVyz+svXC5P9gSuUizdnzs=;
	b=ErtOxfT6p+aVn4eD8FZn/adqqE9izMqcYsbTTmgHinFJwmzIpJSkQrrH1XhMRmZaGSZKaj
	Nro5m5ujsUiUXfCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 325C11329E;
	Tue, 13 Feb 2024 08:28:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id yikACzQoy2W4EwAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Tue, 13 Feb 2024 08:28:36 +0000
Message-ID: <17040808-89ca-41f9-a584-789f000c8e0a@suse.de>
Date: Tue, 13 Feb 2024 09:28:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] auxdisplay: Take over maintainership, but in Odd
 Fixes mode
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
 Javier Martinez Canillas <javierm@redhat.com>,
 Miguel Ojeda <ojeda@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
 <20240212132515.2660837-3-andriy.shevchenko@linux.intel.com>
 <9c7df0e5-31a9-4c86-b996-4cba82c4ea2f@suse.de>
 <ZcpKh_EgNM5IaV-P@smile.fi.intel.com>
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
In-Reply-To: <ZcpKh_EgNM5IaV-P@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=E0B36xOn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ErtOxfT6
X-Spamd-Result: default: False [-3.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 588A61FC26
X-Spam-Level: 
X-Spam-Score: -3.30
X-Spam-Flag: NO

Hi

Am 12.02.24 um 17:42 schrieb Andy Shevchenko:
> On Mon, Feb 12, 2024 at 05:33:39PM +0100, Thomas Zimmermann wrote:
>> (cc'ing Javier Martinez Canillas)
>>
>> Hi
>>
>> Am 12.02.24 um 14:23 schrieb Andy Shevchenko:
>>> I have no time for this, but since it looks like I'm the main
>>> contributor for the last few years to the subsystem, I'll take
>>> it for now. Geert agreed to help me with as a designated reviwer.
>>> Let's see how it will go...
>> A few days ago, I talked to Javier about how auxdisplay is a hotchpodge of
>> various drivers that seem to belong into other subsystems. Could we attempt
>> to move all drivers into other places and then remove the auxdisplay
>> subsystem?
> Can you be more precise on how it can be done? We have at least two clusters of
> the displays: line-display and HD44780-based ones. Moreover, the latter might
> use the former in the future (in some cases).

I see. Taking a closer look, it's not as simple as I implied.

We noticed that cfag1286bfb and ht16k33 are fbdev-based drivers. They 
seem to belong into video/fbdev. But OTOH ht16k33 appears to drive 
14-segment displays and fbdev appears to be an odd choice for such 
devices. And as Javier already noted, we wondered if these charlcd 
displays aren't just a special case of TTYs.

Best regards
Thomas

>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



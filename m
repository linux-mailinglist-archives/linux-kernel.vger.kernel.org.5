Return-Path: <linux-kernel+bounces-121976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB03588F018
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21AD6B245A1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B688152501;
	Wed, 27 Mar 2024 20:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BxVBXQbc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K97Ez81x";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BxVBXQbc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K97Ez81x"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673B61514F7;
	Wed, 27 Mar 2024 20:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711571310; cv=none; b=nSLKaKiS31kAE9WAQOf3V7o563yuGwUJHRSPQd4Z0LPGkRNgUUQcW+ARl1jR3aFFfyO3PPQLptwybX6yv1z1BWqQFd6VFTGNM76BTd6W1qc8f43QxLFzz7jj0R4/r2AUGQ6z68jRFMxTjkgxtkASnECOGGx+Yvfc93lKu8DdG5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711571310; c=relaxed/simple;
	bh=UpUOyzIoicAiSAUUbpqychIlGaoQK9rh/sgsGu0bpwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MiOWiKT+gO/TKnQtxFgC7pB5ykkITjJMxRSEiAmzga1TDDjLK6hRiu04V7vlaaKEbAgDjbtKbL4IGVeF1T4aGqYjFbwLDn1ENe7B6KsPlmv7a4wDBzDyepyudMC7KOIQFbJJJi3hgVG6lk0ZgQIw6AK6X7v1QSCEBcutTdyJdJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BxVBXQbc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K97Ez81x; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BxVBXQbc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K97Ez81x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 84E0E1FB6E;
	Wed, 27 Mar 2024 20:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711571306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1DwBX/Ioxr6p7/z032afJeSuUVlWTs0NlyebTRJsgxA=;
	b=BxVBXQbct7a8JRNQSwI/g+RzMMGE/Hsa9pxQCIa3PqR6bjb2cTAPI8BjbzO9wULFX/vC+Y
	a1VHQ5zpiTINQ72cBjokvsYvChcfv7QmXBfOmXgwIaOvmKltedxQFMksUCpZ9+omml1yBl
	LIJH/qTT9aVkY22rXXSI9RWMcopC9jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711571306;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1DwBX/Ioxr6p7/z032afJeSuUVlWTs0NlyebTRJsgxA=;
	b=K97Ez81xCppZbLqRxrwLBwvnch6LSOtsfMff+bMu6C1koV6kWud5U7TypvFeB0ArIYB695
	KWCEo2KafGRN9TCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711571306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1DwBX/Ioxr6p7/z032afJeSuUVlWTs0NlyebTRJsgxA=;
	b=BxVBXQbct7a8JRNQSwI/g+RzMMGE/Hsa9pxQCIa3PqR6bjb2cTAPI8BjbzO9wULFX/vC+Y
	a1VHQ5zpiTINQ72cBjokvsYvChcfv7QmXBfOmXgwIaOvmKltedxQFMksUCpZ9+omml1yBl
	LIJH/qTT9aVkY22rXXSI9RWMcopC9jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711571306;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1DwBX/Ioxr6p7/z032afJeSuUVlWTs0NlyebTRJsgxA=;
	b=K97Ez81xCppZbLqRxrwLBwvnch6LSOtsfMff+bMu6C1koV6kWud5U7TypvFeB0ArIYB695
	KWCEo2KafGRN9TCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 125E013AB3;
	Wed, 27 Mar 2024 20:28:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id hJVdAmqBBGZBEQAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 27 Mar 2024 20:28:26 +0000
Message-ID: <5df1d391-7683-4d9c-accc-9b446d46a150@suse.de>
Date: Wed, 27 Mar 2024 21:28:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ast: Fix soft lockup
Content-Language: en-US
To: Jocelyn Falempe <jfalempe@redhat.com>, Jammy Huang
 <orbit.huang@gmail.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@redhat.com, airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jammy Huang <jammy_huang@aspeedtech.com>, stable@vger.kernel.org
References: <20240325033515.814-1-jammy_huang@aspeedtech.com>
 <c04ebd16-f0b0-45be-a831-fae8b50b7011@redhat.com>
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
In-Reply-To: <c04ebd16-f0b0-45be-a831-fae8b50b7011@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -0.40
X-Spamd-Result: default: False [-0.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 BAYES_HAM(-0.61)[81.97%];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FREEMAIL_TO(0.00)[redhat.com,gmail.com,linux.intel.com,kernel.org,ffwll.ch];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

Hi

Am 27.03.24 um 09:53 schrieb Jocelyn Falempe:
> Hi,
>
> Thanks for your patch.
> I'm wondering how you can trigger this infinite loop ?

Yeah, a bit more context for this bug would be welcome. It's hard to 
judge the fix without.

Best regards
Thomas

>
> Also this looks like a simple fix, that can be easily backported, so 
> I'm adding stable in Cc.
>
> If Thomas has no objections, I can push it to drm-misc-fixes.
>
> Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
>



-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



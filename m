Return-Path: <linux-kernel+bounces-127667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DA1894F33
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41891C20B1B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D895914C;
	Tue,  2 Apr 2024 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SYkEkt1j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kx05Nsyz"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89379454;
	Tue,  2 Apr 2024 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051693; cv=none; b=m58oXBF9XbfePTZ/zfAT+Z3Pqg3Pw7prt+ZbO5ZkJ+Af0khu5OBikoo63TFkVQA601ICj8SqNTAL/7n59Ytdksgt+uyuEH1l4Wihcj+z44m7FDpG7j48an3KeIQG1nnLMqNkECP1IWrtD/mtCLFsOJHrN9CRC877p+gjeecuo58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051693; c=relaxed/simple;
	bh=6/N3UP7vL7GHx0qWSgrSlYTnJTOsV6KmnYfX374J4X8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a45LwoShG6An7n9o2KQ5ppWu8jubql9PqCGDvTGNTOicLfcTe50TKx0XzXWVeFj4aFF5P+dsRsV9EnRuAy23QqNOO6vU1BMX0zoE71EOHRYkceApYpHqFPmEdMZxErHar72E0Uvu5HdGOlcvKnf48MPy8c/EF2axoeMDwxznouc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SYkEkt1j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kx05Nsyz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 19A9C20F14;
	Tue,  2 Apr 2024 09:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712051690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gBPbUu8Imat77PQrgTuqku3txKkbAPIguPO8wk1Ajv8=;
	b=SYkEkt1jueEur79OpZhutROwuCwOGZ1UISwoV71W3rj0sh+ELNvbNnEjSJiQA9qToCjGT9
	9+YNaUm/Pq6deaWOGQMHLmz9CRrCrnPBEo/DSB8cCtwcJxSlXtctA/xcDf9WAfmJ3UduLK
	YbGSkupVus6H15ZHgrFndSoAvgA1Uy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712051690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gBPbUu8Imat77PQrgTuqku3txKkbAPIguPO8wk1Ajv8=;
	b=kx05NsyzG1JKkF68ZrIXwukGblpBZQFYN/ieIs2aZyI35HBgA4Vn14g8BV5ijUjlsrJNRH
	VPzdKU0OJ1JbPeCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BAF6913A90;
	Tue,  2 Apr 2024 09:54:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Vqo+LOnVC2b2BgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Tue, 02 Apr 2024 09:54:49 +0000
Message-ID: <f1e4e73d-7fe4-435a-b301-c11eaf4e10e6@suse.de>
Date: Tue, 2 Apr 2024 11:54:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ast: Fix soft lockup
To: =?UTF-8?B?6buD56uL6YqY?= <orbit.huang@gmail.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@redhat.com, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jammy Huang <jammy_huang@aspeedtech.com>, stable@vger.kernel.org
References: <20240325033515.814-1-jammy_huang@aspeedtech.com>
 <c04ebd16-f0b0-45be-a831-fae8b50b7011@redhat.com>
 <5df1d391-7683-4d9c-accc-9b446d46a150@suse.de>
 <CAOj9kT3=UA-5wkVXb8Rk2h3D=vtZDbhzxe4MY=Nwzod96DeppA@mail.gmail.com>
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
In-Reply-To: <CAOj9kT3=UA-5wkVXb8Rk2h3D=vtZDbhzxe4MY=Nwzod96DeppA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: 2.30
X-Spam-Flag: NO
X-Spamd-Bar: ++
X-Spamd-Result: default: False [2.30 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.10)[65.09%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org,aspeedtech.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: **
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 19A9C20F14

Hi

Am 01.04.24 um 04:20 schrieb 黃立銘:
> Hi Thomas and Jocelyn,
>
> What we do in ast_dp_set_on_off() is a handshake between host driver
> and bmc-fw to confirm
> the operation, on/off, is completed.
>
> We use some scratch registers in bmc to handshake with host. This
> handshake only work if
> BMC's scu-lock is opened. If scu-lock is opened too late, then it
> could lead to this issue.

Thanks a lot. Can you please send a new version of this patch with this 
information in the commit message? Please also mention why 200 ms is a 
good upper limit.

The code currently waits and then possibly breaks the loop. Should the 
if-branch be located before the mdelay() statement to avoid any 
unnecessary waiting?

Please also send the patch from your Aspeed email address. Our scripts 
do not accept patches where the sender differs from the Signed-off-by tag.

Best regards
Thomas

>
> Best regards
> Jammy
>
> Thomas Zimmermann <tzimmermann@suse.de> 於 2024年3月28日 週四 上午4:28寫道：
>> Hi
>>
>> Am 27.03.24 um 09:53 schrieb Jocelyn Falempe:
>>> Hi,
>>>
>>> Thanks for your patch.
>>> I'm wondering how you can trigger this infinite loop ?
>> Yeah, a bit more context for this bug would be welcome. It's hard to
>> judge the fix without.
>>
>> Best regards
>> Thomas
>>
>>> Also this looks like a simple fix, that can be easily backported, so
>>> I'm adding stable in Cc.
>>>
>>> If Thomas has no objections, I can push it to drm-misc-fixes.
>>>
>>> Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
>>>
>>
>>
>> --
>> --
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Frankenstrasse 146, 90461 Nuernberg, Germany
>> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
>> HRB 36809 (AG Nuernberg)
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



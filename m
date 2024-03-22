Return-Path: <linux-kernel+bounces-111118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA149886823
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6521C23A91
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4561B267;
	Fri, 22 Mar 2024 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N3aWu1ou";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fWVBscP/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N3aWu1ou";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fWVBscP/"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F561199A1;
	Fri, 22 Mar 2024 08:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711095721; cv=none; b=YoKlRA0dX2FS/hz0JAlw7qKnJXj/5u25Ce4z+SL0w84KXkqNtzE0o4w8xcKy8w0x7fh8IL2wL36J+vU0jVFRWYgSWJLqojT51URPNfBFjs71MSvLH+ap/KNmIn9clI4J+N5u5hbkc6677Zl2o0Lih+jvzdaVxeNpWEvBqARlvZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711095721; c=relaxed/simple;
	bh=W+tSzgZPY2VD8BxwHG9VS8fFQkYGiSQRCDwPzLR/euk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M5XWFvfRoRmDKPe//RO6KteKSTn+pm4u9nEUnUI+UsK0U4Jb5f//1vH9BvnDHRkmAuqCqDcgyYjUfPl0eIqoVZMwWBULt40gPxbJvLM2WQhFcM8uibPiExhXpPz1wkoifowbql7p7S7flS/Jxwf3nv+Mk2uoJ0Nns80a7TBidlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N3aWu1ou; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fWVBscP/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N3aWu1ou; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fWVBscP/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D15D338271;
	Fri, 22 Mar 2024 08:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711095717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d4CAmRTbTo7VtEDRy859Wyk1/Hjt7vQUOUoTpI6/ix8=;
	b=N3aWu1ouL5JNgsgPAMFSZTy7QWoi/+M4zG0nY+VGfHrBC+P8XJvqUkkDsGc7uOhO7oYBo5
	busLq5aRS2iWuBLy89JRjHau/ZvFYAs+0w9/GlxhJtKPRJTIGL33Fv5DNq203Js6brpbqe
	TMygON6aUzbbK+9SHY7oXaG1czL7xKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711095717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d4CAmRTbTo7VtEDRy859Wyk1/Hjt7vQUOUoTpI6/ix8=;
	b=fWVBscP/We1+c3lLM8k8pPYi5OaD5O/WxMShF+7Lf6V6dX22BIDC3ZkzpHEn1FeH8PbwEb
	v0diVLy9PLD4dVDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711095717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d4CAmRTbTo7VtEDRy859Wyk1/Hjt7vQUOUoTpI6/ix8=;
	b=N3aWu1ouL5JNgsgPAMFSZTy7QWoi/+M4zG0nY+VGfHrBC+P8XJvqUkkDsGc7uOhO7oYBo5
	busLq5aRS2iWuBLy89JRjHau/ZvFYAs+0w9/GlxhJtKPRJTIGL33Fv5DNq203Js6brpbqe
	TMygON6aUzbbK+9SHY7oXaG1czL7xKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711095717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d4CAmRTbTo7VtEDRy859Wyk1/Hjt7vQUOUoTpI6/ix8=;
	b=fWVBscP/We1+c3lLM8k8pPYi5OaD5O/WxMShF+7Lf6V6dX22BIDC3ZkzpHEn1FeH8PbwEb
	v0diVLy9PLD4dVDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A828B132FF;
	Fri, 22 Mar 2024 08:21:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WB6uJ6U//WWgLwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 22 Mar 2024 08:21:57 +0000
Message-ID: <4ed32e4f-d794-42ab-9292-cb6f11b31348@suse.de>
Date: Fri, 22 Mar 2024 09:21:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PROBLEM: Linux 6.8 build failure in sun ffb driver (regression)
Content-Language: en-US
To: Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org, regressions@lists.linux.dev
References: <5bc21364-41da-a339-676e-5bb0f4faebfb@draconx.ca>
 <7c9b4c27-e179-c136-e327-4c467ece81a2@draconx.ca>
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
In-Reply-To: <7c9b4c27-e179-c136-e327-4c467ece81a2@draconx.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.90
X-Spamd-Result: default: False [0.90 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.00)[40.19%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(2.00)[0.665];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

Hi

Am 22.03.24 um 03:18 schrieb Nick Bowler:
> I bisected this build failure to the following commit:
>
>    commit 8813e86f6d82a7931446c3cbc5d596f77d0f1ba6
>    Author: Thomas Zimmermann <tzimmermann@suse.de>
>    Date:   Mon Nov 27 14:16:01 2023 +0100
>
>        fbdev: Remove default file-I/O implementations
>
> If I revert this commit on top of 6.8, the build is successful.

Thanks for reporting. It looks like a trivial Kconfig problem. I'll send 
a patch.

Best regards
Thomas

>
> On 2024-03-21 21:00, Nick Bowler wrote:
>> Hi,
>>
>> Linux 6.8 (and 6.8.1) are failing to build for me:
>>
>>    LD      .tmp_vmlinux.kallsyms1
>> sparc64-unknown-linux-gnu-ld: drivers/video/fbdev/ffb.o:(.rodata+0x270): undefined reference to `fb_io_read'
>> sparc64-unknown-linux-gnu-ld: drivers/video/fbdev/ffb.o:(.rodata+0x278): undefined reference to `fb_io_write'
>> make[3]: *** [/home/nbowler/misc/linux/scripts/Makefile.vmlinux:37: vmlinux] Error 1
>>
>> This problem does not occur when building Linux 6.7 which builds successfully.
>>
>> Kernel .config attached (gzipped).
>>
>> Please let me know if you need any more info.
>>
>> Thanks,
>>    Nick

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



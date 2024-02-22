Return-Path: <linux-kernel+bounces-76064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6997485F280
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38641F21A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164F217BCA;
	Thu, 22 Feb 2024 08:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fItP/a/V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z2ZPpCNM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qbMRqboS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uTS/ViAF"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD7E3210;
	Thu, 22 Feb 2024 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589443; cv=none; b=OCCnaeGpqWhRjDRPxVbSZJy9oxm+uMJ3pfhHWabs6s2ewrveyM0roUvxfy+ZFrq7X3z0sPCfq2tABYQftiV3xbATuz0DTsf9x8+MVljzg8OOtTpDYzfV1IE/Ib4/nsUWcx5Wxno9PrhBZPxJvbzrrGPylFZRzAxxWZAcNclpWPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589443; c=relaxed/simple;
	bh=Ykb9QS2BhIVnJVG+DGzluCfQ8nsh3AINvIBTFRx3LTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RneA1t2HncodG9VADF65j33alXPsK4Sl52k1kk7b4zPeAvL6H+3nqZwPaLZHa/qmMY5DLUoIXn42gOjo4OyQ34RlZXU0xgr9NCoWmcOll4afGie76TgazxM4Cjcfd4EYMZBpYjV4O/F1PtCNmlPxfPqNLwGS/0puIQlo5RQ9iBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fItP/a/V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z2ZPpCNM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qbMRqboS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uTS/ViAF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E3D871F44B;
	Thu, 22 Feb 2024 08:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708589434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=InezbfYZhgpCMs3q19mLDr21V22eoyIEpatZkAm0n3Y=;
	b=fItP/a/Vnv5zjQkBeLBvFIsM3EHMv1KcCHILF5qMPt/qlAbX2hkDkRXBJ18mwu2CdapXFD
	ynSPpkvPu6YAjh14gKaJ/JSiYP7+PSuVSkfsNzMtXuWLjKQO+eVzfchrnlHZU9Pb0Vt41n
	hwOz5agnjHAszGnzjxHjSrtKw3cEUY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708589434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=InezbfYZhgpCMs3q19mLDr21V22eoyIEpatZkAm0n3Y=;
	b=z2ZPpCNMXIzovcheiFngerg0d+rCGB7T969WXFp0eRYycsF615VORYkN4IVwgBKKBeuEZm
	oEqtPnbDXj78CvDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708589433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=InezbfYZhgpCMs3q19mLDr21V22eoyIEpatZkAm0n3Y=;
	b=qbMRqboSKHEFbkX71+RpQTktizuR/yxwekTBnQFwnnZZh1uBp9zHiF+UOzDcjXaXQlYSPj
	apAlWGxKueP2NCar4Lz5Sa0sGlENI3MVMEnpaXwupPviGbBoA4fXgfavIUlZL5hM0waFcN
	BtfzfyNzj5nBk5mmOyfV7bNx2y/fNV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708589433;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=InezbfYZhgpCMs3q19mLDr21V22eoyIEpatZkAm0n3Y=;
	b=uTS/ViAF3y6rIMzhMedn7YubLBhNYK2+KdJGnbZ0wzCGPD8IblJ01JTW2VKobpaapE8AL4
	LoK6M+CiKDDds1Aw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A718913A6B;
	Thu, 22 Feb 2024 08:10:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id yuhzJ3kB12U3DwAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Thu, 22 Feb 2024 08:10:33 +0000
Message-ID: <0808bf76-ed7f-44cd-b053-da09ba29fdc4@suse.de>
Date: Thu, 22 Feb 2024 09:10:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware/sysfb: fix an error code in sysfb_init()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <aaaa2e13-849b-41a0-8186-25f3d2a16f86@moroto.mountain>
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
In-Reply-To: <aaaa2e13-849b-41a0-8186-25f3d2a16f86@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[redhat.com,gmx.de,kernel.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO



Am 22.02.24 um 07:13 schrieb Dan Carpenter:
> This error path accidentally returns success when it should preserve the
> error code from sysfb_parent_dev().

Thanks! I'll land the patch via drm-misc.

>
> Fixes: 4e754597d603 ("firmware/sysfb: Create firmware device only for enabled PCI devices")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/firmware/sysfb.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
> index a6b48703dc9e..880ffcb50088 100644
> --- a/drivers/firmware/sysfb.c
> +++ b/drivers/firmware/sysfb.c
> @@ -127,8 +127,10 @@ static __init int sysfb_init(void)
>   	sysfb_apply_efi_quirks();
>   
>   	parent = sysfb_parent_dev(si);
> -	if (IS_ERR(parent))
> +	if (IS_ERR(parent)) {
> +		ret = PTR_ERR(parent);
>   		goto unlock_mutex;
> +	}
>   
>   	/* try to create a simple-framebuffer device */
>   	compatible = sysfb_parse_mode(si, &mode);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



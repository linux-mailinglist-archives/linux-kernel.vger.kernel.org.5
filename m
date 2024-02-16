Return-Path: <linux-kernel+bounces-68156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAA1857694
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A9E281AF4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF1114AA7;
	Fri, 16 Feb 2024 07:10:21 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0115C8BFB
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708067420; cv=none; b=SX1LVyqDgyX61h+wJXGYk+9WASCYsLKBJJntavur58UDb/EHem5IqtnEyW+xRd3b/uTR4uKgyQRi7h198zPusa+wJMdMp/NOnh+A7sldIbhxe4+beosBYKf3XMQImDtgq+LUviQJAT4EciT2ZF3kc1oJJipljO1NHxxKGxwTKN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708067420; c=relaxed/simple;
	bh=ZpQqi58OvqeE7dGvb/+B7nxPR7gxUwvW+MZu87p5Ckw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jJh0hmm2tNASz8EzxIzk8Ju6ySR8MBwge7OXU7CsxlBtatB2GgdbVXkAq5gajWjS4iojfawRbWlAygrHA0cF0gI3dMDZjKfYZ/cR0GWNPNhX/ehIWGHVxd2/faEqFVl8KHhxvvKqzTe5rutAKuPp9WZW5l++aiPp9vq4Bc2l5UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3d0d26182dso178772766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 23:10:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708067417; x=1708672217;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6mcSeC2R4ZO4kgXf8K+cFxo0Sfe2JaXXvLGQvOlQKs=;
        b=kfLhIn+ljVhwKgZG1rbuIWgjpMUnPREGy3seL/+cBmS3whw/sVeLGYZFb01ThwMcvf
         hyW6ekk3u/bh9lItHCa5Y1o7u0NumHffalIsA7TGkdXi7l77Ucp7zIJZifw3SM/yznfh
         ZYLeVZEna3I62U0GqKPw+bPA02Wp1aPS4UROzvzBSXVB1m7ZqocKOwTesoqP87J4FI1o
         L6Nnzdpp18oXDGelSBBOkjO1NpNW5mJCadPtVoRTowig0Dw6vumyeJ5tzGnz5GT8B1te
         czbIlUKjgfivl/jt8gDLn3Oz65I0HXGawO8Z6GWFxEZg15CIammtUii+y/T1MW4qcodi
         c4Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVwZ1pMLVON3kJqvyPM9oZXQw5V3g0ywv12Rxnzfhab+RTkt+JW88y395qBbDOovH7xAeaqbNKIe7V1RLr78xC1SPltXYpcV1c9Zimp
X-Gm-Message-State: AOJu0Yzg/qBsHh4CnKmbEwdzOBQxAxjgYLSvJTq6cnq6nZyKIX+hGt2v
	WsaNcCPRlsqP531NWLyB4wEGK+jAbCiXYb5CegIWBYt5SHL5Hpv+yBm2R9Xz
X-Google-Smtp-Source: AGHT+IFxHy3HYnrpB9RoZ/fCTgPjExL5ApyEkzkbw9MKQaNVQueHAbkwNG5dH5CR489HduUb0TSAUg==
X-Received: by 2002:a17:906:2b09:b0:a3c:f4e8:ac38 with SMTP id a9-20020a1709062b0900b00a3cf4e8ac38mr2664058ejg.9.1708067416938;
        Thu, 15 Feb 2024 23:10:16 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id a7-20020a170906670700b00a3d2d81daafsm1284405ejp.172.2024.02.15.23.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 23:10:16 -0800 (PST)
Message-ID: <7c91e5e0-a6eb-4d53-89ed-efde04f57c7c@kernel.org>
Date: Fri, 16 Feb 2024 08:10:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/5] sticon: Allow to get max font width and height
Content-Language: en-US
To: Alexey Gladkov <legion@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <cover.1708011391.git.legion@kernel.org>
 <0c724c30a36aefe2cb4470182cf868d256fbabcd.1708011391.git.legion@kernel.org>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <0c724c30a36aefe2cb4470182cf868d256fbabcd.1708011391.git.legion@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15. 02. 24, 16:37, Alexey Gladkov wrote:
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> ---
>   drivers/video/console/sticon.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
> index 992a4fa431aa..63368b3ff9c5 100644
> --- a/drivers/video/console/sticon.c
> +++ b/drivers/video/console/sticon.c
> @@ -56,6 +56,11 @@
>   #define BLANK 0
>   static int vga_is_gfx;
>   
> +#define STICON_MIN_FONT_WIDTH 6
> +#define STICON_MIN_FONT_HEIGHT 6
> +#define STICON_MAX_FONT_WIDTH 32
> +#define STICON_MAX_FONT_HEIGHT 32
> +
>   #define STI_DEF_FONT	sticon_sti->font
>   
>   /* borrowed from fbcon.c */
> @@ -180,8 +185,10 @@ static int sticon_set_font(struct vc_data *vc, struct console_font *op,
>   	struct sti_cooked_font *cooked_font;
>   	unsigned char *data = op->data, *p;
>   
> -	if ((w < 6) || (h < 6) || (w > 32) || (h > 32) || (vpitch != 32)
> -	    || (op->charcount != 256 && op->charcount != 512))
> +	if ((w < STICON_MIN_FONT_WIDTH) || (h < STICON_MIN_FONT_HEIGHT) ||
> +	    (w > STICON_MAX_FONT_WIDTH) || (h > STICON_MAX_FONT_HEIGHT) ||

Will
!in_range(w, STICON_MIN_FONT_WIDTH, STICON_MAX_FONT_WIDTH)
look better?

> +	    (vpitch != 32) ||
> +	    (op->charcount != 256 && op->charcount != 512))
>   		return -EINVAL;
>   	pitch = ALIGN(w, 8) / 8;
>   	bpc = pitch * h;
> @@ -273,6 +280,15 @@ static int sticon_font_set(struct vc_data *vc, struct console_font *font,
>   	return sticon_set_font(vc, font, vpitch);
>   }
>   
> +static int sticon_font_info(struct vc_data *vc, struct console_font *font)
> +{
> +	font->width = STICON_MAX_FONT_WIDTH;
> +	font->height = STICON_MAX_FONT_HEIGHT;
> +	font->charcount = 512;

Why not to have a macro for this constant?

> +
> +	return 0;
> +}
> +
>   static void sticon_init(struct vc_data *c, int init)
>   {
>       struct sti_struct *sti = sticon_sti;
> @@ -371,6 +387,7 @@ static const struct consw sti_con = {
>   	.con_scroll		= sticon_scroll,
>   	.con_switch		= sticon_switch,
>   	.con_blank		= sticon_blank,
> +	.con_font_info		= sticon_font_info,
>   	.con_font_set		= sticon_font_set,
>   	.con_font_default	= sticon_font_default,
>   	.con_build_attr		= sticon_build_attr,

-- 
js
suse labs



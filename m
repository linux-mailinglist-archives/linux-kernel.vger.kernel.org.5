Return-Path: <linux-kernel+bounces-125047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E8B891F34
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D421F2EE99
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809CE13CF9B;
	Fri, 29 Mar 2024 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSKZFmf3"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EBA8564C;
	Fri, 29 Mar 2024 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716979; cv=none; b=i8F1IsfBWq+B7xjFCJq3mIapxFXnGLhuFitnHiJlUjDpoCwrAOiLOV1l49YXyQmesx5tTni8d/w5oPv3hBOaanKWxavoAs9Pbds6qGP8OihIeVPYjEvGLMCo/l+CagtMBKzfmfd1Vr3hfDPvrbP4hy8msKc10bh78TK4P5xpbbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716979; c=relaxed/simple;
	bh=giiR5PK117e80LYqQREc6Pn73ncvElpx/Bps6tfm1ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuyiPfEl2lqcqFcWKTieczZg5wTISqqS+FoT3PWGid1KJ9xuG5kYQCwhYwJL+IcfvQhWmBGfQu3v15IWcqpoKau7AjLoPbuAX9rHdFLqdGCKmuoARGM+3U44NQPAnOBbJ7QNoRQQ6Jq856e8HT5VOsgdF5jusqAAEHNi8GMJBxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSKZFmf3; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56c441e66a5so2579533a12.0;
        Fri, 29 Mar 2024 05:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711716976; x=1712321776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jhb/ZNVtFOVdFjvoqvyjgcThge4E4KdOyihLh4rO7KA=;
        b=jSKZFmf31y/X6uPdyGVth2KstcFd+zd92rkDJxWjOvucWf5RVlZv/WJGRIjic90V/z
         LPR1sVI8et9iBwaHxv+2LbInAi3MtjutUehiUJMCbG4hBiwmnnvcelYUqSlbPs5EvAIA
         Acs0ZnTt5GP+85fLYJ5hC4izNKkesxlPkx3LMNHmBJg7DKnwLwcWEPjqbYlKQxZ9YZ2F
         6uww1C1ko93mQz81gJC9Uo52icbDqtKlB2u0J43P+SjCZJvdaZpAxtW1aGTNXEAx8ruP
         Pn1ekzC7zN2mt9bNZCckGJZWK0jNMXIU4askJfIKuaT/Nsmd7aieTIX6fRrMeYMletWK
         2R4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711716976; x=1712321776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhb/ZNVtFOVdFjvoqvyjgcThge4E4KdOyihLh4rO7KA=;
        b=vtSqTkJgmYn/N3cG32kNXUfWoOD7hPDhkUPjx6GLpW+DNYDETtpY0rP8tu2zxQPtSU
         W7GUM9E9jsYOVv5sh9sYEf6C2+mqZQMuCCkwq/hDpPxAey5asOi9ikObJarT+p2TtwyV
         jV+wi11HSso+pbsSyM5vIa+mEnaNXIy1fdMzvvZLhk9iWHEqmJyVmOHFr/V0uI2Tp8E7
         Rh5xqDb0xGjByNJwMt9mlMqtPFYUhHDgeXYcH6AY2TaM1z14DAFEfv96k/EKFxz8Dhdf
         iYqf4wijkiwWPg1kplZWd5+DYowi/osVYvMePkCLmZJAyJ8fqrYtWLF+2+WHUUMhX4En
         9+XA==
X-Forwarded-Encrypted: i=1; AJvYcCV3FlUTz6d3TCtcTJUUUxb58WGpblIMLt5ktnMzyAlOb9fpGvKXe+9NKw69QsqVN/o5A2BOeEnsFVC7RU5tbGb3+6jeXvK1FDMHzmLWMv6GbRsHIE0G7hWLLNBWQfZ/B4n6GZ6u/LvYyL4xgK0=
X-Gm-Message-State: AOJu0YwuRO2Y923+s9H47itvK1PMt0zQLKp1ALqYe7gtDGMnhslGPp0d
	gx3QacBZ/fh2/tfRkuD9BTkEsaB8lYuUxKa19BjIDIsoG175HiqV
X-Google-Smtp-Source: AGHT+IHGPWvOGzQDAj+fZIR/IrGdh825/Sa8pgKD31+sRZhZp4d9wY2dHrBfikuf39Ic1r/fig0JGw==
X-Received: by 2002:a17:906:a3d6:b0:a4e:360:c979 with SMTP id ca22-20020a170906a3d600b00a4e0360c979mr1425731ejb.48.1711716976038;
        Fri, 29 Mar 2024 05:56:16 -0700 (PDT)
Received: from shift.daheim (p200300d5ff0d9a0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff0d:9a00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id wr1-20020a170907700100b00a473a0f3384sm1916914ejb.16.2024.03.29.05.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 05:56:15 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.97)
	(envelope-from <chunkeey@gmail.com>)
	id 1rqBgA-0000000023J-2lZ6;
	Fri, 29 Mar 2024 13:56:15 +0100
Message-ID: <74f9afdc-6227-4daa-b501-640b701e2c8b@gmail.com>
Date: Fri, 29 Mar 2024 13:56:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] [RESEND] wifi: carl9170: re-fix fortified-memset
 warning
To: Arnd Bergmann <arnd@kernel.org>, Kees Cook <keescook@chromium.org>,
 Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>
Cc: linux-hardening@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vu?=
 =?UTF-8?Q?sen?= <toke@toke.dk>, linux-wireless@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Colin Ian King <colin.i.king@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20240328135509.3755090-1-arnd@kernel.org>
 <20240328135509.3755090-2-arnd@kernel.org>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20240328135509.3755090-2-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/24 2:55 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The carl9170_tx_release() function sometimes triggers a fortified-memset
> warning in my randconfig builds:
> 
> In file included from include/linux/string.h:254,
>                   from drivers/net/wireless/ath/carl9170/tx.c:40:
> In function 'fortify_memset_chk',
>      inlined from 'carl9170_tx_release' at drivers/net/wireless/ath/carl9170/tx.c:283:2,
>      inlined from 'kref_put' at include/linux/kref.h:65:3,
>      inlined from 'carl9170_tx_put_skb' at drivers/net/wireless/ath/carl9170/tx.c:342:9:
> include/linux/fortify-string.h:493:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>    493 |                         __write_overflow_field(p_size_field, size);
> 
> Kees previously tried to avoid this by using memset_after(), but it seems
> this does not fully address the problem. I noticed that the memset_after()
> here is done on a different part of the union (status) than the original
> cast was from (rate_driver_data), which may confuse the compiler.
> 
> Unfortunately, the memset_after() trick does not work on driver_rates[]
> because that is part of an anonymous struct, and I could not get
> struct_group() to do this either. Using two separate memset() calls
> on the two members does address the warning though.
> 
> Fixes: fb5f6a0e8063b ("mac80211: Use memset_after() to clear tx status")
> Link: https://lore.kernel.org/lkml/20230623152443.2296825-1-arnd@kernel.org/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sure... though I think AI-supported compilers will in the future nag about
this again. Oh well!

Acked-by: Christian Lamparter <chunkeey@gmail.com>


> ---
> I found this while testing randconfig builds, a .config that shows this
> for me is at https://pastebin.com/yWFKvZYu
> 
> Sorry I failed to follow up to Kees' request for a reproducer when
> I posted this last year.
> ---
>   drivers/net/wireless/ath/carl9170/tx.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/tx.c b/drivers/net/wireless/ath/carl9170/tx.c
> index e902ca80eba7..0226c31a6cae 100644
> --- a/drivers/net/wireless/ath/carl9170/tx.c
> +++ b/drivers/net/wireless/ath/carl9170/tx.c
> @@ -280,7 +280,8 @@ static void carl9170_tx_release(struct kref *ref)
>   	 * carl9170_tx_fill_rateinfo() has filled the rate information
>   	 * before we get to this point.
>   	 */
> -	memset_after(&txinfo->status, 0, rates);
> +	memset(&txinfo->pad, 0, sizeof(txinfo->pad));
> +	memset(&txinfo->rate_driver_data, 0, sizeof(txinfo->rate_driver_data));




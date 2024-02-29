Return-Path: <linux-kernel+bounces-87170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F4A86D09A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF1328A25E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57846CC02;
	Thu, 29 Feb 2024 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWxC3fds"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C8B47F51;
	Thu, 29 Feb 2024 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227651; cv=none; b=VgOYxHzYPOlDKpoFAk3+P/Xtr94V42n7250zufr1TGm+v3tfKHo1ua7GZwKzrWyd9rrUdBKeh+c9TXqsyizuKkgLMP9DGh+Xog/6fn67E5HYEskfPzsXmjhSTyQ4oDrXzHGJMa8A8uZ6VSmFeDWbiA206JONSQS9UOt4XI1mJCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227651; c=relaxed/simple;
	bh=KOw7VuSs/NEkKAq0MGdCET1a+tsfpO+KAcOfXqlBUm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZI2YgjPb0k0JVxgYvjkaaYfJmqrPZTyVP/lFfo51gA1vlMpAPYnaYpljFd6+wO4dG2bdu3Nsfzvo8EaaUeE4jaVKrbBSDFNZRGWECwtZXjve/K8BN+SnQBY6bavi9lYoLa1l5W+ptTZuYx2xDUZJMNuH5t9GYix5Ca+Y6iVBVxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWxC3fds; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a36126ee41eso202881366b.2;
        Thu, 29 Feb 2024 09:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709227648; x=1709832448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MnvmanzXumITbMK4lYOMR8IFam6xD+r+5kaEkRNgED0=;
        b=JWxC3fds7nDsFLvarjhnl8SHA6WaM1H6VWXnI16K7W5deomvZhW68FI8XfuLYYCNeb
         xQtUVtY1+eVGTBNDFNamwH3iEpjfHFXJiQwBYuo7yOarCpqJf4M/0nkgfKA/RcX/nUmn
         vuqAxCeIcHWPRyUl/aEfwzEs0YROln0cG5g/j2BO3zdZY+qiWB5XCZwwW9y1J9l4NF7G
         JYSxqFeNBOvvdBPPgd1i7EtzFWhwMiE+PDIJyM40KP08joLSu83eJ1RHUlVrMVY8uWXS
         UngRduTvionBGZFMabkN3gtaKa5+QfeRz9cNDan/WjziHOMrOTSgniytuDqLVp70nqgr
         5vSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709227648; x=1709832448;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnvmanzXumITbMK4lYOMR8IFam6xD+r+5kaEkRNgED0=;
        b=uU5MF8RmZiybB0iIUnCslTW+qZd5s0lmcmxXAnSxkMFUI6e5RqR8hU+SHTiylEBs+X
         euZzYuF8LjtUGkEkpriGl9/9daTJJl+DlXlTXJeyKJouCcreGen9XPzIMtwlsGXQVC9n
         g49Rj4Jt4eAZrU6vC48eOnIj3eeCIREci19Supmd0UO+yE+McN2URnC7w2GjuQHEaAbY
         PESD4mQyaCXrH2hc6PaZn1sj4rg6rKzi8s2z3RYraJnaZC9hJnDFD6fussmYYWTUAcc/
         EBveEwwoYenwxWQ3z/qQiF0ZYrdzbSl9BPeNM1Paqg2w/SURmKkYyRRo00hqXsbHRuTh
         Ag6Q==
X-Forwarded-Encrypted: i=1; AJvYcCViiK/WcmIGzP38XPVajNIn3o4EEwVS+M+AYffkV62bxlWrMbj13GVyYkFN1H8lxXyaKeECeweEbq/j0W1fqyMrfIbwVP/htiOgp6xKyx/GcFRssrNoGzdI28zjWK4sjWexCSzfH/YNho51kUee
X-Gm-Message-State: AOJu0Yw6nAwHVO2KLBd9If3gyvDRsG0lD6y/MzRr5qJzkooZe+22zMaO
	V9gzVjnUJ8TSi6KnGLxJC6cjJAI/s8gm9OdrY3+hzHm2xnXtpQuNmlp+2bbR93U=
X-Google-Smtp-Source: AGHT+IHq+G27ntUHuo4nv+4FAj8M/RA06TNZsxgypvoe2d4DJIQbwcHLvbAkGR8QqHmk+pzFMW9H7A==
X-Received: by 2002:a17:906:f8d5:b0:a43:dd85:e171 with SMTP id lh21-20020a170906f8d500b00a43dd85e171mr1991862ejb.69.1709227647504;
        Thu, 29 Feb 2024 09:27:27 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.188])
        by smtp.gmail.com with ESMTPSA id un8-20020a170907cb8800b00a445044287bsm624974ejc.123.2024.02.29.09.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 09:27:26 -0800 (PST)
Message-ID: <6c615b47-ed2a-4984-9bac-6763d18bdfe9@gmail.com>
Date: Thu, 29 Feb 2024 18:27:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btmtk: Add MODULE_FIRMWARE() for MT7922
Content-Language: en-US, ca-ES, es-ES
To: Takashi Iwai <tiwai@suse.de>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240227102914.8341-1-tiwai@suse.de>
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20240227102914.8341-1-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/02/2024 11:29, Takashi Iwai wrote:
> Since dracut refers to the module info for defining the required
> firmware files and btmtk driver doesn't provide the firmware info for
> MT7922, the generate initrd misses the firmware, resulting in the
> broken Bluetooth.
> 
> This patch simply adds the MODULE_FIRMWARE() for the missing entry
> for covering that.
> 
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1214133
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/bluetooth/btmtk.c | 1 +
>   drivers/bluetooth/btmtk.h | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index aaabb732082c..e5138a207f37 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -420,5 +420,6 @@ MODULE_LICENSE("GPL");
>   MODULE_FIRMWARE(FIRMWARE_MT7622);
>   MODULE_FIRMWARE(FIRMWARE_MT7663);
>   MODULE_FIRMWARE(FIRMWARE_MT7668);
> +MODULE_FIRMWARE(FIRMWARE_MT7922);
>   MODULE_FIRMWARE(FIRMWARE_MT7961);
>   MODULE_FIRMWARE(FIRMWARE_MT7925);
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index 56f5502baadf..cbcdb99a22e6 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -4,6 +4,7 @@
>   #define FIRMWARE_MT7622		"mediatek/mt7622pr2h.bin"
>   #define FIRMWARE_MT7663		"mediatek/mt7663pr2h.bin"
>   #define FIRMWARE_MT7668		"mediatek/mt7668pr2h.bin"
> +#define FIRMWARE_MT7922		"mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin"
>   #define FIRMWARE_MT7961		"mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin"
>   #define FIRMWARE_MT7925		"mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin"
>   


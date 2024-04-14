Return-Path: <linux-kernel+bounces-144170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9979F8A42B5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED57281861
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 13:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08ECC535B6;
	Sun, 14 Apr 2024 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHeCGdOZ"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B328B4F8BC;
	Sun, 14 Apr 2024 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713103106; cv=none; b=VxfE79ydBHEznK2aGlo92h32Chg72rpw1KUxKIjZfh/C6PiPaxY5JYkBzlhpMrxircYp5Twskbz9hZQnQGQNxLN1lV7FALS2QbM9P2Xoqdl2AXwHYhZBKQlWtMNEcxfyNIFqTXxdx1+FtFxOcdFbc7Rp1Q9Daq7rFrffY0BfWAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713103106; c=relaxed/simple;
	bh=1aGZSPF1lKX8ZOF8H/ywJSjaA45F9BB/spqROtVCNMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFJip+ytyN2vjTwun9CvsHlBEojgD/ET21MKLHdPf6Z64I53IzyMQVvZRG7xPerNKazLhV3g68NNu2e1G50MaHYOzL/mOtQxeIW03sgKpcegcg8Rd4Ez4fIPwjhRivyAO0f7FVmlg1xYrowz2IMunGr4me8i6tr+Mac3UF02wKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHeCGdOZ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a52643e4351so37651966b.0;
        Sun, 14 Apr 2024 06:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713103103; x=1713707903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mc9DRYYmsJAu6WGdf2YSxzqE6LHyYkw9/WLj/6x7E4U=;
        b=jHeCGdOZQr2DWFzzpq02MITez/ik9M9U4LPX4gBeVLcvJmWqiiashw7ZMFZP/VU3Js
         PNpCW9+ZNGaCGWyfwV+ki/b7VnavuNMGkLTbSs7KjhxDx2/zVjjJ++FPguoph//0v1FZ
         U3f5sMsDvvTPSjPn9wWOHHASzLWj7AQVSP5plJIbP1lo5QO1OphRCDENH4LJ+kBA7NSh
         LXDZwxVw8Heg+Dd554qYYYJSormTJunJ+ll4REridS0Tq86eZhxUkKHpzetxt6qlAz8+
         bHFKm52nxGhb8cSPfqbJjy9dp8kHsmwwLmA/JghSTsbMrtmzDgbJVy53G5D4En/eS1YH
         fMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713103103; x=1713707903;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mc9DRYYmsJAu6WGdf2YSxzqE6LHyYkw9/WLj/6x7E4U=;
        b=evQZ6JV9XFSoa5RDwZCfnNvX9b+62GJJelck2ekSHYuNFVUeefH/RJpGYhHI+z/AI3
         q/NAZsMcKHmPVK43qjayb2+VbxbYPKYjkpipZja1oTMvz7qzG1Vr3NT8yTAPjU4t9lq6
         LZcUqHiQfWKqqLlbS1H/3XOba6GvjC6OEi+QDh2DSf0SPvdZeNAGTrWnQbvNzmZD2Y0I
         FjBoL77TWvYk9iB08k1i34ejUUTJnlsGxY+oCduleVtnPETjMCv6MNkIa/ht9jyl4NuK
         Phx+jekDzDsXmDKKN65YKhGLYy0w0OflCnxf8cjGiMwFRcxlEp30EKTWF/CwyXoRO0v6
         qCOA==
X-Forwarded-Encrypted: i=1; AJvYcCUKTpR75KlLtJ/2I0vyaOadK2seEKb3DVxgtMFXIZiQLuOX8cBRpxCg5OWUNXTehiNLUwDk2Z6YHAnuAAmV9oD8n8N5K9+CYOMHrWkWNXQGj1LeGtuM1nfWgQXMhS5L1W+w3kA3bjVjYrWRt1aS1L4TWXyMPL1gMbXFZJtUDzxW6SFugA==
X-Gm-Message-State: AOJu0Yyb3YNdCBJerVtfWyBir/IFOmCCaDJy1PzcPPYkTu868lADMAEW
	hrtf7IPEqm6D/mAa1fA2b+kG7sV5lGs9GCUnVXNnaToyHf4mE/s7
X-Google-Smtp-Source: AGHT+IEShVYDR4pF/3pNQ8fw2DzFnb3BC74+1eGAhPlvhL9BMcEmTdM3QVBzqWDyD9VOa5WDdqCozA==
X-Received: by 2002:a17:907:7208:b0:a51:bddf:eaf2 with SMTP id dr8-20020a170907720800b00a51bddfeaf2mr7225509ejc.18.1713103102810;
        Sun, 14 Apr 2024 06:58:22 -0700 (PDT)
Received: from [172.27.138.193] (c7.campus.utcluj.ro. [193.226.6.226])
        by smtp.gmail.com with ESMTPSA id k21-20020a17090666d500b00a518bcb41c1sm4228240ejp.126.2024.04.14.06.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 06:58:22 -0700 (PDT)
Message-ID: <34b08785-86f9-4c28-8d03-928866dbdc10@gmail.com>
Date: Sun, 14 Apr 2024 16:58:20 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] iio: adc: ad7192: Add aincom supply
Content-Language: en-US
To: David Lechner <dlechner@baylibre.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 alexandru.tachici@analog.com, lars@metafoo.de, jic23@kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt@analog.com, bigunclemax@gmail.com,
 okan.sahin@analog.com, fr0st61te@gmail.com, alisa.roman@analog.com,
 marcus.folkesson@gmail.com, schnelle@linux.ibm.com, liambeguin@gmail.com
References: <20240413151152.165682-1-alisa.roman@analog.com>
 <20240413151152.165682-4-alisa.roman@analog.com>
 <CAMknhBFk9e=VDYFVUhKmabHKwhJKbVVA4tRz758QszjHLGUEpg@mail.gmail.com>
From: Alisa-Dariana Roman <alisadariana@gmail.com>
In-Reply-To: <CAMknhBFk9e=VDYFVUhKmabHKwhJKbVVA4tRz758QszjHLGUEpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.04.2024 22:10, David Lechner wrote:
> On Sat, Apr 13, 2024 at 10:12 AM Alisa-Dariana Roman
> <alisadariana@gmail.com> wrote:
>>
>> AINCOM should actually be a supply. If present and it has a non-zero
>> voltage, the pseudo-differential channels are configured as single-ended
>> with an offset. Otherwise, they are configured as differential channels
>> between AINx and AINCOM pins.
>>
>> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
>> ---
>>   drivers/iio/adc/ad7192.c | 53 +++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 49 insertions(+), 4 deletions(-)

..

>> @@ -745,6 +746,9 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
>>                  /* Kelvin to Celsius */
> 
> Not related to this patch, but I'm not a fan of the way the
> temperature case writes over *val (maybe clean that up using a switch
> statement instead in another patch while we are working on this?).
> Adding the else if to this makes it even harder to follow.
> 
>>                  if (chan->type == IIO_TEMP)
>>                          *val -= 273 * ad7192_get_temp_scale(unipolar);
>> +               else if (st->aincom_mv && chan->channel2 == -1)
> 
> I think the logic should be !chan->differential instead of
> chan->channel2 = -1 (more explanation on this below).
> 
>> +                       *val += DIV_ROUND_CLOSEST_ULL((u64)st->aincom_mv * 1000000000,
>> +                                                     st->scale_avail[gain][1]);
>>                  return IIO_VAL_INT;

Hi David,

I am very grateful for your suggestions!

	case IIO_CHAN_INFO_OFFSET:
		if (!unipolar)
			*val = -(1 << (chan->scan_type.realbits - 1));
		else
			*val = 0;
		switch(chan->type) {
		case IIO_VOLTAGE:
			if (st->aincom_mv && !chan->differential)
				*val += DIV_ROUND_CLOSEST_ULL((u64)st->aincom_mv * 1000000000,
							      st->scale_avail[gain][1]);
			return IIO_VAL_INT;
		/* Kelvin to Celsius */
		case IIO_TEMP:
			*val -= 273 * ad7192_get_temp_scale(unipolar);
			return IIO_VAL_INT;
		default:
			return -EINVAL;
		}

I added a switch because it looks neater indeed. But I would keep the if 
else for the unipolar in order not to have duplicate code. Is this alright?



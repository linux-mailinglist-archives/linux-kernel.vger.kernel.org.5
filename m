Return-Path: <linux-kernel+bounces-144361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D8E8A4501
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 22:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4411C20C0F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E3513698F;
	Sun, 14 Apr 2024 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwelWVQ6"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171A813698D;
	Sun, 14 Apr 2024 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713125676; cv=none; b=SXWD1H3gUmMzx63CyvfPtYMEN9LP6v1LZhUtEidHuZckLOUDhYW+6CkQvEZIv9oUOputnhNrlKOgDC9s2BiIUrtKst+8vAlqxRPsLpCdqo/pCP/L5m5Fh6Nn6jfDoNLalVF0kihoLucSEyCGH2DcSlek30mudCoIyZibICJNuiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713125676; c=relaxed/simple;
	bh=PccxBh7zo/tvz64Ww80Rk/YO/brWUZ3Re7wd2ekGWQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RmJZEfwDT4B7kfmZWoWjzhj8ogrxaCo06xFrVgCbDZRYA0HEU1HcQUVt95Nliu1jJgGeon11KygBvzSMh/v+Dl/k0rJPEXS9MBgaS90ElteOKRmk2kkCMURzsikn7FkhknbxmurnleyUIsaMex+cqn12CgORHam5pB4RUM7CZIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwelWVQ6; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-518bad5f598so941716e87.2;
        Sun, 14 Apr 2024 13:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713125671; x=1713730471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CQqN6YrToit4xX74oO1hdA+XGzZL0o4Rxaz/inovTzQ=;
        b=IwelWVQ6/YrNfPIGWgBrCRf04eQ7Zgs8/y4A3HyhX798J6LzQhxU61iFC277qkiNp2
         Oq5087Yy1BwloLykwtwVZ8bGDanip0LtzzBdklVjXVYcZ8X3dxTb6qva2kGttP/uqUau
         kbKsoHYrnEpZX6VcEnWmjjPOGEw83lQ65g+WY/Tf5aUP5eU7VGE1tqFx9uv4tsOuStSG
         XYBwy6LKidyWqVqaowxrBTCfBaIpQBmoypXWNkxjG3X/YKULf8mp4YAJRZB0ngYxePH1
         mdDsApR0akDx+B5yBkbd21bgcpC9FDO3ILsbsQhIsAF3a9mgRfEWKpDaYn9PkZv2Y+hW
         UYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713125671; x=1713730471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQqN6YrToit4xX74oO1hdA+XGzZL0o4Rxaz/inovTzQ=;
        b=areH0/gN2LC0/NA4USfXb0ues4HDanXaIQkR3nN1aVSiJhFh6EBs34QWKbpa+7xXvA
         hMZXtGXWizv+dCEmZpgzCo259IM6CTyHUmDLup6NObDB93TCyN+9/C5h1l2m0fHXIWf8
         Aj4vbK1Qn7CzBO+oUIlvvXP6xU1O1crQchaEGO6qMIwlBl+3l3P/oydmEFpGBZa/iRCz
         h6v99qohQYOlO4M24I3EuOHVCqlFtJSeZLjfBsA1BKt2C2IsoIEC5xXUs0qoOOx1etBK
         IDARv15dSicGGarLdSl2MrRa0M04DYHWder9gxt0cF1W0mgg+j6/2eDFyf+joZS5QzGc
         4ttw==
X-Forwarded-Encrypted: i=1; AJvYcCVGmLLPpWoNjE7wtE9InAIVvL1ftrbSR4zNfITkV4TgVO6e1mtzChEwrE6ea1NeAY92EEtO98vgeD6cJz/uh+YYgH58PHEMj/jSApZQyC2pG37vI3y5dFDFcA/NBN86/OSBYq+yBFui7UVMUOzOwtaxFGiN8Zv7qkfsIiQ4adQPrpf/9Q==
X-Gm-Message-State: AOJu0Yz1XmxOhkBRgi8aiKoorQ2SR36SlfeKsdJBv3ulH7IZB+fCjwc/
	DHmwcdIaheLzMefPeabsF0GHFvGCuXNFF5OY/9kkpqvXUiKUeHek
X-Google-Smtp-Source: AGHT+IEd27NZXiLTF0O+mBYFf7M2dCfew/0+9Hq+7Czir7Cp2Phg+ZLekld8YXy1PrP2QyKSSrCizg==
X-Received: by 2002:a19:ca55:0:b0:513:cae8:4406 with SMTP id h21-20020a19ca55000000b00513cae84406mr4555882lfj.48.1713125670723;
        Sun, 14 Apr 2024 13:14:30 -0700 (PDT)
Received: from [172.27.138.193] (c7.campus.utcluj.ro. [193.226.6.226])
        by smtp.gmail.com with ESMTPSA id n22-20020aa7c796000000b0056feeb85ed0sm3451030eds.19.2024.04.14.13.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 13:14:30 -0700 (PDT)
Message-ID: <dfa86da4-7d2d-4d7e-ac50-86d3713f44d9@gmail.com>
Date: Sun, 14 Apr 2024 23:14:28 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] iio: adc: ad7192: Add AD7194 support
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
 <20240413151152.165682-6-alisa.roman@analog.com>
 <CAMknhBFzUeW5+rs_GgCZCiit=eW04VHyCnt-__jXLnO3Z29ksA@mail.gmail.com>
Content-Language: en-US
From: Alisa-Dariana Roman <alisadariana@gmail.com>
In-Reply-To: <CAMknhBFzUeW5+rs_GgCZCiit=eW04VHyCnt-__jXLnO3Z29ksA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.04.2024 23:05, David Lechner wrote:
> On Sat, Apr 13, 2024 at 10:13 AM Alisa-Dariana Roman
> <alisadariana@gmail.com> wrote:
>>
>> Unlike the other AD719Xs, AD7194 has configurable differential
>> channels. The user can dynamically configure them in the devicetree.
>>
>> Also modify config AD7192 description for better scaling.
>>
>> Moved ad7192_chip_info struct definition to allow use of callback
>> function parse_channels().
> 
> It looks like this no longer needs to be moved in this revision.
> 
>>
>> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
>> ---
>>   drivers/iio/adc/Kconfig  |  11 ++-
>>   drivers/iio/adc/ad7192.c | 140 ++++++++++++++++++++++++++++++++++++---
>>   2 files changed, 138 insertions(+), 13 deletions(-)

..

> 
>> +       if (!ad7194_channels)
>> +               return -ENOMEM;
>> +
>> +       indio_dev->channels = ad7194_channels;
>> +       indio_dev->num_channels = num_channels;
>> +
>> +       device_for_each_child_node(dev, child) {
>> +               *ad7194_channels = ad7194_chan_diff;
>> +               ad7194_channels->scan_index = index++;
>> +               ret = ad7192_parse_channel(child, ad7194_channels);
>> +               if (ret) {
>> +                       fwnode_handle_put(child);
>> +                       return ret;
>> +               }
>> +               ad7194_channels++;
>> +       }
>> +
>> +       *ad7194_channels = ad7194_chan_temp;
>> +       ad7194_channels->scan_index = index++;
>> +       ad7194_channels->address = AD7194_CH_TEMP;
>> +       ad7194_channels++;
> 
> nit: It would seem more natural to have all voltage channels
> altogether rather than having the temperature channel in between.

I wrote the channels like this to match the other chips:

static const struct iio_chan_spec ad7193_channels[] = {
	AD7193_DIFF_CHANNEL(0, 1, 2, AD7193_CH_AIN1P_AIN2M),
	AD7193_DIFF_CHANNEL(1, 3, 4, AD7193_CH_AIN3P_AIN4M),
	AD7193_DIFF_CHANNEL(2, 5, 6, AD7193_CH_AIN5P_AIN6M),
	AD7193_DIFF_CHANNEL(3, 7, 8, AD7193_CH_AIN7P_AIN8M),
	AD719x_TEMP_CHANNEL(4, AD7193_CH_TEMP),
	AD7193_DIFF_CHANNEL(5, 2, 2, AD7193_CH_AIN2P_AIN2M),
	AD7193_CHANNEL(6, 1, AD7193_CH_AIN1),
	AD7193_CHANNEL(7, 2, AD7193_CH_AIN2),
	AD7193_CHANNEL(8, 3, AD7193_CH_AIN3),
	AD7193_CHANNEL(9, 4, AD7193_CH_AIN4),
	AD7193_CHANNEL(10, 5, AD7193_CH_AIN5),
	AD7193_CHANNEL(11, 6, AD7193_CH_AIN6),
	AD7193_CHANNEL(12, 7, AD7193_CH_AIN7),
	AD7193_CHANNEL(13, 8, AD7193_CH_AIN8),
	IIO_CHAN_SOFT_TIMESTAMP(14),
};

Kind regards,
Alisa-Dariana Roman



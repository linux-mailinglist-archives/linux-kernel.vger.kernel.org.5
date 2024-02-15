Return-Path: <linux-kernel+bounces-66970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251CB856435
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0056283F4D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5A6130AC3;
	Thu, 15 Feb 2024 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0T5RdwY"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DFC12E1C7;
	Thu, 15 Feb 2024 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003340; cv=none; b=ddiaCZsqmo6XBLXjUgBwUbZmUD1Mc50TGt1BbPxPZtcK42OU7cGBbYR3Xw9XKXOiU9vbde7znjer9Q8lnYWUqaPSCv2/SQXPJJEWFkuXYbCqiIu6f/BDB/MQDtjcg0btP5cWxTiP2prDdN8sMoT+iMl9Wh2cx/Jvrv9QLsEj6ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003340; c=relaxed/simple;
	bh=bnjUnGWY5tuJqudE0O1MmY98iLuXPIdsyEbTw9zIQdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cxsSWAsnz0jufTvRxmpFzXgkBXo2wnFV4eH/aPRvXmE58oqn3POcfsIzs5A/8YtZ67ZIFPP0/ABuxFZ5euH0paFrp8YhlII6F2Zwh6yltJCVKMwtHQMcoiLhJE0GX5PIxhfSwb6jevpflHG7Iufv9C4g7FGtpbxjcX0LOBkiTEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0T5RdwY; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d0d7985dfdso11978731fa.2;
        Thu, 15 Feb 2024 05:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708003337; x=1708608137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EF0nScnhCC2yAbtMSsLI0QixWOPqumzxsZSInzkhycs=;
        b=j0T5RdwYF9/sQb7hmbDgQ5cV1k6QbN+G6lFg5uI7NT9JdRFSurcbhj3YsZ126vTcOx
         bpI/tiATUtnsvONOVlGLhPGnGwpW40ij9A6zd7rDbNscFLnEPqKLbqLD84RfsXk5Qszd
         2I1w/lbUHy5WTEft20Mq9OzPSmg3hgQo8ZFrhVVRRMlF9M5gDeIEZev58Bja5f2xWLYK
         cqNeKILepHztikzZYpOOy1ASk4J3u/QBxLB/osi2GhgF26GsVGMw0qO7bO3jIRsNLwJ/
         pf2+57LPhYJU+LFheAYCMDnAEcSVYCMjAp/Ij5hmFUb92w+kp0WjEzUZHl/cOPVWZEMY
         wjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708003337; x=1708608137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EF0nScnhCC2yAbtMSsLI0QixWOPqumzxsZSInzkhycs=;
        b=sE1K52LgsvoglasrKd8CL4XblbVKnCHcXFfI5PI13+y3BFHi/NdYJxo3niAJDNeGRz
         zivDHOLJo7H7S10DLGzh/iduvTa2UWEZ1Ox2x+lLTNhD/1b6wrsXIRpotvOOrnYS2ZZ9
         odnQpxnO6EgqkBD90GLPpLjc6vj67MnkwMGdBaLS1+4MS6ojOyB626UPMzCy4xpnZn8B
         Rxspr3AbgH4/5kikwZBqGQmP8uu3JDA1T8SNyVHuDLJxa4ocMOCBObzfy8RU4FJjuNTc
         aBVk87Xrp7Y+D3/47G0K0UtRthScA2QVEqs05/0fzBjkjhsHY3XDPNcM/GW5mzCqyfrY
         9J7g==
X-Forwarded-Encrypted: i=1; AJvYcCW73cNO8QYaFyKak/8Eylm1oBsvLWBguXAu1IO+G9bSxHSXyXphfzMw9W3AmS2MjzYcxB42+NJOHFv0S2AvvMGSAZIP20SZMXvB2aww9bHEnHsl43h8FugIKv8arIeTtNmNmCQO2/Q0/i3ceUkZUQQv3L93FSmY6zP1PXG6+fFLEnT3sw==
X-Gm-Message-State: AOJu0Yzsv46b83onia0rySzi/QrDhkGOhIjkWgQf1l3Y2qLfSl0S9+0Z
	PYVy51Kh0KU616d11NThTXPFyMBRiNzc1NsWjA9OcLKLBCbVff75
X-Google-Smtp-Source: AGHT+IFdSeee2h6yPbN253Q+N6eCnxg7HRV8sLAauAyt9G6++zpa57D4VNNEWvu9CKVdqwilcjiqFA==
X-Received: by 2002:a19:550c:0:b0:511:7c0c:f94a with SMTP id n12-20020a19550c000000b005117c0cf94amr1550261lfe.16.1708003336569;
        Thu, 15 Feb 2024 05:22:16 -0800 (PST)
Received: from [192.168.176.154] ([5.14.144.108])
        by smtp.gmail.com with ESMTPSA id un8-20020a170907cb8800b00a3d1c0a3d5dsm543452ejc.63.2024.02.15.05.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 05:22:16 -0800 (PST)
Message-ID: <84546728-f0cb-4b38-a71c-e053b9b9278e@gmail.com>
Date: Thu, 15 Feb 2024 15:22:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] iio: adc: ad7192: Add AD7194 support
Content-Language: en-US
To: David Lechner <dlechner@baylibre.com>
Cc: alexandru.tachici@analog.com, alisa.roman@analog.com,
 conor+dt@kernel.org, devicetree@vger.kernel.org, jic23@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
 lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.hennerich@analog.com, robh+dt@kernel.org,
 Nuno Sa <nuno.sa@analog.com>
References: <20240208172459.280189-1-alisa.roman@analog.com>
 <20240208172459.280189-6-alisa.roman@analog.com>
 <CAMknhBHU6k8J_PLCmGYF48S1q3uXByiCwzcd+B3q3Cd-02CUow@mail.gmail.com>
From: Alisa-Dariana Roman <alisadariana@gmail.com>
In-Reply-To: <CAMknhBHU6k8J_PLCmGYF48S1q3uXByiCwzcd+B3q3Cd-02CUow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello and thank you for the feedback!

On 09.02.2024 00:27, David Lechner wrote:
> On Thu, Feb 8, 2024 at 11:25 AM Alisa-Dariana Roman
> <alisadariana@gmail.com> wrote:
>>
>> Unlike the other AD719Xs, AD7194 has configurable differential
>> channels. The default configuration for these channels can be changed
>> from the devicetree.

..

>>
>> +static const struct iio_info ad7194_info = {
>> +       .read_raw = ad7192_read_raw,
>> +       .write_raw = ad7192_write_raw,
>> +       .write_raw_get_fmt = ad7192_write_raw_get_fmt,
>> +       .read_avail = ad7192_read_avail,
>> +       .validate_trigger = ad_sd_validate_trigger,
>> +       .update_scan_mode = ad7192_update_scan_mode,
>> +};
> 
> Isn't this identical to ad7192_info and ad7195_info now that .attrs is
> removed? It seems like we could consolidate here.

Those are not exactly identical since: 92 has bridge switch attribute, 
95 has bridge switch and ac excitation attributes and 94 has no custom 
attributes. I used a different info structure for 94 in order to avoid 
showing extra attributes.

> 
>> +
>>   static const struct iio_info ad7195_info = {
>>          .read_raw = ad7192_read_raw,
>>          .write_raw = ad7192_write_raw,
>> @@ -1009,6 +1049,80 @@ static const struct iio_chan_spec ad7193_channels[] = {
>>          IIO_CHAN_SOFT_TIMESTAMP(14),
>>   };
>>
>> +static struct iio_chan_spec ad7194_channels[] = {
>> +       AD7193_DIFF_CHANNEL(0, 1, 2, 0x001),
>> +       AD7193_DIFF_CHANNEL(1, 3, 4, 0x023),
>> +       AD7193_DIFF_CHANNEL(2, 5, 6, 0x045),
>> +       AD7193_DIFF_CHANNEL(3, 7, 8, 0x067),
>> +       AD7193_DIFF_CHANNEL(4, 9, 10, 0x089),
>> +       AD7193_DIFF_CHANNEL(5, 11, 12, 0x0AB),
>> +       AD7193_DIFF_CHANNEL(6, 13, 14, 0x0CD),
>> +       AD7193_DIFF_CHANNEL(7, 15, 16, 0x0EF),
>> +       AD719x_TEMP_CHANNEL(8, AD7194_CH_TEMP),
>> +       AD7193_CHANNEL(9, 1, AD7194_CH_AIN1),
>> +       AD7193_CHANNEL(10, 2, AD7194_CH_AIN2),
>> +       AD7193_CHANNEL(11, 3, AD7194_CH_AIN3),
>> +       AD7193_CHANNEL(12, 4, AD7194_CH_AIN4),
>> +       AD7193_CHANNEL(13, 5, AD7194_CH_AIN5),
>> +       AD7193_CHANNEL(14, 6, AD7194_CH_AIN6),
>> +       AD7193_CHANNEL(15, 7, AD7194_CH_AIN7),
>> +       AD7193_CHANNEL(16, 8, AD7194_CH_AIN8),
>> +       AD7193_CHANNEL(17, 9, AD7194_CH_AIN9),
>> +       AD7193_CHANNEL(18, 10, AD7194_CH_AIN10),
>> +       AD7193_CHANNEL(19, 11, AD7194_CH_AIN11),
>> +       AD7193_CHANNEL(20, 12, AD7194_CH_AIN12),
>> +       AD7193_CHANNEL(21, 13, AD7194_CH_AIN13),
>> +       AD7193_CHANNEL(22, 14, AD7194_CH_AIN14),
>> +       AD7193_CHANNEL(23, 15, AD7194_CH_AIN15),
>> +       AD7193_CHANNEL(24, 16, AD7194_CH_AIN16),
> 
> Shouldn't these be differential channels since they are
> pseudo-differential inputs measuring the difference between AINx and
> AINCOM?
> 
>> +       IIO_CHAN_SOFT_TIMESTAMP(25),
>> +};
> 
> i.e. like this (where AINCOM is voltage0 AINx is voltagex)
> 
> static struct iio_chan_spec ad7194_channels[] = {
>         AD7193_DIFF_CHANNEL(0, 1, 0, AD7194_CH_AIN1),
>         AD7193_DIFF_CHANNEL(1, 2, 0, AD7194_CH_AIN2),
>         AD7193_DIFF_CHANNEL(2, 3, 0, AD7194_CH_AIN3),
>         AD7193_DIFF_CHANNEL(3, 4, 0, AD7194_CH_AIN4),
>         AD7193_DIFF_CHANNEL(4, 5, 0, AD7194_CH_AIN5),
>         AD7193_DIFF_CHANNEL(5, 6, 0, AD7194_CH_AIN6),
>         AD7193_DIFF_CHANNEL(6, 7, 0, AD7194_CH_AIN7),
>         AD7193_DIFF_CHANNEL(7, 8, 0, AD7194_CH_AIN8),
>         AD7193_DIFF_CHANNEL(8, 9, 0, AD7194_CH_AIN9),
>         AD7193_DIFF_CHANNEL(9, 10, 0, AD7194_CH_AIN10),
>         AD7193_DIFF_CHANNEL(10, 11, 0, AD7194_CH_AIN11),
>         AD7193_DIFF_CHANNEL(11, 12, 0, AD7194_CH_AIN12),
>         AD7193_DIFF_CHANNEL(12, 13, 0, AD7194_CH_AIN13),
>         AD7193_DIFF_CHANNEL(13, 14, 0, AD7194_CH_AIN14),
>         AD7193_DIFF_CHANNEL(14, 15, 0, AD7194_CH_AIN15),
>         AD7193_DIFF_CHANNEL(15, 16, 0, AD7194_CH_AIN16),
>         AD719x_TEMP_CHANNEL(16, AD7194_CH_TEMP),
>         IIO_CHAN_SOFT_TIMESTAMP(17),
> };
> 

I tried to follow the existing style of the driver: for each 
pseudo-differential channel(AINx - AINCOM) there is an iio channel like 
this in_voltagex_raw; and for each differential channel(AINx - AINy) 
there is an iio channel like this in_voltagex-in_voltagey_raw. AD7194 
has 16 pseudo-differential channels/8 fully differential channels so I 
thought the (AINx - AINCOM) channels should be static and only the 8 
differential ones could be configured by the user from the devicetree by 
choosing the input pins.

The existing style of the driver, AD7192 has 4 pseudo differential 
channels and 2 (non configurable) differential channels:
static const struct iio_chan_spec ad7192_channels[] = {
	AD719x_DIFF_CHANNEL(0, 1, 2, AD7192_CH_AIN1P_AIN2M),
	AD719x_DIFF_CHANNEL(1, 3, 4, AD7192_CH_AIN3P_AIN4M),
	AD719x_TEMP_CHANNEL(2, AD7192_CH_TEMP),
	AD719x_DIFF_CHANNEL(3, 2, 2, AD7192_CH_AIN2P_AIN2M),
	AD719x_CHANNEL(4, 1, AD7192_CH_AIN1),
	AD719x_CHANNEL(5, 2, AD7192_CH_AIN2),
	AD719x_CHANNEL(6, 3, AD7192_CH_AIN3),
	AD719x_CHANNEL(7, 4, AD7192_CH_AIN4),
	IIO_CHAN_SOFT_TIMESTAMP(8),
};

Would it be better to respect the existing style or to do like you 
suggested and have a total of 16 differential channels that are 
configurable from the device tree?

Kind regards,
Alisa-Dariana Roman


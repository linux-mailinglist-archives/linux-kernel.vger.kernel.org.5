Return-Path: <linux-kernel+bounces-129463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D40D4896B24
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFA228D2DC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2597135A46;
	Wed,  3 Apr 2024 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayUYoXrE"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAE4134CE8;
	Wed,  3 Apr 2024 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138123; cv=none; b=nXxDuRZWEr3WCwj5wot/GTI6BXq6hqQX1UgLLqjgiAleDX5hf0dd4KBHr81ym9xlVOkXL9a1b9GeTONSj/hopRbupcQbbNhMf5XcJHZ7FB2UAH3ysP3E43iHRvjmDNYXEoEdjKL+VvJc0zBrf1xfrT/EABANUd4iT1qPFVlCXE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138123; c=relaxed/simple;
	bh=YU/CeHp5UjL8NmS2ndGli5ANSlG4vJ1uOK5fYMDiHrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QM436lsPSLhr/74OuboqDIULogALI6VsbJuKNqanjoWBHkzAAHK+vaY1iRBrXP+tMuem5tlVNPXnfZxSnasWq/YIoJNSgOw6fcNf4MWIwnJcOOVduJZ76rIWNl1a0+9ElG3mDggyIMiXzsa8z/yPC2eAchfr1x+krfNDoN78KvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayUYoXrE; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-789db18e24eso431103785a.1;
        Wed, 03 Apr 2024 02:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712138120; x=1712742920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CKc40d6Asw6pSQJAyAFc8NNjkra9w0OeaNrald7prfk=;
        b=ayUYoXrEjVZBW9ucmlYex9s1WFxoQZ75BfpcZzPLvmZ/gx1aW+FtyF/ZHbGtiYcGUf
         iN2uodikqzR9iTDreIn9GxBlmklr28L9KPbgGCDVkodCk6NbV6mklrm8Km/8PAnHMD7E
         A4OUCAyblfvlbNddlHbFeK41QFS07O46Vjuc1VkxXjtnYjx9egjrvSP1+DtWxLyKJAYP
         t930DSuH03b9ZJl3aCpZK70tKB/yhgNNgqZ/cRajU49btNYrAc4dwylFkLCaSNQ7wgL4
         01vOAwGCs+fbh0APj46mZZhv9xkjVeMJxqqqq/aoDuUqNv4ha38pblUTD2WC4sOWKvLA
         qesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712138120; x=1712742920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CKc40d6Asw6pSQJAyAFc8NNjkra9w0OeaNrald7prfk=;
        b=VLSnHWSl60rHLvurAth7S05PFGWlQicxfM/bODV1/1u8/fx1si4ysoPfDfQwhKAWqy
         b3hAydDdoC2CypfcpHbaED7IgIe7bhfo2kA6uaPRhzsaq/zVxZGn/bt9bgr9MhYELjiN
         0u+u1O2UMr6HPEoKhw/i9dvJFWRY2hlAoBEN96f2G9mxzlYTCLRpP7uU/boX55s01ynQ
         fKRpR7ACSdHgkiWc6SELQRH7xX2/uLibp1b2vnOAEtKGmfGjQjm1Ozp2LDv1x8rPPXb0
         d6fa+qFdP6sq83spsxBjXcta62srjAyT5VLN6EWA8fKC2kFBDstECh6Z4ORcbAkH+i2u
         pyQA==
X-Forwarded-Encrypted: i=1; AJvYcCVBfwxsaHfe94T5BqGj2PQLKHU6f6fgYGf4e5kHVInw74vDHfb5g/XAD68cVTVkuq5HickrWitqSNHocu7239B82KSHDjB+YAHB0Cqvg/+kt1UraDC6zwzCajamixd1h4yZcteAiE08Ao3rHxLOKRwjOKhwATqYqNzKCEaFjkdKrUEW1A==
X-Gm-Message-State: AOJu0YyrMix9xvivSAF0KeOtFK/Rm/sw+NlB3dKKUxl7aelMCtWUrdZN
	pDLyuuIkmoedUEHKfdUjya2xU24q9jPJ9gmoLtPK9BmYxFE5p+iW
X-Google-Smtp-Source: AGHT+IE0Xsxgk/+2l7vSmJfThk9WB0+LdrirAKzL6+1ZVVNasrfCE4ZcyDXWlXDB9TZ89qi9jSUsMg==
X-Received: by 2002:ad4:40d0:0:b0:699:2523:65a9 with SMTP id x16-20020ad440d0000000b00699252365a9mr2168628qvp.3.1712138120330;
        Wed, 03 Apr 2024 02:55:20 -0700 (PDT)
Received: from [10.76.84.174] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id ke11-20020a056214300b00b006915ae114efsm6327187qvb.52.2024.04.03.02.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 02:55:20 -0700 (PDT)
Message-ID: <b3088d35-fb66-4736-8c6c-f80b05a380c6@gmail.com>
Date: Wed, 3 Apr 2024 12:55:17 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] iio: adc: ad7173: Add support for AD411x devices
To: David Lechner <dlechner@baylibre.com>, dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
 <20240401-ad4111-v1-6-34618a9cc502@analog.com>
 <CAMknhBFdtv84E_S4wa4UW0pO2yiUEk9=jn=_i4F=b8VHdR6v+w@mail.gmail.com>
 <CAMknhBHf_9kFfLySJmRyoUS6UFfTeLW3bfEi1-3ApEDHyyVhCw@mail.gmail.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <CAMknhBHf_9kFfLySJmRyoUS6UFfTeLW3bfEi1-3ApEDHyyVhCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/04/2024 17:00, David Lechner wrote:
> On Mon, Apr 1, 2024 at 2:45 PM David Lechner <dlechner@baylibre.com> wrote:
>>
>> On Mon, Apr 1, 2024 at 10:10 AM Dumitru Ceclan via B4 Relay
>> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:

..

>>>                 *chan = ad7173_channel_template;
>>>                 chan->address = chan_index;
>>>                 chan->scan_index = chan_index;
>>> -               chan->channel = ain[0];
>>> -               chan->channel2 = ain[1];
>>> -               chan->differential = true;
>>>
>>> -               chan_st_priv->ain = AD7173_CH_ADDRESS(ain[0], ain[1]);
>>> +               if (reg >= AD4111_CURRENT_CHAN_CUTOFF) {
>>> +                       chan->type = IIO_CURRENT;
>>> +                       chan->channel = ain[0];
>>> +                       chan_st_priv->ain = ad4111_current_channel_config[ain[0]];
>>> +               } else {
>>> +                       chan->channel = ain[0];
>>> +                       chan->channel2 = ain[1];
>>> +                       chan->differential = true;
>>
>> Expecting chan->differential = false when ADCIN15 is configured for
>> pseudo-differential inputs.
>>
>> Also, perhaps missed in previous reviews, I would expect
>> chan->differential = false when channels are used as single-ended.
>>
> 
> After sleeping on it, I came to the concision that these parts are
> probably too complex to try to worry about differential vs.
> pseudo-differential/single-ended (what the datasheet calls
> single-ended is really pseudo-differential).
> 
> So I take back my comments about expecting differential = false in those cases.

Alrighty then


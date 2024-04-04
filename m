Return-Path: <linux-kernel+bounces-130969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87154898150
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E14FFB216C7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE02F4CB2E;
	Thu,  4 Apr 2024 06:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fWwKBcu8"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298B53E498
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 06:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712211476; cv=none; b=q5qj5XxoOve7zT4rZevZXrUPIPYsi+OgaApksyWb1lzTX6kRMrgaX4Ma5fKPrXNUwPKIHZCXhDDT/HYutqksQFrbAlE/k2VwqhFSfThZGSYBsnKBPQkSmtMuigppM/JFRpXms6tr0yhlbvMqCePY2BmwVG41ELqFIdYfXuwZL7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712211476; c=relaxed/simple;
	bh=ZJ7R9ncDVXtptVEBCmWeFsuNoZap0993lo95uag14cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iAOVnIdwZaQMMainKYAmeOvZfVMDlY7sutd3l4fJq1fkRJ3dns18fjstVSBPxzhj3dL52n55mgJ/+Wy7P0vxVSEMOl7Fx1+7SrRSTSCpk7FNTQo6Xz99YLx8YfUdIG/dHrMGO4wRvYcD8BYItYkiw0FyuN3GUzRsI5lJfG9hxJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fWwKBcu8; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a517d773844so77054466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 23:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712211473; x=1712816273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QstkA/0puettnYJmAHPNH5ZaCqi91hpEvWVtbV4p+ks=;
        b=fWwKBcu8jDOhCYNszm7P9KA0hpyPg3PQmx1tCqsPNM2ba11gTTXgZfEkU29F1dRw9A
         QBxAtjzR+KrMhPGoi1q++HvopurLSwy0B/kauv9/U4g8BGD8/PbuV7/IkcOZIq80bzbw
         AhOydA9nPAq/jUnEnjVAuQ0Sp7UA9ON/RL9POrvfhl9cV55cnc+N5daolovfRrUR9uSy
         scaIzGdpPKi/P+Ql3i+P2tR8wqlJcSmRy7Cr9ER+q9DNUoxV1oIqslHVC3BzwQc/rFpP
         ERq//LbPeUdPKMLmN66BtHXOcyTFjyWN5+V1TZe3pQ50Xus6LQbzMfypzRtoWHTy/Sx6
         fTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712211473; x=1712816273;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QstkA/0puettnYJmAHPNH5ZaCqi91hpEvWVtbV4p+ks=;
        b=e9wmQWHaNA14TCTLuch3I6jTTEwI7X4ePw9b5IMXY7RFA7xxj7DX94+xGmdcQvEAl7
         j+G3xfaVtnGINQCWTgUvBfW8X01Jh3ZryqeHZ1uG8NhORIGwLQOGqEvgo/5MpNmuzRwE
         vQyyBl5jc5JUSTZDU12rQUOhWXssXUjtM8lzf0O1yHc4bJXiUiVLJ8xbRr8QAX05Ar2X
         4p3915XDOqV6POP2VU7eZI4wf+Uv6fTdGQQi1bi9OEo2dzTFlBzwloYBqtMyZuclXSJR
         irloltkh2wO69h9036+stkBBItbM3ez/CMNWZWwiaPVR7q10n8KW/4594fJU0gqD2MsJ
         HsWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoEW1QHkDbHYcUrS4z/mQPXgMMivPCfWDibk6vErV9RkxRVjC9rDjXurNtLOuFmzOO/C+27lPjXWvbd6i5m3Nj48MKn5c7q27ErEvM
X-Gm-Message-State: AOJu0YxA+PO3iRlzJogdgO2NdGKssLjdorQm9zawaYp8PY8jRN+DpNyS
	MvRqW2834Tu0lTyLDd9bsQIuQEGvqAV+uIbaGq3TuwaLvuhTiY2bamQDW8nxAMk=
X-Google-Smtp-Source: AGHT+IEENym2ijmiU/kB6DhuJTWO7Em2jtRiY2Gc4RM4VO0AhN926Sag75h5SCWL36XOduQzAl1fEg==
X-Received: by 2002:a17:906:2a52:b0:a46:5e1b:58a3 with SMTP id k18-20020a1709062a5200b00a465e1b58a3mr875670eje.35.1712211473598;
        Wed, 03 Apr 2024 23:17:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id bb1-20020a1709070a0100b00a4e7dfb5abasm3550712ejc.171.2024.04.03.23.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 23:17:52 -0700 (PDT)
Message-ID: <e6e8c1b1-e1e5-4598-83ac-654c242dc6fc@linaro.org>
Date: Thu, 4 Apr 2024 08:17:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] Add Synopsys DesignWare HDMI RX Controller
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Shreeya Patel <shreeya.patel@collabora.com>, mchehab@kernel.org,
 hverkuil@xs4all.nl, hverkuil-cisco@xs4all.nl, heiko@sntech.de,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
 shawn.wen@rock-chips.com, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm@lists.infradead.org
References: <20240327225057.672304-1-shreeya.patel@collabora.com>
 <35e566-660d2080-1-7eb9eb00@16488675>
 <a2f88176-b4e1-4202-843c-a00c5a2b1622@linaro.org>
 <35f774-660d3b80-3-513fcf80@97941910>
 <86150c89-11d5-4d52-987e-974b1a03018f@linaro.org> <Zg3Gh8P97GaBtgAB@mz550>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <Zg3Gh8P97GaBtgAB@mz550>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/04/2024 23:13, Deborah Brouwer wrote:
> On Wed, Apr 03, 2024 at 01:24:05PM +0200, Krzysztof Kozlowski wrote:
>> On 03/04/2024 13:20, Shreeya Patel wrote:
>>> On Wednesday, April 03, 2024 15:51 IST, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>>> On 03/04/2024 11:24, Shreeya Patel wrote:
>>>>> On Thursday, March 28, 2024 04:20 IST, Shreeya Patel <shreeya.patel@collabora.com> wrote:
>>>>>
>>>>>> This series implements support for the Synopsys DesignWare
>>>>>> HDMI RX Controller, being compliant with standard HDMI 1.4b
>>>>>> and HDMI 2.0.
>>>>>>
>>>>>
>>>>> Hi Mauro and Hans,
>>>>>
>>>>> I haven't received any reviews so far. Hence, this is just a gentle reminder to review this patch series.
>>>>
>>>> Why did you put clk changes here? These go via different subsystem. That
>>>> might be one of obstacles for your patchset.
>>>>
>>>
>>> I added clock changes in this patch series because HDMIRX driver depends on it.
>>> I thought it is wrong to send the driver patches which don't even compile?
>>
>> Hm, why HDMIRX driver depends on clock? How? This sounds really wrong.
>> Please get it reviewed internally first.
>>
>>>
>>> Since you are a more experienced developer, can you help me understand what would
>>> be the right way to send patches in such scenarios?
>>
>> I am not the substitute for your Collabora engineers and peers. You do
>> not get free work from the community. First, do the work and review
>> internally, to solve all trivial things, like how to submit patches
>> upstream or how to make your driver buildable, and then ask community
>> for the review.
> 
> I don't think Shreeya was asking for "free" work from the community.
> Her question wasn't trivial or obvious since reasonable people seem to sometimes
> disagree about where to send a patch especially if it's needed to make a series compile.
> I heard the issue was already resolved but had to say something since this accusation
> seemed so unfair.

If HDMI driver does not build because of clock driver, something is
really wrong at the basics level. Therefore I am sure my statement was
fair,. based on Shreeya statement of build failure.

I am sorry, but independence of drivers and independence of DTS is a
basic thing, so to solve such you can easily get help internally from
your experienced folks (which you have).

Best regards,
Krzysztof



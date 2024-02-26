Return-Path: <linux-kernel+bounces-81337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E86B86746A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 156A4B25C5C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA20604B0;
	Mon, 26 Feb 2024 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JLaAt1MH"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9831C604AE
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949277; cv=none; b=vFudtQRSkLTMyBan0312lFAQFH4YRlhsdBzIVlv9vrc1EKI/ST80PDvdSfNf38mEt/di+xeu4sOxqbQMGDZ3TNfGOcyJ/EBdk44gDJQHoyFge7+iGek9DpKnBDNwo0NyqxeqJZnhwXjGDVOM3OVYCUKW3xR+8s9qaLBlDLY+1Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949277; c=relaxed/simple;
	bh=5oDXRfpmZ9J0rSrpUXylYrOoWTKQqVC2MU8lRe9KPZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIYfGVr8V8wjTpkt9tiplwvR85Ufc2B1FN5RDZ8kAb7axre7r2EOVZIx2df31CDsH0IVjGXDPqixspsBXXXeUuTZFv3JO0NdNvAPy5VEehKpn1pQf6eauTWxaFYKTXV6mEIOT8UDwTQsJVrMyw3aQg0FhR1WpUuXp9JCBoSuM2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JLaAt1MH; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5129cdae3c6so3835426e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708949274; x=1709554074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RhaWD+xU+qe/Vb+KSxnw3lueh/qaRZZn5KJ0TQW/iK0=;
        b=JLaAt1MH+WCwJljDPDvKeZ0vMPfzsKIXMKhGYbN0+1WlQAfqP1/JSbsue4apOa3nJE
         wgQ+xB26XzRZIJ4F5ayeycZFXne7O5kMwOcpJ7ULuPQ4WLUi7J2X9XEszCNTET3wsyJd
         LOKjAYGQuXl5Hh0304nD4pNbBvOQXmmNZnc15GGy6TTiJJhELhp0pUETTRuz7i2ITTl0
         R5gmhx0hxs8oLtuKFcm56Zzvbe5oHwHT+KrU+tWon/A+WPt2ko5AVOq0z96HO1Nq/5Tv
         s+rHAjsJWlRv60UogG58AlB9GzGvb5/GqF9NuN/EAm6ftcySh3QoibEVl3n9Thaomhta
         JM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708949274; x=1709554074;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RhaWD+xU+qe/Vb+KSxnw3lueh/qaRZZn5KJ0TQW/iK0=;
        b=m1CKvhC4RprSS39aYDNJAyzAWUxR81iNcBLRC0oKC4TJHSbCiB1z4L3B27goKz/Zh6
         HCpm6J5o+Nq0ubXKX+xLOGkBDfmDn7PhVVFXCjZ3RPl4U3fVhy/8Gva9X3Fh49q6nXCz
         e2cuSvLSYsEz/9d8oGQW5DPaGlcD50JVvwHsAfveXeeTjYmj0JG5EJZc1XswiFw5duRJ
         1tAv20dGaPO10Tl6O39EO+pb+f7h/1zx8dK1YADqkMKD1R9HkTCM5Jv9Kzdc3NcZtS+i
         XZ/vfA3wSY8TSaLXk7JSmMaY1QufDZHpgxIw2kGedlJ1nlxEbGHw7OJXRuemh5qqpA9M
         p+5w==
X-Forwarded-Encrypted: i=1; AJvYcCVZ0QemY6bbz6GlWFaaXmOYmgtJ5VKNFANe1MjSo6tj52jt6zvcwxmhuMgFppzDTdKE/2O9875YHa7zrhaXGPUD3cG6OggNKQYBmuWv
X-Gm-Message-State: AOJu0Yz+FJCUla0HCxR2/qTEuGKMeiHIJe+na2K0MTNjihP84d1FhMgx
	UbnQy7WNEMbiVw1mGKKMHDxx9/jMqB9t3DI0Xw1G6cBG+YD6hY8IXPt9hKyslu8=
X-Google-Smtp-Source: AGHT+IECH2lQ7LA9j2hJzNetfiOw4/mCf4T3d8GaZqsHdb7EtUTbWs9d4awJCIWhqWWXCRgy+18xnA==
X-Received: by 2002:a05:6512:124c:b0:513:251:f492 with SMTP id fb12-20020a056512124c00b005130251f492mr160131lfb.40.1708949273738;
        Mon, 26 Feb 2024 04:07:53 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id n9-20020a056402060900b0056200715130sm2301671edv.54.2024.02.26.04.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 04:07:53 -0800 (PST)
Message-ID: <e2ae7bfc-fb51-4a60-bb52-c6ccca7a4189@linaro.org>
Date: Mon, 26 Feb 2024 13:07:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] ARM: dts: chameleonv3: Add video device nodes
Content-Language: en-US
To: =?UTF-8?Q?Pawe=C5=82_Anikiel?= <panikiel@google.com>
Cc: airlied@gmail.com, akpm@linux-foundation.org, conor+dt@kernel.org,
 daniel@ffwll.ch, dinguyen@kernel.org, hverkuil-cisco@xs4all.nl,
 krzysztof.kozlowski+dt@linaro.org, maarten.lankhorst@linux.intel.com,
 mchehab@kernel.org, mripard@kernel.org, robh+dt@kernel.org,
 tzimmermann@suse.de, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, chromeos-krk-upstreaming@google.com,
 ribalda@chromium.org
References: <20240221160215.484151-1-panikiel@google.com>
 <20240221160215.484151-10-panikiel@google.com>
 <310cefcb-a4d5-4f4f-a482-ba2ff08a57f6@linaro.org>
 <CAM5zL5rQsYuo3+rW9+YPmvUg9PtNiR0Dy59e8Kf787ranfLh3Q@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAM5zL5rQsYuo3+rW9+YPmvUg9PtNiR0Dy59e8Kf787ranfLh3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/02/2024 12:09, Paweł Anikiel wrote:
> On Mon, Feb 26, 2024 at 10:15 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 21/02/2024 17:02, Paweł Anikiel wrote:
>>> Add device nodes for the video system present on the Chameleon v3.
>>> It consists of six framebuffers and two Intel Displayport receivers.
>>>
>>> Signed-off-by: Paweł Anikiel <panikiel@google.com>
>>> ---
>>
>> ...
>>
>>> +             dprx_sst: dp-receiver@c0064000 {
>>> +                     compatible = "intel,dprx-20.0.1";
>>> +                     reg = <0xc0064000 0x800>;
>>> +                     interrupt-parent = <&dprx_sst_irq>;
>>> +                     interrupts = <0 IRQ_TYPE_EDGE_RISING>;
>>> +                     intel,max-link-rate = <0x1e>;
>>
>> Rate is not in hex! Rate is in Hz, at least usually...
>>
>> Fix your bindings...
> 
> This is the DisplayPort link rate, for which the allowed values are
> 8.1 Gbps, 5.4 Gbps, 2.7 Gbps, or 1.62 Gbps. The standard way to encode
> them (used in the DisplayPort DPCD registers and this device's

Then it is in bps or some other units:

https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

> configuration) is by multiples of 0.27Gbps. This value (AFAIK) is
> usually represented in hex, so 8.1Gbps would be 0x1e.

No, the value is represented in logical units. Frequency in Hz. Rate in
bps/kbps/etc. Voltage in volts.

Best regards,
Krzysztof



Return-Path: <linux-kernel+bounces-54654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDC684B212
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30FBD1C2276C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D81E12E1C9;
	Tue,  6 Feb 2024 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZcK4N98"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6836912DD86
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214213; cv=none; b=U3pFEzpnWaqLQhDzXkHx6IE2o6P4mpIzDoxkz5lWpI6oFAC8fAfaiqtyU/piwwnkm8pnWSVovz6YiwsaNy+oMLXvQkfWaSmE8DCyHgLGaneeZMaWboSH3XsjfhttvLUK8ykx1CTJTk6Sk+Eh8GxDHvvNzkqFAEx5+7iXGYGgJk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214213; c=relaxed/simple;
	bh=+BMJMrZCmgT2D7pFoOaT+XHsPxMbkbEk9k/kf/Csw1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKsr5u1du6quD0EDtkVSgXEzDvWVGXfX6glg++36ewsbiKZTEKhED05ZbFrDbz7rpv+w29TuBPmw/rj+QM0eIGCcEwSp63RG7HtZyg1+PigHNZx6OLiG5b7XprkKo9HHwLU7V96nX/+13oV5M9pPz5YTosH9iXcMMs+KXGCd9Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UZcK4N98; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5114cd44f6aso2386511e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 02:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707214209; x=1707819009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DFjdI4H+4XlAK5XDWdvFCmHsUrlweegvlAR87DZPruU=;
        b=UZcK4N98M6L/6CSuppUJynHplDWZl7/VwlvHy58VOcM/zQuooyQ1Ams0ZS/tjaxywt
         /4QvQ2WcQzma0jDmSUdJuJemU7XwUTSKvW3itMNVW9G9QAj7QpZ9wPkNDbyKKftdYmyd
         cfqlef30GOWhncuef73pZHxZ3JvO8md62+bBtbLpf5rA7I41SfqfRMDP4nwvvOJBeM5t
         jPQWw45fYtKlv2sDzJyc1CoC2TLPpmZOOdsc47QSB90hH5gT9dkXXBIufiQljZC8SVlF
         B2wPyKrzzz3/q+rXu+A52j11Dvd56liKettrY0VUHwVySk9XLGuRB2eCzmloAMAPv2yQ
         nx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707214209; x=1707819009;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFjdI4H+4XlAK5XDWdvFCmHsUrlweegvlAR87DZPruU=;
        b=WvSd25yXZIevK4NAnNXxEyLt7c3431T3P3Inbq3jeJkPztycDLFTZRYCOasd7a+YE/
         A82Rafk0MKWaFB5HO0+Xhur+QtLDm5uP0kS3thNfGJKJnaiprhkkvERy3HzCQ10dw6pF
         doe/dmDQ6ABaxQMMgjIvcWCnWnw7VQVlg1pn7d+G5DUQSOwK/vE7DMscnGIYQ3MdJdhx
         gjiyet+LqOjIcg77+tGbHTFNZzT7zTcPqN4lubSTSgxEIw4pE2yR1mzSI07NPfAPiRk8
         amoZFGK3obhORXCgH2B4DDaJn2+YSOEG34LhB80rxST2vv+6gf0GQJU9pQLxlejECevE
         VCSQ==
X-Gm-Message-State: AOJu0YynO3kJNNTHbHc1ODCYetZ7PuyjUXqqhXhXzm3n82koAj2GV1P3
	PL+9yavl9mhm5zlEX1+F8vzZOJ2rusKuSVRcoVyJaCJvyj8/Leju9A46v4YFu78=
X-Google-Smtp-Source: AGHT+IGYZbblxbf6QoXHv83FC4cZ1D0Gf7Q0pyUHtTuFUXaBLTX15II2pd8v2GxArypAacH8ID/wlQ==
X-Received: by 2002:a05:6512:3b8b:b0:511:4cd3:d313 with SMTP id g11-20020a0565123b8b00b005114cd3d313mr1913738lfv.51.1707214209414;
        Tue, 06 Feb 2024 02:10:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWoGMwHwSUBmWevWPyy9hFJlzl2FYN3wA1WS8KzvDVxEBP1eUB4hsix7XJIpOC39O20Xqr+qiw88W1OqaGQkRIkToDPc3lXEz9QA9cBgoqmINr5bPIBqoG3fIADMIF6Z+7vIMBPJ+9SP/Z6hfZPCvMoEARAeFhKA4r2wmmitnwNYGazIiH0dD7gJB9YnfhYxsJ2dKQt7kV0JVW/yCjlfBJ00c1+DL/Zyy0CVXGsG72vXQh3qd0I33BiUUwdNNnN9vdtPumR8ZMtZajEpVRNKQcOOz9KbzfrVrU7hAxVS3ypTvcUSf/GBQ1g+zzkpsIhXjjvLfvQY7mfY/z8t+YoA2NfEk3MqOHSapls/EDmqn8+nm4Fa5YNuI6+CqJxpcSjbqp9za0XVYJodCzU77bHcKiYYU20TX49UHqgO3Lu+9/H4qbVt2tZt0R48iMdOMiwy8/UT2gDsI7A1BHSEAqwOiPGYD50wcxYUQoHLSr5dND6IvyympWnlx696NeHdpG3aAyMD6VHfHjA7q1VvdNTDVFwCB6rLXMdU4m3J2AnBKOLOUbrUI6ajKQtdKjqfrzJkk4lqqFf+uTcq8dBVlGeWbl+cx41cbs4h+fcK5LXbmAitd5TNJBXQg==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b0040fddaf9ff4sm1489222wms.40.2024.02.06.02.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 02:10:08 -0800 (PST)
Message-ID: <b199ba24-403b-44fa-b807-9b98f9e98913@linaro.org>
Date: Tue, 6 Feb 2024 11:10:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: exynos: gs101: add chipid node
To: Peter Griffin <peter.griffin@linaro.org>,
 Alexey Klimov <alexey.klimov@linaro.org>
Cc: alim.akhtar@samsung.com, linux-samsung-soc@vger.kernel.org,
 semen.protsenko@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, klimov.linux@gmail.com,
 kernel-team@android.com, tudor.ambarus@linaro.org, andre.draszik@linaro.org,
 saravanak@google.com, willmcvicker@google.com, arnd@arndb.de
References: <20240201172224.574238-1-alexey.klimov@linaro.org>
 <20240201172224.574238-2-alexey.klimov@linaro.org>
 <CADrjBPpqHx1uoVZCYDX51kW+JdOr_-+4oryOjXcUMFkmLGTBLw@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CADrjBPpqHx1uoVZCYDX51kW+JdOr_-+4oryOjXcUMFkmLGTBLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/02/2024 15:36, Peter Griffin wrote:
> Hi Alexey & Krysztof,
> 
> On Thu, 1 Feb 2024 at 17:22, Alexey Klimov <alexey.klimov@linaro.org> wrote:
>>
>> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
>> ---
>>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
>> index d838e3a7af6e..156fec2575bc 100644
>> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
>> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
>> @@ -283,6 +283,11 @@ soc: soc@0 {
>>                 #size-cells = <1>;
>>                 ranges = <0x0 0x0 0x0 0x40000000>;
>>
>> +               chipid@10000000 {
>> +                       compatible = "google,gs101-chipid";
>> +                       reg = <0x10000000 0xd000>;
>> +               };
>> +
> 
> I was wondering about the 0xd000 size here, as most upstream platforms
> use a chipid size of 0x100 or 0x24. I see the downstream gs101 kernel
> also uses 0xd000. Looking a bit more, that is because gs-chipid.c also
> has support for dumping other areas of the OTP SFR bank like asv table
> (offset 0x9000) hpm_asv (offset 0xa000) and hw_tune (0xc000).
> 
> I checked Exynos850 and that also has ASV tables at those same offsets
> above, but it currently uses a chipid size of 0x100 upstream.
> Exynos-asv.c driver is part of exynos-chipid.c upstream so it seems
> reasonable to have the increased size including those SFR registers.
> Currently exynos-asv.c driver only supports Exynos5422 upstream.
> 
> @Krzysztof - From a process PoV what is the best/correct thing to do
> here? Have the increased size in DT that includes ASV parts of the OTP
> bank from the get-go?

ChipID so far had only size of 0x30 or something like that. What you
refer to does not look like old ChipID but full blown OTP, which also
includes ChipID. Although I am not entirely sure about that, either.
Depends whether they share clocks, for example.

I don't have any GS101 information so I don't know what's there. It
seems you ask me to give you decision based on guessing... If you have
one block, so if there is OTP, which contains ChipID, then define OTP.
Not ChipID+OTP.

I think Exynos850 DTSI is wrong here. That's OTP block, not ChipID.

Best regards,
Krzysztof



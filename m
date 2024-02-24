Return-Path: <linux-kernel+bounces-79514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1D086237C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 09:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B4C2849F0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 08:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4624C10A24;
	Sat, 24 Feb 2024 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="foX5xjPC"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B9E12E51
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708764420; cv=none; b=f0SOuSq0rbp5K4tIXYHZ0PW2JoWm1rpRV/9EKNIQTsAhy4as9CMQTQcMOKhHoTZuWYpy/L/PcR33MEBvUb+5KF8w9MMPLGjiY3g07C0QNTi7VrfLbNkZez5R58vHT37x133cS8D4IQ6vKtVfHZMCaDx4SiAk3cMf8TH5o0WtMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708764420; c=relaxed/simple;
	bh=KV6d30L9G41JoC3gD7VW+RjaH9o+dowHLYK5EPn704c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgTxsjKZLPhJic1zgV4HATQ6OQSEtNRqNeEql3PCzyLYKs5hpKWh5RwOQwbnWAtgZgvUCV6bQYV4PwOefAz7fVi0pap4QuPuaoiMDPp3Ydtm1bhzzHgvNnz1IjisTd1PkeSBdUX0YKRyYF1LAeKwFtHglzdkcVq0MvlyJ5+tL2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=foX5xjPC; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3ee69976c9so176023066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 00:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708764417; x=1709369217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uQysh1tH0jeyP3+ZDv9awCKHowkCysHFdeN8I61EIUE=;
        b=foX5xjPCLWLjE6SnrIqZa/lxkbzAH5j9qzTXCCbmu71Aa6nzwO2dYmipDkqGTUbY9W
         EccvYOxwQMox6cRmisdg8dZjhAKVa5uSv6tO0KP06OGEeqg7UaLwdRlvh0bMPndT7zrQ
         t/2MLILqntOogu887863HFbeULZSxrJChZsv7ETXjwkPnEdF9vfuVVj1drnhJLR5KFBH
         nhm1C8hhh3Ru1VW2mX3QuMhwDdhmGhuqnhkTYitAf4vadiplsqQc6ZQyCf9kqRIjQb3E
         2P3lKcPEPcMTmE1YQLMpfrSyIELY0tSfyW9FgHiIwqfIcffp0ri+Tx/KSVSndgAsNpz+
         Xjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708764417; x=1709369217;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQysh1tH0jeyP3+ZDv9awCKHowkCysHFdeN8I61EIUE=;
        b=ayurDHkLezLMhT0hJKtI9IKVfwJKflz0mT5qxZyNITd6f6J6upDmjj/YlqArCx0EzH
         yFwXbFhsiDHDqDJ/3gbaT+uASJGU0ZQc4gUImSMlCi+ZCxDER2kw/JPKefr35ImeR9wZ
         Pko4MJw0pxevag+z903UOOqy+mm/Bj0UpB6fXFVyBwPWYx98+Xir2pjnBm+bekOlz4vb
         jz9EvD6LGFSaa0RNlj+kbHjB8Rf84B3H/YVccaDjPyW9gfT80+2Ft0oMVQFiiZUxfYUC
         VNcKJm7MZSChbYMv82iY/rw92v734fT5IlTTEX/x1yuoDUxuasN4E7+DnQjLdlZCDY6o
         ZeBw==
X-Forwarded-Encrypted: i=1; AJvYcCX8TNJ6WG4Q2BzS1PA8UL3T39CIuPEE97ix3dlht6YX3IiBtGQa5bbxuDQ6f3o4fiqs7Yw9sPEebj6hyFJoAQpYV4MBBk9RwN5dVToS
X-Gm-Message-State: AOJu0YyQugsI1Vmtt0ReLJSUStx0DFs7wirDthrS9pap2kyKPRAG9gVl
	cCEsyQK/s4koc4+pjkG46v26A6ZUDFer0IT78IPi40ZNEU3cz5ihLBoK70XFojM=
X-Google-Smtp-Source: AGHT+IGH7Uz7DtLCRUzZ8GnLAm2yi0SvftEtprhNdwkbFzuM51lAqDr9sT7DV7ws1UzELrEI4O8kmg==
X-Received: by 2002:a17:906:248b:b0:a41:56a8:a967 with SMTP id e11-20020a170906248b00b00a4156a8a967mr1276901ejb.63.1708764416988;
        Sat, 24 Feb 2024 00:46:56 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id pk24-20020a170906d7b800b00a3ed811cff9sm387349ejb.154.2024.02.24.00.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 00:46:56 -0800 (PST)
Message-ID: <caea26e2-6598-4796-b199-4ee5b1b9cd30@linaro.org>
Date: Sat, 24 Feb 2024 09:46:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/6] dt-bindings: pinctrl: starfive: Add JH8100
 pinctrl
To: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Alex Soo <yuklin.soo@starfivetech.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Hal Feng <hal.feng@starfivetech.com>,
 Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Jianlong Huang <jianlong.huang@starfivetech.com>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Drew Fustini <drew@beagleboard.org>,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <20240220064246.467216-1-yuklin.soo@starfivetech.com>
 <20240220064246.467216-2-yuklin.soo@starfivetech.com>
 <1a11cee2-2ef1-4ce0-8cc1-63c6cc97863f@linaro.org>
 <20240220-bottling-reverence-e0ee08f48ccc@spud>
 <cafccf8d-b8f7-44cb-bc41-3c7a908fd1e4@linaro.org>
 <20240223002443.GA3877354-robh@kernel.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240223002443.GA3877354-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/02/2024 01:24, Rob Herring wrote:
> On Wed, Feb 21, 2024 at 08:24:26AM +0100, Krzysztof Kozlowski wrote:
>> On 20/02/2024 20:10, Conor Dooley wrote:
>>> On Tue, Feb 20, 2024 at 09:11:43AM +0100, Krzysztof Kozlowski wrote:
>>>> On 20/02/2024 07:42, Alex Soo wrote:
>>>>> Add documentation and header file for JH8100 pinctrl driver.
>>>>>
>>>>> Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
>>>>> ---
>>>>
>>>>
>>>> RFC? Why isn't this patch ready for review?
>>>
>>> The TL;DR is that Emil and I didn't want to apply the dts patches to
>>> support a platform that hadn't actually been taped out yet. 
>>> For an SoC in that state, at least the bindings for, clock and pinctrl
>>> could be subject to changes before tapeou. I think putting RFC on those
>>> patches is a good idea, but of course the rationale should be mentioned.
>>
>> That would be useful information. We also could mark some bindings
>> unstable and accept breaking ABI under certain conditions, like that it
>> is early work without users for long time.
> 
> The challenge with that is when do things get marked stable? No one has 
> any motivation to do that (unless users complain). For example, We have 
> a couple of platforms that have an unstable bindings statement that has 
> been there "forever".

I see. Let's see what I can do for existing "unstable" platforms, but
your argument makes sense - rarely people remember to un-unstable
bindings and there aren't that many incentives for maintainer to do so.

> 
> I would like a solution though. The only idea I have is passing 
> SystemReady cert, but that's an Arm thing.


Best regards,
Krzysztof



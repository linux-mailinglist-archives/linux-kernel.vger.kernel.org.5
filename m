Return-Path: <linux-kernel+bounces-66218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4928558A3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 02:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28FC3B221F9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4A51362;
	Thu, 15 Feb 2024 01:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Euk9RmMk"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A783EC7;
	Thu, 15 Feb 2024 01:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707959829; cv=none; b=YxLj6wKqRY2vvTWYGp7TfLC0NbhpU+FC4Sny6KvFexFP221wmSAKGr7uOEFtVgUPT74YQpMx6pjqvhuVKl2V0kDKOHSklegWnjtiLsGyZWNUKw/J91w2wUxnmqW5YlDlyJBrD2lz7gKP4LFBr7KCCInvR9oko3KT999Q+fTrWf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707959829; c=relaxed/simple;
	bh=B3iwHvDLy4oW+BIedwUdauX5/J6U69PVYe9x/rpbe2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VL2A3oGrFepOBErnheQq5nRonxP+ZOr493Aoudsy7RY3HdFyOQu/Sfuj767XgtjxXxrFl+/Yp/4wXREtKVjcMsJXoqMOT6l/wY0Pzq4vhcyAKh6MIEvnFJxp6GfKiYgx16R+54JDiEkCLXnd49Tqxeob8QJpW1W97tYIMcCoB8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Euk9RmMk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1db4977be03so9377595ad.1;
        Wed, 14 Feb 2024 17:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707959827; x=1708564627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vVcstpclCxoCop2FZ79IhVaEgrNY/ZtlNdr4FrISvJ8=;
        b=Euk9RmMkCIf8f5bsaD9knqBE8zT764oKQ2GIMPhLlX/MJV2nW41++xbrLfvAY/p7n1
         cSTzU0DBsi+ucdLcE8Kc6j5VEo3yMlWEnCAQI/Nv64HDNYEJRFC54YZ5KxzfYWQ2b3iV
         /jxQLkHXvdhkuA7sGpUVaYhJZSZNmgv5lfgZhVV/hwhzaGfs0eWZCx/38+a+BEkzOtLk
         zV0TI7FLUTcAErB4ArBRyy51SqaofhFgI6G3ak/D9w57ctWoXhM5RxPCno3gjEUfZymg
         X0I0QiunD/LmsEGLep/X6g9k0nGsHIjLM3b3coR2wpNDRt1F+LGPDzBhy08ThW67eu0L
         LVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707959827; x=1708564627;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vVcstpclCxoCop2FZ79IhVaEgrNY/ZtlNdr4FrISvJ8=;
        b=w+zhkvXm8Pyi8veFyl54of1hJH5jBKahXS+8jd6/uZDLzcFz6zJnJ8LBIxfmFeDzO0
         Ap47IUZdjPrDw5sE4h22tj4IMKAX5jGefuo3qHrznVReXMFIJtjhAIC51WT/5f8dXfgX
         e+p2oFbxxWYjD5YoCZbp6rFvRCqdM5MgLX1olKTtC7QVdkuNxz5w0g5Nyj5oZRmiRtYA
         4hXavzYKjXAW7Fvo+lyoKIRyMqb8Xu047npfhewrrBxMk50gaTi4xWeH18p8MAKWkmau
         a3p16UwmGLfYlFd2agIrpztUNLlwJ+iEJFMnSUOBZOAd0j/X9AJ7aBA95g+0Fdt5TF1r
         3NPg==
X-Forwarded-Encrypted: i=1; AJvYcCWrmTFoQJpolCTtV7Wh1QRl/G6PhljL2bLz8RDJDk4VWJJVOY1HapLmQXNzZLBTohCApVKewBOkRD5N2bjD/m0AMGp0+Rx/nlyVFewK+L1zy5WBjP8q9RsH1kN0XfdyDhLuRdsOfqzABgLgfGzQ2iJWg3caVXjOpdI4O/kQ1JDNZIeednu+
X-Gm-Message-State: AOJu0Yw2FwiGIuprzyfijaY/NzSgEl/LC+ZgsRvuwaUo6duCklwO+0YY
	lyH8nAXxaPFnH7q0m+/iuD3dqRVPHQTuKPe605uEeFr08Mr9tFaw
X-Google-Smtp-Source: AGHT+IF4URH/58Up2Ou6NHAs5rbVJvxRGUyhz1IbfnZvEUflzYgcXLYvo4O/MWIeT3MopT//XghBjw==
X-Received: by 2002:a17:903:453:b0:1d8:ffbe:82d9 with SMTP id iw19-20020a170903045300b001d8ffbe82d9mr368651plb.14.1707959826727;
        Wed, 14 Feb 2024 17:17:06 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mq7-20020a170902fd4700b001db82fdc89asm62400plb.305.2024.02.14.17.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 17:17:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b306a27e-505e-43d4-aaf8-ab31284a3396@roeck-us.net>
Date: Wed, 14 Feb 2024 17:17:04 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: hwmon: tda38640: Add interrupt &
 regulator properties
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
 Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, mazziesaccount@gmail.com,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240214092504.1237402-1-naresh.solanki@9elements.com>
 <20240214-trinity-delouse-6dcd0b046895@spud>
 <0f1665e5-bae1-4a17-a976-cc225a28dad3@roeck-us.net>
 <20240214-dimly-wife-5b6239d4adec@spud>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240214-dimly-wife-5b6239d4adec@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/24 11:55, Conor Dooley wrote:
[ ... ]
>>> Why "vout0" if there's only one output? Is it called that in the
>>> documentation? I had a quick check but only saw it called "vout".
>>> Are there other related devices that would have multiple regulators
>>> that might end up sharing the binding?
>>>
>>
>> Primarily because that is what the PMBus core generates for the driver
>> because no one including me was aware that this is unacceptable
>> for single-output drivers.
> 
> Is it unacceptable? If you're implying that I am saying it is, that's
> not what I was doing here - I'm just wondering why it was chosen.
> Numbering when there's only one seems odd, so I was just looking for the
> rationale.
> 

Given the tendency of corporate speak (aka "this was a good attempt" for
a complete screwup), and since this did come up before, I did interpret
it along that line. My apologies if that was not the idea.

Still, I really don't know how to resolve this for existing PMBus drivers
which do register "vout0" even if there is only a single output regulator.

Guenter



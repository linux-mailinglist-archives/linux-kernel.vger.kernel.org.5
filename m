Return-Path: <linux-kernel+bounces-69903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0D4859012
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C08282C19
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129817AE7B;
	Sat, 17 Feb 2024 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vsiPntfa"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9AA7AE76
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708180047; cv=none; b=thTUcZepAIavp7lqloE5XOtQ9mHgmmwO5HyGeYKtcT9fB4AvaC33fHCfDLRMlGG2QxaTtGQgbAxXZpSgEP412Y/O0euY1wkKaDuSVhjvoumTg4LqJMBhDejQeTdTeEJgPCXeExrf/45w0XZVIPfNU+w5kVhwhN4vAY9DvhUqH0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708180047; c=relaxed/simple;
	bh=H3916Snr70gqdtZQP8lE61YJhmo0E1lCy5BklIUo34U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Zs0Ug5UU8MvcwvpofaNxpJPKh0VjWawpBxCZTk3Q/7qvTkuJXASfCisEesv6DLqMIrJXN8t0prouEJDvclWu7FasMhhUEKMtTJ3pi/UUB6nE/2CxLrId1q9vVgzfONbYo0RyGfBiEzfubuk88lzmh29PZ2AdvDn0urcNpqt38U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vsiPntfa; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so327578a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 06:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708180044; x=1708784844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zfyGzSc7LXgbkeR0zMNHuwzlUbGWtcjTznmTQnyeVvE=;
        b=vsiPntfaRjJj/wpMhrwAIkL3ECF0JTTOeh8GftGj68C1NgLhg2gkZyYCK6blD/LZ0I
         rP8MPWJQJSPJbQnd/ySZOJSCr0ovDhO1ovOrpxE8e2cMWZx3iAPpiT0rERcO8C+n9lFa
         KfJKxd/vIEwICJI7EqeuHTAHUYwLoeuzP52VGAGd1tGzzvfcOPA/6FZJ/XJ74/gNLPg2
         5PagSi1FejBY2wfsmW2BVu9S4pzWoPqKwqSpmTwThoY44/6aJa1RW7GbwrYi2fnVsv+S
         Xg02FXTKKUvgwuIVk8v0MlU3YorZgq+tVVTcXXS8BqcyA62P4/QPuIUFR4y4up46/QAD
         FvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708180044; x=1708784844;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfyGzSc7LXgbkeR0zMNHuwzlUbGWtcjTznmTQnyeVvE=;
        b=bwVsqaKLPUEF3qTZN1a9y4+FcDsxyWvmXND8nSLLWhDhQlKGGTHqG7MefwlChu/9hr
         6HX9FUGfoR1Nu7JpfbCns26bp0nf/ixVYTXTx2+Z6tM/M/QrMmF10VT94JxS/I2i8Ynp
         jDAgsK9NUtQSZXsFU6EQewaymmPrYixwxcKGCpa7lt+gonzKXY4OKHxlU5oh8FQfjyLe
         0KqLdGHbeaLaXDJGzeILAAiGrtYJWAjeIl3sT60VIiXfsmZzMml7tJoFdUl8SncTdSsD
         QGleH4Ypc03mXGlUZyCnE7QgjAKehbqSvHnADgYrV9qRWkZ7nP5VfBYano99sIWsWEx8
         Js+g==
X-Forwarded-Encrypted: i=1; AJvYcCWG7jZwahi+9ht2jCpQ8u3WbPL+UnCs+1JG6nop9dLZBhH3t7ivObqVEHMJk7y8ksMPmiN5SJgA28qQC3hO4xwrUNPytS3PJ/zFUBiG
X-Gm-Message-State: AOJu0YzrlqmyWUmHlidezMUJQxavaZUea9boJCI/ZZXPgMgnk6SxXtJ8
	WqLI9U1gPdnT+O+/ljW9/HJSiLJLPXUlAbkNuXFnEpRTTohI19OqmUdtYtM6cLQ=
X-Google-Smtp-Source: AGHT+IEixJUZMOssWaZxNUQGH2maYdAan4cNWwZhwaArZgSyFi3uGoxhsunV1PPLt/PUV2zIpWIy2g==
X-Received: by 2002:aa7:d6d6:0:b0:564:3939:8153 with SMTP id x22-20020aa7d6d6000000b0056439398153mr425099edr.28.1708180044015;
        Sat, 17 Feb 2024 06:27:24 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id el14-20020a056402360e00b0055fba4996d9sm923053edb.71.2024.02.17.06.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 06:27:23 -0800 (PST)
Message-ID: <321bdb3d-d377-4044-b8c9-02f7e1af1b6a@linaro.org>
Date: Sat, 17 Feb 2024 15:27:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: cpufreq: Add nvmem-cells for chip
 information
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Andrew Davis <afd@ti.com>, Dhruva Gole <d-gole@ti.com>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240206145721.2418893-1-msp@baylibre.com>
 <20240206145721.2418893-2-msp@baylibre.com>
 <98c9d3ce-8a97-499f-b78a-b918a06ec779@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <98c9d3ce-8a97-499f-b78a-b918a06ec779@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/02/2024 09:24, Krzysztof Kozlowski wrote:
> On 06/02/2024 15:57, Markus Schneider-Pargmann wrote:
>> Add nvmem-cells to describe chip information like chipvariant and
>> chipspeed. If nvmem-cells are used, the syscon property is not necessary
>> anymore.
>>
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> Acked-by: Andrew Davis <afd@ti.com>
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

NAK

And unreviewed. Please carry on:

Nacked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I found older discussion with Rob, who pointed out that one device
cannot have entirely different programming models, so this patchset has
the same errors. None of the previous issues were fixed here.

Best regards,
Krzysztof



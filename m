Return-Path: <linux-kernel+bounces-47816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D92D845344
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7CB62909A9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C374415AAD5;
	Thu,  1 Feb 2024 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wz+W1+aD"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161C415AAB9
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706777934; cv=none; b=FICMnpt+nN4fM+dT/Ce44TpY+wIAVKDiIgxVl2o/AL2RBv1VNy8zlVEvxNOwaPQrKowVCxf6//URphhMMISZaEcxRFHJfeb4hZ5kr60rjObd++AHwrJ8r1DX/pRT3EnhHVIxQ7TU8ZWNk9Ip3uhy9cccy8n3YrvPHSeB4GNUsyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706777934; c=relaxed/simple;
	bh=lXquSksINnAQgs9rhIZIDnVL2EKjkAWgHOMS4W4xcWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bprd/FLf6IF0vutV3CQ3ZBbPqzuVdhRP5/noyVfY9glvNnxTeHU9BYAPy58gVJhcQJShBQlCk+m5zJ42cEm7TgTccjy5vZEOzUVtOodPsvCaEjgYS8dNv7JqLIJ1RktrH7vtKs2JrOhWSN0QWjNYgYjp9WtqJmkqUgZZXQrxk+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wz+W1+aD; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a354fc17f24so79763366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 00:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706777930; x=1707382730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnahjsb4pOQLDby7/J+uHzKaCcjEiFwB97sDznnRHfU=;
        b=Wz+W1+aDDkEOG1XY42i0NtuFb819FgkqZRJtIOe9MPv3OlhzyrMGGJh8mg/lWcQCA8
         C/B2Sa1F13O/p+yHamaiA/wIaouuj3cdwQ3GDav9iQEI/EoPzbftaVe7uZnt/sz+viN8
         1miEJfgIvQf7NGkSs9wIPHbNpM9Txun1ZjqvucquWPTjYDj0XRbQWMkoikWo7OJY4pz+
         OZYnWDM8S9A1RTUh6GSmtZX2mT2d0OLP5Q05GPdks//VHltnlYGizaoLcbPV9bUSv++k
         B5hbj769uHq8PDpdGRBK8jeKdMRclsiy3wirzURKvd09FE7SQEaLt580PPocxu3WKD/q
         Jx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706777930; x=1707382730;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnahjsb4pOQLDby7/J+uHzKaCcjEiFwB97sDznnRHfU=;
        b=S3NTa1cGa64ZfjUFkF7UBw48/w//t8VO2PVlT8kjweR+QXFsK3aj7XrbMn0Cim48/j
         FD3wELDGTkld2XhPAKi3ZzIsM5c3NSpSzXkgYt7FQsm5bBedqx81CqSdJkg5zkrqyboM
         zSQLxpG9tplg6ZVf1SyiyAiCWPIXnd4ujrXkKFqbCWM1JTWgAq64oCrhSiSjgjJbujZR
         z3yCNlng+fFEFY1lHjI7J1ctFLvWd/s41mHwOEXPzKkz94TC1broDmCZ7rdknclSMKZj
         3dEFCI3tT+W4y3OpTAXDGL2/XybZajP938JulLTKKyNU0+eD+Rw9AXUl+YxtD69sBG+I
         a0lA==
X-Gm-Message-State: AOJu0YwbO4hR/IwNzNJCy/ceytmXj99uSiEQs9efa8bUoetU8AvCu6TP
	IqjmqQkIjdvjUkYrRNc8qe7BmBpeFgEzFbQoXU179PZb/dIcft0bpQNCJBs2C60=
X-Google-Smtp-Source: AGHT+IGCVX0wVZBLFNP3H7tBIEao7tri0750Mpd+CzIpeEhrsJKa5eVo0JUl7i0WvplLkHdqwVS0cw==
X-Received: by 2002:a17:906:22d6:b0:a36:c845:86c2 with SMTP id q22-20020a17090622d600b00a36c84586c2mr539710eja.51.1706777930228;
        Thu, 01 Feb 2024 00:58:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVVAzN0iPoBBCQ0p+uFB1UzQGKLIa1StwdomT7NOn/+KGFkt9UQV88DuvaRv4O4G/0A38BiZaUuxd1lzz1dJPdFNy6PsDRmdMaVV2LSTFxegohgGFDO3Gv0I1gNF8QDaFBmGgS/8PvBN7yv9brAZ+mDkX6fw02jhcYScfaaVX0mBQyQnSz13qGcbTIcK6J0Dt4yBubrQbE/ca+YXhbifnS7DkaowpALoEyFur3jdWqb2alesiaAXX7EFDghY40dvvvDHwfcxVV+UWxOhv8uew/9ZeR51SsTXlOekyGdqsh1ja3xBIlWIMgEZwyXp6O5Fh/7kPVp5Gp4Ds/5IgkWzZ7T8xqsxHMpADL39g/WVfeJFxo4uS0iCKL4whE66s2tPFYkwRvbrmzwYmKMFnTyEcvgzolsWYyTGLTWxetLr5CTDx3rm0rN6MHqFvSlxdlNdCzdvVHyrLu4CuMK3sUGotG6EU+M6AXQToQ8PRxANYFpyQd0mq+4J6arjdwFhjbAGUJdqMVgDhJwWYNmRIuPUvgHUsa/R946C8sv+8V8zRDc98p9ubCV5RuBZ63Qml6qIHbXpF1Yy9agI0wtntmn8Xq8HLP39DLfAon1RKBtSyPg+8WSimZzxzNN7Pldj/qPJkMiW/yBH+WCGA==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a36c3e2e52dsm285476ejc.61.2024.02.01.00.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 00:58:49 -0800 (PST)
Message-ID: <f6e5b748-17c4-4de1-be42-f79155be21cb@linaro.org>
Date: Thu, 1 Feb 2024 09:58:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/18] dt-bindings: clock: mobileye,eyeq5-clk: add
 bindings
Content-Language: en-US
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org
References: <20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com>
 <20240131-mbly-clk-v4-4-bcd00510d6a0@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240131-mbly-clk-v4-4-bcd00510d6a0@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 31/01/2024 17:26, Théo Lebrun wrote:
> Add DT schema bindings for the EyeQ5 clock controller driver.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---

No changelog, tags ignored, I scrolled through first two pages of cover
letter and also no changelog.

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tag is "received", when
provided in a message replied to you on the mailing list. Tools like b4
can help here. However, there's no need to repost patches *only* to add
the tags. The upstream maintainer will do that for tags received on the
version they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.

Best regards,
Krzysztof



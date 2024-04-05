Return-Path: <linux-kernel+bounces-132518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B83FC899625
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0531C225FE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E2E28DC8;
	Fri,  5 Apr 2024 07:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vs0igS57"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6695225630
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712300635; cv=none; b=tUDL+amd2dfbTQGpk7bo0czau4wIsOvBwjUtvcTz/IHUlXiR9S3hnv8dDgRa8VvgG7nkfHKW/K3umoaVsDcuQUqMCjgJIs1ZzR3U0uvgeCgxDlBpjKkbhj75t5wMT5KF7XGlpKq/PA0xMz7atP+hISbQhq7Beyg5cEk61Ftdqa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712300635; c=relaxed/simple;
	bh=iwey1lQRQXFlgsb+OZB7hJAqpJiroNXj3GyjfUrkqz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFRXwqSxRzBAsJ4Q83ddcnV7cAoM66IFWCAr7HFqzNKMrl2KHeFLK0E8AoluHpdYkGpNdJieixCwN+sIuIYWNr7IdZEc6GauriUb+KbDZruzJjgosrhzE/IOwfxjCuGeo6sZP1Ya5rPKhKU99kY7vyNgOO51j86n5AfoVmauoyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vs0igS57; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e2c1650d8so517939a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 00:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712300632; x=1712905432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oCYdD0nzUyzU3S8Cbt1H8N7sCuBBdWzT5zTjXFriRfw=;
        b=vs0igS57J6LCAW08FUR8+OehFq8MYlccOMo/oWiX8IA6SE8KIMNIe2wgFduCxDA8/o
         B0pjV5bf4cRsDA6FCFzsrIsx1P8Lm1lVmjVv2b2wj9wS9A7ZGGvjsJT9SqqqgYPpkZhk
         6+6BYbWj5jnD+pjh4VrJOfTiTgOcaL0csl/ekOTRl5P05JjEEOOK6q3aD9o2qEO8WwqC
         iEs1ddEHcZT1B+dheCTE9yny5dTi4L7rBSCE0+7D9kvv5LBEdcJk/dxFPjlc6gh20r9L
         adKZRZKzsPy/k7CQPe/7hTroe8jMUboBrNDjbK0q3wKda2YDj3tj4j7Le2fIYaDieBku
         NewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712300632; x=1712905432;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCYdD0nzUyzU3S8Cbt1H8N7sCuBBdWzT5zTjXFriRfw=;
        b=JmOv+R8ImiMoKp2SO6Lu5GY76dFgFNItkTajNoCCm/RqdT52nBbE/juM4EVMLTjXrZ
         99aQdwXWvwAx893IYc+4LWY50HwMkrwyTCx+YaUhB+daLjqNOPY9wAQjnHIkA8AWJPZ9
         Co1V336GVRFP/2c5iVJVvMJaYLC6mbgZSJnluCOm8IIjLrjY69poJLvt+NpoTuYk5O8j
         YD5M080SVKWaq+v/tdOa12DJLGImqYRa7FVBgaV05Vl7r68S/Q1+vyKXIQvfxmyXHwgt
         Zc8RYjXsYjHdjkRlH0eSD+KspnKn8jO7seMQxO1e6NgdtflJDdt3EV0bGZ8Fp2aIBaJe
         VrAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9Z4C753Z8BBfXkDBEllG/n1rW37Sur9tuDOhr6xeL4mny+/5p583yrRxqy8rr3YTYfbhRrU298ssbeQ6TwVTc/LjJoAiUGC5kjF25
X-Gm-Message-State: AOJu0YzCn0aWFvZpDL7NjZhbObi62Ng1vAroqFnDG4/bk4a8eho+qUi2
	Cvh8FecpfNBaEvH2hCXgn4P0XkGyGxiPeezTfPEVaBDbO9B7qLp6EvV0dJ6pPW8=
X-Google-Smtp-Source: AGHT+IGxeGL6XjKqM0fpJK4YsJNXNd0u3JjOlZY1KDhjbuNKtPeUoCq6nLipiW5zzrZ3/8UQSP7tSA==
X-Received: by 2002:a50:d588:0:b0:56e:2493:e3c2 with SMTP id v8-20020a50d588000000b0056e2493e3c2mr364108edi.37.1712300631852;
        Fri, 05 Apr 2024 00:03:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id q3-20020a056402248300b0056bfca6f1c0sm484633eda.15.2024.04.05.00.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 00:03:51 -0700 (PDT)
Message-ID: <e4b18e23-7103-41a2-be32-18ab6cabd1ff@linaro.org>
Date: Fri, 5 Apr 2024 09:03:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: arm64: marvell: add solidrun cn9130
 som based boards
To: Josua Mayer <josua@solid-run.com>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240404-cn9130-som-v2-0-3af2229c7d2d@solid-run.com>
 <20240404-cn9130-som-v2-1-3af2229c7d2d@solid-run.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240404-cn9130-som-v2-1-3af2229c7d2d@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/04/2024 17:35, Josua Mayer wrote:
> Add bindings for SolidRun boards based on CN9130 SoM.
> 
> Three boards are added in total:
> - Clearfog Base
> - Clearfog Pro
> - SolidWAN
> The Clearfog boards are identical to the older Armada 388 based boards,
> upgraded with a new SoM and SoC.
> However the feature set and performance characteristics are different,
> therefore compatible strings from armada 388 versions are not included.
> 
> SolidWAN uses the same SoM adding a southbridge on the carrier.
> 
> Since 2019 there are bindings in-tree for two boards based on cn9130 and
> 9131. These are extremely verbose by listing cn9132, cn9131, cn9130,
> ap807-quad, ap807 for the SoC alone.
> CN9130 SoC combines an application processor (ap807) and a
> communication processor (cp115) in a single package.
> 
> The communication processor (short CP) is also available separately as a
> southbridge. It only functions in combination with the CN9130 SoC.
> Complete systems adding one or two southbridges are by convention called
> CN9131 and CN9132 respectively.
> Despite different naming all systems are built around the same SoC.
> Therefore marvell,cn9131 and marvell,cn9132 can be omitted. The number
> of CPs is part of a board's BoM and can be reflected in the board
> compatible string instead.
> 
> Existing bindings also describe cn9130 as a specialisation of
> ap807-quad. Usually board-level compatibles stop at the SoC without
> going into silicon versions or individual dies.
> There is no programming model at this layer, and in particular not for
> parts of an SoC. Therefore the ap compatibles can also be omitted.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



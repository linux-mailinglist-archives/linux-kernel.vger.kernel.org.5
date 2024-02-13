Return-Path: <linux-kernel+bounces-63489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C35885304A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C581F29887
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10CF3B196;
	Tue, 13 Feb 2024 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PFsbh+uy"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459C54F1E6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707826353; cv=none; b=NR3sKUxe3Qp4Kg4sbbQG6Zn6S3qKZlLXqV1ld2ZIei10LUtVQL/Pzkrb9ETtPI4iM4IgAe6NUDf78yGQREofS2O3ilMISJT4MsMgpFEnS144e7OWHWnZfe6lMeauTAdeyOIeyuZukzDlt53FIQ3BGuz0RlKd4HdRIkSskDEOHLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707826353; c=relaxed/simple;
	bh=LW/Jq4Q5LtHY9P229cxVjiwUe/lGXRqz+oNQr3nq8L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClXy4evB21TjeRe6YI+YY+D4JzZMMaU+tRmfA7tXQa1zmFFwdWJQNqXONL9k9+0Te2huD6yl1/yYDliftmjBEWVrAODOo+V5XN2AMtx6MyNFI9c6cuy9IpKCsCpu2Hi+wmIVlPljw3ofC5eI6jpBqLlJaeJZAMGmWDYGWjjy34Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PFsbh+uy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33ce2121d5dso80557f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 04:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707826349; x=1708431149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K67weB9dwxJ63WFWBRK4344YdSvRm3NpywijV8bIi14=;
        b=PFsbh+uyiF2QFLAGys30HzG5C7Mu6RhkX9fqH2VFoAkWPuhrnIs1MEAgTWVxHCbq51
         c1H/NiqTRaBsSY0FWYI+Tk0G5r/QFdQ62n9DhCaGXz8+1iMSwUNzQ4tVwOclPgmwe1Oj
         VOFGkGvJOPf67Re28zBwPpX/K1batRKZOxHXlGQ7jB+GNFO42orO5xIT2fH3NMRaU9VS
         W4J3RKeoy3B/4r67u6AEqPnbLXWZlhPvRzxYonjvOxwYRiYX1Z/ekY4B6zGGpz0rRic+
         n1GkDE2XSe09Hmh3b6YTMmCK5rUyjvayOk73MhaeqG4dwFoAJFShDRVhyvoA7wFWPgZE
         OnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707826349; x=1708431149;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K67weB9dwxJ63WFWBRK4344YdSvRm3NpywijV8bIi14=;
        b=e/tqvoyVEQQd8VxLJS5Vud4XgO/gDyss3gWhYpOIO7sVGlRSKFzMxOm0Gw5Yj+9Fmw
         tp34Mdx2YwkhpnFOvvd3eLDXIJQ4VCoO1Z3KfZfsRwdmxSgHMg03HAQEJhJ/3KNtjWSg
         c5VdM8Kr3jyj3opEx1Hdtsnx4utmBeeKcE3QbSUU/reO/b1N8hTxMQrHNCHhCYDwF+4H
         IuQFGxzb2HidjbUSHHr1RAUT7hso6Ykrf//PSXfOLokSSRujq7attofuk6ojdZAduJ0W
         ZxNLC3tg1sb9hW6MqHBjCpWQrIj7F4oClSekFcw0+5zBkHDMG/lmpo/Qkecy02VkEsMx
         MEoA==
X-Forwarded-Encrypted: i=1; AJvYcCUtGUSgbkve/2lPd5aasylR05KRfMNOBVqkwfYdQwemEsJwywjfUCuNquImh14G6GGfdv7aoL2DmJaR0bFgAQBNesmoPx6mUMR6d2/i
X-Gm-Message-State: AOJu0YyYx87FB/DDZTjGUnaUrrt18iT6B6l0a+o9tJvs2sJW/u+h7D/Z
	JAwh6DlwccOpzvSBgiyVL89QImt+9jEMXk9zRDUGKBxeyDroDOB+TRWs+l/1LIA=
X-Google-Smtp-Source: AGHT+IFK73zazqStcyyAnH0zibxGpVhtHc8BbQmI/yCRGXSNRhY0sc3+hjDaY0pWPTwEggWHEs8D7A==
X-Received: by 2002:a5d:490a:0:b0:33b:1d2a:4f7c with SMTP id x10-20020a5d490a000000b0033b1d2a4f7cmr7392336wrq.30.1707826348784;
        Tue, 13 Feb 2024 04:12:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUvUokeu2GOtloMGtT0hmiJ8LAuZGbzAaziaWTcCHh1RdvyVxRR4HKRUOf77+o1Tnzdbl/7C6+j91VyNGk25VWeDq/ZBsEfeYQ0ls6HnXmZ5rvBjYBDCYo2UAZh7vZtY6B3yxlyI0btutiM3B60cxHDBF+hRNQn/r7/UtFYgDo5gcq8r5izE7Pl4H+g87mWm1HDmVfj3s7EpQJgY4oUhBWtqe7Ytl2mcSRzfw3ACdok8HCSV4ZfZAe/lEMyOY6alvRdC6QtQuHpnnK6Cu5bNio7do3d1RtPpxe/0Ml6IQhP5PA+FcuyMq8mHnafEpJV9U63B1MzDRTgfWyAPksuqg13/Dw47qh/4KWgGDSNDKlqUA/O6PUEvUq2oLFrAOpYvhopnVyjlgyitDKztqOGLogU3Bs7+ZlyoIVqE4FRdLI2uhDBwJqmXS39
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id h16-20020a056000001000b0033cdedb3e84sm971070wrx.18.2024.02.13.04.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 04:12:28 -0800 (PST)
Message-ID: <9ff75d56-73b4-42b2-bcc4-6888b247fc0c@linaro.org>
Date: Tue, 13 Feb 2024 13:12:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: ARM: at91: Document Microchip SAMA7G54
 Curiosity
Content-Language: en-US
To: Mihai Sain <mihai.sain@microchip.com>, claudiu.beznea@tuxon.dev,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 andre.przywara@arm.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: cristian.birsan@microchip.com
References: <20240213085614.26804-1-mihai.sain@microchip.com>
 <20240213085614.26804-2-mihai.sain@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240213085614.26804-2-mihai.sain@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2024 09:56, Mihai Sain wrote:
> Document device tree binding of the Microchip SAMA7G54 Curiosity board.
> 
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



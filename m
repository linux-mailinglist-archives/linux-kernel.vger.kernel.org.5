Return-Path: <linux-kernel+bounces-62169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D2F851C99
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289DD1F23467
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4E93FE2B;
	Mon, 12 Feb 2024 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wntZ0atk"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F093FB1D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707762040; cv=none; b=iV8ShgcgN0IKeOYS9KON5ZSBqk/qjBAJC8zg5SIaPHOPcW8Z7vueCWz2Su5YXkEaynJ7c9AqRIm/+iqo8tI/GE50lQyrJP3ofLyW1nV8uRG7SAvXsqAktWf/q+uqEtOH3fs2nCAvcVt8g8lYbgdmVC84ocFWuTiWBncMPHhl2mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707762040; c=relaxed/simple;
	bh=FqstqDRc6DNB25XUnhXq/EbEfMo3G2CcpUBAP4PNy2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDIFTX1mcB2Fwg7kdJicHyJEaNHQaL1ADGw5s4Izk9CV8nFMEnwGrTbthpzPwmRLOxyM+qtMvV2erjUS36iCDg5pSWoI40y8Vckh/2y5Z4NIagURRI9O/HNes0MAYAylUlamdp72T6wsC591P6ypSjeQfvfVk+Hf3WQPAp+8cRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wntZ0atk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-410ec928b83so6061365e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707762037; x=1708366837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MX67yNDS4BaerKNSUXkCDc9Xep26w2KXPFdQrOkSa+M=;
        b=wntZ0atk/zGzFStre4x24U71ywqmKR+FVYEdmg/u1xar8gSGIm+B2QSzmMDH5uOI14
         2acuvTAiQ0/cr4ZIzEkqBMBj6sX2sIu3NUUHhSoNL3m8OeH8By5Dkf2mSvOp8gAha8hn
         QHBXaVFZo0xga7QNGHvf/sj97575N1/IYaiQHbMcUQhElo2Z53oy0F+p7/aDfdW9b4nn
         F/xLATiKzcasx3KRfgsQarYq/VPXOhs/LC4+P5DWydlAljb2ldKyVW0IjvQvk5Q1XRB+
         qaLJ97rTPzhtllbAzKzd5yzA7CgiKhW/rMCxnN2TpmKd85vpl442KbJXi6XqKR+7Vumo
         +H/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707762037; x=1708366837;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MX67yNDS4BaerKNSUXkCDc9Xep26w2KXPFdQrOkSa+M=;
        b=Zft+nFQ32QDH7zUTGJ2E+8EH8uQQLKOT6Ru+RuEgerfJJidh8O6eXc3861sfeV0ShX
         nbSMnN6K1Vd9C6/d1Ug31mZIYW77hxeQKFQLLa3D0HBw75Ghv1gZtW+nk8aT23aFp94X
         Vc6bcXnlI0Mt0s3GBEN7JZwWVdinF1v3AjaV2jYaYU2j4xF1xr/kqnVE+KOZKoxTv/z7
         m5ovZYdNmMJ3q92sOyKiB+/j0BkLDKBbqP3Vq1TLF2IJp7Pmbn/bv5rRGX3Ydu4dl2Xf
         lVfa7UY6aUKRa7Nm2U5o/CwOflp7udc2uxYpnQ1TxyPSAVKrSn7V1yFvEBl+ogzNLMlL
         xc6A==
X-Forwarded-Encrypted: i=1; AJvYcCWK4h2f2hZR30OgZZbu0FpzTj4F9YaypfCbuFRrB8TL2I+kstRPRNhn7zHNmTw0F2LIlIwJ7qwCu5Qdkj+vr7eHoITsKHpozraJNVE5
X-Gm-Message-State: AOJu0YzMhaSqTdSBSuJMGEimJ5TEyv+geISduv/JkIuU7OaGLWtf/8vB
	JfU5QLi69itXYhi8awOsthgw9AhE/k5kkwOePOq6fz8HBKF8n3iLjUfzU1ki7Qw=
X-Google-Smtp-Source: AGHT+IFUs4VfkR41BG2w7yQCifE3pSC5JWJsrHOVFGNukumHimWe634e9ZK8xXCQN9lYK49EHu8Vww==
X-Received: by 2002:a05:600c:4689:b0:410:aa15:4748 with SMTP id p9-20020a05600c468900b00410aa154748mr4375585wmo.7.1707762036997;
        Mon, 12 Feb 2024 10:20:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW6GhFLP0RYUFIqv4FxviLzDnj3+i8k6cI0ZJQVs9lcBlnR7k0P12kQyHfSbVNLh6GQD3Suui2Vme5wY6V7FGhuRPWkrEmIvqEZVEdX9IkRMKEgjof+9iwBG7LNHMc+xa0SXQSJ3M9B6fGO91tBxtM13yl+2ziE2Fdbfr/RP4Hx0rSV1eBhAm+TyVmlKbkv/z8uZWvlJU2OuM35D4Q2mcZFakG3jxhsz9Nc9bWtBjegmKEtNGnKojnLib48yS0ifRNgTtIkGbTpqA3i12/Mj72YuHc1RG9+wRB3lof5CHIU37bknEb/hCIGtLxyWaJVPDOteJyRqPceJtAHH3aD0iQBdGASnyhx5lzIiAlX2FBoB/KsTWJ7d4ED3XdpFIU9d6aZ1PdIdUW5UuMSZZSifKO+sRYHksP5PEXVetwaGKCaXkBHq1M=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id bg10-20020a05600c3c8a00b0040fd3121c4asm9389732wmb.46.2024.02.12.10.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 10:20:36 -0800 (PST)
Message-ID: <5aecbf4e-248e-4d4e-855f-b4f93af01004@linaro.org>
Date: Mon, 12 Feb 2024 19:20:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dt-bindings: net: qca,ar9331: convert to DT
 schema
To: Conor Dooley <conor@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240212105445.45341-1-krzysztof.kozlowski@linaro.org>
 <20240212-wildfowl-bubble-227ae356d652@spud>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240212-wildfowl-bubble-227ae356d652@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/02/2024 18:52, Conor Dooley wrote:
> On Mon, Feb 12, 2024 at 11:54:45AM +0100, Krzysztof Kozlowski wrote:
> 
>> +  mdio:
>> +    $ref: /schemas/net/mdio.yaml#
>> +    unevaluatedProperties: false
>> +    properties:
>> +      interrupt-parent: true
>> +
>> +    patternProperties:
>> +      '@[0-9a-f]+$':
> 
> The thing I don't quite follow in this binding is why this regex is so
> permissive. Is it not limited to "just" phys?
> 

I took it from mdio.yaml, because I want to extend it with interrupts,
but it makes sense to narrow it to ethernet-phy. The phys are part of
the device so I think they are fixed.

Best regards,
Krzysztof



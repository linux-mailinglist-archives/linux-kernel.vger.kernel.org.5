Return-Path: <linux-kernel+bounces-155458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C68308AEAD8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CAA628A8F2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A4D13E404;
	Tue, 23 Apr 2024 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E1wpsgM3"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BF513DBA2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885518; cv=none; b=PBcivhwQfUoGFpNDK0XohKWNmRTymEKvSdpDIQkNSeIAQTPfqeQh8SXQ9X4I+PD/kLaxySpF1MYmq6RuCRr4A337LLqlWiAXid6MaOXIvu1H2I5/kG/IZr29+aiLm8X/qRq6jdZl/n10+rJEd4WCn8E+GvOcayrWQMe2OTwaqFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885518; c=relaxed/simple;
	bh=XYG2QNO6YqfnXZsrhhpcAhYkSb1oPjT8GnOKwiKgNKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRR+a3hDuYA9Uf+XckLGrRMcHt3cgvvNm3ZChCj7GS5K0UwsY4T2wScOYbiLnKD9fIOJPf0P/GeFNnMArPmQ6ftwNhJNqjTnkmklODA155PDTHjy0peEh0/FKfrN7Xi5UbYk2F/s2eR6i0f/57MysYNCMzTe/XgYieFGc8bfTcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E1wpsgM3; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d8b2389e73so70143101fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713885515; x=1714490315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JKIjbUsgxy3/tNIq+MEZrr4f0H6IRWNYpVSuU9q6xD4=;
        b=E1wpsgM3mm7bJjnhLvAHQaq4xXZn131l8O7DpW2FU/1lPrQmNdFQpzFn5Aap8oEr2w
         xYYU+yD9CmiSMLy6Plr3uOoQUl1Thft1DxRvll8ssdKVOI+mxcvpfRlnARb7s81/Nwha
         AtF8EJRAgucq74yqycwR+m9umDZII45ofwZoC6cckbyhHdnbWKPySLt6SaOmPV/BRZyd
         QWvYOR3kuLG8tel28zV4czSbk7BKERFl7kYDlLg0clC4Zl3KLWYtOrSuazQCtR7y/Ydw
         V0xp3P37alWANsFPN77riqY0wr0R/vSIY0U4FFESVotb9hWdH9uxqrhEOXOzJdU6H3k2
         2qtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713885515; x=1714490315;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JKIjbUsgxy3/tNIq+MEZrr4f0H6IRWNYpVSuU9q6xD4=;
        b=SgbdJ36m5TQHM0VVwijIFvGV5lwv1LGIp5cubBK+EuKaN81db4DQUiZ2oZXJes8C8R
         0TcB2rsYT85dBpAiUrpjk1P8U+A7iCczHkEh4uM608MLoSO03Ly0HjkSKlk4fquAMVh7
         prUgb+tWudM1sT433x+zEywgMxM18V+MgfEIHJ7r3c7t9c0HqZcEpb22rQZ/s1aMNkPJ
         BTGup8vrkxIWccG6VP2Xo2C1FIGPHLh99twMoBJhvzXnu4q9LZFobLY215bisOk98yNH
         jYhf9NUnFAH/lN8qRkdMTcqlnrcwhJ941OsY3qUkOE4FbN0Y4eKMi4vVs2jVpC8kY0qy
         SWzA==
X-Forwarded-Encrypted: i=1; AJvYcCV8SMaiEyHKuW+nS+iZuyEMa2outtBaBmgHf8PBsh1v/H2cKwRd6IL/sKz6agTWkZKnDWqGbm74LQP/ihDHrUZBTMGUCPwi5crrD/QS
X-Gm-Message-State: AOJu0Yy2htTA3VE2Y2H/hER04lM+vLakrQWjGrlUIXvDwuhVj8M5u8At
	pRWmrVDe0rFYu7msR8fZtmbYbDqJbFk0n4WOz6Is4x4bUsMgoYLY1rgjqVEinWk=
X-Google-Smtp-Source: AGHT+IFCSFHPSy/Vj6nwpXpzfQn7qQPUjIl813fbivQ6NQbkaJ9fwKv1h23OgE4wIzRd4uGX6r4g7w==
X-Received: by 2002:a19:e01c:0:b0:51b:812:3c87 with SMTP id x28-20020a19e01c000000b0051b08123c87mr4738767lfg.39.1713885514793;
        Tue, 23 Apr 2024 08:18:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id m18-20020a1709060d9200b00a5561456fa8sm7148280eji.21.2024.04.23.08.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 08:18:34 -0700 (PDT)
Message-ID: <1065c1f9-8149-4fae-8fd2-72bda0b5288f@linaro.org>
Date: Tue, 23 Apr 2024 17:18:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dt-bindings: usb: uhci: convert to dt schema
To: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240423150550.91055-1-sheharyaar48@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240423150550.91055-1-sheharyaar48@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/04/2024 17:05, Mohammad Shehar Yaar Tausif wrote:
> Convert USB UHCI bindings to DT schema. Documenting aspeed compatibles
> and missing properties. Adding aspeed/generic-uhci example and fixing
> nodename for the original example.
> 
> Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
> ---
> Changes 
> v3->v4:
> - fix previous incorrect use of if-then block and original example
> v2->v3:
> - fix property declaration and if-then-else block
> - add generic-uhci example and fix prev incorrect example
> v1->v2:
> - add aspeed compatible and deprecated platform-uhci compatible
> 
> v3 patch : https://lore.kernel.org/all/20240422122125.455781-1-sheharyaar48@gmail.com
> v2 patch : https://lore.kernel.org/all/20240422093706.324115-1-sheharyaar48@gmail.com
> v1 patch : https://lore.kernel.org/all/20240420142108.76984-1-sheharyaar48@gmail.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



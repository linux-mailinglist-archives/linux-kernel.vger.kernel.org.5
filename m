Return-Path: <linux-kernel+bounces-98498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF64877AE5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 07:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FDFD1C20FFD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D458F512;
	Mon, 11 Mar 2024 06:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K6lxpN75"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886FFDDB2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 06:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710138401; cv=none; b=d6W8+BsQeftdxvqWPJEueaIwjsL9CQQ3QMEY6tKNYdgyyH0/BpQFhreyJFt3C1OnQOgI1QIGKnp6uLlMxpUUgqTw8Cbhui9QMuCLL5utl9dTSy73x8gW1hqMisfsliHi59R6pdIFmj4jenoIBkTOKDuPDRnl1PjD6gd3ezwRcaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710138401; c=relaxed/simple;
	bh=woBAP+L8tDsf5RhCXUB+Dtyyc0RdLUI1H/io8Jt8a4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nP5P/69LDuhkYKtS5j1yrEGkkuM/GfwuY1vGGAoT4t9NnccaSOXEgaGRHMeGLREw13HO6rqVGtQdNpkojRfjv8d4wT3o8xVfc8qbY9BQN7C6j2I/1z7nMJ0hWtV5o/WCpPd4Q5xy2DRmd1/LvjLu6K5tXOdItLmLbpEupmv0Kp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K6lxpN75; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-564647bcdbfso2692656a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 23:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710138398; x=1710743198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=95DFh9Zq64+Ua7LkMrb/Dol1luz0PS9eyPGG9NqGYkY=;
        b=K6lxpN75P/9y8pnGxRMw0EwoZY12oeocIvFlZpK9mKmHlBIiiBbGaY7+cFmS94u1hr
         ijyH4cD4bTlInZ2DyjyjdosYjrwhlZDpNEadqkqsN0MnxoPJkvIct11616RjByElvhjN
         /HmSqc29doarWJAl8LC5zZqJT63+cOxkM+z+hs5moqa2E/WvH9r4fXHkVHV9TzZ+zHUT
         wchLruHDa1zIxtriGIM8O/IPQefWK048LF1CKYCKnwhAqpOXCbeHCwx9dZ0uZk9FMLQH
         6LPTGVm0ifaJJz5xB/1gF3eg7DaoM1B0NJwfHM2cLwhx9jtfVUvgK1Zw5Mc+ofEo7ULH
         1BxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710138398; x=1710743198;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95DFh9Zq64+Ua7LkMrb/Dol1luz0PS9eyPGG9NqGYkY=;
        b=QFnGj3f5KVCclJh6J9pvtvPQhfsle+Y2VWFTPTr+gviYkYgl/qup1iARvDIv2CGTNN
         h/jB65GhAvzJkt3UajPAkqCGJ4YdxNWFZfbaMkxIk07TKMZkmf0rnDFfwTyQ7IC89IZT
         b51AIwjJ4G+eDNnUMXlqmNhLGt+DLHBhUoKsHe2OZghBmHXMihiHJMWg5l7tbOaHkUz3
         xyUvg6jCID15QQwVX9T8RjmjtzuWuxrdP43SuATH7RbtBOfrCDOMcqyTVfAXgrcg92bU
         oS/thjWNN+hOVqSYSPm+ankCbYLxN5kmOvaeVA5Dtfzy56jPgsklvgvV2PRw64uhl3Gy
         Hvqw==
X-Forwarded-Encrypted: i=1; AJvYcCWXpy+jCJpCFbNoohrht47jaKrC+f2HooFhZHiitBmwWbiU2Sb14v3KvpinVw5yrUjvO58+3wN+JOwPyVYGO5UQrqEkdU6vBhb+o+oz
X-Gm-Message-State: AOJu0YwXZjcw518C6T2wN3uo2SGCRp0fKBN3JrUwNTXc9rM5NDm7JVAI
	z6DG/tMBVfjAD+XqigY36DJ8559wdtT7w4JsS5SMiBs4EgtTM5p360E9AuM3cYU=
X-Google-Smtp-Source: AGHT+IFHE7hHrmss0voO5F8H+/3BdgAADjaBipQomev5Vfy5G0cYVDglUrsj40uawAIgUNKzKo7HaQ==
X-Received: by 2002:a50:9319:0:b0:568:1bd8:a5f9 with SMTP id m25-20020a509319000000b005681bd8a5f9mr3887272eda.33.1710138397989;
        Sun, 10 Mar 2024 23:26:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id e12-20020a056402104c00b005686037bc12sm510919edu.29.2024.03.10.23.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Mar 2024 23:26:37 -0700 (PDT)
Message-ID: <6597b720-4b8f-4034-8f0b-b67949ef5feb@linaro.org>
Date: Mon, 11 Mar 2024 07:26:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] dt-bindings: imx-pata: Convert to dtschema
Content-Language: en-US
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240310171958.96388-1-animeshagarwal28@gmail.com>
 <2b939f61-c8b9-4b41-a319-3bf7be42ba3e@linaro.org>
 <CAE3Oz82coV5RgcRE=Lj5mm2kjdzh3iFJGpMBBw_OfZppfWAHfg@mail.gmail.com>
 <d609c172-2bb3-479a-b5f2-841aed455bff@linaro.org>
 <CAE3Oz80zrnLvpo=YdBA-3PAtJFP8KK4LGHpEpQaMCacFFG13Qg@mail.gmail.com>
 <ba834984-d0d7-4b46-81f6-5a2df8e74944@linaro.org>
 <CAE3Oz8353cPXgZa3BhtjyfdFfu+XPUhHXf=qWxWQ7sbvVK7gcg@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAE3Oz8353cPXgZa3BhtjyfdFfu+XPUhHXf=qWxWQ7sbvVK7gcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/03/2024 04:18, Animesh Agarwal wrote:
> On Mon, Mar 11, 2024 at 1:55 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> What changelog? Read carefully what I asked you few versions ago:
> Below the sign off I have added changes done in all the versions
> before and explained why imx51-pata was added.
> 
>> "Please explain the differences done during conversion in the commit
>> msg. There was no imx51 compatible in the binding before."
> 
> ""
> Changes in v4:
> - added fsl,imx31-pata in compatible property as enum
> - imx31-pata was not listed in compatible in original txt binding
> - adding imx31-pata in enum ensures the node compiles to imx31.dtsi
> Changes in v3:
> - added fsl,imx51-pata in compatible property as enum
> - imx51-pata was not listed in compatible in original txt binding
> - adding imx51-pata in enum ensures the node compiles to imx51.dtsi
> - fsl,imx27-pata is added as a const to ensure it is present always
> ""
> Aren't these lines enough for the said explanation?

This is changelog, not commit msg. I did not ask to explain differences
from pure conversion in changelog.

Best regards,
Krzysztof



Return-Path: <linux-kernel+bounces-56700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EEE84CDC4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8815B28C8C6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBC97F7DC;
	Wed,  7 Feb 2024 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R/SiALUI"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEB259B77
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318697; cv=none; b=W1vvf5FZsHEnYppe0Xtpw11Bj+yEEkTMdzjvtfrgBIPXfP/iVj87vEsZKvEZ7hnWHf/PWWanJEmiKqY9wYrc0yzl8FplWG8kVVscAvGw9YiwmpDPQn1uB+kQitr7yNlLG7rurmQOCiVWjW6aZ45poO3Ogh/hiGb31JpIRkNrLro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318697; c=relaxed/simple;
	bh=NpStMwCvDk6+DFIzcAl4t+k/9yqfNwhqybVEfPEZJd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCSMBIoUHqRy1jGa1dl7WcTjvykuk3q1BDCF+rfxeBps+HZ8ZXb4N3GMfu9Mh6zCrf1iBT0hoEuJjFZOwD76rspCEa2UW4I55k8Cj9w7keHfKZB8jbod7GMO2qUamqSeex6vMZTabPxpXsknLC9BofdEohRTuQUHiUeTztVLvvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R/SiALUI; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33adec41b55so444406f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 07:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707318694; x=1707923494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Awilv/LJeoQrPlNq8IqEh5NNjUL2yw9niQAoG1MQmfA=;
        b=R/SiALUIXwdva+P7A2a7c0BY3gE152/MD0G/5XAIOfb6OgJia4Lrc8GH72ovPzsIJR
         n6u9uotlO7O+7ADDuAxt7kbLwtMhuIvCa7r1ubM7HzLZY4hUYWwhPnInpHVXCF2N6g0u
         4bMzIZgQVKxSkMRxzbVgpdF7UIS8HIahcE+gOi2O1j2cz486yQ9se1J4C7LJPvHHYg3L
         rw3VzeJAqjRWa9ijB0LmUWN/Lc13fHBJSrzoH4th8pWSyfDAwtv1Pmso60RE8PPcwB8/
         o+02iY1oSju08udqoVmxMNvXXw8VCfbCjWZ5HNo8ugZkD+39Nk3wh06xZ4snQMFST1sR
         8iJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707318694; x=1707923494;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Awilv/LJeoQrPlNq8IqEh5NNjUL2yw9niQAoG1MQmfA=;
        b=syxIZrkSSOPX6JzoMp2Zg9YA9RDiFXr1yYiu0zkEjphzZo/nsqaZJtaTKphbeYXpX0
         JWk6ty2o0L1b5WvSYFX3X5098t+TXkSk4nfGitT4UJxIgpAONERraEHzBOGaxyqPg9qC
         JqUsgUzVceblplpgmq9WHCxlN6z5MFuUy82A+eI1LwHNr9BlS4f3WlDBLnnTUVM3+5rk
         U2vMHSE2uW60xCYW/o66BAdjJnxRCybmCb9j4H+UqbVrfGUv/MpesTJnvLAf14RC6yAY
         Y6BWg3Dw16na3aFwB3G3VpYRdcygORGpTyJalyCklQWmMAgdj4jWcCCpkjYqwO3IABAA
         7FgQ==
X-Gm-Message-State: AOJu0Yy0CHYO3dysQAT+9izGV/D3FCtAxjijvv4BQVQvWiuRo+KRlyfF
	4nJ4gK2J1WX6NJLWvrm1VATnhHnSVa/Dz7GOnXgvXN0XG2F9bqZRADhZFwuzkU8=
X-Google-Smtp-Source: AGHT+IEvGd/xHfCmS0M7CqZPHpDerWULSPGgmBjH0z0hPi12G17r1CcsmbkvWlBqZPMnjxYt9Ulk0Q==
X-Received: by 2002:a05:6000:232:b0:33a:f521:7066 with SMTP id l18-20020a056000023200b0033af5217066mr3644148wrz.9.1707318694011;
        Wed, 07 Feb 2024 07:11:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVlPjkWYbguLAUaahW0k+ufOKqLDWUF0NAxAaK+2UfzaeRxaCmDB8FZfkmOeepTi7FhB4GGiN+MJ2E+hRw6YsN9gmUdG8RzQ4pUSO5QO3fFfdgDBsuPKbAuv8kQSgqwkM05y4sAiFM6f94GcKB8WIR1NArS6m1GZWVX3VVFIScT3jxDWPnRJ0yeznA/hL+Kwvr253H8H3SMf8bR0KSzj1paLdIJ5VMhIFTVs/0YPqvIicfbi7cnuBdU0TxDEKQZY3sRBIR4lWusCEE2qK9lTm/4D23Fx7H1uQXkEZ0d2F7iDivXI8PLlsKFoo8vxuyW92ygSRdXuExX3W5ojD9Ha0vTiw9Mh7uTnYYz6pwz12yxWgfjIaN+T3omeeejZ8ZAIOhYDub7DlcvHqCcHdIgDaY7zXMxe+Whzot6g8+Dl6LTBPMAvW7JkBnJgkxfOF5XzeEWb9p44Bmmpv8kfYZpSk02SQg0BX2dHMvtwqi3pmajLQVPYe42KsE/MgM5HS00OiBzzaf/x8PCP1l29ZTap/ENthn5
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id dr9-20020a5d5f89000000b0033b14f22180sm1784995wrb.20.2024.02.07.07.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 07:11:33 -0800 (PST)
Message-ID: <cd2c5ad8-902c-4ea3-8bb1-7f71f130bcc9@linaro.org>
Date: Wed, 7 Feb 2024 16:11:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: dt-bindings: atmel,asoc-wm8904: Convert to
 json-schema
Content-Language: en-US
To: Dharma Balasubiramani <dharma.b@microchip.com>, claudiu.beznea@tuxon.dev,
 lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: hari.prasathge@microchip.com
References: <20240207094144.195397-1-dharma.b@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240207094144.195397-1-dharma.b@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/02/2024 10:41, Dharma Balasubiramani wrote:
> Convert atmel,asoc-wm8904 devicetree binding to json-schema.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



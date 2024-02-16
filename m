Return-Path: <linux-kernel+bounces-68167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E568576BF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C97E91F249A6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E911168DC;
	Fri, 16 Feb 2024 07:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y0LM8AcH"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE0814AB0
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708068081; cv=none; b=VEKGO482n1bfq9R9pFVllmGK8UkcSYDFErLqe49hslFurGKMySLSXWd+Ntghnc0jT1E6uG3XdttR1PaOE3xThsVye4wTiGk4AdaoULfEs6FiMHscDreQhpppt+FC19GDomtXT6/jBWH/LzFGTtK04UFNT34nwHmxDZ1HXl1GXlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708068081; c=relaxed/simple;
	bh=gX9p21m8MX+SbMRzCymLaMq6MwZEtW703t+mFYO4i5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMdrbcHw4ER+dlsAw40KL1YNI07+sl6RyROedaCiq3wg3HEcwW+wPBMaWu3bVrLCHuATOLgenvCfhJWUqZaSz/CoGOlP4TMjVQAWo81qYHsqaDWKImsgMEvIbw+brOM29xNe/iBm5t2nNUVY56vY96q6/4I/oQBweRYOR/VfBkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y0LM8AcH; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-563d32ee33aso988974a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 23:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708068078; x=1708672878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fB3Mqq7RDGaMiv9Pbz0Ju/lXVI65oJ3f+b2W861EQjU=;
        b=y0LM8AcHNejljbOMKz/B8mSogwBTeztksnVCgnVgAglnSoZg/m7uWjJgJcBNlFKF+M
         YPZcvDnU8khDQ0eIy/J84wXlMv5Ca3S+o5BFZqHP7P+gi9mZrlNAf8yNr2Kjk9i/yNcI
         CSTcrsR2oC81nYofbAAUYJVYFFiTyXHEJc0FeAmYyeqqbyWqDWJJsVVWYopBOKGj3hMQ
         K2sW0k92tbQfJG1uX3owmRb62TVpQpvoLL3nXAACHYEHgejaHB6uZIQl8X/0XGviuLxm
         pvgGZVQQdXb+Ek8TOYS1KO75hwh5MwNRFjNgkIg84+H0WkOZ9ki9Y0ogUJO/UPFRzuqD
         JYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708068078; x=1708672878;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fB3Mqq7RDGaMiv9Pbz0Ju/lXVI65oJ3f+b2W861EQjU=;
        b=IXDxjt+bo3V41d0f1Cwz8i7QS7fijC2tYZhvDe/FGy/STuPe86Jq6WfnIfBEDfFyWs
         JtCDmzbCOsXYjsFK7NdbUP+rQcWdNhlrLbiYjKNiwYhb6VIvrLd7txa3crkznTWOklJa
         LGI6FH5gmNpos/FlhnigKd/ujhqQjzofEwB0qhThaJMnVBZZk9tuar3FJzDdlOQyCRTN
         BAJaTgUTFJMO5tffzOEj9tI4n0vaWvjUIzLVYNVU53bR848CjTWP9FS2RuaWfDzGo9kQ
         B3N2y49LeXor8LCa85yJFKsa5RoyqEMfPFZg4Nl0Nx1VBt7XJA2Pj3kXdoAkhdsbFpZi
         gxNA==
X-Forwarded-Encrypted: i=1; AJvYcCUta4z22DhWLSgwa/kQEQ8BLXewWgknMso9Co0aySifk1ih/KOZ5wDJTkRZugXqQtDbKg2uwx33NXl5hSXGLJwMFe6vw3aUunwYF21p
X-Gm-Message-State: AOJu0Yy7SNZpq0QkLYuM5zfuwSgoRG44kQO03TWfF9EDUvyVpPIVFVko
	x9FkJVqlyu6ZHr3OGSCQKRq7I6iUcuBlLBphZFXUy/uHP0s+YmrvkvhPKip2nJI=
X-Google-Smtp-Source: AGHT+IFKhdBtjw94Hbf5J53Qy+vp/yZBGAazXwz7ePR4Scb/X9+HaMbhYYAWPW7z5oiHC6GssQWJ6w==
X-Received: by 2002:a17:906:c417:b0:a3d:e2e9:a7f7 with SMTP id u23-20020a170906c41700b00a3de2e9a7f7mr448384ejz.27.1708068078417;
        Thu, 15 Feb 2024 23:21:18 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id tl21-20020a170907c31500b00a3dcab6f8dfsm455118ejc.5.2024.02.15.23.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 23:21:17 -0800 (PST)
Message-ID: <86a4d31d-80e4-4c11-9c71-e14494e3c8f2@linaro.org>
Date: Fri, 16 Feb 2024 08:21:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] dt-bindings: net: remove outdated hisilicon-femac
Content-Language: en-US
To: forbidden405@outlook.com, Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
 <20240216-net-v1-3-e0ad972cda99@outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240216-net-v1-3-e0ad972cda99@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/02/2024 00:48, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> The user documented(Hi3516) is not found in current kernel anymore.
> Remove this binding entirely due to recent driver changes.

Hardware does not change because you decided to re-implement driver.


Best regards,
Krzysztof



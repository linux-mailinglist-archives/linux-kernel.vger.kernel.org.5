Return-Path: <linux-kernel+bounces-157048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B130C8B0C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57F31C21FAB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B7715DBC1;
	Wed, 24 Apr 2024 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VKpwsVJE"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013EF15E1FE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967938; cv=none; b=ELyfASatZSyV0O+JAo3xd6gHXIunU+NJ0rN39Nyh35BuZxHUzP029IgHMKYGKtSwdm2Fe/Hn2Zk7rf4tC39Dci4+IYElsNp2gKFgfR69cJ33JG8KrlTWKKHnWdWTcjK7wKSUSB5VOuyeMMQh6ujWYUWqApMRTkjJTzwLxxBBQzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967938; c=relaxed/simple;
	bh=JHWDAlXDMHen4ye8Cgf64D+XKALvK+nD/KnFaJSygmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EIfaPGJRz4sBxXTrroh8zqQSlP8mb3xP2Pq57+2K6ONpEoaJC/M4SFNwt4gJMNapSzNkYIYpjYASbvaeWDj2QnLt7KZQTKPUQpDXRjW0S/H+uF9i+Iv8zzkV1pTEoXikMXGsPDKMKXBnhHbtCXDmcYl7K7lh5penbh4FEjXmuy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VKpwsVJE; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34be34b3296so244713f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713967935; x=1714572735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3zh00KAZtdWL9fqL/Gs2PzvIUPj0Oj4tDIo1Vf5qeC8=;
        b=VKpwsVJEHx/Q+Iy5tQ+gtNa6LIPT0ekOQEJmocM9IiZuwdQeJZKNylq8cBhGZRAVIL
         kYVvAG/I2OAY+dPeWxN2WDfGefls8mQhH0+gmUr7WJRBXLx2IhVGuFLDs55KfNRAvKbS
         iKSEdYDqv9efQd0lpyPbYrcsVJvP2vS+nAbI1xOmFMsTr2oMXGnrmtDNaV2ZB0c34hxx
         XQ3BclPEyBo+iC4oYZGovAOo+JuBPYn6SKWNR+D/q3HnpKC+FFP9X4bhWSfvSB2g08Em
         KYTgHXnLWcebWr42xnlH632k4xGTaiEgZMZFpX03scE9eNlBrpDNsn2QGMM/T31dXh0x
         DNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713967935; x=1714572735;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3zh00KAZtdWL9fqL/Gs2PzvIUPj0Oj4tDIo1Vf5qeC8=;
        b=A3cvrh3/52JRoCrxm/qU04JMEdYSKbLErQtZXTrC4dQS8mEesmSk23+Wd8Q0simoZ5
         BBkZp4QQAJnSavESfOcThVuwKdbNcUjumpKIG02emctULLHpHCtDqV7cnSjaN0aBsVmc
         Ezrm9ZV0mF7naOMbA7En2FjlseMAIv2J56QA4iCP5AjDqreuqPW+xRzLRH8ehY+KonGh
         /BCg/M+kmLMX/W3XYezpZsLK8EO22Gc+cPM8+KfXCqh1oaGfwGqOzdwZWrYEjqc9vxC2
         kQMhbIWrTLlOQ5CRMLEHH4hXmSk8N92mnrRf+oWhY9ZkoAdivfgPe/t8E5FRVKuuxK4J
         JBrA==
X-Forwarded-Encrypted: i=1; AJvYcCXKnkvJyOaRmLpFFvMolkMFJjoNJyDQnQ9L7Rq19FNCnQYwdkgfMtD/fgzMCDeHoQfm7YPdDccbg/yU9haKy0nnsiKaxHLq/OU+2WXT
X-Gm-Message-State: AOJu0YyAQK9epuDm0fHVyRIfBsIsxaoYd7yiB0287+wnE8qG5OkHCR3k
	vX57vG8OIiBcSGhfND96js9hVdpjp9Tre+8KB3vsZ/wN9Z8x9/DXXgJW3e5j/fI=
X-Google-Smtp-Source: AGHT+IG8yQJyvrtnTwlNbmHTTR7gHwykrYPCeKBeei6+S5iwv3E/DPqubFaiH8iH3FPtja9CKq4pWQ==
X-Received: by 2002:a5d:5702:0:b0:343:44b9:af97 with SMTP id a2-20020a5d5702000000b0034344b9af97mr2205042wrv.64.1713967935251;
        Wed, 24 Apr 2024 07:12:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id w20-20020adfe054000000b0034a366f26b0sm15620894wrh.87.2024.04.24.07.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 07:12:14 -0700 (PDT)
Message-ID: <a2af498e-5db7-4362-b3b8-486c2c38b8b2@linaro.org>
Date: Wed, 24 Apr 2024 16:12:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Add support for Blaize BLZP1600 SoC
To: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "olof@lixom.net" <olof@lixom.net>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "sboyd@kernel.org" <sboyd@kernel.org>
References: <20240424133032.19056-1-nikolaos.pasaloukos@blaize.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240424133032.19056-1-nikolaos.pasaloukos@blaize.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 15:31, Niko Pasaloukos wrote:
> Adds basic support for the Blaize BLZP1600 SoC.
> This SoC contains two cores of Cortex-A53 CPUs, one Blaize
> Graph Streaming Processor (GSP) and several other IPs.
> 
> V2 changes:
>  * Update SoBs.
>  * `make dtbs_check` has no warnings.
>  * Fix dts names and removed dead code.
>  * DTS is separated from anything else.

Your threading is totally broken.

I recommend using b4, if sending patches is tricky. b4 nicely solves
such (and many more) issues.

Best regards,
Krzysztof



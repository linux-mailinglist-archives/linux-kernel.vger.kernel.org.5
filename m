Return-Path: <linux-kernel+bounces-82786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 284BF8689AC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82ECDB215FC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F57B5466B;
	Tue, 27 Feb 2024 07:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GZ0okCMs"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A95B53E32
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709018098; cv=none; b=cAZYHD6DybZhzs8cEKg8bnkPrw/wHGKzJ5qRkGqPW+45MmqSWyPnJj4qYn3pSJc3aqUEnAW540R6wOKN1o4wNveUfwVk5zm+rsJ4J4tMw175YvHOoUuAkyRDOdfdhm3pnV7/UM+nnIvV1AEnNholVDkLhvsml/8FZ0tiiFTWzt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709018098; c=relaxed/simple;
	bh=5dgx8teHXyhrbYtjDzZ2zjeKLcEnVhLNenBcFEZPvos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXBcRzhDsyBIlyKhB3UyHMWCfDQKHzmIOxk8eqVwFjS2zlQ9E9TW4b3Km7fB0WPh4/RrkWYpW5xCn/sMuo9rbxO6n/3rCMxnlW2E31fcAk1uxj4KvTkgreQSeIIhbERwOyUMehg2QN71e/sWPpRQj3lrQjiFr40sxGgVyMPMaQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GZ0okCMs; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3ee69976c9so496513866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 23:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709018095; x=1709622895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZofl9MWRYJSXOfcFZP7d0qgJGrCZgB7SQ0M8fGFc0Y=;
        b=GZ0okCMsajWzGC1UqLspJZN4VgR++1bLZlu46QRIjKoYA51qz1/y2TOrIvKtKRumFP
         n33XECcEeN0xcDMQl83JsYDFYoY6kkmwnls4YfQcPxDAaS9VWOdyiYpimCHe/eeVAnj8
         jUhjT2I8xbJc2D/MhHT3lylCi3ZkiTBL28Xzku8lT2/XSchWtTb6I4tiRY2lMi/w+9GA
         kaeOv9UQvL5RTZ8pv0JwsECd6ZpNSv2UqlbvERUfk2Y3S0bBZm4NYW3+XHc75dVNhJ7N
         /I1L6FF6AY+Gb1i2gN9Bsj3VcamTn130nphb35OvkYzLz7KMSP8mp8t4x+tPsKdX7XCM
         4WcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709018095; x=1709622895;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZofl9MWRYJSXOfcFZP7d0qgJGrCZgB7SQ0M8fGFc0Y=;
        b=qKaKCGQFxsLL1IL+bPUIrqSznTeIEYEDOeyJiSeYtjVNqqYQsUxCgFdSD8W/7rcrAK
         mq1tQ//LG9pLqHpvsZxt1e6glDXqxr9ADvSInB8vp2UNPOgNCE8Qg+p8LYH4gYB6w7tr
         C6sS2K3HD0edlHGoLvBqTxL8fVtcI+EXAQ/Kd5eseu2T6u6rfFFg4NUHzZQo1k9Dh1wT
         YdH6jYxUAn/ZDDHJeKkGNo6DLZjwfU3hmiB6lUus0vxc7Ba6REOxcVpVoLvES4suZAqO
         QocfyaLAgqoFQObwjENuRkd0LRdKS77GwRZg5yboGpEK3DaTuDNdFz2ia1dxTOtOdkyP
         kmAA==
X-Gm-Message-State: AOJu0YwGI5X6l7lmCX898kkgSW+16tmvHWRLWvIxOu6CVRMJyHQ+0jSS
	SCDipXYftam8HPAPPcsXp9anY8eqt5ZPeSoWrHo4FzRhwvDYbGXsf3oTBsGXIU0=
X-Google-Smtp-Source: AGHT+IF6JwIq/66AaXhn7aU76AcRsywDSGqb0TZvLLqBK3GX0BahtgxJrmIEQqk+u50SNrJNI6jSug==
X-Received: by 2002:a17:906:b88a:b0:a3e:8015:ac94 with SMTP id hb10-20020a170906b88a00b00a3e8015ac94mr4989753ejb.12.1709018094904;
        Mon, 26 Feb 2024 23:14:54 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id ty6-20020a170907c70600b00a3f27031d7bsm470135ejc.104.2024.02.26.23.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 23:14:54 -0800 (PST)
Message-ID: <2a2c3200-3eb2-4f67-a471-248fbd25fa18@linaro.org>
Date: Tue, 27 Feb 2024 08:14:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/31] dt-bindings: fsi: Add AST2700 compatible
Content-Language: en-US
To: Eddie James <eajames@linux.ibm.com>, linux-fsi@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, andi.shyti@kernel.org, alistair@popple.id.au,
 joel@jms.id.au, jk@ozlabs.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, lakshmiy@us.ibmcom
References: <20240226165321.91976-1-eajames@linux.ibm.com>
 <20240226165321.91976-9-eajames@linux.ibm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240226165321.91976-9-eajames@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/02/2024 17:52, Eddie James wrote:
> Document the 2700 FSI master compatible string.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



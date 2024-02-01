Return-Path: <linux-kernel+bounces-47813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE26C845334
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D461F23176
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A381015A498;
	Thu,  1 Feb 2024 08:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KIkrmPZQ"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B1C1586FE
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706777770; cv=none; b=YdqwtLU9oq9PMUFj+wyGYAD6h+pD/1VYyikwgfoZ3/8EY3FfY5ZmNWVJJ2gehMpJKcJOVXZ3Rl54w6US0JrygU/VnTf0M0YulTq6btmw4DiltCDshnM375z8KoMGEj27TPhmnauhb2WIn2Ogt3YO0Vt48BpEZ1aSuhfxdWz22nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706777770; c=relaxed/simple;
	bh=RLkQH/GJxsJeVLwHLafLjvyrL5mb6HnKHTKR/Y9FUmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9Y8RRR4ns/NobEF+K2uFlS4j3mfSdUlXBnkYoe+7rMmifrvatlzQm5nXpo1Of6DCmWiBojJf5oWzrn5xlfZsEFgnTuriDM2cWVWsigOeOxcAxMbbQKwfzvGPNpWDgX9XSDbFFY+P4JtbkTQtCy7o4ADVoZvOkVoAWxr70zc8I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KIkrmPZQ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a36126e7459so66347566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 00:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706777767; x=1707382567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mB7vjw31zr2ME4ruwxSaUAFeK+9jaGAgfyv3NCi+5rE=;
        b=KIkrmPZQb8Mg1/J2bBiMBW90drD4uVYMeSMSt06Tq/zfFGRrHosrgvmFLA7vsplDkt
         JuRdesYBj1t9ccacStNBR8dMVN/5K2tqqDagZkLkyVPj1jjB2ofvmuYBv8x74mtB9ni2
         w+7QjtrVsXouc5Gqby+NQMpFBYvwDiQvkuiyI07fFJmWkDjCgmKPWIEa3gbOyyYHA//1
         /+hE4fblkxidN++teUO4/XJCxRg0Pu3NW9/rtKpp7GYlaIllvtokDKDx2H/+LyxjcZQe
         FuaZyejc3i44Myr34unA117kCOZWqka6MjinMKrUUkVspRJlvjpfOghjQYqoJci5Q7rc
         5/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706777767; x=1707382567;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mB7vjw31zr2ME4ruwxSaUAFeK+9jaGAgfyv3NCi+5rE=;
        b=eBhexsiCyy10C35rhGi3xt/MHIVKu1XrL77UhPrdW3TSS1n49y6uQ/Qtnuo23Mu5hL
         PyIUp8vYHVMRx715uKjzdrCAaJluNRVUQ7b1UegQvbUp/ricNvwxfEp4m3WrZoQFJ4eR
         qVXs2IKEQLLccvy9A4Rzy/qWvTstUJy/EQvvz7VjHpmmKXyXApqhb1yWU15xozMdNZpZ
         oovD8iElbYki9ltcjeisvBefoW13u2a91/5bqfknL2HuAmLjo0T94Rw+8tR7QNYNJhpo
         tcGcbU0omUTUWxnLTg8qcgJgOlZmSfC8BI2lYtbqVFBPRsYw4RlmNNy9YoHia06jL9TF
         i+YQ==
X-Gm-Message-State: AOJu0YzgZ84cgvrN0bJuBQWBn7AIeF4nmZiw8XnmMOyjXtyMT2OWUbY2
	/FJ9gye8Nw4HJmCF9bWBps1ou+n/BLizwlGcHEx4p7g8YCcqqoMqgo4P/Z8Te0RmNXnnF/enPO/
	b
X-Google-Smtp-Source: AGHT+IEvk+ikpQ7EL9PeouXhZZ76oVWxuQ3rVJls+FGmPgsN0eFbbz9cMFGZANeF0vrFUzDStHBUDw==
X-Received: by 2002:a17:907:1110:b0:a35:b808:8f1d with SMTP id qu16-20020a170907111000b00a35b8088f1dmr3344089ejb.67.1706777767458;
        Thu, 01 Feb 2024 00:56:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWkt1xBZa5iosvZ6ourmNI65ZeYwDUNROjacpmLSg8vas4us+XlCfwUaVPLGInDDfmEDH+mM3hj7bCCpxOKH8+P6naBnNnI/GRBf962MXWkbXRs3t6806RF2HO1JgKHC99ESU5EkBhrjFe8mXsoXEr9u1PKyesUjQ1oZ/343YkjdRwDNdB/Fb8gEkDFe/xaReBJ3/ObXqm5tefuJ+2LFSO63AdRJc55GuaKhPs2CWtOUiAGwF8DRvy/Hfa09YhE/Datgkn53PH6yHO1UxUMKT1qrbJbjgOR41YZnrfNOyrjTGHjBOBXPrPx3orMjOEbFqegwN3AOls4t0OU3tvvkvfxiAtB7NpvXa3FXPFwP4i2mJFzB6OF63j+8TPZBloEanLk1cON2EVGc6tnZZIgSIWaZx2KtZrter/o/+G54QywzPQCNCFoj/NJ/yoXUmvAu+dPRgu1CTaQejZhsi5fKAtUiJ15dsKm7dDenSywes5Cz90OJZyPdnQFQ3HVyy9x0ZEmaWsZoRbRxPuwwRYVARjPkE820Ll4x8utID1XuZT4UK/zanQHu/pO0MhrXhJvlK3B5gUE
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id o14-20020a1709061d4e00b00a2c70ec1533sm6927297ejh.66.2024.02.01.00.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 00:56:06 -0800 (PST)
Message-ID: <821ce1d4-bc15-4764-bbe0-315c57e8536e@linaro.org>
Date: Thu, 1 Feb 2024 09:56:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] dt-bindings: input: Add TouchNetix axiom
 touchscreen
Content-Language: en-US
To: Kamel Bouhara <kamel.bouhara@bootlin.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Marco Felsch <m.felsch@pengutronix.de>, Jeff LaBundy <jeff@labundy.com>
Cc: catalin.popescu@leica-geosystems.com, mark.satterthwaite@touchnetix.com,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 bsp-development.geo@leica-geosystems.com
References: <20240131141158.3350344-1-kamel.bouhara@bootlin.com>
 <20240131141158.3350344-3-kamel.bouhara@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240131141158.3350344-3-kamel.bouhara@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/01/2024 15:11, Kamel Bouhara wrote:
> Add the TouchNetix axiom I2C touchscreen device tree bindings
> documentation.
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



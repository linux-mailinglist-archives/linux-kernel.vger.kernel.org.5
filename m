Return-Path: <linux-kernel+bounces-44907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7760A8428E6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0981F2AFD8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BA286AD8;
	Tue, 30 Jan 2024 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xQ64RXv3"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C8F86129
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631133; cv=none; b=jj1WUQWBdXETGr0TU2szkmRBXOObFwmvC1NjrNti6ORyUB0HBFZAhwqjJcWGN07S0SQ6Fhfa121WTdp9IoIfH0ODOkMJN2IbCCXQzkSoCj9xX/R6L/zd9FOR69mLjYQnLsgaAsEfC3tZ4nWCDRBOsQ269lIy4V5zVSIMQ7q1LN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631133; c=relaxed/simple;
	bh=Jz5sWsEbs/CamPCf3wN/rI0j9WpIGCr7jEjgoj3EzDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZvEJbXoKAfpI1iWUKhBJLdgTPsDagcq4Q1YHU9dTkA8qRifvr6TP/yopwRxs5u04ISlqgXyRGHqDxx5mz4h+eWl1FXG+PZok8vvVU2RjyibqOCW5YYJqDIuyU7dKfQ0O2O2cJKtkMtOzfrf8U13y0KmFtd7uEhWwLkVrgOGtwYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xQ64RXv3; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68c66c6a234so2134646d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706631130; x=1707235930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JAbLZeFXK6KxvOS3fa0sDwiP5CSWEuS4DDu7f/RUmGg=;
        b=xQ64RXv3Dt2vrQTYwiG6uZEgCchX4gQel0ORenvUgR/5jdT5h1S0OMicPy+iHeA6tD
         LUpaiR/3kBqs8IGIf1PE6OIDP9nIgow17rJFlUieBtjl8YPKz3i7/Q5CCNPA7q0UgI7F
         9e8w1Re5qe/gphfUuwldLxNdQbKG/gfZIrmAyCLShZjaYOWanFLRwUYb4bcq+CHKMjM2
         VIn0X1gigVcxRzlxUDnCvgtiPh7lJea7iKB5d7ziEhJce1kJP76FNI3Y8mvUnWm08V/+
         d6W42T/Q/DMpGE3yivC/rJuQMpbMvmzL5S9xWX8buUmS6opbzsRi6PM5mXg3vC8lN9GG
         0I/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706631130; x=1707235930;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JAbLZeFXK6KxvOS3fa0sDwiP5CSWEuS4DDu7f/RUmGg=;
        b=WJV946UM+OjkJBLVJizW52BV7AMw2BGnVeKOO9fhJ07f1Lq6ewUaJ0JU6DJ1/nATRM
         zK0LfrbSAK+NpjcxpYgwYRWjvnw/u/8kmTPBcxQMLZ7ypQ+/N7q5NdOuIopY9Jb1J856
         Ap2EbhA9XEajqyNu7xJ5ZyNnLsg7NWFAWvuuDb5nBwNCjMeok6K/o7ydHnezzvbek6sW
         ejChlhbyJIz5zfyux7HgLVohpfUvgn833vm2bNZlIWKAHSkOVozHLklG48L1jd+3UcHw
         5SyGIy0RwLxaOOM7vsezFhzEjYijuX2yqwLsMtT5s0q+wnuw5BV5T9Gw24GcbeEceEc0
         b4hQ==
X-Gm-Message-State: AOJu0YxMwI01f6KuCCH7kJ0Jxy7/cKMy6lTHMEUGofMqNXCeVqo92Wad
	3/YaxWvEnqn+wSHRiVxhtEBoFokonPa5PgUmqlPBhYzuFXccYvp7PfomPadonxs=
X-Google-Smtp-Source: AGHT+IGHoVfiTwm16TgEKlNIex7QvIw3vMePhqWSt1NeiOPj7Zz/HrlnDQubBDorLG3N8EMBTuvJqg==
X-Received: by 2002:a05:6214:acb:b0:686:9663:ae32 with SMTP id g11-20020a0562140acb00b006869663ae32mr13548911qvi.63.1706631130551;
        Tue, 30 Jan 2024 08:12:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXLNUYdOl+Rw3gc/0u64OQVJtRz4hojgRgVhE7Gv6jja6yYrejfiJz75YkZlQjNKhOiPXb0Y7msyQB1wpM/LDGtRFDGOUn2eydSHse2tvFNlfSsulAvlnnnPzzkBbAYbuI+g8H3wIvFiWo8V7ik3jTD58UV7/8CFyud+x4DUrPlm2lIh857U8RNjTeEcseTPnpVZyHrGnsGApvK38o4/F+G2z/uRlbeP3KBP48OX0jbofGnIe4NpG1c61j6p+1+fyX8ZgRmaZ5/0JuDbtwWj9H4mKrLw6v8zwKqXStm1w+SGD2xYNoPtDTfy+q19AxW0nA1HFcb1z/oAVhX81KgA78TU8sbCMC3WI561Hg5TQcA51M8I24LnRfJ/8p9VLG99THRyysveQ==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id qp7-20020a056214598700b0068c39b7a7cfsm3845337qvb.12.2024.01.30.08.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 08:12:10 -0800 (PST)
Message-ID: <fac9c37d-bb0f-4157-ba34-26b215fa2387@linaro.org>
Date: Tue, 30 Jan 2024 17:12:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: mfd: syscon: Add ti,am62-usb-phy-ctrl
 compatible
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, nm@ti.com, vigneshr@ti.com,
 lee@kernel.org
Cc: afd@ti.com, kristo@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, srk@ti.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240130154035.6901-1-rogerq@kernel.org>
 <20240130154035.6901-2-rogerq@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240130154035.6901-2-rogerq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2024 16:40, Roger Quadros wrote:
> Add the compatible for TI AM62 USB PHY Control register. This
> register is found in the TI AM62 WKUP_CTRL_MMR0 space [1]. It
> is used to indicate the USB PHY PLL reference clock rate and
> core voltage level to the USB controller.
> 
> [1] - https://www.ti.com/lit/pdf/spruiv7
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
> 
> Notes:
>     Changelog:
>     
>     v2 - New patch
> 
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 084b5c2a2a3c..b5f27cc2917c 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -73,6 +73,7 @@ properties:
>                - rockchip,rv1126-qos
>                - starfive,jh7100-sysmain
>                - ti,am654-dss-oldi-io-ctrl
> +              - ti,am62-usb-phy-ctrl

Please keep order of entries (so 654 after 62).

Best regards,
Krzysztof



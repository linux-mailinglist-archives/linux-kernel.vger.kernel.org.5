Return-Path: <linux-kernel+bounces-133302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D3589A1FC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249201C21FE4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DD916FF5C;
	Fri,  5 Apr 2024 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uO9pKL5Q"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FCB16F27B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332645; cv=none; b=ECe8Dt+ByiJfj0JuG1h55dNK41fxC+zMss85m644rNdeQvwg4A2ZSzdYJapZLu4mt8yFaCYa+1xal3Nn/STPT/+A4ICZBqGUdJcYRzDY1xPP6DVLOZz0cQsiYPofYALhtIBmbVF1MyBjA5kR67MZ+YfaMGNh0benUArI+ZuKN2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332645; c=relaxed/simple;
	bh=z3Rimi7jzpMWlTiHBYwSHESyJvpSlZW503BwqamNhdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQ5X5Z4wZQu0SuUpOFysQGmArp81jtpNhIWI93qCAm1VZAxS+zvQ7BDWGPGvr/Dbln9SpPON1fVB8hhwPFv7f3HZXn840ENw5IKuLmn7f+6KiB7t9EY0eTVZC2zHpNTTTvY0C3NTFLiGlYYKGIbV5eZ0cJVpMdWBqEBDrj01lhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uO9pKL5Q; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a5199906493so181224966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 08:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712332642; x=1712937442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mKkipGSap3V6ea4UiOGlmbzb7FNgkBvFxP98TV7aYLU=;
        b=uO9pKL5Q+Fn9cOsbh/EZdO4NfTVqE2qOzaL0NpiOZaqNuWZAQ8W9KKROS4rGSkWIWk
         jzgZti9XFoxW0Ij88KvSSQjWc7CwIvCySeCaxtYzUe6dDK1EuoFwMQ2Lo/qKUmX2eLZT
         DYN8SkLSqy8RZGS+3auBr6e+kra7omVquk4OD1U6DsB+41SDxcOxUZIC6Y+5wQRnDlcf
         XyXYdgr7qH3JLW9SWtvP58SsGDXQMakagPyBeD1xNYhQTshOzDS714BEMjdR8iJC/DQK
         851F/qzgCGAk+6R4jiX4Kc1tiJ9/sZZWo3Jp/vMgqvn5gpL3u9s5xGh2XWWaxwIoF6X8
         mW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712332642; x=1712937442;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKkipGSap3V6ea4UiOGlmbzb7FNgkBvFxP98TV7aYLU=;
        b=QSUO1YhS8/rVwTFnPMGGkzA1CuRh3xJIt4L8qt7mGHQxZVm6IpLorjDFwe7owMQnff
         /aKgn2AgczHb9HYnPp4UE+eWm4tnt/eCPHlQJliAKuXnfJWrCdu89/dYXzIgFvP7JNDl
         yBzox+fZIpd84NoMXv7okCjrLp7ekn5coa0kIRI/g/TtnZ/pvZObjzBJ/8GFIpvSjC49
         KeOG4bI81fkEXHtiHUOpsP/yC+d/FEIfe2eIqb6peqIneJ1NacWZpQaQQLKgJbcqKzMU
         gfhy77OPBpw6B6rft170o0u84wDLYDtoICXDg8YSBI26m0gKOqibW1IIVMkMQfeIq2nI
         YC2w==
X-Forwarded-Encrypted: i=1; AJvYcCWxdaS98jDPieXy3ntOdHhBDCpE6k1aME5sjzE7q/9gtutgCV2q79bG4T8OdWfTc8auuRUy+0vScAliWEqQl1jhsuBo4FQAE1IG72K+
X-Gm-Message-State: AOJu0Yw3v7ORo6fOdaJRwGwCgAvxm+m93DSNe/6wjmr9ln7x05tVHxHW
	XNrHfgkDK2Gd9ZGXUbWvqjoXO9c/jWP/uc+eM0dgKJG199vbfFReBcmfMwP/Cus=
X-Google-Smtp-Source: AGHT+IGjhvATYUztCqWkZMJcrdWOwv2T7iTd21lfPbduEPI9w0ewiLk5LX8czXsHTruTvausR3ZKyg==
X-Received: by 2002:a17:906:3791:b0:a51:a329:cd76 with SMTP id n17-20020a170906379100b00a51a329cd76mr1279322ejc.13.1712332642140;
        Fri, 05 Apr 2024 08:57:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id qx25-20020a170907b59900b00a46caa13e67sm968388ejc.105.2024.04.05.08.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 08:57:21 -0700 (PDT)
Message-ID: <ec7f77a7-2cf1-4ea6-b9c4-d4fe8a1673ab@linaro.org>
Date: Fri, 5 Apr 2024 17:57:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: omap-mcpdm: Convert to DT schema
To: Mithil <bavishimithil@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240404160649.967-1-bavishimithil@gmail.com>
 <78091796-fd0a-42dd-a4da-f7bed3025bf9@linaro.org>
 <CAGzNGRnuG_gLUrH1N57WvpKbpiNtFrcsG6nJcacQNJB_yMYNrA@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAGzNGRnuG_gLUrH1N57WvpKbpiNtFrcsG6nJcacQNJB_yMYNrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/04/2024 16:48, Mithil wrote:
> So sorry about the 2nd patch being sent as a new mail, here is a new
> patch with the changes as suggested
> 
>> Please use subject prefixes matching the subsystem
> Changed the patch name to match the folder history.

Nothing improved. What the history tells you?

> 
>> Is it your full name?
> Fixed it, my apologies.
> 
>> Filename like compatible.
> Fixed.

Still not, compatible is omap4.

> 
>> Please open existing bindings and look how it is done there.
> Changed it, is it fine now?

You mean v2? I have no clue to what you are responding here, but no, v2
did not improve much.

Best regards,
Krzysztof



Return-Path: <linux-kernel+bounces-71002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F26F859F3A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF08D28103B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE6923766;
	Mon, 19 Feb 2024 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m0Hl221J"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB9623746
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333598; cv=none; b=uydcM5AqJYEN829YKJEf6x6xAtIrWJabzhga+IWF9r/Mxo/eGNciKldsEGiPioyY9H95hhJO3Vplz07PFJGZXSPufKfFoCF59BUDgt1rovlP4X7SnAY/uegDbIvTWk6BSZ5hGK1MUxs2RYRLUXnjX92Vyvr67trUnaehIL7IXwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333598; c=relaxed/simple;
	bh=gm12EEsec1XU6vdLLBDw2ZcT1t0fwEKSLeI1NjHfJvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LiDJBlOkuwVhM2/dfKODIkJ0zedHo0VsUd+y1IfK7KPhNxonETFgmEePMD3kyfLJMYt9AHbp9rktMy5MdcBOh9IpVkBDA6Rt+7JJOVu/Pr0O29R5izhglXX2FIF1OSliT2AOEtkACnj9dgZRX0Tt8cvYIyjZB+E2hNRFcduVY5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m0Hl221J; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33d38c9ca5bso624661f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 01:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708333595; x=1708938395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hfO0qqe3wWMOTMMAVQM2mr03BWRL4if8K5v6ah+tKAg=;
        b=m0Hl221JohtEAryFA9nX8YgHT2f6zPgcswMqQYjZwmbBrhGKtr+JhaGoZWY5JpYSE9
         z8WC2zVUxBoY37L6SmVQbl2QmL+nboLqSAV8iQXW3yt0zAoznIkrFU7g2QVWoNrKWq23
         P05buItLVrRkWlDOL+xShk4kXGYmRTB+QeXJE2FzIRxUC3WLzZQrVckEzOajnTlYieen
         3Ev+Ct8K0py6BRACHdUi+8wFsbDemJqGd+thFC8huWPpakAa2ShcZqE+CHdKgFp2QiQa
         LVAOHVyzbLBzWuX3J90K1e3kYmU1lihHwCEDFWbYsyRWXY0h6FWrprlGRkTE7zaR/NCB
         L1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708333595; x=1708938395;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfO0qqe3wWMOTMMAVQM2mr03BWRL4if8K5v6ah+tKAg=;
        b=aoGHRksxfXUPRVuI6S6vj3BAdwQYc+mEByoEIB1hctWIrbZZ1NHtO4QWtMglq7BNOq
         ksnOryS118dS2yR3+niflkTEzMfedLKMDtAd+QT/seIJ4hnGrYVceVnf6lfK9udKTGOJ
         /XE2d+Ip/nzgExkwxETrB8Ec2GD/gsEUopwA1enr2Fjv65PlQbpdm0f0t7RHBB23/gbd
         y61Hudj4XrEFWZ/8mFqmKMWoyhdehjlTQXewmiga0zfxEZzogUQtXNeMqKSFymD7seUp
         OsLAc5TRx4vJ/3ZEm5p41hFTxsJ0yZ3MoMNxvc+3gunHvqFyHZI4yTPGzQJgZMXiuJTs
         nXnA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ/tqMNuow9tFSYLGNASxfF9FJLciGWk4UbaRve49BWo7yZlvnRzHGvG4QsTy1ihYWTIlVc7mVoq89q1vYlPgCrI8jnW0WqaFTfGQj
X-Gm-Message-State: AOJu0Ywuo+xkOZFlqTma7XVBv/wFySANSciqw4fM4C9mpw268AjajgQH
	a+7VJM3NeLWFw1dxx0SbrsCCwb++SKZcydPs7eUgLnyx1Muokv48YQ2Oar8UzCA=
X-Google-Smtp-Source: AGHT+IHAhI2sUb2Mudtx+wU42TiWUKdglMF3z2hN/Yb/7ARoaTlARAaRqy2hH5hUhrZlS2FwV0X2Ig==
X-Received: by 2002:a5d:56c3:0:b0:33d:32fe:1978 with SMTP id m3-20020a5d56c3000000b0033d32fe1978mr4025388wrw.17.1708333595155;
        Mon, 19 Feb 2024 01:06:35 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d4c82000000b0033d07edbaa6sm9725160wrs.110.2024.02.19.01.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 01:06:34 -0800 (PST)
Message-ID: <72fffc25-33f0-4394-b7c1-8dbc2d23a4a4@linaro.org>
Date: Mon, 19 Feb 2024 10:06:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: arm64: mediatek: add Kontron
 3.5"-SBC-i1200
Content-Language: en-US
To: Michael Walle <mwalle@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240219084456.1075445-1-mwalle@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240219084456.1075445-1-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/02/2024 09:44, Michael Walle wrote:
> Add the compatible string for the Kontron 3.5"-SBC-i1200 single board
> computer.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> v2:
>  - convert enum to const as there is only one specific board
> 
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 09f9ffd3ff7b..add167d8b8da 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -357,6 +357,11 @@ properties:
>                - radxa,nio-12l
>            - const: mediatek,mt8395
>            - const: mediatek,mt8195
> +      - description: Kontron 3.5"-SBC-i1200
> +        items:
> +          - const: kontron,3-5-sbc-i1200

And then it should be part of earlier entry. Just take a look there in
the file...

Best regards,
Krzysztof



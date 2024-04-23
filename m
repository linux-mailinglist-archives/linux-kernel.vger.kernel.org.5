Return-Path: <linux-kernel+bounces-155556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C808AF3E0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1646A1F24DAF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4E313DDDE;
	Tue, 23 Apr 2024 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QWwJv7b2"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEA013DDD4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889434; cv=none; b=W9LHk2j760//0iDmGSJX6uKkpmznwXcJlL8KjUpWaUTmQZ/0zpG5qQNx+hfRJPz7BfnAXDmj9DL2qJT9eFJyXiIV8pg1DMeFdq/Fbq2NikNfaL+Gr7NaXUumcGlEvP/j9hAUJz0cr6HlKplvs7aWOQYeI2KQnoEGWAaPesheu1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889434; c=relaxed/simple;
	bh=7DGRS56GPjR9jN13G1hcYN8IQqXWrcF2dE7DU0ubnPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VwW7HAgeTL6gug/wSqC7jmTOCDjE4gIil00whOkVocW6qFluZHLU7ccYSgoHDqDUkZm44Tjrs4xo/NNB2yJmru24MKnSsgvRRHBToa+IqgTX+RdTfpN7YxFXK44ZAxc69bJQXLZxjIr+q1U0mTs9BT/LHKUXTfOrTNtTkL1KGx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QWwJv7b2; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-347c197a464so4354124f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713889431; x=1714494231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bJvOdPBXFk/bDuzeH+zHs6VNJH1qJlIWX1daArUf4O4=;
        b=QWwJv7b2qwAtHWw/JdG9BxoKB8sidZL3Yadii+tK7jhzJwzWEurYyyt9Rg+vC5e9jh
         H71idGbJwMI3nPgUmUP1TnrhaYXea/RpY0kFxY9SR/vm3kadHzED1DQCsfrrGNbhwpQ6
         20y1voQA+P5GZ2pnf8D/rCDfJnAAOpythUkCZmxv+WodLbXaAVIoedHKsgCDFfjooW7P
         CvIgFjgRTcpYAqpy9hRLE5rOVTlSVe5Up6T+yyNWjf0+XzLdplqv11xss1BO7MSMoROu
         kG5HVHiZsazYk3+aTnMkKD4TtnL6Pa6/MLUu1jgGlia3AOPGkkc/xgEHL5lJKG7UadEj
         u3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713889431; x=1714494231;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJvOdPBXFk/bDuzeH+zHs6VNJH1qJlIWX1daArUf4O4=;
        b=v7PVXiRmvbTxlHvEB2lKlDcuwFGxqW8KivMEtrRVpDIEAIyHwHcYjVELnUaptHHfDm
         jCoNrTEARitRgyE1xU//q04/elQwMVBa+X6NsV1Q0OtWRUJ7/ufjv1Nrodyot3cgWxIR
         5eDyAG9Ul1k9vwOuhlrGiIzw73JENnD/hAxb8VZPxPp6EdXFLWyMNtFGv0aCv/Z9gP89
         9nmfns65Jksq17DWQus9NgSAsm0KetKt6xIZ50GWiFbyMe77+JEIpSVUTy5Zo+GqIu/v
         JsLgP0g1dNDXOPsRKeiRmHaAJ9MIU7bIQIBved2pBBt8uWxy7MQSIykAlU01ExR4TYUZ
         y5jw==
X-Forwarded-Encrypted: i=1; AJvYcCVaPSSA47QOzO0ZBZ0s4VQsAcMrdyyvlAkn0FG3LeBQtYavuWcJdYkJ86WCxwG0QeLnypFAIAp3EjqZ+z2qjQDXSXmD2eSKLHAdg+I+
X-Gm-Message-State: AOJu0Yz1H8STbGbEYmsIXysz5WmntukGt4pd0LrcuDkhCAroOIzAx8rB
	xIAeQdHbE0O1X8mqyhSoJQ20a5fGB4Xt7/rgRg80x+e6FqluP7GU58nvCT4V2ersvdYvLysgaRG
	UBEs=
X-Google-Smtp-Source: AGHT+IEdQcLYJ/QzhHJkBdgViQmdOJxYR4LUOX8SHs7WRJuCBg3gtXdcaG+Enk0mXe9WOnSV80W15A==
X-Received: by 2002:a05:6000:1950:b0:343:bb25:73d9 with SMTP id e16-20020a056000195000b00343bb2573d9mr8367158wry.22.1713889431029;
        Tue, 23 Apr 2024 09:23:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id f8-20020adff8c8000000b0033e7b05edf3sm14909968wrq.44.2024.04.23.09.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 09:23:50 -0700 (PDT)
Message-ID: <d1933c48-ce81-4b29-8290-7ce0c8ecbeb3@linaro.org>
Date: Tue, 23 Apr 2024 18:23:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: HID: i2c-hid: add dedicated Ilitek
 ILI2901 schema
To: Johan Hovold <johan+linaro@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Douglas Anderson <dianders@chromium.org>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
References: <20240423134611.31979-1-johan+linaro@kernel.org>
 <20240423134611.31979-2-johan+linaro@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240423134611.31979-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/04/2024 15:46, Johan Hovold wrote:
> The Ilitek ILI2901 touch screen controller was apparently incorrectly
> added to the Elan eKTH6915 schema simply because it also has a reset
> gpio and is currently managed by the Elan driver in Linux.
> 
> The two controllers are not related even if an unfortunate wording in
> the commit message adding the Ilitek compatible made it sound like they
> were.
> 
> Add a dedicated schema for the ILI2901 which does not specify the I2C
> address (which is likely 0x41 rather than 0x10 as for other Ilitek touch
> controllers) to avoid cluttering the Elan schema with unrelated devices
> and to make it easier to find the correct schema when adding further
> Ilitek controllers.
> 
> Fixes: d74ac6f60a7e ("dt-bindings: HID: i2c-hid: elan: Introduce Ilitek ili2901")
> Cc: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../bindings/input/elan,ekth6915.yaml         |  5 +-
>  .../bindings/input/ilitek,ili2901.yaml        | 66 +++++++++++++++++++
>  2 files changed, 68 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/ilitek,ili2901.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> index dc4ac41f2441..3e2d216c6432 100644
> --- a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> +++ b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> @@ -18,9 +18,8 @@ allOf:
>  
>  properties:
>    compatible:
> -    enum:
> -      - elan,ekth6915
> -      - ilitek,ili2901
> +    items:

Drop items, that's just const. Or keep it as enum, which makes patch
diff smaller here.

> +      - const: elan,ekth6915

With items dropped:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



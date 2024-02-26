Return-Path: <linux-kernel+bounces-82065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4A9867E90
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12EA1F239A7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48B012DD87;
	Mon, 26 Feb 2024 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hc63XxRG"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520C012E1C2;
	Mon, 26 Feb 2024 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968703; cv=none; b=tAUpaufY9Z7iSknEJkhMLApHdT2XZtlkFi4GcoEy8uynUI1T79gH0BEnAqa2FSffXcQDpCz9ESpB01GoKUTEyVibs4Vac6gjuSURuthfT/G1Kzrkh5DAhESn4C3K0VIHFV2bmy+2RQto4VdSzzEL3e+F/T0ooeXH/doIyuAgk6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968703; c=relaxed/simple;
	bh=JqR/nbtraPfs2ZLthyKJWlx6wGyBAgMXjbmnp7oiyqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eon/QGBqlWhG/ioljTsq2PHx4jOaG8ivz6nghRrgGduMPPZWdVJBaM4UVF08YwrxS1FKh+9KMkQSLAGONyJVbXIfVrhj9lNA0+FxUCXg28gTJi1yGErKz6hf/X/gEQo5nS6VszS4UNZDxIEvVMZJeNRpDhMUqI+3u9wC1/tnjDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hc63XxRG; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a293f2280c7so483330166b.1;
        Mon, 26 Feb 2024 09:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708968700; x=1709573500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WU5hdSHBzbEr/EOa1is0WCLMDW3bS3kIX0rAhn0rg8=;
        b=hc63XxRG/aoe5/LDhNndB7QhPeNqmGHnf41gu2Qf/mfPWZYNgXoqRwEV+tKO1Lxd4C
         a592ZiyGmXNuQyDlAlIPdJn7XL9rNzLobhMOToe6qvGuTl3ZLrnwuH1hPTf7rAgQaEiI
         jOkm2LVpPz9ZrijkAJVal/7ftMWkDM+PlzqOgyRkiQo9XShIhcjuAO5YrI0iloMMQp9K
         sgsvcy3VAqln+K+Tf5ZONBuIc1c7LExJeqH5j9k7XQjourUmkEzeMHuFf1u9rrb7fi/b
         Db4YTFgWAYecuNaRaOAWYTUnF7w2d04I4nI4Trx9RY3Yp7U+Pb/QMU0C5tshNawitEYt
         esBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708968700; x=1709573500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WU5hdSHBzbEr/EOa1is0WCLMDW3bS3kIX0rAhn0rg8=;
        b=wdZdZXN6eq6fKCl6OtwUPYgSwpQ1nWvGBv9wxar+qVFHkDL0uX8SK95bNDqXsiWPyv
         xzaKn6ZlcV5Lwkt1dy1AwGAtyKkgE9c6elmHF6HCE2Fa2MzmSZJV8LaVjKp6x9JLtPdh
         5lo0WH3Ce3YfWg8Z/Pz2n4mudx7Ayeev9X4DhRjQVT+VeWYdmvgZgbk+4TTp4/HB0dYz
         4MRTWjnQKbOqP/kgp67anHkreL4CE0EjutfYPscJRkx6PgZ494kDFRhcygQwhmCdkUiC
         70JIKeOW2IAj5t9p9wuPnlQ3S8p8t7P6I6gjujpkhddFRmvPIpfKUplePrRv/EjbO4kc
         UMlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqstTfPPfIbVfXzB1UA2HVJlF0oPXVhGj7vZSf56hXJosvaBXUbPN3vJWJc/hkFgA0b4ZumGk85EQ6Z7kXnoRavGcnWlGOhIdhAU2T3Yga26y+MuVVlUPZX6WXaNajk8u7ZW3pa+6+PJzuQKNJ4l8Eds4FbfYng9sG2u093kXaxAENWBt5
X-Gm-Message-State: AOJu0YwTWCA34HkgYndZu7e7i02l6OtkTUOnKv57hNGE60nnnloe5VHc
	BGeV6heUtxkHnT5oIg0W7EqdL4ulSZD5oPBFG1N6RNz3yFkHMotY
X-Google-Smtp-Source: AGHT+IFQIbGtRJZcvdmjxtUF9k7iAj+aV2asa5agG4pUYnayde6hWZh9DoU0ud+zNuxKQdrFfIsQgQ==
X-Received: by 2002:a17:906:1310:b0:a43:c72:4146 with SMTP id w16-20020a170906131000b00a430c724146mr4081186ejb.58.1708968699695;
        Mon, 26 Feb 2024 09:31:39 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ps8-20020a170906bf4800b00a42ee2af521sm2535227ejb.137.2024.02.26.09.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 09:31:39 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject:
 Re: [PATCH] dt-bindings: input: allwinner,sun4i-a10-lrad: drop redundant type
 from label
Date: Mon, 26 Feb 2024 18:31:38 +0100
Message-ID: <3207352.5fSG56mABF@jernej-laptop>
In-Reply-To: <20240226122934.89257-1-krzysztof.kozlowski@linaro.org>
References: <20240226122934.89257-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne ponedeljek, 26. februar 2024 ob 13:29:34 CET je Krzysztof Kozlowski napisal(a):
> dtschema defines label as string, so $ref in other bindings is
> redundant.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

I already send PR for 6.9. Do you mind if it waits on next cycle?

Best regards,
Jernej

> ---
>  .../bindings/input/allwinner,sun4i-a10-lradc-keys.yaml           | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml b/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
> index 5efceb313879..c384bf0bb25d 100644
> --- a/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
> +++ b/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
> @@ -49,7 +49,6 @@ patternProperties:
>      $ref: input.yaml#
>      properties:
>        label:
> -        $ref: /schemas/types.yaml#/definitions/string
>          description: Descriptive name of the key
>  
>        linux,code: true
> 






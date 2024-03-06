Return-Path: <linux-kernel+bounces-93438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CF3872FC3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598BC28164B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B832C5C90C;
	Wed,  6 Mar 2024 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fmSP5Cmd"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1381617745
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710496; cv=none; b=Z92SboA6uGdpf8EWGVURypVivEHGElP+nsDLj+yYpLY0ptpmNTRMtgEzXmzoDM0kHfk4Vgf4/xoNehyYyy4mx1GnRwqu+Fn03vgQLdlMSl3IZUOZ7lY7k0cgLvo+pO+ekSaQwtUFkTBT/ZSwqiHIUpvEuCxMB7AVWGvbU5fx7a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710496; c=relaxed/simple;
	bh=I0f6+eX1s+HWRJYTub/vdh5mp7asa2hhcNPoDkt+6Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1nqlAJCdvtuOdBc5x893dHJqKuwsfstcJLqPaxkSPTYAjDnXJQpMrKrPVZZtpKuSGm6sD2VvDjdemEyNeID3OrK97SCVJY26KQUlzN/recq5fGRSB1NJl0X56v1WbfVDr33InAHIK3bcNMkTmTZD4FihIptHZontFAJ7YAO4ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fmSP5Cmd; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a452877ddcaso408839366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 23:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709710493; x=1710315293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Roy/GFA4LhSJfy4U8CC0PZ8QNN0oJiic2IZNVSrgRig=;
        b=fmSP5CmdvO6xmX5VUx1/lUSfVBkxvTBm/2LEHYBB5x5gOuqAx+9hglgOe3waLY9SYE
         dYeEfyp73pGsr4L8EjaMKiEoKAPkT4EWAfiogoqOiiCi0nPW4uvFkdAEHbI31BYqGbgw
         tZfYuqg8en5qndN+eVbIRaE5IVkB2Ovd6IlRZvGBVX45mUndQB+tr8ETZSKt3L8d/kt+
         X0IFC5CHgEsdGLCk1Xtz1p46hmTH2M8k6sE5pStf8pcnmPAUQ3krt5H0SiXPGdkJtu+k
         pgNIsx4dDr38ydDEfTLOiNz31GewEoPyeaYhEkaYFx/YBxYRe2V/mK30QxvQTRWYhAgq
         vGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709710493; x=1710315293;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Roy/GFA4LhSJfy4U8CC0PZ8QNN0oJiic2IZNVSrgRig=;
        b=oHjwuUkfFndmmdXyqmj+/l+dWhIaxJ8N3sIq+wS43CVSwPM5MfR+s87oBDAimHZQz5
         fF7asDUX6Zd/JLLmiE6Zcx74fQDoE1pBHclvoVe6WtfhqIEZ8+fFVGp7s5k1847QM//4
         iSvAdIAlT9vc5JO2uHkGjtzaXuzWz7/kKhW/1aiRHgPZtNLXex/viy/yz73SBMA6RcKy
         sY/bRoI+eqk0Nc3UN/7nwwQj7tJuJZOWGv4IaOozhYmbl+q25kephXD2+vbvK3AlPKN+
         pjL09hJkfpjC+vZgB7UwF/jGZ6kA8HeKYfMzMzoSAdlQPB5GdGyMy7Q3iK4tzeEFc5q6
         maCw==
X-Gm-Message-State: AOJu0YyjIP2GjhJ4Sq75tzkIW5HkUHdTlFurv5C8L695Gpqq2FrAThzR
	kqcKw/1Z+eJue1V6vr7YJKkiXgzNwbYKLPRayeFp16DJ5iRTUUphf11cLyE9m2k=
X-Google-Smtp-Source: AGHT+IEGmrfLrmuZnuwk9MDReu8TUpEtAmMBhhU/WEy5PR3SDazmyLPhrfnKGf4nlk3vxgBgjKr5Zw==
X-Received: by 2002:a17:906:714f:b0:a3f:20b9:2b68 with SMTP id z15-20020a170906714f00b00a3f20b92b68mr9826117ejj.10.1709710493125;
        Tue, 05 Mar 2024 23:34:53 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id x11-20020a170906710b00b00a4434e9938asm6793728ejj.84.2024.03.05.23.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 23:34:52 -0800 (PST)
Message-ID: <848fd700-e450-4dfd-b415-5d4fa5f6af9a@linaro.org>
Date: Wed, 6 Mar 2024 08:34:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: serial: renesas,scif: Document R9A09G057
 support
Content-Language: en-US
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240305171600.328699-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240305171600.328699-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/03/2024 18:16, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Document support for the Serial Communication Interface with FIFO (SCIF)
> available in the Renesas RZ/V2H(P) (R9A09G057) SoC. The SCIF interface in
> the Renesas RZ/V2H(P) is similar to that available in the RZ/G2L
> (R9A07G044) SoC, with the only difference being that the RZ/V2H(P) SoC has
> three additional interrupts: one for Tx end/Rx ready and the other two for
> Rx and Tx buffer full, which are edge-triggered.
> 
> No driver changes are required as generic compatible string
> "renesas,scif-r9a07g044" will be used as a fallback on RZ/V2H(P) SoC.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
>  .../bindings/serial/renesas,scif.yaml         | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> index 4610a5bd580c..b2c2305e352c 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> @@ -80,6 +80,7 @@ properties:
>                - renesas,scif-r9a07g043      # RZ/G2UL and RZ/Five
>                - renesas,scif-r9a07g054      # RZ/V2L
>                - renesas,scif-r9a08g045      # RZ/G3S
> +              - renesas,scif-r9a09g057      # RZ/V2H(P)
>            - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback
>  
>    reg:
> @@ -101,6 +102,16 @@ properties:
>            - description: Break interrupt
>            - description: Data Ready interrupt
>            - description: Transmit End interrupt
> +      - items:
> +          - description: Error interrupt
> +          - description: Receive buffer full interrupt
> +          - description: Transmit buffer empty interrupt
> +          - description: Break interrupt
> +          - description: Data Ready interrupt
> +          - description: Transmit End interrupt
> +          - description: Transmit End/Data Ready interrupt
> +          - description: Receive buffer full interrupt (EDGE trigger)
> +          - description: Transmit buffer empty interrupt (EDGE trigger)

You should narrow the choice per variant. Your patch is now saying that
all devices could have 9 interrupts.

Best regards,
Krzysztof



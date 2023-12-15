Return-Path: <linux-kernel+bounces-1039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E781814997
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06138284D80
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCA22E633;
	Fri, 15 Dec 2023 13:48:49 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2A92DF98;
	Fri, 15 Dec 2023 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3ba2dd905f9so539827b6e.2;
        Fri, 15 Dec 2023 05:48:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702648127; x=1703252927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADnelWsbFBE1kM+VJ0XLFA7dl/I3fFumQ78mElohUE4=;
        b=jE4ovwrLIHV2m7MaN+SaFvL26Drn/f4y7U7FMZ1nwDDuSHbGrWJ1uCbsNaszPYFX4/
         J5cRcBG5cwNaNYnrtlEZdoNSntq6zbi25LYL4v3cd7o82PSm/llo93yaNhXi2d/T6yBb
         EEgN1xkwVCYOuG9e8KJYECkE5RZe6Vf1BoeP/3iv4TP2rU7irKTYqVZ5Su29h6iiP3oJ
         fpfz6EtmEOafT7BUyuWFxCslsgigXcobXnmhmzs1iq2k3axoxHF8CORqbfDTVQTmIMOZ
         VigVRz4bQAw4V+tIGDW2BYr1gSK7STkdfREQBT/F7jFR2ICFA7VjZuNJpgYxw6XT8Kgp
         1JxQ==
X-Gm-Message-State: AOJu0YzGfxus4lrBVjsbokKrIp7tJK8npKFf/vQjX0vzZydb0lAMTVDg
	FB8FgQw1zlKrmEKrPZjDmA==
X-Google-Smtp-Source: AGHT+IGelGR0QgAaVpJOlPlGoPIFwG6d83dChGqVzOjhyhqbrUUPSxMennaB/EvfqSR/qaCnCvMhFw==
X-Received: by 2002:a05:6808:2e4e:b0:3ba:b1f:f48f with SMTP id gp14-20020a0568082e4e00b003ba0b1ff48fmr13036693oib.63.1702648126886;
        Fri, 15 Dec 2023 05:48:46 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i14-20020a056808030e00b003af642cf646sm3766034oie.37.2023.12.15.05.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 05:48:46 -0800 (PST)
Received: (nullmailer pid 3401288 invoked by uid 1000);
	Fri, 15 Dec 2023 13:48:45 -0000
Date: Fri, 15 Dec 2023 07:48:45 -0600
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v3 1/4] dt-bindings: net: phy: Document new LEDs
 active-low property
Message-ID: <20231215134845.GA3366586-robh@kernel.org>
References: <20231213111322.6152-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213111322.6152-1-ansuelsmth@gmail.com>

On Wed, Dec 13, 2023 at 12:13:19PM +0100, Christian Marangi wrote:
> Document new LEDs active-low property to define if the LED require to be
> set low to be turned on.
> 
> active-low can be defined in the leds node for PHY that apply the LED
> polarity globally for each attached LED or in the specific led node for
> PHY that supports setting the LED polarity per LED.
> 
> Declaring both way is not supported and will result in the schema
> getting rejected.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v3:
> - Out of RFC
> Changes v2:
> - Add this patch
> 
>  .../devicetree/bindings/net/ethernet-phy.yaml | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> index 8fb2a6ee7e5b..9cb3981fed2a 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> @@ -213,6 +213,11 @@ properties:
>        '#size-cells':
>          const: 0
>  
> +      'active-low':

Don't need quotes.

I think this should just be per LED. If the h/w only supports a global 
setting, then they all should match.

> +        type: boolean
> +        description:
> +          This define whether all LEDs needs to be low to be turned on.
> +
>      patternProperties:
>        '^led@[a-f0-9]+$':
>          $ref: /schemas/leds/common.yaml#
> @@ -225,11 +230,26 @@ properties:
>                driver dependent and required for ports that define multiple
>                LED for the same port.
>  
> +          'active-low':
> +            type: boolean
> +            description:
> +              This define whether the LED needs to be low to be turned on.
> +
>          required:
>            - reg
>  
>          unevaluatedProperties: false
>  
> +    allOf:
> +      - if:
> +          required:
> +            - active-low
> +        then:
> +          patternProperties:
> +            '^led@[a-f0-9]+$':
> +              properties:
> +                'active-low': false
> +
>      additionalProperties: false
>  
>  required:
> -- 
> 2.40.1
> 


Return-Path: <linux-kernel+bounces-2663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B13816020
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 16:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D261C21BE3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B03844C93;
	Sun, 17 Dec 2023 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+Zc79M+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6B731741;
	Sun, 17 Dec 2023 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4b2cef60577so314620e0c.3;
        Sun, 17 Dec 2023 07:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702826359; x=1703431159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UtImHLFMCVHfk9UzUAedYoxSjwyfQ8nKMkLmNvd6Mw=;
        b=h+Zc79M+Qd6nk+H9TZZ3V8XU4FlheZY7FJPRf/S3B6ON/x7jECjGeco5BSraj21ex3
         ZoOFZmUvpr3kfamMhOpQ3ZnUwjDHttChkRzPz46y3TWbf/Ia4TAIY5cBTBDCQiQ6JNH0
         6LRXfabprhbM4l8Ml++Czv/V6qjT4/CtvVlYkUQqth/+nNGAGIA+oQo2pC3GyQXhTezf
         Tr86rtIlW0fdxkSFB32qDrwKeDENIGFCg4w6TABJjDZZHC+rWh/sTrVBVevcOwrRMEgB
         o9RA39FxcRs+TR1w4QqtjmVLCxzJu39bL4RY5G8WovmhbkQMtcz/QBwerXhB5+d4B1aT
         NOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702826359; x=1703431159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UtImHLFMCVHfk9UzUAedYoxSjwyfQ8nKMkLmNvd6Mw=;
        b=MWcq1GCVAGqKyoSjUSnO0G2lmz4TmPQQRi/H/8tYGiK9Eza6wMN52f/WzXl517VbnN
         PJoGQ/mzL6RJfb64gkI+ILkItOtjxxoMkv03JDkQ96JluBkiaPY0aVPZIpKTq/cjtPX1
         fLuE/JvixIog6tVPNlMc64eU67eohbA+kEXw+DpkLI5uDdLle2471W39PqjPZkcmCNdj
         s+bXiMya00MpqxQBePc6iPLROiI3/FqUlzyMugnv7KeY/rP0xeq4bl3LLpIh3QDI67p/
         S9L7pOzImZzfIstoSnQLAmxSB57bYnF7YY13EEWrSTfOmnuaO2P8bHxshr/BVpqpYRyw
         nxRw==
X-Gm-Message-State: AOJu0YyvnBpIvQfHmmNf47QUaJIgAekDBpiBcqouCbO5PsavQwneD/A2
	6w+96Y+SfP9EcSYYDwsj9Es=
X-Google-Smtp-Source: AGHT+IGfbOYjCY2Rb5Lm6BujYo5gkYTmyE30aTT/TjEes6SdT58P3AL4UPO57Vxufivds2qdx6NXig==
X-Received: by 2002:a05:6102:c94:b0:464:9f3f:cde with SMTP id f20-20020a0561020c9400b004649f3f0cdemr12760068vst.23.1702826358904;
        Sun, 17 Dec 2023 07:19:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cd19-20020a056102419300b00457bc8f04e3sm1721488vsb.5.2023.12.17.07.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 07:19:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 17 Dec 2023 07:19:17 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Mark Brown <broonie@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Peter Yin <peter.yin@quantatw.com>,
	Potin Lai <potin.lai@quantatw.com>,
	Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: Add MP2856/MP2857 voltage regulator
 device
Message-ID: <f204b419-3e05-4848-882e-70a17671435e@roeck-us.net>
References: <20231211160519.21254-1-potin.lai.pt@gmail.com>
 <20231211160519.21254-2-potin.lai.pt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211160519.21254-2-potin.lai.pt@gmail.com>

On Tue, Dec 12, 2023 at 12:05:18AM +0800, Potin Lai wrote:
> From: Peter Yin <peteryin.openbmc@gmail.com>
> 
> Monolithic Power Systems, Inc. (MPS) MP2856/MP2857
> dual-loop, digital, multi-phase controller.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 386ebd1471d0e..c847a532283d4 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -119,6 +119,10 @@ properties:
>            - fsl,mpl3115
>              # MPR121: Proximity Capacitive Touch Sensor Controller
>            - fsl,mpr121
> +            # Monolithic Power Systems Inc. multi-phase controller mp2856
> +          - mps,mp2856
> +            # Monolithic Power Systems Inc. multi-phase controller mp2857
> +          - mps,mp2857
>              # Monolithic Power Systems Inc. multi-phase controller mp2888
>            - mps,mp2888
>              # Monolithic Power Systems Inc. multi-phase controller mp2971


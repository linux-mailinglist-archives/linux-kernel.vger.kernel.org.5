Return-Path: <linux-kernel+bounces-7154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C1081A25D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC151F25186
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A8D3DB9C;
	Wed, 20 Dec 2023 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfIbUWkn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D7D40BEF;
	Wed, 20 Dec 2023 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c3fe6c1b5so62921835e9.2;
        Wed, 20 Dec 2023 07:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703085953; x=1703690753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uS6w3rNmw0cdtYnw4LMSsxjjgZzl4QPxrmb81MWLsvk=;
        b=ZfIbUWknOEot2+Xgy5pP2CIdtrldY5SLtigTqyJUjFcQhCKI6PHfP/Nk4YRTTqgu0A
         6fvJ4qV3g8g9KkOJLbliw0mhekLwKaOftqKP+sp+U7bRC528AKzDb2QfH57rKSQha7FY
         41YaAYEqRndgkaD0StqpSpiBGlF8U62wZay3rM4yVigcCocH3TWU5G1vFftJnXz385iB
         Mcw6rJs1wLFxCvJV1sCM1x5VAXQXk9BfG0xUJp9JMh0qrcxP77DEXJliU67w0UJPXFpF
         o+wIjCuKnB/tTryCJsfq2+ggef945gZRm/zDkmtj3bAKK+hQpzTKifEOIyrT/wrBUtlA
         RP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703085953; x=1703690753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uS6w3rNmw0cdtYnw4LMSsxjjgZzl4QPxrmb81MWLsvk=;
        b=gyC+3x24Mc+SiQgDtYYRzm4PcbgU9qQCHXE8fBUTTRkKwPpEAVWZQ1mwx92FkrOyB1
         YtyKxE2nV7eaE/xCZQSsA6kyORDr4P9kFMZlzm0wddfB4xzgha1HcDKx3Tx5+iaJ6nlO
         2FTN2v8pyi+ff/PHvwpLqXbMqYAypAdb1SNrmOC5sgVg8bw6Qo4maLZi7Q6wBWy8viyg
         WdGJBwYTJ0uqcj953XiSvStK31dXWXN6sc5LXNwtFGaoHK5YlCJzzFIukm8/DR7x4wat
         XKU69GDruKsScMiU9SjpWPhJlHYvCqf3cUBRZ2n0v5dngHIDYsc/iCbesuEuEEfIT2to
         5WJw==
X-Gm-Message-State: AOJu0YzL29/muuddjzvhTWhZr5+iPGHV0ZRDXpX4hKgWDluReukUQdDH
	y8ILUql++4HWAXCib4dQ7aM=
X-Google-Smtp-Source: AGHT+IGqN3fsaKks2Cw8XAX/rXbmEt1dkYX1uzdoef3zSrDXFU1J51FjOJPUUlBcU0nkMxM5sTgiRQ==
X-Received: by 2002:a05:600c:5d5:b0:40c:34e1:72e5 with SMTP id p21-20020a05600c05d500b0040c34e172e5mr9978141wmd.69.1703085953376;
        Wed, 20 Dec 2023 07:25:53 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c4f0200b003feae747ff2sm7858073wmq.35.2023.12.20.07.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 07:25:53 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Yangtao Li <tiny.windzz@gmail.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Brandon Cheo Fusi <fusibrandon13@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Brandon Cheo Fusi <fusibrandon13@gmail.com>
Subject: Re: [RFC PATCH 2/2] riscv: dts: allwinner: Fill in OPPs
Date: Wed, 20 Dec 2023 16:25:50 +0100
Message-ID: <113541315.nniJfEyVGO@jernej-laptop>
In-Reply-To: <20231220095141.27883-3-fusibrandon13@gmail.com>
References:
 <20231220095141.27883-1-fusibrandon13@gmail.com>
 <20231220095141.27883-3-fusibrandon13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne sreda, 20. december 2023 ob 10:51:41 CET je Brandon Cheo Fusi napisal(a):
> Specifies two voltage ranges, in order of increasing stability,
> for each OPP. This is heavily inspired by
> 
> https://github.com/Tina-Linux/linux-5.4/blob/master/arch/riscv/boot/dts/sunxi/sun20iw1p1.dtsi#L118-L133
> 
> and
> 
> https://github.com/mangopi-sbc/tina-linux-5.4/blob/0d4903ebd9d2194ad914686d5b0fc1ddacf11a9d/arch/riscv/boot/dts/sunxi/sun20iw1p1.dtsi#L118-L182

Remove links from message. If you really want them, add Link tag for each.

> 
> Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> ---
>  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> index 2f1771c19..8e7bc8bd0 100644
> --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> @@ -48,13 +48,17 @@ opp_table_cpu: opp-table-cpu {
>  		opp-408000000 {
>  			clock-latency-ns = <244144>; /* 8 32k periods */
>  			opp-hz = /bits/ 64 <408000000>;
> -			opp-microvolt-speed0 = <900000 900000 1100000>;
> +
> +			opp-microvolt-speed0 = <950000 900000 1100000>;

Second value should be same as first, otherwise you'll experience stability issue.

> +			opp-microvolt-speed1 = <900000 900000 1100000>;
>  		};
>  
>  		opp-1080000000 {
>  			clock-latency-ns = <244144>; /* 8 32k periods */
>  			opp-hz = /bits/ 64 <1008000000>;
> -			opp-microvolt-speed0 = <900000 900000 1100000>;
> +
> +			opp-microvolt-speed0 = <1100000 900000 1100000>;

Ditto.

Best regards,
Jernej

> +			opp-microvolt-speed1 = <950000 900000 1100000>;
>  		};
>  	};
>  
> 






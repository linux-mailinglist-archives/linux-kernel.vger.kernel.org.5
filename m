Return-Path: <linux-kernel+bounces-32577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 706AC835D76
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E5D1C23229
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE7939FCC;
	Mon, 22 Jan 2024 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHVIqYgH"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5371E39AEA;
	Mon, 22 Jan 2024 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913836; cv=none; b=jhjYMD74OgSaOPohefE/LzKntGRJEBIkBWLuafzOJUxQBZFoeficU2WpbrPBxxMfKIOy2J9Ge8TUKr/FHOVpG0SWK7w1yWs9EyNTLUw1HDxm3iqmoVmUAqN0vgYudKZLoqasnzNwRsJrZIXmXbMNvq7SOMXw1kjkVBgGm39zNn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913836; c=relaxed/simple;
	bh=DZdxQzVzfHrKANIN7+0mhcd4gKztKEpFjrLdWtyyBjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATCvl/X1rrguEjaTmjHjDlSIQUeC1Mm5wFMybebTlYiXdhKUGNHbJaGQwNTedtro4JpBdMdavp690Io/6zNe+hjrKVzHX8/RNyhTFsq/IOaCdhtms1vGJE7jmXNighORldCVR1X+CwgeI0eElPGypOIAfVOOhZ08vTYlkwaHDWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHVIqYgH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40eb033c192so1424095e9.0;
        Mon, 22 Jan 2024 00:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705913833; x=1706518633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w1+TRGt25MpNfEoS3hXoxH/tN7Awcod+oM5fMO5D3jc=;
        b=gHVIqYgH8dcud1vWnPY7mB3JSQXJEV/UsNO4FZAn9czkUsZ7FIKqKSsvv/0W4dnURY
         r4uEYBRAdfqss6/9etVRmhREtKaAbpUke83UwG4//OILXht6L76cXtEU1dQBuTY65HX5
         N4kb1SIhaKvkiLGKZ1JdBvT39gE3jNBhF7r2L7TVP7YpItJCEykGCXLZ/S0QNStVyn5j
         zdawaGfVshEtHcqdGTTOcd4P261htXKBPBL2WKkdxgXSmELMyGvH85jJGhN78+eyhZUn
         SxwFmKALkLazagsSkI//38RikJNdYSeeCVwB58YtplGmfdt3POsim1uuveYQBtFlsFF8
         vr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705913833; x=1706518633;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w1+TRGt25MpNfEoS3hXoxH/tN7Awcod+oM5fMO5D3jc=;
        b=uZxIvlTHvbdC6PjJhPKgV/so5BFT+2MLkw2OgrGAtSgca6tmLGDH/ni6E1Gda7Gdxt
         Qmjajen5X9jo7e7d2Yyd1OHkpRo79ngPuk/tPdjVSRzlxoChA1A8fRBeZasU3aqLFI3T
         Tt37FCcX63l2HlKDvNbbhuBcnRB22/7RCTRiwxuJU1heuLVVtxTRJ6PeE10ipNzaBB1p
         aATWFPt7JJSiAfFVMJCOiuxZrilihW3rUs8J14LzEbF1BbRgRY9u7Sk4h5Jr9x9vWmyf
         6yo6IL1wUXHbzxIJneHnr1qroNZJpPdM8Zv0ontifKxiPKm6Ah3+W0AduugHt/mB+aLf
         sUKQ==
X-Gm-Message-State: AOJu0YweXQx8pYLEKtd4N+wyAfffjM8q2HtgNLZrgP9UVhSsyR+Gvuds
	KULLBfSmmNkbbTTdJ4S1kBWRpQPxBNM0W3ZCiZu4qY3SrzWKgvjI
X-Google-Smtp-Source: AGHT+IHTPThDUzVUHUWazCjWo+HmxmUbfHP07K3tx1bQtUkViBI9fvhJQ7xyJRZWWrJ9IqRbxqlZig==
X-Received: by 2002:a05:600c:6a8e:b0:40e:4ad9:90df with SMTP id jl14-20020a05600c6a8e00b0040e4ad990dfmr1813366wmb.158.1705913833292;
        Mon, 22 Jan 2024 00:57:13 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.188])
        by smtp.gmail.com with ESMTPSA id s8-20020a05600c45c800b0040e527602c8sm42479485wmo.9.2024.01.22.00.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 00:57:12 -0800 (PST)
Message-ID: <0d3c2713-6da5-4e7c-8568-180df6e424d7@gmail.com>
Date: Mon, 22 Jan 2024 09:57:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: reset: mediatek: add MT7988 LVTS
 reset ID
Content-Language: en-US, ca-ES, es-ES
To: Frank Wunderlich <linux@fw-web.de>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Frank Wunderlich <frank-w@public-files.de>,
 Sam Shih <sam.shih@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20240105162056.43266-1-linux@fw-web.de>
 <20240105162056.43266-2-linux@fw-web.de>
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 xsFNBFP1zgUBEAC21D6hk7//0kOmsUrE3eZ55kjc9DmFPKIz6l4NggqwQjBNRHIMh04BbCMY
 fL3eT7ZsYV5nur7zctmJ+vbszoOASXUpfq8M+S5hU2w7sBaVk5rpH9yW8CUWz2+ZpQXPJcFa
 OhLZuSKB1F5JcvLbETRjNzNU7B3TdS2+zkgQQdEyt7Ij2HXGLJ2w+yG2GuR9/iyCJRf10Okq
 gTh//XESJZ8S6KlOWbLXRE+yfkKDXQx2Jr1XuVvM3zPqH5FMg8reRVFsQ+vI0b+OlyekT/Xe
 0Hwvqkev95GG6x7yseJwI+2ydDH6M5O7fPKFW5mzAdDE2g/K9B4e2tYK6/rA7Fq4cqiAw1+u
 EgO44+eFgv082xtBez5WNkGn18vtw0LW3ESmKh19u6kEGoi0WZwslCNaGFrS4M7OH+aOJeqK
 fx5dIv2CEbxc6xnHY7dwkcHikTA4QdbdFeUSuj4YhIZ+0QlDVtS1QEXyvZbZky7ur9rHkZvP
 ZqlUsLJ2nOqsmahMTIQ8Mgx9SLEShWqD4kOF4zNfPJsgEMB49KbS2o9jxbGB+JKupjNddfxZ
 HlH1KF8QwCMZEYaTNogrVazuEJzx6JdRpR3sFda/0x5qjTadwIW6Cl9tkqe2h391dOGX1eOA
 1ntn9O/39KqSrWNGvm+1raHK+Ev1yPtn0Wxn+0oy1tl67TxUjQARAQABzSlNYXR0aGlhcyBC
 cnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPsLBkgQTAQIAPAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AWIQTmuZIYwPLDJRwsOhfZFAuyVhMC8QUCWt3scQIZAQAKCRDZFAuy
 VhMC8WzRD/4onkC+gCxG+dvui5SXCJ7bGLCu0xVtiGC673Kz5Aq3heITsERHBV0BqqctOEBy
 ZozQQe2Hindu9lasOmwfH8+vfTK+2teCgWesoE3g3XKbrOCB4RSrQmXGC3JYx6rcvMlLV/Ch
 YMRR3qv04BOchnjkGtvm9aZWH52/6XfChyh7XYndTe5F2bqeTjt+kF/ql+xMc4E6pniqIfkv
 c0wsH4CkBHqoZl9w5e/b9MspTqsU9NszTEOFhy7p2CYw6JEa/vmzR6YDzGs8AihieIXDOfpT
 DUr0YUlDrwDSrlm/2MjNIPTmSGHH94ScOqu/XmGW/0q1iar/Yr0leomUOeeEzCqQtunqShtE
 4Mn2uEixFL+9jiVtMjujr6mphznwpEqObPCZ3IcWqOFEz77rSL+oqFiEA03A2WBDlMm++Sve
 9jpkJBLosJRhAYmQ6ey6MFO6Krylw1LXcq5z1XQQavtFRgZoruHZ3XlhT5wcfLJtAqrtfCe0
 aQ0kJW+4zj9/So0uxJDAtGuOpDYnmK26dgFN0tAhVuNInEVhtErtLJHeJzFKJzNyQ4GlCaLw
 jKcwWcqDJcrx9R7LsCu4l2XpKiyxY6fO4O8DnSleVll9NPfAZFZvf8AIy3EQ8BokUsiuUYHz
 wUo6pclk55PZRaAsHDX/fNr24uC6Eh5oNQ+v4Pax/gtyyc7BTQRd1TlIARAAm78mTny44Hwd
 IYNK4ZQH6U5pxcJtU45LLBmSr4DK/7er9chpvJ5pgzCGuI25ceNTEg5FChYcgfNMKqwCAekk
 V9Iegzi6UK448W1eOp8QeQDS6sHpLSOe8np6/zvmUvhiLokk7tZBhGz+Xs5qQmJPXcag7AMi
 fuEcf88ZSpChmUB3WflJV2DpxF3sSon5Ew2i53umXLqdRIJEw1Zs2puDJaMqwP3wIyMdrfdI
 H1ZBBJDIWV/53P52mKtYQ0Khje+/AolpKl96opi6o9VLGeqkpeqrKM2cb1bjo5Zmn4lXl6Nv
 JRH/ZT68zBtOKUtwhSlOB2bE8IDonQZCOYo2w0opiAgyfpbij8uiI7siBE6bWx2fQpsmi4Jr
 ZBmhDT6n/uYleGW0DRcZmE2UjeekPWUumN13jaVZuhThV65SnhU05chZT8vU1nATAwirMVeX
 geZGLwxhscduk3nNb5VSsV95EM/KOtilrH69ZL6Xrnw88f6xaaGPdVyUigBTWc/fcWuw1+nk
 GJDNqjfSvB7ie114R08Q28aYt8LCJRXYM1WuYloTcIhRSXUohGgHmh7usl469/Ra5CFaMhT3
 yCVciuHdZh3u+x+O1sRcOhaFW3BkxKEy+ntxw8J7ZzhgFOgi2HGkOGgM9R03A6ywc0sPwbgk
 gF7HCLirshP2U/qxWy3C8DkAEQEAAcLBdgQYAQgAIBYhBOa5khjA8sMlHCw6F9kUC7JWEwLx
 BQJd1TlIAhsMAAoJENkUC7JWEwLxtdcP/jHJ9vI8adFi1HQoWUKCQbZdZ5ZJHayFKIzU9kZE
 /FHzzzMDZYFgcCTs2kmUVyGloStXpZ0WtdCMMB31jBoQe5x9LtICHEip0irNXm80WsyPCEHU
 3wx91QkOmDJftm6T8+F3lqhlc3CwJGpoPY7AVlevzXNJfATZR0+Yh9NhON5Ww4AjsZntqQKx
 E8rrieLRd+he57ZdRKtRRNGKZOS4wetNhodjfnjhr4Z25BAssD5q+x4uaO8ofGxTjOdrSnRh
 vhzPCgmP7BKRUZA0wNvFxjboIw8rbTiOFGb1Ebrzuqrrr3WFuK4C1YAF4CyXUBL6Z1Lto//i
 44ziQUK9diAgfE/8GhXP0JlMwRUBlXNtErJgItR/XAuFwfO6BOI43P19YwEsuyQq+rubW2Wv
 rWY2Bj2dXDAKUxS4TuLUf2v/b9Rct36ljzbNxeEWt+Yq4IOY6QHnE+w4xVAkfwjT+Vup8sCp
 +zFJv9fVUpo/bjePOL4PMP1y+PYrp4PmPmRwoklBpy1ep8m8XURv46fGUHUEIsTwPWs2Q87k
 7vjYyrcyAOarX2X5pvMQvpAMADGf2Z3wrCsDdG25w2HztweUNd9QEprtJG8GNNzMOD4cQ82T
 a7eGvPWPeXauWJDLVR9jHtWT9Ot3BQgmApLxACvwvD1a69jaFKov28SPHxUCQ9Y1Y/Ct
In-Reply-To: <20240105162056.43266-2-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/01/2024 17:20, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add reset constant for using as index in driver and dts.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> v2:
>   - add missing commit message and SoB
>   - change value of infrareset to 0
> ---
>   include/dt-bindings/reset/mediatek,mt7988-resets.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/dt-bindings/reset/mediatek,mt7988-resets.h b/include/dt-bindings/reset/mediatek,mt7988-resets.h
> index 493301971367..0216eeb249c7 100644
> --- a/include/dt-bindings/reset/mediatek,mt7988-resets.h
> +++ b/include/dt-bindings/reset/mediatek,mt7988-resets.h
> @@ -10,4 +10,8 @@
>   /* ETHWARP resets */
>   #define MT7988_ETHWARP_RST_SWITCH		0
>   
> +/* INFRA resets */
> +#define MT7988_INFRA_RST0_THERM_CTRL_SWRST	0
> +
>   #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT7988 */
> +


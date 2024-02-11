Return-Path: <linux-kernel+bounces-60768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2334F850938
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9AA2862EC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9141C5B5A1;
	Sun, 11 Feb 2024 12:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hIq1AO0m"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F82433A3
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654836; cv=none; b=b2TU8BslovplJaYwmAIdqDoFDL4kfk5bft68n5l0wPI0ey7PFErillvtjZZGo22Iu6jug8BKoBTNEYDkFBWunCL5vCCO2CbXdu9bcs3gz/EsMKEP6LeDMs/p9DPJRNMX/tL7wdIlL12PhTLW0vhwwC8GRw5nFtdFfWQAMPUIFKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654836; c=relaxed/simple;
	bh=GCED/QP/xyH+7CW8WTFgW3oMBKe+o8sf2sTvuBphVXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZEb0oS5LIFEMsM6MGU6RnJLNe16CvO71uq7r+DG+u6Suh+jjFK+XdMvL/7OJ0MTGyI328yMKHbDtfXJcdJgBoZdEnge8mPS861mXYgluPPlRkgdYwFTXxToMQ8yCZSAy576FRq48uvwVBK+YXVJ4GdLX4qvfoiwpequaOnU3u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hIq1AO0m; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50eac018059so3063692e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707654833; x=1708259633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/aI7qXhMOcf5MtNE5vZGmHT8dxl7tg52Y94nD3qt87c=;
        b=hIq1AO0mIlAij9rXzHld5tio1FxhFn5CyXMxIM672IIboynw5HVELTY7lIu1Q9OR/Z
         WDvgCuEg5YfoNwGfiORbMIshaJFbS9xdOAgJq2/0wN/uusWZhnAH7NiRlTFwSGR2uST8
         lrX70dh1BEth2KKXrEWMBCFFlQ3BYyf5FHJArk7aYoP6H8ysBlthCeW5d4cPyOsKjGNW
         QlkwGbqIiG11CPEHKS9GZtO1sfk2MKVxzIm74Lm/Ty8EFNge1QBdnKt3g4v1lgXKeqmE
         mQbhOpVzdb18EUNA2ZXH0MsHvcP06py/T7ErygjXXo8oTHVGc6ZGKtDR8iQXllTtYhri
         Ymxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707654833; x=1708259633;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/aI7qXhMOcf5MtNE5vZGmHT8dxl7tg52Y94nD3qt87c=;
        b=SWwKsehX/jbT0Q7tkWh1p7REjJDJmmByX3o79UXZdXmrr96pZSwLkxm1H5dxDz9O/x
         QtFDu3rbJurrNELE2xEWMaDQrpEbcu86nx6NKB1mg17upZzjzT+HG8N7Np934o6twYQp
         Bb7uaf1lKcsnY5zO1N7/Iz7du5f/Y4ojEWGOWQWGdcIMRWfaIooeli6IWRYJtckwgFxT
         DUXMSGl6Jq6rOPD89OKa5ZDl+DtpemInh8cYpjB6qlLVf6ZPOb/xd6PUV4ufKpxnIQ/j
         bfTwa7ku2RYqiWD3Z+ai4DKTyS8I3QYu0pwqMzX3yUQh9Tf5PdreQ+75zX2vqxnN2+lL
         kEnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFAqqh4zWWWYu+6YpbgIoxSZcivdkaaZoclEeiXusUAVaKanjupKiLnh5AIZYNs/oI1dRMVG4sIectRMdhg08Nsxj1E1RwP/EStkRz
X-Gm-Message-State: AOJu0YxSWMmN9WJPYJ4EZQHmVnEckPFXaPR5FE11H++mAb6lNHA52NEj
	/qzgzS+cOAMhPt/J8fYrUhlWZyRqOpdYGWJ+kumnzBf1xupmEmuzZEWBh5mHY5g=
X-Google-Smtp-Source: AGHT+IGro3bN2jjp78eM+pbqQ9ReRWEHRHxVZoUNckYdXQWuiJ9gflrHkADPdP8I4rvfKMW4+of3ug==
X-Received: by 2002:a05:6512:33cb:b0:511:85c3:32be with SMTP id d11-20020a05651233cb00b0051185c332bemr1948418lfg.34.1707654832967;
        Sun, 11 Feb 2024 04:33:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/lyt7L2JL6reMZu9vtq8oSEj4hK0X5Cq2euVtSezHwy1hn/Yt3BAY5rC8uaflH2kldek2feMTjLDOP50alaUwTroklynfUrRBXOrLEXNLxCJTUv3Kvc5/aa0ZJoDYM7D9KcX9yVcHI85yXHI9y4FG1XDtI2QdjaknPE44O99t8XWdxvdZZujBWqjDJi/obxK61xcgfoifyFBNnaOP1YkrxsiHhYTfCgBEpY8oz48F5wJEENsQixoJzYJcamGLwISolGgNfk1k/6Wd764t+qKcQ1xkY6oOLf1ql0D8Y2HvZ0IDCnopFfj4IkIJbUf84DV37AEgtBPxnkGB6QJDLLO4yuVdxnXm5yBH87x7VWXv5Lrjwq/F/ujWenl/bt7hyWoExeos5Tw0s0BEv+xdIOeJzsEJEbVJI7qrpvCv5G5u89lmyTSBdNq5dBBgMnl4M6j2dNzxKJ8XzsKu5WlkyaX3oBf/MNxS4GzGO1nKnkO8AFU10T+0bZqT4qOH1H4Ry9wdd+V4oMt3tekMvCqFSA==
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id n38-20020a05600c3ba600b0040fdb17e66csm5833625wms.4.2024.02.11.04.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 04:33:52 -0800 (PST)
Message-ID: <e086d382-299c-4b60-b8f7-0b13d92131c7@linaro.org>
Date: Sun, 11 Feb 2024 13:33:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/14] dt-bindings: vendor-prefixes: add UNI-T
Content-Language: en-US
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240210012114.489102-1-sre@kernel.org>
 <20240210012114.489102-13-sre@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240210012114.489102-13-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/02/2024 02:18, Sebastian Reichel wrote:
> Uni-Trend Technology is a manufacturer of measurement
> and testing tools.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



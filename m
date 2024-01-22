Return-Path: <linux-kernel+bounces-32642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA975835E5E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D48287430
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1E239AE9;
	Mon, 22 Jan 2024 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rQd9QRJW"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE3D39FC5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705916379; cv=none; b=dWa0BRip5c1xJZGy5YI6ujYI9kWRpGPaOw1szKJc8q5/jmyoQQqlpfzpQfBSfjU/0OtTiewsRlFLx/4x+/0jAo/W4mlQjTFyUKjDJdoncrfa4dSI8KxvDV4IFQBD442rYDAsWtnGrA6Bb0ZsplqNaU9ZwM61SiyouogTr24xbOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705916379; c=relaxed/simple;
	bh=a7JCHdX/+Wi5nG0phX5LTfmFq2Y/bGWVDLlTsNSGf+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYcw35EA54XXZOC1ycdopY7ToTqSdt8pFCO4O/YwA7elyz0yMYUuJVvVSZsTB4BCzO4sAUhsj4MsCRm22dYIeAw4mgdup8HjI30c99sbijhxUTQklpwz1C7xtP1jEKupwa2tnSfvkTcFVsCkXcfEgUH62kWnnbWswvcWeGVjudw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rQd9QRJW; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2dd05e02ffso280396766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 01:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705916376; x=1706521176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vAD+3c3nndCrNn/ZhmJDqEDMFrTLLYdnCYv1uwPMD+w=;
        b=rQd9QRJWByBqHWdDvWPZN0FzpJ+O0sLSsSRimKmTIdW5toaMQqyqfK+oYRUO1N36cH
         A3AQwdO7L7G6aqD7k77lOQr7LZB6LHnl7jyLpV9Gc6S3YFuNKOgYak22qKA8MbhtmSff
         ogtfg1pZXzVIF4ePulLWg3W25nOe48VsuOZjQt8ZtJX+1jqL+EcmDFlxBCErv9fcshXW
         Q4mPqwVUqbMT780uQT7dEFqSSah5TU3v2GFWCnPCgYjFAvAFdIGd5JgDSqYonQ56QVLr
         gwBnNybBnzjVMJZuUpGiWB7tdwD3a9WTjIhMnkot+vgmT0FzOngyV4bt+JVFgW58J29Z
         FM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705916376; x=1706521176;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAD+3c3nndCrNn/ZhmJDqEDMFrTLLYdnCYv1uwPMD+w=;
        b=gi3Ik1UBeIJsFOEJ1I+B2dq1XgccBwnae2PWQXPSaCVCMrtw1K4RLKUIkRoCtegPuI
         F/kN9tyxEYseRX9rV46earTw/OQgqIs2sIkGOvQ+u0KNTSd3zhsYgNsvINcfCs+sJijQ
         ZkzQoW2nDgw7Oy2QpYXe1AMKfHKOxvxJJBertHw4pcdFgXGMPTwrY7vA9U1Q0bT26BGe
         3H6NKM8jPuurCBkOVEdo6jnKzD+RlV875fRnbEU2y+oZwbtkJFBUPbrOeghnX7V4AlgE
         tNYucSx9eTvT9temZnisKCLLZMpn5Mz5oiplQIpI3d2NqElOHC6yfEh97ATnbc7U8BQ+
         01Pw==
X-Gm-Message-State: AOJu0Yz8K6842vjd+O9hhnMJzlvwx9p8vBmUIWKo8vWCUgEuAAoIUSbA
	L6U0WVejOElZot3x/6wd8cTRr0MQcbJBqCRT5R+B2j895gY+TDgpYYJ+guDQD3A=
X-Google-Smtp-Source: AGHT+IFkxvuMy752Dmx4CvugdWWSDBxv0qZ+2Lg2i8ghmrUXU8Itvgz0RqAVHEGdyTuLEI8F4NVpJw==
X-Received: by 2002:a17:906:6ad6:b0:a2e:636e:36a7 with SMTP id q22-20020a1709066ad600b00a2e636e36a7mr1311964ejs.88.1705916376263;
        Mon, 22 Jan 2024 01:39:36 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id vi14-20020a170907d40e00b00a2f1a1259fesm4960469ejc.207.2024.01.22.01.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 01:39:35 -0800 (PST)
Message-ID: <f3be0e57-c984-41a7-bfff-facd0180abcb@linaro.org>
Date: Mon, 22 Jan 2024 10:39:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Introduce ITE IT5205 Alt. Mode
 Passive MUX
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 gregkh@linuxfoundation.org
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, heikki.krogerus@linux.intel.com,
 matthias.bgg@gmail.com, dmitry.baryshkov@linaro.org,
 neil.armstrong@linaro.org, andersson@kernel.org, nathan@kernel.org,
 luca.weiss@fairphone.com, tianping.fang@mediatek.com,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20240119125812.239197-1-angelogioacchino.delregno@collabora.com>
 <20240119125812.239197-2-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240119125812.239197-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/01/2024 13:58, AngeloGioacchino Del Regno wrote:
> Introduce a binding for the ITE IT5205 Alternate Mode Passive MUX,
> used for connecting, disconnecting and switching orientation and
> control the SBU signals for alternate modes on USB Type-C ports.
> 

..

> +  mode-switch:
> +    description: Flag the port as possible handle of altmode switching
> +    type: boolean
> +
> +  orientation-switch:
> +    description: Flag the port as possible handler of orientation switching
> +    type: boolean

Just FYI, I will be sending v2 of:
https://lore.kernel.org/all/20240115092923.105275-1-krzysztof.kozlowski@linaro.org/

which could be used here. If your patch gets first, I will adjust mine.

..

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c2 {

i2c {



Best regards,
Krzysztof



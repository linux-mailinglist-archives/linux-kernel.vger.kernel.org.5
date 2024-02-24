Return-Path: <linux-kernel+bounces-79562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E79C862439
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A85B8B22CEC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB1822626;
	Sat, 24 Feb 2024 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u3NfNiFI"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BD4210E8
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708770538; cv=none; b=TVpzMb2w5fffgqcsg3bD5vnwKDcFWU1KfOhl9//MoREIjCCCVHvjzbO1mpZA/Z7SfYkBwwrwzHh/+CenPu6uyeemqVjpWBeX+RB8HI63oqccoWPWoTQGX7a1lzO9gGH2ra1NYg3liEI7grs5jBHh0FpMiveu9DF5GmrKRYMADig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708770538; c=relaxed/simple;
	bh=Wg0PBihE3EDGuRdaaCb2GnwtY1WotZgKhFda+XYqOVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tay2pxRvcvkVTVXtx0Qa8M75WSlIie0kGRCJ5/b1k5Pv33TKNRwsibAlAANbITenKlZKEVOvkOP2DQMjSQvPJOZZK346D80ijYK2ugfiIhQ4/fIiwYT2wSkG4jQNzJGHYugoK7uGfVS/rLrZeEek0FnlzsqYiD0xqDMDqYzulMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u3NfNiFI; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3e6f79e83dso151668866b.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 02:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708770533; x=1709375333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rgfQfFWKfhHnlKFB8GZQVPCeubPlUtrG7fkujZpbwSg=;
        b=u3NfNiFI4opY+HVrfjOyy8R/cmoOU/+46Ts1JWGkHPpvO9UaMEbbBKiF1vA5IjU/z3
         AvwJEskKkzARXOaLfjU4BA0eyomGBmdBbfKTbY+7zid2CvZkv7Gg4ecDGafMahZ5YHRi
         8QVPRGiGAxiBrrjwkAfIag6Bewtqi0NyOm9ANoxRPB9yPYoUfZHwzWh0258kK3PkkUyK
         1EO21JNVMamTxV0LVOP0apZXbcWrARkaXFb/Zxdg7BShxeXD80OwP5dlfaqbC/lUH08A
         0Y25Q3LoiM6H5C3SrefwYzZYpjqXWnQZJHN3lFxJYtyVm87Xi+7KFWOjB/UrJZcBrSC8
         E2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708770533; x=1709375333;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rgfQfFWKfhHnlKFB8GZQVPCeubPlUtrG7fkujZpbwSg=;
        b=C2MRHOnl1R6qKmDLDnm6amyqvNzNs5LQ1jIRTWmeJAd4+uVTGxNeNTGUfWcKVWzzuT
         vaCfkbfeOT9dj6a8F/Fwxb6HjnoAU8C7wKVvr8o3Tguu1BX2/UHw49N6JSyESxheEgBM
         CMXpCUcPfMCDiLGtqXW8FOQN458VKcOfRAQb7i5pvdDcsODrveBUrbJcEEyM24pWsF5w
         xCzuNjEOPUwmAk0uhJi3Ho4hD1a6Oju+iU58kmJx/TOg9f3t25xKSx6PQ+2e8DhKQqWJ
         m1xrpuoZBJgxtrljAum2W83Z7CioyuxtUseHthgQOqL9x1Oz+QEg1tu0f+bFhkg/mvVA
         ZhCw==
X-Forwarded-Encrypted: i=1; AJvYcCU/V/7nwHvO/flTMbcd4YFtaHjuiYTh+6m3nfNZfS+tc11DMVeXexjceRKq9qpPQX+zrDhisonR/DyDPdhK8Bh+UBEc1xV6rgD8tP57
X-Gm-Message-State: AOJu0YzUXZRERY64GLb30pnzzukuaoOlNZKEf19NcG+JWWBDEkSCvNKR
	5LQezTV8Stt2ooLHR/QWNG8XLk0Nlh1yHE1oVXSSkFekTwjWVt+DSXLv9/yGgO8=
X-Google-Smtp-Source: AGHT+IHRmKgfev3iDF0qZ2rGd4o58JZj/sbd27NcjAsUMnHOL/4J7Az80B8i+gkMBS8gGAKvW2uIBg==
X-Received: by 2002:a17:906:2b05:b0:a3e:77d2:9e04 with SMTP id a5-20020a1709062b0500b00a3e77d29e04mr1284170ejg.24.1708770533237;
        Sat, 24 Feb 2024 02:28:53 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id ps8-20020a170906bf4800b00a42ee2af521sm384657ejb.137.2024.02.24.02.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 02:28:52 -0800 (PST)
Message-ID: <b64155f2-2965-4ea1-8c23-7c79d7a01c9f@linaro.org>
Date: Sat, 24 Feb 2024 11:28:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: add hisilicon,hi3798mv200-dwc3
Content-Language: en-US
To: forbidden405@outlook.com, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240224-dwc3-v2-0-8e4fcd757175@outlook.com>
 <20240224-dwc3-v2-1-8e4fcd757175@outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240224-dwc3-v2-1-8e4fcd757175@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/02/2024 22:43, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> Document the DWC3 controller used by Hi3798MV200.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>


> +
> +properties:
> +  compatible:
> +    const: hisilicon,hi3798mv200-dwc3
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  reg: true

Constraints. maxItems: X

> +
> +  ranges: true
> +
> +  clocks:
> +    items:
> +      - description: Controller bus clock
> +      - description: Controller suspend clock
> +      - description: Controller reference clock
> +      - description: Controller gm clock
> +      - description: Controller gs clock
> +      - description: Controller utmi clock
> +      - description: Controller pipe clock
> +
> +  clock-names:
> +    items:
> +      - const: bus
> +      - const: suspend
> +      - const: ref
> +      - const: gm
> +      - const: gs
> +      - const: utmi
> +      - const: pipe
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: soft
> +
> +patternProperties:
> +  '^usb@[0-9a-z]+$':

unit addresses are in hex, so a-f

Open existing bindings and look how it is done there. There are no
bindings for DWC3 glue/wrapper device having a-z.


> +    $ref: snps,dwc3.yaml#
> +
> +additionalProperties: false

Same comments: open existing bindings and take a look how it is there.
This goes after 'required:' block.

> +
> +required:
> +  - compatible
> +  - '#address-cells'
> +  - '#size-cells'
> +  - ranges
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    usb@98a0000 {
> +            compatible = "hisilicon,hi3798mv200-dwc3";

reg is always the second property. ranges is third.


> +            #address-cells = <1>;
> +            #size-cells = <1>;

Use 4 spaces for example indentation.



Best regards,
Krzysztof



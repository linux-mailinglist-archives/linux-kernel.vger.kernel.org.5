Return-Path: <linux-kernel+bounces-111679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 507C6886F74
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EFFE1C22358
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEEA4E1DD;
	Fri, 22 Mar 2024 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u0vc9sCA"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928D9481A0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120151; cv=none; b=YIDqYaR3V/nedQO9qjfFyAIpb+n7UV6fgh31nKC0Btw4u/up21daTwHscSUUemu4vNfrezQQOodNuMYOUepQ8bkrQXI1H2jxpP99H55Wj5MkWv20/WIoJu0gEgY39V1CFZ1oJz1yx3vVZrelVRCzFBgqbRtwkBP0S7QlnNiXvl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120151; c=relaxed/simple;
	bh=ioCddxy0Wrih4HSkFxOLHM43p7Jl973JpXnI5PGwl2M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kT8w1S+T3G9qqsh9102FJ6gWLhL87O2CMusEvJu3lVDORgezeWJnuGKRJbKfknGRog7B/2LD1BNDr2qYjqEdbw4RhC7x6VFuk5G5qg5RKfosFI9Dhj/pS3aHGtFc095L3+OcaTEGjunK2JU+Ajd/mCDv8oM+75Qhn2RApRpQk2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u0vc9sCA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41477211086so14675215e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711120148; x=1711724948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+yvhwYHTfV+3rWYF2DgHMW8lY8LzP+BMH9HrnaAPrfM=;
        b=u0vc9sCAI1HN3xQAtVMng+IZkpfhxd0M+Zez/GowzxWXDfoQQs/W6F5dzLQDFHXCSN
         7Z0cIcxcSiId6TyOZ2xqToWVuebqWOJccpP4cAT5lm+F7rm3HJctW0RcZhQsXaxYYtSw
         B1fqGzwuIz8eX2A5m5s6NfNmssfdub21t/ysRSD+84j+9ORp95K6/mVGPxYzixvppmT/
         zUJPZmdx8CkHXwmA8CAdsB9omACsCCJaxxCrBPBk8PgGJ0atpkXD+/bYHKvZGLDZnCVY
         EZf/zmXtpU/TcOZSavc7kxiA+xgsW0uiv9WEsQvyca8yrLjoCahDYyFghBymprB7GBF4
         AkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711120148; x=1711724948;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+yvhwYHTfV+3rWYF2DgHMW8lY8LzP+BMH9HrnaAPrfM=;
        b=UVRM4ndWp9CfAuTp+lYrzxgxBLz9/5gOnyTylgCriRqZL8aNS5jE6At16Obz6Z8ndi
         DpBj+Of2mwsXXfbsaOJf+IYfuA0rlgVHLwh+UExyBTKnbxc3FzQmyZgAyaYUdUCnxPX4
         qap1XlAC1WnSse357Xwh14I7cTtOdA7XryB3oZ3jeMSBvJscJCr5HBG0wGWjPoNwTXqj
         GpFNQKFW8lFeKOVMo4a0eDLy7vGZC731J4gUn6u7+MzNeXgNTzR6zVHmkbIa8DwAelUl
         VTuAsIG6ubLVwGMLBvDmIp923U9nrZNg0k2pja3Uv4itNmj0o/RiycFYLrSl4Birvld/
         EW9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7CuK1koHh6dFm8MZzlVxQp0ToWL6zu7D3FUYVfV96bPlrY2Z8qzZ6RqCxpEXUVMO4/LxFEQ55UTGTgBTmiMbLm9xgPFKUhfPem16j
X-Gm-Message-State: AOJu0YxeFFAeknB1dfg2CyI4OaoTwSN1ou5okOb4RlveZ/hW7EQHmkOh
	EGYLobsPhze8RFEHrucrnXCvYOa+8QKcZ3g3EH9Uw+0v4hVyJ1+IaddDOJBGWnk=
X-Google-Smtp-Source: AGHT+IH+c2Vf59CqJ5Cq+G3Tl6E5gw0t2OS8y62T87hvyxoA76WeFaOA1V0WIJpkrZVfPD9fa8oFJw==
X-Received: by 2002:a05:600c:3546:b0:413:2a10:8a29 with SMTP id i6-20020a05600c354600b004132a108a29mr2656828wmq.13.1711120147837;
        Fri, 22 Mar 2024 08:09:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b232:2557:aa5b:1e23? ([2a01:e0a:982:cbb0:b232:2557:aa5b:1e23])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c469100b004132ae838absm3289819wmo.43.2024.03.22.08.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 08:09:07 -0700 (PDT)
Message-ID: <c0f1e898-7638-4b7b-a938-9e31e5b57e57@linaro.org>
Date: Fri, 22 Mar 2024 16:09:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] dt-bindings: usb: qcom,pmic-typec: drop port
 description
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240322-typec-fix-example-v1-0-6b01c347419e@linaro.org>
 <20240322-typec-fix-example-v1-1-6b01c347419e@linaro.org>
 <230eab52-9751-43fd-8e47-fbfe12410e44@linaro.org>
 <CAA8EJprD3fM966pLV4QXPUu=bFTn24fvPMKOaGqtqkAbdz7sOQ@mail.gmail.com>
 <5ea4a187-1971-4970-a289-826d96c0351a@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <5ea4a187-1971-4970-a289-826d96c0351a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/03/2024 15:52, Bryan O'Donoghue wrote:
> On 22/03/2024 13:28, Dmitry Baryshkov wrote:
>> Then the actual usage doesn't match the schema. usb-c-connector
>> clearly defines HS, SS and SBU ports
> 
> Its a bit restrictive IMO, data-role and power-role switching is not limited to HS and in fact can be done with a GPIO for example.
> 
> /Looks in Documentation/devicetree/bindings/connector/usb-connector.yaml
> 
> Yeah I mean this just doesn't cover all use-cases ..
> 
> ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>      description: OF graph bindings modeling any data bus to the connector
>        unless the bus is between parent node and the connector. Since a single
>        connector can have multiple data buses every bus has an assigned OF graph
>        port number as described below.
> 
>      properties:
>        port@0:
>          $ref: /schemas/graph.yaml#/properties/port
>          description: High Speed (HS), present in all connectors.
> 
>        port@1:
>          $ref: /schemas/graph.yaml#/properties/port
>          description: Super Speed (SS), present in SS capable connectors.
> 
>        port@2:
>          $ref: /schemas/graph.yaml#/properties/port
>          description: Sideband Use (SBU), present in USB-C. This describes the
>            alternate mode connection of which SBU is a part.
> 
> TBH I think we should drop this HS, SS stuff from the connector definition - there's nothing to say in a h/w definition anywhere HS must be a port or indeed SS - not all hardware knows or cares about different HS/SS signalling.

It matches the USB-C connector electrical characteristics, which by spec has, at least:
- High-Speed USB Line
- up to 4 differential high-speed lanes that can be switched to DP, USB2 or PCIe
- SideBand line (SBU)

And those 3 components can be handled by 3 different HW in the SoC, so each one has a dedicated port.

Remember DT describes the HW, not the SW implementation.

Neil

> 
> Documentation bit-rot
> 
> ---
> bod
> 



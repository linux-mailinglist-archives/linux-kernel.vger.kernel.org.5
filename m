Return-Path: <linux-kernel+bounces-90775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07878704CD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B6E288B96
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808F046B8B;
	Mon,  4 Mar 2024 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jw1wR1fI"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022B846525
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564713; cv=none; b=T+m6qrUos8qebIrWz5oKZGXRx/FQYfTUHtzpEBiIwv+7qYMAmJZpYrZyOwH7+pDQpDdh/gJlGsyXX3AOAktjbaJjdFQEMMvO1c2VURKCKRBf8jS7JajreWCiR97pveViVQk7HdWtoleW9zA1+4mG6PyYL39OI8o0+tzn8OQuZ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564713; c=relaxed/simple;
	bh=aFzIYWpLx7ze1PbKKisSlGy++E+y8yDWrJ85BjnO9Ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5HTPvZoxNklKKVEWYZYYqP6wK5t/8xK+VyUH8IMuYK0tLmQSteLaPyUyD+qk6fxgqdENaXcQpS5ETYkS65Pwk+1WrcXSwL+w5LRuTZfkd5i2bVqNDgpxSdRNZ10+1MKF5whQJTvquprH/JbleYP/DHCtIN4uEheO/sYESIn+o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jw1wR1fI; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-564647bcdbfso5318280a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 07:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709564710; x=1710169510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vZJI3H0dwvZmmdTH+7pLS2Jlnz/cwhWbuBa7wLEeu3Y=;
        b=jw1wR1fIGDvefbYt3i7w6BAjM/37zJYx4/u2Otrj1cRBHoyS8fgxHYCPYfK+EHTc/y
         6M2Zk6sM3EL6p5npvlSPqUcdFVfpoF3HoFAN7YSrcOVetRevAdWxif6dyK77+tmzNOeF
         8GYIrTyRkVtfsrmbJye0qYeAi4EyN2G0ejWyWIHZB+A3F7L0/v1IawTI2UNfADrUBjW2
         9KY5DGoXfvEzCk2kCcL4fRyDW3lq+QIBAXFwgzpQn+F+EEPCSWSJhzWXhWGUftknEP+e
         +AdSDwQtLgxZXAsedaTCwmKpHxs5igLsy0US1+xd0KsDguwwUIJcm1gwK0CykF9iwPTi
         +0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564710; x=1710169510;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZJI3H0dwvZmmdTH+7pLS2Jlnz/cwhWbuBa7wLEeu3Y=;
        b=qkrVLgj/2C/6wXr3drHgM3XwzTH6COmwRI35Ho8so3uyJTnfXbFzjWQHrIe0LE+JoJ
         7rHuVoSRv6MZTB0e01fz00Imox2+B/cD041rgV0Uv2g24M8x5TO7Y3mpp7N1ehd9EJds
         pWzu/Lwt9UxgWPxv0BZRVNxTbnAf5/fO5tJKdwawBHl8AyLNOsQJ9HlYB+W8O+DeeBX9
         CLDU2iWlDpX6f2rRAM3biNntKMpXZPqekoAQzOm6ZGGPTCiltyl1X6owd2VpgpdTmpJG
         bPp39G+MfSYIV+49qjN6ag/qEwj/+niQQPzrF4oWY1d0fh8rkY3vnhLS2IJwkBk1PWPU
         jgrw==
X-Forwarded-Encrypted: i=1; AJvYcCXjyKidkoiSPVMokb6mjxwQkz4KuESQmRaq+yAgYcLqOYDNB792k3AU/so0JYYVFQKjvFQ17t420Dhmbb9E8eyUD1pIU8yDx5gvqbUD
X-Gm-Message-State: AOJu0Yw/zAhV6gjDP4Qqmtd1SJnb0hor41JId0jDwm29sKx7FPOBUUZO
	wmg75ynMbUjnqW/pxnrc52hczHFJFNQ5OA75uVRRws+N34ql0VQqGKq0OVYYFRM=
X-Google-Smtp-Source: AGHT+IEnz6QZ+BBBdhwZU2aVBi7I3HTmP7+LI3oH8eZ8kUL+tXj1J3CQ8RXj0bs+vE+d6HYS34PFPA==
X-Received: by 2002:a17:906:2346:b0:a44:f91c:a85 with SMTP id m6-20020a170906234600b00a44f91c0a85mr3249491eja.60.1709564710341;
        Mon, 04 Mar 2024 07:05:10 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id wr8-20020a170907700800b00a4553c6d52csm1105065ejb.35.2024.03.04.07.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 07:05:09 -0800 (PST)
Message-ID: <7925ce69-0cc6-45cb-851e-75a9f19f883b@linaro.org>
Date: Mon, 4 Mar 2024 16:05:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] ASoC: dt-bindings: fsl,imx-asrc/spdif: Add
 power-domains requirement
Content-Language: en-US
To: Frank Li <Frank.li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240228-asrc_8qxp-v3-0-d4d5935fd3aa@nxp.com>
 <20240228-asrc_8qxp-v3-1-d4d5935fd3aa@nxp.com>
 <f8ce39e9-7f06-49e7-92fa-785bd1cd2d1e@linaro.org>
 <ZeFTDSuLEeYrsbKi@lizhi-Precision-Tower-5810>
 <0cc8a370-4497-40f5-9040-1584c0c777f9@linaro.org>
 <ZeH3UhbStCTh04Ku@lizhi-Precision-Tower-5810>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZeH3UhbStCTh04Ku@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/03/2024 16:42, Frank Li wrote:
> On Fri, Mar 01, 2024 at 07:30:10AM +0100, Krzysztof Kozlowski wrote:
>> On 01/03/2024 05:01, Frank Li wrote:
>>> On Thu, Feb 29, 2024 at 10:44:20AM +0100, Krzysztof Kozlowski wrote:
>>>> On 28/02/2024 20:14, Frank Li wrote:
>>>>> Add power-domains property for asrc and spdif.
>>>>
>>>> Why?
>>>
>>> i.MX8QXP i.MX8DXL and i.MX8QM need it.
>>
>> Where is it explained in the commit msg? What about other devices/variants?
> 
> I will add it. These patches are for imx8qxp\imx8dxl\imx8qm only. If other
> platform have problem, it should be fixed by new patch. 

I would assume more responsible approach from NXP, not just "their
problem", but anyway that's not what the comment is. Why do you say all
the variants have power domains in one commit, but now in email says
that they might not have? All your patches are vague in this aspect.

Best regards,
Krzysztof



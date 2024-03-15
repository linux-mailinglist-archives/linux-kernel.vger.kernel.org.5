Return-Path: <linux-kernel+bounces-104163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B439287C9F1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D761F1C22483
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815EE171C8;
	Fri, 15 Mar 2024 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GWjuH9Ad"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B54A17581
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710491610; cv=none; b=SfWKVFwTd/yhDunSP9pFLqAzjtNjNOHfRfsd/xdJYezwzIn9Qr6OEDSXEoW51t9fb/QbV0+761b8tR3bPuV1cXlWlEFURzpZ/nFj+GugroN9BEzN95KkU9vA2y07IlzuF3EZ6c+8XYG9QPdPJ3x4TXxCg4Y2oNic2fQ3SWeWGew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710491610; c=relaxed/simple;
	bh=0pzxmIDKxV1tL0ySvXJiiHFFHL0RmDz5EJr2bm0061M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LvMWjHN5zYyXfE4+JKcsUHOwV8mFA0thEPdR86ZJRX+tTWyfa/WmCtS/NZI4n1PtMLG2rvdE/XCiXtL73pCDAR8X36G2xy07yQeqL0Yi0zFVLSykJDjkP0irylj1soZNNvoQg2nqJ9kEEYzJ7DAjZeJDV7HEMuiWdA78iL31Zao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GWjuH9Ad; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d27fef509eso21502291fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 01:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710491607; x=1711096407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zr3Ym6zKCsEpGspJn2V8yJxIf3tDNmnDHJsng5id7sg=;
        b=GWjuH9Adsdl2pp0UZgVlMH4lvEr4lQzK5XFQKjdLZpoK4OCwo3so1GBhfoLHOlp9PH
         W55gU0AaiCgbFy3tBTM1+Q1njbgsn7MpekuNAQFhskEeuB2ADmMccWUfLvlg5/j6HOkf
         FExglakF0SFEDtgwT9PNulG5za9PIGV79HD+z8vb8+zmg/aQNADWGA1tGu4YBfnpetIU
         TxbKMI/tS4YFUNzdsiAABeTQSAIecjNPiD+Qilyzk9ZPxwUhJIWlVRHGsZ2/8ZMWWcuw
         lYrO9BF/BQHnIYBUs4C6qC6gFer3LRkKEyB1kto7YJDLTyOy6WT/G/7v/MmQmfZfJ03a
         feEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710491607; x=1711096407;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zr3Ym6zKCsEpGspJn2V8yJxIf3tDNmnDHJsng5id7sg=;
        b=VAatQx7uBXHag7MrdDtOGKXwKIzx7MxTk8HrfIgHqIkndEWfkdVEhJoM5g9nfGK957
         q9qj0dqW7QE3Qg0cmq8/CrEWIqpirWI5Ez9EfC/eFLQXGIt6QEQYkB7wx3hEHuJ9D9C9
         AH4QF44CnHrJmAzC8yQC+/EccYbMJmYCthncCaeSewlyJb7UdrCzw/cuPYphJXwW/pig
         Rtt1Nr6EBOTVe7/ErDT2bEvDyU4rgwxU+3fwG0jpYu+2JaIduQp2bbaGMdaFq94nE9rG
         /wHbvgVdOLYxU9niUJexLk+yOdIzsUt/XKRICjWT6FRKd9/Wg9dsWD50Kj1U+zicKuDH
         aWBg==
X-Forwarded-Encrypted: i=1; AJvYcCVrQCI9VKXWraAXkgxvTmOM2C4awOB7Lv76hs96rdyBFvdgvUYZCrkOVtm+iGPHAyc60QoyWCyigIgOWHKKMIeV+yOSZ8R6kgoQV9qG
X-Gm-Message-State: AOJu0Yw5ZPBwQYVB6YfCPZNgrT8WRUukjuT2ivHNJubNjuKec8L5tHKd
	e+tJOQd1Z7T5ftBg45Rp/68PAAGbmNxNTpjKqN2eg1QLnzvw+lOYMSyPODMhG68=
X-Google-Smtp-Source: AGHT+IG6y/hhJMC9+c5VDWWuL3WPPWEAzF2JWD+ATPeQeUlfZqQNPFlrORbh8UKtKu8cmjMC2uBWWQ==
X-Received: by 2002:a2e:b042:0:b0:2d3:f0e7:6bcd with SMTP id d2-20020a2eb042000000b002d3f0e76bcdmr2932748ljl.40.1710491607253;
        Fri, 15 Mar 2024 01:33:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b00413ea26f942sm7699529wmq.14.2024.03.15.01.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 01:33:26 -0700 (PDT)
Message-ID: <4ec0fae0-afcd-4b64-bf26-21a7972a5d0f@linaro.org>
Date: Fri, 15 Mar 2024 09:33:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sdm630-nile: add pinctrl for camera key
Content-Language: en-US
To: Sebastian Raase <basti@sraa.de>
Cc: Sebastian Raase <linux@sraa.de>, marijn.suijten@somainline.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240314200037.549206-1-linux@sraa.de>
 <fc7bda50-279e-4afb-8c31-4fcda0e8b2ed@linaro.org>
 <20240315002338.3fe1dcfc@probook>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240315002338.3fe1dcfc@probook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/03/2024 00:23, Sebastian Raase wrote:
>>>  	gpio-keys {
>>>  		compatible = "gpio-keys";
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&gpio_keys_default>;  
>>
>> A nit: Please reverse the order: pinctrl-0 then names
> 
> All existing pinctrl definitions use pinctrl-names first, so I followed the existing file. Is this still okay?

No, not all. If you are sending v2, why you cannot fix this in new code?

Best regards,
Krzysztof



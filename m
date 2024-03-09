Return-Path: <linux-kernel+bounces-97927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 984378771C0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 16:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2211F215FD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 15:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A05843ACD;
	Sat,  9 Mar 2024 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LM8SEfaR"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3263FB9F
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709996430; cv=none; b=L+hfeeUT/F1slh+pam5Lxt7b4fmcotsYCXolUkofEHo1v16Wi8bTb2mn6DfIPnncxQwvGayqSi/OTNlFERjdfzDBKHmCPBgTIlYn7L+ofKNbfjRz6nF0CLXVC/EVexiDuqjbIDPi2Zs0sV+t7OkHJjKMFkVP6hYC3j2qZn0E61M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709996430; c=relaxed/simple;
	bh=OvfWJNJDU81omg1NmON18Hw3qmdbiI8lTYPpBXiEqVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQXQC+8imq9Pumxe4m/dM+C8D/sBjgprd7/FsSvFHRN6m+zaeKnJ4dsD6QUxkX+RnVT8nQxQ1PKtEAakRliKzqWqil5VTyGg10IyxcqZpNFyf44LpfIVSUKzF+D4UnOr/P1T9wtnVzubeGxMoDlltYrKY3iima7NwDiqVrqWwU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LM8SEfaR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4467d570cdso210227566b.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 07:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709996427; x=1710601227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OnfRxqBj01Ms+OYJOxmdm9ZV/lLNiKHxQ8hOUSQ50uI=;
        b=LM8SEfaRNEFmVBwxfWHayo/SNWL0VgckVZS2TBOr0+PSpGLlwzmB/wcoBwEaGsE924
         5ELs+XdpzGP2YPqoHyhBACgyshYXIjWpbFm7WXZ22DDPpEYZsL701e9PfwaUfH6SPKml
         RhoF4eFwoAkpoCbFkqFxP3rFauQlg3Pa66kn3fx8H/atYVV2OpVE2FpzmHu/TGGueTIo
         InUfH8spCfDw6E8GlDfPquOuo0qt4wg30NjOOKpHx18pplHFsp8jygf8k2sXPFaed82b
         xDdntyN/QeeKBq1oBbZxYOj9url1QmPKTRI1ER4/dILB0REnzziBQ2fbIgYaulQMdWnk
         S2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709996427; x=1710601227;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OnfRxqBj01Ms+OYJOxmdm9ZV/lLNiKHxQ8hOUSQ50uI=;
        b=WDGzVXaCzWx1NHHSqoiAV0HPv29wLspYzWBHJAS/iVzxMi/WMUYZHDjQpI2oZZ1UVL
         qBNJGyg0Z2ISGhh3gfxZ3iu8ezZpG2Xvrt4bp+v64HwjsOWI07TNawro2YLueSvs0dYq
         ST+T4Y2YMSETDfi015qhPHHA9nwjkykTJ25OlJI4ThqYHumvqgBu32h0aLzAHzv62kbm
         HwuI8vzXsqA7ThC7XTQZRqUcNY0hIKSmStPWmZzL7+q9sK1cs/I2biITrOGJtn7X5uzI
         RoPlFSWV6isA6K2CMEf2+4lovqzCaOcpxp7hQV1/h0+QDUcRwG2BNiL8+WEkYflmZ7mp
         N//w==
X-Forwarded-Encrypted: i=1; AJvYcCVqBqwmjinlrWNfiNVlTiFo79qWzRf2VDJ6K489q5D0u8pJD4NVgIjV/hUrUPu7JQGdKHwkp6jLJnu8zOrLqeOsHu9Iz4V4W997f7JI
X-Gm-Message-State: AOJu0YwJyl/coRovhXipR5Bt3s3mft9NcYWcBWE3O6D2obv2h2bvaSUW
	IJ/6sadwedV3TvblirUFcVm8CmCfdLhqRPbs6w51pZiuB6fj4lRWRtkHpvtR3L8=
X-Google-Smtp-Source: AGHT+IF0rumUZgQS6BYdusxgGYVlj0twL4YVgze4/SlrihM/xxPBSVwJPAU5SPQ4ApN5FnWFn5wMFw==
X-Received: by 2002:a17:907:a783:b0:a44:e90d:c091 with SMTP id vx3-20020a170907a78300b00a44e90dc091mr1022435ejc.59.1709996427305;
        Sat, 09 Mar 2024 07:00:27 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id gq14-20020a170906e24e00b00a3d2d81daafsm973998ejb.172.2024.03.09.07.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 07:00:26 -0800 (PST)
Message-ID: <7856f1b7-e12a-4530-82c5-416ec66e1885@linaro.org>
Date: Sat, 9 Mar 2024 16:00:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: trivial-devices with vdd-supply: true
Content-Language: en-US
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1ee8fc6f-5299-4ba5-bb61-14b4351c0708@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1ee8fc6f-5299-4ba5-bb61-14b4351c0708@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/03/2024 13:22, Javier Carrasco wrote:
> Hi,
> 
> I am trying to figure out the current policy to add trivial devices
> (I2C/SPI devices with at most one interrupt) to trivial-devices.yaml or
> include a dedicated file.
> 
> Apparently, bindings for the same sort of devices where "vdd-supply" is
> provided require their own file, and I wonder why there is no
> "vdd/supplied/whatever-trivial-devices.yaml".
> 
> Instead, files with trivial bindings + "vdd-supply: true" are added on a
> regular basis. That property is not saying anything specific about the

Anything needing supply is not really trivial anymore, because we want
the supply name to match more or less what's in datasheet.

Solution is sometimes to allow generic "power-supply", like panels have,
AFAIR. If you have new device, just add new binding for it or add the
device to existing binding with very, very similar device.

See also:
https://lore.kernel.org/all/YUz+psAILnF5L5GH@robh.at.kernel.org/
https://lore.kernel.org/all/20210921131804.GC1864238@roeck-us.net/
https://lore.kernel.org/all/CAL_JsqKJgvK8g+zbzLCBxnKbgAioBcdHWNAvqe4Z9BzkNMwPpA@mail.gmail.com/


> device beyond that it needs a supply, which is very common. Is that
> intended and no more generic bindings are desired?
> 
> On the other hand, trivial-devices.yaml includes several devices that do
> require a single supply (e.g. several sensors), but it is not explicitly
> documented. Did the requirement of providing vdd-supply arise after
> those devices were added to trivial-devices? I think that some devices

You would need to analyze the history... requirement of providing
supplies was kind of always. Just like trivial devices were.

> that were added to trivial-devices in the last months could have also
> had a vdd-supply property, so I am not sure about the rules to choose
> one way or another.

https://lore.kernel.org/all/20230505204810.GB3506915-robh@kernel.org/

Best regards,
Krzysztof



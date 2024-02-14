Return-Path: <linux-kernel+bounces-64914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFC5854498
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3417728D841
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0562410A3B;
	Wed, 14 Feb 2024 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RJDAQngR"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED3AD4B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901553; cv=none; b=na1NdO92hRi07/EiT8gpyFzZAD7pxHfrKHNo25KxrWRiwGuE0OfGrlfwDg5P5VXMMh4/n5zdBjG8EhHCww+4KkUkJwYSHd+WYz62QjgaXpD5YOKb2G6IiH/QdNuvGSp6Vy4KCHTX3Nj7gpG+ER5XVLPbY4TItogv/ORtHFpFDOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901553; c=relaxed/simple;
	bh=I8D/NVeZlWyXUSuy1g8l5l45XPggH39b8RzJqNF+BpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=boOdmPbJUxeSMFrj0EZqegJFhtb1ttbqGN2C/EJsBI8eTU7j12LIvOKO9IK71581RDv5QoIA+QOS31taZxVCia5FeN5ZfG333Fw82pdmk297JUMtN18D/Yu5YbQe5s8izwdV93UaLS498duH9hT3PwvddD9HKfOaYqUuE9KntCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RJDAQngR; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5620595f743so1708800a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707901549; x=1708506349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/lqba7VkE2HTVepiVP1TeOFkS6pBAOY08pjklGS4aIc=;
        b=RJDAQngRn1Qf9EB7+wcTUrfKMmOBlcW1siXsRLbfm5mH5lVO1yXQJ54yIhdXorCn/U
         j5g1vSahdvgUrknFJ2oF04+8XehXS0FtjZhSTyndd+AMTFtI4s0tONZEtGGsOOrf9exa
         FdUDI3eE8muc1kIPhs2TQyYf/hVJcn5z0XQn52zTOBXp0PjVNpZ8YB3qT2DWbYh8XrMr
         NeZxBJbjqjk41IUO9HA/C5mQckuGriD9UBeAyQnHd5xQrnZ82JJ+jh/lhkIQ97YXQsjI
         b8m0HpaslRNjDeFU1ZSA5hSWFnpE42wcjPg2ZIw4fyvo8D6UGgFVvl+ODM26+W8Y3xRm
         7VZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707901549; x=1708506349;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/lqba7VkE2HTVepiVP1TeOFkS6pBAOY08pjklGS4aIc=;
        b=V7lwEPGRCNfts4OUABSOM+5zSa/RUAvOT5vTzcRRtwGYhpy+RS9bxNe7ipbm1U+rIK
         iZIxcWDOW/C9/qJ8JMtKR1AQXMQ/06FEy7cVUD7vq6hoC5YqacS0MCKvU+vhrU81ixHG
         8oZkv6I7semGagLzDgHet2tjZcultkDwJTOnxx/XTUK67irRxRefkrqP0yGPE+rpFA/D
         LW5KwSFFfcCt9DB2xnINt0DXNg1jhhnxcyIH9/XOrp0hpPssT32miUwRI71MRURnxu0g
         ZHwZSCnPXea2DdOlAcw98M14SKN3lOAScLaNmkbdhOXK0PQA7i1NH0GBCphwBNVjXAmi
         yKTA==
X-Forwarded-Encrypted: i=1; AJvYcCU+OLhDRC8CvTpGXn0mDE70E032UUhbG1E0oXijGtHkJXaUFMkF/MM7YeKIJ6flQuxUr4SzfCmE4XhTkgS4TdZRGU9Z8XYRKFbgoOhA
X-Gm-Message-State: AOJu0YyfSwvwgoG1vJwGHF5LGU8RIZS37tfzbu1Xx/Ia4qvo51QQ/39x
	mf1sFL7AuTRqP3CS7yaFcswmEEvNF6ohs1ngYM6wnxTzPQnch34Oxy6Hd2SUmOA=
X-Google-Smtp-Source: AGHT+IHpfzSB3UUkNobzLN8Vi9rrVWDrFR5E2F7N2kju1nQrJg5vax6bdIsqlAz6p3UUZxExtRBB7w==
X-Received: by 2002:a17:906:5a8a:b0:a3c:e99f:c08f with SMTP id l10-20020a1709065a8a00b00a3ce99fc08fmr1377804ejq.40.1707901549703;
        Wed, 14 Feb 2024 01:05:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFzIXfw3EKu3QR3Lpmz52Q0qgGCEIZ/NIRWL7eliD7DpXtG+mo+WvSbG4lvj841OWGLwIlI60JnvXuYv9ZTnKrb0wOWFd02g/qJ/p7BKwg1t503KcpT3dPAarBHwShgUjZT2T/w69kxB3ldvrTlzP7pYgE2mdl1pnhaL+UnFrmy8muQweceYPU22idzltPLBpA1TUSyByulXPo0nbuenXzoF7wSujtfDuQMSzZSH15EHb/eUMvklt0SD3NHHMsm/Lr5KdZo1rjXRMOviuyy9ZOWJTSR1KBSZuaPOgMFmpcA4wffn8hVgOYhM0kddkMz3LqPMtNc0CvHyUXuGW9eagbIzI4ftSXl+L61ETGDO6t4TRNWwsG4crwHaSKiUoqK704+swd356+sDYepExune427iTh7+tObD3QduKdAKewsOlGLx7LEJ92VhxUPVypWi3QL/W/xzFFDNZ5GvbxphyZ1nFcmppaKogeUf445vH7QeTH9QPN
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id th7-20020a1709078e0700b00a3d07f3ac61sm1363299ejc.101.2024.02.14.01.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 01:05:49 -0800 (PST)
Message-ID: <2dac95be-b23a-4c42-ac67-241100c7a51b@linaro.org>
Date: Wed, 14 Feb 2024 10:05:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: pwm: mediatek,mt2712: add compatible for
 MT7988
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, John Crispin <john@phrozen.org>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
References: <20240213164633.25447-1-zajec5@gmail.com>
 <onnokyq7ciza7i7jzc74cun2khpst5iocuccks2cm433ux3za3@dou4oacrvuxj>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <onnokyq7ciza7i7jzc74cun2khpst5iocuccks2cm433ux3za3@dou4oacrvuxj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/02/2024 18:48, Uwe Kleine-König wrote:
> Hello Rafał,
> 
> On Tue, Feb 13, 2024 at 05:46:32PM +0100, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> MT7988 has on-SoC controller that can control up to 8 PWMs.
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> 
> please make sure that the email address used for sending the patch
> matches the Signed-off-by line.
> 
> (It depends on the pickyness of the relevant maintainer if that is a
> stopper or not.)

Does not have to... It must match From field which is correct here.
Syntax like:

From: Foo <foo@com>
Signed-off-by: Foo <foo@com>
Signed-off-by: Foo <my-other-email-foo@com>

makes sense only if copyrights change (e.g. change of employers) and/or
one email stop working. How would be the point of having to SoBs for the
same person in other cases?

Best regards,
Krzysztof



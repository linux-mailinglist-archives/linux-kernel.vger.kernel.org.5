Return-Path: <linux-kernel+bounces-131364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4BA8986C2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754E228FAA6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ACD85269;
	Thu,  4 Apr 2024 12:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zpaaywsu"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C257583A09
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232257; cv=none; b=hPK+eyc+9BniPws/jWOi1agh+7gh5OEeKMp3P0ZgHSPmn85nK0E6GduJxDWRSSPtbNwSU0F6mm5hvxDmdIzzFkRcJeyBaZQHqxIbWt+I95eMuNYRU6llg6G8BlOjzwyjdc1j4lTY9eGZqPFrlqlPCD/5/66EfV4ezVVl0ZIhNRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232257; c=relaxed/simple;
	bh=UScraqXPPVJ0cjYlAUkodB9M6d9/T5aTAQ5aSjNT6F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KyFJPmWcHyecke1rk35SsF3VU0gx7MNzcqtPsJL3iLfnXa4edY/nmc3x1kZBaZFRO6CSEV070FkFuSglSBvik+qtFkxnNqi9EXKIknHXf2z3wMF6enxKwv19jgV0mU3SCgol5D9u2TG3n7tGACrx/5q+va1+09tMKnrJrpAVJzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zpaaywsu; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516c97ddcc7so797044e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712232254; x=1712837054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m9cPHQQe1Hj9Ffz8OM+GePjteUbhs1Uu0DY8ScLn9tQ=;
        b=zpaaywsumuLi3VFJf2xTDyGjAzfZCvMFltEwOvYSuE3lMk7YCXojzhZjCyJcAsCpbP
         6f4BbjpxoLnzuvxQGVxxADfu9KLIrlBkw9hA90+ECbtllzkN1hvyj3QAt3h+TdAflpJA
         Fn65B671RFFMTLOprzc0sKhOvfCe6r+tC6fkWs9RNUrQFcAl1APcPboMqBm8haKnfhpa
         FB9jQFqtGmMDmT11OdhQT/D4x6OAMCJzb8FGzIU6WvNROFgNSf0g7dJr8BLC0oRPgn1b
         Ognnnefsey1eJLQPXJj1iuSbB85p1BwNn4Cfo/YMn2Se0OL2BY1yUzqPZyTA9rs2uWKO
         8BLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712232254; x=1712837054;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9cPHQQe1Hj9Ffz8OM+GePjteUbhs1Uu0DY8ScLn9tQ=;
        b=iKNSsBH5Fzot+JN8rYvAi9bGj8OU6c/bJd8NL5NGE9uIsnuReQ/F1cA2r3TyM+6LTY
         FbknojjRTIz7jCkF5ubI6Epwr0P1kRgTaULaxxszseFBogHI6shlOeUeQjplfBwpW/D5
         aC7MMWzB2UNdWZoEJcrY63sa8cW4mZ12uDumPQPbb8ovCF4hBSdOgFQEIW7rzpyKhA/l
         D7zGHKTneaPGC+yWEfnleq2+HjvalhRUTVLeDocrRBH6dLV+8k9FbfHa+5/cEhM3D40r
         ihudLOOdGWTSx0Iq81V6VMuQ9cdMLJuNoHFSt+WPCxNmKqSl6YfLptC3Fzh3iEDYhAbP
         r5nw==
X-Forwarded-Encrypted: i=1; AJvYcCVywFJ5L925Cy+yegk6L0JEwqTJ8dxQbFwpNmE/ThFgrS5Cb94CadWrtU276iIuEVo4NAdV+bX/cK9B9Q9GV/PjppWVWkungC8qNkH+
X-Gm-Message-State: AOJu0YxcWUpToW5XKDtMd8+ft2n6RVjuXaxqWXby5VHuyimXow3IU9E3
	6HIJpAMs2QPANkEbSMMdTRtcf5URV+j4FdozS+/zOrpU3di4EN9PNRmBcXdZ+cc=
X-Google-Smtp-Source: AGHT+IFcCvhoAGbUsaHwpZRA4Qosof6fz75O3swKqNETnkXCzHGAatydq/YMcmYrcoCpZ2LVIWrLYw==
X-Received: by 2002:a05:6512:748:b0:513:bf92:79ad with SMTP id c8-20020a056512074800b00513bf9279admr1633910lfs.45.1712232253993;
        Thu, 04 Apr 2024 05:04:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id ew12-20020a056402538c00b0056a033fa007sm9068238edb.64.2024.04.04.05.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 05:04:13 -0700 (PDT)
Message-ID: <8f37211a-57ed-48ab-8de8-cd5a0d4c6609@linaro.org>
Date: Thu, 4 Apr 2024 14:04:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: mfd: Add ROHM BD71879
To: Andreas Kemnade <andreas@kemnade.info>
Cc: lee@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, mazziesaccount@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240402193515.513713-1-andreas@kemnade.info>
 <20240402193515.513713-2-andreas@kemnade.info>
 <6420ac43-f200-459c-8c38-7cd55c64a155@linaro.org>
 <20240404123010.69454fda@aktux>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240404123010.69454fda@aktux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/04/2024 12:30, Andreas Kemnade wrote:
> On Thu, 4 Apr 2024 08:59:54 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 02/04/2024 21:35, Andreas Kemnade wrote:
>>> As this chip was seen in several devices in the wild, add it.
>>>
>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>> Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>> ---
>>>  Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
>>> index 0b62f854bf6b..e4df09e8961c 100644
>>> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
>>> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
>>> @@ -17,7 +17,9 @@ description: |
>>>  
>>>  properties:
>>>    compatible:
>>> -    const: rohm,bd71828
>>> +    enum:
>>> +      - rohm,bd71828
>>> +      - rohm,bd71879  
>>
>> In your second commit you claim they are compatible, so why they are not
>> marked as such?
>>
> so you mean allowing
> 
> compatible = "rohm,bd71828"
> and
> compatible = "rohm,bd71879", "rohm,bd71828"

Yes. If there are reasons against, please briefly mention them in commit
msg.

Best regards,
Krzysztof



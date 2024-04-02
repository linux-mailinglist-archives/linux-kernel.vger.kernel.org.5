Return-Path: <linux-kernel+bounces-127895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1548895275
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570AC287655
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AB374C1D;
	Tue,  2 Apr 2024 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldzUuP/q"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A6976C61
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712059637; cv=none; b=KNYOX2p5bnsEKhiaRAC5Qfmmm2Pgios8vRcuR5lxQVCvArwLx4njBo902Hy3GVj9Vwr44Q1KKJc6ZI0YK2QflfUQjzFRwXQPbmgZer02D14wuYZFpG9I2+rr0kCW0doeMVRE69V8xDZbkhz/4JSemQiWIUwUagzO8mCaXYp9CIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712059637; c=relaxed/simple;
	bh=LJysKHt/G76byYSFIHYYrO8UFHkz066n7YDdzbCF7H8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oAYpMEZbcHhPZ7S8T3pOQe0Q525Zy8f/XAkUWrdPzkEP2om3i+myJQyS70EnFtCe4fE+0yqlE8Cdtjfjb71sF9eT3or0LEO+cYdgZQUaZPBgzhMKafq/PsUQwu+OTGbNoxUn6XFVRBR4Eh+3vCvDmuEiEODGcC4JqKHbEqgb/yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ldzUuP/q; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a46ba938de0so669935066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712059634; x=1712664434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bu1NZHpiJwJBsJMpdzoT3mwXRazMJ14vhFwwufBSJvw=;
        b=ldzUuP/qEanIj6eYRqaiocdgSgtXNhIbdK6w6QMY1h7AFXxhU8HpnMvilC+ETOwL+r
         346fc7nlXV0zYrzFL/uzGEEIGVQ6LnzxHNI9lDxf9R2qElEjn5YNWc2AYzJ9Gjtbc2Jq
         kht/Loyu/GORQ/qfo19IV9o5KmjZxzbREB+oP1WzYHNJDXKrzK8dDAze+v7bLnha3l9J
         dM9cpT+qo52FROIrcfkWYbRAW2P52Fe4wd3Coq7WWtXTZSrmg8xtykKz3BQHeGnJ4wzx
         mymOgQNgHrM0GiPiwaKWO7ow5zsI8K0l86o4Itdu8EDKPpUuj7wiXobGfaup77nNLt9e
         PTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712059634; x=1712664434;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bu1NZHpiJwJBsJMpdzoT3mwXRazMJ14vhFwwufBSJvw=;
        b=jHxXD+pefFtkk3now5Quv5QsAj2B2yx7oVvUEFdNrfSHGByVwiLn/n/kLFM+dmVlOI
         fmh21ghFMs1cUt3CBoV5KAo3g+VW6kwXUZT0sImWhrZCevL0TaWjksdP+/iCRiGJATl0
         +H9hlv4cVi3DcbhUl9Gc7oyZTcbgeJ7yAUljd5kFN585e8wmyIepfkBg22U8gZSKnNcf
         zVew3nHmIS0ZxeQWnsEh3d05DIOkjDRzlFvOqK3forDb3SAggBkjMIZNdQVOSSKQiQIh
         zzsZmsVbZ1VP7P42ER6qO/NBanEicp40vGJw/4B3VWB6r6NL4G+rutJ0jgVEoBzaJy+H
         JCWg==
X-Forwarded-Encrypted: i=1; AJvYcCXqPd7DEvBq/zdxAzmBps+DSOhyaGo2suukPgiJvuANkUtaS3olxzJmSU0yna8D9kQMTx8ZF/vzOHIDAlySjUnzWrPibCsEMLBq9E0J
X-Gm-Message-State: AOJu0YxBhWlRPJChlYXH7mwMvQ9P7ACQTMYnJceQ/Y2LW1Pt+zz/TWLF
	T8zg/DO3NSFx2xqtHstbQS9MOGbeoI7mb/uQw3QsczkfKhJ7omOm+CYw1a6iU+I=
X-Google-Smtp-Source: AGHT+IEgIUMy6oJvR7bl3B1Ky8W+fUm2ue1yAgUuXGXQNM5attKUq9jSjoWGKSEWzwcctq2FOBzs4A==
X-Received: by 2002:a17:907:26ce:b0:a4e:67ca:1040 with SMTP id bp14-20020a17090726ce00b00a4e67ca1040mr5152652ejc.14.1712059634339;
        Tue, 02 Apr 2024 05:07:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id et12-20020a056402378c00b0056c3e65caecsm6699432edb.2.2024.04.02.05.07.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 05:07:13 -0700 (PDT)
Message-ID: <453ecc3d-c585-4665-bda1-b12ffa8d6967@linaro.org>
Date: Tue, 2 Apr 2024 14:07:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ARM: boot: dts: microchip: at91-sama7g5ek: Replace
 regulator-suspend-voltage with the valid property
To: Andrei.Simion@microchip.com, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, Mihai.Sain@microchip.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240402091228.110362-1-andrei.simion@microchip.com>
 <20240402091228.110362-2-andrei.simion@microchip.com>
 <34543ae2-4e78-45a4-9cff-389f7495fd4a@linaro.org>
 <312bed1a-0b8a-457d-a2e2-b8ee1b6f443b@microchip.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <312bed1a-0b8a-457d-a2e2-b8ee1b6f443b@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/04/2024 13:27, Andrei.Simion@microchip.com wrote:
> On 02.04.2024 13:39, Krzysztof Kozlowski wrote:
>> [You don't often get email from krzysztof.kozlowski@linaro.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 02/04/2024 11:12, Andrei Simion wrote:
>>> Replace regulator-suspend-voltage with regulator-suspend-microvolt.
>>
>> Why?
>>
> 
> at91-sama7g5ek.dtb: mcp16502@5b: regulators:VDD_(CORE|OTHER)|LDO[1-2]:
> regulator-state-standby 'regulator-suspend-voltage' does not match any of
> the regexes 'pinctrl-[0-9]+' from schema
> $id: http://devicetree.org/schemas/regulator/microchip,mcp16502.yaml#
> 
> no property named regulator-suspend-voltage in
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/regulator/regulator.yaml  
> so if it is using this property there will be no effect as it was expected in 
> https://github.com/torvalds/linux/commit/85b1304b9daa06367139b471789c7ddb76250b9f
> 
>> Please explain what is the bug and how it manifests itself. Is one
>> property incorrect and other correct?
>>
> The main reason is explained in the cover-letter but if you ask me to explain in each commit I will do it in next version.

Cover letter does not go to commit history. Each commit should explain
why you are doing it. Usually piece of the warning is quite
self-explanatory, thus one easy way to achieve the point - answer why.

Best regards,
Krzysztof



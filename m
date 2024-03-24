Return-Path: <linux-kernel+bounces-112815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD09887E86
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EA7FB20DB7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF93DDB3;
	Sun, 24 Mar 2024 19:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT6TFEEV"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB0C17FE;
	Sun, 24 Mar 2024 19:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711307149; cv=none; b=b49hMEDOjphN3N7RttWnp9pfdVrCMzUeaUubmhaZSUE5JnNQsBuGyNhpDeSBO35MAaztHEnBqynI1+cTg3asve9Yfnk9PlShICIITGh18mw3lC6820fe6IZGJgWNY6J0hak+JgBbvyS4rvbw4RTy19KulqaVgaGigwDhrnq3xeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711307149; c=relaxed/simple;
	bh=Ba3kjhiP6SQpATgAj98BY87JCQv8Qb8fcnl864/zUec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eLIcf2lROU06QaCWjp9/xCYi7dUfLMcbR3pY65RmSH2Jas8Skrug0uzA7/HhMOOQoGuL0QQMARNGgFDeiLOMlq5nJPfi3IFhOwd/6fzMzBQV2X4TQ33loK1Hte7lXaV1hgxSA4nq55WByMOAmyhxrC1mYRWMZfJzpuiqIcMROxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bT6TFEEV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41485b58b7bso3191185e9.2;
        Sun, 24 Mar 2024 12:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711307146; x=1711911946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y/vGi9mIqib7R1uxthBhoWVrJSnd7HDnqCJJjjy98Rc=;
        b=bT6TFEEVcgrApoUzVSdxR4v5Dt0m68Ja76CTU6GXJ6EYKp4QDnhtI4zkWkLdphsA20
         yvYXFfPO9mYYUqwgsoEPqyKtq4RSIKOmn2yswb1Kkg9epIhX5YyF1P91qg3MbjAu6KSN
         ET6GdKUioXFvIZBOTGHPHIiIPr7aOQxlxY7IL2/1LZy6bJFKH2kFqKYjpr0CM+ymiirC
         XQ5tdeWylkciP+QkLtTeC0OTspOuDxAVQvX0rmBF0xffbcVcEjNBAOUs/HTTVfIIytwP
         IIX+pm+li5Bx8YtNQ62usxk4olju/ifnhagy57YJTzCDeu/RkrM+ABiEdiAakzyhQ9HT
         MkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711307146; x=1711911946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/vGi9mIqib7R1uxthBhoWVrJSnd7HDnqCJJjjy98Rc=;
        b=VpspPIqSXRdPIccQShfdHHaRA0A8V4SLJRAMEPA5UyOTrzrD3/A4wjzik+SdXBuwQK
         +gypPyvXawpLEllxs6Mvyw62d8ZGdrDwFBDe+M24fBRoxEpp9vK2n8s/ZyZBGDj8yu7b
         B3SFKjwRzeOxromjCGeZfDYgapsTjGg1/1+5CtLyz2FfoZyzzZKTDYPycG1SyzJqHwiI
         mkpecsTT5uAmV/Olqr5rdPjpVysYApb0LTj6Bxn4xWCt2RV742cFx7kPG6v9DGK4U1c/
         1M5k9EqVIKsog7380iv+GgN5yvZND4E7kij2H7k92CGnKyhAOqq7yOWDi70/1/lZZpHC
         Ixpg==
X-Forwarded-Encrypted: i=1; AJvYcCU174WPS0W/t9VzpFPGzDEcjLMNdiQMLAasOqeIV+4jiX7z198f6PSMLnykrKXnOE4hBxxZlHaAe7z+UdJhv7KAAJWOFd74Vw09lFlcinPVqg4QrvsX3HH48Z3KjNegV3W3nBQYs9hhu965P0wsiEvJItEYpW+7hzv2nsbqQ2uPxCVakQ==
X-Gm-Message-State: AOJu0Yy/PmQYfBcSWIFeDOGJ/LdCdc52k2q6ioYHxESVrDx/LocUqW/U
	65TqTI4FvC216U1syKwjFlC9hCitk5oyUKDoYPwwvN4GZ4z0fC7Z
X-Google-Smtp-Source: AGHT+IFExVmL53lKILc8q5yW5V63K/emv1t9YdL7Q54eRZ1zjCPdModFP2EqUlorVAZSdwx7IScHHw==
X-Received: by 2002:a05:600c:5c4:b0:413:ef97:45e5 with SMTP id p4-20020a05600c05c400b00413ef9745e5mr3548347wmd.21.1711307145597;
        Sun, 24 Mar 2024 12:05:45 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:2e5e:f14e:aa7c:2010? (2a02-8389-41cf-e200-2e5e-f14e-aa7c-2010.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:2e5e:f14e:aa7c:2010])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c4fd200b0041463334822sm6018443wmq.26.2024.03.24.12.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Mar 2024 12:05:45 -0700 (PDT)
Message-ID: <d4bebe80-ade4-4b91-91e8-6d67fe4b69cd@gmail.com>
Date: Sun, 24 Mar 2024 20:05:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: health: maxim,max30102: add
 max30101
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matt Ranostay <matt@ranostay.sg>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240321-max30101-v1-0-00b83e966824@gmail.com>
 <20240321-max30101-v1-1-00b83e966824@gmail.com>
 <20240324134615.0380ef81@jic23-huawei>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240324134615.0380ef81@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/24 14:46, Jonathan Cameron wrote:
> On Thu, 21 Mar 2024 19:33:48 +0100
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
>> The Maxim max30101 irs the replacement for the max30105, which is no
>> longer recommended for future designs.
>>
>> The max30101 does not require new properties, and it can be described
>> with the existing ones for the max30105.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> Given there were no driver changes, is it fully compatible?
> i.e. Should we have a fallback compatible here?
> 
> properties:
>   compatible:
>     oneOf:
>        - items:
>            - const: maxim,max30101
>            - const: maxim,max30105
>        - enum:
>            - maxim,max30102
>            - maxim,max30105
> 
> So that a DTS file could use
> compatible = "maxim,max30101", "maxim,max30105"
> and work with older kernels as well as new ones that understand the new ID?
> 

According to the manufacturer, it is fully compatible, and apart from
the pinout, I could not find any difference beyond the device description.

I like the idea of having a fallback compatible for older kernels, so I
will add it to v2 as you suggested.

Thanks and best regards,
Javier Carrasco


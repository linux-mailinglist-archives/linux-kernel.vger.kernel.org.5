Return-Path: <linux-kernel+bounces-76074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639E285F29A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2C40B23A0E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AB719478;
	Thu, 22 Feb 2024 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UoJSDJHF"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950A821109
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589605; cv=none; b=WrwxgaKpLgwl76Q7YOe2rXs7dMXfihXWXlt28wBF6zPNs9Rdau0RVMsB7/rJ0l1rMHLcCZzo6qf9bxokixcmdQohb49tof02F7CErb+IuKxrp8Jyrcg2U2gcWuVlpQ20da8iESQ4UDC4GwEAA2qZGNZmNDCOhDw5RoRssC81Pak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589605; c=relaxed/simple;
	bh=NPT3PWmW4zgM++6hb6uAZw1T7a8vx5sGqAALjqa3r2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vAmAth6vJEFuGJLpxUbf3zcLjsknEt6gmAuu5R4We2Y/WUDFasxOggSJgxjmMsaxDVKdufQ3l71P010dCjF4icRytf8crpFkWrpgMDipTIoi0sKKpBzSSRsq18mg8hLofk/dhNKdil6jLYhLDiXzmcEePgLQd0W8ifGw6e2afvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UoJSDJHF; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3f4464c48dso174595666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708589583; x=1709194383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tyk4T9TEQQ5JCsQPipNXRMcoozCsfh8H/KvBrA5AA4w=;
        b=UoJSDJHFmPonj/stF2IQQsRdCjtNc80S+bQyYJmvOU1Os/ml6mEXtJfyGtswn2izlY
         QxizdKY1WSsWoYEKa/zC2wFOd47Hl03nGjodvCy5g5xu0tp171zzTU7kpAAL2jc3e0AS
         qQYzYoGrpcY+la+vXSMHkn0du4l7TCKnwmvAQJJSD1wHchuqFGQSawJ7IQiwqVHQlPkm
         fDi7lqDgISyLVuvJau3kkFcOx2Qhq+N5vUNzNu0k/JcFqesTyMNeZNCZm/t8OMx6ytK8
         StYCE5T26xVZUQ933SJteGOS9vH61O41uPacBI9ppqaerE914ZEkmrmsONPwMUkQ5dBo
         MUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708589583; x=1709194383;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tyk4T9TEQQ5JCsQPipNXRMcoozCsfh8H/KvBrA5AA4w=;
        b=v6M21TpQJcqqZxznvKVRVp7c91WXq1LUdnMRUYyRiJY5KwUOxW/Asxc64PynNvAG4Z
         7tPrbb5bdW0oWJU5IA8b7jVRL3C+Vhyd+YcawGxpnnQa1bdzl0zKH+6rhs17Sw4BdYUy
         VIRWfqG2GEVuj4g7mGgg3JxJvHjkTQCIVHIDUTAdyivr+8YNLR/jql1GXbjssrY+GvYW
         XQ6V1dTsVklBZbEb5EmNJ6tnWNix0lQr8Luoy3CqwbufcsjmoCz44DVsXc2wtL69+Noc
         YZj9yiTS0j8L0LJRfyM+oR8DCn4uaW/5LAZ+9xOCwi04uJiIqpzQVuXCKXxLo2U7o6AQ
         nu1A==
X-Forwarded-Encrypted: i=1; AJvYcCXdFHuFzPHCONr4/IFXPP/UhD5Cvs4uctqi8Q5odov+m47x8M0gNdea7R+YgB+SDHYoMSCPMXenQAuSoh+lX+/vRTEVs9qaOWRiZ+Xi
X-Gm-Message-State: AOJu0Yx6f9QA95cDSC80WXJFTa7nNEBmtwcnR1UpDXbfcBml6W5CYG65
	k5ALFeSLp3WlbPN2NM596O6aAriWVEyru6grFizfWDBHwzzzYKylN8375gRrfMc=
X-Google-Smtp-Source: AGHT+IE7h9IG5FIFdz3wdDPelpfZgYLAu2HWcBxgqx1uOiDdqh6RLg7kAgabuJC7rQSpFc1G3w9lZw==
X-Received: by 2002:a17:906:1698:b0:a3f:86ca:ed2f with SMTP id s24-20020a170906169800b00a3f86caed2fmr705637ejd.49.1708589583095;
        Thu, 22 Feb 2024 00:13:03 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id m12-20020a170906160c00b00a3d0a094574sm5683084ejd.66.2024.02.22.00.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 00:13:02 -0800 (PST)
Message-ID: <40925c33-0b1d-4eb7-8f83-85efb6aeae4d@linaro.org>
Date: Thu, 22 Feb 2024 09:13:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: arm: aspeed: add ASUS X4TF board
Content-Language: en-US
To: =?UTF-8?B?S2VsbHkgSHVuZyjmtKrlmInojokp?= <Kelly_Hung@asus.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Kelly Hung <ppighouse@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc: "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
 <joel@jms.id.au>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
 =?UTF-8?B?QWxsZW5ZWSBIc3Uo6Kix5bm85bKzKQ==?= <AllenYY_Hsu@asus.com>
References: <20240222032504.1147489-1-Kelly_Hung@asus.com>
 <20240222032504.1147489-2-Kelly_Hung@asus.com>
 <2ab9b3924dbe07039e934d4580ab7dd397a31728.camel@codeconstruct.com.au>
 <TYZPR04MB6596F2EBAF65F7F53809C2259D562@TYZPR04MB6596.apcprd04.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <TYZPR04MB6596F2EBAF65F7F53809C2259D562@TYZPR04MB6596.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/02/2024 08:32, Kelly Hung(洪嘉莉) wrote:
> External email : Ensure your email is secure before opening links and attachments.

Please send proper patchsets. Patchset includes all necessary patches:
First binding then DTS.

Version your patches and provide changelog under ---.

> 
> Document the new compatibles used on ASUS X4TF.
> 
> Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>

..

> 
> Andrew
> 
> <p></p>
> ===================================================================================================================================
> This email and any attachments to it contain confidential information and are intended solely for the use of the individual to whom it is addressed. If you are not the 

Sorry, we cannot work with confidential information.


If you do not understand why, please also see:
https://www.youtube.com/live/fMeH7wqOwXA?si=GY7igfbda6vnjXlJ&t=835

Best regards,
Krzysztof



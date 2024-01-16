Return-Path: <linux-kernel+bounces-28258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B82C82FC37
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48181C21226
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920A73771C;
	Tue, 16 Jan 2024 20:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ts8kRwMJ"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C5C1DA54
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437677; cv=none; b=TGwjZydGioqeOkqGheuhUf0Q8kBZfECs4mnNEHmoxHXqTYWzTC/ydiSQrubDke9XfU3QQahwmDAQcs22pqjra9GSd9v5o1EvDzsaCaivCxRmA+Y1ZMec1064GyXFijJ6Sb8qnxR208zjeHgAb01hqNOR0HXcpmThDL22GSwGriA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437677; c=relaxed/simple;
	bh=XmFU90GyA+U8ut8T6e6djiZu0XPsCMUd4t+6dR5k/+M=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=ibiYLKtGplbvgSYLgW1ebo8W/0RcfQZWXB4g5OB7/Q6eE7gGHOvoaLFC3ftnnfZCPBBuhYzp3U4vd0gYVropk7ay/qC2VU82NjjPT12SwAhKRvY4EX6gsMdqGTD5zLHwnzJS5gdbBeTW2T1Xcs5tGRmYKI2a+W/LpxkvZ9MGlJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ts8kRwMJ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5592d1bc4fbso3053660a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 12:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705437674; x=1706042474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8AV6p1YAjXVsg43aeNRRf1sOrvdKTjzDvVP/4t3Uwmw=;
        b=ts8kRwMJ7xz5DRtwYSMjVvt/3uO8Mk5kzCamTuEYmMdzeGT7EBe2NyE0Otb3cblzYt
         2Fi33guScgSGkYfWADGPm4Nbbs5LaBfqAHCnz8+Sv65iOvGeZBsx+LQYtVLWmWAUstZP
         wJdftkwqWHauS0oqOEKmsrsvTJcerVuhN9CEsC/XaJgZDjLgPpsJMwc10n7SD8d5aXfg
         AeSXgE6BxbgXkGKBHOpT6lH1DqwdY0r3EGtR7ysogsJMsXiSMCRvp4zYR7uMYvORS/qQ
         Rcotp1HjIwuBCRIeyT7m1BRrLcCxA+cFVgoYqrIDVC1KkpHUp3fL3FpXR55AknIVe6cA
         dl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705437674; x=1706042474;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8AV6p1YAjXVsg43aeNRRf1sOrvdKTjzDvVP/4t3Uwmw=;
        b=OipJxy7ahv+D/0sLgwVv+R6xHdF/uHxcvV7RlNNHuwPkxOSlQ88h5H4pbk5BrNRAiI
         tRJopArbmt/vmoFBt4OK2+ptI9Uzob1Iuak6+PXffaZz1XsOmrkB+Yiq/Y2ItYB8TLUJ
         Xu4UimugJmcGm1JMgRdwpLHJrh14Qta8aaA/NwOd68AUzDdDK17PDIqnm5iu9d38mR0E
         OkLyAdt5BZopGAYC6X+IUvDJqFiRXpvKEMcpEfCNIyz0ogCZ5shRfBGm956+VMLRoF+D
         2xLx+t1O6Ux3CLBkdoIiOtQf71Viy26Zq9S/XCM3kB2NusOR6prz3uCPuHPtttPp3wby
         JYGA==
X-Gm-Message-State: AOJu0YyzH0wGb9vsr+yuT/B/A3d2svPEoffkLrP0niDof/KwlO67iRMK
	/zNM8cyDfiHVcj9kp+nQuhza3aP/FKuxug==
X-Google-Smtp-Source: AGHT+IGl3VYM7br1rpA/tGxzWdbWhI2812qneSnFAhbs4UAwfYByZSo0BgNBilsbNauRHKNOQNbOTA==
X-Received: by 2002:a17:906:c2d9:b0:a2b:969a:bb3b with SMTP id ch25-20020a170906c2d900b00a2b969abb3bmr3960198ejb.122.1705437673899;
        Tue, 16 Jan 2024 12:41:13 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id ot8-20020a170906ccc800b00a28a8a7de10sm6904562ejb.159.2024.01.16.12.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 12:41:13 -0800 (PST)
Message-ID: <05691d0e-2d23-4d0d-a773-13ec6305a5a0@linaro.org>
Date: Tue, 16 Jan 2024 21:41:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 7/8] arm64: dts: nuvoton: npcm8xx: replace reg with
 syscon property
Content-Language: en-US
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com, joel@jms.id.au,
 venture@google.com, yuenn@google.com, benjaminfair@google.com,
 openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240108135421.684263-1-tmaimon77@gmail.com>
 <20240108135421.684263-8-tmaimon77@gmail.com>
 <23fdd643-ae30-474b-93b0-fb98edeb0071@linaro.org>
 <CAP6Zq1i88mx8hfE-Ui_yMDOUxB5YofyyRSygBY8zuPq71ptHqg@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAP6Zq1i88mx8hfE-Ui_yMDOUxB5YofyyRSygBY8zuPq71ptHqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/01/2024 20:39, Tomer Maimon wrote:
> Hi Krzysztof,
> 
> Thanks for your comment.
> 
> On Wed, 10 Jan 2024 at 22:59, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 08/01/2024 14:54, Tomer Maimon wrote:
>>> Replace reg with syscon property since the clock registers handle the
>>> reset registers as well.
>>>
>>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>>> ---
>>
>> NAK for the same reasons as previous patch.
> Will explain more in the commit message

No, this wasn't even tested. Build your code with W=1 and fix all
warnings first. But anyway this is not the way to go.

Best regards,
Krzysztof



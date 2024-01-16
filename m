Return-Path: <linux-kernel+bounces-28278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA8282FC76
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0BD1C26606
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08A0286B8;
	Tue, 16 Jan 2024 21:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z6VEVw3V"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC621F61A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 21:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705438907; cv=none; b=K9al4Vilr/sIOipDIJAs2v2LP2NFgScfO30861f4AB9KwMEzTemWMUmxX9PIl6ZVmb5nTE6BDmaNFO17u3oHWO1tK+zrGJNWQrMlMK9WrHH5L3HxMTlKGy8oEoMwL5ziU1W8WJpwjLot8OoNc04jQ0WC7WCvcL1MBOLRs/GVcQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705438907; c=relaxed/simple;
	bh=PNx+QXbDWvXWtLz50dOxThikUZ335c3MC79aRH2BLb4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 From:To:Cc:References:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=bAAB8hSVVeQAf8aqkAEobGSwFfRjyGSUKtx0c6aYpg9bFLzSqVodJ7kH0dtb12MNf7eRg2CNO40Ox3WvuxqqZ3fwRpU5BOpBOwwLcOu06B2au/vKKUdSlG1fAB7IYLkKYQHXlGVR1v/1OSTBpL7W/fumXKEbbfNNRDotEjYQF7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z6VEVw3V; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso11585558a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705438904; x=1706043704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BI0JqMsCv4VcqbNYt8+RzCV7QHNt5sRA33XbIYq+33c=;
        b=z6VEVw3VuovlpONAmlBRweSPiDtdz99uNAxynB0n3+7bUawfgp7+IzdKJ2Og3WtM2x
         OdgjW0YOr61JCMiZMA9mcukZdA+Kp37yWfC6DqaTESUV8lygEXDCrLuUZ86gexgvVrr3
         ILlYjG1mQP18QFz4TGbMNiJSdCTWZrKPCvLwEL5DXPS0catzZX0q33BvOfp6ZbX39Z3n
         Oka6ABfHS2FGdeRuYzuas8XxRuadzxEa7/TYahoDclAEISBKMuHsHnGUn3W4h9cgY1Wy
         MOgnaMR/zmGzae/clI1bMr/+Gq14TL7n6fB5xY5WgCBwXJ95jU43NVu9z/E42mVFmO+4
         CdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705438904; x=1706043704;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BI0JqMsCv4VcqbNYt8+RzCV7QHNt5sRA33XbIYq+33c=;
        b=ITL8gUA8FftwbxEpYvdMnpDBCovjkeNBf6dPlwR4vj+kmP6uE7hTTGKj0hnXGWFywY
         GH6RhXGDcH4GPM+q8DLig4+Y7a+iC6WTmMyEno5kVBV2yWfcovHYxjXTXNLOj8nZMFjA
         pOEigo9QMF4N0WC1UbAWPC5tHj4fUvKdKUteu2Kcsjd/PEpumcS37PVRF3aG7JBXHXBp
         THD8P7+w39ArPPmPbfUHhTVjDP194wOubvhIxLX2qoIT8wLjtt4C/Y7PrSP7Q+5qOQ5d
         dVWtYxRdEwzn5mokFuz/KZ3JXpP9iLhYi0q2u8zJgvGhOuqFx1dhY93k0Kg+fgOYMjFf
         a46A==
X-Gm-Message-State: AOJu0YzvBTX57eg6JG+ioO3nX+nLXK+CgjMKmjLL6ZDONkEH0921Y4fT
	6/52hbtDMX09z/txFg03WmlyJOMbsMbNzQ==
X-Google-Smtp-Source: AGHT+IHSKQjn3iRQ2ltMWmBiWTkmis4S2DCRaFDXIur/tWNxSSuIXUs/UXtiIZnENnqyI9dAW4sdDA==
X-Received: by 2002:a17:907:a80a:b0:a2d:2328:6d52 with SMTP id vo10-20020a170907a80a00b00a2d23286d52mr1363322ejc.276.1705438904380;
        Tue, 16 Jan 2024 13:01:44 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id v1-20020a17090606c100b00a2a04754eb1sm6939441ejb.8.2024.01.16.13.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 13:01:43 -0800 (PST)
Message-ID: <e54e2b30-03e7-40e3-bb33-dc71de8511a4@linaro.org>
Date: Tue, 16 Jan 2024 22:01:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] dt-bindings: i3c: svc: add compatible string i3c:
 silvaco,i3c-target-v1
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Conor Dooley <conor@kernel.org>, Conor Dooley
 <conor.dooley@microchip.com>, robh@kernel.org,
 alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
 gregkh@linuxfoundation.org, imx@lists.linux.dev, jirislaby@kernel.org,
 joe@perches.com, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 miquel.raynal@bootlin.com, zbigniew.lukwinski@linux.intel.com,
 devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <1b628901-7f71-4c97-9a16-723912988417@linaro.org>
 <ZaXqCoCHPWER94Hh@lizhi-Precision-Tower-5810>
 <d45e31c4-914e-4cea-a145-9775b6f516ab@linaro.org>
 <20240116-bleach-herbicide-48d636967134@wendy>
 <3199c245-3d2d-49e8-951e-2b059de4d683@linaro.org>
 <20240116-achiness-thievish-10a12b3c08cd@wendy>
 <Zaa+cLGVVDSB5MYr@lizhi-Precision-Tower-5810>
 <20240116-retract-conclude-c47a7fc8cb21@spud>
 <ZabVSYgq1Mz3LPpC@lizhi-Precision-Tower-5810>
 <4a9ed1ca-cd13-4b61-af06-a3d7935aeeee@linaro.org>
 <ZabqxHD4wtiPn6ep@lizhi-Precision-Tower-5810>
 <c760b89c-efec-489e-8333-c60b38fb5a47@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <c760b89c-efec-489e-8333-c60b38fb5a47@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/01/2024 21:56, Krzysztof Kozlowski wrote:
> On 16/01/2024 21:44, Frank Li wrote:
>> On Tue, Jan 16, 2024 at 09:30:24PM +0100, Krzysztof Kozlowski wrote:
>>> On 16/01/2024 20:13, Frank Li wrote:
>>>> On Tue, Jan 16, 2024 at 06:23:09PM +0000, Conor Dooley wrote:
>>>>> On Tue, Jan 16, 2024 at 12:35:44PM -0500, Frank Li wrote:
>>>>>> On Tue, Jan 16, 2024 at 09:48:08AM +0000, Conor Dooley wrote:
>>>>>>> On Tue, Jan 16, 2024 at 10:33:48AM +0100, Krzysztof Kozlowski wrote:
>>>>>>>> On 16/01/2024 10:30, Conor Dooley wrote:
>>>>>>>>> On Tue, Jan 16, 2024 at 08:24:20AM +0100, Krzysztof Kozlowski wrote:
>>>>>>>>>> On 16/01/2024 03:29, Frank Li wrote:
>>>>>>>>>>>>> 	Patches were accepted after discussion, what you ponit to. So I
>>>>>>>>>>>>> think everyone agree on the name 'silvaco,i3c-master-v1'.
>>>>>>>>>>>>> 	I plan send next version to fix auto build error. Any additional
>>>>>>>>>>>>> comments about this?
>>>>>>>>>>>>
>>>>>>>>>>>> I still do not see how did you address Rob's comment and his point is
>>>>>>>>>>>> valid. You just did not reply to it.
>>>>>>>>>>>
>>>>>>>>>>> See https://lore.kernel.org/imx/ZXCiaKfMYYShoiXK@lizhi-Precision-Tower-5810/
>>>>>>>>>>
>>>>>>>>>> First of all, that's not the answer to Rob's email, but some other
>>>>>>>>>> thread which is 99% ignored by Rob (unless he has filters for
>>>>>>>>>> "@Rob"...). Therefore no, it does not count as valid answer.
>>>>>>>>>>
>>>>>>>>>> Second, explanation does not make sense. There is no argument granting
>>>>>>>>>> you exception from SoC specific compatibles.
>>>>>>>>>
>>>>>>>>> The patch could have been applied two months ago had Frank done as
>>>>>>>>> was requested (multiple times). I don't understand the resistance
>>>>>>>>> towards doing so given the process has taken way way longer as a result.
>>>>>>>>
>>>>>>>> I think that Rob's comment was just skipped and original master binding
>>>>>>>> was merged without addressing it. I don't want to repeat the same
>>>>>>>> process for the "target". Indeed I could point this earlier... if I only
>>>>>>>> knew that Rob pointed out that issue.
>>>>>>>
>>>>>>> Oh I think I got confused here. The context for this mail led me to
>>>>>>> think that this was still trying to push the i3c-master-v1 stuff through
>>>>>>> and I was commenting on my frustration with the resistance to applying
>>>>>>> the feedback received. I didn't realise that this was for another
>>>>>>> patch adding a target.
>>>>>>>
>>>>>>> I think you already said it, but NAK to adding any more compatibles here
>>>>>>> until the soc-specific compatible that was asked for for the imx93 is
>>>>>>> added.
>>>>>>
>>>>>> Is it okay for 'silvaco,i3c-target-imx93'?
>>>
>>> No, because imx93 is product of NXP, not Silvaco.
>>>
>>> You need regular SoC-block compatibles, just like we have for all other
>>> snps, dwc and cdns.
>>
>> "nxp,imx93-svc-i3c-target" ? 
> 
> Could be, now please point me to patch adding such code to DTS. I would
> like to see the real use case for it.

Probably I was not clear enough, so let's be more precise: I think you
might have troubles pointing to such code, because it just does not
exist. It is a bit contradicting to single hardware description, because
you want to describe one hardware in two different ways, with two
different compatibles.

Your commit msg is here empty - it says what  patch is does, which is
obvious. Tells nothing about the hardware being described here, which
does not help this discussion. This would need solving as well, but main
point stays - don't add new compatibles for the same hardware, at least
not without valid reason/explanation.

Best regards,
Krzysztof



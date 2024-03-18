Return-Path: <linux-kernel+bounces-105855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C4B87E58D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CC8CB20F2E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1149D2C190;
	Mon, 18 Mar 2024 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JRCWbvs1"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAFB28E11
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753587; cv=none; b=k5TnBH+RZzxZIS4nwe+hiKLxvE5mDys6ymKyXfwzD5ru3bNeuH98EkQF7PPe8ItWQ/xhKeKhptNTEQenCf5u5KpPBbE2n3unV9zQH4sLA3BUEqqHwRPM+79hDfyncCQwnznWegbsTTo4u2VUOyyJSTlIp4YGa4QbTHMj5XlGbP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753587; c=relaxed/simple;
	bh=jp7QZPp2a/Gaou65Z69AxcDk/5PHYR3FnTCZRxVmIgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uaem+lQVCOMV+ae4xDkBOtdY5GojRoJagoyEHyFoYU0nIrOg/UjJmB1Ff5WLDD1aHheTVBvHNddHP+jp8LH//C58OQRC0QZ7yNI1iPvNhWdDBs5NQ1Dv33gUyVbHTP6wx2qSfy8IKYCRi4cQRDtYJWUWMUGcX2r1B4g2RZvwvHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JRCWbvs1; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56a2bb1d84eso984139a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 02:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710753583; x=1711358383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6DmORVVqQRASoZ9rnkfY0LA6LIBlyeKMNcLspwpQKNk=;
        b=JRCWbvs12RiY0GNoEpReQSPMXMEUarw5bwO/kdzJHjrjDbryBSzwFH7GwKYx/GN0wk
         I9aFbTiSPEuqj7L79qHejvTMpK14QcGwNZZc/7hovbRmNBnyiQaLEYx04NVapnt7pou7
         +PWFJtS4CeViE01GNageelJ2Z4LOUhbTfwVt+iD5lu/Rz+D1Sgor/GJBME1en1SxUvJi
         s4Y8GXvVh5sX3RCwQzgwLmgUM9S7hiBqcbGO/kENUbIdgNuyzab+dxOINbBM1noIZl02
         O0vhGvzfzWsZ+8KEr3CmFTvTHiNXt2XTKKhlmAparXlroBqR0JsEGB7+L8pv42fhWuoJ
         +HHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710753583; x=1711358383;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6DmORVVqQRASoZ9rnkfY0LA6LIBlyeKMNcLspwpQKNk=;
        b=eI5BKPV+0GyOKnebXjycoYGjmLLvh3wvPG1/LhFs7ritd1iddt2Yf6MIeQhPsL2Od+
         TaXBK1atH6RCh0AQrBuxtIBB13n2W+8cG7IeMl2QoXYlPPrmelYzVRlFVcRGRE+SbfGL
         67qEogWhkWI0JbA6c5PUtejO+B+Yjrs72qUdM4OzYetVagm4BPQp3lHuJKIPUdAMsnpH
         ZBRiqbo8CtR2kgyN7r7SRWyVyR7lBqfRhlYFSeLLD5knk/XGYGe6wcvC56r/N9IQPBJ6
         uuuWle+YyMrG/F/+UYOoS00/dHrD/EZ3wdU99pef9WBKvrDNTHJP+Ypzd0S1NIOewjr4
         hfEA==
X-Forwarded-Encrypted: i=1; AJvYcCVVahfg0mL2YPe9qYuI0Ch1iGCvSxrGGuVTi0mT1npgWQk5HdRN+9RgMwiu4FO09pSMUaR6Wy+fr3Jz9bLiHvfrKlpYS7N76YLiOUHJ
X-Gm-Message-State: AOJu0Yx5Cf8E1hiKwKiv+odVTcfh+qiZMI3XlRHAG28swNNdLEa5ZxOv
	48EBpub5NEo9seZUK/Vp+cqO1mus2P8/tBgyqNZKoxmuIAIKl+Y/u/KtlUGXR/k=
X-Google-Smtp-Source: AGHT+IEO7HsXFmgG7cuRv+XQ37xkX8fwJoLmGPXNGPpfTG+c2mFTpqtwRjx9ZqjjwFVZwbR/mziCIg==
X-Received: by 2002:a05:6402:3814:b0:568:d21c:e0ef with SMTP id es20-20020a056402381400b00568d21ce0efmr3109311edb.6.1710753582701;
        Mon, 18 Mar 2024 02:19:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id x1-20020a056402414100b00568d2d4e4besm1390210eda.54.2024.03.18.02.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 02:19:42 -0700 (PDT)
Message-ID: <8a6e717d-a63b-4f1f-9873-efce2a868a4a@linaro.org>
Date: Mon, 18 Mar 2024 10:19:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] mips: dts: ralink: mt7621: improve DTS style
Content-Language: en-US
To: Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>
Cc: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
 <CAMhs-H9ZO-sitsrASuvsEd+ddwVyHH35gj7yAABTqFNfOCGYYw@mail.gmail.com>
 <60512ae2-dd73-4cb6-9514-145f946300fc@linaro.org>
 <5d6c36cb9dd9afda1efb69aa34058517@risingedge.co.za>
 <adefc3ff-86a5-4af7-8276-73d0e0108901@linaro.org>
 <26633d73360e43b2c548f49e544472ea@risingedge.co.za>
 <CAMhs-H_1bwfKO8yquz-3BHQ0UQYW1FFVJYHE66w8Q9m1+fCCHw@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAMhs-H_1bwfKO8yquz-3BHQ0UQYW1FFVJYHE66w8Q9m1+fCCHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/03/2024 09:48, Sergio Paracuellos wrote:
>>
>>
>>>> But if there're no objections and it lessens the burden on
>>>> maintainers upstream to have less patches to apply, then I have no
>>>> problem combining them into a single patch.
>>>>
>>>
>>> Yeah, one review response instead of 14 responses... One commit in the
>>> history instead of 14.
>>
>> I agree that 1 commit vs 14 is better.
>>
>> But for future reference: is it not enough for the Reviewed-by: trailer
>> to be sent in response to the cover letter of a patch set if a reviewer
>> has looked at the entire set?
> 
> It is enough, AFAICT. I found your patchset very easy to review so I
> am ok with the patchset as it is. However, at the end this will be
> through the mips tree, so let's do what Thomas prefers: add all
> patches as they are or squash all of them in one commit.

Yeah, like fixing language typos in comments: one typo per patch.

Best regards,
Krzysztof



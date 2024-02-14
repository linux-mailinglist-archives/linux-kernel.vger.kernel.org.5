Return-Path: <linux-kernel+bounces-65018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5254D8546C9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 753781C20E64
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8DB171A3;
	Wed, 14 Feb 2024 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oGmpWvM+"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0070B79DF
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904965; cv=none; b=culva3T6bCHnrQydC6IPHkD+qObuuAQ7VZVpfJ+W0X143LOUxQTop0I8OC6QNHdxAe9TY0c46nr0tvXTFednizJhe2d0aWXEP+Rj31+OXNKeMkjKRAZU0cDw33ZbjPGjQCfcLqYC6mcwMhwNcNE0KWOKxSrzsIXfWxtsxAtAliI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904965; c=relaxed/simple;
	bh=apRKVNhBQJHlkjixukc6o0dx+/iVFiLgbLhv6KDF56I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HT1IP8lLHXe5bf4GqaDQz7DLDZo79+8h8cxEI7qC10kHOkTw2sJnd+YlEt3CNJIwRu8tpO+9Q698zchev2qbDFmvhJeuhKvBTqrE675TJjA/qOrI3rAu4WwuptV2rtLwQk/asempmqsED+XSstpwYaKyzlE8N3/RoqDs796Z7NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oGmpWvM+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-562131bb958so1209725a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 02:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707904962; x=1708509762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3bMW9whpBA0jL3HiuL3tccPcVAuuxpNXPVuN6B+u2gg=;
        b=oGmpWvM+otbvKEcD/YtPoGxgsblMJqpo4/Vecdm9nKuNAm4W5HSbh6xUPXREYNbZt0
         RbaqUmMSAFeq3Nga3wgWJLozzmxmkRrSMdTUJP7wI5vkEy+exWUec7igLYxB9Zl/RO3b
         eOapxvhk7eXM+vgqRFp2+h+XYhFvtOp1x1L8Y4VkBYDba6a1xvtBcgDyXyEPkB6GhlnW
         iJmOTFNEtyJ8gAbjc0kVLaD2kp1dZTzaiwOB+85GTL6VmP9uVafcob81+yc+q8JI9EfQ
         M5E/km3Jo4sPS7UQJMAIDrl6qyhOvcjvxgsHfjrRBeJedCxPRhOjYV4QH7FNvL4cz72/
         X0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707904962; x=1708509762;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3bMW9whpBA0jL3HiuL3tccPcVAuuxpNXPVuN6B+u2gg=;
        b=FIhYnRQslCJD3wDpLJuzFGQ+mJea8ltAPqgbJHoajtg6xpoNz8Ma1ih0+2TjM1z3T4
         gArcyX8irXl2p96R8FVffbC2u+MS7LrFQVhjYZoreWKAhCb955trlj2rlfsxCVBc0KXK
         RZUrSLHhD2KAXj6dyAhJmA+dHFmck9g8bUZqB6XXxB3Vyk4yn3cpLt+qTtIbDrfB+Gt5
         HzLTbx4dtq8h5v9ZCk3csRpgiRiA7+ldNNeS7QkASrPwOn/GlwrLNIq4ae4R9EHxCYx9
         FDC5T518EEqO8f4eD88gcQhr97l+TiiU9To5fWWvBgK1IP4ISY2EGX/TkpRoA2xhfW1D
         FW7A==
X-Forwarded-Encrypted: i=1; AJvYcCXSS2rsZm0s63qEVQdMyEkJpPO69NpvqwPHj3qQGsKDQf8yXnPuJMkS/j3jlLiDYo4JqQL/lD7cq9KS5QRhSfr3l1lHT+YowvSPxEFe
X-Gm-Message-State: AOJu0YwhdinPBziTu8pPfzAzmoadxImj49qAiWtZtYnIRaP+IvvMTvDM
	iuTL/n2cUSBQb4MR+QiR0lir7/lJmd2dVyGCHCHf9W3cxmvVMxWYkHwEQD4Kkgg=
X-Google-Smtp-Source: AGHT+IHNVysDTvrlpcCZDo0fkXx0/f/34mP+7CCFE+pH3BouUA6vCsnowXjEfoeQZZOjgW0VU98yIg==
X-Received: by 2002:a17:906:378a:b0:a3d:1ca9:b994 with SMTP id n10-20020a170906378a00b00a3d1ca9b994mr1336086ejc.33.1707904962270;
        Wed, 14 Feb 2024 02:02:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW8vaf5LHXA17YCCPIKcCCtlN1JISNK+L+VrIGFWTWtREpE1AommHGZJDnPVDiyqv5Kb3Yot2I0tQMagrYNam/8/G1wb/LJQvRe7L+8jidwhLyIZLCQVvqF61FOsGBALdfbuybfh96uQ0O8DdqzPj++WYaJYxVcDNGiiIWzCHqzwRPG0esmoeeKjcnwxpub+78fyDCH5C1za7lKiNo/wLYhTWB7TMIS89U+ZH2yoA0naIxu2VBihinXMTW1ulQ3/vBQ9GtBRNsipahtPye1hljmvrCfPLaQRHZloR87PxaIbaqz/iw715ueVl/uyKpO/xlITCbHZ//w0q7f35j/3UPxcl+0cKzt423t0OxTNavA+Q6y7bagpiTRrII=
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id wp14-20020a170907060e00b00a3d36da3a57sm589083ejb.7.2024.02.14.02.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 02:02:41 -0800 (PST)
Message-ID: <ff61656d-e4a8-4561-a3ba-f34abd1c6ce4@linaro.org>
Date: Wed, 14 Feb 2024 11:02:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Add MP25 FMC2 support
Content-Language: en-US
To: Christophe Kerello <christophe.kerello@foss.st.com>,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, devicetree@vger.kernel.org
References: <20240212174822.77734-1-christophe.kerello@foss.st.com>
 <fbaad3c7-13b7-41a2-a8f6-7036ec1ca2fe@linaro.org>
 <9f20563b-bef1-41d0-a1ba-fefeabed2e09@foss.st.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <9f20563b-bef1-41d0-a1ba-fefeabed2e09@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2024 13:09, Christophe Kerello wrote:
> 
> 
> On 2/13/24 08:34, Krzysztof Kozlowski wrote:
>> On 12/02/2024 18:48, Christophe Kerello wrote:
>>> Add MP25 SOC support in stm32_fmc2 drivers:
>>>   - Update stm32-fmc2-ebi driver to support FMC2 revision 2 and MP25 SOC.
>>>   - Update stm32_fmc2_nand driver to support FMC2 revision 2 and MP25 SOC
>>
>> Why do you combine memory controller driver and NAND in one patchset if
>> there is no dependency? On any further submissions, please split
>> independent works.
> 
> Hi Krzysztof,
> 
> NAND driver patch 11 refers to the compatible described for the memory

Eh, it shouldn't really. This does not scale - you will keep growing
that 'if' clause? And other drivers should not include other device
compatibles.

But anyway that's not a real subsystem dependency. Just mention in patch
changelog (so ---) that compatible is documented somewhere at URL xyz.

Best regards,
Krzysztof



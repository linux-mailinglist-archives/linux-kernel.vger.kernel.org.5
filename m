Return-Path: <linux-kernel+bounces-86253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1FA86C2E4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4054E1F22FA9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A8747F58;
	Thu, 29 Feb 2024 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jgO7BqV+"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB19445BE2
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709193382; cv=none; b=L5PMitjBlst3YnX+h8ff8X+sBGB3bcSoMKShO/hhPAU4vziN9A5119vP5tuS1+M9rUwGfJ7ZD5nMit4KvAITufuW8wj4LAVVmlWngUb+ZzoJO79x3T7EMj+3wo4POzm6Yt0uC3Ee4kdq2vM3GubkL/UDvCAAmwyqvU8nEWynr5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709193382; c=relaxed/simple;
	bh=xalTvrC3436CWoDDWIMy3YccKsUzpHw+pYYrTOnwkpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdMwYHwf4VCNt8JTjYGQLeIixdXN/mp7g5gbkQCXwl3TS25FQp3Mn3uGR3i0Ozj4QbQlOZVYeM2KYEECy3VTO3MDYD6OTnlzeScyu8kaeRDoQoOTPgQ4oreO0RzqHNE6KkJj6lbH0UYg8WpyedamCBDOUAZQ0B9kvPYRSJ0ePsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jgO7BqV+; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56698eb5e1dso552768a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 23:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709193379; x=1709798179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cu6mjnfD5m4+aU28S18XmI+K3qmvRUR5PoxLhp2cnhk=;
        b=jgO7BqV+8dQvG+kGIEVgbrsJMVioZbi+D34mo3TXztclfWS7KCf9ZkHMk2s+ehbKFs
         Hi7CI82CrBzNhTsIGavQ40t8M2S6gTvUiaCVTKDChtNJ60ZN1DCtcCL2yTX2MzGtQS5l
         VkQNiuNiHEbofIubsT2wQeWD9beJEh18YK11Mi+Ms78pDpfmF/PQdutLa8zoVXN5emkD
         Yl/WKj9fzEl4lqwefeZamGaT9o4irEMg4Sxr2KbQHsf0ZDNO2VEuuSwYWeu1Hv55o7/o
         Lu2NAy4YCWw2gwDkcq7pRvWHG/vtiRL9peqo3jFUQjnDoCnrHXLSpOuBKtTaJbZ5SSRY
         H8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709193379; x=1709798179;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cu6mjnfD5m4+aU28S18XmI+K3qmvRUR5PoxLhp2cnhk=;
        b=WP9yWWRL5Ah8JjQgDjqNlVS3ze5ZuC3OwyIW0n6mbHwzbLVCtGgKkJ6EqRUsyCtiOh
         nub4Uz7ofPfknneHNFTQabrp8qmRWMDwbKfNXU6N1R6+/KL/2yZfO/FjOxEKJ/MiYHfL
         qn07pbAq3CYhAPDNUD9vB7L207LahhTUalKWdpaY7fyb0ngHM+1tyWNIvPfMO12Cu2iW
         vumM+XBdzz2UbRCD//qy1ru3HGAW6WBVWYTOboOseKmWSXPZfRT0DyPPhdqMEvrRdgZ7
         yY7Ysxdyt9pQcgXnQmbZCdK0fi35d/RXyaOFZSUNt+fmuvajY9itYylhsSqTElB4ygUc
         v1ow==
X-Forwarded-Encrypted: i=1; AJvYcCUWw7Z5nTDCNHov9R4DVHQVU36Qr8tEBWqnEryRrkPE8qPsUGK+ZVTLIiLqLy4o9TTuNCVluWD1tKE/nmYjVNLyWgtgGaDPf/qINxBq
X-Gm-Message-State: AOJu0YwhvVO3nuym1I3boOibrByrmQfQQIreaV2PM+T2wrxIfAFQPbuI
	nMkkCnZw6NVgjlvTCaNkVDlvP0oouLiB1HpwH+MXi6Ps+RF0wFsQ5/4OHf/647A=
X-Google-Smtp-Source: AGHT+IFD2F0dsAJTriWGloHGAECOnwct5/b+t1wR92stMVygQYZ4dVGFAsGp8PfFSSPlMMNUCWMbjg==
X-Received: by 2002:a17:906:f902:b0:a3f:effa:2134 with SMTP id lc2-20020a170906f90200b00a3feffa2134mr744061ejb.18.1709193379062;
        Wed, 28 Feb 2024 23:56:19 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id ps2-20020a170906bf4200b00a43a79b10absm407995ejb.140.2024.02.28.23.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 23:56:18 -0800 (PST)
Message-ID: <df9c05aa-6744-4954-9918-8b2abf59bbc0@linaro.org>
Date: Thu, 29 Feb 2024 08:56:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board
Content-Language: en-US
To: =?UTF-8?B?S2VsbHkgSHVuZyjmtKrlmInojokp?= <Kelly_Hung@asus.com>,
 Kelly Hung <ppighouse@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc: "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
 <joel@jms.id.au>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
 =?UTF-8?B?QWxsZW5ZWSBIc3Uo6Kix5bm85bKzKQ==?= <AllenYY_Hsu@asus.com>
References: <20240227092922.1734998-1-Kelly_Hung@asus.com>
 <60d048df-9a54-4239-8a8b-a8eb9a59dde9@linaro.org>
 <TYZPR04MB65964904A9624AF3BE05198D9D5F2@TYZPR04MB6596.apcprd04.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <TYZPR04MB65964904A9624AF3BE05198D9D5F2@TYZPR04MB6596.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/02/2024 08:45, Kelly Hung(洪嘉莉) wrote:
> Hi, Krzysztof,
> 
> I correct my change log
>> Document the new compatibles used on ASUS X4TF.
>>
>> Changelog
>> Changes in v3
>> --- The new compatible is a BMC for a ASUS X4TF server which use a ast2600-a3 chip, so correct string to asus,x4tf-bmc
> 
> Do I need to resend v3 patch again with the correct change log?

You need to send v4 with correct changelog and tags.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.

Best regards,
Krzysztof


